-- Migration 170: Import INA Regatta II & National Sailing Championship 2026
--
-- Imports the official championship results for Indonesia's premier national regatta:
-- Event: INA Regatta II & National Sailing Championship 2026 (Kejurnas Layar 2026)
-- Dates: 20–23 August 2026 · Venue: Indonesia National Sailing Center (INSC), Ancol, Jakarta
-- Authority: Pengurus Besar Persatuan Olahraga Layar Seluruh Indonesia (PB. PORLASI / INASAF)
-- Official Source: Official 18-page results PDF (https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf)
--
-- Classes Imported (8 fleets across 7 permitted classes):
-- 1. Optimist: 21 boats, 7 races, 2 discards (147 race scores)
-- 2. ILCA 4: 11 boats, 7 races, 2 discards (77 race scores)
-- 3. ILCA 6: 13 boats, 7 races, 2 discards (91 race scores)
-- 4. ILCA 7: 9 boats, 7 races, 2 discards (63 race scores)
-- 5. International 420: 5 boats, 8 races, 2 discards (40 race scores)
-- 6. Techno 293: 10 boards, 8 races, 2 discards (80 race scores)
-- 7. Techno 293 Plus: 6 boards, 8 races, 2 discards (48 race scores)
-- 8. iQFoil: 4 boards, 8 races, 2 discards (32 race scores)
--
-- All operations execute in a single atomic transaction.

BEGIN;

-- 1. Insert New Verified Sailor Profiles
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8696bbd8-c1e5-5c7f-8205-104ec53a9eae', 'Abdul Habibi', 'abdul-habibi-b2d8d4', 'INA 2510', 'Kaltim', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6f72c1bc-65fa-5daf-af99-3a2b77ebb8f2', 'Novrizam Afka Adrian', 'novrizam-afka-adrian-003d40', 'INA 6671', 'Jakarta', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '399a73ee-d2aa-5c3d-953d-d9c2d0b737f8', 'M. Habibie Al-Zahri', 'm-habibie-al-zahri-1e5d52', 'INA 2201', 'Kepri/Kodaeral IV', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ebd89b7e-7937-5c44-bf0d-e9788bba387f', 'Hannindieta Julia Syabani', 'hannindieta-julia-syabani-f69f88', 'INA 2101', 'Jakarta', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'cc825cf2-3d27-595b-965d-350c3ef718b7', 'Dwi Anisa Aprilia', 'dwi-anisa-aprilia-e8fc05', 'INA 2530', 'Kaltim', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2870ae72-4359-54d8-a9fb-25118ba8b77c', 'Carissa Nindra Alunaditiandika', 'carissa-nindra-alunaditiandika-e69e46', 'INA 5022', 'Kota Cimahi', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f09b015d-777f-59db-8f2d-7edca7b5c1a7', 'Amira Khansa Syabila', 'amira-khansa-syabila-8d60a1', 'INA 5805', 'Kota Bekasi', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1329ea9c-464f-54ad-97e1-b4a0dc0e14c5', 'Tiyas Nur Falah', 'tiyas-nur-falah-e0196a', 'SGP 15379', 'Banten', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '187e47b7-bfc2-5f86-b686-fb5977edbfac', 'Lexy Rizka Ratita', 'lexy-rizka-ratita-7cfd5d', 'INA 1579', 'Banten', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c0ce582a-7846-58eb-8498-04b6eb15f986', 'Ni Putu Anindya Maheswari', 'ni-putu-anindya-maheswari-d3c9ce', '1', 'Bali', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '47f8796d-8ce6-5568-950d-e90887d9f34a', 'Okshi Kurniawan', 'okshi-kurniawan-62e9cd', 'INA 907', 'Jakarta', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ab5a65e3-4e47-5cd6-b058-37f8519a1aa7', 'M Adam Farina Bin Guido Farina', 'm-adam-farina-bin-guido-farina-f4b3bb', 'MAS 9023', 'Kedah Sailing', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '029980b2-2fe6-5047-94a9-05fcab48c1b1', 'Nadira Septiandini Ponanda', 'nadira-septiandini-ponanda-32d914', 'INA 1736', 'TASS', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'df2d7463-6413-5cc2-82c3-606954ea9852', 'Radit Bay Supriyadi', 'radit-bay-supriyadi-c1f875', 'SGP 1', 'Banten', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9bd769b1-94ba-55b9-96c4-9820d777b30b', 'Shafar Raditia Ramlan', 'shafar-raditia-ramlan-1a3335', 'INA 2602', 'Kepri/Kodaeral IV', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8a5451ff-07c1-5719-b820-b63983c56a20', 'Maura Putri Ariski', 'maura-putri-ariski-53d237', 'INA 199', 'TASS', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e655b076-c7da-5db5-ae87-5b39b6d4f631', 'M. Nidzar A.', 'm-nidzar-a-06ef93', 'INA 159', 'TASS', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fc95de97-5a08-51e2-a8e7-0ecfea24deb3', 'Galang Bangkit Ramadhan', 'galang-bangkit-ramadhan-3b92a8', '1527', 'TASS', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2a70b3af-482c-51f3-911a-88760a23d0b5', 'Aqila Chan Stevany Sarendeng', 'aqila-chan-stevany-sarendeng-7d2181', 'INA 17', 'TASS', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7a5a55f5-0b86-5286-b402-e688c2290b12', 'Jigme Suharyo', 'jigme-suharyo-ca9122', 'INA 118', 'TASS', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0e39559e-ec8e-52d6-91c5-47dba0b6a2e1', 'Achmad Rafa Abyas', 'achmad-rafa-abyas-6a7295', 'INA 15', 'Jakarta', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd5b73423-e2a1-558b-829c-44b824606225', 'Addy Armand Bin Anuar', 'addy-armand-bin-anuar-394eb5', 'SGP 143', 'Singapore Sailing', 'SGP', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4453abbe-f8e7-5d87-9968-f6b202564385', 'Nazwa Anggraeni', 'nazwa-anggraeni-764f43', 'INA 1', 'Jakarta', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6601496b-5734-5e04-8f54-b2cea50e1606', 'Adhelia Khanza Al Naira', 'adhelia-khanza-al-naira-ab205a', 'INA 7', 'Jakarta', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'eb1b0682-c7ec-5b39-bbac-f9bdbfc42c63', 'Berly Yasta Muammar', 'berly-yasta-muammar-18e993', 'INA 8', 'Banten', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '04869a26-6a15-5515-9c1c-99159fbba7f7', 'Zulfikri Ilham', 'zulfikri-ilham-b9fbea', '29', 'Kaltim', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '85e1af27-1243-5d47-8fe3-c9dd19f14882', 'Marcus Thye', 'marcus-thye-04a24d', 'SGP 417', 'Constant Wind', 'SGP', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f051bd59-1744-53ff-86d7-c3658f8aeb41', 'Afriza Achmad Bagaskara', 'afriza-achmad-bagaskara-674ce2', 'INA 81', 'Jakarta', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b3763d38-e350-5d3d-b944-789ae4af5234', 'Syafira Zahra Aulia', 'syafira-zahra-aulia-03f2ef', 'INA 18', 'Jakarta', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '44b23788-36d2-585f-937c-29cc15e99268', 'Aulia Jumata Savani', 'aulia-jumata-savani-fdd702', 'INA 111', 'Kaltim', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b256f1da-0142-5233-9b44-afd7bdf5ece6', 'Muhammad Fachry Rizky', 'muhammad-fachry-rizky-b0ed26', '12', 'Kota Bekasi', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9961a814-f254-550e-855d-7e1da2e02c56', 'Febrian Eka Ss.', 'febrian-eka-ss-e83972', 'INA 89', 'TASS', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0b3ce018-152f-512f-a38e-522c15834c51', 'Ahmad Jaini', 'ahmad-jaini-4ea9b0', 'INA 79', 'Kaltim', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fd52c255-ed1b-5530-8abb-a20fd11f9368', 'Dexy Priany', 'dexy-priany-a76226', '1', 'Banten', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f7b979a3-0779-5c32-b82c-ec571b67f1f2', 'Alifah Auralia', 'alifah-auralia-a4bb4c', 'INA 99', 'Jakarta', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fce87a61-25ad-5b6c-b5db-eff5b29b4f66', 'Roy Zulfadli Bahri', 'roy-zulfadli-bahri-2e5603', 'INA 38', 'Kaltim', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '02615641-6db6-5a32-ad5f-354820d39ce0', 'Saitama Junjungan Simanjuntak', 'saitama-junjungan-simanjuntak-d29127', 'INA 35', 'Jakarta', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'dd97b0f0-b35f-57b6-9132-61c6ca6a3a21', 'Rizky Marvel', 'rizky-marvel-181237', 'INA 225223', 'Kepri/Kodaeral IV', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '77e917ce-5882-50ae-8de1-c03dd228e12b', 'Adelia Maisyah Adha', 'adelia-maisyah-adha-b1f553', '192409', 'KALTIM', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '619924d0-7a1e-5a51-b479-c9cf8ed63b49', 'Aurora Cantika Lilo Haqqi', 'aurora-cantika-lilo-haqqi-52f651', '175899', 'KOTA BEKASI', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '20f4c63e-751a-500f-bece-db4c3137163f', 'Fahri Khalfani Akbar', 'fahri-khalfani-akbar-375f9d', 'INA 221026', 'KOTA BEKASI', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f50d93a6-03cd-5e27-ac1a-1eb365f43f4c', 'Fiorentino Gabriel Alberto Awuy', 'fiorentino-gabriel-alberto-awuy-f743a3', '204628', 'KOTA CIMAHI', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '58b4d139-3c98-5fc1-86de-317be2ebe6c1', 'Naura Adhara Ariyanto', 'naura-adhara-ariyanto-1c4354', 'INA 221111', 'JAKARTA', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9e3cb0fc-ba20-56ce-a13e-c5de907f38a2', 'Esta Annabil Syarif Revandi', 'esta-annabil-syarif-revandi-516f99', 'INA 220411', 'JAKARTA', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7ef183f5-f6dd-5ce7-8d5c-d94d717d8e3e', 'Surya Tama Saputra', 'surya-tama-saputra-15c59d', '192408', 'KALTIM', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2104a554-e16c-5ce4-8bd9-5590a90f271f', 'Fachrie Aldiansyah', 'fachrie-aldiansyah-d967d4', 'INA 209147', 'Kepri/Kodaeral IV', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c7ea9adb-c8f7-5dbb-8256-a8bb6d70a8d5', 'Nur Azila', 'nur-azila-0041af', 'INA 198172', 'Kepri/Kodaeral IV', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3c15d222-fff0-5e3f-99f7-29321154e5ee', 'Rizka Tri Aryani', 'rizka-tri-aryani-247330', 'INA 193924', 'Kepri/Kodaeral IV', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e38adb25-9c74-5d2b-b887-a96d9fc2830f', 'Lucky Novriansyah', 'lucky-novriansyah-b03057', 'INA 22', 'Kepri/Kodaeral IV', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '56c325d1-c1de-58c4-bfb9-cd55eed8fd8d', 'Rivandi', 'rivandi-a772b8', 'INA 211121', 'KALTIM', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2fdd39b5-36b1-53bc-a31d-7d2538029c8b', 'Fitri Alwiyah', 'fitri-alwiyah-2ea291', '221599', 'KOTA BEKASI', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f7b5cd3f-a9d1-5b26-926d-005b753ca1d6', 'Jalesveva Divo Ardiansyah', 'jalesveva-divo-ardiansyah-8e82db', 'INA 217961', 'Kepri/Kodaeral IV', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0bfb3cdf-a06a-5595-bd37-748261ad2e94', 'Rezky Adrean', 'rezky-adrean-4b89af', '262021', 'KOTA BANDUNG', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '95b977f5-b5ec-5b40-9245-e5b5369102b5', 'Alif Apriliano Ariesta', 'alif-apriliano-ariesta-d41d19', '12', 'KABUPATEN BANDUNG', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5db2885e-4e93-50f3-a9af-81f72edb79a8', 'Sarmila', 'sarmila-41f2d5', 'INA 20', 'KALTIM', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3a05ef10-228f-561b-9395-044f7454b050', 'Amellia', 'amellia-358160', '88', 'JAKARTA', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f12adeb3-8b1c-5380-a4f7-17c7e2f61321', 'Muhammad Al Jalil Mandala Julyaji', 'muhammad-al-jalil-mandala-julyaji-1ab4d1', '8', 'JAKARTA', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f2d90982-885f-501f-9bdf-a461bffdb701', 'William Woolston', 'william-woolston-f4d2f2', '1', 'HORNING SAILING CLUB', 'GBR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6e7616bc-ec6d-599d-ac46-98d3c5a71d3e', 'Tora Mirsya Pratama', 'tora-mirsya-pratama-0c003d', '227676', 'KOARMADA 1', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4a918f7d-c427-55e5-abec-73934c37a54f', 'Sujatmiko Siswanto', 'sujatmiko-siswanto-e292a1', '221121', 'KOTA BANDUNG', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '99e8004d-8b84-5e8e-809d-ee3f9d8573be', 'Samsuardi', 'samsuardi-581010', '6', 'KOTA BANDUNG', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2c76ae25-c4e6-5bdd-8ef4-a1935ef47fcf', 'Alif Thaariq Sutrisno', 'alif-thaariq-sutrisno-077fce', '200998', 'SULAWESI SELATAN', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '70a60989-1817-53fb-b3fb-dab26afd9815', 'Aditya Rama Dani', 'aditya-rama-dani-c0c40b', '60', 'KOARMADA I/JAKARTA', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5128047f-c7fb-5412-890c-b21a4ddabec3', 'Kevin Julyo Aldafa', 'kevin-julyo-aldafa-22e04a', '221579', 'KOTA BEKASI', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '380d05db-dc36-5fd2-9f90-5ff5737ea25f', 'Bagus Susanto', 'bagus-susanto-02a9d6', '80', 'KOARMADA 1', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0da77a16-919d-5fdd-a00a-832f70de8620', 'M Adhit', 'm-adhit-1e912a', 'INA 57240', 'KALTIM', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5c8d2c22-f00f-576f-b797-e407431f282f', 'Andi M Faruq', 'andi-m-faruq-660133', 'INA 57240', 'KALTIM', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ea4e4440-b236-5f9c-bd6d-d54b6d55b49a', 'Alya', 'alya-4c1676', '10', 'KALTIM', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0a35f645-13fa-584b-b382-7c59d21438a7', 'Hafizhah Ramadhani H', 'hafizhah-ramadhani-h-88e9d3', '10', 'KALTIM', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2d82caa4-e947-5ac2-9cee-00603f1b8a35', 'Kinara Prisha D', 'kinara-prisha-d-8539bf', 'INA 65404', 'JAKARTA', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '462759d5-09af-555d-a8ed-0c619cc7f72b', 'Azaleya Tifani P', 'azaleya-tifani-p-4f6c87', 'INA 65404', 'JAKARTA', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5c7e1959-8451-58b6-8288-1e5050a99cdd', 'Safira Zaliyanti', 'safira-zaliyanti-3582c0', 'INA 888', 'BANTEN', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'aca44d87-5e1e-5f36-b253-2cfd7a11ac35', 'Ratu Sri AW', 'ratu-sri-aw-3535a1', 'INA 888', 'BANTEN', 'INA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '145c0ac3-b906-5479-8387-3c2791049071', 'Zevan Adriansah', 'zevan-adriansah-0b036d', 'INA 50389', 'JAKARTA', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b3b191f7-de7a-5536-942e-e14c13f740a5', 'Mujaya', 'mujaya-506655', 'INA 50389', 'JAKARTA', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);

-- Enrich existing profiles with verified Indonesian nationality & club
UPDATE public.sailors SET nationality = 'INA', club = 'JATIM' WHERE id = '79c6406b-143d-542d-a3fc-b8a328b93f96' AND nationality IS NULL;
UPDATE public.sailors SET nationality = 'INA', club = 'JATIM' WHERE id = 'd2d167b4-52fc-532a-8d72-11ffb103a300' AND nationality IS NULL;

-- 2. Insert INA Regatta II & National Sailing Championship 2026 Event
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules,
    created_at, updated_at
) VALUES (
    '3ae81002-0dba-52b3-98e3-9b58715edc32',
    'INA Regatta II & National Sailing Championship 2026',
    'ina-regatta-ii-national-sailing-championship-2026',
    '2026-08-20',
    '2026-08-23',
    'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'Pengurus Besar Persatuan Olahraga Layar Seluruh Indonesia (PB PORLASI / INASAF)',
    '["Optimist", "ILCA 4", "ILCA 6", "ILCA 7", "420", "Techno 293", "Techno 293 Plus", "iQFoil"]'::jsonb,
    false,
    false,
    'Official Indonesian National Sailing Championship 2026 (Kejurnas Layar) held 20–23 August 2026 at INSC Ancol, Jakarta.',
    'Low Point System (Appendix A) with 2 discards.',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;

-- Regatta Sheet: INA Regatta II & National Sailing Championship 2026 — Optimist
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '0edbbb2f-1b15-5655-9974-2ab7c4201198',
    '3ae81002-0dba-52b3-98e3-9b58715edc32',
    'INA Regatta II & National Sailing Championship 2026 — Optimist',
    'ina-regatta-ii-national-sailing-championship-2026-optimist',
    '2026-08-23',
    '2026-08-23',
    21,
    'Open',
    7,
    'INA',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'PB. PORLASI / INASAF',
    'published',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'Official Final Results PDF from Indonesian Sailing Federation (PB. PORLASI / INASAF)',
    'Official Indonesian National Championship final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8ee818b0-36c4-5f52-9a5c-d6aaadf36dee', '8696bbd8-c1e5-5c7f-8205-104ec53a9eae', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Abdul Habibi', 'INA 2510', 'individual', 1,
    18.0, 8.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Abdul Habibi. Club: Kaltim. Division: Opt. Green Open. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '055898fd-8197-502d-aa24-eb32ad7a47ee', '8ee818b0-36c4-5f52-9a5c-d6aaadf36dee', '8696bbd8-c1e5-5c7f-8205-104ec53a9eae', 'Abdul Habibi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee818b0-36c4-5f52-9a5c-d6aaadf36dee', 1, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee818b0-36c4-5f52-9a5c-d6aaadf36dee', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee818b0-36c4-5f52-9a5c-d6aaadf36dee', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee818b0-36c4-5f52-9a5c-d6aaadf36dee', 4, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee818b0-36c4-5f52-9a5c-d6aaadf36dee', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee818b0-36c4-5f52-9a5c-d6aaadf36dee', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee818b0-36c4-5f52-9a5c-d6aaadf36dee', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e78a0e9a-f08b-5189-bb4d-25f669dcef58', '6f72c1bc-65fa-5daf-af99-3a2b77ebb8f2', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Novrizam Afka Adrian', 'INA 6671', 'individual', 2,
    20.0, 9.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Novrizam Afka Adrian. Club: Jakarta. Division: Optimist Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6faf3bd3-249b-5b4d-b2d2-3be60809838b', 'e78a0e9a-f08b-5189-bb4d-25f669dcef58', '6f72c1bc-65fa-5daf-af99-3a2b77ebb8f2', 'Novrizam Afka Adrian', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e78a0e9a-f08b-5189-bb4d-25f669dcef58', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e78a0e9a-f08b-5189-bb4d-25f669dcef58', 2, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e78a0e9a-f08b-5189-bb4d-25f669dcef58', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e78a0e9a-f08b-5189-bb4d-25f669dcef58', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e78a0e9a-f08b-5189-bb4d-25f669dcef58', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e78a0e9a-f08b-5189-bb4d-25f669dcef58', 6, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e78a0e9a-f08b-5189-bb4d-25f669dcef58', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a5199bbc-2534-5e46-9287-58a3ace9c3c3', '399a73ee-d2aa-5c3d-953d-d9c2d0b737f8', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'M. Habibie Al-Zahri', 'INA 2201', 'individual', 3,
    36.0, 12.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: M. Habibie Al-Zahri. Club: Kepri/Kodaeral IV. Division: Opt. Green Open. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5d1209aa-570a-5ec3-878a-df52c2671b74', 'a5199bbc-2534-5e46-9287-58a3ace9c3c3', '399a73ee-d2aa-5c3d-953d-d9c2d0b737f8', 'M. Habibie Al-Zahri', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5199bbc-2534-5e46-9287-58a3ace9c3c3', 1, 13.0, NULL, true, '(13)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5199bbc-2534-5e46-9287-58a3ace9c3c3', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5199bbc-2534-5e46-9287-58a3ace9c3c3', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5199bbc-2534-5e46-9287-58a3ace9c3c3', 4, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5199bbc-2534-5e46-9287-58a3ace9c3c3', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5199bbc-2534-5e46-9287-58a3ace9c3c3', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5199bbc-2534-5e46-9287-58a3ace9c3c3', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '00725edb-29df-53af-acd8-df2bde67ff78', 'd4ac1747-65f6-57eb-aac2-aa3247f79da9', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Aguero Pratama Syabani', 'INA 2611', 'individual', 4,
    21.0, 13.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Aguero Pratama Syabani. Club: Kota Bekasi. Division: Optimist Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9ff23253-676b-51aa-98d1-80d0b787ceb8', '00725edb-29df-53af-acd8-df2bde67ff78', 'd4ac1747-65f6-57eb-aac2-aa3247f79da9', 'Aguero Pratama Syabani', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00725edb-29df-53af-acd8-df2bde67ff78', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00725edb-29df-53af-acd8-df2bde67ff78', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00725edb-29df-53af-acd8-df2bde67ff78', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00725edb-29df-53af-acd8-df2bde67ff78', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00725edb-29df-53af-acd8-df2bde67ff78', 5, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00725edb-29df-53af-acd8-df2bde67ff78', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00725edb-29df-53af-acd8-df2bde67ff78', 7, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1c38fbba-fd4b-563e-8b50-0356c034ddbf', 'ebd89b7e-7937-5c44-bf0d-e9788bba387f', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Hannindieta Julia Syabani', 'INA 2101', 'individual', 5,
    58.0, 24.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Hannindieta Julia Syabani. Club: Jakarta. Division: Optimist Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '77eb8268-8d70-5c9e-9a3c-bae4ac1d4f92', '1c38fbba-fd4b-563e-8b50-0356c034ddbf', 'ebd89b7e-7937-5c44-bf0d-e9788bba387f', 'Hannindieta Julia Syabani', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c38fbba-fd4b-563e-8b50-0356c034ddbf', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c38fbba-fd4b-563e-8b50-0356c034ddbf', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c38fbba-fd4b-563e-8b50-0356c034ddbf', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c38fbba-fd4b-563e-8b50-0356c034ddbf', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c38fbba-fd4b-563e-8b50-0356c034ddbf', 5, 12.0, NULL, true, '(12)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c38fbba-fd4b-563e-8b50-0356c034ddbf', 6, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c38fbba-fd4b-563e-8b50-0356c034ddbf', 7, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c6a78592-340a-53a1-b155-79a654453411', 'cc825cf2-3d27-595b-965d-350c3ef718b7', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Dwi Anisa Aprilia', 'INA 2530', 'individual', 6,
    55.0, 26.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Dwi Anisa Aprilia. Club: Kaltim. Division: Optimist Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '49ea7511-79aa-5917-8162-caeaa759e99f', 'c6a78592-340a-53a1-b155-79a654453411', 'cc825cf2-3d27-595b-965d-350c3ef718b7', 'Dwi Anisa Aprilia', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c6a78592-340a-53a1-b155-79a654453411', 1, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c6a78592-340a-53a1-b155-79a654453411', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c6a78592-340a-53a1-b155-79a654453411', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c6a78592-340a-53a1-b155-79a654453411', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c6a78592-340a-53a1-b155-79a654453411', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c6a78592-340a-53a1-b155-79a654453411', 6, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c6a78592-340a-53a1-b155-79a654453411', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '52f3fa98-aff0-52f0-8a09-54c4963519f2', '2870ae72-4359-54d8-a9fb-25118ba8b77c', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Carissa Nindra Alunaditiandika', 'INA 5022', 'individual', 7,
    63.0, 32.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Carissa Nindra Alunaditiandika. Club: Kota Cimahi. Division: Optimist Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '576621b2-28ee-5914-9c50-6a2c0d78b382', '52f3fa98-aff0-52f0-8a09-54c4963519f2', '2870ae72-4359-54d8-a9fb-25118ba8b77c', 'Carissa Nindra Alunaditiandika', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52f3fa98-aff0-52f0-8a09-54c4963519f2', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52f3fa98-aff0-52f0-8a09-54c4963519f2', 2, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52f3fa98-aff0-52f0-8a09-54c4963519f2', 3, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52f3fa98-aff0-52f0-8a09-54c4963519f2', 4, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52f3fa98-aff0-52f0-8a09-54c4963519f2', 5, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52f3fa98-aff0-52f0-8a09-54c4963519f2', 6, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52f3fa98-aff0-52f0-8a09-54c4963519f2', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '99d481c8-008e-54e2-b460-dddad318f634', 'f09b015d-777f-59db-8f2d-7edca7b5c1a7', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Amira Khansa Syabila', 'INA 5805', 'individual', 8,
    55.0, 33.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Amira Khansa Syabila. Club: Kota Bekasi. Division: Opt. Green Open. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '145f89fd-0085-5e4a-9c2b-18dc29def879', '99d481c8-008e-54e2-b460-dddad318f634', 'f09b015d-777f-59db-8f2d-7edca7b5c1a7', 'Amira Khansa Syabila', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d481c8-008e-54e2-b460-dddad318f634', 1, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d481c8-008e-54e2-b460-dddad318f634', 2, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d481c8-008e-54e2-b460-dddad318f634', 3, 12.0, NULL, true, '(12)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d481c8-008e-54e2-b460-dddad318f634', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d481c8-008e-54e2-b460-dddad318f634', 5, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d481c8-008e-54e2-b460-dddad318f634', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d481c8-008e-54e2-b460-dddad318f634', 7, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '133a1db4-80fb-5b8d-be7a-0be21dae113e', '1329ea9c-464f-54ad-97e1-b4a0dc0e14c5', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Tiyas Nur Falah', 'SGP 15379', 'individual', 9,
    62.0, 35.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Tiyas Nur Falah. Club: Banten. Division: Optimist Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '193a92fb-6fb2-5ffc-9826-b657daec8b9c', '133a1db4-80fb-5b8d-be7a-0be21dae113e', '1329ea9c-464f-54ad-97e1-b4a0dc0e14c5', 'Tiyas Nur Falah', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '133a1db4-80fb-5b8d-be7a-0be21dae113e', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '133a1db4-80fb-5b8d-be7a-0be21dae113e', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '133a1db4-80fb-5b8d-be7a-0be21dae113e', 3, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '133a1db4-80fb-5b8d-be7a-0be21dae113e', 4, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '133a1db4-80fb-5b8d-be7a-0be21dae113e', 5, 17.0, NULL, true, '(17)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '133a1db4-80fb-5b8d-be7a-0be21dae113e', 6, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '133a1db4-80fb-5b8d-be7a-0be21dae113e', 7, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bb54925d-147d-5192-bcb4-f85dfb8127f3', '187e47b7-bfc2-5f86-b686-fb5977edbfac', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Lexy Rizka Ratita', 'INA 1579', 'individual', 10,
    72.0, 42.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Lexy Rizka Ratita. Club: Banten. Division: Optimist Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'da5042a7-08ce-5bcf-be11-805b096150ca', 'bb54925d-147d-5192-bcb4-f85dfb8127f3', '187e47b7-bfc2-5f86-b686-fb5977edbfac', 'Lexy Rizka Ratita', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bb54925d-147d-5192-bcb4-f85dfb8127f3', 1, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bb54925d-147d-5192-bcb4-f85dfb8127f3', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bb54925d-147d-5192-bcb4-f85dfb8127f3', 3, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bb54925d-147d-5192-bcb4-f85dfb8127f3', 4, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bb54925d-147d-5192-bcb4-f85dfb8127f3', 5, 15.0, NULL, true, '(15)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bb54925d-147d-5192-bcb4-f85dfb8127f3', 6, 15.0, NULL, true, '(15)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bb54925d-147d-5192-bcb4-f85dfb8127f3', 7, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '263b7611-66ba-5ae8-973b-014d16f41d62', 'c0ce582a-7846-58eb-8498-04b6eb15f986', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Ni Putu Anindya Maheswari', '1', 'individual', 11,
    73.0, 47.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Ni Putu Anindya Maheswari. Club: Bali. Division: Optimist Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '728a13ff-9449-51bb-bedb-f869f2a15b44', '263b7611-66ba-5ae8-973b-014d16f41d62', 'c0ce582a-7846-58eb-8498-04b6eb15f986', 'Ni Putu Anindya Maheswari', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '263b7611-66ba-5ae8-973b-014d16f41d62', 1, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '263b7611-66ba-5ae8-973b-014d16f41d62', 2, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '263b7611-66ba-5ae8-973b-014d16f41d62', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '263b7611-66ba-5ae8-973b-014d16f41d62', 4, 12.0, NULL, true, '(12)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '263b7611-66ba-5ae8-973b-014d16f41d62', 5, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '263b7611-66ba-5ae8-973b-014d16f41d62', 6, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '263b7611-66ba-5ae8-973b-014d16f41d62', 7, 14.0, NULL, true, '(14)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '042788f4-b092-5ab2-9b14-0835510a2c3a', '47f8796d-8ce6-5568-950d-e90887d9f34a', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Okshi Kurniawan', 'INA 907', 'individual', 12,
    85.0, 49.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Okshi Kurniawan. Club: Jakarta. Division: Opt. Green Open. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fafe382a-6265-528e-a8f1-5d6bc5f299f8', '042788f4-b092-5ab2-9b14-0835510a2c3a', '47f8796d-8ce6-5568-950d-e90887d9f34a', 'Okshi Kurniawan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '042788f4-b092-5ab2-9b14-0835510a2c3a', 1, 14.0, NULL, true, '(14)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '042788f4-b092-5ab2-9b14-0835510a2c3a', 2, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '042788f4-b092-5ab2-9b14-0835510a2c3a', 3, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '042788f4-b092-5ab2-9b14-0835510a2c3a', 4, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '042788f4-b092-5ab2-9b14-0835510a2c3a', 5, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '042788f4-b092-5ab2-9b14-0835510a2c3a', 6, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '042788f4-b092-5ab2-9b14-0835510a2c3a', 7, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c25815cc-a174-5b86-ba3a-b0c52f44ad1d', 'ab5a65e3-4e47-5cd6-b058-37f8519a1aa7', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'M Adam Farina Bin Guido Farina', 'MAS 9023', 'individual', 13,
    95.0, 55.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: M Adam Farina Bin Guido Farina. Club: Kedah Sailing. Division: Opt. Green Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bee90925-4893-5025-a8d1-106c824ca445', 'c25815cc-a174-5b86-ba3a-b0c52f44ad1d', 'ab5a65e3-4e47-5cd6-b058-37f8519a1aa7', 'M Adam Farina Bin Guido Farina', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c25815cc-a174-5b86-ba3a-b0c52f44ad1d', 1, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c25815cc-a174-5b86-ba3a-b0c52f44ad1d', 2, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c25815cc-a174-5b86-ba3a-b0c52f44ad1d', 3, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c25815cc-a174-5b86-ba3a-b0c52f44ad1d', 4, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c25815cc-a174-5b86-ba3a-b0c52f44ad1d', 5, 18.0, NULL, true, '(18)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c25815cc-a174-5b86-ba3a-b0c52f44ad1d', 6, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c25815cc-a174-5b86-ba3a-b0c52f44ad1d', 7, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5fe9b30b-831b-5af2-a098-66ed976a3645', '029980b2-2fe6-5047-94a9-05fcab48c1b1', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Nadira Septiandini Ponanda', 'INA 1736', 'individual', 14,
    96.0, 62.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Nadira Septiandini Ponanda. Club: TASS. Division: Opt. Green Open. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9e3ec916-2e36-5b41-b5cd-d71af5f6b55b', '5fe9b30b-831b-5af2-a098-66ed976a3645', '029980b2-2fe6-5047-94a9-05fcab48c1b1', 'Nadira Septiandini Ponanda', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5fe9b30b-831b-5af2-a098-66ed976a3645', 1, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5fe9b30b-831b-5af2-a098-66ed976a3645', 2, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5fe9b30b-831b-5af2-a098-66ed976a3645', 3, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5fe9b30b-831b-5af2-a098-66ed976a3645', 4, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5fe9b30b-831b-5af2-a098-66ed976a3645', 5, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5fe9b30b-831b-5af2-a098-66ed976a3645', 6, 17.0, NULL, true, '(17)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5fe9b30b-831b-5af2-a098-66ed976a3645', 7, 17.0, NULL, true, '(17)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4095c148-94cd-5495-af34-e967dcdbfdd2', 'df2d7463-6413-5cc2-82c3-606954ea9852', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Radit Bay Supriyadi', 'SGP 1', 'individual', 15,
    114.0, 70.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Radit Bay Supriyadi. Club: Banten. Division: Opt. Green Open. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2fef94c1-8af2-5e9d-a748-61fc54758eb6', '4095c148-94cd-5495-af34-e967dcdbfdd2', 'df2d7463-6413-5cc2-82c3-606954ea9852', 'Radit Bay Supriyadi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4095c148-94cd-5495-af34-e967dcdbfdd2', 1, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4095c148-94cd-5495-af34-e967dcdbfdd2', 2, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4095c148-94cd-5495-af34-e967dcdbfdd2', 3, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4095c148-94cd-5495-af34-e967dcdbfdd2', 4, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4095c148-94cd-5495-af34-e967dcdbfdd2', 5, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4095c148-94cd-5495-af34-e967dcdbfdd2', 6, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4095c148-94cd-5495-af34-e967dcdbfdd2', 7, 19.0, NULL, false, '19'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '32564475-7a8c-53f0-9c45-f231ff3a6afb', '9bd769b1-94ba-55b9-96c4-9820d777b30b', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Shafar Raditia Ramlan', 'INA 2602', 'individual', 16,
    109.0, 71.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Shafar Raditia Ramlan. Club: Kepri/Kodaeral IV. Division: Opt. Green Open. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '042b9568-0d6c-58f1-b592-826b78cec977', '32564475-7a8c-53f0-9c45-f231ff3a6afb', '9bd769b1-94ba-55b9-96c4-9820d777b30b', 'Shafar Raditia Ramlan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32564475-7a8c-53f0-9c45-f231ff3a6afb', 1, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32564475-7a8c-53f0-9c45-f231ff3a6afb', 2, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32564475-7a8c-53f0-9c45-f231ff3a6afb', 3, 16.0, NULL, true, '(16)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32564475-7a8c-53f0-9c45-f231ff3a6afb', 4, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32564475-7a8c-53f0-9c45-f231ff3a6afb', 5, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32564475-7a8c-53f0-9c45-f231ff3a6afb', 6, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32564475-7a8c-53f0-9c45-f231ff3a6afb', 7, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ceee9f26-cda5-5d29-b0ca-882fa7425c10', '8a5451ff-07c1-5719-b820-b63983c56a20', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Maura Putri Ariski', 'INA 199', 'individual', 17,
    117.0, 73.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Maura Putri Ariski. Club: TASS. Division: Optimist Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e4f2daec-d7d4-5e1b-9a2b-bb642c2e12af', 'ceee9f26-cda5-5d29-b0ca-882fa7425c10', '8a5451ff-07c1-5719-b820-b63983c56a20', 'Maura Putri Ariski', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee9f26-cda5-5d29-b0ca-882fa7425c10', 1, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee9f26-cda5-5d29-b0ca-882fa7425c10', 2, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee9f26-cda5-5d29-b0ca-882fa7425c10', 3, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee9f26-cda5-5d29-b0ca-882fa7425c10', 4, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee9f26-cda5-5d29-b0ca-882fa7425c10', 5, 20.0, NULL, false, '20'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee9f26-cda5-5d29-b0ca-882fa7425c10', 6, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee9f26-cda5-5d29-b0ca-882fa7425c10', 7, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a7fe5c77-ca93-5128-85ee-e01d100334f9', 'e655b076-c7da-5db5-ae87-5b39b6d4f631', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'M. Nidzar A.', 'INA 159', 'individual', 18,
    117.0, 75.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: M. Nidzar A.. Club: TASS. Division: Opt. Green Open. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fb4fb717-11cd-5b6d-ab9b-17ca790927ec', 'a7fe5c77-ca93-5128-85ee-e01d100334f9', 'e655b076-c7da-5db5-ae87-5b39b6d4f631', 'M. Nidzar A.', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7fe5c77-ca93-5128-85ee-e01d100334f9', 1, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7fe5c77-ca93-5128-85ee-e01d100334f9', 2, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7fe5c77-ca93-5128-85ee-e01d100334f9', 3, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7fe5c77-ca93-5128-85ee-e01d100334f9', 4, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7fe5c77-ca93-5128-85ee-e01d100334f9', 5, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7fe5c77-ca93-5128-85ee-e01d100334f9', 6, 20.0, NULL, true, '(20)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7fe5c77-ca93-5128-85ee-e01d100334f9', 7, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9484d8a6-2dc1-5542-973e-ae334784458e', 'fc95de97-5a08-51e2-a8e7-0ecfea24deb3', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Galang Bangkit Ramadhan', '1527', 'individual', 19,
    121.0, 77.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Galang Bangkit Ramadhan. Club: TASS. Division: Optimist Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3963415c-8ada-5b07-b36e-5f53759a5362', '9484d8a6-2dc1-5542-973e-ae334784458e', 'fc95de97-5a08-51e2-a8e7-0ecfea24deb3', 'Galang Bangkit Ramadhan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9484d8a6-2dc1-5542-973e-ae334784458e', 1, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9484d8a6-2dc1-5542-973e-ae334784458e', 2, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9484d8a6-2dc1-5542-973e-ae334784458e', 3, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9484d8a6-2dc1-5542-973e-ae334784458e', 4, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9484d8a6-2dc1-5542-973e-ae334784458e', 5, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9484d8a6-2dc1-5542-973e-ae334784458e', 6, 18.0, NULL, false, '18'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9484d8a6-2dc1-5542-973e-ae334784458e', 7, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1dd70d98-de0f-5c4b-a3c6-7f160573abdc', '2a70b3af-482c-51f3-911a-88760a23d0b5', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Aqila Chan Stevany Sarendeng', 'INA 17', 'individual', 20,
    141.0, 97.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Aqila Chan Stevany Sarendeng. Club: TASS. Division: Opt. Green Open. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ed50916a-0879-55cd-9b44-9719fb939bd9', '1dd70d98-de0f-5c4b-a3c6-7f160573abdc', '2a70b3af-482c-51f3-911a-88760a23d0b5', 'Aqila Chan Stevany Sarendeng', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1dd70d98-de0f-5c4b-a3c6-7f160573abdc', 1, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1dd70d98-de0f-5c4b-a3c6-7f160573abdc', 2, 18.0, NULL, false, '18'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1dd70d98-de0f-5c4b-a3c6-7f160573abdc', 3, 18.0, NULL, false, '18'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1dd70d98-de0f-5c4b-a3c6-7f160573abdc', 4, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1dd70d98-de0f-5c4b-a3c6-7f160573abdc', 5, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1dd70d98-de0f-5c4b-a3c6-7f160573abdc', 6, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1dd70d98-de0f-5c4b-a3c6-7f160573abdc', 7, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2cf9b85c-24a4-5894-946a-92e9dfba516f', '7a5a55f5-0b86-5286-b402-e688c2290b12', '0edbbb2f-1b15-5655-9974-2ab7c4201198', 'Jigme Suharyo', 'INA 118', 'individual', 21,
    144.0, 100.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Jigme Suharyo. Club: TASS. Division: Opt. Green Open. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '826d8085-a458-57de-bd27-c147c572e104', '2cf9b85c-24a4-5894-946a-92e9dfba516f', '7a5a55f5-0b86-5286-b402-e688c2290b12', 'Jigme Suharyo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cf9b85c-24a4-5894-946a-92e9dfba516f', 1, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cf9b85c-24a4-5894-946a-92e9dfba516f', 2, 22.0, 'DNC', true, '(22 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cf9b85c-24a4-5894-946a-92e9dfba516f', 3, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cf9b85c-24a4-5894-946a-92e9dfba516f', 4, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cf9b85c-24a4-5894-946a-92e9dfba516f', 5, 19.0, NULL, false, '19'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cf9b85c-24a4-5894-946a-92e9dfba516f', 6, 19.0, NULL, false, '19'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2cf9b85c-24a4-5894-946a-92e9dfba516f', 7, 18.0, NULL, false, '18'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: INA Regatta II & National Sailing Championship 2026 — ILCA 4
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '7a249f69-c9d0-5a5e-ac36-1c17a4883a9f',
    '3ae81002-0dba-52b3-98e3-9b58715edc32',
    'INA Regatta II & National Sailing Championship 2026 — ILCA 4',
    'ina-regatta-ii-national-sailing-championship-2026-ilca-4',
    '2026-08-23',
    '2026-08-23',
    11,
    'Open',
    7,
    'INA',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'PB. PORLASI / INASAF',
    'published',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'Official Final Results PDF from Indonesian Sailing Federation (PB. PORLASI / INASAF)',
    'Official Indonesian National Championship final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'aa5b88fb-09d2-58dc-8763-0b36c89adc34', 'dd97b0f0-b35f-57b6-9132-61c6ca6a3a21', '7a249f69-c9d0-5a5e-ac36-1c17a4883a9f', 'Rizky Marvel', 'INA 225223', 'individual', 1,
    19.0, 5.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Rizky Marvel. Club: Kepri/Kodaeral IV. Division: ILCA 4 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0afcf8f9-e4b8-5e82-80a3-e0df84bb1c5e', 'aa5b88fb-09d2-58dc-8763-0b36c89adc34', 'dd97b0f0-b35f-57b6-9132-61c6ca6a3a21', 'Rizky Marvel', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa5b88fb-09d2-58dc-8763-0b36c89adc34', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa5b88fb-09d2-58dc-8763-0b36c89adc34', 2, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa5b88fb-09d2-58dc-8763-0b36c89adc34', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa5b88fb-09d2-58dc-8763-0b36c89adc34', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa5b88fb-09d2-58dc-8763-0b36c89adc34', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa5b88fb-09d2-58dc-8763-0b36c89adc34', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa5b88fb-09d2-58dc-8763-0b36c89adc34', 7, 12.0, 'DNC', true, '(12 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9cdb2b77-709c-577f-b55e-3cca3d01cc4a', '77e917ce-5882-50ae-8de1-c03dd228e12b', '7a249f69-c9d0-5a5e-ac36-1c17a4883a9f', 'Adelia Maisyah Adha', '192409', 'individual', 2,
    18.0, 10.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Adelia Maisyah Adha. Club: KALTIM. Division: ILCA 4 Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e1fbdfb8-5ce8-52cf-9ff8-967d82f99eac', '9cdb2b77-709c-577f-b55e-3cca3d01cc4a', '77e917ce-5882-50ae-8de1-c03dd228e12b', 'Adelia Maisyah Adha', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9cdb2b77-709c-577f-b55e-3cca3d01cc4a', 1, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9cdb2b77-709c-577f-b55e-3cca3d01cc4a', 2, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9cdb2b77-709c-577f-b55e-3cca3d01cc4a', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9cdb2b77-709c-577f-b55e-3cca3d01cc4a', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9cdb2b77-709c-577f-b55e-3cca3d01cc4a', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9cdb2b77-709c-577f-b55e-3cca3d01cc4a', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9cdb2b77-709c-577f-b55e-3cca3d01cc4a', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a3da0fc2-3f11-5008-9d14-3232c1995ab1', '619924d0-7a1e-5a51-b479-c9cf8ed63b49', '7a249f69-c9d0-5a5e-ac36-1c17a4883a9f', 'Aurora Cantika Lilo Haqqi', '175899', 'individual', 3,
    29.0, 15.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Aurora Cantika Lilo Haqqi. Club: KOTA BEKASI. Division: ILCA 4 Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '27ab03dd-9329-5764-9097-536b765dba66', 'a3da0fc2-3f11-5008-9d14-3232c1995ab1', '619924d0-7a1e-5a51-b479-c9cf8ed63b49', 'Aurora Cantika Lilo Haqqi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3da0fc2-3f11-5008-9d14-3232c1995ab1', 1, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3da0fc2-3f11-5008-9d14-3232c1995ab1', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3da0fc2-3f11-5008-9d14-3232c1995ab1', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3da0fc2-3f11-5008-9d14-3232c1995ab1', 4, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3da0fc2-3f11-5008-9d14-3232c1995ab1', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3da0fc2-3f11-5008-9d14-3232c1995ab1', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3da0fc2-3f11-5008-9d14-3232c1995ab1', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '649954f3-e705-59d2-8abc-1f134ce9f803', '20f4c63e-751a-500f-bece-db4c3137163f', '7a249f69-c9d0-5a5e-ac36-1c17a4883a9f', 'Fahri Khalfani Akbar', 'INA 221026', 'individual', 4,
    31.0, 17.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Fahri Khalfani Akbar. Club: KOTA BEKASI. Division: ILCA 4 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c0d027a8-e403-561d-ad3e-77451020e1ac', '649954f3-e705-59d2-8abc-1f134ce9f803', '20f4c63e-751a-500f-bece-db4c3137163f', 'Fahri Khalfani Akbar', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '649954f3-e705-59d2-8abc-1f134ce9f803', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '649954f3-e705-59d2-8abc-1f134ce9f803', 2, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '649954f3-e705-59d2-8abc-1f134ce9f803', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '649954f3-e705-59d2-8abc-1f134ce9f803', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '649954f3-e705-59d2-8abc-1f134ce9f803', 5, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '649954f3-e705-59d2-8abc-1f134ce9f803', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '649954f3-e705-59d2-8abc-1f134ce9f803', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2e61fec4-c10c-57fe-ac85-ae5c05ae518e', 'f50d93a6-03cd-5e27-ac1a-1eb365f43f4c', '7a249f69-c9d0-5a5e-ac36-1c17a4883a9f', 'Fiorentino Gabriel Alberto Awuy', '204628', 'individual', 5,
    38.0, 22.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Fiorentino Gabriel Alberto Awuy. Club: KOTA CIMAHI. Division: ILCA 4 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9311ec3b-738c-51cf-b733-59bb7c648834', '2e61fec4-c10c-57fe-ac85-ae5c05ae518e', 'f50d93a6-03cd-5e27-ac1a-1eb365f43f4c', 'Fiorentino Gabriel Alberto Awuy', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e61fec4-c10c-57fe-ac85-ae5c05ae518e', 1, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e61fec4-c10c-57fe-ac85-ae5c05ae518e', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e61fec4-c10c-57fe-ac85-ae5c05ae518e', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e61fec4-c10c-57fe-ac85-ae5c05ae518e', 4, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e61fec4-c10c-57fe-ac85-ae5c05ae518e', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e61fec4-c10c-57fe-ac85-ae5c05ae518e', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e61fec4-c10c-57fe-ac85-ae5c05ae518e', 7, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c4be2b99-062f-5425-9081-ec85302bd3fc', '58b4d139-3c98-5fc1-86de-317be2ebe6c1', '7a249f69-c9d0-5a5e-ac36-1c17a4883a9f', 'Naura Adhara Ariyanto', 'INA 221111', 'individual', 6,
    46.0, 27.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Naura Adhara Ariyanto. Club: JAKARTA. Division: ILCA 4 Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'cc9f8cd7-8f64-594b-9128-93a789f2534a', 'c4be2b99-062f-5425-9081-ec85302bd3fc', '58b4d139-3c98-5fc1-86de-317be2ebe6c1', 'Naura Adhara Ariyanto', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4be2b99-062f-5425-9081-ec85302bd3fc', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4be2b99-062f-5425-9081-ec85302bd3fc', 2, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4be2b99-062f-5425-9081-ec85302bd3fc', 3, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4be2b99-062f-5425-9081-ec85302bd3fc', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4be2b99-062f-5425-9081-ec85302bd3fc', 5, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4be2b99-062f-5425-9081-ec85302bd3fc', 6, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4be2b99-062f-5425-9081-ec85302bd3fc', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c8d6711f-5643-5712-a1cd-32e61ccbb9ca', '9e3cb0fc-ba20-56ce-a13e-c5de907f38a2', '7a249f69-c9d0-5a5e-ac36-1c17a4883a9f', 'Esta Annabil Syarif Revandi', 'INA 220411', 'individual', 7,
    45.0, 28.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Esta Annabil Syarif Revandi. Club: JAKARTA. Division: ILCA 4 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '698b8ef7-ea3c-5d9a-afb9-ee3b23b90560', 'c8d6711f-5643-5712-a1cd-32e61ccbb9ca', '9e3cb0fc-ba20-56ce-a13e-c5de907f38a2', 'Esta Annabil Syarif Revandi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d6711f-5643-5712-a1cd-32e61ccbb9ca', 1, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d6711f-5643-5712-a1cd-32e61ccbb9ca', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d6711f-5643-5712-a1cd-32e61ccbb9ca', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d6711f-5643-5712-a1cd-32e61ccbb9ca', 4, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d6711f-5643-5712-a1cd-32e61ccbb9ca', 5, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d6711f-5643-5712-a1cd-32e61ccbb9ca', 6, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d6711f-5643-5712-a1cd-32e61ccbb9ca', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '50efd142-e7d0-5863-8d8b-fcd774dfd3ef', '7ef183f5-f6dd-5ce7-8d5c-d94d717d8e3e', '7a249f69-c9d0-5a5e-ac36-1c17a4883a9f', 'Surya Tama Saputra', '192408', 'individual', 8,
    53.0, 32.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Surya Tama Saputra. Club: KALTIM. Division: ILCA 4 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c098d156-a53e-551e-90ed-4b34e188b1c8', '50efd142-e7d0-5863-8d8b-fcd774dfd3ef', '7ef183f5-f6dd-5ce7-8d5c-d94d717d8e3e', 'Surya Tama Saputra', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50efd142-e7d0-5863-8d8b-fcd774dfd3ef', 1, 12.0, 'DNC', true, '(12 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50efd142-e7d0-5863-8d8b-fcd774dfd3ef', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50efd142-e7d0-5863-8d8b-fcd774dfd3ef', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50efd142-e7d0-5863-8d8b-fcd774dfd3ef', 4, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50efd142-e7d0-5863-8d8b-fcd774dfd3ef', 5, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50efd142-e7d0-5863-8d8b-fcd774dfd3ef', 6, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50efd142-e7d0-5863-8d8b-fcd774dfd3ef', 7, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a0c7a535-0580-5670-8ca0-7e91c5494277', '2104a554-e16c-5ce4-8bd9-5590a90f271f', '7a249f69-c9d0-5a5e-ac36-1c17a4883a9f', 'Fachrie Aldiansyah', 'INA 209147', 'individual', 9,
    57.0, 33.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Fachrie Aldiansyah. Club: Kepri/Kodaeral IV. Division: ILCA 4 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1a25f2d2-f961-52a9-9de6-5f4f310a6dcb', 'a0c7a535-0580-5670-8ca0-7e91c5494277', '2104a554-e16c-5ce4-8bd9-5590a90f271f', 'Fachrie Aldiansyah', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0c7a535-0580-5670-8ca0-7e91c5494277', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0c7a535-0580-5670-8ca0-7e91c5494277', 2, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0c7a535-0580-5670-8ca0-7e91c5494277', 3, 12.0, 'DNC', true, '(12 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0c7a535-0580-5670-8ca0-7e91c5494277', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0c7a535-0580-5670-8ca0-7e91c5494277', 5, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0c7a535-0580-5670-8ca0-7e91c5494277', 6, 12.0, 'DNC', true, '(12 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0c7a535-0580-5670-8ca0-7e91c5494277', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'cc3025cc-2fb3-57fb-8b1a-d9effc53e6e0', 'c7ea9adb-c8f7-5dbb-8256-a8bb6d70a8d5', '7a249f69-c9d0-5a5e-ac36-1c17a4883a9f', 'Nur Azila', 'INA 198172', 'individual', 10,
    68.0, 44.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Nur Azila. Club: Kepri/Kodaeral IV. Division: ILCA 4 Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e58821d6-7bf9-570e-827f-2cb98edfdedc', 'cc3025cc-2fb3-57fb-8b1a-d9effc53e6e0', 'c7ea9adb-c8f7-5dbb-8256-a8bb6d70a8d5', 'Nur Azila', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc3025cc-2fb3-57fb-8b1a-d9effc53e6e0', 1, 12.0, 'DNC', true, '(12 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc3025cc-2fb3-57fb-8b1a-d9effc53e6e0', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc3025cc-2fb3-57fb-8b1a-d9effc53e6e0', 3, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc3025cc-2fb3-57fb-8b1a-d9effc53e6e0', 4, 12.0, 'DNC', true, '(12 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc3025cc-2fb3-57fb-8b1a-d9effc53e6e0', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc3025cc-2fb3-57fb-8b1a-d9effc53e6e0', 6, 12.0, 'DNC', false, '12 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc3025cc-2fb3-57fb-8b1a-d9effc53e6e0', 7, 12.0, 'DNC', false, '12 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0b7b7131-761e-55f9-a8cd-ad5594917163', '3c15d222-fff0-5e3f-99f7-29321154e5ee', '7a249f69-c9d0-5a5e-ac36-1c17a4883a9f', 'Rizka Tri Aryani', 'INA 193924', 'individual', 11,
    79.0, 55.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Rizka Tri Aryani. Club: Kepri/Kodaeral IV. Division: ILCA 4 Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '65268f17-86a0-5047-9dd3-fde8452319be', '0b7b7131-761e-55f9-a8cd-ad5594917163', '3c15d222-fff0-5e3f-99f7-29321154e5ee', 'Rizka Tri Aryani', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b7b7131-761e-55f9-a8cd-ad5594917163', 1, 12.0, 'DNC', true, '(12 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b7b7131-761e-55f9-a8cd-ad5594917163', 2, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b7b7131-761e-55f9-a8cd-ad5594917163', 3, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b7b7131-761e-55f9-a8cd-ad5594917163', 4, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b7b7131-761e-55f9-a8cd-ad5594917163', 5, 12.0, 'DNC', true, '(12 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b7b7131-761e-55f9-a8cd-ad5594917163', 6, 12.0, 'DNC', false, '12 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b7b7131-761e-55f9-a8cd-ad5594917163', 7, 12.0, 'DNC', false, '12 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: INA Regatta II & National Sailing Championship 2026 — ILCA 6
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '9f22c139-ca52-5eec-b559-6940cf03ea6e',
    '3ae81002-0dba-52b3-98e3-9b58715edc32',
    'INA Regatta II & National Sailing Championship 2026 — ILCA 6',
    'ina-regatta-ii-national-sailing-championship-2026-ilca-6',
    '2026-08-23',
    '2026-08-23',
    13,
    'Open',
    7,
    'INA',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'PB. PORLASI / INASAF',
    'published',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'Official Final Results PDF from Indonesian Sailing Federation (PB. PORLASI / INASAF)',
    'Official Indonesian National Championship final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6032aad4-520a-54b3-8c97-e145da36a020', '79c6406b-143d-542d-a3fc-b8a328b93f96', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'Kirana Wardojo', 'INA 199449', 'individual', 1,
    20.0, 5.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Kirana Wardojo. Club: JATIM. Division: ILCA 6 Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c28d6511-b168-5853-848f-b0d5a41afaae', '6032aad4-520a-54b3-8c97-e145da36a020', '79c6406b-143d-542d-a3fc-b8a328b93f96', 'Kirana Wardojo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6032aad4-520a-54b3-8c97-e145da36a020', 1, 1.0, NULL, true, '(1)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6032aad4-520a-54b3-8c97-e145da36a020', 2, 14.0, 'DNF', true, '(14 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6032aad4-520a-54b3-8c97-e145da36a020', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6032aad4-520a-54b3-8c97-e145da36a020', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6032aad4-520a-54b3-8c97-e145da36a020', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6032aad4-520a-54b3-8c97-e145da36a020', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6032aad4-520a-54b3-8c97-e145da36a020', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a546170b-69fb-5b53-bd43-536cfee4440a', 'e38adb25-9c74-5d2b-b887-a96d9fc2830f', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'Lucky Novriansyah', 'INA 22', 'individual', 2,
    20.0, 10.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Lucky Novriansyah. Club: Kepri/Kodaeral IV. Division: ILCA 6 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f4835835-6221-56dd-b616-135116dee5a8', 'a546170b-69fb-5b53-bd43-536cfee4440a', 'e38adb25-9c74-5d2b-b887-a96d9fc2830f', 'Lucky Novriansyah', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a546170b-69fb-5b53-bd43-536cfee4440a', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a546170b-69fb-5b53-bd43-536cfee4440a', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a546170b-69fb-5b53-bd43-536cfee4440a', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a546170b-69fb-5b53-bd43-536cfee4440a', 4, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a546170b-69fb-5b53-bd43-536cfee4440a', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a546170b-69fb-5b53-bd43-536cfee4440a', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a546170b-69fb-5b53-bd43-536cfee4440a', 7, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '12e3a467-87b6-599d-a8f9-456a80c04465', '56c325d1-c1de-58c4-bfb9-cd55eed8fd8d', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'Rivandi', 'INA 211121', 'individual', 3,
    24.0, 12.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Rivandi. Club: KALTIM. Division: ILCA 6 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '226d0993-b8d6-52e1-a636-6dd0bfdb193c', '12e3a467-87b6-599d-a8f9-456a80c04465', '56c325d1-c1de-58c4-bfb9-cd55eed8fd8d', 'Rivandi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12e3a467-87b6-599d-a8f9-456a80c04465', 1, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12e3a467-87b6-599d-a8f9-456a80c04465', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12e3a467-87b6-599d-a8f9-456a80c04465', 3, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12e3a467-87b6-599d-a8f9-456a80c04465', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12e3a467-87b6-599d-a8f9-456a80c04465', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12e3a467-87b6-599d-a8f9-456a80c04465', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12e3a467-87b6-599d-a8f9-456a80c04465', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4cc19f05-8b1e-5b07-862b-1d73afaf092c', '2fdd39b5-36b1-53bc-a31d-7d2538029c8b', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'Fitri Alwiyah', '221599', 'individual', 4,
    29.0, 18.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Fitri Alwiyah. Club: KOTA BEKASI. Division: ILCA 6 Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '01ea6c0d-9986-5c39-ad23-838909f449a3', '4cc19f05-8b1e-5b07-862b-1d73afaf092c', '2fdd39b5-36b1-53bc-a31d-7d2538029c8b', 'Fitri Alwiyah', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4cc19f05-8b1e-5b07-862b-1d73afaf092c', 1, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4cc19f05-8b1e-5b07-862b-1d73afaf092c', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4cc19f05-8b1e-5b07-862b-1d73afaf092c', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4cc19f05-8b1e-5b07-862b-1d73afaf092c', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4cc19f05-8b1e-5b07-862b-1d73afaf092c', 5, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4cc19f05-8b1e-5b07-862b-1d73afaf092c', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4cc19f05-8b1e-5b07-862b-1d73afaf092c', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c8837018-c363-568e-a14b-a532c392586e', 'f7b5cd3f-a9d1-5b26-926d-005b753ca1d6', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'Jalesveva Divo Ardiansyah', 'INA 217961', 'individual', 5,
    35.0, 21.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Jalesveva Divo Ardiansyah. Club: Kepri/Kodaeral IV. Division: ILCA 6 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '534fceb7-3992-5946-b9e0-ebba08493973', 'c8837018-c363-568e-a14b-a532c392586e', 'f7b5cd3f-a9d1-5b26-926d-005b753ca1d6', 'Jalesveva Divo Ardiansyah', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8837018-c363-568e-a14b-a532c392586e', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8837018-c363-568e-a14b-a532c392586e', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8837018-c363-568e-a14b-a532c392586e', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8837018-c363-568e-a14b-a532c392586e', 4, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8837018-c363-568e-a14b-a532c392586e', 5, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8837018-c363-568e-a14b-a532c392586e', 6, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8837018-c363-568e-a14b-a532c392586e', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a5a01e6a-10a0-5ed5-9102-62380f46b229', '0bfb3cdf-a06a-5595-bd37-748261ad2e94', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'Rezky Adrean', '262021', 'individual', 6,
    35.0, 21.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Rezky Adrean. Club: KOTA BANDUNG. Division: ILCA 6 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f07a8488-5e37-5d28-8efa-a9680cd8ddf9', 'a5a01e6a-10a0-5ed5-9102-62380f46b229', '0bfb3cdf-a06a-5595-bd37-748261ad2e94', 'Rezky Adrean', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5a01e6a-10a0-5ed5-9102-62380f46b229', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5a01e6a-10a0-5ed5-9102-62380f46b229', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5a01e6a-10a0-5ed5-9102-62380f46b229', 3, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5a01e6a-10a0-5ed5-9102-62380f46b229', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5a01e6a-10a0-5ed5-9102-62380f46b229', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5a01e6a-10a0-5ed5-9102-62380f46b229', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5a01e6a-10a0-5ed5-9102-62380f46b229', 7, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b645fd5f-25e6-5b94-85ec-1b1f034f45f5', '95b977f5-b5ec-5b40-9245-e5b5369102b5', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'Alif Apriliano Ariesta', '12', 'individual', 7,
    54.0, 31.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Alif Apriliano Ariesta. Club: KABUPATEN BANDUNG. Division: ILCA 6 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '69050e3a-a796-5b72-86ea-7fe9bfd0ca95', 'b645fd5f-25e6-5b94-85ec-1b1f034f45f5', '95b977f5-b5ec-5b40-9245-e5b5369102b5', 'Alif Apriliano Ariesta', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b645fd5f-25e6-5b94-85ec-1b1f034f45f5', 1, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b645fd5f-25e6-5b94-85ec-1b1f034f45f5', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b645fd5f-25e6-5b94-85ec-1b1f034f45f5', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b645fd5f-25e6-5b94-85ec-1b1f034f45f5', 4, 14.0, 'RET', true, '(14 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b645fd5f-25e6-5b94-85ec-1b1f034f45f5', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b645fd5f-25e6-5b94-85ec-1b1f034f45f5', 6, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b645fd5f-25e6-5b94-85ec-1b1f034f45f5', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9a3d5283-298e-5fd6-990c-44f2097aa681', '822a10e0-6fac-4645-af34-da63ed1597e1', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'David Bagustyo', '7', 'individual', 8,
    57.0, 34.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: David Bagustyo. Club: BANTEN. Division: ILCA 6 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '27982fd6-dcb4-5a1e-a56f-77d47426ef79', '9a3d5283-298e-5fd6-990c-44f2097aa681', '822a10e0-6fac-4645-af34-da63ed1597e1', 'David Bagustyo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a3d5283-298e-5fd6-990c-44f2097aa681', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a3d5283-298e-5fd6-990c-44f2097aa681', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a3d5283-298e-5fd6-990c-44f2097aa681', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a3d5283-298e-5fd6-990c-44f2097aa681', 4, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a3d5283-298e-5fd6-990c-44f2097aa681', 5, 14.0, 'DNC', true, '(14 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a3d5283-298e-5fd6-990c-44f2097aa681', 6, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a3d5283-298e-5fd6-990c-44f2097aa681', 7, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '671d0278-0884-585f-883e-8f7fe0b848e0', '5db2885e-4e93-50f3-a9af-81f72edb79a8', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'Sarmila', 'INA 20', 'individual', 9,
    62.0, 39.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Sarmila. Club: KALTIM. Division: ILCA 6 Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '029aadd8-5225-5ea8-93ce-9e1b32955433', '671d0278-0884-585f-883e-8f7fe0b848e0', '5db2885e-4e93-50f3-a9af-81f72edb79a8', 'Sarmila', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '671d0278-0884-585f-883e-8f7fe0b848e0', 1, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '671d0278-0884-585f-883e-8f7fe0b848e0', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '671d0278-0884-585f-883e-8f7fe0b848e0', 3, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '671d0278-0884-585f-883e-8f7fe0b848e0', 4, 14.0, 'DNC', true, '(14 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '671d0278-0884-585f-883e-8f7fe0b848e0', 5, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '671d0278-0884-585f-883e-8f7fe0b848e0', 6, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '671d0278-0884-585f-883e-8f7fe0b848e0', 7, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bdfec38f-2704-59e9-817e-a44c75a60a5f', '3a05ef10-228f-561b-9395-044f7454b050', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'Amellia', '88', 'individual', 10,
    85.0, 57.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Amellia. Club: JAKARTA. Division: ILCA 6 Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9dcf2559-b161-5628-986d-989940d6a73b', 'bdfec38f-2704-59e9-817e-a44c75a60a5f', '3a05ef10-228f-561b-9395-044f7454b050', 'Amellia', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfec38f-2704-59e9-817e-a44c75a60a5f', 1, 14.0, 'DNC', true, '(14 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfec38f-2704-59e9-817e-a44c75a60a5f', 2, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfec38f-2704-59e9-817e-a44c75a60a5f', 3, 14.0, 'DNC', true, '(14 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfec38f-2704-59e9-817e-a44c75a60a5f', 4, 14.0, 'DNC', false, '14 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfec38f-2704-59e9-817e-a44c75a60a5f', 5, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfec38f-2704-59e9-817e-a44c75a60a5f', 6, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfec38f-2704-59e9-817e-a44c75a60a5f', 7, 14.0, 'DNC', false, '14 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '94cf04f8-8357-569c-a330-6e39f6b41d30', 'f12adeb3-8b1c-5380-a4f7-17c7e2f61321', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'Muhammad Al Jalil Mandala Julyaji', '8', 'individual', 11,
    86.0, 58.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Muhammad Al Jalil Mandala Julyaji. Club: JAKARTA. Division: ILCA 6 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'de8568da-4d1e-5cea-9bf8-5b49303b711d', '94cf04f8-8357-569c-a330-6e39f6b41d30', 'f12adeb3-8b1c-5380-a4f7-17c7e2f61321', 'Muhammad Al Jalil Mandala Julyaji', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '94cf04f8-8357-569c-a330-6e39f6b41d30', 1, 14.0, 'DNC', true, '(14 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '94cf04f8-8357-569c-a330-6e39f6b41d30', 2, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '94cf04f8-8357-569c-a330-6e39f6b41d30', 3, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '94cf04f8-8357-569c-a330-6e39f6b41d30', 4, 14.0, 'DNC', true, '(14 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '94cf04f8-8357-569c-a330-6e39f6b41d30', 5, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '94cf04f8-8357-569c-a330-6e39f6b41d30', 6, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '94cf04f8-8357-569c-a330-6e39f6b41d30', 7, 14.0, 'DNC', false, '14 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5e9e9f7c-3fea-5b18-a5f9-12756c109da9', 'f2d90982-885f-501f-9bdf-a461bffdb701', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'William Woolston', '1', 'individual', 12,
    89.0, 61.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: William Woolston. Club: HORNING SAILING CLUB. Division: ILCA 6 Men. Nat: GBR.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8ecdc440-991c-5d67-8a65-c0cde377fc9e', '5e9e9f7c-3fea-5b18-a5f9-12756c109da9', 'f2d90982-885f-501f-9bdf-a461bffdb701', 'William Woolston', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e9e9f7c-3fea-5b18-a5f9-12756c109da9', 1, 14.0, 'DNC', true, '(14 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e9e9f7c-3fea-5b18-a5f9-12756c109da9', 2, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e9e9f7c-3fea-5b18-a5f9-12756c109da9', 3, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e9e9f7c-3fea-5b18-a5f9-12756c109da9', 4, 14.0, 'DNC', true, '(14 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e9e9f7c-3fea-5b18-a5f9-12756c109da9', 5, 14.0, 'DNC', false, '14 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e9e9f7c-3fea-5b18-a5f9-12756c109da9', 6, 14.0, 'DNC', false, '14 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e9e9f7c-3fea-5b18-a5f9-12756c109da9', 7, 14.0, 'DNC', false, '14 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b782bf57-ef58-58ef-8597-72df38dc6764', '6e7616bc-ec6d-599d-ac46-98d3c5a71d3e', '9f22c139-ca52-5eec-b559-6940cf03ea6e', 'Tora Mirsya Pratama', '227676', 'individual', 13,
    91.0, 63.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Tora Mirsya Pratama. Club: KOARMADA 1. Division: ILCA 6 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '21e23b9b-c263-530a-854a-6a762495c007', 'b782bf57-ef58-58ef-8597-72df38dc6764', '6e7616bc-ec6d-599d-ac46-98d3c5a71d3e', 'Tora Mirsya Pratama', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b782bf57-ef58-58ef-8597-72df38dc6764', 1, 14.0, 'DNC', true, '(14 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b782bf57-ef58-58ef-8597-72df38dc6764', 2, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b782bf57-ef58-58ef-8597-72df38dc6764', 3, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b782bf57-ef58-58ef-8597-72df38dc6764', 4, 14.0, 'DNC', true, '(14 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b782bf57-ef58-58ef-8597-72df38dc6764', 5, 14.0, 'DNC', false, '14 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b782bf57-ef58-58ef-8597-72df38dc6764', 6, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b782bf57-ef58-58ef-8597-72df38dc6764', 7, 14.0, 'DNC', false, '14 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: INA Regatta II & National Sailing Championship 2026 — ILCA 7
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'dfa25f9a-5ede-55b6-99d8-03b4c616659c',
    '3ae81002-0dba-52b3-98e3-9b58715edc32',
    'INA Regatta II & National Sailing Championship 2026 — ILCA 7',
    'ina-regatta-ii-national-sailing-championship-2026-ilca-7',
    '2026-08-23',
    '2026-08-23',
    9,
    'Men',
    7,
    'INA',
    'ILCA 7',
    'individual',
    1,
    1,
    false,
    'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'PB. PORLASI / INASAF',
    'published',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'Official Final Results PDF from Indonesian Sailing Federation (PB. PORLASI / INASAF)',
    'Official Indonesian National Championship final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '535e7037-e5b1-5d3c-906d-73fe540544a3', '24fe9786-c482-527b-86a2-fb20e95ee3dc', 'dfa25f9a-5ede-55b6-99d8-03b4c616659c', 'Ahmad Zainuddin', 'INA 225223', 'individual', 1,
    17.0, 5.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Ahmad Zainuddin. Club: KEPRI/KODAERAL IV. Division: ILCA 7 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9c70ef88-02f7-5bdb-83ed-aadaa4677456', '535e7037-e5b1-5d3c-906d-73fe540544a3', '24fe9786-c482-527b-86a2-fb20e95ee3dc', 'Ahmad Zainuddin', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535e7037-e5b1-5d3c-906d-73fe540544a3', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535e7037-e5b1-5d3c-906d-73fe540544a3', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535e7037-e5b1-5d3c-906d-73fe540544a3', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535e7037-e5b1-5d3c-906d-73fe540544a3', 4, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535e7037-e5b1-5d3c-906d-73fe540544a3', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535e7037-e5b1-5d3c-906d-73fe540544a3', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535e7037-e5b1-5d3c-906d-73fe540544a3', 7, 10.0, 'DNC', true, '(10 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bec6988a-69c6-57c2-a446-1f7327c975b2', 'd2d167b4-52fc-532a-8d72-11ffb103a300', 'dfa25f9a-5ede-55b6-99d8-03b4c616659c', 'Gregory Roger Wardojo', 'INA 201522', 'individual', 2,
    13.0, 8.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Gregory Roger Wardojo. Club: JATIM. Division: ILCA 7 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3bb3fefd-a800-5b99-b8e9-30b13a836ffc', 'bec6988a-69c6-57c2-a446-1f7327c975b2', 'd2d167b4-52fc-532a-8d72-11ffb103a300', 'Gregory Roger Wardojo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bec6988a-69c6-57c2-a446-1f7327c975b2', 1, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bec6988a-69c6-57c2-a446-1f7327c975b2', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bec6988a-69c6-57c2-a446-1f7327c975b2', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bec6988a-69c6-57c2-a446-1f7327c975b2', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bec6988a-69c6-57c2-a446-1f7327c975b2', 5, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bec6988a-69c6-57c2-a446-1f7327c975b2', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bec6988a-69c6-57c2-a446-1f7327c975b2', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'cac41b44-5650-56ec-88c3-919833f58ff4', '4a918f7d-c427-55e5-abec-73934c37a54f', 'dfa25f9a-5ede-55b6-99d8-03b4c616659c', 'Sujatmiko Siswanto', '221121', 'individual', 3,
    23.0, 15.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Sujatmiko Siswanto. Club: KOTA BANDUNG. Division: ILCA 7 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c188325a-52ee-5ea7-9022-858da41a3a79', 'cac41b44-5650-56ec-88c3-919833f58ff4', '4a918f7d-c427-55e5-abec-73934c37a54f', 'Sujatmiko Siswanto', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cac41b44-5650-56ec-88c3-919833f58ff4', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cac41b44-5650-56ec-88c3-919833f58ff4', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cac41b44-5650-56ec-88c3-919833f58ff4', 3, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cac41b44-5650-56ec-88c3-919833f58ff4', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cac41b44-5650-56ec-88c3-919833f58ff4', 5, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cac41b44-5650-56ec-88c3-919833f58ff4', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cac41b44-5650-56ec-88c3-919833f58ff4', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd08299eb-e061-5bf9-8b2b-61cd0e29ed77', '99e8004d-8b84-5e8e-809d-ee3f9d8573be', 'dfa25f9a-5ede-55b6-99d8-03b4c616659c', 'Samsuardi', '6', 'individual', 4,
    28.0, 18.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Samsuardi. Club: KOTA BANDUNG. Division: ILCA 7 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a2ea4434-d509-543e-b074-9bd4fafca471', 'd08299eb-e061-5bf9-8b2b-61cd0e29ed77', '99e8004d-8b84-5e8e-809d-ee3f9d8573be', 'Samsuardi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd08299eb-e061-5bf9-8b2b-61cd0e29ed77', 1, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd08299eb-e061-5bf9-8b2b-61cd0e29ed77', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd08299eb-e061-5bf9-8b2b-61cd0e29ed77', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd08299eb-e061-5bf9-8b2b-61cd0e29ed77', 4, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd08299eb-e061-5bf9-8b2b-61cd0e29ed77', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd08299eb-e061-5bf9-8b2b-61cd0e29ed77', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd08299eb-e061-5bf9-8b2b-61cd0e29ed77', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '467cd492-7cf8-5a41-934f-80fa1fafedc6', '2c76ae25-c4e6-5bdd-8ef4-a1935ef47fcf', 'dfa25f9a-5ede-55b6-99d8-03b4c616659c', 'Alif Thaariq Sutrisno', '200998', 'individual', 5,
    29.0, 19.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Alif Thaariq Sutrisno. Club: SULAWESI SELATAN. Division: ILCA 7 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8f1ea015-0f25-5da8-81c2-fff5767b2e1e', '467cd492-7cf8-5a41-934f-80fa1fafedc6', '2c76ae25-c4e6-5bdd-8ef4-a1935ef47fcf', 'Alif Thaariq Sutrisno', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '467cd492-7cf8-5a41-934f-80fa1fafedc6', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '467cd492-7cf8-5a41-934f-80fa1fafedc6', 2, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '467cd492-7cf8-5a41-934f-80fa1fafedc6', 3, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '467cd492-7cf8-5a41-934f-80fa1fafedc6', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '467cd492-7cf8-5a41-934f-80fa1fafedc6', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '467cd492-7cf8-5a41-934f-80fa1fafedc6', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '467cd492-7cf8-5a41-934f-80fa1fafedc6', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2efc27c9-5631-564f-bead-8ca8eb253fa7', '70a60989-1817-53fb-b3fb-dab26afd9815', 'dfa25f9a-5ede-55b6-99d8-03b4c616659c', 'Aditya Rama Dani', '60', 'individual', 6,
    44.0, 29.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Aditya Rama Dani. Club: KOARMADA I/JAKARTA. Division: ILCA 7 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ce1ab124-08bf-5030-8d61-f1f7351f3edd', '2efc27c9-5631-564f-bead-8ca8eb253fa7', '70a60989-1817-53fb-b3fb-dab26afd9815', 'Aditya Rama Dani', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2efc27c9-5631-564f-bead-8ca8eb253fa7', 1, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2efc27c9-5631-564f-bead-8ca8eb253fa7', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2efc27c9-5631-564f-bead-8ca8eb253fa7', 3, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2efc27c9-5631-564f-bead-8ca8eb253fa7', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2efc27c9-5631-564f-bead-8ca8eb253fa7', 5, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2efc27c9-5631-564f-bead-8ca8eb253fa7', 6, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2efc27c9-5631-564f-bead-8ca8eb253fa7', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6c1790d1-5b36-50fa-8947-e942aa7ad1b7', '5128047f-c7fb-5412-890c-b21a4ddabec3', 'dfa25f9a-5ede-55b6-99d8-03b4c616659c', 'Kevin Julyo Aldafa', '221579', 'individual', 7,
    52.0, 32.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Kevin Julyo Aldafa. Club: KOTA BEKASI. Division: ILCA 7 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2d74f247-0b91-5e44-a31e-d6dd4cd4fe29', '6c1790d1-5b36-50fa-8947-e942aa7ad1b7', '5128047f-c7fb-5412-890c-b21a4ddabec3', 'Kevin Julyo Aldafa', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c1790d1-5b36-50fa-8947-e942aa7ad1b7', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c1790d1-5b36-50fa-8947-e942aa7ad1b7', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c1790d1-5b36-50fa-8947-e942aa7ad1b7', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c1790d1-5b36-50fa-8947-e942aa7ad1b7', 4, 10.0, 'DNC', true, '(10 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c1790d1-5b36-50fa-8947-e942aa7ad1b7', 5, 10.0, 'DNC', true, '(10 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c1790d1-5b36-50fa-8947-e942aa7ad1b7', 6, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c1790d1-5b36-50fa-8947-e942aa7ad1b7', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd1bf27ab-1c55-5c9c-b638-cc4f8a3ed2f7', '0951d7ed-7faf-4fab-a660-ca9bb034dc4d', 'dfa25f9a-5ede-55b6-99d8-03b4c616659c', 'Omar Agoes', '209145', 'individual', 8,
    65.0, 45.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Omar Agoes. Club: TLSC. Division: ILCA 7 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd048dde2-05ff-5fc1-9a32-6cd06e7e5308', 'd1bf27ab-1c55-5c9c-b638-cc4f8a3ed2f7', '0951d7ed-7faf-4fab-a660-ca9bb034dc4d', 'Omar Agoes', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd1bf27ab-1c55-5c9c-b638-cc4f8a3ed2f7', 1, 10.0, 'DNC', true, '(10 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd1bf27ab-1c55-5c9c-b638-cc4f8a3ed2f7', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd1bf27ab-1c55-5c9c-b638-cc4f8a3ed2f7', 3, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd1bf27ab-1c55-5c9c-b638-cc4f8a3ed2f7', 4, 10.0, 'DNC', true, '(10 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd1bf27ab-1c55-5c9c-b638-cc4f8a3ed2f7', 5, 10.0, 'DNC', false, '10 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd1bf27ab-1c55-5c9c-b638-cc4f8a3ed2f7', 6, 10.0, 'DNC', false, '10 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd1bf27ab-1c55-5c9c-b638-cc4f8a3ed2f7', 7, 10.0, 'DNC', false, '10 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0ef04019-9a01-59b5-b195-ed3748e7a68e', '380d05db-dc36-5fd2-9f90-5ff5737ea25f', 'dfa25f9a-5ede-55b6-99d8-03b4c616659c', 'Bagus Susanto', '80', 'individual', 9,
    70.0, 50.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Bagus Susanto. Club: KOARMADA 1. Division: ILCA 7 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'cbb00205-5092-5a98-934f-12332bc9ece9', '0ef04019-9a01-59b5-b195-ed3748e7a68e', '380d05db-dc36-5fd2-9f90-5ff5737ea25f', 'Bagus Susanto', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef04019-9a01-59b5-b195-ed3748e7a68e', 1, 10.0, 'DNC', true, '(10 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef04019-9a01-59b5-b195-ed3748e7a68e', 2, 10.0, 'DNC', true, '(10 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef04019-9a01-59b5-b195-ed3748e7a68e', 3, 10.0, 'DNC', false, '10 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef04019-9a01-59b5-b195-ed3748e7a68e', 4, 10.0, 'DNC', false, '10 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef04019-9a01-59b5-b195-ed3748e7a68e', 5, 10.0, 'DNC', false, '10 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef04019-9a01-59b5-b195-ed3748e7a68e', 6, 10.0, 'DNC', false, '10 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef04019-9a01-59b5-b195-ed3748e7a68e', 7, 10.0, 'DNC', false, '10 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: INA Regatta II & National Sailing Championship 2026 — Techno 293
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'b55258c5-6f5f-5ae2-9bcb-9101ef0e8ca2',
    '3ae81002-0dba-52b3-98e3-9b58715edc32',
    'INA Regatta II & National Sailing Championship 2026 — Techno 293',
    'ina-regatta-ii-national-sailing-championship-2026-techno-293',
    '2026-08-23',
    '2026-08-23',
    10,
    'Open',
    8,
    'INA',
    'Techno 293',
    'individual',
    1,
    1,
    false,
    'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'PB. PORLASI / INASAF',
    'published',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'Official Final Results PDF from Indonesian Sailing Federation (PB. PORLASI / INASAF)',
    'Official Indonesian National Championship final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '05b4e379-3e5b-53ff-9293-718940643760', 'cf0cc0cf-d9fa-413c-9f08-8b5f78a1c258', 'b55258c5-6f5f-5ae2-9bcb-9101ef0e8ca2', 'Trevor Ng Zong Yang', 'SGP 45', 'individual', 1,
    16.0, 8.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Trevor Ng Zong Yang. Club: Singapore Sailing. Division: Techno 293 Men. Nat: SGP.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f7e1edbf-cdd9-5bef-a2f1-2ffa4ea12551', '05b4e379-3e5b-53ff-9293-718940643760', 'cf0cc0cf-d9fa-413c-9f08-8b5f78a1c258', 'Trevor Ng Zong Yang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05b4e379-3e5b-53ff-9293-718940643760', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05b4e379-3e5b-53ff-9293-718940643760', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05b4e379-3e5b-53ff-9293-718940643760', 3, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05b4e379-3e5b-53ff-9293-718940643760', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05b4e379-3e5b-53ff-9293-718940643760', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05b4e379-3e5b-53ff-9293-718940643760', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05b4e379-3e5b-53ff-9293-718940643760', 7, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05b4e379-3e5b-53ff-9293-718940643760', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7fc93ae8-26e1-598f-9473-566f83b51e48', '0e39559e-ec8e-52d6-91c5-47dba0b6a2e1', 'b55258c5-6f5f-5ae2-9bcb-9101ef0e8ca2', 'Achmad Rafa Abyas', 'INA 15', 'individual', 2,
    23.0, 10.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Achmad Rafa Abyas. Club: Jakarta. Division: Techno 293 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2d98ca6e-9986-564b-bf4c-2bba06bbd8e4', '7fc93ae8-26e1-598f-9473-566f83b51e48', '0e39559e-ec8e-52d6-91c5-47dba0b6a2e1', 'Achmad Rafa Abyas', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7fc93ae8-26e1-598f-9473-566f83b51e48', 1, 11.0, 'DNC', true, '(11 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7fc93ae8-26e1-598f-9473-566f83b51e48', 2, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7fc93ae8-26e1-598f-9473-566f83b51e48', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7fc93ae8-26e1-598f-9473-566f83b51e48', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7fc93ae8-26e1-598f-9473-566f83b51e48', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7fc93ae8-26e1-598f-9473-566f83b51e48', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7fc93ae8-26e1-598f-9473-566f83b51e48', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7fc93ae8-26e1-598f-9473-566f83b51e48', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd132c13a-60f7-5146-bace-febb15d75875', 'd5b73423-e2a1-558b-829c-44b824606225', 'b55258c5-6f5f-5ae2-9bcb-9101ef0e8ca2', 'Addy Armand Bin Anuar', 'SGP 143', 'individual', 3,
    28.0, 19.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Addy Armand Bin Anuar. Club: Singapore Sailing. Division: Techno 293 Men. Nat: SGP.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c0638d5f-61bc-596c-8a9f-f9edefdca28a', 'd132c13a-60f7-5146-bace-febb15d75875', 'd5b73423-e2a1-558b-829c-44b824606225', 'Addy Armand Bin Anuar', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd132c13a-60f7-5146-bace-febb15d75875', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd132c13a-60f7-5146-bace-febb15d75875', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd132c13a-60f7-5146-bace-febb15d75875', 3, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd132c13a-60f7-5146-bace-febb15d75875', 4, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd132c13a-60f7-5146-bace-febb15d75875', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd132c13a-60f7-5146-bace-febb15d75875', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd132c13a-60f7-5146-bace-febb15d75875', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd132c13a-60f7-5146-bace-febb15d75875', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4f1626a2-1e26-58ae-8fc0-121fb6efeba6', '1a7d2b71-08c8-4ff7-88ea-de5b56a90c65', 'b55258c5-6f5f-5ae2-9bcb-9101ef0e8ca2', 'Qi Shan', 'SGP 26', 'individual', 4,
    49.0, 27.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Qi Shan. Club: Singapore Sailing. Division: Techno 293 Women. Nat: SGP.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fa64ce13-445b-585d-b323-78fac185c45a', '4f1626a2-1e26-58ae-8fc0-121fb6efeba6', '1a7d2b71-08c8-4ff7-88ea-de5b56a90c65', 'Qi Shan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f1626a2-1e26-58ae-8fc0-121fb6efeba6', 1, 11.0, 'DNC', true, '(11 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f1626a2-1e26-58ae-8fc0-121fb6efeba6', 2, 11.0, 'RET', true, '(11 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f1626a2-1e26-58ae-8fc0-121fb6efeba6', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f1626a2-1e26-58ae-8fc0-121fb6efeba6', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f1626a2-1e26-58ae-8fc0-121fb6efeba6', 5, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f1626a2-1e26-58ae-8fc0-121fb6efeba6', 6, 11.0, 'DNC', false, '11 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f1626a2-1e26-58ae-8fc0-121fb6efeba6', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f1626a2-1e26-58ae-8fc0-121fb6efeba6', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '120aba3f-693c-54ee-9c53-9e0ebaf92dbc', '840ea47b-9173-43dc-a513-3b841b17497b', 'b55258c5-6f5f-5ae2-9bcb-9101ef0e8ca2', 'Kate Teo', 'SGP 87', 'individual', 5,
    41.0, 28.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Kate Teo. Club: Singapore Sailing. Division: Techno 293 Women. Nat: SGP.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b0de32d2-6fa4-58a2-b65c-974a34f43ca2', '120aba3f-693c-54ee-9c53-9e0ebaf92dbc', '840ea47b-9173-43dc-a513-3b841b17497b', 'Kate Teo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '120aba3f-693c-54ee-9c53-9e0ebaf92dbc', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '120aba3f-693c-54ee-9c53-9e0ebaf92dbc', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '120aba3f-693c-54ee-9c53-9e0ebaf92dbc', 3, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '120aba3f-693c-54ee-9c53-9e0ebaf92dbc', 4, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '120aba3f-693c-54ee-9c53-9e0ebaf92dbc', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '120aba3f-693c-54ee-9c53-9e0ebaf92dbc', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '120aba3f-693c-54ee-9c53-9e0ebaf92dbc', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '120aba3f-693c-54ee-9c53-9e0ebaf92dbc', 8, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8741aadf-d935-5634-ad2c-5e4ce6c55c63', '4453abbe-f8e7-5d87-9968-f6b202564385', 'b55258c5-6f5f-5ae2-9bcb-9101ef0e8ca2', 'Nazwa Anggraeni', 'INA 1', 'individual', 6,
    52.0, 30.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Nazwa Anggraeni. Club: Jakarta. Division: Techno 293 Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6f52f6b3-0949-5368-b178-721493f92306', '8741aadf-d935-5634-ad2c-5e4ce6c55c63', '4453abbe-f8e7-5d87-9968-f6b202564385', 'Nazwa Anggraeni', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8741aadf-d935-5634-ad2c-5e4ce6c55c63', 1, 11.0, 'DNC', true, '(11 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8741aadf-d935-5634-ad2c-5e4ce6c55c63', 2, 11.0, 'DNC', true, '(11 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8741aadf-d935-5634-ad2c-5e4ce6c55c63', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8741aadf-d935-5634-ad2c-5e4ce6c55c63', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8741aadf-d935-5634-ad2c-5e4ce6c55c63', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8741aadf-d935-5634-ad2c-5e4ce6c55c63', 6, 11.0, 'DNC', false, '11 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8741aadf-d935-5634-ad2c-5e4ce6c55c63', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8741aadf-d935-5634-ad2c-5e4ce6c55c63', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b105a827-f515-5f43-921f-7400c0f5cce4', '6601496b-5734-5e04-8f54-b2cea50e1606', 'b55258c5-6f5f-5ae2-9bcb-9101ef0e8ca2', 'Adhelia Khanza Al Naira', 'INA 7', 'individual', 7,
    68.0, 46.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Adhelia Khanza Al Naira. Club: Jakarta. Division: Techno 293 Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '302fe29a-00bd-5126-b631-aec4d23a0faf', 'b105a827-f515-5f43-921f-7400c0f5cce4', '6601496b-5734-5e04-8f54-b2cea50e1606', 'Adhelia Khanza Al Naira', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b105a827-f515-5f43-921f-7400c0f5cce4', 1, 11.0, 'DNC', true, '(11 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b105a827-f515-5f43-921f-7400c0f5cce4', 2, 11.0, 'DNC', true, '(11 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b105a827-f515-5f43-921f-7400c0f5cce4', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b105a827-f515-5f43-921f-7400c0f5cce4', 4, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b105a827-f515-5f43-921f-7400c0f5cce4', 5, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b105a827-f515-5f43-921f-7400c0f5cce4', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b105a827-f515-5f43-921f-7400c0f5cce4', 7, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b105a827-f515-5f43-921f-7400c0f5cce4', 8, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6d484ade-aa5b-587f-b879-bbe2bd15ef0d', 'eb1b0682-c7ec-5b39-bbac-f9bdbfc42c63', 'b55258c5-6f5f-5ae2-9bcb-9101ef0e8ca2', 'Berly Yasta Muammar', 'INA 8', 'individual', 8,
    73.0, 51.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Berly Yasta Muammar. Club: Banten. Division: Techno 293 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '514c3b2a-9082-565d-80c9-662252bbaf75', '6d484ade-aa5b-587f-b879-bbe2bd15ef0d', 'eb1b0682-c7ec-5b39-bbac-f9bdbfc42c63', 'Berly Yasta Muammar', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d484ade-aa5b-587f-b879-bbe2bd15ef0d', 1, 11.0, 'DNC', true, '(11 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d484ade-aa5b-587f-b879-bbe2bd15ef0d', 2, 11.0, 'DNC', true, '(11 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d484ade-aa5b-587f-b879-bbe2bd15ef0d', 3, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d484ade-aa5b-587f-b879-bbe2bd15ef0d', 4, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d484ade-aa5b-587f-b879-bbe2bd15ef0d', 5, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d484ade-aa5b-587f-b879-bbe2bd15ef0d', 6, 11.0, 'DNC', false, '11 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d484ade-aa5b-587f-b879-bbe2bd15ef0d', 7, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d484ade-aa5b-587f-b879-bbe2bd15ef0d', 8, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1bb2c5d9-f85d-5b41-8417-d3017c2e6dd4', '04869a26-6a15-5515-9c1c-99159fbba7f7', 'b55258c5-6f5f-5ae2-9bcb-9101ef0e8ca2', 'Zulfikri Ilham', '29', 'individual', 9,
    75.0, 53.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Zulfikri Ilham. Club: Kaltim. Division: Techno 293 Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a7995553-e024-527d-a78a-d7e09a62a37e', '1bb2c5d9-f85d-5b41-8417-d3017c2e6dd4', '04869a26-6a15-5515-9c1c-99159fbba7f7', 'Zulfikri Ilham', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bb2c5d9-f85d-5b41-8417-d3017c2e6dd4', 1, 11.0, 'DNC', true, '(11 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bb2c5d9-f85d-5b41-8417-d3017c2e6dd4', 2, 11.0, 'DNC', true, '(11 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bb2c5d9-f85d-5b41-8417-d3017c2e6dd4', 3, 11.0, 'DNC', false, '11 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bb2c5d9-f85d-5b41-8417-d3017c2e6dd4', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bb2c5d9-f85d-5b41-8417-d3017c2e6dd4', 5, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bb2c5d9-f85d-5b41-8417-d3017c2e6dd4', 6, 11.0, 'DNC', false, '11 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bb2c5d9-f85d-5b41-8417-d3017c2e6dd4', 7, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bb2c5d9-f85d-5b41-8417-d3017c2e6dd4', 8, 11.0, 'DNC', false, '11 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd9a1432a-e8bd-5160-9006-5b9e142e956a', '85e1af27-1243-5d47-8fe3-c9dd19f14882', 'b55258c5-6f5f-5ae2-9bcb-9101ef0e8ca2', 'Marcus Thye', 'SGP 417', 'individual', 10,
    84.0, 62.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Marcus Thye. Club: Constant Wind. Division: Techno 293 Men. Nat: SGP.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e4297788-a032-5526-827b-c1c7605bf1cd', 'd9a1432a-e8bd-5160-9006-5b9e142e956a', '85e1af27-1243-5d47-8fe3-c9dd19f14882', 'Marcus Thye', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a1432a-e8bd-5160-9006-5b9e142e956a', 1, 11.0, 'DNC', true, '(11 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a1432a-e8bd-5160-9006-5b9e142e956a', 2, 11.0, 'DNC', true, '(11 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a1432a-e8bd-5160-9006-5b9e142e956a', 3, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a1432a-e8bd-5160-9006-5b9e142e956a', 4, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a1432a-e8bd-5160-9006-5b9e142e956a', 5, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a1432a-e8bd-5160-9006-5b9e142e956a', 6, 11.0, 'DNC', false, '11 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a1432a-e8bd-5160-9006-5b9e142e956a', 7, 11.0, 'DNC', false, '11 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a1432a-e8bd-5160-9006-5b9e142e956a', 8, 11.0, 'DNC', false, '11 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: INA Regatta II & National Sailing Championship 2026 — Techno 293 Plus
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '30360e7c-71d5-5af2-b212-96928ff207a1',
    '3ae81002-0dba-52b3-98e3-9b58715edc32',
    'INA Regatta II & National Sailing Championship 2026 — Techno 293 Plus',
    'ina-regatta-ii-national-sailing-championship-2026-techno-293-plus',
    '2026-08-23',
    '2026-08-23',
    6,
    'Plus',
    8,
    'INA',
    'Techno 293',
    'individual',
    1,
    1,
    false,
    'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'PB. PORLASI / INASAF',
    'published',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'Official Final Results PDF from Indonesian Sailing Federation (PB. PORLASI / INASAF)',
    'Official Indonesian National Championship final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3040ffb5-a94b-547a-b7b5-3c7054885411', 'f051bd59-1744-53ff-86d7-c3658f8aeb41', '30360e7c-71d5-5af2-b212-96928ff207a1', 'Afriza Achmad Bagaskara', 'INA 81', 'individual', 1,
    9.0, 6.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Afriza Achmad Bagaskara. Club: Jakarta. Division: Techno 293 Plus Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4072890b-3ddd-588b-b2ad-27acc365af05', '3040ffb5-a94b-547a-b7b5-3c7054885411', 'f051bd59-1744-53ff-86d7-c3658f8aeb41', 'Afriza Achmad Bagaskara', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3040ffb5-a94b-547a-b7b5-3c7054885411', 1, 1.0, NULL, true, '(1)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3040ffb5-a94b-547a-b7b5-3c7054885411', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3040ffb5-a94b-547a-b7b5-3c7054885411', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3040ffb5-a94b-547a-b7b5-3c7054885411', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3040ffb5-a94b-547a-b7b5-3c7054885411', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3040ffb5-a94b-547a-b7b5-3c7054885411', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3040ffb5-a94b-547a-b7b5-3c7054885411', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3040ffb5-a94b-547a-b7b5-3c7054885411', 8, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '16be9cd2-ed36-58c8-bb8c-89fad2c25e6a', 'b3763d38-e350-5d3d-b944-789ae4af5234', '30360e7c-71d5-5af2-b212-96928ff207a1', 'Syafira Zahra Aulia', 'INA 18', 'individual', 2,
    17.0, 11.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Syafira Zahra Aulia. Club: Jakarta. Division: Techno 293 Plus Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '640ddbdf-fe60-5ce0-9c53-1682ac886b15', '16be9cd2-ed36-58c8-bb8c-89fad2c25e6a', 'b3763d38-e350-5d3d-b944-789ae4af5234', 'Syafira Zahra Aulia', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16be9cd2-ed36-58c8-bb8c-89fad2c25e6a', 1, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16be9cd2-ed36-58c8-bb8c-89fad2c25e6a', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16be9cd2-ed36-58c8-bb8c-89fad2c25e6a', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16be9cd2-ed36-58c8-bb8c-89fad2c25e6a', 4, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16be9cd2-ed36-58c8-bb8c-89fad2c25e6a', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16be9cd2-ed36-58c8-bb8c-89fad2c25e6a', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16be9cd2-ed36-58c8-bb8c-89fad2c25e6a', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16be9cd2-ed36-58c8-bb8c-89fad2c25e6a', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ecdafc3c-6849-5049-a80d-054b167b240c', '44b23788-36d2-585f-937c-29cc15e99268', '30360e7c-71d5-5af2-b212-96928ff207a1', 'Aulia Jumata Savani', 'INA 111', 'individual', 3,
    35.0, 21.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Aulia Jumata Savani. Club: Kaltim. Division: Techno 293 Plus Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '009502c4-7fb2-516c-9ca1-4397c9a87ff4', 'ecdafc3c-6849-5049-a80d-054b167b240c', '44b23788-36d2-585f-937c-29cc15e99268', 'Aulia Jumata Savani', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ecdafc3c-6849-5049-a80d-054b167b240c', 1, 7.0, 'DNC', true, '(7 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ecdafc3c-6849-5049-a80d-054b167b240c', 2, 7.0, 'DNC', true, '(7 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ecdafc3c-6849-5049-a80d-054b167b240c', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ecdafc3c-6849-5049-a80d-054b167b240c', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ecdafc3c-6849-5049-a80d-054b167b240c', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ecdafc3c-6849-5049-a80d-054b167b240c', 6, 7.0, 'DNC', false, '7 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ecdafc3c-6849-5049-a80d-054b167b240c', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ecdafc3c-6849-5049-a80d-054b167b240c', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '37e606eb-91a3-55f5-b6bb-a41a22b2b3c9', 'b256f1da-0142-5233-9b44-afd7bdf5ece6', '30360e7c-71d5-5af2-b212-96928ff207a1', 'Muhammad Fachry Rizky', '12', 'individual', 4,
    39.0, 25.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Muhammad Fachry Rizky. Club: Kota Bekasi. Division: Techno 293 Plus Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '62876a8a-d145-5fe8-8a80-f864fd3532a6', '37e606eb-91a3-55f5-b6bb-a41a22b2b3c9', 'b256f1da-0142-5233-9b44-afd7bdf5ece6', 'Muhammad Fachry Rizky', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e606eb-91a3-55f5-b6bb-a41a22b2b3c9', 1, 7.0, 'DNC', true, '(7 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e606eb-91a3-55f5-b6bb-a41a22b2b3c9', 2, 7.0, 'DNC', true, '(7 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e606eb-91a3-55f5-b6bb-a41a22b2b3c9', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e606eb-91a3-55f5-b6bb-a41a22b2b3c9', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e606eb-91a3-55f5-b6bb-a41a22b2b3c9', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e606eb-91a3-55f5-b6bb-a41a22b2b3c9', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e606eb-91a3-55f5-b6bb-a41a22b2b3c9', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e606eb-91a3-55f5-b6bb-a41a22b2b3c9', 8, 7.0, 'DNC', false, '7 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '74983d64-7e73-5046-bcbd-c298e5d1eae1', '9961a814-f254-550e-855d-7e1da2e02c56', '30360e7c-71d5-5af2-b212-96928ff207a1', 'Febrian Eka Ss.', 'INA 89', 'individual', 5,
    49.0, 35.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Febrian Eka Ss.. Club: TASS. Division: Techno 293 Plus Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'cee4204f-8ee8-5403-915c-9e1ae7f998ae', '74983d64-7e73-5046-bcbd-c298e5d1eae1', '9961a814-f254-550e-855d-7e1da2e02c56', 'Febrian Eka Ss.', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74983d64-7e73-5046-bcbd-c298e5d1eae1', 1, 7.0, 'DNC', true, '(7 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74983d64-7e73-5046-bcbd-c298e5d1eae1', 2, 7.0, 'DNC', true, '(7 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74983d64-7e73-5046-bcbd-c298e5d1eae1', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74983d64-7e73-5046-bcbd-c298e5d1eae1', 4, 7.0, 'DNC', false, '7 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74983d64-7e73-5046-bcbd-c298e5d1eae1', 5, 7.0, 'DNC', false, '7 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74983d64-7e73-5046-bcbd-c298e5d1eae1', 6, 7.0, 'DNC', false, '7 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74983d64-7e73-5046-bcbd-c298e5d1eae1', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74983d64-7e73-5046-bcbd-c298e5d1eae1', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'aa0d4e1a-226b-55a6-8db8-86588523910a', '0b3ce018-152f-512f-a38e-522c15834c51', '30360e7c-71d5-5af2-b212-96928ff207a1', 'Ahmad Jaini', 'INA 79', 'individual', 6,
    56.0, 42.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Ahmad Jaini. Club: Kaltim. Division: Techno 293 Plus Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ff46bb3c-deda-5886-8b8c-71c8706f182d', 'aa0d4e1a-226b-55a6-8db8-86588523910a', '0b3ce018-152f-512f-a38e-522c15834c51', 'Ahmad Jaini', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0d4e1a-226b-55a6-8db8-86588523910a', 1, 7.0, 'DNC', true, '(7 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0d4e1a-226b-55a6-8db8-86588523910a', 2, 7.0, 'DNC', true, '(7 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0d4e1a-226b-55a6-8db8-86588523910a', 3, 7.0, 'DNC', false, '7 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0d4e1a-226b-55a6-8db8-86588523910a', 4, 7.0, 'DNC', false, '7 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0d4e1a-226b-55a6-8db8-86588523910a', 5, 7.0, 'DNC', false, '7 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0d4e1a-226b-55a6-8db8-86588523910a', 6, 7.0, 'DNC', false, '7 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0d4e1a-226b-55a6-8db8-86588523910a', 7, 7.0, 'DNC', false, '7 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0d4e1a-226b-55a6-8db8-86588523910a', 8, 7.0, 'DNC', false, '7 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: INA Regatta II & National Sailing Championship 2026 — iQFoil
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '35197547-199f-56b4-a0e3-76424fdcc0da',
    '3ae81002-0dba-52b3-98e3-9b58715edc32',
    'INA Regatta II & National Sailing Championship 2026 — iQFoil',
    'ina-regatta-ii-national-sailing-championship-2026-iqfoil',
    '2026-08-23',
    '2026-08-23',
    4,
    'Open',
    8,
    'INA',
    'iQFoil',
    'individual',
    1,
    1,
    false,
    'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'PB. PORLASI / INASAF',
    'published',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'Official Final Results PDF from Indonesian Sailing Federation (PB. PORLASI / INASAF)',
    'Official Indonesian National Championship final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '191ff022-de77-5ddb-b10a-88e9aa224d8a', 'fd52c255-ed1b-5530-8abb-a20fd11f9368', '35197547-199f-56b4-a0e3-76424fdcc0da', 'Dexy Priany', '1', 'individual', 1,
    12.0, 6.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Dexy Priany. Club: Banten. Division: IQ Foil Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c2aedcca-483f-5459-baa2-4fc040fc5fff', '191ff022-de77-5ddb-b10a-88e9aa224d8a', 'fd52c255-ed1b-5530-8abb-a20fd11f9368', 'Dexy Priany', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '191ff022-de77-5ddb-b10a-88e9aa224d8a', 1, 1.0, NULL, true, '(1)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '191ff022-de77-5ddb-b10a-88e9aa224d8a', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '191ff022-de77-5ddb-b10a-88e9aa224d8a', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '191ff022-de77-5ddb-b10a-88e9aa224d8a', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '191ff022-de77-5ddb-b10a-88e9aa224d8a', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '191ff022-de77-5ddb-b10a-88e9aa224d8a', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '191ff022-de77-5ddb-b10a-88e9aa224d8a', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '191ff022-de77-5ddb-b10a-88e9aa224d8a', 8, 5.0, 'DNS', true, '(5 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0de35819-0786-52a4-aad7-5c2bf5c05f1a', 'f7b979a3-0779-5c32-b82c-ec571b67f1f2', '35197547-199f-56b4-a0e3-76424fdcc0da', 'Alifah Auralia', 'INA 99', 'individual', 2,
    22.0, 14.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Alifah Auralia. Club: Jakarta. Division: IQ Foil Women. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3c777631-f5af-59ae-9303-e536cd1d37e9', '0de35819-0786-52a4-aad7-5c2bf5c05f1a', 'f7b979a3-0779-5c32-b82c-ec571b67f1f2', 'Alifah Auralia', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0de35819-0786-52a4-aad7-5c2bf5c05f1a', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0de35819-0786-52a4-aad7-5c2bf5c05f1a', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0de35819-0786-52a4-aad7-5c2bf5c05f1a', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0de35819-0786-52a4-aad7-5c2bf5c05f1a', 4, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0de35819-0786-52a4-aad7-5c2bf5c05f1a', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0de35819-0786-52a4-aad7-5c2bf5c05f1a', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0de35819-0786-52a4-aad7-5c2bf5c05f1a', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0de35819-0786-52a4-aad7-5c2bf5c05f1a', 8, 5.0, 'DNS', true, '(5 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ea35701a-1b27-5f1f-b956-9edbdea2d6ad', 'fce87a61-25ad-5b6c-b5db-eff5b29b4f66', '35197547-199f-56b4-a0e3-76424fdcc0da', 'Roy Zulfadli Bahri', 'INA 38', 'individual', 3,
    24.0, 15.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Roy Zulfadli Bahri. Club: Kaltim. Division: IQ Foil Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5f5f3688-9394-50a9-8486-db76aa35fb3b', 'ea35701a-1b27-5f1f-b956-9edbdea2d6ad', 'fce87a61-25ad-5b6c-b5db-eff5b29b4f66', 'Roy Zulfadli Bahri', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea35701a-1b27-5f1f-b956-9edbdea2d6ad', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea35701a-1b27-5f1f-b956-9edbdea2d6ad', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea35701a-1b27-5f1f-b956-9edbdea2d6ad', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea35701a-1b27-5f1f-b956-9edbdea2d6ad', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea35701a-1b27-5f1f-b956-9edbdea2d6ad', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea35701a-1b27-5f1f-b956-9edbdea2d6ad', 6, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea35701a-1b27-5f1f-b956-9edbdea2d6ad', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea35701a-1b27-5f1f-b956-9edbdea2d6ad', 8, 5.0, 'DNS', true, '(5 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c90df46c-16e1-5857-9181-e4c701697869', '02615641-6db6-5a32-ad5f-354820d39ce0', '35197547-199f-56b4-a0e3-76424fdcc0da', 'Saitama Junjungan Simanjuntak', 'INA 35', 'individual', 4,
    36.0, 26.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Sailor: Saitama Junjungan Simanjuntak. Club: Jakarta. Division: IQ Foil Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4597285e-9c4a-56b6-a98e-e0422a91e0b3', 'c90df46c-16e1-5857-9181-e4c701697869', '02615641-6db6-5a32-ad5f-354820d39ce0', 'Saitama Junjungan Simanjuntak', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c90df46c-16e1-5857-9181-e4c701697869', 1, 5.0, 'DNC', true, '(5 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c90df46c-16e1-5857-9181-e4c701697869', 2, 5.0, 'DNC', true, '(5 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c90df46c-16e1-5857-9181-e4c701697869', 3, 5.0, 'DNC', false, '5 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c90df46c-16e1-5857-9181-e4c701697869', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c90df46c-16e1-5857-9181-e4c701697869', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c90df46c-16e1-5857-9181-e4c701697869', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c90df46c-16e1-5857-9181-e4c701697869', 7, 5.0, 'DNC', false, '5 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c90df46c-16e1-5857-9181-e4c701697869', 8, 5.0, 'DNS', false, '5 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 420
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '2c469f79-4f6c-5691-a2f5-85dae334ede4',
    '3ae81002-0dba-52b3-98e3-9b58715edc32',
    'INA Regatta II & National Sailing Championship 2026 — 420',
    'ina-regatta-ii-national-sailing-championship-2026-420',
    '2026-08-23',
    '2026-08-23',
    5,
    'Open',
    8,
    'INA',
    '420',
    'crew',
    2,
    2,
    false,
    'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'PB. PORLASI / INASAF',
    'published',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'Official Final Results PDF from Indonesian Sailing Federation (PB. PORLASI / INASAF)',
    'Official Indonesian National Championship final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'eeaf9dd3-4b02-562a-9fb4-9094d0e82429', '0da77a16-919d-5fdd-a00a-832f70de8620', '2c469f79-4f6c-5691-a2f5-85dae334ede4', 'M Adhit & Andi M Faruq', 'INA 57240', 'crew', 1,
    14.0, 9.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Boat: KALTIM 57240. Helm: M Adhit, Crew: Andi M Faruq. Club: KALTIM.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e597560b-8e32-5d73-9ffd-f3b5848ce885', 'eeaf9dd3-4b02-562a-9fb4-9094d0e82429', '0da77a16-919d-5fdd-a00a-832f70de8620', 'M Adhit', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c5ba9114-1df9-5fb9-8087-3ef052fc0c28', 'eeaf9dd3-4b02-562a-9fb4-9094d0e82429', '5c8d2c22-f00f-576f-b797-e407431f282f', 'Andi M Faruq', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eeaf9dd3-4b02-562a-9fb4-9094d0e82429', 1, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eeaf9dd3-4b02-562a-9fb4-9094d0e82429', 2, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eeaf9dd3-4b02-562a-9fb4-9094d0e82429', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eeaf9dd3-4b02-562a-9fb4-9094d0e82429', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eeaf9dd3-4b02-562a-9fb4-9094d0e82429', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eeaf9dd3-4b02-562a-9fb4-9094d0e82429', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eeaf9dd3-4b02-562a-9fb4-9094d0e82429', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eeaf9dd3-4b02-562a-9fb4-9094d0e82429', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c7947eb3-12eb-5018-8303-59237f0f8802', 'ea4e4440-b236-5f9c-bd6d-d54b6d55b49a', '2c469f79-4f6c-5691-a2f5-85dae334ede4', 'Alya & Hafizhah Ramadhani H', '10', 'crew', 2,
    20.0, 11.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Boat: KALTIM 10. Helm: Alya, Crew: Hafizhah Ramadhani H. Club: KALTIM.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '11065851-1d38-58db-8e27-c615d2eb1027', 'c7947eb3-12eb-5018-8303-59237f0f8802', 'ea4e4440-b236-5f9c-bd6d-d54b6d55b49a', 'Alya', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '87dfc701-6c27-5786-97e3-9859a028fd27', 'c7947eb3-12eb-5018-8303-59237f0f8802', '0a35f645-13fa-584b-b382-7c59d21438a7', 'Hafizhah Ramadhani H', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7947eb3-12eb-5018-8303-59237f0f8802', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7947eb3-12eb-5018-8303-59237f0f8802', 2, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7947eb3-12eb-5018-8303-59237f0f8802', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7947eb3-12eb-5018-8303-59237f0f8802', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7947eb3-12eb-5018-8303-59237f0f8802', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7947eb3-12eb-5018-8303-59237f0f8802', 6, 6.0, 'DNC', true, '(6 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7947eb3-12eb-5018-8303-59237f0f8802', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7947eb3-12eb-5018-8303-59237f0f8802', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd33484cc-432b-5ae1-8cf2-9b09fb31e2ec', '2d82caa4-e947-5ac2-9cee-00603f1b8a35', '2c469f79-4f6c-5691-a2f5-85dae334ede4', 'Kinara Prisha D & Azaleya Tifani P', 'INA 65404', 'crew', 3,
    19.0, 12.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Boat: JAKARTA 65404. Helm: Kinara Prisha D, Crew: Azaleya Tifani P. Club: JAKARTA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0345d524-c241-55d7-a6f4-3d38b46df47b', 'd33484cc-432b-5ae1-8cf2-9b09fb31e2ec', '2d82caa4-e947-5ac2-9cee-00603f1b8a35', 'Kinara Prisha D', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '94da504c-4140-5888-a837-c3a64824e4d5', 'd33484cc-432b-5ae1-8cf2-9b09fb31e2ec', '462759d5-09af-555d-a8ed-0c619cc7f72b', 'Azaleya Tifani P', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd33484cc-432b-5ae1-8cf2-9b09fb31e2ec', 1, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd33484cc-432b-5ae1-8cf2-9b09fb31e2ec', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd33484cc-432b-5ae1-8cf2-9b09fb31e2ec', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd33484cc-432b-5ae1-8cf2-9b09fb31e2ec', 4, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd33484cc-432b-5ae1-8cf2-9b09fb31e2ec', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd33484cc-432b-5ae1-8cf2-9b09fb31e2ec', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd33484cc-432b-5ae1-8cf2-9b09fb31e2ec', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd33484cc-432b-5ae1-8cf2-9b09fb31e2ec', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'dc2acfba-ff5a-54bb-ac3c-fad5da5be4b3', '5c7e1959-8451-58b6-8288-1e5050a99cdd', '2c469f79-4f6c-5691-a2f5-85dae334ede4', 'Safira Zaliyanti & Ratu Sri AW', 'INA 888', 'crew', 4,
    31.0, 22.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Boat: BANTEN 888. Helm: Safira Zaliyanti, Crew: Ratu Sri AW. Club: BANTEN.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b160879c-177a-5d52-9f8b-1d528fb384e1', 'dc2acfba-ff5a-54bb-ac3c-fad5da5be4b3', '5c7e1959-8451-58b6-8288-1e5050a99cdd', 'Safira Zaliyanti', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b99e15b3-483d-5ecb-ae35-33d2633d5087', 'dc2acfba-ff5a-54bb-ac3c-fad5da5be4b3', 'aca44d87-5e1e-5f36-b253-2cfd7a11ac35', 'Ratu Sri AW', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc2acfba-ff5a-54bb-ac3c-fad5da5be4b3', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc2acfba-ff5a-54bb-ac3c-fad5da5be4b3', 2, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc2acfba-ff5a-54bb-ac3c-fad5da5be4b3', 3, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc2acfba-ff5a-54bb-ac3c-fad5da5be4b3', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc2acfba-ff5a-54bb-ac3c-fad5da5be4b3', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc2acfba-ff5a-54bb-ac3c-fad5da5be4b3', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc2acfba-ff5a-54bb-ac3c-fad5da5be4b3', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc2acfba-ff5a-54bb-ac3c-fad5da5be4b3', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'eb3fb2d2-fee8-52b6-8ad5-200ca249047c', '145c0ac3-b906-5479-8387-3c2791049071', '2c469f79-4f6c-5691-a2f5-85dae334ede4', 'Zevan Adriansah & Mujaya', 'INA 50389', 'crew', 5,
    40.0, 28.0, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', 'INA Regatta II 2026. Boat: JAKARTA 50389. Helm: Zevan Adriansah, Crew: Mujaya. Club: JAKARTA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7407f58e-c800-5d0a-8633-e4f20cf5b260', 'eb3fb2d2-fee8-52b6-8ad5-200ca249047c', '145c0ac3-b906-5479-8387-3c2791049071', 'Zevan Adriansah', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'eba5bf92-fa4a-552c-88f3-09979ff43936', 'eb3fb2d2-fee8-52b6-8ad5-200ca249047c', 'b3b191f7-de7a-5536-942e-e14c13f740a5', 'Mujaya', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb3fb2d2-fee8-52b6-8ad5-200ca249047c', 1, 6.0, 'DNC', true, '(6 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb3fb2d2-fee8-52b6-8ad5-200ca249047c', 2, 6.0, 'DNC', true, '(6 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb3fb2d2-fee8-52b6-8ad5-200ca249047c', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb3fb2d2-fee8-52b6-8ad5-200ca249047c', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb3fb2d2-fee8-52b6-8ad5-200ca249047c', 5, 6.0, 'DNC', false, '6 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb3fb2d2-fee8-52b6-8ad5-200ca249047c', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb3fb2d2-fee8-52b6-8ad5-200ca249047c', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb3fb2d2-fee8-52b6-8ad5-200ca249047c', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- 5. Admin Change Log Record
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'regattas.import_championships',
  'regatta',
  '3ae81002-0dba-52b3-98e3-9b58715edc32',
  'INA Regatta II & National Sailing Championship 2026',
  'Imported premier Indonesian National Sailing Championship across 8 fleets (Optimist, ILCA 4, ILCA 6, ILCA 7, 420, Techno 293, Techno 293 Plus, iQFoil) totaling 79 entries and 578 race scores from official INASAF PDF.',
  jsonb_build_object(
    'country', 'INA',
    'fleets_count', 8,
    'total_entries', 79,
    'new_profiles_created', 75,
    'total_race_scores', 578,
    'status', 'published'
  ),
  'migration_170',
  clock_timestamp()
);

COMMIT;
