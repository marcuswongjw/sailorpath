-- Migration 174: Import Philippine National Sailing Championship 2026
--
-- Imports the official championship results for:
-- Event: Philippine National Sailing Championship 2026
-- Venue: Manila Bay, Philippines
-- Dates: 15 – 18 January 2026
-- Authority: Philippine Sailing Association (PSA)
--
-- Fleets imported (43 entries):
-- 1. Optimist Class A: 5 entries, 4 races
-- 2. Optimist Class B: 15 entries, 4 races
-- 3. ILCA 4: 8 entries, 4 races
-- 4. ILCA 6: 5 entries, 4 races
-- 5. ILCA 7: 5 entries, 4 races
-- 6. Int. 420: 5 boats (10 sailors), 8 races, 1 discard
--
-- Source: https://www.racingrulesofsailing.org/documents/13459/event (Document 172875: Results 2026 Philippine National Sailing Championship.xlsx.pdf)
--
-- All operations execute in a single atomic transaction.

BEGIN;

-- 1. Insert New Verified Sailor Profiles
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4080ef6f-12a0-56de-862a-6407b7d0e4b0', 'Kevin Millanas', 'kevin-millanas-1e6ca1', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '611448bb-466a-5beb-b19e-a7a0c2348414', 'Amanda Amadeo', 'amanda-amadeo-a66bab', 'TBD', 'Philippine Sailing Association', 'PHI', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '74ab24c2-52b2-5009-852b-4a07e28ab06e', 'Fritz Gerald Castillo', 'fritz-gerald-castillo-60871f', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '89638172-e1c7-50b4-b8f7-eae1781e0044', 'Genmark Daenniel Maranan', 'genmark-daenniel-maranan-716114', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e08b2f5b-a819-5368-a628-1096d2723279', 'Edmon Asejo Jr', 'edmon-asejo-jr-c46dd5', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c', 'Fred Julian Marienau', 'fred-julian-marienau-3c1eb2', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '088cfe2e-0eb6-54f0-9e2d-ddaadf30da8c', 'Brix Gabriel Jumarang', 'brix-gabriel-jumarang-5cc099', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c8b6f944-2891-5f53-b78e-4bf822624355', 'Baby Beverly Brylle Magramo', 'baby-beverly-brylle-magramo-96bc4c', 'TBD', 'Philippine Sailing Association', 'PHI', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b0276abf-c8a8-512a-ad5d-266460aca070', 'Alvin Pano', 'alvin-pano-125a33', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a4b8b252-b7df-5b95-8270-bd5ab989dd60', 'Lexie Laurice Lucero', 'lexie-laurice-lucero-dc149a', 'TBD', 'Philippine Sailing Association', 'PHI', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '03207997-4a62-508b-abb9-15b43480a36b', 'Ivan Matthew Eseque', 'ivan-matthew-eseque-acea15', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd48c024a-3059-5f68-9a6a-7f678f9b2fb2', 'Kesha Rose Hara', 'kesha-rose-hara-768216', 'TBD', 'Philippine Sailing Association', 'PHI', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2267d2ee-eef4-54c6-be60-74b9462632d0', 'John Cyrus Epa', 'john-cyrus-epa-c1491b', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fba11970-faae-511a-902e-41e44269846d', 'Christian Asejo', 'christian-asejo-647f0e', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '41e75156-e8cb-544a-9f0f-e7d28bfa31b6', 'Angelo Omales', 'angelo-omales-968e0b', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ee47fb94-4096-5154-9620-8c29f4f0db0d', 'Daniel Alonso Subia', 'daniel-alonso-subia-a255be', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1798d7d8-3214-57d5-8a53-029dc369050f', 'Zac Allison Belgica', 'zac-allison-belgica-a1bc97', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '93d72156-c62a-5bc7-add0-a1b27eabf4bb', 'Rey Matthew Tundayag', 'rey-matthew-tundayag-370cb7', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '06f7dd80-c725-5e9f-bbea-e69503a06eac', 'Prince July Montecer', 'prince-july-montecer-7483bf', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2f41e07e-a6fb-572a-98f5-a15f5d593a2b', 'John Rovhan Muyot', 'john-rovhan-muyot-daf04e', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2590130d-2e1e-5116-b5e6-4de3ac752482', 'Rose Ann Marienau', 'rose-ann-marienau-78255f', 'TBD', 'Philippine Sailing Association', 'PHI', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c198b673-3ee0-568e-af44-6f0dee646380', 'Zyke Castillo', 'zyke-castillo-4230d9', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a6963324-b0a4-56dc-94f5-f78816b28b6b', 'Mark Amadeo', 'mark-amadeo-1c3936', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3d9efcfe-3ac7-5368-8783-93f288ab531b', 'Josa Gonzales', 'josa-gonzales-3a70b1', 'TBD', 'Philippine Sailing Association', 'PHI', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f6b26ef3-658c-54c1-97f6-77b99166f040', 'Roahnne Roy Santos', 'roahnne-roy-santos-82bc97', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3973833a-410d-5cfa-9203-21e2c645d6c3', 'Teogenes Vilando', 'teogenes-vilando-67d5ee', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '71b50eef-af48-568a-bb4a-82c2b52c50c2', 'Ronello Castillo', 'ronello-castillo-e0ae64', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '28d41ecd-3f04-5c5f-81e5-15b3567e68f3', 'Doglas Amadeo', 'doglas-amadeo-bf129b', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4b58297f-8e99-5710-af4c-28a1c12f4564', 'Rhyannedra Laud', 'rhyannedra-laud-99ff11', 'TBD', 'Philippine Sailing Association', 'PHI', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '14fe7ad8-c782-5e65-8d9e-7cb700abd778', 'Czyrille Bonidict G Icamen', 'czyrille-bonidict-g-icamen-1cd8b2', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0cc2b490-0422-5b10-a4b8-14435ff94dbd', 'Samuel Tolentino', 'samuel-tolentino-dd7774', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '53cbc7ca-b875-575e-88bd-28ba72fd1543', 'Nadine Boyano', 'nadine-boyano-3420fc', 'TBD', 'Philippine Sailing Association', 'PHI', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c1f870bf-053c-503c-8c08-b6227ca316fd', 'Paolo Alocilja', 'paolo-alocilja-3788b2', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '686782e6-68ea-53b3-8ded-61e5b8d789dd', 'Frinz Jonas Liam B Mejarito', 'frinz-jonas-liam-b-mejarito-bcf868', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0d1b97b3-525e-5649-9063-058003417e7a', 'Miguel Madlos', 'miguel-madlos-e0e6fa', 'TBD', 'Philippine Sailing Association', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);

-- 2. Create Parent Regatta Event
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer,
    classes, nor_url, created_at, updated_at
) VALUES (
    'ec0a10ee-90b6-54b0-ba10-0a08894da825',
    'Philippine National Sailing Championship 2026',
    'philippine-national-sailing-championship-2026',
    '2026-01-15',
    '2026-01-18',
    'Manila Bay, Philippines',
    'Philippine Sailing Association (PSA)',
    '["Optimist", "ILCA 4", "ILCA 6", "ILCA 7", "420"]'::jsonb,
    'https://www.racingrulesofsailing.org/documents/13459/event',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    updated_at = clock_timestamp();

-- Regatta Sheet: Philippine National Sailing Championship 2026 (Optimist Class A)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'a06dd350-c44e-5f2e-8bc7-8f79fd7fe841',
    'ec0a10ee-90b6-54b0-ba10-0a08894da825',
    'Philippine National Sailing Championship 2026 (Optimist Class A)',
    'philippine-national-championship-2026-optimist-a',
    '2026-01-18',
    '2026-01-18',
    5,
    'Class A',
    4,
    'PHI',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Manila Bay, Philippines',
    'Philippine Sailing Association (PSA)',
    'published',
    'https://www.racingrulesofsailing.org/documents/13459/event',
    'Philippine Sailing Association Official Document 172875',
    'Philippine National Sailing Championship 2026 final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bc44cfec-8179-5f76-b441-4f0060a835b1', '4080ef6f-12a0-56de-862a-6407b7d0e4b0', 'a06dd350-c44e-5f2e-8bc7-8f79fd7fe841', 'Kevin Millanas', 'individual', 1,
    7.0, 7.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Kevin Millanas. Division: Class A.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '03e91093-a5d4-5773-a0d8-b5d3bb4d63d4', 'bc44cfec-8179-5f76-b441-4f0060a835b1', '4080ef6f-12a0-56de-862a-6407b7d0e4b0', 'Kevin Millanas', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc44cfec-8179-5f76-b441-4f0060a835b1', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc44cfec-8179-5f76-b441-4f0060a835b1', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc44cfec-8179-5f76-b441-4f0060a835b1', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc44cfec-8179-5f76-b441-4f0060a835b1', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b155588f-87bb-58e0-8a9a-ef1954087585', '243ed8f1-783f-4c3c-b69c-5a39442342ab', 'a06dd350-c44e-5f2e-8bc7-8f79fd7fe841', 'Carlstein Jade Dulay', 'individual', 2,
    8.0, 8.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Carlstein Jade Dulay. Division: Class A.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b3118b27-6fa8-564f-93ca-42333b24fb97', 'b155588f-87bb-58e0-8a9a-ef1954087585', '243ed8f1-783f-4c3c-b69c-5a39442342ab', 'Carlstein Jade Dulay', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b155588f-87bb-58e0-8a9a-ef1954087585', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b155588f-87bb-58e0-8a9a-ef1954087585', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b155588f-87bb-58e0-8a9a-ef1954087585', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b155588f-87bb-58e0-8a9a-ef1954087585', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '45cdd8ac-e661-5198-a448-8ca49e3659af', '611448bb-466a-5beb-b19e-a7a0c2348414', 'a06dd350-c44e-5f2e-8bc7-8f79fd7fe841', 'Amanda Amadeo', 'individual', 3,
    12.0, 12.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Amanda Amadeo. Division: Class A.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f42a9581-244f-5a25-8790-00b0519a47f1', '45cdd8ac-e661-5198-a448-8ca49e3659af', '611448bb-466a-5beb-b19e-a7a0c2348414', 'Amanda Amadeo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45cdd8ac-e661-5198-a448-8ca49e3659af', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45cdd8ac-e661-5198-a448-8ca49e3659af', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45cdd8ac-e661-5198-a448-8ca49e3659af', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45cdd8ac-e661-5198-a448-8ca49e3659af', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6a92207d-aefb-59af-a5c9-608b4f8d3dd1', '74ab24c2-52b2-5009-852b-4a07e28ab06e', 'a06dd350-c44e-5f2e-8bc7-8f79fd7fe841', 'Fritz Gerald Castillo', 'individual', 4,
    14.0, 14.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Fritz Gerald Castillo. Division: Class A.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '30d43447-5819-5688-a169-77e171166a35', '6a92207d-aefb-59af-a5c9-608b4f8d3dd1', '74ab24c2-52b2-5009-852b-4a07e28ab06e', 'Fritz Gerald Castillo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6a92207d-aefb-59af-a5c9-608b4f8d3dd1', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6a92207d-aefb-59af-a5c9-608b4f8d3dd1', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6a92207d-aefb-59af-a5c9-608b4f8d3dd1', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6a92207d-aefb-59af-a5c9-608b4f8d3dd1', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6e4a1827-4d17-56b7-9737-58d19f8352ce', '89638172-e1c7-50b4-b8f7-eae1781e0044', 'a06dd350-c44e-5f2e-8bc7-8f79fd7fe841', 'Genmark Daenniel Maranan', 'individual', 5,
    19.0, 19.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Genmark Daenniel Maranan. Division: Class A.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '17ce55a6-29fb-5c61-adf1-4d7b9985001c', '6e4a1827-4d17-56b7-9737-58d19f8352ce', '89638172-e1c7-50b4-b8f7-eae1781e0044', 'Genmark Daenniel Maranan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e4a1827-4d17-56b7-9737-58d19f8352ce', 1, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e4a1827-4d17-56b7-9737-58d19f8352ce', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e4a1827-4d17-56b7-9737-58d19f8352ce', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e4a1827-4d17-56b7-9737-58d19f8352ce', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: Philippine National Sailing Championship 2026 (Optimist Class B)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '3612c0c8-cc6e-538f-a026-a02d1e3864da',
    'ec0a10ee-90b6-54b0-ba10-0a08894da825',
    'Philippine National Sailing Championship 2026 (Optimist Class B)',
    'philippine-national-championship-2026-optimist-b',
    '2026-01-18',
    '2026-01-18',
    15,
    'Class B',
    4,
    'PHI',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Manila Bay, Philippines',
    'Philippine Sailing Association (PSA)',
    'published',
    'https://www.racingrulesofsailing.org/documents/13459/event',
    'Philippine Sailing Association Official Document 172875',
    'Philippine National Sailing Championship 2026 final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '561b13bf-6efd-5d05-9bf7-8f78fcbe9731', 'ef927ede-4bbb-4fa3-afc4-1e3ee42e3520', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Xenakie Dacer', 'individual', 1,
    4.0, 4.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Xenakie Dacer. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0ec1fdb5-bd6b-5b50-a721-3eff40ab82b8', '561b13bf-6efd-5d05-9bf7-8f78fcbe9731', 'ef927ede-4bbb-4fa3-afc4-1e3ee42e3520', 'Xenakie Dacer', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '561b13bf-6efd-5d05-9bf7-8f78fcbe9731', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '561b13bf-6efd-5d05-9bf7-8f78fcbe9731', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '561b13bf-6efd-5d05-9bf7-8f78fcbe9731', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '561b13bf-6efd-5d05-9bf7-8f78fcbe9731', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '88cae409-79be-5078-b3d1-84a33cfd422c', 'e08b2f5b-a819-5368-a628-1096d2723279', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Edmon Asejo Jr', 'individual', 2,
    12.0, 12.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Edmon Asejo Jr. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '874fdc1f-64fb-5a41-9f05-1a6b7e90bd2a', '88cae409-79be-5078-b3d1-84a33cfd422c', 'e08b2f5b-a819-5368-a628-1096d2723279', 'Edmon Asejo Jr', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '88cae409-79be-5078-b3d1-84a33cfd422c', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '88cae409-79be-5078-b3d1-84a33cfd422c', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '88cae409-79be-5078-b3d1-84a33cfd422c', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '88cae409-79be-5078-b3d1-84a33cfd422c', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '630fadcc-b8a2-5796-934b-460d095cb654', 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Fred Julian Marienau', 'individual', 3,
    13.0, 13.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Fred Julian Marienau. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f1a04652-163d-5f6b-bbf5-e6cd35ec4bbc', '630fadcc-b8a2-5796-934b-460d095cb654', 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c', 'Fred Julian Marienau', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '630fadcc-b8a2-5796-934b-460d095cb654', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '630fadcc-b8a2-5796-934b-460d095cb654', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '630fadcc-b8a2-5796-934b-460d095cb654', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '630fadcc-b8a2-5796-934b-460d095cb654', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5dcbac3f-d131-5ea3-9c64-0e79d641205f', '088cfe2e-0eb6-54f0-9e2d-ddaadf30da8c', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Brix Gabriel Jumarang', 'individual', 4,
    14.0, 14.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Brix Gabriel Jumarang. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ac1f34b8-da9e-55b1-951b-2877e58d5c17', '5dcbac3f-d131-5ea3-9c64-0e79d641205f', '088cfe2e-0eb6-54f0-9e2d-ddaadf30da8c', 'Brix Gabriel Jumarang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5dcbac3f-d131-5ea3-9c64-0e79d641205f', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5dcbac3f-d131-5ea3-9c64-0e79d641205f', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5dcbac3f-d131-5ea3-9c64-0e79d641205f', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5dcbac3f-d131-5ea3-9c64-0e79d641205f', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4e3bf1ce-eac5-5f2d-b95e-9f207fa8f06d', 'c8b6f944-2891-5f53-b78e-4bf822624355', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Baby Beverly Brylle Magramo', 'individual', 5,
    19.0, 19.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Baby Beverly Brylle Magramo. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e8d405cc-2848-56a5-9c53-d51cf9dffaad', '4e3bf1ce-eac5-5f2d-b95e-9f207fa8f06d', 'c8b6f944-2891-5f53-b78e-4bf822624355', 'Baby Beverly Brylle Magramo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4e3bf1ce-eac5-5f2d-b95e-9f207fa8f06d', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4e3bf1ce-eac5-5f2d-b95e-9f207fa8f06d', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4e3bf1ce-eac5-5f2d-b95e-9f207fa8f06d', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4e3bf1ce-eac5-5f2d-b95e-9f207fa8f06d', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ca5eaaad-4235-56a5-8de6-8fa78c412a30', 'b0276abf-c8a8-512a-ad5d-266460aca070', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Alvin Pano', 'individual', 6,
    29.0, 29.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Alvin Pano. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '18e32515-db0f-5dad-9b72-3db7e0efd138', 'ca5eaaad-4235-56a5-8de6-8fa78c412a30', 'b0276abf-c8a8-512a-ad5d-266460aca070', 'Alvin Pano', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5eaaad-4235-56a5-8de6-8fa78c412a30', 1, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5eaaad-4235-56a5-8de6-8fa78c412a30', 2, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5eaaad-4235-56a5-8de6-8fa78c412a30', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5eaaad-4235-56a5-8de6-8fa78c412a30', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0a775c0e-8598-5e15-8f71-cd9563065351', 'a4b8b252-b7df-5b95-8270-bd5ab989dd60', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Lexie Laurice Lucero', 'individual', 7,
    30.0, 30.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Lexie Laurice Lucero. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8d7a3af5-ec42-5f94-a646-8c1fe988aff9', '0a775c0e-8598-5e15-8f71-cd9563065351', 'a4b8b252-b7df-5b95-8270-bd5ab989dd60', 'Lexie Laurice Lucero', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a775c0e-8598-5e15-8f71-cd9563065351', 1, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a775c0e-8598-5e15-8f71-cd9563065351', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a775c0e-8598-5e15-8f71-cd9563065351', 3, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a775c0e-8598-5e15-8f71-cd9563065351', 4, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '218c66b6-d918-545e-bf64-47f1ccc73d9e', '03207997-4a62-508b-abb9-15b43480a36b', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Ivan Matthew Eseque', 'individual', 8,
    32.0, 32.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Ivan Matthew Eseque. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '681a7ab8-3c18-5266-8339-b82be89a7b15', '218c66b6-d918-545e-bf64-47f1ccc73d9e', '03207997-4a62-508b-abb9-15b43480a36b', 'Ivan Matthew Eseque', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '218c66b6-d918-545e-bf64-47f1ccc73d9e', 1, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '218c66b6-d918-545e-bf64-47f1ccc73d9e', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '218c66b6-d918-545e-bf64-47f1ccc73d9e', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '218c66b6-d918-545e-bf64-47f1ccc73d9e', 4, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8e41938e-d230-5b67-81ad-89c7f358a3cc', 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Kesha Rose Hara', 'individual', 9,
    33.0, 33.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Kesha Rose Hara. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f1f5ef40-1efd-59b6-97b9-00e31fe48ec7', '8e41938e-d230-5b67-81ad-89c7f358a3cc', 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2', 'Kesha Rose Hara', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8e41938e-d230-5b67-81ad-89c7f358a3cc', 1, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8e41938e-d230-5b67-81ad-89c7f358a3cc', 2, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8e41938e-d230-5b67-81ad-89c7f358a3cc', 3, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8e41938e-d230-5b67-81ad-89c7f358a3cc', 4, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4975966d-71a2-5554-91f8-c8894d9f5007', '2267d2ee-eef4-54c6-be60-74b9462632d0', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'John Cyrus Epa', 'individual', 10,
    41.0, 41.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: John Cyrus Epa. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '38948a87-5251-5b1a-bbfa-5f37bfe8d2e1', '4975966d-71a2-5554-91f8-c8894d9f5007', '2267d2ee-eef4-54c6-be60-74b9462632d0', 'John Cyrus Epa', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4975966d-71a2-5554-91f8-c8894d9f5007', 1, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4975966d-71a2-5554-91f8-c8894d9f5007', 2, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4975966d-71a2-5554-91f8-c8894d9f5007', 3, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4975966d-71a2-5554-91f8-c8894d9f5007', 4, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'af045836-ff25-5be3-a878-d8bd507f3c80', 'fba11970-faae-511a-902e-41e44269846d', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Christian Asejo', 'individual', 11,
    42.0, 42.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Christian Asejo. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fa93bc2e-1aed-54c6-8a59-6b38c3d008b2', 'af045836-ff25-5be3-a878-d8bd507f3c80', 'fba11970-faae-511a-902e-41e44269846d', 'Christian Asejo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'af045836-ff25-5be3-a878-d8bd507f3c80', 1, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'af045836-ff25-5be3-a878-d8bd507f3c80', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'af045836-ff25-5be3-a878-d8bd507f3c80', 3, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'af045836-ff25-5be3-a878-d8bd507f3c80', 4, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f850ad26-4a62-534d-86a6-e73fe8cc7a5f', '41e75156-e8cb-544a-9f0f-e7d28bfa31b6', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Angelo Omales', 'individual', 12,
    44.0, 44.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Angelo Omales. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9b1ca8ba-7f1d-57f0-9266-a91425ebc4b9', 'f850ad26-4a62-534d-86a6-e73fe8cc7a5f', '41e75156-e8cb-544a-9f0f-e7d28bfa31b6', 'Angelo Omales', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f850ad26-4a62-534d-86a6-e73fe8cc7a5f', 1, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f850ad26-4a62-534d-86a6-e73fe8cc7a5f', 2, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f850ad26-4a62-534d-86a6-e73fe8cc7a5f', 3, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f850ad26-4a62-534d-86a6-e73fe8cc7a5f', 4, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '46c6e816-da77-5df0-aeef-f60620b97476', 'ee47fb94-4096-5154-9620-8c29f4f0db0d', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Daniel Alonso Subia', 'individual', 13,
    53.0, 53.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Daniel Alonso Subia. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3116c6f3-c2ea-5539-ab06-df20e063ad65', '46c6e816-da77-5df0-aeef-f60620b97476', 'ee47fb94-4096-5154-9620-8c29f4f0db0d', 'Daniel Alonso Subia', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46c6e816-da77-5df0-aeef-f60620b97476', 1, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46c6e816-da77-5df0-aeef-f60620b97476', 2, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46c6e816-da77-5df0-aeef-f60620b97476', 3, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46c6e816-da77-5df0-aeef-f60620b97476', 4, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ce1cf1c0-4a87-5889-a6b1-793928984453', '1798d7d8-3214-57d5-8a53-029dc369050f', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Zac Allison Belgica', 'individual', 14,
    54.0, 54.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Zac Allison Belgica. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '684af3fd-0288-56d1-8a72-be1942e67440', 'ce1cf1c0-4a87-5889-a6b1-793928984453', '1798d7d8-3214-57d5-8a53-029dc369050f', 'Zac Allison Belgica', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce1cf1c0-4a87-5889-a6b1-793928984453', 1, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce1cf1c0-4a87-5889-a6b1-793928984453', 2, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce1cf1c0-4a87-5889-a6b1-793928984453', 3, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce1cf1c0-4a87-5889-a6b1-793928984453', 4, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8834cc2e-d42d-5a83-94fc-f8784a77cfe7', '93d72156-c62a-5bc7-add0-a1b27eabf4bb', '3612c0c8-cc6e-538f-a026-a02d1e3864da', 'Rey Matthew Tundayag', 'individual', 15,
    64.0, 64.0, true, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Rey Matthew Tundayag. Division: Class B.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0b0026a0-a637-5340-8e50-4ef7a3470187', '8834cc2e-d42d-5a83-94fc-f8784a77cfe7', '93d72156-c62a-5bc7-add0-a1b27eabf4bb', 'Rey Matthew Tundayag', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8834cc2e-d42d-5a83-94fc-f8784a77cfe7', 1, 16.0, 'DNC', false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8834cc2e-d42d-5a83-94fc-f8784a77cfe7', 2, 16.0, 'DNC', false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8834cc2e-d42d-5a83-94fc-f8784a77cfe7', 3, 16.0, 'DNC', false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8834cc2e-d42d-5a83-94fc-f8784a77cfe7', 4, 16.0, 'DNC', false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: Philippine National Sailing Championship 2026 (ILCA 4)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '6cdcec53-e3ca-51c1-9ab1-ed4dd4886009',
    'ec0a10ee-90b6-54b0-ba10-0a08894da825',
    'Philippine National Sailing Championship 2026 (ILCA 4)',
    'philippine-national-championship-2026-ilca4',
    '2026-01-18',
    '2026-01-18',
    8,
    'Open',
    4,
    'PHI',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Manila Bay, Philippines',
    'Philippine Sailing Association (PSA)',
    'published',
    'https://www.racingrulesofsailing.org/documents/13459/event',
    'Philippine Sailing Association Official Document 172875',
    'Philippine National Sailing Championship 2026 final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2824830d-8855-57fd-a5cb-4726ba09f8db', 'be28b454-e570-446f-afad-6cf8f88c8764', '6cdcec53-e3ca-51c1-9ab1-ed4dd4886009', 'Ian Carl Carino', 'individual', 1,
    9.0, 9.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Ian Carl Carino. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5e8da88c-a851-50f7-8045-9baee817f620', '2824830d-8855-57fd-a5cb-4726ba09f8db', 'be28b454-e570-446f-afad-6cf8f88c8764', 'Ian Carl Carino', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2824830d-8855-57fd-a5cb-4726ba09f8db', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2824830d-8855-57fd-a5cb-4726ba09f8db', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2824830d-8855-57fd-a5cb-4726ba09f8db', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2824830d-8855-57fd-a5cb-4726ba09f8db', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '77c85af0-45d7-5cc1-898b-5d116274032d', 'bb4b7b96-28a7-459c-aeb2-8ba378575646', '6cdcec53-e3ca-51c1-9ab1-ed4dd4886009', 'Benjaminson Lee Villena', 'individual', 2,
    10.0, 10.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Benjaminson Lee Villena. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fb5b1390-0406-520a-a19f-d02060037384', '77c85af0-45d7-5cc1-898b-5d116274032d', 'bb4b7b96-28a7-459c-aeb2-8ba378575646', 'Benjaminson Lee Villena', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77c85af0-45d7-5cc1-898b-5d116274032d', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77c85af0-45d7-5cc1-898b-5d116274032d', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77c85af0-45d7-5cc1-898b-5d116274032d', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77c85af0-45d7-5cc1-898b-5d116274032d', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e5fe156e-cf26-5471-ad46-b51279743816', '350e86ba-c58a-4a8a-a276-ee4b93eb84da', '6cdcec53-e3ca-51c1-9ab1-ed4dd4886009', 'Zildjan Martin Samson', 'individual', 3,
    12.0, 12.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Zildjan Martin Samson. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '79ed4c7f-dcb2-5438-8c14-e6a06f8554df', 'e5fe156e-cf26-5471-ad46-b51279743816', '350e86ba-c58a-4a8a-a276-ee4b93eb84da', 'Zildjan Martin Samson', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5fe156e-cf26-5471-ad46-b51279743816', 1, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5fe156e-cf26-5471-ad46-b51279743816', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5fe156e-cf26-5471-ad46-b51279743816', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5fe156e-cf26-5471-ad46-b51279743816', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2ca80553-9ce0-5e57-a7f3-33778bdb1ee6', '06f7dd80-c725-5e9f-bbea-e69503a06eac', '6cdcec53-e3ca-51c1-9ab1-ed4dd4886009', 'Prince July Montecer', 'individual', 4,
    13.0, 13.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Prince July Montecer. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '354c76bb-221c-542e-8c42-d3aea49e10d9', '2ca80553-9ce0-5e57-a7f3-33778bdb1ee6', '06f7dd80-c725-5e9f-bbea-e69503a06eac', 'Prince July Montecer', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2ca80553-9ce0-5e57-a7f3-33778bdb1ee6', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2ca80553-9ce0-5e57-a7f3-33778bdb1ee6', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2ca80553-9ce0-5e57-a7f3-33778bdb1ee6', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2ca80553-9ce0-5e57-a7f3-33778bdb1ee6', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0af1bebe-ebd7-51bc-9545-1c5e9e1b0969', 'f51d67a0-2e8c-47eb-9f01-74144117e993', '6cdcec53-e3ca-51c1-9ab1-ed4dd4886009', 'Raya Mithi Samson', 'individual', 5,
    21.0, 21.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Raya Mithi Samson. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '72ffbdcf-c78b-558a-9e0e-4b31703a88e1', '0af1bebe-ebd7-51bc-9545-1c5e9e1b0969', 'f51d67a0-2e8c-47eb-9f01-74144117e993', 'Raya Mithi Samson', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0af1bebe-ebd7-51bc-9545-1c5e9e1b0969', 1, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0af1bebe-ebd7-51bc-9545-1c5e9e1b0969', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0af1bebe-ebd7-51bc-9545-1c5e9e1b0969', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0af1bebe-ebd7-51bc-9545-1c5e9e1b0969', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '65d9622d-31c2-554b-a6ad-c55aeb5f9b05', '40dd5b66-d007-42f6-ba79-88ae35d1e060', '6cdcec53-e3ca-51c1-9ab1-ed4dd4886009', 'Fran Samuel Mejarito', 'individual', 6,
    24.0, 24.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Fran Samuel Mejarito. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '51f397f1-7614-5041-a5e9-6823f60691e2', '65d9622d-31c2-554b-a6ad-c55aeb5f9b05', '40dd5b66-d007-42f6-ba79-88ae35d1e060', 'Fran Samuel Mejarito', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65d9622d-31c2-554b-a6ad-c55aeb5f9b05', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65d9622d-31c2-554b-a6ad-c55aeb5f9b05', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65d9622d-31c2-554b-a6ad-c55aeb5f9b05', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65d9622d-31c2-554b-a6ad-c55aeb5f9b05', 4, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8d46a3eb-da40-5ed8-b399-61ec5457c0d3', '2f41e07e-a6fb-572a-98f5-a15f5d593a2b', '6cdcec53-e3ca-51c1-9ab1-ed4dd4886009', 'John Rovhan Muyot', 'individual', 7,
    27.0, 27.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: John Rovhan Muyot. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd563f382-a8d1-51de-b6ac-e48352cb2a5d', '8d46a3eb-da40-5ed8-b399-61ec5457c0d3', '2f41e07e-a6fb-572a-98f5-a15f5d593a2b', 'John Rovhan Muyot', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d46a3eb-da40-5ed8-b399-61ec5457c0d3', 1, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d46a3eb-da40-5ed8-b399-61ec5457c0d3', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d46a3eb-da40-5ed8-b399-61ec5457c0d3', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d46a3eb-da40-5ed8-b399-61ec5457c0d3', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b95467a1-66b2-5c0f-a81c-83538ce13c06', '2590130d-2e1e-5116-b5e6-4de3ac752482', '6cdcec53-e3ca-51c1-9ab1-ed4dd4886009', 'Rose Ann Marienau', 'individual', 8,
    28.0, 28.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Rose Ann Marienau. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '37c62445-22fc-5ae4-b526-d9b5e6b7588d', 'b95467a1-66b2-5c0f-a81c-83538ce13c06', '2590130d-2e1e-5116-b5e6-4de3ac752482', 'Rose Ann Marienau', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b95467a1-66b2-5c0f-a81c-83538ce13c06', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b95467a1-66b2-5c0f-a81c-83538ce13c06', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b95467a1-66b2-5c0f-a81c-83538ce13c06', 3, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b95467a1-66b2-5c0f-a81c-83538ce13c06', 4, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: Philippine National Sailing Championship 2026 (ILCA 6)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'c5429315-175a-5e33-96c8-48fbff14e956',
    'ec0a10ee-90b6-54b0-ba10-0a08894da825',
    'Philippine National Sailing Championship 2026 (ILCA 6)',
    'philippine-national-championship-2026-ilca6',
    '2026-01-18',
    '2026-01-18',
    5,
    'Open',
    4,
    'PHI',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Manila Bay, Philippines',
    'Philippine Sailing Association (PSA)',
    'published',
    'https://www.racingrulesofsailing.org/documents/13459/event',
    'Philippine Sailing Association Official Document 172875',
    'Philippine National Sailing Championship 2026 final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd3fb5ed1-bb39-5d53-9eae-546addf68a4e', 'a24f538d-5b4f-4446-bf0c-0731c4c67d80', 'c5429315-175a-5e33-96c8-48fbff14e956', 'Renzo Sanchez', 'individual', 1,
    7.0, 7.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Renzo Sanchez. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e3e8f257-518b-51c2-aef2-5231028666d9', 'd3fb5ed1-bb39-5d53-9eae-546addf68a4e', 'a24f538d-5b4f-4446-bf0c-0731c4c67d80', 'Renzo Sanchez', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd3fb5ed1-bb39-5d53-9eae-546addf68a4e', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd3fb5ed1-bb39-5d53-9eae-546addf68a4e', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd3fb5ed1-bb39-5d53-9eae-546addf68a4e', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd3fb5ed1-bb39-5d53-9eae-546addf68a4e', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '862052e2-b5a1-5b06-b48e-ee7818ad4912', 'c198b673-3ee0-568e-af44-6f0dee646380', 'c5429315-175a-5e33-96c8-48fbff14e956', 'Zyke Castillo', 'individual', 2,
    9.0, 9.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Zyke Castillo. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7cc65097-55ac-5feb-9799-f4d7f49c0c45', '862052e2-b5a1-5b06-b48e-ee7818ad4912', 'c198b673-3ee0-568e-af44-6f0dee646380', 'Zyke Castillo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '862052e2-b5a1-5b06-b48e-ee7818ad4912', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '862052e2-b5a1-5b06-b48e-ee7818ad4912', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '862052e2-b5a1-5b06-b48e-ee7818ad4912', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '862052e2-b5a1-5b06-b48e-ee7818ad4912', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ce734af4-b33b-556b-a05b-e67eb3e4a01e', 'a6963324-b0a4-56dc-94f5-f78816b28b6b', 'c5429315-175a-5e33-96c8-48fbff14e956', 'Mark Amadeo', 'individual', 3,
    11.0, 11.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Mark Amadeo. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5291e6a6-f529-53c6-b152-39ede9e74125', 'ce734af4-b33b-556b-a05b-e67eb3e4a01e', 'a6963324-b0a4-56dc-94f5-f78816b28b6b', 'Mark Amadeo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce734af4-b33b-556b-a05b-e67eb3e4a01e', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce734af4-b33b-556b-a05b-e67eb3e4a01e', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce734af4-b33b-556b-a05b-e67eb3e4a01e', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce734af4-b33b-556b-a05b-e67eb3e4a01e', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bc6ed4c1-817a-5527-b435-f23088c6d8ce', '3d9efcfe-3ac7-5368-8783-93f288ab531b', 'c5429315-175a-5e33-96c8-48fbff14e956', 'Josa Gonzales', 'individual', 4,
    13.0, 13.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Josa Gonzales. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b2927c2f-7734-50d8-acfa-a53877e1f353', 'bc6ed4c1-817a-5527-b435-f23088c6d8ce', '3d9efcfe-3ac7-5368-8783-93f288ab531b', 'Josa Gonzales', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc6ed4c1-817a-5527-b435-f23088c6d8ce', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc6ed4c1-817a-5527-b435-f23088c6d8ce', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc6ed4c1-817a-5527-b435-f23088c6d8ce', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc6ed4c1-817a-5527-b435-f23088c6d8ce', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1bf83141-ac83-597d-b963-52c92b86535c', 'f6b26ef3-658c-54c1-97f6-77b99166f040', 'c5429315-175a-5e33-96c8-48fbff14e956', 'Roahnne Roy Santos', 'individual', 5,
    20.0, 20.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Roahnne Roy Santos. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7f8f0fd8-cf40-5a1f-8d8c-be91094fc391', '1bf83141-ac83-597d-b963-52c92b86535c', 'f6b26ef3-658c-54c1-97f6-77b99166f040', 'Roahnne Roy Santos', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bf83141-ac83-597d-b963-52c92b86535c', 1, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bf83141-ac83-597d-b963-52c92b86535c', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bf83141-ac83-597d-b963-52c92b86535c', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bf83141-ac83-597d-b963-52c92b86535c', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: Philippine National Sailing Championship 2026 (ILCA 7)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'a84c4810-ba1f-59ad-a78b-f9f04d3985e4',
    'ec0a10ee-90b6-54b0-ba10-0a08894da825',
    'Philippine National Sailing Championship 2026 (ILCA 7)',
    'philippine-national-championship-2026-ilca7',
    '2026-01-18',
    '2026-01-18',
    5,
    'Open',
    4,
    'PHI',
    'ILCA 7',
    'individual',
    1,
    1,
    false,
    'Manila Bay, Philippines',
    'Philippine Sailing Association (PSA)',
    'published',
    'https://www.racingrulesofsailing.org/documents/13459/event',
    'Philippine Sailing Association Official Document 172875',
    'Philippine National Sailing Championship 2026 final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c471555a-f7e2-536f-8c4e-3538bd94a618', 'c846c0e6-8776-4e2b-9845-8dbe5b2547ca', 'a84c4810-ba1f-59ad-a78b-f9f04d3985e4', 'Morris Lann Madlos', 'individual', 1,
    6.0, 6.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Morris Lann Madlos. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7caf94fa-03ac-5147-8d31-9ccc8f3e7db5', 'c471555a-f7e2-536f-8c4e-3538bd94a618', 'c846c0e6-8776-4e2b-9845-8dbe5b2547ca', 'Morris Lann Madlos', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c471555a-f7e2-536f-8c4e-3538bd94a618', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c471555a-f7e2-536f-8c4e-3538bd94a618', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c471555a-f7e2-536f-8c4e-3538bd94a618', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c471555a-f7e2-536f-8c4e-3538bd94a618', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c4c10e7b-85ba-574d-bfdf-fedd40b85b8e', '0f1602d0-82c1-4be9-8e5a-0921bae516c3', 'a84c4810-ba1f-59ad-a78b-f9f04d3985e4', 'Jeanson Lumapas', 'individual', 2,
    7.0, 7.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Jeanson Lumapas. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '94cc426b-09ab-5002-9e7c-454f2c66ccfb', 'c4c10e7b-85ba-574d-bfdf-fedd40b85b8e', '0f1602d0-82c1-4be9-8e5a-0921bae516c3', 'Jeanson Lumapas', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4c10e7b-85ba-574d-bfdf-fedd40b85b8e', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4c10e7b-85ba-574d-bfdf-fedd40b85b8e', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4c10e7b-85ba-574d-bfdf-fedd40b85b8e', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4c10e7b-85ba-574d-bfdf-fedd40b85b8e', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9a400849-eeff-50d6-8c3a-60d70bd2daaf', '428e0d02-34c2-5e83-a520-341e5dbc4c1e', 'a84c4810-ba1f-59ad-a78b-f9f04d3985e4', 'Daven Balangue', 'individual', 3,
    15.0, 15.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Daven Balangue. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3ae75cf2-5113-5e65-87c8-d8eac4c2180b', '9a400849-eeff-50d6-8c3a-60d70bd2daaf', '428e0d02-34c2-5e83-a520-341e5dbc4c1e', 'Daven Balangue', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a400849-eeff-50d6-8c3a-60d70bd2daaf', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a400849-eeff-50d6-8c3a-60d70bd2daaf', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a400849-eeff-50d6-8c3a-60d70bd2daaf', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a400849-eeff-50d6-8c3a-60d70bd2daaf', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a099d987-bd3b-5aff-9974-f7f32386d404', '3973833a-410d-5cfa-9203-21e2c645d6c3', 'a84c4810-ba1f-59ad-a78b-f9f04d3985e4', 'Teogenes Vilando', 'individual', 4,
    17.0, 17.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Teogenes Vilando. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ef37808b-e902-59fe-9e89-564a4f627625', 'a099d987-bd3b-5aff-9974-f7f32386d404', '3973833a-410d-5cfa-9203-21e2c645d6c3', 'Teogenes Vilando', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a099d987-bd3b-5aff-9974-f7f32386d404', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a099d987-bd3b-5aff-9974-f7f32386d404', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a099d987-bd3b-5aff-9974-f7f32386d404', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a099d987-bd3b-5aff-9974-f7f32386d404', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b0daf892-b0c0-5cf6-b2da-40cdd4955ca3', '115e5bdf-9079-4a63-b63d-5fadd39eb1c7', 'a84c4810-ba1f-59ad-a78b-f9f04d3985e4', 'Whok Dimapilis', 'individual', 5,
    18.0, 18.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results',
    'document', 'Philippine National Sailing Championship 2026. Sailor: Whok Dimapilis. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c02befc7-123a-58cd-af27-43a41108374d', 'b0daf892-b0c0-5cf6-b2da-40cdd4955ca3', '115e5bdf-9079-4a63-b63d-5fadd39eb1c7', 'Whok Dimapilis', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b0daf892-b0c0-5cf6-b2da-40cdd4955ca3', 1, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b0daf892-b0c0-5cf6-b2da-40cdd4955ca3', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b0daf892-b0c0-5cf6-b2da-40cdd4955ca3', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b0daf892-b0c0-5cf6-b2da-40cdd4955ca3', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: Philippine National Sailing Championship 2026 — 420
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'abcafe1c-58a2-5a78-92f7-e2cdfbd44b93',
    'ec0a10ee-90b6-54b0-ba10-0a08894da825',
    'Philippine National Sailing Championship 2026 — 420',
    'philippine-national-championship-2026-420',
    '2026-01-18',
    '2026-01-18',
    5,
    'Open',
    8,
    'PHI',
    '420',
    'crew',
    2,
    2,
    false,
    'Manila Bay, Philippines',
    'Philippine Sailing Association (PSA)',
    'published',
    'https://www.racingrulesofsailing.org/documents/13459/event',
    'Philippine Sailing Association Official Document 172875',
    'Philippine National Sailing Championship 2026 final results (Int. 420).',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a495a931-e95d-5b34-93b2-c32ca4a75621', '71b50eef-af48-568a-bb4a-82c2b52c50c2', 'abcafe1c-58a2-5a78-92f7-e2cdfbd44b93', 'Ronello Castillo & Khim Ashley Albo', 'crew', 1,
    10.0, 8.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results (Int. 420)',
    'document', 'Philippine National Sailing Championship 2026 (Int. 420). Helm: Ronello Castillo, Crew: Khim Ashley Albo.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '94e2138f-3afe-54f4-8a44-86b3f081f759', 'a495a931-e95d-5b34-93b2-c32ca4a75621', '71b50eef-af48-568a-bb4a-82c2b52c50c2', 'Ronello Castillo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1924ac2b-296a-5021-8381-edfd771373fa', 'a495a931-e95d-5b34-93b2-c32ca4a75621', '108d0eda-d379-5e23-bcde-6732a7f489cb', 'Khim Ashley Albo', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a495a931-e95d-5b34-93b2-c32ca4a75621', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a495a931-e95d-5b34-93b2-c32ca4a75621', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a495a931-e95d-5b34-93b2-c32ca4a75621', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a495a931-e95d-5b34-93b2-c32ca4a75621', 4, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a495a931-e95d-5b34-93b2-c32ca4a75621', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a495a931-e95d-5b34-93b2-c32ca4a75621', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a495a931-e95d-5b34-93b2-c32ca4a75621', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a495a931-e95d-5b34-93b2-c32ca4a75621', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1a81b305-ff46-5114-8b75-5899e425b805', '28d41ecd-3f04-5c5f-81e5-15b3567e68f3', 'abcafe1c-58a2-5a78-92f7-e2cdfbd44b93', 'Doglas Amadeo & Rhyannedra Laud', 'crew', 2,
    22.0, 18.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results (Int. 420)',
    'document', 'Philippine National Sailing Championship 2026 (Int. 420). Helm: Doglas Amadeo, Crew: Rhyannedra Laud.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b528c2fb-0802-5643-9865-504f60c8e5c3', '1a81b305-ff46-5114-8b75-5899e425b805', '28d41ecd-3f04-5c5f-81e5-15b3567e68f3', 'Doglas Amadeo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5a59f765-e544-50d9-a862-bcb05d653c65', '1a81b305-ff46-5114-8b75-5899e425b805', '4b58297f-8e99-5710-af4c-28a1c12f4564', 'Rhyannedra Laud', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a81b305-ff46-5114-8b75-5899e425b805', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a81b305-ff46-5114-8b75-5899e425b805', 2, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a81b305-ff46-5114-8b75-5899e425b805', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a81b305-ff46-5114-8b75-5899e425b805', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a81b305-ff46-5114-8b75-5899e425b805', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a81b305-ff46-5114-8b75-5899e425b805', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a81b305-ff46-5114-8b75-5899e425b805', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a81b305-ff46-5114-8b75-5899e425b805', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f6ea22ab-4a74-5f62-ad99-dc5b1b691ffd', '14fe7ad8-c782-5e65-8d9e-7cb700abd778', 'abcafe1c-58a2-5a78-92f7-e2cdfbd44b93', 'Czyrille Bonidict G Icamen & Samuel Tolentino', 'crew', 3,
    27.0, 21.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results (Int. 420)',
    'document', 'Philippine National Sailing Championship 2026 (Int. 420). Helm: Czyrille Bonidict G Icamen, Crew: Samuel Tolentino.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'db788b3a-ffa5-5079-b92a-2a59b95c84e2', 'f6ea22ab-4a74-5f62-ad99-dc5b1b691ffd', '14fe7ad8-c782-5e65-8d9e-7cb700abd778', 'Czyrille Bonidict G Icamen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c05889e8-abbc-54b5-b7d4-e86f486bd682', 'f6ea22ab-4a74-5f62-ad99-dc5b1b691ffd', '0cc2b490-0422-5b10-a4b8-14435ff94dbd', 'Samuel Tolentino', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6ea22ab-4a74-5f62-ad99-dc5b1b691ffd', 1, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6ea22ab-4a74-5f62-ad99-dc5b1b691ffd', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6ea22ab-4a74-5f62-ad99-dc5b1b691ffd', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6ea22ab-4a74-5f62-ad99-dc5b1b691ffd', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6ea22ab-4a74-5f62-ad99-dc5b1b691ffd', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6ea22ab-4a74-5f62-ad99-dc5b1b691ffd', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6ea22ab-4a74-5f62-ad99-dc5b1b691ffd', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6ea22ab-4a74-5f62-ad99-dc5b1b691ffd', 8, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3bb89087-bd83-597b-8a23-d1d7ea515fd7', '53cbc7ca-b875-575e-88bd-28ba72fd1543', 'abcafe1c-58a2-5a78-92f7-e2cdfbd44b93', 'Nadine Boyano & Paolo Alocilja', 'crew', 4,
    30.0, 25.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results (Int. 420)',
    'document', 'Philippine National Sailing Championship 2026 (Int. 420). Helm: Nadine Boyano, Crew: Paolo Alocilja.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '89f87b09-879c-50cf-9fd2-0bb41d433870', '3bb89087-bd83-597b-8a23-d1d7ea515fd7', '53cbc7ca-b875-575e-88bd-28ba72fd1543', 'Nadine Boyano', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '33d2c033-28d3-57f1-a43e-224f779e2e4c', '3bb89087-bd83-597b-8a23-d1d7ea515fd7', 'c1f870bf-053c-503c-8c08-b6227ca316fd', 'Paolo Alocilja', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3bb89087-bd83-597b-8a23-d1d7ea515fd7', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3bb89087-bd83-597b-8a23-d1d7ea515fd7', 2, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3bb89087-bd83-597b-8a23-d1d7ea515fd7', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3bb89087-bd83-597b-8a23-d1d7ea515fd7', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3bb89087-bd83-597b-8a23-d1d7ea515fd7', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3bb89087-bd83-597b-8a23-d1d7ea515fd7', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3bb89087-bd83-597b-8a23-d1d7ea515fd7', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3bb89087-bd83-597b-8a23-d1d7ea515fd7', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '45e62835-46bb-5f76-a687-dfd9909f0e60', '686782e6-68ea-53b3-8ded-61e5b8d789dd', 'abcafe1c-58a2-5a78-92f7-e2cdfbd44b93', 'Frinz Jonas Liam B Mejarito & Miguel Madlos', 'crew', 5,
    33.0, 28.0, false, false, 'https://www.racingrulesofsailing.org/documents/13459/event',
    'https://www.racingrulesofsailing.org/documents/13459/event', 'Philippine National Sailing Championship 2026 Official Results (Int. 420)',
    'document', 'Philippine National Sailing Championship 2026 (Int. 420). Helm: Frinz Jonas Liam B Mejarito, Crew: Miguel Madlos.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '08cffcf7-a266-56f6-98cf-e88f7073a8a4', '45e62835-46bb-5f76-a687-dfd9909f0e60', '686782e6-68ea-53b3-8ded-61e5b8d789dd', 'Frinz Jonas Liam B Mejarito', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c320072c-9033-5547-9c9d-c388a21c6c6e', '45e62835-46bb-5f76-a687-dfd9909f0e60', '0d1b97b3-525e-5649-9063-058003417e7a', 'Miguel Madlos', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e62835-46bb-5f76-a687-dfd9909f0e60', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e62835-46bb-5f76-a687-dfd9909f0e60', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e62835-46bb-5f76-a687-dfd9909f0e60', 3, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e62835-46bb-5f76-a687-dfd9909f0e60', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e62835-46bb-5f76-a687-dfd9909f0e60', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e62835-46bb-5f76-a687-dfd9909f0e60', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e62835-46bb-5f76-a687-dfd9909f0e60', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e62835-46bb-5f76-a687-dfd9909f0e60', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

COMMIT;
