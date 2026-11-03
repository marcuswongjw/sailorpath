-- Migration 172: Import Hong Kong Race Week 2026 — 29er Asian Championship & ILCA 6
--
-- Imports the official championship results for:
-- Event: Hong Kong Race Week 2026
-- Venue: Royal Hong Kong Yacht Club, Middle Island, Hong Kong
-- Dates: 27 January – 1 February 2026
-- Authority: Sailing Federation of Hong Kong, China (HKSF) & Royal Hong Kong Yacht Club (RHKYC)
--
-- 1. 2026 29er Asian Championship: 25 boats (50 sailors), 11 races, 2 discards
-- 2. Hong Kong Race Week 2026 (ILCA 6): 13 boats (13 sailors), 8 races, 2 discards
--
-- Sources:
-- - 29er: https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm
-- - ILCA 6: https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm
--
-- All operations execute in a single atomic transaction.

BEGIN;

-- 1. Insert New Verified Sailor Profiles
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7b500a87-14e9-5240-be8a-4553021e0544', 'Nicholas Hon', 'nicholas-hon-a970b1', '3053', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f462d56c-e354-5b0d-945c-faaa30b0d382', 'Kaden Chan', 'kaden-chan-fd4bf3', '3053', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0035813f-6b37-5dad-970e-1d43e5fde57c', 'McCarley Wong', 'mccarley-wong-e938b7', '3355', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ad1da805-d827-5d22-9f38-f47cb18697b8', 'Hins Law', 'hins-law-2a1a5e', '3055', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c53b02b5-9285-5325-9edd-12e07f01e4e1', 'Ayden Pang', 'ayden-pang-7622a7', '3398', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b7d88773-fe00-5fb1-a6d0-91d905be4d10', 'Xu Peng William Chen', 'xu-peng-william-chen-11ee78', '3398', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '516c6861-49b9-55dc-b501-8a4def81f4a2', 'Kristen Hwang', 'kristen-hwang-21b3ee', '3383', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7a100c0d-c2d4-5355-988a-90ca7ab2d776', 'Bernice Pang', 'bernice-pang-79be70', '3383', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '44e50008-bc46-5daa-8b83-ba77571b5bd9', 'Sung Chak Kyle Lee', 'sung-chak-kyle-lee-7b9efe', '3054', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1504e58c-eb1f-5550-ac5d-cb8bd8edcc59', 'Brandon Sin Him Liu', 'brandon-sin-him-liu-047b58', '3054', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2d689cf2-48aa-5905-950f-91a3c3f77e35', 'Joshua Duncan-Andrews', 'joshua-duncan-andrews-5436cb', '2877', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3114c493-b297-5031-8b50-eb75a88a9d3f', 'Cheryl Ho', 'cheryl-ho-978241', '2869', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2113225c-9122-535a-ac52-cf5b2143de4d', 'Gemma Chen', 'gemma-chen-3b897b', '2869', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '14ec02c8-1b78-58d6-870f-d1910a1f5e79', 'Sze Shuen Lo', 'sze-shuen-lo-040a97', '2751', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '713b2eec-7756-566e-b82d-cab7abdfa7ba', 'Cheuk Ting Liu', 'cheuk-ting-liu-8fda93', '2751', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5190088d-e98e-5a9f-8176-431f6ef632c7', 'Alfred Yip', 'alfred-yip-8f88b4', '3521', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7', 'Ned Tyson', 'ned-tyson-5e7d97', '3351', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4814da86-9e14-57a1-96d2-d1e9bc335f6c', 'Hilary Daisy Chan', 'hilary-daisy-chan-a14e1f', '2750', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bfa40b34-a5ab-5948-a2a2-7078eace1d91', 'Febe Wong', 'febe-wong-310061', '2466', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a695d089-977f-5de1-b6f8-29668c4fb57c', 'Connor Hood', 'connor-hood-b1b580', '2988', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1a1fbe35-df8c-53ba-a298-9a832678f458', 'Jade Zirah', 'jade-zirah-40147e', '2846', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a70d76a6-d1d2-54cb-9c47-20e853dca426', 'Tsz Ching Casie Ho', 'tsz-ching-casie-ho-ecc344', '2521', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4c2d41d9-2391-5729-aa03-fe1879b1b50e', 'Soham Singh Mangaraj', 'soham-singh-mangaraj-0e4714', '2521', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '34935589-166c-5215-8c6a-75090f19db63', 'Mack Tung', 'mack-tung-df3119', '3524', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '10881ed6-7463-5b90-9598-756c7894dd8e', 'Rhys Lee', 'rhys-lee-2231c5', '2876', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '491de384-41a8-58a9-b767-2205c99b0322', 'Ema Poposka', 'ema-poposka-4197b1', '2876', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9a91ea41-973c-5ee9-8af2-52b02212a8bf', 'Montgomery Jackson', 'montgomery-jackson-738513', '2532', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '31be3df1-f499-5240-947d-ad4ef5bcec32', 'Oliver Lynch', 'oliver-lynch-5b003a', '2532', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '17bf03a1-784e-52bd-b3d4-c3fa2f47086d', 'Avelino Shin', 'avelino-shin-3ad169', '209902', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ec92b0f6-3e15-5ef2-bc96-222ffec71b47', 'Kam Hing Hu', 'kam-hing-hu-fa91b9', '225952', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '058e8046-aa70-5145-9b4f-2270f6683891', 'Adam Huxley Cheng Hou Kan', 'adam-huxley-cheng-hou-kan-33f24c', '213312', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2866a8ce-4421-5d78-a87a-c10f48461393', 'Ralph Andrei Buitre', 'ralph-andrei-buitre-044257', '215313', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd772ab6d-51ae-5b99-82ce-8fdfee006a6e', 'Haochen Lu', 'haochen-lu-c35efd', '225489', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a942aae6-1c23-511c-b386-fb0fbd704d06', 'Ela Tezel', 'ela-tezel-691ff6', '213343', 'RHKYC', 'HKG', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '69990555-b9fc-532f-a922-1c502dc62ec6', 'Kai Story', 'kai-story-28ba77', '187010', 'RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);

-- 2. Update Hong Kong Race Week 2026 Event Classes
UPDATE public.regatta_events
SET classes = '["Optimist", "ILCA 4", "ILCA 6", "29er"]'::jsonb,
    updated_at = clock_timestamp()
WHERE id = '8b2aa46e-12e7-55ee-afd4-2b927edd02cf';

-- Regatta Sheet: Hong Kong Race Week 2026 — 29er Asian Championship
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'c92a7017-4779-5f9b-8a56-4ca469fed159',
    '8b2aa46e-12e7-55ee-afd4-2b927edd02cf',
    'Hong Kong Race Week 2026 — 29er Asian Championship',
    'hong-kong-race-week-2026-29er',
    '2026-02-01',
    '2026-02-01',
    25,
    'Open',
    11,
    'HKG',
    '29er',
    'crew',
    2,
    2,
    false,
    'Royal Hong Kong Yacht Club, Middle Island, Hong Kong',
    'Sailing Federation of Hong Kong, China / Royal Hong Kong Yacht Club',
    'published',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'Official Final Sailwave Results from Royal Hong Kong Yacht Club (RHKYC)',
    'Official Hong Kong Race Week 2026 final results (2026 29er Asian Championship).',
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
    '4b33b277-dc07-51ec-9a16-0a143e41e473', 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Ethan Kiu & Louis Polson', '3354', 'crew', 1,
    21.0, 11.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Ethan Kiu, Crew: Louis Polson. Division: Junior, Men. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bc7b132f-03f8-5b82-9aea-857426a1082b', '4b33b277-dc07-51ec-9a16-0a143e41e473', 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6', 'Ethan Kiu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7dad6b95-6529-5cad-9079-16796cdf738f', '4b33b277-dc07-51ec-9a16-0a143e41e473', '3e1da03f-d00f-5604-b46e-716456fd72ee', 'Louis Polson', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b33b277-dc07-51ec-9a16-0a143e41e473', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b33b277-dc07-51ec-9a16-0a143e41e473', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b33b277-dc07-51ec-9a16-0a143e41e473', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b33b277-dc07-51ec-9a16-0a143e41e473', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b33b277-dc07-51ec-9a16-0a143e41e473', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b33b277-dc07-51ec-9a16-0a143e41e473', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b33b277-dc07-51ec-9a16-0a143e41e473', 7, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b33b277-dc07-51ec-9a16-0a143e41e473', 8, 3.0, NULL, true, '(3.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b33b277-dc07-51ec-9a16-0a143e41e473', 9, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b33b277-dc07-51ec-9a16-0a143e41e473', 10, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b33b277-dc07-51ec-9a16-0a143e41e473', 11, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', '7b500a87-14e9-5240-be8a-4553021e0544', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Nicholas Hon & Kaden Chan', '3053', 'crew', 2,
    60.0, 22.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Nicholas Hon, Crew: Kaden Chan. Division: Junior, Men. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6fae16d7-66cd-55de-8f37-01196b81e221', '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', '7b500a87-14e9-5240-be8a-4553021e0544', 'Nicholas Hon', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a39b05a0-0db3-5bb5-895c-80bac6686589', '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', 'f462d56c-e354-5b0d-945c-faaa30b0d382', 'Kaden Chan', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', 7, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', 8, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', 9, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', 10, 12.0, NULL, true, '(12.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43954dee-6764-5dde-a6bf-1fdbad9e7cb4', 11, 26.0, 'DSQ', true, '(26.0 DSQ)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '647049ae-a878-5fbb-8bec-9e261fa8024f', '6591a20e-7f52-4b81-b6cf-2b450a6410b5', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Chloe Kong & McCarley Wong', '3355', 'crew', 3,
    39.0, 23.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Chloe Kong, Crew: McCarley Wong. Division: Women. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '80593773-0811-5909-9195-8ead4fa242c8', '647049ae-a878-5fbb-8bec-9e261fa8024f', '6591a20e-7f52-4b81-b6cf-2b450a6410b5', 'Chloe Kong', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9e41f69b-d4a5-569b-a24b-012bdbd06226', '647049ae-a878-5fbb-8bec-9e261fa8024f', '0035813f-6b37-5dad-970e-1d43e5fde57c', 'McCarley Wong', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '647049ae-a878-5fbb-8bec-9e261fa8024f', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '647049ae-a878-5fbb-8bec-9e261fa8024f', 2, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '647049ae-a878-5fbb-8bec-9e261fa8024f', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '647049ae-a878-5fbb-8bec-9e261fa8024f', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '647049ae-a878-5fbb-8bec-9e261fa8024f', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '647049ae-a878-5fbb-8bec-9e261fa8024f', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '647049ae-a878-5fbb-8bec-9e261fa8024f', 7, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '647049ae-a878-5fbb-8bec-9e261fa8024f', 8, 11.0, NULL, true, '(11.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '647049ae-a878-5fbb-8bec-9e261fa8024f', 9, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '647049ae-a878-5fbb-8bec-9e261fa8024f', 10, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '647049ae-a878-5fbb-8bec-9e261fa8024f', 11, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 'efbf3e52-e103-455f-af07-e182b5280b3c', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Jessica Liu & Leanna Lee', '3375', 'crew', 4,
    66.0, 45.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Jessica Liu, Crew: Leanna Lee. Division: Junior, Women. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a60202b7-b0b1-5c0e-8268-6ca8d2feb81a', '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 'efbf3e52-e103-455f-af07-e182b5280b3c', 'Jessica Liu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6caf5e92-1040-58e0-8618-3c4dec5ef7ab', '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 'bc65ccb8-4c2f-5524-aa50-f350a82b9508', 'Leanna Lee', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 1, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 2, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 3, 10.0, NULL, true, '(10.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 4, 11.0, NULL, true, '(11.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 7, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 8, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 9, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 10, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '175e0ed0-a203-5aa9-87f2-5c9cb36d5e30', 11, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 'abf791c2-8de8-5603-9304-48a1eaa36338', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Atlas Miller & Rory Spinaze Littlejohn', '2681', 'crew', 5,
    69.0, 51.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Atlas Miller, Crew: Rory Spinaze Littlejohn. Division: Men. Nat: AUS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '89f55b25-db8d-5a4a-8e13-4031d9b1cddd', 'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 'abf791c2-8de8-5603-9304-48a1eaa36338', 'Atlas Miller', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1187140f-6036-5f60-9cd0-4f34d367cc2d', 'ffd38e0e-fc2e-5b89-bef9-1951c928813c', '5d9eb61e-776b-5398-ba66-c7d09d750521', 'Rory Spinaze Littlejohn', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 5, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 7, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 8, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 9, 9.0, NULL, true, '(9.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 10, 9.0, NULL, true, '(9.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffd38e0e-fc2e-5b89-bef9-1951c928813c', 11, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 'ad1da805-d827-5d22-9f38-f47cb18697b8', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Hins Law & Jaythan Lee', '3055', 'crew', 6,
    80.0, 57.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Hins Law, Crew: Jaythan Lee. Division: Men. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '073fc836-d02d-565c-928e-0796d4cfd5da', '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 'ad1da805-d827-5d22-9f38-f47cb18697b8', 'Hins Law', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a3091d74-a91c-561f-a39c-e91ff0172f2a', '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 'b0e69dac-7597-55e5-89a7-12d8d56e9d3a', 'Jaythan Lee', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 4, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 7, 12.0, NULL, true, '(12.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 8, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 9, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 10, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52800d38-c29a-5b27-81f4-cc35f8bf24a9', 11, 11.0, NULL, true, '(11.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', '69843896-764b-5fbd-8754-f3b8fba0d252', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Kai Lawson & Andy Allt-Graham', '3084', 'crew', 7,
    110.0, 58.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Kai Lawson, Crew: Andy Allt-Graham. Division: Junior, Men. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd21034a8-147f-55bc-ab91-645cb78ef7c2', 'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', '69843896-764b-5fbd-8754-f3b8fba0d252', 'Kai Lawson', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1fcab0a6-8482-5255-b460-449dee179f28', 'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', '81fcced4-6ca3-54d1-82c4-3c37f45f706b', 'Andy Allt-Graham', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', 1, 26.0, 'NSC', true, '(26.0 NSC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', 5, 26.0, 'UFD', true, '(26.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', 6, 26.0, 'UFD', false, '26.0 UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', 7, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', 8, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', 9, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', 10, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df1bcb2d-02e9-5d02-a7b1-2e1067cfbf9d', 11, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 'e84ec5f5-02aa-4b5b-889a-edf1eefdbfbf', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Sean Kum & Nigel Tan', '2472', 'crew', 8,
    82.0, 58.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Sean Kum, Crew: Nigel Tan. Division: Junior, Men. Nat: SGP.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9029f2eb-fe41-5430-8c60-dd0b9095901b', '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 'e84ec5f5-02aa-4b5b-889a-edf1eefdbfbf', 'Sean Kum', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '79270711-ea10-5338-ac70-91955503be22', '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 'ca98c637-aebd-4f38-81c7-80345846c93a', 'Nigel Tan', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 2, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 6, 14.0, NULL, true, '(14.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 7, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 8, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 9, 10.0, NULL, true, '(10.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 10, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c4b1f3f-d8d3-5bce-ade2-9cc70e1bec33', 11, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 'c53b02b5-9285-5325-9edd-12e07f01e4e1', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Ayden Pang & Xu Peng William Chen', '3398', 'crew', 9,
    109.0, 69.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Ayden Pang, Crew: Xu Peng William Chen. Division: Men. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f53c7d44-8d05-5969-a096-e792074cccf6', 'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 'c53b02b5-9285-5325-9edd-12e07f01e4e1', 'Ayden Pang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dcd736b4-6e6d-5420-81c4-b6a65abd4edb', 'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 'b7d88773-fe00-5fb1-a6d0-91d905be4d10', 'Xu Peng William Chen', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 1, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 3, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 7, 14.0, NULL, true, '(14.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 8, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 9, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 10, 26.0, 'UFD', true, '(26.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c44f14c7-48a0-52b8-85b0-e61a7cbdd753', 11, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '231619cf-21f4-51d0-9cb7-a574a0dbb481', '516c6861-49b9-55dc-b501-8a4def81f4a2', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Kristen Hwang & Bernice Pang', '3383', 'crew', 10,
    126.0, 74.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Kristen Hwang, Crew: Bernice Pang. Division: Junior, Women. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5316dcda-b11a-5b04-bf3d-4c3af743017d', '231619cf-21f4-51d0-9cb7-a574a0dbb481', '516c6861-49b9-55dc-b501-8a4def81f4a2', 'Kristen Hwang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'faa579f4-571e-5a5c-a5fe-25237c6c993f', '231619cf-21f4-51d0-9cb7-a574a0dbb481', '7a100c0d-c2d4-5355-988a-90ca7ab2d776', 'Bernice Pang', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '231619cf-21f4-51d0-9cb7-a574a0dbb481', 1, 26.0, 'DNS', true, '(26.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '231619cf-21f4-51d0-9cb7-a574a0dbb481', 2, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '231619cf-21f4-51d0-9cb7-a574a0dbb481', 3, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '231619cf-21f4-51d0-9cb7-a574a0dbb481', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '231619cf-21f4-51d0-9cb7-a574a0dbb481', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '231619cf-21f4-51d0-9cb7-a574a0dbb481', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '231619cf-21f4-51d0-9cb7-a574a0dbb481', 7, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '231619cf-21f4-51d0-9cb7-a574a0dbb481', 8, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '231619cf-21f4-51d0-9cb7-a574a0dbb481', 9, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '231619cf-21f4-51d0-9cb7-a574a0dbb481', 10, 26.0, 'UFD', true, '(26.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '231619cf-21f4-51d0-9cb7-a574a0dbb481', 11, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '04cadbcd-14b3-5c32-9140-4cad74a515cf', '44e50008-bc46-5daa-8b83-ba77571b5bd9', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Sung Chak Kyle Lee & Brandon Sin Him Liu', '3054', 'crew', 11,
    121.0, 79.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Sung Chak Kyle Lee, Crew: Brandon Sin Him Liu. Division: Men. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '646b945f-4fc2-5b1d-894f-a7fc29e8a178', '04cadbcd-14b3-5c32-9140-4cad74a515cf', '44e50008-bc46-5daa-8b83-ba77571b5bd9', 'Sung Chak Kyle Lee', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '30824b01-e550-5c3a-a13e-d60739c3ed9e', '04cadbcd-14b3-5c32-9140-4cad74a515cf', '1504e58c-eb1f-5550-ac5d-cb8bd8edcc59', 'Brandon Sin Him Liu', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04cadbcd-14b3-5c32-9140-4cad74a515cf', 1, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04cadbcd-14b3-5c32-9140-4cad74a515cf', 2, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04cadbcd-14b3-5c32-9140-4cad74a515cf', 3, 16.0, NULL, true, '(16.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04cadbcd-14b3-5c32-9140-4cad74a515cf', 4, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04cadbcd-14b3-5c32-9140-4cad74a515cf', 5, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04cadbcd-14b3-5c32-9140-4cad74a515cf', 6, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04cadbcd-14b3-5c32-9140-4cad74a515cf', 7, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04cadbcd-14b3-5c32-9140-4cad74a515cf', 8, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04cadbcd-14b3-5c32-9140-4cad74a515cf', 9, 26.0, 'UFD', true, '(26.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04cadbcd-14b3-5c32-9140-4cad74a515cf', 10, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04cadbcd-14b3-5c32-9140-4cad74a515cf', 11, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '934b7587-2db2-5b85-a7eb-60c9e138e238', '2d6a86d3-e3c2-5805-ba50-b08cc77aba98', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Toby Yuen & Joshua Duncan-Andrews', '2877', 'crew', 12,
    145.0, 98.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Toby Yuen, Crew: Joshua Duncan-Andrews. Division: Junior, Men. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '18390230-e064-5c84-bebe-30240701d9f2', '934b7587-2db2-5b85-a7eb-60c9e138e238', '2d6a86d3-e3c2-5805-ba50-b08cc77aba98', 'Toby Yuen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5d711a73-9284-54f8-b857-dba7e366c2e1', '934b7587-2db2-5b85-a7eb-60c9e138e238', '2d689cf2-48aa-5905-950f-91a3c3f77e35', 'Joshua Duncan-Andrews', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '934b7587-2db2-5b85-a7eb-60c9e138e238', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '934b7587-2db2-5b85-a7eb-60c9e138e238', 2, 26.0, 'RET', true, '(26.0 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '934b7587-2db2-5b85-a7eb-60c9e138e238', 3, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '934b7587-2db2-5b85-a7eb-60c9e138e238', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '934b7587-2db2-5b85-a7eb-60c9e138e238', 5, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '934b7587-2db2-5b85-a7eb-60c9e138e238', 6, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '934b7587-2db2-5b85-a7eb-60c9e138e238', 7, 21.0, NULL, true, '(21.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '934b7587-2db2-5b85-a7eb-60c9e138e238', 8, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '934b7587-2db2-5b85-a7eb-60c9e138e238', 9, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '934b7587-2db2-5b85-a7eb-60c9e138e238', 10, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '934b7587-2db2-5b85-a7eb-60c9e138e238', 11, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', '3114c493-b297-5031-8b50-eb75a88a9d3f', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Cheryl Ho & Gemma Chen', '2869', 'crew', 13,
    159.0, 119.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Cheryl Ho, Crew: Gemma Chen. Division: Junior, Women. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '283545e2-96b2-50b3-9bf0-01947e40229f', 'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', '3114c493-b297-5031-8b50-eb75a88a9d3f', 'Cheryl Ho', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd3d82bbe-fb09-5dac-b05d-e377facb7ed5', 'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', '2113225c-9122-535a-ac52-cf5b2143de4d', 'Gemma Chen', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', 1, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', 2, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', 3, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', 4, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', 5, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', 6, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', 7, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', 8, 21.0, NULL, true, '(21.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', 9, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', 10, 19.0, NULL, true, '(19.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', 11, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', '14ec02c8-1b78-58d6-870f-d1910a1f5e79', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Sze Shuen Lo & Cheuk Ting Liu', '2751', 'crew', 14,
    182.0, 136.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Sze Shuen Lo, Crew: Cheuk Ting Liu. Division: Junior, Women. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b0437ad8-2561-56a5-91d2-de6e81a3e743', '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', '14ec02c8-1b78-58d6-870f-d1910a1f5e79', 'Sze Shuen Lo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fe9305e2-852f-5737-9892-0a886fb75337', '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', '713b2eec-7756-566e-b82d-cab7abdfa7ba', 'Cheuk Ting Liu', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', 1, 26.0, 'DNF', true, '(26.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', 2, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', 3, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', 4, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', 5, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', 6, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', 7, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', 8, 20.0, NULL, true, '(20.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', 9, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', 10, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7a730be2-87e6-57ee-9b81-fa80f7fa88fe', 11, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', '76579635-65b3-53b3-a2f6-a478f8965d49', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Alex Hon & Alfred Yip', '3521', 'crew', 15,
    189.0, 137.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Alex Hon, Crew: Alfred Yip. Division: Men. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1d6937a6-182b-5dec-bef7-fa49f48110f0', 'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', '76579635-65b3-53b3-a2f6-a478f8965d49', 'Alex Hon', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '59f5bbfe-c351-5a4a-9768-3c244254daf4', 'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', '5190088d-e98e-5a9f-8176-431f6ef632c7', 'Alfred Yip', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', 1, 26.0, 'NSC', true, '(26.0 NSC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', 2, 26.0, 'DNS', true, '(26.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', 3, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', 4, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', 5, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', 6, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', 7, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', 8, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', 9, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', 10, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd36bfa88-4265-5f1d-846d-d0a1ade1dd84', 11, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '981b61db-382a-5847-81f9-b4517b6e340b', 'c9a7c7ea-f867-4aa0-bbd7-ca47226a8477', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Katie Lai & Ned Tyson', '3351', 'crew', 16,
    191.0, 139.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Katie Lai, Crew: Ned Tyson. Division: Mixed. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3fd9b1f6-c50d-5813-9970-234cb3ad02e9', '981b61db-382a-5847-81f9-b4517b6e340b', 'c9a7c7ea-f867-4aa0-bbd7-ca47226a8477', 'Katie Lai', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '29ef13f8-20da-5df3-ac14-f5a3b2c89710', '981b61db-382a-5847-81f9-b4517b6e340b', '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7', 'Ned Tyson', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '981b61db-382a-5847-81f9-b4517b6e340b', 1, 26.0, 'DNF', true, '(26.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '981b61db-382a-5847-81f9-b4517b6e340b', 2, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '981b61db-382a-5847-81f9-b4517b6e340b', 3, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '981b61db-382a-5847-81f9-b4517b6e340b', 4, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '981b61db-382a-5847-81f9-b4517b6e340b', 5, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '981b61db-382a-5847-81f9-b4517b6e340b', 6, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '981b61db-382a-5847-81f9-b4517b6e340b', 7, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '981b61db-382a-5847-81f9-b4517b6e340b', 8, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '981b61db-382a-5847-81f9-b4517b6e340b', 9, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '981b61db-382a-5847-81f9-b4517b6e340b', 10, 26.0, 'UFD', true, '(26.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '981b61db-382a-5847-81f9-b4517b6e340b', 11, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bdfcf255-ec89-52e2-8767-f201f08b18d7', '7a9f67d5-fa2c-5961-ac2a-e14e377ae93a', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Ching Jaymee Ip & Hilary Daisy Chan', '2750', 'crew', 17,
    196.0, 144.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Ching Jaymee Ip, Crew: Hilary Daisy Chan. Division: Junior, Women. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '41919fb9-e7f4-5655-bd84-e2cec6642791', 'bdfcf255-ec89-52e2-8767-f201f08b18d7', '7a9f67d5-fa2c-5961-ac2a-e14e377ae93a', 'Ching Jaymee Ip', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '88cc1753-7d50-57ec-a325-90cd1546751d', 'bdfcf255-ec89-52e2-8767-f201f08b18d7', '4814da86-9e14-57a1-96d2-d1e9bc335f6c', 'Hilary Daisy Chan', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfcf255-ec89-52e2-8767-f201f08b18d7', 1, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfcf255-ec89-52e2-8767-f201f08b18d7', 2, 26.0, 'DNF', true, '(26.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfcf255-ec89-52e2-8767-f201f08b18d7', 3, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfcf255-ec89-52e2-8767-f201f08b18d7', 4, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfcf255-ec89-52e2-8767-f201f08b18d7', 5, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfcf255-ec89-52e2-8767-f201f08b18d7', 6, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfcf255-ec89-52e2-8767-f201f08b18d7', 7, 26.0, 'RET', true, '(26.0 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfcf255-ec89-52e2-8767-f201f08b18d7', 8, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfcf255-ec89-52e2-8767-f201f08b18d7', 9, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfcf255-ec89-52e2-8767-f201f08b18d7', 10, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdfcf255-ec89-52e2-8767-f201f08b18d7', 11, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9c8184da-16ba-590f-91db-8364b07abef6', 'b887d7b9-e768-4024-b4bd-16455e87835b', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Cheryl Yong & Febe Wong', '2466', 'crew', 18,
    207.0, 155.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Cheryl Yong, Crew: Febe Wong. Division: Women. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6ea7d578-0beb-5945-bf5b-bb9203a183bc', '9c8184da-16ba-590f-91db-8364b07abef6', 'b887d7b9-e768-4024-b4bd-16455e87835b', 'Cheryl Yong', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '29ea6b8a-d074-5b0d-9929-d6c20803f365', '9c8184da-16ba-590f-91db-8364b07abef6', 'bfa40b34-a5ab-5948-a2a2-7078eace1d91', 'Febe Wong', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c8184da-16ba-590f-91db-8364b07abef6', 1, 26.0, 'DNC', true, '(26.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c8184da-16ba-590f-91db-8364b07abef6', 2, 26.0, 'DNC', true, '(26.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c8184da-16ba-590f-91db-8364b07abef6', 3, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c8184da-16ba-590f-91db-8364b07abef6', 4, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c8184da-16ba-590f-91db-8364b07abef6', 5, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c8184da-16ba-590f-91db-8364b07abef6', 6, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c8184da-16ba-590f-91db-8364b07abef6', 7, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c8184da-16ba-590f-91db-8364b07abef6', 8, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c8184da-16ba-590f-91db-8364b07abef6', 9, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c8184da-16ba-590f-91db-8364b07abef6', 10, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c8184da-16ba-590f-91db-8364b07abef6', 11, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c442d937-5dc3-568b-b6c3-fa107fd5b554', '7411c058-0e0a-5a5d-aa05-fb3bd9edc4aa', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Mac Darlington & Connor Hood', '2988', 'crew', 19,
    210.0, 158.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Mac Darlington, Crew: Connor Hood. Division: Junior, Men. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '91463456-68fd-5df5-b900-08ed7565810b', 'c442d937-5dc3-568b-b6c3-fa107fd5b554', '7411c058-0e0a-5a5d-aa05-fb3bd9edc4aa', 'Mac Darlington', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'baf315e9-15f1-5140-b35e-d54c23e734ca', 'c442d937-5dc3-568b-b6c3-fa107fd5b554', 'a695d089-977f-5de1-b6f8-29668c4fb57c', 'Connor Hood', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c442d937-5dc3-568b-b6c3-fa107fd5b554', 1, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c442d937-5dc3-568b-b6c3-fa107fd5b554', 2, 26.0, 'DNF', true, '(26.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c442d937-5dc3-568b-b6c3-fa107fd5b554', 3, 26.0, 'DNS', true, '(26.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c442d937-5dc3-568b-b6c3-fa107fd5b554', 4, 26.0, 'RET', false, '26.0 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c442d937-5dc3-568b-b6c3-fa107fd5b554', 5, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c442d937-5dc3-568b-b6c3-fa107fd5b554', 6, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c442d937-5dc3-568b-b6c3-fa107fd5b554', 7, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c442d937-5dc3-568b-b6c3-fa107fd5b554', 8, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c442d937-5dc3-568b-b6c3-fa107fd5b554', 9, 26.0, 'RET', false, '26.0 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c442d937-5dc3-568b-b6c3-fa107fd5b554', 10, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c442d937-5dc3-568b-b6c3-fa107fd5b554', 11, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '39437e0a-06b6-58f8-ad85-666708da352a', '1a1fbe35-df8c-53ba-a298-9a832678f458', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Jade Zirah & Penelope Wilde', '2846', 'crew', 20,
    215.0, 163.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Jade Zirah, Crew: Penelope Wilde. Division: Junior, Women. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '436b18c2-9553-5307-992f-c078e76d82f7', '39437e0a-06b6-58f8-ad85-666708da352a', '1a1fbe35-df8c-53ba-a298-9a832678f458', 'Jade Zirah', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7491b77b-869a-53ca-8b49-0a4b2f4b488e', '39437e0a-06b6-58f8-ad85-666708da352a', 'ba833ded-4802-5349-8bff-f61007f74c32', 'Penelope Wilde', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39437e0a-06b6-58f8-ad85-666708da352a', 1, 26.0, 'UFD', true, '(26.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39437e0a-06b6-58f8-ad85-666708da352a', 2, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39437e0a-06b6-58f8-ad85-666708da352a', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39437e0a-06b6-58f8-ad85-666708da352a', 4, 26.0, 'RET', true, '(26.0 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39437e0a-06b6-58f8-ad85-666708da352a', 5, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39437e0a-06b6-58f8-ad85-666708da352a', 6, 26.0, 'UFD', false, '26.0 UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39437e0a-06b6-58f8-ad85-666708da352a', 7, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39437e0a-06b6-58f8-ad85-666708da352a', 8, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39437e0a-06b6-58f8-ad85-666708da352a', 9, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39437e0a-06b6-58f8-ad85-666708da352a', 10, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39437e0a-06b6-58f8-ad85-666708da352a', 11, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd6834eb2-1bce-52bf-8598-d36b5490272c', 'a70d76a6-d1d2-54cb-9c47-20e853dca426', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Tsz Ching Casie Ho & Soham Singh Mangaraj', '2521', 'crew', 21,
    219.0, 167.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Tsz Ching Casie Ho, Crew: Soham Singh Mangaraj. Division: Mixed. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1da58661-dcfb-51c5-b9ec-7e4016437cce', 'd6834eb2-1bce-52bf-8598-d36b5490272c', 'a70d76a6-d1d2-54cb-9c47-20e853dca426', 'Tsz Ching Casie Ho', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '118e249a-7e2c-55e7-aef2-763934ca5406', 'd6834eb2-1bce-52bf-8598-d36b5490272c', '4c2d41d9-2391-5729-aa03-fe1879b1b50e', 'Soham Singh Mangaraj', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6834eb2-1bce-52bf-8598-d36b5490272c', 1, 26.0, 'DNC', true, '(26.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6834eb2-1bce-52bf-8598-d36b5490272c', 2, 26.0, 'DNC', true, '(26.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6834eb2-1bce-52bf-8598-d36b5490272c', 3, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6834eb2-1bce-52bf-8598-d36b5490272c', 4, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6834eb2-1bce-52bf-8598-d36b5490272c', 5, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6834eb2-1bce-52bf-8598-d36b5490272c', 6, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6834eb2-1bce-52bf-8598-d36b5490272c', 7, 26.0, 'DNF', false, '26.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6834eb2-1bce-52bf-8598-d36b5490272c', 8, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6834eb2-1bce-52bf-8598-d36b5490272c', 9, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6834eb2-1bce-52bf-8598-d36b5490272c', 10, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6834eb2-1bce-52bf-8598-d36b5490272c', 11, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', '4b6e6b85-ad06-5f70-aba9-242c899d8c30', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Owen Ou & Mack Tung', '3524', 'crew', 22,
    221.0, 169.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Owen Ou, Crew: Mack Tung. Division: Men. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4a02555f-6f46-5f7e-b853-6cc2b0c0a4d3', '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', '4b6e6b85-ad06-5f70-aba9-242c899d8c30', 'Owen Ou', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7282353f-776b-50bd-bbcb-034c47cf8e4f', '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', '34935589-166c-5215-8c6a-75090f19db63', 'Mack Tung', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', 1, 26.0, 'DNC', true, '(26.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', 2, 26.0, 'DNC', true, '(26.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', 3, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', 4, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', 5, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', 6, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', 7, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', 8, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', 9, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', 10, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72ec2b7d-73db-5c5d-9e41-17ddb38a3749', 11, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ff20ff85-e4ba-5556-873b-bef34f5c1064', '0f21b908-6234-4f3b-a34c-fbe589a75c7c', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Keira Hwang & Keana Hah', '3393', 'crew', 23,
    247.0, 195.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Keira Hwang, Crew: Keana Hah. Division: Junior, Women. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '08946454-95c7-50df-83c3-bd077bf9fe59', 'ff20ff85-e4ba-5556-873b-bef34f5c1064', '0f21b908-6234-4f3b-a34c-fbe589a75c7c', 'Keira Hwang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3146dc01-a216-5070-965c-c4abadcf0083', 'ff20ff85-e4ba-5556-873b-bef34f5c1064', '8388f8f9-1ce2-5ca7-b198-feff165118dc', 'Keana Hah', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff20ff85-e4ba-5556-873b-bef34f5c1064', 1, 26.0, 'DNS', true, '(26.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff20ff85-e4ba-5556-873b-bef34f5c1064', 2, 26.0, 'DNS', true, '(26.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff20ff85-e4ba-5556-873b-bef34f5c1064', 3, 26.0, 'DNS', false, '26.0 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff20ff85-e4ba-5556-873b-bef34f5c1064', 4, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff20ff85-e4ba-5556-873b-bef34f5c1064', 5, 26.0, 'DNS', false, '26.0 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff20ff85-e4ba-5556-873b-bef34f5c1064', 6, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff20ff85-e4ba-5556-873b-bef34f5c1064', 7, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff20ff85-e4ba-5556-873b-bef34f5c1064', 8, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff20ff85-e4ba-5556-873b-bef34f5c1064', 9, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff20ff85-e4ba-5556-873b-bef34f5c1064', 10, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff20ff85-e4ba-5556-873b-bef34f5c1064', 11, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c52108e9-a359-5906-babd-bdee7e18aa47', '10881ed6-7463-5b90-9598-756c7894dd8e', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Rhys Lee & Ema Poposka', '2876', 'crew', 24,
    286.0, 234.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Rhys Lee, Crew: Ema Poposka. Division: Junior, Mixed. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e7fa1684-adde-554c-8b8a-a71ab4094f29', 'c52108e9-a359-5906-babd-bdee7e18aa47', '10881ed6-7463-5b90-9598-756c7894dd8e', 'Rhys Lee', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '00456b80-e6ac-5ef8-9074-ec867866ce24', 'c52108e9-a359-5906-babd-bdee7e18aa47', '491de384-41a8-58a9-b767-2205c99b0322', 'Ema Poposka', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c52108e9-a359-5906-babd-bdee7e18aa47', 1, 26.0, 'DNF', true, '(26.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c52108e9-a359-5906-babd-bdee7e18aa47', 2, 26.0, 'DNS', true, '(26.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c52108e9-a359-5906-babd-bdee7e18aa47', 3, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c52108e9-a359-5906-babd-bdee7e18aa47', 4, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c52108e9-a359-5906-babd-bdee7e18aa47', 5, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c52108e9-a359-5906-babd-bdee7e18aa47', 6, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c52108e9-a359-5906-babd-bdee7e18aa47', 7, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c52108e9-a359-5906-babd-bdee7e18aa47', 8, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c52108e9-a359-5906-babd-bdee7e18aa47', 9, 26.0, 'RET', false, '26.0 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c52108e9-a359-5906-babd-bdee7e18aa47', 10, 26.0, 'RET', false, '26.0 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c52108e9-a359-5906-babd-bdee7e18aa47', 11, 26.0, 'DNS', false, '26.0 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', '9a91ea41-973c-5ee9-8af2-52b02212a8bf', 'c92a7017-4779-5f9b-8a56-4ca469fed159', 'Montgomery Jackson & Oliver Lynch', '2532', 'crew', 24,
    286.0, 234.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/29er.htm', 'Official HKRW 2026 29er Asian Championship Results (RHKYC)',
    'document', 'HKRW 2026 29er Asian Championship. Helm: Montgomery Jackson, Crew: Oliver Lynch. Division: Men. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2a0423ba-5c6d-55b4-b7f3-6f3f5e3fad69', 'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', '9a91ea41-973c-5ee9-8af2-52b02212a8bf', 'Montgomery Jackson', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c50e4fbe-a6cb-53ee-adb3-44093b6bd5d2', 'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', '31be3df1-f499-5240-947d-ad4ef5bcec32', 'Oliver Lynch', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', 1, 26.0, 'DNF', true, '(26.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', 2, 26.0, 'RET', true, '(26.0 RET)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', 3, 26.0, 'DNS', false, '26.0 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', 4, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', 5, 26.0, 'DNF', false, '26.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', 6, 26.0, 'DNF', false, '26.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', 7, 26.0, 'DNF', false, '26.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', 8, 26.0, 'DNF', false, '26.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', 9, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', 10, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e126b4d2-17bc-5ecb-9be0-72c25bfb4e76', 11, 26.0, 'DNC', false, '26.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- Regatta Sheet: Hong Kong Race Week 2026 (ILCA 6)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '5407e3b4-f6f1-5e34-add9-de2903c1fd97',
    '8b2aa46e-12e7-55ee-afd4-2b927edd02cf',
    'Hong Kong Race Week 2026 (ILCA 6)',
    'hong-kong-race-week-2026-ilca6',
    '2026-02-01',
    '2026-02-01',
    13,
    'Open',
    8,
    'HKG',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Royal Hong Kong Yacht Club, Middle Island, Hong Kong',
    'Sailing Federation of Hong Kong, China / Royal Hong Kong Yacht Club',
    'published',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'Official Final Sailwave Results from Royal Hong Kong Yacht Club (RHKYC)',
    'Official Hong Kong Race Week 2026 final results.',
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
    '2aa6e223-9e40-5f6a-ae15-014dea4378c9', '1efbd4b8-343f-43e4-bcce-659e65a06e56', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Charalampos Velianitis', '220790', 'individual', 1,
    15.0, 6.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Charalampos Velianitis. Division: Open. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '20aaf566-49cc-5366-9e09-bdde99793d85', '2aa6e223-9e40-5f6a-ae15-014dea4378c9', '1efbd4b8-343f-43e4-bcce-659e65a06e56', 'Charalampos Velianitis', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aa6e223-9e40-5f6a-ae15-014dea4378c9', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aa6e223-9e40-5f6a-ae15-014dea4378c9', 2, 4.0, NULL, true, '(4.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aa6e223-9e40-5f6a-ae15-014dea4378c9', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aa6e223-9e40-5f6a-ae15-014dea4378c9', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aa6e223-9e40-5f6a-ae15-014dea4378c9', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aa6e223-9e40-5f6a-ae15-014dea4378c9', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aa6e223-9e40-5f6a-ae15-014dea4378c9', 7, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aa6e223-9e40-5f6a-ae15-014dea4378c9', 8, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9348e4a0-f90e-5bb3-b0e1-6ad9135c7f9a', '3a1abf10-28a8-55a8-95be-53f5a8d13ed9', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Xavier Wilde', '213211', 'individual', 2,
    18.0, 12.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Xavier Wilde. Division: Open. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0f02710e-a30d-54d7-a560-57ed8007c635', '9348e4a0-f90e-5bb3-b0e1-6ad9135c7f9a', '3a1abf10-28a8-55a8-95be-53f5a8d13ed9', 'Xavier Wilde', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9348e4a0-f90e-5bb3-b0e1-6ad9135c7f9a', 1, 3.0, NULL, true, '(3.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9348e4a0-f90e-5bb3-b0e1-6ad9135c7f9a', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9348e4a0-f90e-5bb3-b0e1-6ad9135c7f9a', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9348e4a0-f90e-5bb3-b0e1-6ad9135c7f9a', 4, 3.0, NULL, true, '(3.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9348e4a0-f90e-5bb3-b0e1-6ad9135c7f9a', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9348e4a0-f90e-5bb3-b0e1-6ad9135c7f9a', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9348e4a0-f90e-5bb3-b0e1-6ad9135c7f9a', 7, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9348e4a0-f90e-5bb3-b0e1-6ad9135c7f9a', 8, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a5579764-5888-5bfa-ba46-280f8125aab7', 'f7c2cdc3-b794-4d79-9ed1-fa6262298665', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Samuel Tan-Hardy', '221934', 'individual', 3,
    21.0, 13.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Samuel Tan-Hardy. Division: Open. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '57ffc98d-f44c-5c55-af6d-6d0c88ad9603', 'a5579764-5888-5bfa-ba46-280f8125aab7', 'f7c2cdc3-b794-4d79-9ed1-fa6262298665', 'Samuel Tan-Hardy', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5579764-5888-5bfa-ba46-280f8125aab7', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5579764-5888-5bfa-ba46-280f8125aab7', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5579764-5888-5bfa-ba46-280f8125aab7', 3, 4.0, NULL, true, '(4.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5579764-5888-5bfa-ba46-280f8125aab7', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5579764-5888-5bfa-ba46-280f8125aab7', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5579764-5888-5bfa-ba46-280f8125aab7', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5579764-5888-5bfa-ba46-280f8125aab7', 7, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5579764-5888-5bfa-ba46-280f8125aab7', 8, 4.0, NULL, true, '(4.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '01f4fa66-9afb-54f0-9327-0c620ef5c590', '17bf03a1-784e-52bd-b3d4-c3fa2f47086d', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Avelino Shin', '209902', 'individual', 4,
    34.0, 24.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Avelino Shin. Division: Open. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3ebc2029-6837-5830-b9d0-88b82ad1b340', '01f4fa66-9afb-54f0-9327-0c620ef5c590', '17bf03a1-784e-52bd-b3d4-c3fa2f47086d', 'Avelino Shin', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01f4fa66-9afb-54f0-9327-0c620ef5c590', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01f4fa66-9afb-54f0-9327-0c620ef5c590', 2, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01f4fa66-9afb-54f0-9327-0c620ef5c590', 3, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01f4fa66-9afb-54f0-9327-0c620ef5c590', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01f4fa66-9afb-54f0-9327-0c620ef5c590', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01f4fa66-9afb-54f0-9327-0c620ef5c590', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01f4fa66-9afb-54f0-9327-0c620ef5c590', 7, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01f4fa66-9afb-54f0-9327-0c620ef5c590', 8, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7c80322b-1d9f-50ec-8835-1d939c6f6ffb', 'c19dae59-5f06-52f8-bd66-e13efdd35e6d', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Ziyan Huang', '221401', 'individual', 5,
    35.0, 24.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Ziyan Huang. Division: Open. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c32a9d0f-7be9-5014-b55e-bf570b334485', '7c80322b-1d9f-50ec-8835-1d939c6f6ffb', 'c19dae59-5f06-52f8-bd66-e13efdd35e6d', 'Ziyan Huang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7c80322b-1d9f-50ec-8835-1d939c6f6ffb', 1, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7c80322b-1d9f-50ec-8835-1d939c6f6ffb', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7c80322b-1d9f-50ec-8835-1d939c6f6ffb', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7c80322b-1d9f-50ec-8835-1d939c6f6ffb', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7c80322b-1d9f-50ec-8835-1d939c6f6ffb', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7c80322b-1d9f-50ec-8835-1d939c6f6ffb', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7c80322b-1d9f-50ec-8835-1d939c6f6ffb', 7, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7c80322b-1d9f-50ec-8835-1d939c6f6ffb', 8, 6.0, NULL, true, '(6.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c7c60434-812b-5ce6-8969-a417e850c7bb', 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Kam Hing Hu', '225952', 'individual', 6,
    48.0, 34.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Kam Hing Hu. Division: Open. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5b90e125-fef4-51d8-bdb7-5472e4d6f2bc', 'c7c60434-812b-5ce6-8969-a417e850c7bb', 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47', 'Kam Hing Hu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7c60434-812b-5ce6-8969-a417e850c7bb', 1, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7c60434-812b-5ce6-8969-a417e850c7bb', 2, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7c60434-812b-5ce6-8969-a417e850c7bb', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7c60434-812b-5ce6-8969-a417e850c7bb', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7c60434-812b-5ce6-8969-a417e850c7bb', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7c60434-812b-5ce6-8969-a417e850c7bb', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7c60434-812b-5ce6-8969-a417e850c7bb', 7, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7c60434-812b-5ce6-8969-a417e850c7bb', 8, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2f48adba-f542-57bc-a3cc-855643333c33', '058e8046-aa70-5145-9b4f-2270f6683891', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Adam Huxley Cheng Hou Kan', '213312', 'individual', 7,
    68.0, 40.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Adam Huxley Cheng Hou Kan. Division: Open. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '71ef82d3-65fc-55c4-82b7-5c949f5cd6bf', '2f48adba-f542-57bc-a3cc-855643333c33', '058e8046-aa70-5145-9b4f-2270f6683891', 'Adam Huxley Cheng Hou Kan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f48adba-f542-57bc-a3cc-855643333c33', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f48adba-f542-57bc-a3cc-855643333c33', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f48adba-f542-57bc-a3cc-855643333c33', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f48adba-f542-57bc-a3cc-855643333c33', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f48adba-f542-57bc-a3cc-855643333c33', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f48adba-f542-57bc-a3cc-855643333c33', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f48adba-f542-57bc-a3cc-855643333c33', 7, 14.0, 'DNC', true, '(14.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f48adba-f542-57bc-a3cc-855643333c33', 8, 14.0, 'DNC', true, '(14.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5e664400-ff91-5c13-998d-bf1b11bdf93d', '3dec8359-73a7-4ea4-8b5c-d2542fd066ff', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Ryan Cheung', '201677', 'individual', 8,
    70.0, 49.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Ryan Cheung. Division: Open. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fcda26d4-6cf6-50a6-9951-a606c5b5b5cd', '5e664400-ff91-5c13-998d-bf1b11bdf93d', '3dec8359-73a7-4ea4-8b5c-d2542fd066ff', 'Ryan Cheung', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e664400-ff91-5c13-998d-bf1b11bdf93d', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e664400-ff91-5c13-998d-bf1b11bdf93d', 2, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e664400-ff91-5c13-998d-bf1b11bdf93d', 3, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e664400-ff91-5c13-998d-bf1b11bdf93d', 4, 11.0, NULL, true, '(11.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e664400-ff91-5c13-998d-bf1b11bdf93d', 5, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e664400-ff91-5c13-998d-bf1b11bdf93d', 6, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e664400-ff91-5c13-998d-bf1b11bdf93d', 7, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e664400-ff91-5c13-998d-bf1b11bdf93d', 8, 10.0, NULL, true, '(10.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '14dedb4a-2120-5bd4-872f-9a5ac42d25de', '2866a8ce-4421-5d78-a87a-c10f48461393', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Ralph Andrei Buitre', '215313', 'individual', 9,
    77.0, 53.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Ralph Andrei Buitre. Division: Open. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dbe5e2f0-0c8e-511e-adc8-44f7af0572f0', '14dedb4a-2120-5bd4-872f-9a5ac42d25de', '2866a8ce-4421-5d78-a87a-c10f48461393', 'Ralph Andrei Buitre', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14dedb4a-2120-5bd4-872f-9a5ac42d25de', 1, 10.0, NULL, true, '(10.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14dedb4a-2120-5bd4-872f-9a5ac42d25de', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14dedb4a-2120-5bd4-872f-9a5ac42d25de', 3, 14.0, 'DNF', true, '(14.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14dedb4a-2120-5bd4-872f-9a5ac42d25de', 4, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14dedb4a-2120-5bd4-872f-9a5ac42d25de', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14dedb4a-2120-5bd4-872f-9a5ac42d25de', 6, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14dedb4a-2120-5bd4-872f-9a5ac42d25de', 7, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14dedb4a-2120-5bd4-872f-9a5ac42d25de', 8, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '59bef2b3-18bf-5636-9fd2-53b08c8193e2', 'd772ab6d-51ae-5b99-82ce-8fdfee006a6e', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Haochen Lu', '225489', 'individual', 10,
    86.0, 58.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Haochen Lu. Division: Open. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ab87a5b9-2c3a-5a99-b51d-2fb2b28ef48f', '59bef2b3-18bf-5636-9fd2-53b08c8193e2', 'd772ab6d-51ae-5b99-82ce-8fdfee006a6e', 'Haochen Lu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59bef2b3-18bf-5636-9fd2-53b08c8193e2', 1, 14.0, 'DNF', true, '(14.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59bef2b3-18bf-5636-9fd2-53b08c8193e2', 2, 14.0, 'DNS', true, '(14.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59bef2b3-18bf-5636-9fd2-53b08c8193e2', 3, 14.0, 'DNC', false, '14.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59bef2b3-18bf-5636-9fd2-53b08c8193e2', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59bef2b3-18bf-5636-9fd2-53b08c8193e2', 5, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59bef2b3-18bf-5636-9fd2-53b08c8193e2', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59bef2b3-18bf-5636-9fd2-53b08c8193e2', 7, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59bef2b3-18bf-5636-9fd2-53b08c8193e2', 8, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '21dee8ed-be5e-5216-b323-f26b5fc0366d', 'a942aae6-1c23-511c-b386-fb0fbd704d06', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Ela Tezel', '213343', 'individual', 11,
    88.0, 60.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Ela Tezel. Division: Open. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '55c7d0f7-64bc-5eb1-83ac-59171fa543ee', '21dee8ed-be5e-5216-b323-f26b5fc0366d', 'a942aae6-1c23-511c-b386-fb0fbd704d06', 'Ela Tezel', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '21dee8ed-be5e-5216-b323-f26b5fc0366d', 1, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '21dee8ed-be5e-5216-b323-f26b5fc0366d', 2, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '21dee8ed-be5e-5216-b323-f26b5fc0366d', 3, 14.0, 'DNF', true, '(14.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '21dee8ed-be5e-5216-b323-f26b5fc0366d', 4, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '21dee8ed-be5e-5216-b323-f26b5fc0366d', 5, 14.0, 'DNS', true, '(14.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '21dee8ed-be5e-5216-b323-f26b5fc0366d', 6, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '21dee8ed-be5e-5216-b323-f26b5fc0366d', 7, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '21dee8ed-be5e-5216-b323-f26b5fc0366d', 8, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6df07329-297a-58be-8f0f-0352c810ed70', '45720fde-ed0e-5f9d-bf37-8d064283a182', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Minqi Zhu', '225098', 'individual', 12,
    89.0, 61.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Minqi Zhu. Division: Open. Nat: CHN.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '129cc153-7be4-5f00-9639-0eba8cbc9662', '6df07329-297a-58be-8f0f-0352c810ed70', '45720fde-ed0e-5f9d-bf37-8d064283a182', 'Minqi Zhu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6df07329-297a-58be-8f0f-0352c810ed70', 1, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6df07329-297a-58be-8f0f-0352c810ed70', 2, 14.0, 'DNS', true, '(14.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6df07329-297a-58be-8f0f-0352c810ed70', 3, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6df07329-297a-58be-8f0f-0352c810ed70', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6df07329-297a-58be-8f0f-0352c810ed70', 5, 14.0, 'UFD', true, '(14.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6df07329-297a-58be-8f0f-0352c810ed70', 6, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6df07329-297a-58be-8f0f-0352c810ed70', 7, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6df07329-297a-58be-8f0f-0352c810ed70', 8, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'dbd8224e-36c4-5239-8446-aff3f8e556f2', '69990555-b9fc-532f-a922-1c502dc62ec6', '5407e3b4-f6f1-5e34-add9-de2903c1fd97', 'Kai Story', '187010', 'individual', 13,
    112.0, 84.0, false, false, 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA6.htm', 'Official HKRW 2026 Results (RHKYC)',
    'document', 'HKRW 2026. Sailor: Kai Story. Division: Open. Nat: HKG.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd317a92e-bfef-5a44-bb55-008979ad073e', 'dbd8224e-36c4-5239-8446-aff3f8e556f2', '69990555-b9fc-532f-a922-1c502dc62ec6', 'Kai Story', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dbd8224e-36c4-5239-8446-aff3f8e556f2', 1, 14.0, 'DNC', true, '(14.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dbd8224e-36c4-5239-8446-aff3f8e556f2', 2, 14.0, 'DNC', true, '(14.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dbd8224e-36c4-5239-8446-aff3f8e556f2', 3, 14.0, 'DNC', false, '14.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dbd8224e-36c4-5239-8446-aff3f8e556f2', 4, 14.0, 'DNC', false, '14.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dbd8224e-36c4-5239-8446-aff3f8e556f2', 5, 14.0, 'DNC', false, '14.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dbd8224e-36c4-5239-8446-aff3f8e556f2', 6, 14.0, 'DNC', false, '14.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dbd8224e-36c4-5239-8446-aff3f8e556f2', 7, 14.0, 'DNC', false, '14.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dbd8224e-36c4-5239-8446-aff3f8e556f2', 8, 14.0, 'DNC', false, '14.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

COMMIT;
