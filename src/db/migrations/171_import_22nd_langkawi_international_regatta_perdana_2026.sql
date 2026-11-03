-- Migration 171: Import 22nd Langkawi International Regatta Perdana 2026 across 7 classes
--
-- Imports the official championship results for Malaysia's premier international youth regatta:
-- Event: 22nd Langkawi International Regatta Perdana 2026 (LIRP 2026)
-- Dates: 8–12 February 2026 · Venue: National Sailing Centre, Langkawi, Kedah, Malaysia
-- Organizing Authority: Kedah Sailing Association & Malaysia Sailing Association (MSA)
-- Official Sources: Official Final Results PDFs from Kedah Sailing Association / MSA Google Drive archive
--
-- Classes Imported (14 sheets across 7 permitted classes):
-- 1. 29er OPEN: 6 boats (12 sailors), 12 races, 2 discards
-- 2. INT 420 MEN: 7 boats (14 sailors), 12 races, 2 discards
-- 3. INT 420 WOMEN: 6 boats (12 sailors), 12 races, 2 discards
-- 4. ILCA 7: 14 sailors, 12 races, 2 discards
-- 5. iQFoil OPEN MEN: 4 sailors, 12 races, 2 discards
-- 6. iQFoil OPEN WOMEN: 3 sailors, 12 races, 2 discards
-- 7. Techno 293 MEN: 5 sailors, 11 races, 2 discards
-- 8. Techno 293 WOMEN: 3 sailors, 11 races, 2 discards
-- 9. Techno 293 Plus MEN: 3 sailors, 11 races, 2 discards
-- 10. Techno 293 Plus WOMEN: 2 sailors, 11 races, 2 discards
-- 11. ILCA 4 MEN: 16 sailors, 12 races, 2 discards
-- 12. ILCA 4 WOMEN: 13 sailors, 12 races, 2 discards
-- 13. ILCA 6 MEN: 11 sailors, 12 races, 2 discards
-- 14. ILCA 6 WOMEN: 11 sailors, 12 races, 2 discards
--
-- All operations execute in a single atomic transaction.

BEGIN;

-- 1. Insert New Verified Sailor Profiles
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '20149ed1-32c2-50e1-8a97-ac52f1f046b9', 'Nor Izniey Humaira Binti Mohd Azri', 'nor-izniey-humaira-binti-mohd-azri-eed512', '2487', 'MSN/MSA', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1a026605-01b2-5c06-adf6-665ad5d89ef1', 'Aina Zulaikha Binti Azizul Rahman', 'aina-zulaikha-binti-azizul-rahman-b16713', '2487', 'MSN/MSA', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f6095146-c267-5a59-a60a-c86b7cbcb5be', 'Mohamad Hazmi Bin Suwandy', 'mohamad-hazmi-bin-suwandy-732d82', '1', 'MSN/MSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '95b20b9e-fe72-5617-ba01-e55da0c048f8', 'Alif Nur Bin Amzi', 'alif-nur-bin-amzi-83c519', '1', 'MSN/MSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f69c3030-ab08-5bfd-8037-74c8e4696b72', 'Muhammad Adam Aierell Bin Moh Azizol Amirul', 'muhammad-adam-aierell-bin-moh-azizol-amirul-ab5402', '50', 'MSN/MSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'dc9f6965-7f57-5e89-9077-1faee0afb764', 'Miss Patcharaphan Ongploy', 'miss-patcharaphan-ongploy-55bc4c', '621', 'YRAT', 'THA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '86f5a930-4f9a-5f9e-b24d-6389c66465f0', 'Chung Jihyeok', 'chung-jihyeok-d4d30e', '1412', 'BSC(KOREA)', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2489ba3e-0f35-5218-9c00-35eb0a75a894', 'Seo Minjun', 'seo-minjun-17a057', '1412', 'BSC(KOREA)', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9e4c2cd7-24d6-51e0-8d7e-5e6d91ee137a', 'Muhammad Idris Bin Mohd Zahawi', 'muhammad-idris-bin-mohd-zahawi-84825e', '57346', 'MSNT-TSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '580a0306-cd4c-548f-a98c-38bde8e7846c', 'Muhammad Nazmi Qusyairi Bin Mohd Nazri', 'muhammad-nazmi-qusyairi-bin-mohd-nazri-a30b8a', '57346', 'MSNT-TSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9ab6cba2-69ff-5905-b4c5-cb4dcd8e6ade', 'Danyal Marczqui Rahmat Haron Muzaffar', 'danyal-marczqui-rahmat-haron-muzaffar-ff5253', '55957', 'MSN/MSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6333c43d-c279-5dcd-bc41-3f247a3afbc9', 'Atthakit Thuaythong', 'atthakit-thuaythong-e8ffec', 'JPN 57009', 'YRAT', 'THA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd09b7f61-8e4b-58e0-bfa9-21af32b8fb1b', 'Muhammad Zafrin Bin Mohd Zailan', 'muhammad-zafrin-bin-mohd-zailan-2e4940', '22', 'SELANGOR', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '459011bb-ba27-5414-a9bc-17b0634b85a9', 'Muhammad Zulhelmie Haqimi Bin Zulkifli', 'muhammad-zulhelmie-haqimi-bin-zulkifli-b178d6', '22', 'SELANGOR', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c9df556b-7b8e-5944-92c8-0cc863207d9b', 'Muhammad Yusri Bin Syahrizan', 'muhammad-yusri-bin-syahrizan-637c0a', '56051', 'MSN SARAWAK', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5b9e6612-96be-592e-bd9b-06b558b96f63', 'Muhammad Abrisam Athmar Bin Aslan', 'muhammad-abrisam-athmar-bin-aslan-b604fa', '56051', 'MSN SARAWAK', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '143cd50a-0f51-5d01-ac67-4dcf1f4277b5', 'Nur Asma Balqis Binti Rosli', 'nur-asma-balqis-binti-rosli-7bb0de', '55154', 'MSN/MSA', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0ad44896-4a70-528f-88ea-a31f0f6d6538', 'Bibi Qeesha Binti Mohd Faizal', 'bibi-qeesha-binti-mohd-faizal-12432a', 'SIN 54882', 'SABAH', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c963bbb1-0fa2-57f1-a0aa-721928f29e55', 'Natasha Wong See Kei', 'natasha-wong-see-kei-9ad426', 'SIN 54882', 'SABAH', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a246e2ce-5bfd-5212-b021-99a80151b1b0', 'Amni Nur Afifa Binti Mohd Azlan', 'amni-nur-afifa-binti-mohd-azlan-3f6004', '56300 D', 'MSNT-TSA', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c9237bd5-7570-5213-80d8-e56a8d3bffdb', 'Nik Haiqal Danial Bin Nik Muhazarin', 'nik-haiqal-danial-bin-nik-muhazarin-af8fc2', '56300 D', 'MSNT-TSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7d79261f-75e1-5069-a10e-567d9c9816f3', 'Nur Aqilah Raifana Binti Aslan', 'nur-aqilah-raifana-binti-aslan-0728ef', '56054', 'MSN SARAWAK', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f1d035dc-2510-5f18-a6d0-09b8f9827d52', 'Nur Asma Binti Syahrizan', 'nur-asma-binti-syahrizan-32b7c4', '56054', 'MSN SARAWAK', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '516aec8c-41fd-5ebf-90ad-bea9af92a244', 'Nur Ain Batrisyia Binti Azhar', 'nur-ain-batrisyia-binti-azhar-cd6bdd', '54393', 'MS PAHANG', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '330ced97-e136-541a-811b-f9000a2b9eaa', 'Nur Qaseh Qistiena Binti Mohd Husney', 'nur-qaseh-qistiena-binti-mohd-husney-529a91', '9999', 'MSNK/KSA', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '840a648e-eddd-5158-800a-b1018f9d31b2', 'Kanitha Inthanu', 'kanitha-inthanu-caf534', '9999', 'MSNK/KSA', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bd3ea917-2821-539f-a858-91ae716fa34b', 'Muhammad Faizal Bin Ahmad Asri', 'muhammad-faizal-bin-ahmad-asri-161bbd', '209883', 'MSN/MSA/PODIUM', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '35dc95b9-784f-52ac-b416-5e485d68a8f8', 'Brandan Richard Peter Wright', 'brandan-richard-peter-wright-834190', '217837', 'MSNK/KSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '57a1f9c5-bf57-5654-85a6-68f16b64ab40', 'Muhammad Zafir Bin Mohd Zailan', 'muhammad-zafir-bin-mohd-zailan-491436', '207095', 'SELANGOR', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bcf5dfcc-5bea-5f87-8080-564805c9695e', 'Haziem Hakimi Bin Edie Akbar', 'haziem-hakimi-bin-edie-akbar-21c942', '197851', 'MS PAHANG', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '514fc284-f5a5-5aae-a8ce-956a6303df8d', 'Ahmad Farel Bin Arham', 'ahmad-farel-bin-arham-ff0513', '221056', 'MSNT-TSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '91927627-a2be-5b01-a357-134fe82679f9', 'Adam Iwan Carraz', 'adam-iwan-carraz-728f9d', '150757', 'SABAH', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'dffe8ea9-f134-5a78-9fc2-e7837c01e591', 'Fikri Izzan Bin Zamri', 'fikri-izzan-bin-zamri-5c6062', '210597', 'MSN SARAWAK', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd5950089-a98b-528b-83d6-3582f48dacb9', 'Yim Woojun', 'yim-woojun-50190e', '8', 'BSC(KOREA)', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0fc23dd4-3434-5e78-8767-25afc8afdc87', 'Imman Nazhim Bin Musmuliadi', 'imman-nazhim-bin-musmuliadi-81872b', '211027', 'MSNK/KSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6bd0387e-8eca-5194-8c1b-2427ec2bd6aa', 'Mohd. Nofalzul Iqma Bin Fazelillah', 'mohd-nofalzul-iqma-bin-fazelillah-736267', '2', 'TLDM', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e5d0c092-9144-5e09-be5f-f19eb008c85a', 'Muhammad Amir Asyraf Bin Mohd Aziz', 'muhammad-amir-asyraf-bin-mohd-aziz-139418', '197225', 'MELAKA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e69480ac-aad2-5a19-9d13-26d3fe8c437a', 'Ku Muhammad Amirul Haziq Bin Ku Halid', 'ku-muhammad-amirul-haziq-bin-ku-halid-dc754b', '138629', 'TLDM', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '551f1e67-9740-5f26-a69b-499f09d63471', 'Andrei Tugade', 'andrei-tugade-3dd314', '295', 'PWA', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'efbd9517-2dd8-5c0b-8e29-3642c9e1c338', 'Wachirawit Manbumrung', 'wachirawit-manbumrung-0fa200', '51', 'WATH', 'THA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7a7426a9-fa00-5658-8afd-bda6025ff56c', 'I Gusti Putra Padantya Sulaksana', 'i-gusti-putra-padantya-sulaksana-43c2f7', '11', 'EAST BALI SURF & SAIL', 'INA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'dc53f7b9-6c62-5b56-a8af-126c740c3310', 'Phatchara Nari', 'phatchara-nari-f1aa77', '27', 'WATH', 'THA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4ca37d74-db0e-5a1c-9986-d6fd6a9407c4', 'Alfionnah Mae Gonzalez', 'alfionnah-mae-gonzalez-647369', '14', 'PWA', 'PHI', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0f664096-c007-56a0-9edc-c7226be5a9da', 'Kelsy Loryn Moreno', 'kelsy-loryn-moreno-610e28', '12', 'PWA', 'PHI', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ff3dc58d-9647-5239-aa5f-455b53ac35f5', 'Marcella Wilson Villaceran', 'marcella-wilson-villaceran-67954c', '23', 'MSA/MSN', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c4a8af93-b344-5b96-a9e4-bef4c6f0107b', 'Suphachai Chueatathong', 'suphachai-chueatathong-5b302c', '31', 'WATH', 'THA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5480f138-dccf-5c68-82da-1fd7dcbcba63', 'Rayyan Mirza Bin Azman', 'rayyan-mirza-bin-azman-f40970', '95', 'MSNK/KSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '011d13b6-d2d8-5942-b777-ecb1272110f8', 'Riyadh Adief Bin Rozaidi', 'riyadh-adief-bin-rozaidi-7d105a', '96', 'MSNK/KSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5e56bd58-f094-5e35-8761-403ce2c7a21d', 'Ammar Danish Bin Khairul Azhar', 'ammar-danish-bin-khairul-azhar-71535d', '71', 'MS PAHANG', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5870de79-63ef-5d28-b060-c8774a0e4b73', 'Kornkanya Pantong', 'kornkanya-pantong-9f2cd6', '17', 'WATH', 'THA', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3b38fb75-d880-5e44-8a3d-9426188f06a2', 'Hayfa Maryam Bin Dzul Azwardi Shah', 'hayfa-maryam-bin-dzul-azwardi-shah-131982', '70', 'MS PAHANG', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '682eeb1b-9e9a-5b3f-b346-0f6d17c46d60', 'Hadelia Amani', 'hadelia-amani-ed5d0e', 'K7', 'KSA/MSNK', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bf5455bc-c310-5bc1-85f1-372889e90934', 'Suphachok Chueatathong', 'suphachok-chueatathong-a9c657', '999', 'WATH', 'THA', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fb14cb2c-b4dd-5f8c-a74c-1f5fd93579ed', 'Khian Cuerdo', 'khian-cuerdo-70fb54', '30', 'PWA', 'PHI', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '76df8c8f-3f8a-5cfb-80e1-84aa077aca71', 'Muhammad Syahzwan Bin Jefri', 'muhammad-syahzwan-bin-jefri-52baf4', '111', 'PERLIS', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3f0aaa81-cb50-567d-bf36-63f802d41cf5', 'Tengku Nurani Ezaty Binti Tengku Kahirudeen', 'tengku-nurani-ezaty-binti-tengku-kahirudeen-7148a1', '20', 'MSN/MSA', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '59a84a2b-7c8f-5e7f-b925-06665d607191', 'Angie Tan Ang Yee', 'angie-tan-ang-yee-286832', '3', 'MSNT-TSA', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4ab81121-eed4-5d26-84a0-7c233e31bc6d', 'Muhammad Hilfi Nafael Bin Mohd Hasrizan', 'muhammad-hilfi-nafael-bin-mohd-hasrizan-e99361', '209886', 'MSN/MSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3f8e7331-d3fe-56d2-b62d-14b9f485452b', 'Haziq Mustaqim Bin Mohd Husni', 'haziq-mustaqim-bin-mohd-husni-5807f0', '221056', 'MSNT-TSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '48f7a683-cf70-51e3-932a-e1544f08f6cd', 'Xu Xiaoring', 'xu-xiaoring-1b016c', '221877', 'XIAMEN', 'CHN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a55b0e5b-682d-5fe8-ae8f-2f3b0bed2dc8', 'Muhammad Adam Firdaus Bin Zainal Abidin', 'muhammad-adam-firdaus-bin-zainal-abidin-116f6a', '207094', 'SELANGOR', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7c98de8c-7b60-5fa7-a90e-d8349ed96b86', 'Muhammad Hadif Nabihan Bin Rashidi', 'muhammad-hadif-nabihan-bin-rashidi-a1d4c5', '206792', 'PERLIS', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3b8c9fed-9111-5e5a-b0e7-8dadc53d2511', 'Muhammad Haikal Iskandar B. Haironizam', 'muhammad-haikal-iskandar-b-haironizam-b8f86c', '210226', 'MSN PERAK', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '979f1f91-dfb2-58aa-a17a-44293382c34d', 'Muhammad Izzul Arshad Bin Zulkarnain', 'muhammad-izzul-arshad-bin-zulkarnain-93d778', '225710', 'MS PAHANG', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0cb5bbd8-bae4-5988-953b-e9ea98e6ba02', 'Muhammad Ammar Zikri Bin Azman', 'muhammad-ammar-zikri-bin-azman-7a7c39', '213185', 'MSNT-TSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0289f4b4-118b-5f4b-962b-f4fc5428021a', 'Lee Buhyun', 'lee-buhyun-2f7e36', '224677', 'BSC(KOREA)', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '76f020a1-6591-53a2-81c4-e1e638505628', 'Awallymuiz Bin Mohzeiswandi', 'awallymuiz-bin-mohzeiswandi-243f34', '222439', 'MSN PENANG', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7717423d-94bb-572a-b3c6-ddb37b67576c', 'Muhammad Khalish Kashfi Bin Mohd Husney', 'muhammad-khalish-kashfi-bin-mohd-husney-1715a8', '206796', 'MSNK/KSA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e1eedc58-7114-5046-b317-4d3184ae1118', 'Gene Fu Fengkai', 'gene-fu-fengkai-50229c', '225956', 'CHINA', 'CHN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '59978bb7-0c9a-5e65-85de-bd7153301709', 'Lee Songha', 'lee-songha-ccef17', '223204', 'KSAF', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e7045456-266c-5f5a-a7b9-4f95ac17f66c', 'Dhaifina Natallia Binti Shazlisham', 'dhaifina-natallia-binti-shazlisham-d88c95', '213186', 'MSNT-TSA', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd583f482-a971-5f83-abb1-8d1f42cc7974', 'Humaira Qurratulaini Bt. Muhamad Arief', 'humaira-qurratulaini-bt-muhamad-arief-d6762f', '210227', 'MSN PERAK', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '52fc293d-43c5-5ab1-bb46-15406e652607', 'Nur Amina Fatehah Binti Azmi', 'nur-amina-fatehah-binti-azmi-056e73', '215061', 'MSNK/KSA', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '36daa0e1-333c-5f4c-b5c1-435e38c6f948', 'Nur ''Ain Binti Syahrizan', 'nur-ain-binti-syahrizan-d5fbe7', '210602', 'MSN SARAWAK', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bd617971-6ff4-55f2-9542-f0705b8a72f4', 'Aisya Farisya Binti Mohd Aziran', 'aisya-farisya-binti-mohd-aziran-410587', '221057', 'MSNT-TSA', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f6623824-d20b-5439-a53c-8af02181a014', 'Huahg Chenyue', 'huahg-chenyue-5aef54', '218507', 'XIAMEN', 'CHN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6f1134e3-125c-5b25-b2a8-91fa7c37971d', 'Nur Elena Zahra Binti Mohd Azrin', 'nur-elena-zahra-binti-mohd-azrin-4b34b2', '204323', 'SELANGOR', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bb3a2667-c68d-5c1e-a0c9-571847f45b70', 'Mas Vanya Kirstyn Teruki', 'mas-vanya-kirstyn-teruki-dc6cae', '210603', 'MSN SARAWAK', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '63f8a7e1-71cd-550c-a3b7-07ae06cde9f9', 'Eva Maria Medyna Binti Norzaimy', 'eva-maria-medyna-binti-norzaimy-c9b78d', 'TBD', 'MSN PENANG', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8aabfea9-a419-5648-9b0d-b07ce894ea6e', 'Ammar Bin Azali', 'ammar-bin-azali-7ca298', '227279', 'PERLIS', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bba09e45-d786-5773-9694-800d0641f833', 'Afwan Bin Amir Harun', 'afwan-bin-amir-harun-1f820b', '840545', 'PPTLDM', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '709a793b-9bc0-5708-89e4-18afc8c48d2d', 'Farish Hanif Bin Zamri', 'farish-hanif-bin-zamri-f09846', '210607', 'MSN SARAWAK', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c76a1a28-6931-5653-97a8-2b91b0daec03', 'Danish Zafran Bin Rozali', 'danish-zafran-bin-rozali-6ccaf5', '197854', 'SELANGOR', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '92ede04b-c400-57fd-928d-2852566682aa', 'Karl Brady', 'karl-brady-9fa299', '193112', 'SSCA', 'GBR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8c4234ba-4e3a-5322-afcf-c8b9818adc0d', 'Amirul Zikry Bin Norashiddin', 'amirul-zikry-bin-norashiddin-6cd394', '196779', 'MSWP', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fa29a3fe-bc57-55c0-b6fd-36c9ad8b34a5', 'Ahmad Umar Bin Mohd Nizar', 'ahmad-umar-bin-mohd-nizar-c2e80b', '88', 'MELAKA', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1db2931e-11b3-5a4c-9f03-443a1e17e958', 'Mohd Isahmuddin Bin Maming', 'mohd-isahmuddin-bin-maming-277323', '841356', 'TLDM', 'MAS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f2fc7707-469f-5bfc-b583-e4c2e93829ac', 'Yumiko Tombe', 'yumiko-tombe-a03234', '202611', 'TSAF', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c9e9c7ed-d987-5646-be1a-46a5c6399497', 'Nur Ku Zarith Binti Jaa''far', 'nur-ku-zarith-binti-jaa-far-a7f39e', '206800', 'MSWP', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '87b64c29-9e86-5fe3-97f2-01d0a7e02165', 'Nur Arfah Harizsya Bt. A''adnan', 'nur-arfah-harizsya-bt-a-adnan-5fa6b3', '212220', 'MSN PERAK', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'cb3a63b6-8117-5da4-b2ad-c606b89847db', 'Angeline Pei Wright', 'angeline-pei-wright-e3c9c7', '215058', 'MSNK/KSA', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0964f4f8-25aa-53a0-87c3-3cc4e4b93b58', 'Ainur Mardhiah Binti Mohd Shailannie', 'ainur-mardhiah-binti-mohd-shailannie-af54f1', '225713', 'MS PAHANG', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0285e1be-3c9f-5d9e-a21a-21f995a09436', 'Nur Hafizahanani Binti Zailan', 'nur-hafizahanani-binti-zailan-4a5946', '224712', 'SABAH', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd66bce28-eef0-57f8-8c00-679446eca2bd', 'Qaisarah Damia Binti Mohamad Faizal', 'qaisarah-damia-binti-mohamad-faizal-aff68f', '210598', 'MSN SARAWAK', 'MAS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);

-- 2. Update 22nd Langkawi International Regatta Perdana 2026 Event Classes
UPDATE public.regatta_events
SET classes = '["Optimist", "ILCA 4", "ILCA 6", "ILCA 7", "29er", "420", "iQFoil", "Techno 293"]'::jsonb,
    updated_at = clock_timestamp()
WHERE id = '58e20ba5-f1e4-4895-9387-231273b43421';

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — 29er
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'cd329052-dd4e-5b0b-985a-00a096b2b6ba',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — 29er',
    'langkawi-international-regatta-perdana-2026-29er',
    '2026-02-12',
    '2026-02-12',
    6,
    'Open',
    12,
    'MAS',
    '29er',
    'crew',
    2,
    2,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', '20149ed1-32c2-50e1-8a97-ac52f1f046b9', 'cd329052-dd4e-5b0b-985a-00a096b2b6ba', 'Nor Izniey Humaira Binti Mohd Azri & Aina Zulaikha Binti Azizul Rahman', 'MAS 2487', 'crew', 1,
    31.0, 21.0, false, false, 'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing',
    'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Nor Izniey Humaira Binti Mohd Azri, Crew: Aina Zulaikha Binti Azizul Rahman. Club: MSN/MSA. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e30be5bf-3265-50d5-b612-11c58e1bdff6', 'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', '20149ed1-32c2-50e1-8a97-ac52f1f046b9', 'Nor Izniey Humaira Binti Mohd Azri', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5800e4f4-32c0-54ef-9acc-8a59bff165a9', 'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', '1a026605-01b2-5c06-adf6-665ad5d89ef1', 'Aina Zulaikha Binti Azizul Rahman', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', 4, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', 9, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', 11, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a55a52eb-29e4-53b0-9d94-0b31f9ac520a', 12, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 'f6095146-c267-5a59-a60a-c86b7cbcb5be', 'cd329052-dd4e-5b0b-985a-00a096b2b6ba', 'Mohamad Hazmi Bin Suwandy & Alif Nur Bin Amzi', '1', 'crew', 2,
    38.0, 24.0, false, false, 'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing',
    'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Mohamad Hazmi Bin Suwandy, Crew: Alif Nur Bin Amzi. Club: MSN/MSA. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bd72204c-94f9-5409-9967-78df054f77b1', '024156e4-46b5-534d-a2f3-9de519a98a6e', 'f6095146-c267-5a59-a60a-c86b7cbcb5be', 'Mohamad Hazmi Bin Suwandy', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ee5604de-00dc-5a69-9854-e0bc533ea847', '024156e4-46b5-534d-a2f3-9de519a98a6e', '95b20b9e-fe72-5617-ba01-e55da0c048f8', 'Alif Nur Bin Amzi', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 1, 7.0, 'DNF', true, '(7 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 3, 7.0, 'DSQ', true, '(7 DSQ)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '024156e4-46b5-534d-a2f3-9de519a98a6e', 12, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 'f69c3030-ab08-5bfd-8037-74c8e4696b72', 'cd329052-dd4e-5b0b-985a-00a096b2b6ba', 'Muhammad Adam Aierell Bin Moh Azizol Amirul & Iqbal Nazham Bin Musmuliadi', '50', 'crew', 3,
    42.0, 30.0, false, false, 'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing',
    'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Muhammad Adam Aierell Bin Moh Azizol Amirul, Crew: Iqbal Nazham Bin Musmuliadi. Club: MSN/MSA. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b7f16a44-097d-516d-b051-0e075c0ecd1e', 'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 'f69c3030-ab08-5bfd-8037-74c8e4696b72', 'Muhammad Adam Aierell Bin Moh Azizol Amirul', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd55dea13-4614-5fd5-84c9-d8c300be532d', 'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 'ffa6f01a-8891-4c9a-a169-33a1008ecd31', 'Iqbal Nazham Bin Musmuliadi', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 5, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 6, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 10, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1f80104-6d0e-5795-943f-c7747ce1e1f4', 12, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', '2f22eebd-9bdc-549a-a5a9-6bea594a58ff', 'cd329052-dd4e-5b0b-985a-00a096b2b6ba', 'Sarawut Panphiboon & Panudat Polpool', 'THA 627', 'crew', 4,
    47.0, 33.0, false, false, 'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing',
    'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Sarawut Panphiboon, Crew: Panudat Polpool. Club: YRAT. Division: Open. Nat: THA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2e4472c0-fc58-53b7-9c75-e598933a2f06', '51ae7e40-8365-5d07-9570-da7781ad0d35', '2f22eebd-9bdc-549a-a5a9-6bea594a58ff', 'Sarawut Panphiboon', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '204609c9-8701-56b3-99d1-b33b8a62f6c0', '51ae7e40-8365-5d07-9570-da7781ad0d35', '2c3a793f-5bb5-531e-9290-5d976898618a', 'Panudat Polpool', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', 1, 7.0, 'DNS', true, '(7 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', 9, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', 10, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', 11, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '51ae7e40-8365-5d07-9570-da7781ad0d35', 12, 7.0, 'DNF', true, '(7 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 'dc9f6965-7f57-5e89-9077-1faee0afb764', 'cd329052-dd4e-5b0b-985a-00a096b2b6ba', 'Miss Patcharaphan Ongploy & Pichayapa Kamutatira', 'THA 621', 'crew', 5,
    48.0, 35.0, false, false, 'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing',
    'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Miss Patcharaphan Ongploy, Crew: Pichayapa Kamutatira. Club: YRAT. Division: Open. Nat: THA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0e2f2a37-42b9-5869-a816-0ae424d4188e', 'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 'dc9f6965-7f57-5e89-9077-1faee0afb764', 'Miss Patcharaphan Ongploy', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8934be57-58dd-5c67-abfe-4d487e429844', 'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 'd65f1d24-7149-519b-854e-506b4ba5788c', 'Pichayapa Kamutatira', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 1, 7.0, 'DNS', true, '(7 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 9, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 10, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 11, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b88e5f86-db8a-5701-814e-c67f9ae2c87b', 12, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', '86f5a930-4f9a-5f9e-b24d-6389c66465f0', 'cd329052-dd4e-5b0b-985a-00a096b2b6ba', 'Chung Jihyeok & Seo Minjun', '1412', 'crew', 6,
    60.0, 46.0, false, false, 'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing',
    'https://drive.google.com/file/d/1qD39g6m2OqUoGevey3-_0s84u0wZY3e2/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Chung Jihyeok, Crew: Seo Minjun. Club: BSC(KOREA). Division: Open. Nat: KOR.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9ca68536-e438-5a98-a70d-14ef42a44e46', '0aaed4dd-8318-541c-8c65-06afc31d3d02', '86f5a930-4f9a-5f9e-b24d-6389c66465f0', 'Chung Jihyeok', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '16f921d2-dce0-56a3-a816-632d84d520c3', '0aaed4dd-8318-541c-8c65-06afc31d3d02', '2489ba3e-0f35-5218-9c00-35eb0a75a894', 'Seo Minjun', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', 1, 7.0, 'DNF', true, '(7 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', 2, 7.0, 'DNF', true, '(7 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', 8, 7.0, 'UFD', false, '7 UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', 10, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', 11, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0aaed4dd-8318-541c-8c65-06afc31d3d02', 12, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — 420 Men
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '9ad056c7-1a19-546c-892a-aed7e90b0edf',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — 420 Men',
    'langkawi-international-regatta-perdana-2026-420-men',
    '2026-02-12',
    '2026-02-12',
    7,
    'Men',
    12,
    'MAS',
    '420',
    'crew',
    2,
    2,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    '91aad29d-5840-55ef-a583-328b75231321', 'd1624d92-8fde-5d56-9acb-69df6f18cb75', '9ad056c7-1a19-546c-892a-aed7e90b0edf', 'Pitipoom Jaroenpon & Worrakan Saksriklom', 'THA 55513', 'crew', 1,
    17.0, 10.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Pitipoom Jaroenpon, Crew: Worrakan Saksriklom. Club: YRAT. Division: Men. Nat: THA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '86da8cdd-003c-58e4-accb-47e1cd659d69', '91aad29d-5840-55ef-a583-328b75231321', 'd1624d92-8fde-5d56-9acb-69df6f18cb75', 'Pitipoom Jaroenpon', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '87676afb-fcf4-5f24-8fa4-bd586d74da82', '91aad29d-5840-55ef-a583-328b75231321', 'b1252473-a364-5f83-851b-8d9740d7e233', 'Worrakan Saksriklom', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '91aad29d-5840-55ef-a583-328b75231321', 1, 1.0, NULL, true, '(1)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '91aad29d-5840-55ef-a583-328b75231321', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '91aad29d-5840-55ef-a583-328b75231321', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '91aad29d-5840-55ef-a583-328b75231321', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '91aad29d-5840-55ef-a583-328b75231321', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '91aad29d-5840-55ef-a583-328b75231321', 6, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '91aad29d-5840-55ef-a583-328b75231321', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '91aad29d-5840-55ef-a583-328b75231321', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '91aad29d-5840-55ef-a583-328b75231321', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '91aad29d-5840-55ef-a583-328b75231321', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '91aad29d-5840-55ef-a583-328b75231321', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '91aad29d-5840-55ef-a583-328b75231321', 12, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', '9e4c2cd7-24d6-51e0-8d7e-5e6d91ee137a', '9ad056c7-1a19-546c-892a-aed7e90b0edf', 'Muhammad Idris Bin Mohd Zahawi & Muhammad Nazmi Qusyairi Bin Mohd Nazri', 'MAS 57346', 'crew', 2,
    33.0, 26.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Muhammad Idris Bin Mohd Zahawi, Crew: Muhammad Nazmi Qusyairi Bin Mohd Nazri. Club: MSNT-TSA. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0b3d26d8-0feb-5fc2-8593-9314d6b4aef9', '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', '9e4c2cd7-24d6-51e0-8d7e-5e6d91ee137a', 'Muhammad Idris Bin Mohd Zahawi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f6174c44-fb48-509a-977a-b5335831b129', '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', '580a0306-cd4c-548f-a98c-38bde8e7846c', 'Muhammad Nazmi Qusyairi Bin Mohd Nazri', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', 1, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', 5, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', 10, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', 11, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76bedd1b-1cc9-5fcb-8a6b-ad11d4e8d1b7', 12, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', '9ab6cba2-69ff-5905-b4c5-cb4dcd8e6ade', '9ad056c7-1a19-546c-892a-aed7e90b0edf', 'Danyal Marczqui Rahmat Haron Muzaffar & Nur Aina Binti Norhazram', 'MAS 55957', 'crew', 3,
    42.0, 29.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Danyal Marczqui Rahmat Haron Muzaffar, Crew: Nur Aina Binti Norhazram. Club: MSN/MSA. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e5583eb3-ddf5-52f1-8dde-117abf0193f5', '2afbffc3-74ee-53c7-80d6-253648a67d59', '9ab6cba2-69ff-5905-b4c5-cb4dcd8e6ade', 'Danyal Marczqui Rahmat Haron Muzaffar', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '41fcb8e0-557a-59c8-a000-b8f87d9b6b52', '2afbffc3-74ee-53c7-80d6-253648a67d59', '00e9f759-95f1-4633-88db-b07d7933d248', 'Nur Aina Binti Norhazram', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', 5, 8.0, 'DSQ', true, '(8 DSQ)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', 7, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', 11, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2afbffc3-74ee-53c7-80d6-253648a67d59', 12, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', '2bda4fc0-b72c-4b0b-b21f-597107dc5ca8', '9ad056c7-1a19-546c-892a-aed7e90b0edf', 'Muaz Mujahid Bin Khamarul Azwan & Muhammad Zahir Naiman Bin Ismail', '55156', 'crew', 4,
    48.0, 36.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Muaz Mujahid Bin Khamarul Azwan, Crew: Muhammad Zahir Naiman Bin Ismail. Club: MSN/MSA. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f28d00f2-2ff9-5cc8-a6ca-aeddd906cbbe', 'a87400a0-4a08-5276-be09-09222b3ed4b1', '2bda4fc0-b72c-4b0b-b21f-597107dc5ca8', 'Muaz Mujahid Bin Khamarul Azwan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f766f15d-0897-5a39-be23-21bb4cf29859', 'a87400a0-4a08-5276-be09-09222b3ed4b1', '6b9c77fe-5a8d-490a-bc66-34f60695132b', 'Muhammad Zahir Naiman Bin Ismail', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', 1, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', 4, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', 9, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', 10, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a87400a0-4a08-5276-be09-09222b3ed4b1', 12, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', '6333c43d-c279-5dcd-bc41-3f247a3afbc9', '9ad056c7-1a19-546c-892a-aed7e90b0edf', 'Atthakit Thuaythong & Kankao Peungchimplee', 'JPN 57009', 'crew', 5,
    59.0, 44.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Atthakit Thuaythong, Crew: Kankao Peungchimplee. Club: YRAT. Division: Men. Nat: THA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ade1cd61-97ed-5c46-91ce-a1ef739c542c', '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', '6333c43d-c279-5dcd-bc41-3f247a3afbc9', 'Atthakit Thuaythong', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8b4a5da1-ef14-51e8-bba1-9f4ab64051b9', '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 'e5a2cd0f-d08b-5984-9b75-e19f4242e1ff', 'Kankao Peungchimplee', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 3, 8.0, 'DNF', true, '(8 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 8, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 9, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 10, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 11, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87a1d635-6863-50c7-a0e6-c3dcf1c44d9d', 12, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 'd09b7f61-8e4b-58e0-bfa9-21af32b8fb1b', '9ad056c7-1a19-546c-892a-aed7e90b0edf', 'Muhammad Zafrin Bin Mohd Zailan & Muhammad Zulhelmie Haqimi Bin Zulkifli', '22', 'crew', 6,
    64.0, 49.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Muhammad Zafrin Bin Mohd Zailan, Crew: Muhammad Zulhelmie Haqimi Bin Zulkifli. Club: SELANGOR. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7fde1cd6-758a-59cc-8d3e-7328b7273f81', '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 'd09b7f61-8e4b-58e0-bfa9-21af32b8fb1b', 'Muhammad Zafrin Bin Mohd Zailan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '527db540-a632-50c8-a02e-7c14b08bb95c', '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', '459011bb-ba27-5414-a9bc-17b0634b85a9', 'Muhammad Zulhelmie Haqimi Bin Zulkifli', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 1, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 3, 8.0, 'DNF', true, '(8 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 9, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 10, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 11, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2f1952-4f45-5bbc-b1fd-f5085eccb7af', 12, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 'c9df556b-7b8e-5944-92c8-0cc863207d9b', '9ad056c7-1a19-546c-892a-aed7e90b0edf', 'Muhammad Yusri Bin Syahrizan & Muhammad Abrisam Athmar Bin Aslan', '56051', 'crew', 7,
    77.0, 63.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Muhammad Yusri Bin Syahrizan, Crew: Muhammad Abrisam Athmar Bin Aslan. Club: MSN SARAWAK. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7d8be8c2-c2f4-56b4-81c0-5d7508ed5e66', 'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 'c9df556b-7b8e-5944-92c8-0cc863207d9b', 'Muhammad Yusri Bin Syahrizan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e7542eee-ea57-588a-9287-cb1acc85f4e7', 'fdac0ea6-080f-5bc0-b200-bdd8acf13798', '5b9e6612-96be-592e-bd9b-06b558b96f63', 'Muhammad Abrisam Athmar Bin Aslan', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 1, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 2, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 4, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 5, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 6, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 7, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 8, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 9, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 10, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 11, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdac0ea6-080f-5bc0-b200-bdd8acf13798', 12, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — 420 Women
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'a1874593-4941-5616-b7a0-3227943563eb',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — 420 Women',
    'langkawi-international-regatta-perdana-2026-420-women',
    '2026-02-12',
    '2026-02-12',
    6,
    'Women',
    12,
    'MAS',
    '420',
    'crew',
    2,
    2,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', '143cd50a-0f51-5d01-ac67-4dcf1f4277b5', 'a1874593-4941-5616-b7a0-3227943563eb', 'Nur Asma Balqis Binti Rosli & Hadif Muayyad Bin Mohd Husni', 'MAS 55154', 'crew', 1,
    16.0, 11.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Nur Asma Balqis Binti Rosli, Crew: Hadif Muayyad Bin Mohd Husni. Club: MSN/MSA. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '34c1b9be-220b-593d-8f26-3f40663efa60', '9b299455-fb3c-5333-9a3c-13e9f473cde5', '143cd50a-0f51-5d01-ac67-4dcf1f4277b5', 'Nur Asma Balqis Binti Rosli', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9a88bbc0-a7a5-533a-90a3-de19015f8410', '9b299455-fb3c-5333-9a3c-13e9f473cde5', '8012fc54-f672-5e6f-8693-25415c616fc3', 'Hadif Muayyad Bin Mohd Husni', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', 5, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', 7, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9b299455-fb3c-5333-9a3c-13e9f473cde5', 12, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', '0ad44896-4a70-528f-88ea-a31f0f6d6538', 'a1874593-4941-5616-b7a0-3227943563eb', 'Bibi Qeesha Binti Mohd Faizal & Natasha Wong See Kei', 'SIN 54882', 'crew', 2,
    34.0, 22.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Bibi Qeesha Binti Mohd Faizal, Crew: Natasha Wong See Kei. Club: SABAH. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1e15fe45-3fb7-5731-96eb-4d2c7c05a2c7', '535bc778-2f82-5e43-a913-42def1dcd0e5', '0ad44896-4a70-528f-88ea-a31f0f6d6538', 'Bibi Qeesha Binti Mohd Faizal', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4708b240-f7c1-5b58-8df9-97b0b020a20e', '535bc778-2f82-5e43-a913-42def1dcd0e5', 'c963bbb1-0fa2-57f1-a0aa-721928f29e55', 'Natasha Wong See Kei', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', 1, 7.0, 'DNC', true, '(7 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', 2, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', 9, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '535bc778-2f82-5e43-a913-42def1dcd0e5', 12, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 'a246e2ce-5bfd-5212-b021-99a80151b1b0', 'a1874593-4941-5616-b7a0-3227943563eb', 'Amni Nur Afifa Binti Mohd Azlan & Nik Haiqal Danial Bin Nik Muhazarin', 'MAS 56300 D', 'crew', 3,
    44.0, 30.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Amni Nur Afifa Binti Mohd Azlan, Crew: Nik Haiqal Danial Bin Nik Muhazarin. Club: MSNT-TSA. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f3a3ff45-5ab4-54c2-b771-cf2dc7b64bca', '05dea1ab-21c9-5e09-8b05-d775d49983fa', 'a246e2ce-5bfd-5212-b021-99a80151b1b0', 'Amni Nur Afifa Binti Mohd Azlan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c2442d5b-8c4e-5a74-8629-0ca0cffe3c0d', '05dea1ab-21c9-5e09-8b05-d775d49983fa', 'c9237bd5-7570-5213-80d8-e56a8d3bffdb', 'Nik Haiqal Danial Bin Nik Muhazarin', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 1, 7.0, 'RET', true, '(7 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 2, 7.0, 'DNC', true, '(7 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 10, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 11, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '05dea1ab-21c9-5e09-8b05-d775d49983fa', 12, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', '7d79261f-75e1-5069-a10e-567d9c9816f3', 'a1874593-4941-5616-b7a0-3227943563eb', 'Nur Aqilah Raifana Binti Aslan & Nur Asma Binti Syahrizan', '56054', 'crew', 4,
    51.0, 38.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Nur Aqilah Raifana Binti Aslan, Crew: Nur Asma Binti Syahrizan. Club: MSN SARAWAK. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'be83cc99-5ad6-5396-bb70-62075f1873cf', '8431b291-432a-5101-ac29-6ec8db0fb6a7', '7d79261f-75e1-5069-a10e-567d9c9816f3', 'Nur Aqilah Raifana Binti Aslan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dd74e351-2f41-5201-9f82-f09de68374ec', '8431b291-432a-5101-ac29-6ec8db0fb6a7', 'f1d035dc-2510-5f18-a6d0-09b8f9827d52', 'Nur Asma Binti Syahrizan', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', 1, 7.0, 'RET', true, '(7 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', 8, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', 10, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', 11, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8431b291-432a-5101-ac29-6ec8db0fb6a7', 12, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', '0734265d-4f61-5c1e-ae03-6f39847bbd1c', 'a1874593-4941-5616-b7a0-3227943563eb', 'Ainnur Iman Qistina Binti Kamarulzaman & Nur Ain Batrisyia Binti Azhar', 'MAS 54393', 'crew', 5,
    56.0, 43.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Ainnur Iman Qistina Binti Kamarulzaman, Crew: Nur Ain Batrisyia Binti Azhar. Club: MS PAHANG. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '079baf09-5906-5376-89f0-fd5f103bf46e', '5073987c-1701-5029-be50-8438af7e6b47', '0734265d-4f61-5c1e-ae03-6f39847bbd1c', 'Ainnur Iman Qistina Binti Kamarulzaman', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9851cde9-dd19-58a8-8bac-50164336eb36', '5073987c-1701-5029-be50-8438af7e6b47', '516aec8c-41fd-5ebf-90ad-bea9af92a244', 'Nur Ain Batrisyia Binti Azhar', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', 9, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', 10, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', 11, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5073987c-1701-5029-be50-8438af7e6b47', 12, 7.0, 'RET', true, '(7 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', '330ced97-e136-541a-811b-f9000a2b9eaa', 'a1874593-4941-5616-b7a0-3227943563eb', 'Nur Qaseh Qistiena Binti Mohd Husney & Kanitha Inthanu', '9999', 'crew', 6,
    61.0, 48.0, false, false, 'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing',
    'https://drive.google.com/file/d/1wHci7wyeFnle5EiMJlFOp1bAMWCF74c5/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Helm: Nur Qaseh Qistiena Binti Mohd Husney, Crew: Kanitha Inthanu. Club: MSNK/KSA. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '024296b3-e79f-5adc-97cc-ae5b9c7c3e8d', '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', '330ced97-e136-541a-811b-f9000a2b9eaa', 'Nur Qaseh Qistiena Binti Mohd Husney', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5b939647-0aa3-5b97-aae0-161cea00cad4', '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', '840a648e-eddd-5158-800a-b1018f9d31b2', 'Kanitha Inthanu', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', 3, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', 5, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', 6, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', 9, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', 10, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', 11, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a21e44a-6ca8-5518-b7aa-81e9ec6f6cfd', 12, 7.0, 'RET', true, '(7 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — ILCA 7
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '9d489190-aaf7-5613-8148-8e8a97cf61e2',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — ILCA 7',
    'langkawi-international-regatta-perdana-2026-ilca-7',
    '2026-02-12',
    '2026-02-12',
    14,
    'Open',
    12,
    'MAS',
    'ILCA 7',
    'individual',
    1,
    1,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 'bd3ea917-2821-539f-a858-91ae716fa34b', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Muhammad Faizal Bin Ahmad Asri', 'MAS 209883', 'individual', 1,
    16.0, 12.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Faizal Bin Ahmad Asri. Club: MSN/MSA/PODIUM. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '536ca3c3-f27d-562b-a492-0434b4f698a5', '20f575cd-d066-5c90-82d8-c250f7a6bb50', 'bd3ea917-2821-539f-a858-91ae716fa34b', 'Muhammad Faizal Bin Ahmad Asri', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 5, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 6, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f575cd-d066-5c90-82d8-c250f7a6bb50', 12, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', '1e4b724c-4571-5f4a-8f48-73f77141691d', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Muhammad Asnawi Iqbal Bin Adam', 'MAS 214989', 'individual', 2,
    25.0, 19.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Asnawi Iqbal Bin Adam. Club: MSN/MSA/PODIUM. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '899287ca-d998-52eb-85e3-9aca6ce4a030', '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', '1e4b724c-4571-5f4a-8f48-73f77141691d', 'Muhammad Asnawi Iqbal Bin Adam', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', 3, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', 5, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23c36867-7f9d-5bdf-9e50-97bfb3e2d399', 12, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', '35dc95b9-784f-52ac-b416-5e485d68a8f8', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Brandan Richard Peter Wright', '217837', 'individual', 3,
    36.0, 27.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Brandan Richard Peter Wright. Club: MSNK/KSA. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1511f3f0-9eea-5537-b8f9-f5fedb7de25f', '29f3ea07-82ff-5600-925c-2124168bbd1c', '35dc95b9-784f-52ac-b416-5e485d68a8f8', 'Brandan Richard Peter Wright', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', 4, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', 6, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', 9, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', 10, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', 11, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29f3ea07-82ff-5600-925c-2124168bbd1c', 12, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', '57a1f9c5-bf57-5654-85a6-68f16b64ab40', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Muhammad Zafir Bin Mohd Zailan', '207095', 'individual', 4,
    62.0, 46.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Zafir Bin Mohd Zailan. Club: SELANGOR. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c0c31342-8545-5fa7-9fa2-d26d3c6a3466', 'f01dd9a7-624e-50f7-9a38-ca438d9060dc', '57a1f9c5-bf57-5654-85a6-68f16b64ab40', 'Muhammad Zafir Bin Mohd Zailan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', 3, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', 9, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', 10, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', 11, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f01dd9a7-624e-50f7-9a38-ca438d9060dc', 12, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', '0734265d-4f61-5c1e-ae03-6f39847bbd1c', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Muhammad Iman Danish B. Mohamad Razali', 'MAS 213183', 'individual', 5,
    74.0, 52.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Iman Danish B. Mohamad Razali. Club: MSN PERAK. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '518dda3b-5dce-5b7e-8d3b-1e415dc96537', '154ffc6a-956d-518c-939c-964192d63e0a', '0734265d-4f61-5c1e-ae03-6f39847bbd1c', 'Muhammad Iman Danish B. Mohamad Razali', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', 1, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', 4, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', 5, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', 6, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', 7, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', 8, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', 10, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', 11, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '154ffc6a-956d-518c-939c-964192d63e0a', 12, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 'bcf5dfcc-5bea-5f87-8080-564805c9695e', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Haziem Hakimi Bin Edie Akbar', '197851', 'individual', 6,
    86.0, 61.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Haziem Hakimi Bin Edie Akbar. Club: MS PAHANG. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3ebe9839-8b8f-5a86-b2ee-4834bf8089a2', 'd5c61c53-424c-53cf-8ccc-d461715e69af', 'bcf5dfcc-5bea-5f87-8080-564805c9695e', 'Haziem Hakimi Bin Edie Akbar', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 1, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 3, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 4, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 6, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 8, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 9, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 10, 15.0, 'RET', true, '(15 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 11, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5c61c53-424c-53cf-8ccc-d461715e69af', 12, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', '514fc284-f5a5-5aae-a8ce-956a6303df8d', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Ahmad Farel Bin Arham', '221056', 'individual', 7,
    94.0, 69.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Ahmad Farel Bin Arham. Club: MSNT-TSA. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7280dd4a-a0fc-5a2a-accd-72332b0cbc27', '1210d3d9-ecf0-50f8-ac4e-75435305028f', '514fc284-f5a5-5aae-a8ce-956a6303df8d', 'Ahmad Farel Bin Arham', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', 1, 15.0, 'DNF', true, '(15 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', 5, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', 6, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', 7, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', 9, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', 10, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', 11, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1210d3d9-ecf0-50f8-ac4e-75435305028f', 12, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', '91927627-a2be-5b01-a357-134fe82679f9', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Adam Iwan Carraz', '150757', 'individual', 8,
    100.0, 74.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Adam Iwan Carraz. Club: SABAH. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '683dc303-7c80-5ed3-ba31-a0ef879bcec1', '96f5c9f6-2b66-51f3-9f65-070312e10247', '91927627-a2be-5b01-a357-134fe82679f9', 'Adam Iwan Carraz', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', 1, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', 2, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', 3, 15.0, 'DNF', true, '(15 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', 5, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', 7, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', 8, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', 9, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', 10, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', 11, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96f5c9f6-2b66-51f3-9f65-070312e10247', 12, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 'dffe8ea9-f134-5a78-9fc2-e7837c01e591', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Fikri Izzan Bin Zamri', '210597', 'individual', 9,
    93.0, 75.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Fikri Izzan Bin Zamri. Club: MSN SARAWAK. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9fd1b52a-852c-57dc-aba3-1224428f2154', '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 'dffe8ea9-f134-5a78-9fc2-e7837c01e591', 'Fikri Izzan Bin Zamri', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 2, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 4, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 5, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 6, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 8, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 9, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 10, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 11, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6d954753-e6a3-5c3a-9da5-926c32fbe1d4', 12, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 'd5950089-a98b-528b-83d6-3582f48dacb9', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Yim Woojun', '8', 'individual', 10,
    98.0, 76.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Yim Woojun. Club: BSC(KOREA). Division: Open. Nat: KOR.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dcd3964d-bc11-5fcb-91ab-0d10be32514f', 'e45916e6-067a-5caf-b0b8-b235d92ed375', 'd5950089-a98b-528b-83d6-3582f48dacb9', 'Yim Woojun', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 1, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 4, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 5, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 6, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 7, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 8, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 9, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 10, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 11, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e45916e6-067a-5caf-b0b8-b235d92ed375', 12, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', '0fc23dd4-3434-5e78-8767-25afc8afdc87', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Imman Nazhim Bin Musmuliadi', '211027', 'individual', 11,
    136.0, 106.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Imman Nazhim Bin Musmuliadi. Club: MSNK/KSA. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '856ccfff-02cd-5413-8aa6-631393a371ac', 'e5087939-cbd2-517d-980e-1baaa2ba1aee', '0fc23dd4-3434-5e78-8767-25afc8afdc87', 'Imman Nazhim Bin Musmuliadi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', 1, 15.0, 'RET', true, '(15 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', 2, 15.0, 'RET', true, '(15 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', 3, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', 4, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', 5, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', 6, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', 7, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', 8, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', 9, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', 10, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', 11, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e5087939-cbd2-517d-980e-1baaa2ba1aee', 12, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', '6bd0387e-8eca-5194-8c1b-2427ec2bd6aa', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Mohd. Nofalzul Iqma Bin Fazelillah', '2', 'individual', 12,
    155.0, 125.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Mohd. Nofalzul Iqma Bin Fazelillah. Club: TLDM. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '66eea1e1-c82f-5159-9ac6-66982666c204', '840e6fbe-8221-57cb-addd-4503aabce1ba', '6bd0387e-8eca-5194-8c1b-2427ec2bd6aa', 'Mohd. Nofalzul Iqma Bin Fazelillah', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', 1, 15.0, 'DNF', true, '(15 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', 2, 15.0, 'DNF', true, '(15 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', 3, 15.0, 'DNF', false, '15 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', 4, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', 5, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', 6, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', 7, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', 8, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', 9, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', 10, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', 11, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '840e6fbe-8221-57cb-addd-4503aabce1ba', 12, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 'e5d0c092-9144-5e09-be5f-f19eb008c85a', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Muhammad Amir Asyraf Bin Mohd Aziz', '197225', 'individual', 13,
    157.0, 127.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Amir Asyraf Bin Mohd Aziz. Club: MELAKA. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a41c7dac-4e73-51c0-8003-3ce919ac1d49', '38887716-4d30-5896-822e-0c3e7438393f', 'e5d0c092-9144-5e09-be5f-f19eb008c85a', 'Muhammad Amir Asyraf Bin Mohd Aziz', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 1, 15.0, 'DNF', true, '(15 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 2, 15.0, 'DNF', true, '(15 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 3, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 4, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 5, 15.0, 'DNF', false, '15 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 6, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 7, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 8, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 9, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 10, 15.0, 'RET', false, '15 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 11, 15.0, 'RET', false, '15 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38887716-4d30-5896-822e-0c3e7438393f', 12, 15.0, 'RET', false, '15 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 'e69480ac-aad2-5a19-9d13-26d3fe8c437a', '9d489190-aaf7-5613-8148-8e8a97cf61e2', 'Ku Muhammad Amirul Haziq Bin Ku Halid', 'MAS 138629', 'individual', 14,
    165.0, 135.0, false, false, 'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing',
    'https://drive.google.com/file/d/1117sUE9C4Qql3Ix1cuUEbgkh_gs3tc6b/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Ku Muhammad Amirul Haziq Bin Ku Halid. Club: TLDM. Division: Open. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '17363326-ed33-5ca9-ada3-32acf55eea80', 'cc291ddf-826f-5d54-813f-0ed17585f689', 'e69480ac-aad2-5a19-9d13-26d3fe8c437a', 'Ku Muhammad Amirul Haziq Bin Ku Halid', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 1, 15.0, 'DNF', true, '(15 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 2, 15.0, 'DNF', true, '(15 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 3, 15.0, 'DNF', false, '15 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 4, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 5, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 6, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 7, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 8, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 9, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 10, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 11, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cc291ddf-826f-5d54-813f-0ed17585f689', 12, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — iQFoil Men
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '618ec075-06ff-5c8a-8efd-7418ff4f1f17',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — iQFoil Men',
    'langkawi-international-regatta-perdana-2026-iqfoil-men',
    '2026-02-12',
    '2026-02-12',
    4,
    'Men',
    12,
    'MAS',
    'iQFoil',
    'individual',
    1,
    1,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    'be9f772c-1aa4-597e-baba-b89fdf52d560', '551f1e67-9740-5f26-a69b-499f09d63471', '618ec075-06ff-5c8a-8efd-7418ff4f1f17', 'Andrei Tugade', 'PHI 295', 'individual', 1,
    19.0, 14.0, false, false, 'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing',
    'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Andrei Tugade. Club: PWA. Division: Men. Nat: PHI.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '25161cb3-1497-5044-a125-263d9e2f4083', 'be9f772c-1aa4-597e-baba-b89fdf52d560', '551f1e67-9740-5f26-a69b-499f09d63471', 'Andrei Tugade', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'be9f772c-1aa4-597e-baba-b89fdf52d560', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'be9f772c-1aa4-597e-baba-b89fdf52d560', 2, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'be9f772c-1aa4-597e-baba-b89fdf52d560', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'be9f772c-1aa4-597e-baba-b89fdf52d560', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'be9f772c-1aa4-597e-baba-b89fdf52d560', 5, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'be9f772c-1aa4-597e-baba-b89fdf52d560', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'be9f772c-1aa4-597e-baba-b89fdf52d560', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'be9f772c-1aa4-597e-baba-b89fdf52d560', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'be9f772c-1aa4-597e-baba-b89fdf52d560', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'be9f772c-1aa4-597e-baba-b89fdf52d560', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'be9f772c-1aa4-597e-baba-b89fdf52d560', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'be9f772c-1aa4-597e-baba-b89fdf52d560', 12, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 'efbd9517-2dd8-5c0b-8e29-3642c9e1c338', '618ec075-06ff-5c8a-8efd-7418ff4f1f17', 'Wachirawit Manbumrung', 'THA51', 'individual', 2,
    18.0, 14.0, false, false, 'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing',
    'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Wachirawit Manbumrung. Club: WATH. Division: Men. Nat: THA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '13aaee6f-eec5-5fc9-af08-cc07ebc3ad41', 'c48df57c-7413-5637-8b74-3d9efda5964f', 'efbd9517-2dd8-5c0b-8e29-3642c9e1c338', 'Wachirawit Manbumrung', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 1, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 3, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c48df57c-7413-5637-8b74-3d9efda5964f', 12, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', '7a7426a9-fa00-5658-8afd-bda6025ff56c', '618ec075-06ff-5c8a-8efd-7418ff4f1f17', 'I Gusti Putra Padantya Sulaksana', '11', 'individual', 3,
    41.0, 32.0, false, false, 'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing',
    'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: I Gusti Putra Padantya Sulaksana. Club: EAST BALI SURF & SAIL. Division: Men. Nat: INA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'aee9efd4-ec1f-5a87-b9ef-9a7f152f9579', '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', '7a7426a9-fa00-5658-8afd-bda6025ff56c', 'I Gusti Putra Padantya Sulaksana', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', 2, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', 6, 5.0, 'DNF', true, '(5 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', 10, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', 11, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f7d053a-d8d6-5d26-9b2b-2d0fe55c6cc8', 12, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 'dc53f7b9-6c62-5b56-a8af-126c740c3310', '618ec075-06ff-5c8a-8efd-7418ff4f1f17', 'Phatchara Nari', 'THA27', 'individual', 4,
    48.0, 38.0, false, false, 'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing',
    'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Phatchara Nari. Club: WATH. Division: Men. Nat: THA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '634cd60b-7821-517f-955c-41045add270d', '955a9255-1596-5b5c-a84c-65c4183b3877', 'dc53f7b9-6c62-5b56-a8af-126c740c3310', 'Phatchara Nari', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 1, 5.0, 'DNS', true, '(5 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 5, 5.0, 'DNF', true, '(5 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 6, 5.0, 'DNF', false, '5 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 7, 5.0, 'DNF', false, '5 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 9, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 10, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 11, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '955a9255-1596-5b5c-a84c-65c4183b3877', 12, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — iQFoil Women
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'da4ddb9a-2be1-5ef3-803b-86d7b20d9986',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — iQFoil Women',
    'langkawi-international-regatta-perdana-2026-iqfoil-women',
    '2026-02-12',
    '2026-02-12',
    3,
    'Women',
    12,
    'MAS',
    'iQFoil',
    'individual',
    1,
    1,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', '4ca37d74-db0e-5a1c-9986-d6fd6a9407c4', 'da4ddb9a-2be1-5ef3-803b-86d7b20d9986', 'Alfionnah Mae Gonzalez', 'PHI 14', 'individual', 1,
    13.0, 10.0, false, false, 'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing',
    'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Alfionnah Mae Gonzalez. Club: PWA. Division: Women. Nat: PHI.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '09b2934e-5878-5f0f-85ab-02641be9b3f2', 'c78d545a-695c-5e64-b154-9e4059a6ebcb', '4ca37d74-db0e-5a1c-9986-d6fd6a9407c4', 'Alfionnah Mae Gonzalez', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', 1, 1.0, NULL, true, '(1)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', 9, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c78d545a-695c-5e64-b154-9e4059a6ebcb', 12, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', '0f664096-c007-56a0-9edc-c7226be5a9da', 'da4ddb9a-2be1-5ef3-803b-86d7b20d9986', 'Kelsy Loryn Moreno', 'PHI 12', 'individual', 2,
    26.0, 19.0, false, false, 'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing',
    'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Kelsy Loryn Moreno. Club: PWA. Division: Women. Nat: PHI.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e3ff78ad-3b3f-5f0e-963a-be025cb77a00', 'bd4060ef-ec2e-5612-9aca-272daa038b1f', '0f664096-c007-56a0-9edc-c7226be5a9da', 'Kelsy Loryn Moreno', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', 6, 4.0, 'DNF', true, '(4 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', 10, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd4060ef-ec2e-5612-9aca-272daa038b1f', 12, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 'ff3dc58d-9647-5239-aa5f-455b53ac35f5', 'da4ddb9a-2be1-5ef3-803b-86d7b20d9986', 'Marcella Wilson Villaceran', 'MAS 23', 'individual', 3,
    37.0, 29.0, false, false, 'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing',
    'https://drive.google.com/file/d/1Cngb7WLqwc9yqbrsgAK9-IdEYYsDZ9eK/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Marcella Wilson Villaceran. Club: MSA/MSN. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1d6ee9ff-80ed-58bb-887d-2fc7fad79fec', '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 'ff3dc58d-9647-5239-aa5f-455b53ac35f5', 'Marcella Wilson Villaceran', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 5, 4.0, 'DNF', true, '(4 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 6, 4.0, 'DNF', true, '(4 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 11, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '08d4fb2a-62b4-5bce-a4b0-c7ce0ff202cf', 12, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — Techno 293 Men
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '1f52bc8a-7ff0-51bf-b4f5-0df5f036ad97',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — Techno 293 Men',
    'langkawi-international-regatta-perdana-2026-techno-293-men',
    '2026-02-12',
    '2026-02-12',
    5,
    'Men',
    11,
    'MAS',
    'Techno 293',
    'individual',
    1,
    1,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    'cfbbd889-8caa-56c3-8505-ff8584f9b030', 'c4a8af93-b344-5b96-a9e4-bef4c6f0107b', '1f52bc8a-7ff0-51bf-b4f5-0df5f036ad97', 'Suphachai Chueatathong', 'THA 31', 'individual', 1,
    21.0, 11.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Suphachai Chueatathong. Club: WATH. Division: Men. Nat: THA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '58df5fd9-4ffe-515b-9b81-0e8ce393a4c4', 'cfbbd889-8caa-56c3-8505-ff8584f9b030', 'c4a8af93-b344-5b96-a9e4-bef4c6f0107b', 'Suphachai Chueatathong', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cfbbd889-8caa-56c3-8505-ff8584f9b030', 1, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cfbbd889-8caa-56c3-8505-ff8584f9b030', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cfbbd889-8caa-56c3-8505-ff8584f9b030', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cfbbd889-8caa-56c3-8505-ff8584f9b030', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cfbbd889-8caa-56c3-8505-ff8584f9b030', 5, 6.0, 'UFD', true, '(6 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cfbbd889-8caa-56c3-8505-ff8584f9b030', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cfbbd889-8caa-56c3-8505-ff8584f9b030', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cfbbd889-8caa-56c3-8505-ff8584f9b030', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cfbbd889-8caa-56c3-8505-ff8584f9b030', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cfbbd889-8caa-56c3-8505-ff8584f9b030', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cfbbd889-8caa-56c3-8505-ff8584f9b030', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', '8ffa116a-c240-50cf-9829-612d51554520', '1f52bc8a-7ff0-51bf-b4f5-0df5f036ad97', 'Jade Justin Justiniane', 'PHI 05', 'individual', 2,
    25.0, 16.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Jade Justin Justiniane. Club: PWA. Division: Men. Nat: PHI.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2ad9629b-66e5-592b-9144-b8f88591c928', '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', '8ffa116a-c240-50cf-9829-612d51554520', 'Jade Justin Justiniane', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', 5, 6.0, 'UFD', true, '(6 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', 10, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '943655ef-4e9a-5e5a-9d4c-e87a1beebb50', 11, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '15fd604e-ee13-5973-8b58-d007d8bdbd76', '5480f138-dccf-5c68-82da-1fd7dcbcba63', '1f52bc8a-7ff0-51bf-b4f5-0df5f036ad97', 'Rayyan Mirza Bin Azman', 'MAS 95', 'individual', 3,
    33.0, 24.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Rayyan Mirza Bin Azman. Club: MSNK/KSA. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6918e3db-bb2f-5e08-a74a-5b3b5b5ee494', '15fd604e-ee13-5973-8b58-d007d8bdbd76', '5480f138-dccf-5c68-82da-1fd7dcbcba63', 'Rayyan Mirza Bin Azman', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15fd604e-ee13-5973-8b58-d007d8bdbd76', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15fd604e-ee13-5973-8b58-d007d8bdbd76', 2, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15fd604e-ee13-5973-8b58-d007d8bdbd76', 3, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15fd604e-ee13-5973-8b58-d007d8bdbd76', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15fd604e-ee13-5973-8b58-d007d8bdbd76', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15fd604e-ee13-5973-8b58-d007d8bdbd76', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15fd604e-ee13-5973-8b58-d007d8bdbd76', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15fd604e-ee13-5973-8b58-d007d8bdbd76', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15fd604e-ee13-5973-8b58-d007d8bdbd76', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15fd604e-ee13-5973-8b58-d007d8bdbd76', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15fd604e-ee13-5973-8b58-d007d8bdbd76', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2659d576-cef6-5fcb-bf30-e5bd8184b89c', '011d13b6-d2d8-5942-b777-ecb1272110f8', '1f52bc8a-7ff0-51bf-b4f5-0df5f036ad97', 'Riyadh Adief Bin Rozaidi', 'MAS 96', 'individual', 4,
    44.0, 34.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Riyadh Adief Bin Rozaidi. Club: MSNK/KSA. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0fde895c-86a3-5cca-ae3c-55bde64b8c9d', '2659d576-cef6-5fcb-bf30-e5bd8184b89c', '011d13b6-d2d8-5942-b777-ecb1272110f8', 'Riyadh Adief Bin Rozaidi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2659d576-cef6-5fcb-bf30-e5bd8184b89c', 1, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2659d576-cef6-5fcb-bf30-e5bd8184b89c', 2, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2659d576-cef6-5fcb-bf30-e5bd8184b89c', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2659d576-cef6-5fcb-bf30-e5bd8184b89c', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2659d576-cef6-5fcb-bf30-e5bd8184b89c', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2659d576-cef6-5fcb-bf30-e5bd8184b89c', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2659d576-cef6-5fcb-bf30-e5bd8184b89c', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2659d576-cef6-5fcb-bf30-e5bd8184b89c', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2659d576-cef6-5fcb-bf30-e5bd8184b89c', 9, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2659d576-cef6-5fcb-bf30-e5bd8184b89c', 10, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2659d576-cef6-5fcb-bf30-e5bd8184b89c', 11, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '38b37db4-775b-5c7d-acd3-77b78fb36856', '5e56bd58-f094-5e35-8761-403ce2c7a21d', '1f52bc8a-7ff0-51bf-b4f5-0df5f036ad97', 'Ammar Danish Bin Khairul Azhar', 'MAS 71', 'individual', 5,
    45.0, 35.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Ammar Danish Bin Khairul Azhar. Club: MS PAHANG. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '86add23c-0ca4-5250-85ac-dadbe8fa2218', '38b37db4-775b-5c7d-acd3-77b78fb36856', '5e56bd58-f094-5e35-8761-403ce2c7a21d', 'Ammar Danish Bin Khairul Azhar', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38b37db4-775b-5c7d-acd3-77b78fb36856', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38b37db4-775b-5c7d-acd3-77b78fb36856', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38b37db4-775b-5c7d-acd3-77b78fb36856', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38b37db4-775b-5c7d-acd3-77b78fb36856', 4, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38b37db4-775b-5c7d-acd3-77b78fb36856', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38b37db4-775b-5c7d-acd3-77b78fb36856', 6, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38b37db4-775b-5c7d-acd3-77b78fb36856', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38b37db4-775b-5c7d-acd3-77b78fb36856', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38b37db4-775b-5c7d-acd3-77b78fb36856', 9, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38b37db4-775b-5c7d-acd3-77b78fb36856', 10, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38b37db4-775b-5c7d-acd3-77b78fb36856', 11, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — Techno 293 Women
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '2ddb971d-0637-58d1-ba03-a91874d98095',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — Techno 293 Women',
    'langkawi-international-regatta-perdana-2026-techno-293-women',
    '2026-02-12',
    '2026-02-12',
    3,
    'Women',
    11,
    'MAS',
    'Techno 293',
    'individual',
    1,
    1,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    'ceee697d-057b-56a2-b4cf-42c19031ea40', '5870de79-63ef-5d28-b060-c8774a0e4b73', '2ddb971d-0637-58d1-ba03-a91874d98095', 'Kornkanya Pantong', 'THA17', 'individual', 1,
    14.0, 9.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Kornkanya Pantong. Club: WATH. Division: Women. Nat: THA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '121004ff-b649-5744-8dec-2415e6713748', 'ceee697d-057b-56a2-b4cf-42c19031ea40', '5870de79-63ef-5d28-b060-c8774a0e4b73', 'Kornkanya Pantong', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee697d-057b-56a2-b4cf-42c19031ea40', 1, 1.0, NULL, true, '(1)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee697d-057b-56a2-b4cf-42c19031ea40', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee697d-057b-56a2-b4cf-42c19031ea40', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee697d-057b-56a2-b4cf-42c19031ea40', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee697d-057b-56a2-b4cf-42c19031ea40', 5, 4.0, 'UFD', true, '(4 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee697d-057b-56a2-b4cf-42c19031ea40', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee697d-057b-56a2-b4cf-42c19031ea40', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee697d-057b-56a2-b4cf-42c19031ea40', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee697d-057b-56a2-b4cf-42c19031ea40', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee697d-057b-56a2-b4cf-42c19031ea40', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ceee697d-057b-56a2-b4cf-42c19031ea40', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '96dc39ab-71a5-57d9-968b-0dbb5b04d814', '3b38fb75-d880-5e44-8a3d-9426188f06a2', '2ddb971d-0637-58d1-ba03-a91874d98095', 'Hayfa Maryam Bin Dzul Azwardi Shah', 'MAS 70', 'individual', 2,
    34.0, 26.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Hayfa Maryam Bin Dzul Azwardi Shah. Club: MS PAHANG. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c1f7b60f-ce87-5779-b0a9-d1b5777d9659', '96dc39ab-71a5-57d9-968b-0dbb5b04d814', '3b38fb75-d880-5e44-8a3d-9426188f06a2', 'Hayfa Maryam Bin Dzul Azwardi Shah', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96dc39ab-71a5-57d9-968b-0dbb5b04d814', 1, 4.0, 'DNF', true, '(4 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96dc39ab-71a5-57d9-968b-0dbb5b04d814', 2, 4.0, 'DNC', true, '(4 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96dc39ab-71a5-57d9-968b-0dbb5b04d814', 3, 4.0, 'DNC', false, '4 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96dc39ab-71a5-57d9-968b-0dbb5b04d814', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96dc39ab-71a5-57d9-968b-0dbb5b04d814', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96dc39ab-71a5-57d9-968b-0dbb5b04d814', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96dc39ab-71a5-57d9-968b-0dbb5b04d814', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96dc39ab-71a5-57d9-968b-0dbb5b04d814', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96dc39ab-71a5-57d9-968b-0dbb5b04d814', 9, 4.0, 'RET', false, '4 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96dc39ab-71a5-57d9-968b-0dbb5b04d814', 10, 4.0, 'DNF', false, '4 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '96dc39ab-71a5-57d9-968b-0dbb5b04d814', 11, 4.0, 'DNF', false, '4 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '443aa592-c54c-5a54-97e3-e24c8169af44', '682eeb1b-9e9a-5b3f-b346-0f6d17c46d60', '2ddb971d-0637-58d1-ba03-a91874d98095', 'Hadelia Amani', 'K7', 'individual', 3,
    40.0, 32.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Hadelia Amani. Club: KSA/MSNK. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '087e2f6f-d410-5921-8e76-04942e50e8c7', '443aa592-c54c-5a54-97e3-e24c8169af44', '682eeb1b-9e9a-5b3f-b346-0f6d17c46d60', 'Hadelia Amani', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '443aa592-c54c-5a54-97e3-e24c8169af44', 1, 4.0, 'DNF', true, '(4 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '443aa592-c54c-5a54-97e3-e24c8169af44', 2, 4.0, 'DNF', true, '(4 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '443aa592-c54c-5a54-97e3-e24c8169af44', 3, 4.0, 'DNF', false, '4 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '443aa592-c54c-5a54-97e3-e24c8169af44', 4, 4.0, 'DNF', false, '4 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '443aa592-c54c-5a54-97e3-e24c8169af44', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '443aa592-c54c-5a54-97e3-e24c8169af44', 6, 4.0, 'DNF', false, '4 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '443aa592-c54c-5a54-97e3-e24c8169af44', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '443aa592-c54c-5a54-97e3-e24c8169af44', 8, 4.0, 'DNF', false, '4 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '443aa592-c54c-5a54-97e3-e24c8169af44', 9, 4.0, 'RET', false, '4 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '443aa592-c54c-5a54-97e3-e24c8169af44', 10, 4.0, 'DNF', false, '4 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '443aa592-c54c-5a54-97e3-e24c8169af44', 11, 4.0, 'DNF', false, '4 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — Techno 293 Plus Men
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '36540c79-2029-5704-baab-a46bec05c09d',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — Techno 293 Plus Men',
    'langkawi-international-regatta-perdana-2026-techno-293-plus-men',
    '2026-02-12',
    '2026-02-12',
    3,
    'Plus Men',
    11,
    'MAS',
    'Techno 293',
    'individual',
    1,
    1,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    'b32306db-27a9-5410-81fa-254b0aac3461', 'bf5455bc-c310-5bc1-85f1-372889e90934', '36540c79-2029-5704-baab-a46bec05c09d', 'Suphachok Chueatathong', 'THA999', 'individual', 1,
    14.0, 10.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Suphachok Chueatathong. Club: WATH. Division: Plus Men. Nat: THA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '068ac2b8-f4f0-5701-9d77-98346d2520e5', 'b32306db-27a9-5410-81fa-254b0aac3461', 'bf5455bc-c310-5bc1-85f1-372889e90934', 'Suphachok Chueatathong', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b32306db-27a9-5410-81fa-254b0aac3461', 1, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b32306db-27a9-5410-81fa-254b0aac3461', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b32306db-27a9-5410-81fa-254b0aac3461', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b32306db-27a9-5410-81fa-254b0aac3461', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b32306db-27a9-5410-81fa-254b0aac3461', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b32306db-27a9-5410-81fa-254b0aac3461', 6, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b32306db-27a9-5410-81fa-254b0aac3461', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b32306db-27a9-5410-81fa-254b0aac3461', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b32306db-27a9-5410-81fa-254b0aac3461', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b32306db-27a9-5410-81fa-254b0aac3461', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b32306db-27a9-5410-81fa-254b0aac3461', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 'fb14cb2c-b4dd-5f8c-a74c-1f5fd93579ed', '36540c79-2029-5704-baab-a46bec05c09d', 'Khian Cuerdo', 'PHI 30', 'individual', 2,
    21.0, 15.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Khian Cuerdo. Club: PWA. Division: Plus Men. Nat: PHI.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7f3f4279-96bb-5f60-896b-4f6ea7d25a8e', 'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 'fb14cb2c-b4dd-5f8c-a74c-1f5fd93579ed', 'Khian Cuerdo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 2, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 5, 4.0, 'UFD', true, '(4 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9c35ce-03d3-54d6-8434-33cc9c6efbd9', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0515a7a8-e609-577f-871a-f0298c608123', '76df8c8f-3f8a-5cfb-80e1-84aa077aca71', '36540c79-2029-5704-baab-a46bec05c09d', 'Muhammad Syahzwan Bin Jefri', '111', 'individual', 3,
    40.0, 32.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Syahzwan Bin Jefri. Club: PERLIS. Division: Plus Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '97f9749e-30fe-5f7c-806c-557318ede131', '0515a7a8-e609-577f-871a-f0298c608123', '76df8c8f-3f8a-5cfb-80e1-84aa077aca71', 'Muhammad Syahzwan Bin Jefri', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0515a7a8-e609-577f-871a-f0298c608123', 1, 4.0, 'DNF', true, '(4 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0515a7a8-e609-577f-871a-f0298c608123', 2, 4.0, 'DNC', true, '(4 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0515a7a8-e609-577f-871a-f0298c608123', 3, 4.0, 'DNC', false, '4 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0515a7a8-e609-577f-871a-f0298c608123', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0515a7a8-e609-577f-871a-f0298c608123', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0515a7a8-e609-577f-871a-f0298c608123', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0515a7a8-e609-577f-871a-f0298c608123', 7, 4.0, 'DNC', false, '4 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0515a7a8-e609-577f-871a-f0298c608123', 8, 4.0, 'DNC', false, '4 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0515a7a8-e609-577f-871a-f0298c608123', 9, 4.0, 'DNC', false, '4 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0515a7a8-e609-577f-871a-f0298c608123', 10, 4.0, 'DNF', false, '4 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0515a7a8-e609-577f-871a-f0298c608123', 11, 4.0, 'DNF', false, '4 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — Techno 293 Plus Women
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '7774701e-fa16-5fb3-a61c-26c5d6b0718c',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — Techno 293 Plus Women',
    'langkawi-international-regatta-perdana-2026-techno-293-plus-women',
    '2026-02-12',
    '2026-02-12',
    2,
    'Plus Women',
    11,
    'MAS',
    'Techno 293',
    'individual',
    1,
    1,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    'a6167b74-173c-56ce-971a-492e1db12015', '3f0aaa81-cb50-567d-bf36-63f802d41cf5', '7774701e-fa16-5fb3-a61c-26c5d6b0718c', 'Tengku Nurani Ezaty Binti Tengku Kahirudeen', 'MAS 20', 'individual', 1,
    11.0, 9.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Tengku Nurani Ezaty Binti Tengku Kahirudeen. Club: MSN/MSA. Division: Plus Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '405e1666-948b-543c-84b1-874ba4ac7768', 'a6167b74-173c-56ce-971a-492e1db12015', '3f0aaa81-cb50-567d-bf36-63f802d41cf5', 'Tengku Nurani Ezaty Binti Tengku Kahirudeen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6167b74-173c-56ce-971a-492e1db12015', 1, 1.0, NULL, true, '(1)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6167b74-173c-56ce-971a-492e1db12015', 2, 1.0, NULL, true, '(1)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6167b74-173c-56ce-971a-492e1db12015', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6167b74-173c-56ce-971a-492e1db12015', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6167b74-173c-56ce-971a-492e1db12015', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6167b74-173c-56ce-971a-492e1db12015', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6167b74-173c-56ce-971a-492e1db12015', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6167b74-173c-56ce-971a-492e1db12015', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6167b74-173c-56ce-971a-492e1db12015', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6167b74-173c-56ce-971a-492e1db12015', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6167b74-173c-56ce-971a-492e1db12015', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7851f556-d9e5-553f-ae82-36370776f4c5', '59a84a2b-7c8f-5e7f-b925-06665d607191', '7774701e-fa16-5fb3-a61c-26c5d6b0718c', 'Angie Tan Ang Yee', 'MAS 3', 'individual', 2,
    22.0, 18.0, false, false, 'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing',
    'https://drive.google.com/file/d/1C-lDmocSOF-hs4oQy_kOSToNU6rrD0EH/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Angie Tan Ang Yee. Club: MSNT-TSA. Division: Plus Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8b753831-d8c8-5c90-bcad-d5d8d8ccc45e', '7851f556-d9e5-553f-ae82-36370776f4c5', '59a84a2b-7c8f-5e7f-b925-06665d607191', 'Angie Tan Ang Yee', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7851f556-d9e5-553f-ae82-36370776f4c5', 1, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7851f556-d9e5-553f-ae82-36370776f4c5', 2, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7851f556-d9e5-553f-ae82-36370776f4c5', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7851f556-d9e5-553f-ae82-36370776f4c5', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7851f556-d9e5-553f-ae82-36370776f4c5', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7851f556-d9e5-553f-ae82-36370776f4c5', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7851f556-d9e5-553f-ae82-36370776f4c5', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7851f556-d9e5-553f-ae82-36370776f4c5', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7851f556-d9e5-553f-ae82-36370776f4c5', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7851f556-d9e5-553f-ae82-36370776f4c5', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7851f556-d9e5-553f-ae82-36370776f4c5', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — ILCA 4 Men
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '603f4e9a-fa48-59f4-9fb3-0778f272dafe',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — ILCA 4 Men',
    'langkawi-international-regatta-perdana-2026-ilca-4-men',
    '2026-02-12',
    '2026-02-12',
    16,
    'Men',
    12,
    'MAS',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    'd2dc0bb8-6549-5009-ad26-584284c0352b', '4ab81121-eed4-5d26-84a0-7c233e31bc6d', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Muhammad Hilfi Nafael Bin Mohd Hasrizan', 'MAS 209886', 'individual', 1,
    35.0, 24.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Hilfi Nafael Bin Mohd Hasrizan. Club: MSN/MSA. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4dfefad7-1819-53da-9582-76dc8d0dc64f', 'd2dc0bb8-6549-5009-ad26-584284c0352b', '4ab81121-eed4-5d26-84a0-7c233e31bc6d', 'Muhammad Hilfi Nafael Bin Mohd Hasrizan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2dc0bb8-6549-5009-ad26-584284c0352b', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2dc0bb8-6549-5009-ad26-584284c0352b', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2dc0bb8-6549-5009-ad26-584284c0352b', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2dc0bb8-6549-5009-ad26-584284c0352b', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2dc0bb8-6549-5009-ad26-584284c0352b', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2dc0bb8-6549-5009-ad26-584284c0352b', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2dc0bb8-6549-5009-ad26-584284c0352b', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2dc0bb8-6549-5009-ad26-584284c0352b', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2dc0bb8-6549-5009-ad26-584284c0352b', 9, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2dc0bb8-6549-5009-ad26-584284c0352b', 10, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2dc0bb8-6549-5009-ad26-584284c0352b', 11, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2dc0bb8-6549-5009-ad26-584284c0352b', 12, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', '9a560745-0f52-4fd7-b4f9-f6409489ae84', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Muhammad Aiman Aqeel Bin Mohd Firdaus', '185185', 'individual', 2,
    36.0, 24.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Aiman Aqeel Bin Mohd Firdaus. Club: SABAH. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '253940dc-a484-5c30-800d-30044a6d7d9e', '8c421e0b-05ca-51a4-8b56-3726cbefb007', '9a560745-0f52-4fd7-b4f9-f6409489ae84', 'Muhammad Aiman Aqeel Bin Mohd Firdaus', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', 1, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', 4, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', 11, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c421e0b-05ca-51a4-8b56-3726cbefb007', 12, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', '3f8e7331-d3fe-56d2-b62d-14b9f485452b', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Haziq Mustaqim Bin Mohd Husni', 'MAS 221056', 'individual', 3,
    63.0, 45.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Haziq Mustaqim Bin Mohd Husni. Club: MSNT-TSA. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f988988b-d239-58d9-ae31-89fae25ac858', '276cac62-7297-545e-b93b-b4745f332ce9', '3f8e7331-d3fe-56d2-b62d-14b9f485452b', 'Haziq Mustaqim Bin Mohd Husni', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', 5, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', 9, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', 10, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', 11, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '276cac62-7297-545e-b93b-b4745f332ce9', 12, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', '05a574c4-6f79-5e25-8c19-285f43eb1b63', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Ahmad Tsauban Bin Ramli', '217838', 'individual', 4,
    82.0, 48.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Ahmad Tsauban Bin Ramli. Club: MSNK/KSA. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'cbf24302-877c-5609-be77-f3997ef0271e', '0552f0b4-db5b-55bd-bbbc-93b711f1164b', '05a574c4-6f79-5e25-8c19-285f43eb1b63', 'Ahmad Tsauban Bin Ramli', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', 1, 17.0, 'DNS', true, '(17 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', 2, 17.0, 'DNS', true, '(17 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', 3, 17.0, 'DNS', false, '17 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', 6, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', 8, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0552f0b4-db5b-55bd-bbbc-93b711f1164b', 12, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', '48f7a683-cf70-51e3-932a-e1544f08f6cd', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Xu Xiaoring', '221877', 'individual', 5,
    81.0, 54.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Xu Xiaoring. Club: XIAMEN. Division: Men. Nat: CHN.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5a87e1d8-d87b-574d-8abb-f851044f0947', 'c1c11f29-61f0-540a-b70b-37b1af7c3090', '48f7a683-cf70-51e3-932a-e1544f08f6cd', 'Xu Xiaoring', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', 1, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', 4, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', 6, 17.0, 'RET', true, '(17 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', 7, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', 9, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', 10, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1c11f29-61f0-540a-b70b-37b1af7c3090', 12, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', '0d87c76a-54be-5d3d-acfe-8ce144c04ca1', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Kim Junmo', '224680', 'individual', 6,
    78.0, 56.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Kim Junmo. Club: KSAF. Division: Men. Nat: KOR.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '24c421b5-9dff-51d1-abad-b6e3f80103c6', 'e21c6758-7563-54c8-87e4-67e96223386e', '0d87c76a-54be-5d3d-acfe-8ce144c04ca1', 'Kim Junmo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', 1, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', 2, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', 6, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', 7, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', 9, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', 10, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', 11, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21c6758-7563-54c8-87e4-67e96223386e', 12, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 'a55b0e5b-682d-5fe8-ae8f-2f3b0bed2dc8', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Muhammad Adam Firdaus Bin Zainal Abidin', '207094', 'individual', 7,
    94.0, 62.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Adam Firdaus Bin Zainal Abidin. Club: SELANGOR. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5053f0b6-bf86-5101-947c-6eefa0b53268', '41481468-5334-563c-ba08-5466ee20739a', 'a55b0e5b-682d-5fe8-ae8f-2f3b0bed2dc8', 'Muhammad Adam Firdaus Bin Zainal Abidin', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 5, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 6, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 7, 15.0, NULL, true, '(15)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 8, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 9, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 10, 17.0, 'DSQ', true, '(17 DSQ)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 11, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41481468-5334-563c-ba08-5466ee20739a', 12, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', '7c98de8c-7b60-5fa7-a90e-d8349ed96b86', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Muhammad Hadif Nabihan Bin Rashidi', 'MAS 206792', 'individual', 8,
    88.0, 68.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Hadif Nabihan Bin Rashidi. Club: PERLIS. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b58e2730-0b4e-54c8-b51e-93c3ba3e8e8e', 'e8565e15-3490-5bef-b1fe-e37dcf80284c', '7c98de8c-7b60-5fa7-a90e-d8349ed96b86', 'Muhammad Hadif Nabihan Bin Rashidi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', 1, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', 3, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', 5, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', 7, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', 8, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', 9, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', 10, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', 11, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8565e15-3490-5bef-b1fe-e37dcf80284c', 12, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', '3b8c9fed-9111-5e5a-b0e7-8dadc53d2511', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Muhammad Haikal Iskandar B. Haironizam', '210226', 'individual', 9,
    90.0, 69.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Haikal Iskandar B. Haironizam. Club: MSN PERAK. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7ef0dc99-630b-59ff-bdb4-930fad9e2b01', '37e7ae72-fd3d-5bec-9f81-2661948d75d8', '3b8c9fed-9111-5e5a-b0e7-8dadc53d2511', 'Muhammad Haikal Iskandar B. Haironizam', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', 2, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', 3, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', 4, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', 5, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', 6, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', 8, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', 9, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', 10, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', 11, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '37e7ae72-fd3d-5bec-9f81-2661948d75d8', 12, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 'aada8925-cb09-4adb-8bdc-c6b8c2d0a20d', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Charles Kong', 'SGP 227676', 'individual', 10,
    102.0, 73.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Charles Kong. Club: CHANGI SAILING CLUB. Division: Men. Nat: SGP.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '11ae741e-e5f9-570f-9f0c-8d3ff4122898', 'f02855d5-164b-5779-9106-c39cb3ad1685', 'aada8925-cb09-4adb-8bdc-c6b8c2d0a20d', 'Charles Kong', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 1, 14.0, NULL, true, '(14)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 2, 15.0, NULL, true, '(15)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 4, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 5, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 7, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 8, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 9, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 10, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 11, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f02855d5-164b-5779-9106-c39cb3ad1685', 12, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', '979f1f91-dfb2-58aa-a17a-44293382c34d', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Muhammad Izzul Arshad Bin Zulkarnain', '225710', 'individual', 11,
    120.0, 90.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Izzul Arshad Bin Zulkarnain. Club: MS PAHANG. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd56a6605-cd05-5708-9aaa-5ef7514b2003', '46267ed5-23c4-59fd-8073-669a29d2b284', '979f1f91-dfb2-58aa-a17a-44293382c34d', 'Muhammad Izzul Arshad Bin Zulkarnain', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', 1, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', 3, 13.0, NULL, true, '(13)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', 4, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', 5, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', 6, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', 8, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', 10, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', 11, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '46267ed5-23c4-59fd-8073-669a29d2b284', 12, 17.0, 'RET', true, '(17 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', '0cb5bbd8-bae4-5988-953b-e9ea98e6ba02', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Muhammad Ammar Zikri Bin Azman', '213185', 'individual', 12,
    140.0, 110.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Ammar Zikri Bin Azman. Club: MSNT-TSA. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '307d04d0-8146-5891-bb3e-b3e374410473', 'e4755928-280d-59ed-aa72-6f167c2629cd', '0cb5bbd8-bae4-5988-953b-e9ea98e6ba02', 'Muhammad Ammar Zikri Bin Azman', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', 1, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', 2, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', 3, 17.0, 'DNF', true, '(17 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', 4, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', 5, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', 6, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', 7, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', 8, 13.0, NULL, true, '(13)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', 9, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', 10, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', 11, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4755928-280d-59ed-aa72-6f167c2629cd', 12, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', '0289f4b4-118b-5f4b-962b-f4fc5428021a', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Lee Buhyun', '224677', 'individual', 13,
    150.0, 116.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Lee Buhyun. Club: BSC(KOREA). Division: Men. Nat: KOR.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7427dc12-b5cb-5c66-84f7-9555b7969201', '130a1c98-a440-53dc-bf0e-0528ea6f5c59', '0289f4b4-118b-5f4b-962b-f4fc5428021a', 'Lee Buhyun', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', 3, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', 4, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', 5, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', 6, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', 7, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', 8, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', 9, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', 10, 17.0, 'RET', true, '(17 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', 11, 17.0, 'DNF', true, '(17 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '130a1c98-a440-53dc-bf0e-0528ea6f5c59', 12, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', '76f020a1-6591-53a2-81c4-e1e638505628', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Awallymuiz Bin Mohzeiswandi', 'MAS 222439', 'individual', 14,
    153.0, 125.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Awallymuiz Bin Mohzeiswandi. Club: MSN PENANG. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '22fb1a15-937e-5827-80be-7c8e950eecdd', '1bec338a-f668-5175-ba5b-4669e56ac659', '76f020a1-6591-53a2-81c4-e1e638505628', 'Awallymuiz Bin Mohzeiswandi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', 1, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', 2, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', 3, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', 4, 14.0, NULL, true, '(14)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', 5, 14.0, NULL, true, '(14)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', 6, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', 7, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', 8, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', 9, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', 10, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', 11, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1bec338a-f668-5175-ba5b-4669e56ac659', 12, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', '7717423d-94bb-572a-b3c6-ddb37b67576c', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Muhammad Khalish Kashfi Bin Mohd Husney', '206796', 'individual', 15,
    158.0, 128.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Khalish Kashfi Bin Mohd Husney. Club: MSNK/KSA. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '263347a3-40e8-576d-9a61-90e5ba94a388', 'ce0b0f3c-6000-54f9-801e-9a4203547749', '7717423d-94bb-572a-b3c6-ddb37b67576c', 'Muhammad Khalish Kashfi Bin Mohd Husney', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', 1, 15.0, NULL, true, '(15)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', 2, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', 3, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', 4, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', 5, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', 6, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', 7, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', 8, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', 9, 15.0, NULL, true, '(15)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', 10, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', 11, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ce0b0f3c-6000-54f9-801e-9a4203547749', 12, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 'e1eedc58-7114-5046-b317-4d3184ae1118', '603f4e9a-fa48-59f4-9fb3-0778f272dafe', 'Gene Fu Fengkai', 'CHN225956', 'individual', 16,
    187.0, 153.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Gene Fu Fengkai. Club: CHINA. Division: Men. Nat: CHN.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '10baf105-c2d4-5b59-aa08-431c4083340e', '2514fa78-9644-5f29-9305-3ef7b7dc562b', 'e1eedc58-7114-5046-b317-4d3184ae1118', 'Gene Fu Fengkai', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 1, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 2, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 3, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 4, 17.0, 'RET', true, '(17 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 5, 17.0, 'RET', true, '(17 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 6, 17.0, 'RET', false, '17 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 7, 17.0, 'DNF', false, '17 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 8, 17.0, 'DNF', false, '17 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 9, 17.0, 'DNC', false, '17 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 10, 17.0, 'DNF', false, '17 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 11, 17.0, 'DNF', false, '17 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2514fa78-9644-5f29-9305-3ef7b7dc562b', 12, 17.0, 'DNF', false, '17 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — ILCA 4 Women
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '01f3cb7c-2724-56cb-be6b-982d2dd29cd2',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — ILCA 4 Women',
    'langkawi-international-regatta-perdana-2026-ilca-4-women',
    '2026-02-12',
    '2026-02-12',
    13,
    'Women',
    12,
    'MAS',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', '96bfe722-1e1a-4e2c-901e-dae4789973ac', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Nur Hafizanah Binti Zailan', 'MAS 209891', 'individual', 1,
    27.0, 19.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Nur Hafizanah Binti Zailan. Club: MSA MSN PELAPIS. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3a7638c1-d52c-525e-8567-f9592baa209d', 'b5d600c7-d4d5-52d8-bb80-328826a236e8', '96bfe722-1e1a-4e2c-901e-dae4789973ac', 'Nur Hafizanah Binti Zailan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', 6, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', 7, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', 10, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5d600c7-d4d5-52d8-bb80-328826a236e8', 12, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', '59978bb7-0c9a-5e65-85de-bd7153301709', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Lee Songha', '223204', 'individual', 2,
    32.0, 20.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Lee Songha. Club: KSAF. Division: Women. Nat: KOR.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0021e204-be72-584c-991e-54670f64f4db', 'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', '59978bb7-0c9a-5e65-85de-bd7153301709', 'Lee Songha', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', 2, 4.0, NULL, true, '(4)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', 7, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc70a8ee-fb35-59ca-a7af-8a88a8db8ea7', 12, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 'e7045456-266c-5f5a-a7b9-4f95ac17f66c', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Dhaifina Natallia Binti Shazlisham', 'MAS 213186', 'individual', 3,
    49.0, 30.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Dhaifina Natallia Binti Shazlisham. Club: MSNT-TSA. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '30c80b01-734b-5415-80ae-af53940050af', '9864d27c-1b45-5530-a82c-0177ef8bd783', 'e7045456-266c-5f5a-a7b9-4f95ac17f66c', 'Dhaifina Natallia Binti Shazlisham', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 5, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 8, 14.0, 'UFD', true, '(14 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 11, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9864d27c-1b45-5530-a82c-0177ef8bd783', 12, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', '126eaba9-16e6-40ef-9f4b-822df0550b41', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Sara Amanda Binti Mohd Noor Azman', 'MAS 209888', 'individual', 4,
    46.0, 33.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Sara Amanda Binti Mohd Noor Azman. Club: MSA/MSN. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '02e35051-958a-593a-b531-8deeb1d2a0e2', 'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', '126eaba9-16e6-40ef-9f4b-822df0550b41', 'Sara Amanda Binti Mohd Noor Azman', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', 6, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', 9, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', 10, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', 11, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7a0dd84-3b97-5b5c-ba4d-5372f4961e70', 12, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 'f7c2b125-af12-5716-98bf-b05bfaa6666b', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Aina Qasrina Binti Yuslizam', 'MAS 206789', 'individual', 5,
    53.0, 38.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Aina Qasrina Binti Yuslizam. Club: PERLIS. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0b34a8de-e5f2-52aa-9b58-abb13886a017', 'a2897ed2-246f-5281-a433-57c7d994f411', 'f7c2b125-af12-5716-98bf-b05bfaa6666b', 'Aina Qasrina Binti Yuslizam', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 1, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 8, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 9, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 10, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 11, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2897ed2-246f-5281-a433-57c7d994f411', 12, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 'd583f482-a971-5f83-abb1-8d1f42cc7974', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Humaira Qurratulaini Bt. Muhamad Arief', '210227', 'individual', 6,
    80.0, 61.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Humaira Qurratulaini Bt. Muhamad Arief. Club: MSN PERAK. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '120d263d-8e71-5411-9815-7d4f1aabea94', '514e822f-cc82-5464-b97a-4c89c53e0e12', 'd583f482-a971-5f83-abb1-8d1f42cc7974', 'Humaira Qurratulaini Bt. Muhamad Arief', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 1, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 3, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 4, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 5, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 9, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 10, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 11, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '514e822f-cc82-5464-b97a-4c89c53e0e12', 12, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', '52fc293d-43c5-5ab1-bb46-15406e652607', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Nur Amina Fatehah Binti Azmi', '215061', 'individual', 7,
    83.0, 63.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Nur Amina Fatehah Binti Azmi. Club: MSNK/KSA. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7aaaf460-c39c-552b-b317-748efecaefc8', 'a440adda-f04e-512d-99bd-06c896356d57', '52fc293d-43c5-5ab1-bb46-15406e652607', 'Nur Amina Fatehah Binti Azmi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', 4, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', 5, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', 6, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', 7, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', 9, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', 10, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', 11, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a440adda-f04e-512d-99bd-06c896356d57', 12, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', '36daa0e1-333c-5f4c-b5c1-435e38c6f948', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Nur ''Ain Binti Syahrizan', '210602', 'individual', 8,
    90.0, 67.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Nur ''Ain Binti Syahrizan. Club: MSN SARAWAK. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'deefb3dd-cea0-5759-9cc4-0b302778f1cf', '011b0014-dac3-529e-ba19-69c50a98abe2', '36daa0e1-333c-5f4c-b5c1-435e38c6f948', 'Nur ''Ain Binti Syahrizan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', 1, 14.0, 'DNF', true, '(14 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', 5, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', 6, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', 7, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', 8, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', 9, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', 10, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', 11, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '011b0014-dac3-529e-ba19-69c50a98abe2', 12, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 'bd617971-6ff4-55f2-9542-f0705b8a72f4', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Aisya Farisya Binti Mohd Aziran', '221057', 'individual', 9,
    117.0, 91.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Aisya Farisya Binti Mohd Aziran. Club: MSNT-TSA. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '39d90f59-1b08-5d53-abf5-a5f6ecc4dfd3', 'dd2a19d3-7125-5f78-9257-6c14c8708d82', 'bd617971-6ff4-55f2-9542-f0705b8a72f4', 'Aisya Farisya Binti Mohd Aziran', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 1, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 2, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 3, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 4, 14.0, 'DNC', true, '(14 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 5, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 6, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 8, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 9, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 10, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 11, 12.0, NULL, true, '(12)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd2a19d3-7125-5f78-9257-6c14c8708d82', 12, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 'f6623824-d20b-5439-a53c-8af02181a014', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Huahg Chenyue', '218507', 'individual', 10,
    113.0, 91.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Huahg Chenyue. Club: XIAMEN. Division: Women. Nat: CHN.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6120dcdd-3bf6-5a01-bbf7-ff6904e2bb8f', '3970fc72-433b-51f8-906e-ad5ce96ca5df', 'f6623824-d20b-5439-a53c-8af02181a014', 'Huahg Chenyue', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 1, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 2, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 3, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 4, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 5, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 6, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 7, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 8, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 9, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 10, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 11, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3970fc72-433b-51f8-906e-ad5ce96ca5df', 12, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', '6f1134e3-125c-5b25-b2a8-91fa7c37971d', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Nur Elena Zahra Binti Mohd Azrin', '204323', 'individual', 11,
    116.0, 91.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Nur Elena Zahra Binti Mohd Azrin. Club: SELANGOR. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '92ca7e82-c3b3-571c-ad00-05bca5d606a7', '7f49f044-2e8d-5bc6-8cc5-751276503595', '6f1134e3-125c-5b25-b2a8-91fa7c37971d', 'Nur Elena Zahra Binti Mohd Azrin', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', 1, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', 2, 14.0, 'DNF', true, '(14 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', 3, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', 4, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', 5, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', 6, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', 7, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', 8, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', 9, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', 10, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', 11, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f49f044-2e8d-5bc6-8cc5-751276503595', 12, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 'bb3a2667-c68d-5c1e-a0c9-571847f45b70', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Mas Vanya Kirstyn Teruki', '210603', 'individual', 12,
    146.0, 118.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Mas Vanya Kirstyn Teruki. Club: MSN SARAWAK. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dcc35818-c70b-5277-8c49-cee403be7233', 'ae315893-e853-5118-b46f-926fa93ca81c', 'bb3a2667-c68d-5c1e-a0c9-571847f45b70', 'Mas Vanya Kirstyn Teruki', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 1, 14.0, 'DNF', true, '(14 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 2, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 3, 14.0, 'DNF', true, '(14 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 4, 14.0, 'DNF', false, '14 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 5, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 6, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 7, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 8, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 9, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 10, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 11, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae315893-e853-5118-b46f-926fa93ca81c', 12, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', '63f8a7e1-71cd-550c-a3b7-07ae06cde9f9', '01f3cb7c-2724-56cb-be6b-982d2dd29cd2', 'Eva Maria Medyna Binti Norzaimy', 'MAS', 'individual', 13,
    168.0, 140.0, false, false, 'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing',
    'https://drive.google.com/file/d/1YyWTE5XwT6eXpEVKRFpqijACTk6LHuGx/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Eva Maria Medyna Binti Norzaimy. Club: MSN PENANG. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8d3d7cf9-5753-5b35-b2f5-c9fe5f4205e3', '2d2356d9-0128-560d-a49b-14ed8ad6d287', '63f8a7e1-71cd-550c-a3b7-07ae06cde9f9', 'Eva Maria Medyna Binti Norzaimy', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', 1, 14.0, 'DNF', true, '(14 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', 2, 14.0, 'DNF', true, '(14 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', 3, 14.0, 'DNF', false, '14 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', 4, 14.0, 'DNF', false, '14 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', 5, 14.0, 'DNF', false, '14 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', 6, 14.0, 'DNF', false, '14 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', 7, 14.0, 'DNF', false, '14 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', 8, 14.0, 'DNF', false, '14 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', 9, 14.0, 'DNC', false, '14 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', 10, 14.0, 'DNC', false, '14 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', 11, 14.0, 'DNC', false, '14 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d2356d9-0128-560d-a49b-14ed8ad6d287', 12, 14.0, 'DNC', false, '14 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — ILCA 6 Men
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'dbcdbe38-66d9-514a-9952-2b63b37501db',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — ILCA 6 Men',
    'langkawi-international-regatta-perdana-2026-ilca-6-men',
    '2026-02-12',
    '2026-02-12',
    11,
    'Men',
    12,
    'MAS',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    '19242a30-9971-5d77-a62c-ae6590551fd9', 'b953fc9b-8e11-5982-bcfd-874d440c373b', 'dbcdbe38-66d9-514a-9952-2b63b37501db', 'Muhammad Fikri Aqil Bin Mohd Fouzi', '221056', 'individual', 1,
    40.0, 16.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Fikri Aqil Bin Mohd Fouzi. Club: MSNT-TSA. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a0e4d827-0878-5453-bca3-025541023cfb', '19242a30-9971-5d77-a62c-ae6590551fd9', 'b953fc9b-8e11-5982-bcfd-874d440c373b', 'Muhammad Fikri Aqil Bin Mohd Fouzi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19242a30-9971-5d77-a62c-ae6590551fd9', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19242a30-9971-5d77-a62c-ae6590551fd9', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19242a30-9971-5d77-a62c-ae6590551fd9', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19242a30-9971-5d77-a62c-ae6590551fd9', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19242a30-9971-5d77-a62c-ae6590551fd9', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19242a30-9971-5d77-a62c-ae6590551fd9', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19242a30-9971-5d77-a62c-ae6590551fd9', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19242a30-9971-5d77-a62c-ae6590551fd9', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19242a30-9971-5d77-a62c-ae6590551fd9', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19242a30-9971-5d77-a62c-ae6590551fd9', 10, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19242a30-9971-5d77-a62c-ae6590551fd9', 11, 12.0, 'RET', true, '(12 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19242a30-9971-5d77-a62c-ae6590551fd9', 12, 12.0, 'RET', true, '(12 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', '0734265d-4f61-5c1e-ae03-6f39847bbd1c', 'dbcdbe38-66d9-514a-9952-2b63b37501db', 'Muhammad Iman Amru Al As Bin Rasdan', '217859', 'individual', 2,
    35.0, 25.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Muhammad Iman Amru Al As Bin Rasdan. Club: MS PAHANG. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dcf26786-3b30-59b0-88c0-62d8b4bdf7de', '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', '0734265d-4f61-5c1e-ae03-6f39847bbd1c', 'Muhammad Iman Amru Al As Bin Rasdan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', 6, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', 7, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', 10, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f0ecabf-d9b4-5053-b98b-3d87ccc3be5a', 12, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', '8aabfea9-a419-5648-9b0d-b07ce894ea6e', 'dbcdbe38-66d9-514a-9952-2b63b37501db', 'Ammar Bin Azali', '227279', 'individual', 3,
    43.0, 29.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Ammar Bin Azali. Club: PERLIS. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6836aaed-46d7-5bbe-874c-602ce489c33d', '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', '8aabfea9-a419-5648-9b0d-b07ce894ea6e', 'Ammar Bin Azali', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', 5, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', 7, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', 10, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', 11, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a69e5b0-d940-58b6-a87d-6a9ddb12c51b', 12, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 'bba09e45-d786-5773-9694-800d0641f833', 'dbcdbe38-66d9-514a-9952-2b63b37501db', 'Afwan Bin Amir Harun', 'MAS 840545', 'individual', 4,
    43.0, 32.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Afwan Bin Amir Harun. Club: PPTLDM. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e36cc5d5-9a29-58b1-9511-c0be068bf0a7', '0b0af0c3-a986-5329-875b-20140d780c39', 'bba09e45-d786-5773-9694-800d0641f833', 'Afwan Bin Amir Harun', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 1, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 5, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 9, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b0af0c3-a986-5329-875b-20140d780c39', 12, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', '76b64bcc-6b88-515a-8759-89e4c015ca3d', 'dbcdbe38-66d9-514a-9952-2b63b37501db', 'Mohammad Syahieradham Bin Raiman', '219283', 'individual', 5,
    67.0, 49.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Mohammad Syahieradham Bin Raiman. Club: SABAH. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1223794c-d2fe-52f4-840a-87294ac415c0', 'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', '76b64bcc-6b88-515a-8759-89e4c015ca3d', 'Mohammad Syahieradham Bin Raiman', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', 1, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', 2, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', 7, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', 8, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', 9, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', 10, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', 11, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3e2ace9-cdec-5233-b3f3-d60ea0baa1d8', 12, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', '709a793b-9bc0-5708-89e4-18afc8c48d2d', 'dbcdbe38-66d9-514a-9952-2b63b37501db', 'Farish Hanif Bin Zamri', '210607', 'individual', 6,
    65.0, 50.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Farish Hanif Bin Zamri. Club: MSN SARAWAK. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3a7f229a-20ef-5f35-ad75-e42dfbd5c709', '59fec0ea-163f-5beb-89e5-6db91caa64aa', '709a793b-9bc0-5708-89e4-18afc8c48d2d', 'Farish Hanif Bin Zamri', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', 3, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', 6, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', 7, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', 9, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', 11, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59fec0ea-163f-5beb-89e5-6db91caa64aa', 12, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 'c76a1a28-6931-5653-97a8-2b91b0daec03', 'dbcdbe38-66d9-514a-9952-2b63b37501db', 'Danish Zafran Bin Rozali', '197854', 'individual', 7,
    82.0, 64.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Danish Zafran Bin Rozali. Club: SELANGOR. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd3d542da-21a9-5262-ab2b-9a0c75ff6b3a', 'fa78ab9f-a182-5ab9-ad61-0274243249a5', 'c76a1a28-6931-5653-97a8-2b91b0daec03', 'Danish Zafran Bin Rozali', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 1, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 4, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 6, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 8, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 9, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 10, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 11, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa78ab9f-a182-5ab9-ad61-0274243249a5', 12, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', '92ede04b-c400-57fd-928d-2852566682aa', 'dbcdbe38-66d9-514a-9952-2b63b37501db', 'Karl Brady', '193112', 'individual', 8,
    84.0, 66.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Karl Brady. Club: SSCA. Division: Men. Nat: GBR.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a8d0e05f-cd78-53ad-a4a3-fc9483498b4c', 'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', '92ede04b-c400-57fd-928d-2852566682aa', 'Karl Brady', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', 4, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', 5, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', 6, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', 7, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', 8, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', 9, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', 10, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', 11, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1d555ea-ae1c-5087-ad33-4b683fd3f38a', 12, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', '8c4234ba-4e3a-5322-afcf-c8b9818adc0d', 'dbcdbe38-66d9-514a-9952-2b63b37501db', 'Amirul Zikry Bin Norashiddin', '196779', 'individual', 9,
    87.0, 69.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Amirul Zikry Bin Norashiddin. Club: MSWP. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '93135859-d879-5dc3-b252-fd1dffaf2138', '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', '8c4234ba-4e3a-5322-afcf-c8b9818adc0d', 'Amirul Zikry Bin Norashiddin', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', 1, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', 3, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', 4, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', 5, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', 6, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', 8, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', 9, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', 10, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', 11, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d51bf8b-ee09-59ef-94ba-d39f781bc8df', 12, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 'fa29a3fe-bc57-55c0-b6fd-36c9ad8b34a5', 'dbcdbe38-66d9-514a-9952-2b63b37501db', 'Ahmad Umar Bin Mohd Nizar', 'MAS 88', 'individual', 10,
    128.0, 104.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Ahmad Umar Bin Mohd Nizar. Club: MELAKA. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f0273991-4330-575d-84b0-6e47048c0bc8', '74f970c2-2c87-57a6-a665-3e086e464d8b', 'fa29a3fe-bc57-55c0-b6fd-36c9ad8b34a5', 'Ahmad Umar Bin Mohd Nizar', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 1, 12.0, 'DNF', true, '(12 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 2, 12.0, 'DNF', true, '(12 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 3, 12.0, 'DNF', false, '12 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 4, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 5, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 6, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 7, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 8, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 9, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 10, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 11, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74f970c2-2c87-57a6-a665-3e086e464d8b', 12, 12.0, 'DNF', false, '12 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', '1db2931e-11b3-5a4c-9f03-443a1e17e958', 'dbcdbe38-66d9-514a-9952-2b63b37501db', 'Mohd Isahmuddin Bin Maming', '841356', 'individual', 11,
    129.0, 105.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Mohd Isahmuddin Bin Maming. Club: TLDM. Division: Men. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '53273bd5-a6b2-5ba3-9c0c-8a2966542f6b', '4814911f-77c2-5d60-8aa0-6a04efbb681b', '1db2931e-11b3-5a4c-9f03-443a1e17e958', 'Mohd Isahmuddin Bin Maming', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', 1, 12.0, 'DNF', true, '(12 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', 2, 12.0, 'DNF', true, '(12 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', 3, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', 4, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', 5, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', 6, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', 7, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', 8, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', 9, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', 10, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', 11, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4814911f-77c2-5d60-8aa0-6a04efbb681b', 12, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: 22nd Langkawi International Regatta Perdana 2026 — ILCA 6 Women
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'b12abee8-a54c-5ed7-8868-aa77884b2bde',
    '58e20ba5-f1e4-4895-9387-231273b43421',
    '22nd Langkawi International Regatta Perdana 2026 — ILCA 6 Women',
    'langkawi-international-regatta-perdana-2026-ilca-6-women',
    '2026-02-12',
    '2026-02-12',
    11,
    'Women',
    12,
    'MAS',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Kedah Sailing Association / Malaysia Sailing Association',
    'published',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'Official Final Results PDF from Kedah Sailing Association / MSA',
    'Official Langkawi International Regatta Perdana 2026 final results.',
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
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 'f2fc7707-469f-5bfc-b583-e4c2e93829ac', 'b12abee8-a54c-5ed7-8868-aa77884b2bde', 'Yumiko Tombe', '202611', 'individual', 1,
    18.0, 13.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Yumiko Tombe. Club: TSAF. Division: Women. Nat: JPN.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c6c4163e-1ae5-5778-b965-d4bde7fd859a', '31c9bef1-c168-5080-a7ca-1c498e15b430', 'f2fc7707-469f-5bfc-b583-e4c2e93829ac', 'Yumiko Tombe', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 4, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 6, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31c9bef1-c168-5080-a7ca-1c498e15b430', 12, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', '9a71b922-1236-52ad-83b6-8810421a88ff', 'b12abee8-a54c-5ed7-8868-aa77884b2bde', 'Jung Hyewon', '222960', 'individual', 2,
    22.0, 15.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Jung Hyewon. Club: KSAF. Division: Women. Nat: KOR.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '33f915ff-5dee-5786-ae3f-b06f672283f2', 'df220409-6f7f-5b99-bd5c-464563bc62ce', '9a71b922-1236-52ad-83b6-8810421a88ff', 'Jung Hyewon', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', 1, 2.0, NULL, true, '(2)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', 7, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df220409-6f7f-5b99-bd5c-464563bc62ce', 12, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 'c9e9c7ed-d987-5646-be1a-46a5c6399497', 'b12abee8-a54c-5ed7-8868-aa77884b2bde', 'Nur Ku Zarith Binti Jaa''far', '206800', 'individual', 3,
    51.0, 34.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Nur Ku Zarith Binti Jaa''far. Club: MSWP. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b2746c8f-114e-5ae5-a5c1-daf4ce57ac1b', 'c388791b-6449-5309-b4d4-d4d80ebfd323', 'c9e9c7ed-d987-5646-be1a-46a5c6399497', 'Nur Ku Zarith Binti Jaa''far', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 4, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 5, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 6, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 10, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 11, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c388791b-6449-5309-b4d4-d4d80ebfd323', 12, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 'b33f7ace-2a40-5394-8858-007b26ae3163', 'b12abee8-a54c-5ed7-8868-aa77884b2bde', 'Nur Zafrina Syuhada Binti Mohd Zailan', 'MAS 209878', 'individual', 4,
    45.0, 34.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Nur Zafrina Syuhada Binti Mohd Zailan. Club: MSA/MSN. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1f26f1d0-b313-5068-841f-247e19c70b9d', '0ef47555-19b1-5e4e-8c03-205085e51dfe', 'b33f7ace-2a40-5394-8858-007b26ae3163', 'Nur Zafrina Syuhada Binti Mohd Zailan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 9, 6.0, NULL, true, '(6)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 10, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 11, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0ef47555-19b1-5e4e-8c03-205085e51dfe', 12, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', '87b64c29-9e86-5fe3-97f2-01d0a7e02165', 'b12abee8-a54c-5ed7-8868-aa77884b2bde', 'Nur Arfah Harizsya Bt. A''adnan', '212220', 'individual', 5,
    76.0, 56.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Nur Arfah Harizsya Bt. A''adnan. Club: MSN PERAK. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'cdc6bee6-41c6-5db6-9bcc-acbf6f44c737', '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', '87b64c29-9e86-5fe3-97f2-01d0a7e02165', 'Nur Arfah Harizsya Bt. A''adnan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', 1, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', 4, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', 5, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', 6, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', 7, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', 9, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', 10, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', 11, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4fc0d593-5223-53b6-9c2f-4f85170fd1b3', 12, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 'cb3a63b6-8117-5da4-b2ad-c606b89847db', 'b12abee8-a54c-5ed7-8868-aa77884b2bde', 'Angeline Pei Wright', '215058', 'individual', 6,
    83.0, 62.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Angeline Pei Wright. Club: MSNK/KSA. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '820d151b-df9a-58db-8838-25f0ab2b72eb', '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 'cb3a63b6-8117-5da4-b2ad-c606b89847db', 'Angeline Pei Wright', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 1, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 5, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 6, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 7, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 8, 12.0, 'RET', true, '(12 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 9, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 10, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 11, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b6d3ad6-ef22-5d2c-b38f-9dada7519261', 12, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 'ce278b06-d698-5f58-b57b-e901c9f7b859', 'b12abee8-a54c-5ed7-8868-aa77884b2bde', 'Nur Faarihah Binti Abdul Rani', '205779', 'individual', 7,
    85.0, 67.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Nur Faarihah Binti Abdul Rani. Club: MSNT-TSA. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '46481ad0-3a43-5d41-a401-4c2901579b9f', '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 'ce278b06-d698-5f58-b57b-e901c9f7b859', 'Nur Faarihah Binti Abdul Rani', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 3, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 6, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 8, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 9, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 10, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 11, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '81a0e71a-4bd1-5c0e-991d-8ef58df388bd', 12, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', '0964f4f8-25aa-53a0-87c3-3cc4e4b93b58', 'b12abee8-a54c-5ed7-8868-aa77884b2bde', 'Ainur Mardhiah Binti Mohd Shailannie', '225713', 'individual', 8,
    89.0, 69.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Ainur Mardhiah Binti Mohd Shailannie. Club: MS PAHANG. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ac66c9a0-6c4b-53b0-a080-7ea68db8d2ce', '0778fc88-28de-5f67-9e8c-41884d26b4a1', '0964f4f8-25aa-53a0-87c3-3cc4e4b93b58', 'Ainur Mardhiah Binti Mohd Shailannie', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', 1, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', 2, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', 3, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', 5, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', 8, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', 9, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', 10, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', 11, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0778fc88-28de-5f67-9e8c-41884d26b4a1', 12, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', '0285e1be-3c9f-5d9e-a21a-21f995a09436', 'b12abee8-a54c-5ed7-8868-aa77884b2bde', 'Nur Hafizahanani Binti Zailan', '224712', 'individual', 9,
    89.0, 69.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Nur Hafizahanani Binti Zailan. Club: SABAH. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '161a9e02-b425-594f-a22f-abc7e8103c91', '0408331c-19d8-5c42-b441-8acb3912796d', '0285e1be-3c9f-5d9e-a21a-21f995a09436', 'Nur Hafizahanani Binti Zailan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', 1, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', 4, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', 7, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', 8, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', 9, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', 10, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', 11, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0408331c-19d8-5c42-b441-8acb3912796d', 12, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 'aa32a80e-daae-5beb-81f4-47f68f292b92', 'b12abee8-a54c-5ed7-8868-aa77884b2bde', 'Zeti Irdina Binti Zainal', '196769', 'individual', 10,
    104.0, 84.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Zeti Irdina Binti Zainal. Club: SABAH. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '77872e27-c056-5d22-832c-1b146e477b2a', 'cf652e53-7002-5773-a77c-f8a38634b747', 'aa32a80e-daae-5beb-81f4-47f68f292b92', 'Zeti Irdina Binti Zainal', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 1, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 2, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 3, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 4, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 5, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 6, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 7, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 8, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 9, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 10, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 11, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf652e53-7002-5773-a77c-f8a38634b747', 12, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 'd66bce28-eef0-57f8-8c00-679446eca2bd', 'b12abee8-a54c-5ed7-8868-aa77884b2bde', 'Qaisarah Damia Binti Mohamad Faizal', '210598', 'individual', 11,
    135.0, 111.0, false, false, 'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing',
    'https://drive.google.com/file/d/1Ea1dxcs8ONM-QOgrkv2jVYtIggdbRDDM/view?usp=sharing', 'Official LIRP 2026 Results PDF',
    'document', 'LIRP 2026. Sailor: Qaisarah Damia Binti Mohamad Faizal. Club: MSN SARAWAK. Division: Women. Nat: MAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '83748ba7-19b8-5283-9e44-12b8056734de', '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 'd66bce28-eef0-57f8-8c00-679446eca2bd', 'Qaisarah Damia Binti Mohamad Faizal', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 1, 12.0, 'RET', true, '(12 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 2, 12.0, 'DNF', true, '(12 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 3, 12.0, 'DNF', false, '12 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 4, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 5, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 6, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 7, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 8, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 9, 12.0, 'DNF', false, '12 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 10, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 11, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67813e00-7f42-5b6e-b7e9-065de0a3dfb5', 12, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

COMMIT;
