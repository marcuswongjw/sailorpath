-- Migration 166: Sailor Demographics Enrichment (68 Genders, 193 DOBs) & Keep-Separate Registration
--
-- Enriches demographic fields for 255 active sailors with 100% verified corroboration
-- from official regatta scoring sheets (unanimous results only; zero speculative guessing).
-- Formally registers keep-separate pair for Yong Ai Chuang / Yong Ray Chuang in admin_change_log.
--
-- Compliance with AGENTS.md:
--   - Corroborated strictly against official federation result records.
--   - Uses standard SailorPath convention YYYY-01-01 when birth year is corroborated.
--   - Zero speculative guessing.
--
-- All operations executed in a single atomic transaction.

BEGIN;

-- ============================================================================
-- 1. GENDER ENRICHMENTS (68 SAILORS)
-- ============================================================================

-- Lily Cantwell (0774b01e-2dd0-5a3d-81d2-62386d3e7e68) -> Gender: 'F' (Source: 2025 Musto Australian Optimist Championship — Optimist Silver; 2025 NSW Optimist Championship — Optimist Open)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '0774b01e-2dd0-5a3d-81d2-62386d3e7e68' AND (gender IS NULL OR gender = '');

-- Yuechen Liu (09f2bdaa-0bdf-4228-acd5-fab4a5ff3189) -> Gender: 'F' (Source: 2023 Optimist Asian & Oceanian Championship (Optimist Overall); 2024 Optimist Asian & Oceanian Championship (Optimist Overall))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '09f2bdaa-0bdf-4228-acd5-fab4a5ff3189' AND (gender IS NULL OR gender = '');

-- Joshua Zhang (0de47a8f-c663-5d69-95e4-3a1aea8ab3ea) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver; 2026 Zhik Youth Sail South Australia — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '0de47a8f-c663-5d69-95e4-3a1aea8ab3ea' AND (gender IS NULL OR gender = '');

-- Tucker McKeon (0deba605-0d91-5f15-8ac4-c9bfdbc3281d) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '0deba605-0d91-5f15-8ac4-c9bfdbc3281d' AND (gender IS NULL OR gender = '');

-- Theodore Altson (0e4b7c7f-d18a-5551-b701-1ff02cf07f74) -> Gender: 'M' (Source: 2025 Musto Australian Optimist Championship — Optimist Intermediate; 2025 Organic Garden International Optimist Victorian & Open Championship — Optimist Intermediate)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74' AND (gender IS NULL OR gender = '');

-- Zane Taylor (1692bd9b-eddc-5ddf-ba96-ad67b45df7c8) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold; 2026 Zhik Youth Sail Queensland — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '1692bd9b-eddc-5ddf-ba96-ad67b45df7c8' AND (gender IS NULL OR gender = '');

-- Xavier Bates (1805d4ae-6d82-58a5-b751-b903c88d19d9) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open; 2026 Zhik Youth Sail Western Australia — ILCA 7)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '1805d4ae-6d82-58a5-b751-b903c88d19d9' AND (gender IS NULL OR gender = '');

-- Austin Higgins (204ec49b-39ff-53d9-bb39-e1891d13b0a8) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold; 2026 Zhik Youth Sail South Australia — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '204ec49b-39ff-53d9-bb39-e1891d13b0a8' AND (gender IS NULL OR gender = '');

-- Thun Pyae Zan (29990b00-de3f-51ec-a3c1-2fb250a82fbf) -> Gender: 'M' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; ODAM Fleet Championship 2025 (Optimist, Provisional))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '29990b00-de3f-51ec-a3c1-2fb250a82fbf' AND (gender IS NULL OR gender = '');

-- Oliver Atwell (2f613f35-4e2e-567e-83d4-e67f1e6e8dfb) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver; 2026 Zhik Youth Sail Northern Territory — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '2f613f35-4e2e-567e-83d4-e67f1e6e8dfb' AND (gender IS NULL OR gender = '');

-- Hugh Healy (349d2aaf-38ba-5138-97e9-5cee69c510bb) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold; 2026 Zhik Youth Sail Western Australia — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '349d2aaf-38ba-5138-97e9-5cee69c510bb' AND (gender IS NULL OR gender = '');

-- Boxuan Yu (3590c7e0-16bf-4193-973e-2d94d3a9e37d) -> Gender: 'M' (Source: 2024 ILCA Asian Open Championship (ILCA 4 Youth Boys U18); Hong Kong Race Week 2025 (ILCA 4))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '3590c7e0-16bf-4193-973e-2d94d3a9e37d' AND (gender IS NULL OR gender = '');

-- Harry Pilkington (360387e8-85ab-57f2-a4c7-ea887bbe07db) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold; 2026 Zhik Youth Sail Tasmania — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '360387e8-85ab-57f2-a4c7-ea887bbe07db' AND (gender IS NULL OR gender = '');

-- Lucy Walker (3cc84142-9672-5599-b421-11d08e024c31) -> Gender: 'F' (Source: 2025 Musto Australian Optimist Championship — Optimist Green; 2026 Zhik Youth Sail Queensland — ILCA 4)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '3cc84142-9672-5599-b421-11d08e024c31' AND (gender IS NULL OR gender = '');

-- Seth Till (3d70aa98-88dc-5a10-ada6-0a123739d648) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold; 2026 Zhik Youth Sail Western Australia — ILCA 4)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '3d70aa98-88dc-5a10-ada6-0a123739d648' AND (gender IS NULL OR gender = '');

-- Max Higley (40e96ecc-797d-501a-b179-75a15c65ef52) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver; 2026 Zhik Youth Sail South Australia — ILCA 4)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '40e96ecc-797d-501a-b179-75a15c65ef52' AND (gender IS NULL OR gender = '');

-- Zhongling Qi (4220cbc3-f523-5575-8abd-00610c01c3c3) -> Gender: 'F' (Source: 2023 Optimist Asian & Oceanian Championship (Optimist Overall); Hong Kong Race Week 2025 (Optimist Main))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '4220cbc3-f523-5575-8abd-00610c01c3c3' AND (gender IS NULL OR gender = '');

-- Matilda Tarring (43b9d0a2-01e0-5674-99aa-f4a050ad1cd6) -> Gender: 'F' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver; 2026 Zhik Youth Sail Queensland — ILCA 6)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '43b9d0a2-01e0-5674-99aa-f4a050ad1cd6' AND (gender IS NULL OR gender = '');

-- Jeremy Atwell (4629e1b0-74cf-5239-9f00-6c84db765d41) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver; 2026 Zhik Youth Sail Northern Territory — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '4629e1b0-74cf-5239-9f00-6c84db765d41' AND (gender IS NULL OR gender = '');

-- Ruby Pilkington (49dd9440-93c1-5ce6-a05c-0b799517ee96) -> Gender: 'F' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver; 2026 Zhik Youth Sail Tasmania — ILCA 4)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '49dd9440-93c1-5ce6-a05c-0b799517ee96' AND (gender IS NULL OR gender = '');

-- Adele Prior (51bedb4e-2e91-5b3d-bcdf-e6bc736642f2) -> Gender: 'F' (Source: 2025 Musto Australian Optimist Championship — Optimist Silver)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '51bedb4e-2e91-5b3d-bcdf-e6bc736642f2' AND (gender IS NULL OR gender = '');

-- BingJie Yan (58fb912f-79c6-5649-8b60-27ac74b3f452) -> Gender: 'F' (Source: 2024 Optimist Asian & Oceanian Championship (Optimist Overall); Hong Kong Race Week 2025 (Optimist Main))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '58fb912f-79c6-5649-8b60-27ac74b3f452' AND (gender IS NULL OR gender = '');

-- Morgan Grieve (59f4256f-e4e7-520e-819a-cf47bbc0250c) -> Gender: 'M' (Source: 2025 Musto Australian Optimist Championship — Optimist Gold; 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '59f4256f-e4e7-520e-819a-cf47bbc0250c' AND (gender IS NULL OR gender = '');

-- Htet Lin Zaw (5acb538c-6b7b-5ba7-8cb8-2aad97d20816) -> Gender: 'M' (Source: 33rd SEA Games 2025 — Sailing — ILCA 7; Pre-33rd SEA Games 2025 — ILCA 7)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '5acb538c-6b7b-5ba7-8cb8-2aad97d20816' AND (gender IS NULL OR gender = '');

-- Kaung Khant Khant Thu (5bb45750-85e3-5735-b9c4-b055b87af577) -> Gender: 'M' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Gold; ODAM Fleet Championship 2025 (Optimist, Provisional))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '5bb45750-85e3-5735-b9c4-b055b87af577' AND (gender IS NULL OR gender = '');

-- Eaint Chue Zayar (6319ae29-7ef6-53f0-aa9b-1770d73ed55c) -> Gender: 'F' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; ODAM Fleet Championship 2025 (Optimist, Provisional))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '6319ae29-7ef6-53f0-aa9b-1770d73ed55c' AND (gender IS NULL OR gender = '');

-- Charlie Putt (653f57cf-f7d2-5c3a-9c35-13e3a6431116) -> Gender: 'M' (Source: 2025 Musto Australian Optimist Championship — Optimist Gold; 2026 Musto Australian Optimist Championship (Optimist Gold))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116' AND (gender IS NULL OR gender = '');

-- Molli McIlwaine (6b6deac2-18ea-59be-a761-521789b7cdde) -> Gender: 'F' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver; 2026 Zhik Youth Sail Queensland — ILCA 4)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '6b6deac2-18ea-59be-a761-521789b7cdde' AND (gender IS NULL OR gender = '');

-- Jasper Stay (6b96ae16-4077-54dd-b438-30147aa14bb7) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold; 2026 Zhik Youth Sail Western Australia — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '6b96ae16-4077-54dd-b438-30147aa14bb7' AND (gender IS NULL OR gender = '');

-- Yong Liang Chuang (6bb8044b-6e37-4e15-84d2-605f5fecb2b7) -> Gender: 'M' (Source: 2023 Optimist Asian & Oceanian Championship (Optimist Overall); Hong Kong Race Week 2025 (ILCA 4))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '6bb8044b-6e37-4e15-84d2-605f5fecb2b7' AND (gender IS NULL OR gender = '');

-- Tommy Crone (6c4063f7-2bdb-5526-b6b6-fa781646d82c) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '6c4063f7-2bdb-5526-b6b6-fa781646d82c' AND (gender IS NULL OR gender = '');

-- George Burnett (6f9e44de-45c0-5b5c-b848-35e81fe8cdab) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '6f9e44de-45c0-5b5c-b848-35e81fe8cdab' AND (gender IS NULL OR gender = '');

-- Leigh Harvie (75a13a0e-836b-54f8-93b7-9b7d7fb8ced9) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold; 2026 Zhik Youth Sail New South Wales — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '75a13a0e-836b-54f8-93b7-9b7d7fb8ced9' AND (gender IS NULL OR gender = '');

-- William McGrath (78344a5b-d5d0-5f06-82ac-11b9351b39ee) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold; 2026 Zhik Youth Sail Northern Territory — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '78344a5b-d5d0-5f06-82ac-11b9351b39ee' AND (gender IS NULL OR gender = '');

-- Samuel Hart (78f78712-4830-5322-8055-fdbcc975c080) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold; 2026 Zhik Youth Sail Western Australia — ILCA 7)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '78f78712-4830-5322-8055-fdbcc975c080' AND (gender IS NULL OR gender = '');

-- Kirana Wardojo (79c6406b-143d-542d-a3fc-b8a328b93f96) -> Gender: 'F' (Source: 33rd SEA Games 2025 — Sailing — ILCA 6; Pre-33rd SEA Games 2025 — ILCA 6)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '79c6406b-143d-542d-a3fc-b8a328b93f96' AND (gender IS NULL OR gender = '');

-- Alisa Eangsantea (7b4c39c9-4e3c-511a-ad83-3d2871065992) -> Gender: 'F' (Source: 17th Eastern Seaboard Regatta 2025 — 420; Children’s Day Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '7b4c39c9-4e3c-511a-ad83-3d2871065992' AND (gender IS NULL OR gender = '');

-- Robyn Tutty (7d964f7a-a837-5385-99e3-d4d7d866cc24) -> Gender: 'F' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver; 2026 Zhik Youth Sail Western Australia — ILCA 6)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '7d964f7a-a837-5385-99e3-d4d7d866cc24' AND (gender IS NULL OR gender = '');

-- Enyu John Yin (86be27b5-6ef5-5894-a0e8-e823f4ea0659) -> Gender: 'M' (Source: 2025 Musto Australian Optimist Championship — Optimist Intermediate; 2025 NSW Optimist Championship — Optimist Intermediate)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659' AND (gender IS NULL OR gender = '');

-- Thomas Cooper (87b5a49b-135e-5b1f-82f2-ea37b3c109ed) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold; 2026 Zhik Youth Sail Western Australia — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '87b5a49b-135e-5b1f-82f2-ea37b3c109ed' AND (gender IS NULL OR gender = '');

-- Connor Inglis (8d536516-5a6a-535f-9ce1-cb0619a3565c) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver; 2026 Zhik Youth Sail South Australia — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '8d536516-5a6a-535f-9ce1-cb0619a3565c' AND (gender IS NULL OR gender = '');

-- Fredi O''Donoghue (92053cf1-036f-55e4-b514-e44586ab93af) -> Gender: 'F' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver; 2026 Zhik Youth Sail Tasmania — ILCA 4)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '92053cf1-036f-55e4-b514-e44586ab93af' AND (gender IS NULL OR gender = '');

-- Alastair Kernaghan (9276bce6-0f5f-5bdf-82ef-f0befc16c3f9) -> Gender: 'M' (Source: 2025 Musto Australian Optimist Championship — Optimist Intermediate; 2025 NSW Optimist Championship — Optimist Intermediate)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9' AND (gender IS NULL OR gender = '');

-- Matthew Pilkington (9734b9b9-30ab-52e2-8a49-cf91c3d0eb0a) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open; 2026 Zhik Youth Sail Tasmania — ILCA 7)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '9734b9b9-30ab-52e2-8a49-cf91c3d0eb0a' AND (gender IS NULL OR gender = '');

-- Rory Miller (a86c63a2-a425-58e9-a700-ee411b641df5) -> Gender: 'M' (Source: 2025 Musto Australian Optimist Championship — Optimist Silver; 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'a86c63a2-a425-58e9-a700-ee411b641df5' AND (gender IS NULL OR gender = '');

-- Harrison Rudham (b0432b6e-f5bb-5a48-a472-190a6f34218b) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold; 2026 Zhik Youth Sail New South Wales — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'b0432b6e-f5bb-5a48-a472-190a6f34218b' AND (gender IS NULL OR gender = '');

-- Yufei Chen (bd3f9394-9eb2-47c0-8c60-2b5cc89359fd) -> Gender: 'F' (Source: 2024 ILCA Asian Open Championship (ILCA 4 Youth Girls U18); Hong Kong Race Week 2025 (ILCA 4))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'bd3f9394-9eb2-47c0-8c60-2b5cc89359fd' AND (gender IS NULL OR gender = '');

-- Wilbur Bright (bd4e7fae-3f4b-5edc-9a56-1164fed5486c) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold; 2026 Zhik Youth Sail Queensland — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'bd4e7fae-3f4b-5edc-9a56-1164fed5486c' AND (gender IS NULL OR gender = '');

-- Louis Coates (c53693fc-922e-5457-ae79-c429839b765f) -> Gender: 'M' (Source: 2025 Musto Australian Optimist Championship — Optimist Silver; 2025 Organic Garden International Optimist Victorian & Open Championship — Optimist Open)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'c53693fc-922e-5457-ae79-c429839b765f' AND (gender IS NULL OR gender = '');

-- Alexandra Orchard (c6e6611e-f698-570d-8fd5-ec5566ae2b6d) -> Gender: 'F' (Source: 2025 Musto Australian Optimist Championship — Optimist Green; 2026 Zhik Youth Sail Queensland — Optimist Intermediate)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'c6e6611e-f698-570d-8fd5-ec5566ae2b6d' AND (gender IS NULL OR gender = '');

-- Jin Song Zhang (c7e11466-03d9-4c45-a8b2-81e080c543f9) -> Gender: 'M' (Source: 2024 ILCA Asian Open Championship (ILCA 4 Youth Boys U18); Hong Kong Race Week 2025 (ILCA 4))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'c7e11466-03d9-4c45-a8b2-81e080c543f9' AND (gender IS NULL OR gender = '');

-- Pitipoom Jaroenpon (d1624d92-8fde-5d56-9acb-69df6f18cb75) -> Gender: 'M' (Source: 17th Eastern Seaboard Regatta 2025 — 420; 2023 Optimist Asian & Oceanian Championship (Optimist Overall))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'd1624d92-8fde-5d56-9acb-69df6f18cb75' AND (gender IS NULL OR gender = '');

-- Luke Carrick (d21788fb-ab25-5974-a3de-2c1e42431fa2) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold; 2026 Zhik Youth Sail Western Australia — ILCA 7)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'd21788fb-ab25-5974-a3de-2c1e42431fa2' AND (gender IS NULL OR gender = '');

-- Gregory Roger Wardojo (d2d167b4-52fc-532a-8d72-11ffb103a300) -> Gender: 'M' (Source: 33rd SEA Games 2025 — Sailing — ILCA 7; Pre-33rd SEA Games 2025 — ILCA 7)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'd2d167b4-52fc-532a-8d72-11ffb103a300' AND (gender IS NULL OR gender = '');

-- Philip Reid (d51406cb-20e9-5cba-bf18-cff721623046) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open; 2026 Zhik Youth Sail Tasmania — ILCA 7)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'd51406cb-20e9-5cba-bf18-cff721623046' AND (gender IS NULL OR gender = '');

-- Courtney Harrison (d6485671-0de9-5522-b3de-262e2cc27a13) -> Gender: 'F' (Source: 2025 Musto Australian Optimist Championship — Optimist Intermediate; 2026 ACT Optimist Championship — Open Fleet)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'd6485671-0de9-5522-b3de-262e2cc27a13' AND (gender IS NULL OR gender = '');

-- Argon Palmer (dc9afb5f-4f17-5c3e-ade0-7bedb6c0b108) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold; 2026 Zhik Youth Sail South Australia — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'dc9afb5f-4f17-5c3e-ade0-7bedb6c0b108' AND (gender IS NULL OR gender = '');

-- Seraphina Townson (e373706e-da5f-59e8-add0-a53e1dd4797f) -> Gender: 'F' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver; 2026 Zhik Youth Sail Western Australia — ILCA 4)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'e373706e-da5f-59e8-add0-a53e1dd4797f' AND (gender IS NULL OR gender = '');

-- Nur Shazrin Mohamad Latif (e65296f7-fdc4-582a-b74b-fc2463ea8228) -> Gender: 'F' (Source: 33rd SEA Games 2025 — Sailing — ILCA 6; Pre-33rd SEA Games 2025 — ILCA 6)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' AND (gender IS NULL OR gender = '');

-- Phyu Cin Thadar (e9c8f1e1-acff-5660-ba36-6f75834f3421) -> Gender: 'F' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'e9c8f1e1-acff-5660-ba36-6f75834f3421' AND (gender IS NULL OR gender = '');

-- Caterina Meyer (ea191ba9-cbf0-5fb3-8818-c750df27f300) -> Gender: 'F' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold; 2026 Zhik Youth Sail Queensland — ILCA 6)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'ea191ba9-cbf0-5fb3-8818-c750df27f300' AND (gender IS NULL OR gender = '');

-- Zwel La Yaung (eccf0a0e-a600-599a-b300-79f74309a169) -> Gender: 'M' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'eccf0a0e-a600-599a-b300-79f74309a169' AND (gender IS NULL OR gender = '');

-- Olivia Barr (f0e4a9b7-53f2-5673-9852-b9b882846b62) -> Gender: 'F' (Source: 2025 Musto Australian Optimist Championship — Optimist Silver; 2026 Zhik Youth Sail Queensland — ILCA 4)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'f0e4a9b7-53f2-5673-9852-b9b882846b62' AND (gender IS NULL OR gender = '');

-- Oskar Bromberger (f2512712-39ec-5aac-9284-087252628007) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold; 2026 Zhik Youth Sail Western Australia — ILCA 4)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'f2512712-39ec-5aac-9284-087252628007' AND (gender IS NULL OR gender = '');

-- Kai Nakayama (f5fbefd7-6dec-5dc9-85bb-6e844cf0ffcc) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold; 2026 Zhik Youth Sail Western Australia — ILCA 4)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'f5fbefd7-6dec-5dc9-85bb-6e844cf0ffcc' AND (gender IS NULL OR gender = '');

-- Joshua King (fcbd6728-90fe-527f-bcea-d339fe168777) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold; 2026 Zhik Youth Sail Queensland — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'fcbd6728-90fe-527f-bcea-d339fe168777' AND (gender IS NULL OR gender = '');

-- Zac Howell (fd76cf0f-efe1-53bd-a6ef-3eb77be730cc) -> Gender: 'M' (Source: 2025 Musto Australian Optimist Championship — Optimist Gold; 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'fd76cf0f-efe1-53bd-a6ef-3eb77be730cc' AND (gender IS NULL OR gender = '');

-- Eddie Cleverly (ff6cfae4-b54d-5c85-9536-fe393faeb0e8) -> Gender: 'M' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver; 2026 Zhik Youth Sail New South Wales — ILCA 6)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'ff6cfae4-b54d-5c85-9536-fe393faeb0e8' AND (gender IS NULL OR gender = '');

-- ============================================================================
-- 2. DATE OF BIRTH (DOB) ENRICHMENTS (193 SAILORS)
-- ============================================================================

-- Claudia Nazarov (0078ae64-1507-5aed-8907-af6d48c2da7f) -> DOB: '2008-01-01' (Source: Children’s Day Regatta 2025 — ILCA 6; ILCA Thailand National Championships 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = '0078ae64-1507-5aed-8907-af6d48c2da7f' AND dob IS NULL;

-- Sasawat Puengpradit (00bec64f-201f-57d1-b9ae-fbafdbba4331) -> DOB: '2012-01-01' (Source: Children’s Day Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '00bec64f-201f-57d1-b9ae-fbafdbba4331' AND dob IS NULL;

-- Paliga Poonpat (00e255ee-fe4e-5ffd-a300-fb91012432b1) -> DOB: '2002-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 6; Thailand National Championship 2025 — Long Distance — ILCA 6)
UPDATE public.sailors
SET dob = '2002-01-01'::date, updated_at = clock_timestamp()
WHERE id = '00e255ee-fe4e-5ffd-a300-fb91012432b1' AND dob IS NULL;

-- Pwynn Rungruengrayubkul (02d171ca-7f90-502a-876d-ac445a323468) -> DOB: '2014-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver; Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '02d171ca-7f90-502a-876d-ac445a323468' AND dob IS NULL;

-- Thattep Jantapanya (0496f3f6-18c2-5544-9d5f-591617bde85f) -> DOB: '2012-01-01' (Source: Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '0496f3f6-18c2-5544-9d5f-591617bde85f' AND dob IS NULL;

-- Zhai Jingqi (054aee36-ca29-587c-a986-d818a393d57a) -> DOB: '2014-01-01' (Source: Thailand National Championship 2025 — Long Distance — Optimist)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '054aee36-ca29-587c-a986-d818a393d57a' AND dob IS NULL;

-- Ahmad Tsauban Bin Ramli (05a574c4-6f79-5e25-8c19-285f43eb1b63) -> DOB: '2009-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 6)
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = '05a574c4-6f79-5e25-8c19-285f43eb1b63' AND dob IS NULL;

-- Norio Akiyama (06ac765d-1d35-5c0c-9c7d-173bc45fc968) -> DOB: '1958-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '1958-01-01'::date, updated_at = clock_timestamp()
WHERE id = '06ac765d-1d35-5c0c-9c7d-173bc45fc968' AND dob IS NULL;

-- Nur Adlina Nasreen Binti Mohd Nasri (08805f7e-ee2e-52e8-823f-d9b7b81941ba) -> DOB: '2004-01-01' (Source: 2024 ILCA Asian Open Championship (ILCA 6 Women); ILCA Thailand National Championships 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2004-01-01'::date, updated_at = clock_timestamp()
WHERE id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' AND dob IS NULL;

-- Chayodom Seelalakh (089e667e-8089-5e95-b941-698999626cd6) -> DOB: '2009-01-01' (Source: Children’s Day Regatta 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = '089e667e-8089-5e95-b941-698999626cd6' AND dob IS NULL;

-- Thatthep Chanthapanya (08fef6b8-f195-5de7-8924-81160ccdb1ee) -> DOB: '2012-01-01' (Source: Trat Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '08fef6b8-f195-5de7-8924-81160ccdb1ee' AND dob IS NULL;

-- Nur Iman Sofia Binti Mohd Shazwan (0937f68f-464b-4655-98ec-2ce754ec2d33) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver; 22nd Langkawi International Regatta Perdana 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '0937f68f-464b-4655-98ec-2ce754ec2d33' AND dob IS NULL;

-- Ivan Karaman (0abd5bfd-e35f-5df9-8be8-62da3477de4e) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '0abd5bfd-e35f-5df9-8be8-62da3477de4e' AND dob IS NULL;

-- Zachary Tait (0b2ef30b-3fd7-5beb-8137-07340ecf5ea3) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; 2025 Musto Australian Optimist Championship — Optimist Gold)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '0b2ef30b-3fd7-5beb-8137-07340ecf5ea3' AND dob IS NULL;

-- Park Seong Hee (0edf08d5-0982-5feb-956f-80f0a8beee32) -> DOB: '2008-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = '0edf08d5-0982-5feb-956f-80f0a8beee32' AND dob IS NULL;

-- Kusalin Rordboonruang (10ea412e-5b0c-5fee-baf0-f558e2c04084) -> DOB: '2010-01-01' (Source: 37th Phuket King’s Cup Regatta 2025 — Optimist; ACDC Cup International Sailing Championship 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = '10ea412e-5b0c-5fee-baf0-f558e2c04084' AND dob IS NULL;

-- Scott Montgomery (1407fe63-bc6d-54dd-9076-8a89f70b2607) -> DOB: '1965-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1965-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1407fe63-bc6d-54dd-9076-8a89f70b2607' AND dob IS NULL;

-- Somros Buakaw (141154ce-e358-5b22-8f07-a6a8351e736c) -> DOB: '2012-01-01' (Source: 2026 Trat Regatta — Optimist Green; Trat Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '141154ce-e358-5b22-8f07-a6a8351e736c' AND dob IS NULL;

-- Pitchayut Jaroenphat (1a6a3369-0a69-54cb-a556-a5fbaff24454) -> DOB: '2014-01-01' (Source: 2025 YRAT Cup Series 5 — Optimist Silver)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1a6a3369-0a69-54cb-a556-a5fbaff24454' AND dob IS NULL;

-- Min Jeehei (1a7499fa-1b2b-5c12-8a70-9a85a381fda6) -> DOB: '2003-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2003-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1a7499fa-1b2b-5c12-8a70-9a85a381fda6' AND dob IS NULL;

-- Huang Yu Chieh (1acada38-b48d-5cb1-9016-563f3ae24665) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1acada38-b48d-5cb1-9016-563f3ae24665' AND dob IS NULL;

-- Banpoat Netkrachang (1b851f6a-eb86-5f45-9182-d8a232c66638) -> DOB: '1960-01-01' (Source: 2025 YRAT Cup Series 5 — ILCA 7 Master; Pattaya Regatta 2026 — ILCA 7)
UPDATE public.sailors
SET dob = '1960-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1b851f6a-eb86-5f45-9182-d8a232c66638' AND dob IS NULL;

-- Kan Sripoomkhai (1c15f478-eec9-5351-bfb7-83216e5a21c1) -> DOB: '1972-01-01' (Source: Thailand National Championship 2025 — Long Distance — ILCA 7)
UPDATE public.sailors
SET dob = '1972-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1c15f478-eec9-5351-bfb7-83216e5a21c1' AND dob IS NULL;

-- Nathan, Nande Li (1c5900eb-e05a-4376-a668-e3cd7cf3a2db) -> DOB: '2015-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; HKODA Open and National Championships 2026 — Optimist Main)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1c5900eb-e05a-4376-a668-e3cd7cf3a2db' AND dob IS NULL;

-- Kaan Bilgen (1d3643f3-3a40-5033-9d7a-31c9d35d1efc) -> DOB: '1973-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1973-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1d3643f3-3a40-5033-9d7a-31c9d35d1efc' AND dob IS NULL;

-- Muhammad Asnawi Iqbal Bin Adam (1e4b724c-4571-5f4a-8f48-73f77141691d) -> DOB: '2006-01-01' (Source: 19th Asian Games Hangzhou 2022 (Boy''s Dinghy - ILCA 4); 2024 ILCA Asian Open Championship (ILCA 7 Men))
UPDATE public.sailors
SET dob = '2006-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1e4b724c-4571-5f4a-8f48-73f77141691d' AND dob IS NULL;

-- Norakit Faothanom (1e767d30-91bd-58e1-b562-6aa545fbe932) -> DOB: '2013-01-01' (Source: Children’s Day Regatta 2025 — Optimist Gold)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1e767d30-91bd-58e1-b562-6aa545fbe932' AND dob IS NULL;

-- Kamonchanok Klahan (1e8de1ed-c7d0-570a-8972-4b587d575bd5) -> DOB: '2000-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2000-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1e8de1ed-c7d0-570a-8972-4b587d575bd5' AND dob IS NULL;

-- Kritkamon Prasertnopakun (2135c975-184e-5672-81ec-4fbcf85bcbf7) -> DOB: '2010-01-01' (Source: 2025 YRAT Cup Series 5 — ILCA 4; ACDC Cup International Sailing Championship 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2135c975-184e-5672-81ec-4fbcf85bcbf7' AND dob IS NULL;

-- Aarav Adnaan Jinwala (2237eb29-58b8-598c-8f8a-b9b7d63864a5) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2237eb29-58b8-598c-8f8a-b9b7d63864a5' AND dob IS NULL;

-- Huang,Shang-Kai (Rocky) (23f9e8e0-42ec-5054-bb35-ff2ff4c549dc) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '23f9e8e0-42ec-5054-bb35-ff2ff4c549dc' AND dob IS NULL;

-- Imanina Raisya bt Izhar (241af289-a3d3-4054-8f9a-a874c1a62471) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; 22nd Langkawi International Regatta Perdana 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '241af289-a3d3-4054-8f9a-a874c1a62471' AND dob IS NULL;

-- Martin Nazarov (247479a5-1bab-5515-acee-efe300334855) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '247479a5-1bab-5515-acee-efe300334855' AND dob IS NULL;

-- Eleanor Wong-Forhart (24dfa310-ddfe-5612-bf7a-efc33e9d8d1c) -> DOB: '2011-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '24dfa310-ddfe-5612-bf7a-efc33e9d8d1c' AND dob IS NULL;

-- Ivan Prudnikov (2512ea97-a33b-5e45-924d-ce1d6a0d8ea5) -> DOB: '2009-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 6)
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2512ea97-a33b-5e45-924d-ce1d6a0d8ea5' AND dob IS NULL;

-- Pongthep Chamnanchang (252b448c-a5dc-5ffa-8a00-a21a36a488d8) -> DOB: '2012-01-01' (Source: Trat Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '252b448c-a5dc-5ffa-8a00-a21a36a488d8' AND dob IS NULL;

-- Jay Kanchanabandhu (275c2a83-5605-5a6f-919c-482fe877d727) -> DOB: '2008-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = '275c2a83-5605-5a6f-919c-482fe877d727' AND dob IS NULL;

-- Ethan Yi Xuan Lim (28084792-a8b9-4ef8-b621-55231cb559a1) -> DOB: '2006-01-01' (Source: 17th SAFYC Regatta 2021 (ILCA 4); 18th SAFYC Regatta 2022 (ILCA 6))
UPDATE public.sailors
SET dob = '2006-01-01'::date, updated_at = clock_timestamp()
WHERE id = '28084792-a8b9-4ef8-b621-55231cb559a1' AND dob IS NULL;

-- Minyun , Yeh (2930fe0f-f92d-579b-b4ad-e126f189b59b) -> DOB: '2017-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2017-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2930fe0f-f92d-579b-b4ad-e126f189b59b' AND dob IS NULL;

-- Hamilton Zhao (298175a4-db74-4a70-a55c-fdd65f4d3004) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; 2025 NSW Optimist Championship — Optimist Open)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '298175a4-db74-4a70-a55c-fdd65f4d3004' AND dob IS NULL;

-- Thun Pyae Zan (29990b00-de3f-51ec-a3c1-2fb250a82fbf) -> DOB: '2011-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; ODAM Fleet Championship 2025 (Optimist, Provisional))
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '29990b00-de3f-51ec-a3c1-2fb250a82fbf' AND dob IS NULL;

-- Zachary Chew (2a82a295-7087-40e3-9552-6cf2438e0a6b) -> DOB: '2018-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver; Cincapura 2026 (Silver))
UPDATE public.sailors
SET dob = '2018-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2a82a295-7087-40e3-9552-6cf2438e0a6b' AND dob IS NULL;

-- Muhammad Rayyan Bin Mohd Yusof (2acc8f84-9322-4c4b-bd6c-6bd84c6fb136) -> DOB: '2012-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; 22nd Langkawi International Regatta Perdana 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2acc8f84-9322-4c4b-bd6c-6bd84c6fb136' AND dob IS NULL;

-- Natthamani Boonlikitchewa (2bc5829b-6211-5c3f-97fc-562996a23b0c) -> DOB: '2008-01-01' (Source: 2025 YRAT Cup Series 5 — ILCA 4)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2bc5829b-6211-5c3f-97fc-562996a23b0c' AND dob IS NULL;

-- Wasawat Puengpradit (2c1b6cea-2f95-5e1c-8895-2599a064f4fa) -> DOB: '2009-01-01' (Source: 2024 ILCA Asian Open Championship (ILCA 4 Youth Boys U18); 2025 YRAT Cup Series 5 — ILCA 4)
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2c1b6cea-2f95-5e1c-8895-2599a064f4fa' AND dob IS NULL;

-- Kim Jong Hwi (2d5a08d0-b75a-5097-9d88-989426fe2f12) -> DOB: '2007-01-01' (Source: 19th Asian Games Hangzhou 2022 (Boy''s Dinghy - ILCA 4); ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '2007-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2d5a08d0-b75a-5097-9d88-989426fe2f12' AND dob IS NULL;

-- Umi Nurcamelia Binti Salahuddin (2e45d3f1-a681-52f2-8570-afd3c3647a28) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2e45d3f1-a681-52f2-8570-afd3c3647a28' AND dob IS NULL;

-- Sarawut Panphiboon (2f22eebd-9bdc-549a-a5a9-6bea594a58ff) -> DOB: '2008-01-01' (Source: Children’s Day Regatta 2025 — ILCA 4; ILCA Thailand National Championships 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2f22eebd-9bdc-549a-a5a9-6bea594a58ff' AND dob IS NULL;

-- Kram Chantarawinij (2faf8eb3-aabb-4616-bc87-cea77c033f8c) -> DOB: '2011-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 4; RSYC Optimist Knockout Championship 2024 (Gold))
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2faf8eb3-aabb-4616-bc87-cea77c033f8c' AND dob IS NULL;

-- Max Moldovan (306930d7-9cad-58ed-ba9f-dab0b603effe) -> DOB: '1989-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1989-01-01'::date, updated_at = clock_timestamp()
WHERE id = '306930d7-9cad-58ed-ba9f-dab0b603effe' AND dob IS NULL;

-- Watthanaphong Taphim (30931733-4456-5ac9-855e-e09705774b51) -> DOB: '2010-01-01' (Source: Children’s Day Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = '30931733-4456-5ac9-855e-e09705774b51' AND dob IS NULL;

-- Jarrod Toh (34e36e78-abc0-4ba7-9739-3fe5b465be89) -> DOB: '2007-01-01' (Source: 17th SAFYC Regatta 2021 (ILCA 4); 18th SAFYC Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET dob = '2007-01-01'::date, updated_at = clock_timestamp()
WHERE id = '34e36e78-abc0-4ba7-9739-3fe5b465be89' AND dob IS NULL;

-- Thanh Theerapasiri (34e51da7-60d4-5918-8e02-8545a554ea46) -> DOB: '2011-01-01' (Source: Children’s Day Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '34e51da7-60d4-5918-8e02-8545a554ea46' AND dob IS NULL;

-- Fengziyi Fu (34fe033f-bb33-58e5-aedb-a78fc1809851) -> DOB: '2010-01-01' (Source: 2024 ILCA Asian Open Championship (ILCA 4 Youth Boys U18); Thailand National Championship 2025 — Long Distance — ILCA 4)
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = '34fe033f-bb33-58e5-aedb-a78fc1809851' AND dob IS NULL;

-- Tsai-Chien Wu (363e5317-2c81-5af0-b407-6717ac0b3bda) -> DOB: '2005-01-01' (Source: 2024 ILCA Asian Open Championship (ILCA 7 Men); ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '2005-01-01'::date, updated_at = clock_timestamp()
WHERE id = '363e5317-2c81-5af0-b407-6717ac0b3bda' AND dob IS NULL;

-- Kwangyeon Lee (36ea7d59-1c3f-57be-abde-375931da4d40) -> DOB: '1992-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1992-01-01'::date, updated_at = clock_timestamp()
WHERE id = '36ea7d59-1c3f-57be-abde-375931da4d40' AND dob IS NULL;

-- Shahab Khatam (392798bc-1758-555a-b6cc-962e074b68fd) -> DOB: '1991-01-01' (Source: ILCA District Championship 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1991-01-01'::date, updated_at = clock_timestamp()
WHERE id = '392798bc-1758-555a-b6cc-962e074b68fd' AND dob IS NULL;

-- Shinnapat Mahathanakom (3a234c9e-8552-5b11-85a9-b66448dbb40c) -> DOB: '2011-01-01' (Source: Children’s Day Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '3a234c9e-8552-5b11-85a9-b66448dbb40c' AND dob IS NULL;

-- Chattapat Plienprasit (3ab32092-7117-5bfa-9352-2144fd371eae) -> DOB: '2015-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = '3ab32092-7117-5bfa-9352-2144fd371eae' AND dob IS NULL;

-- Sitt May Chit Po (3adcdfee-1b33-409f-9e45-a9d3fc4a2725) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; 2025 Optimist Asian & Oceanian Championship (Optimist Overall))
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '3adcdfee-1b33-409f-9e45-a9d3fc4a2725' AND dob IS NULL;

-- Rotjana Asawawatanaporn (3dd7f89c-5563-56f5-a268-c891ffc68f60) -> DOB: '1969-01-01' (Source: ILCA District Championship 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '1969-01-01'::date, updated_at = clock_timestamp()
WHERE id = '3dd7f89c-5563-56f5-a268-c891ffc68f60' AND dob IS NULL;

-- Paniti Praditchit (3e716d05-8277-5636-b767-e4c729e2bea8) -> DOB: '2012-01-01' (Source: Children’s Day Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '3e716d05-8277-5636-b767-e4c729e2bea8' AND dob IS NULL;

-- Jessada Namwong (3f585228-fe16-5a16-8cd9-cfd471eb53fb) -> DOB: '2012-01-01' (Source: Children’s Day Regatta 2025 — ILCA 4; Thailand National Championship 2025 — Long Distance — ILCA 4)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '3f585228-fe16-5a16-8cd9-cfd471eb53fb' AND dob IS NULL;

-- Jakkrapat Vongtim (41519e2c-4a0e-5943-85f0-79e441e88df5) -> DOB: '2010-01-01' (Source: Children’s Day Regatta 2025 — ILCA 6; Pre-33rd SEA Games 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = '41519e2c-4a0e-5943-85f0-79e441e88df5' AND dob IS NULL;

-- Henry Thomas Kuratle (45169513-7b8d-5bd6-bbe3-88fbb8247031) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '45169513-7b8d-5bd6-bbe3-88fbb8247031' AND dob IS NULL;

-- Natthapat Chotipisarn (452ed06c-8b14-59dc-8d66-ea066c8e7414) -> DOB: '2000-01-01' (Source: Thailand National Championship 2025 — Long Distance — ILCA 7)
UPDATE public.sailors
SET dob = '2000-01-01'::date, updated_at = clock_timestamp()
WHERE id = '452ed06c-8b14-59dc-8d66-ea066c8e7414' AND dob IS NULL;

-- Kan Kanchanabandh (4587ab4c-aa80-5ece-a835-19aa5b83310d) -> DOB: '2008-01-01' (Source: ILCA District Championship 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = '4587ab4c-aa80-5ece-a835-19aa5b83310d' AND dob IS NULL;

-- Porpiang Sae-Uy (47efefde-bce7-57b4-b32e-a50df4b5984d) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '47efefde-bce7-57b4-b32e-a50df4b5984d' AND dob IS NULL;

-- Poramut Srisawaddisrilodom (499c67de-06e1-5c6f-a3f1-694b2342b326) -> DOB: '2009-01-01' (Source: 37th Phuket King’s Cup Regatta 2025 — ILCA 4; ACDC Cup International Sailing Championship 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = '499c67de-06e1-5c6f-a3f1-694b2342b326' AND dob IS NULL;

-- Roman Philip (4a65897a-050e-5729-84d3-75746107707a) -> DOB: '2014-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '4a65897a-050e-5729-84d3-75746107707a' AND dob IS NULL;

-- Hnin Eaindrae (4dc907be-d2ed-5616-abe8-004804a9b2fc) -> DOB: '2013-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '4dc907be-d2ed-5616-abe8-004804a9b2fc' AND dob IS NULL;

-- Khant Zin Thaw (4f380165-9a64-4366-911f-b15dacc6bbda) -> DOB: '2012-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4; 2025 Optimist Asian & Oceanian Championship (Optimist Overall))
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '4f380165-9a64-4366-911f-b15dacc6bbda' AND dob IS NULL;

-- Milton Li (51a80a27-8665-4db2-afb4-0940cbc20376) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; 2025 Musto Australian Optimist Championship — Optimist Intermediate)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '51a80a27-8665-4db2-afb4-0940cbc20376' AND dob IS NULL;

-- Ethan McAullay (53e1f8fb-197e-501c-97fc-10b918763ae5) -> DOB: '2001-01-01' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open; ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '2001-01-01'::date, updated_at = clock_timestamp()
WHERE id = '53e1f8fb-197e-501c-97fc-10b918763ae5' AND dob IS NULL;

-- Yumeng Li (574a4d8f-58d3-443a-aa33-1e9cb01024ee) -> DOB: '2014-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver; Singapore National Sailing Championships 2026 (Gold))
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '574a4d8f-58d3-443a-aa33-1e9cb01024ee' AND dob IS NULL;

-- Naing Lin Aung (586ae1d6-91c4-4189-b0a4-b8cd05f0a15a) -> DOB: '2012-01-01' (Source: 2024 Optimist Asian & Oceanian Championship (Optimist Overall); 2025 Optimist Asian & Oceanian Championship (Optimist Overall))
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '586ae1d6-91c4-4189-b0a4-b8cd05f0a15a' AND dob IS NULL;

-- Manat Thongjiam (58b7b23a-debb-5dd7-a384-ea2fc04e1840) -> DOB: '1950-01-01' (Source: 2025 YRAT Cup Series 5 — ILCA 7 Master)
UPDATE public.sailors
SET dob = '1950-01-01'::date, updated_at = clock_timestamp()
WHERE id = '58b7b23a-debb-5dd7-a384-ea2fc04e1840' AND dob IS NULL;

-- Napatsakorn Wongprom (58eb296d-6b5f-50ef-8b4d-a23156b45e9f) -> DOB: '2009-01-01' (Source: Children’s Day Regatta 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = '58eb296d-6b5f-50ef-8b4d-a23156b45e9f' AND dob IS NULL;

-- Woraphop Chatsri (58f3112a-b122-5646-bd0d-ccd8eb33fcdf) -> DOB: '2015-01-01' (Source: Children’s Day Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = '58f3112a-b122-5646-bd0d-ccd8eb33fcdf' AND dob IS NULL;

-- Phakpham Sae-Auy (5a7eadc5-4b5c-5242-9161-9b6ee6fc4e2b) -> DOB: '2015-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = '5a7eadc5-4b5c-5242-9161-9b6ee6fc4e2b' AND dob IS NULL;

-- Kaung Khant Khant Thu (5bb45750-85e3-5735-b9c4-b055b87af577) -> DOB: '2011-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Gold; ODAM Fleet Championship 2025 (Optimist, Provisional))
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '5bb45750-85e3-5735-b9c4-b055b87af577' AND dob IS NULL;

-- Muhammad Ada Mfarina Bin Guido Farina (5d0aec2a-d505-5f9b-961f-00a7003994c3) -> DOB: '2016-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2016-01-01'::date, updated_at = clock_timestamp()
WHERE id = '5d0aec2a-d505-5f9b-961f-00a7003994c3' AND dob IS NULL;

-- Qinghe Wu (5ef47535-be2f-4a76-86d6-474e9d8b14ab) -> DOB: '2014-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver; Singapore National Sailing Championships 2026 (Gold))
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '5ef47535-be2f-4a76-86d6-474e9d8b14ab' AND dob IS NULL;

-- Lauren Lim Xiu Qing (5fef1999-39e8-57bd-9e60-a8a9de0eead2) -> DOB: '2012-01-01' (Source: ILCA District Championship 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '5fef1999-39e8-57bd-9e60-a8a9de0eead2' AND dob IS NULL;

-- Shin May Kha Kyaw (61793964-ab3a-4d40-b8a1-57c94a420ca1) -> DOB: '2011-01-01' (Source: 2024 Optimist Asian & Oceanian Championship (Optimist Overall); ACDC Cup International Sailing Championship 2025 — Optimist Gold)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '61793964-ab3a-4d40-b8a1-57c94a420ca1' AND dob IS NULL;

-- Lorenzo Brando Chiavarini (61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1) -> DOB: '1994-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1994-01-01'::date, updated_at = clock_timestamp()
WHERE id = '61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1' AND dob IS NULL;

-- Satoshi Mouri (61d2947c-385f-50ce-ac97-aa69c3e513ef) -> DOB: '1980-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '1980-01-01'::date, updated_at = clock_timestamp()
WHERE id = '61d2947c-385f-50ce-ac97-aa69c3e513ef' AND dob IS NULL;

-- Eaint Chue Zayar (6319ae29-7ef6-53f0-aa9b-1770d73ed55c) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; ODAM Fleet Championship 2025 (Optimist, Provisional))
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '6319ae29-7ef6-53f0-aa9b-1770d73ed55c' AND dob IS NULL;

-- Abigail Koh (63d082ef-363c-4b69-929a-25341b195a08) -> DOB: '2006-01-01' (Source: 17th SAFYC Regatta 2021 (ILCA 4); 18th SAFYC Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET dob = '2006-01-01'::date, updated_at = clock_timestamp()
WHERE id = '63d082ef-363c-4b69-929a-25341b195a08' AND dob IS NULL;

-- Jeremy Ein (64a16ae0-dd22-57c2-9f39-cbcae2141900) -> DOB: '2009-01-01' (Source: Children’s Day Regatta 2025 — ILCA 4; Trat Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = '64a16ae0-dd22-57c2-9f39-cbcae2141900' AND dob IS NULL;

-- Ayuth Saligupta (6610e632-bab1-56a5-b382-4eb478eab3ad) -> DOB: '1968-01-01' (Source: ACDC Cup International Sailing Championship 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1968-01-01'::date, updated_at = clock_timestamp()
WHERE id = '6610e632-bab1-56a5-b382-4eb478eab3ad' AND dob IS NULL;

-- Boseong Jeon (67c7dbe2-74b3-533e-b56a-966db6ba44a8) -> DOB: '2005-01-01' (Source: Children’s Day Regatta 2025 — ILCA 6; ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '2005-01-01'::date, updated_at = clock_timestamp()
WHERE id = '67c7dbe2-74b3-533e-b56a-966db6ba44a8' AND dob IS NULL;

-- Luck Puapitsirikul (68fea819-ebd7-5cec-9b89-de1d58136f05) -> DOB: '2010-01-01' (Source: ACDC Cup International Sailing Championship 2025 — ILCA 6; Children’s Day Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = '68fea819-ebd7-5cec-9b89-de1d58136f05' AND dob IS NULL;

-- Sirisak Narkmee (69b4678e-fe85-5161-ac3e-d5d2894d3ff4) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '69b4678e-fe85-5161-ac3e-d5d2894d3ff4' AND dob IS NULL;

-- Panatchaya Okabe (6a341c74-bab2-5d41-9e0c-42e7cbca2db1) -> DOB: '2014-01-01' (Source: Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '6a341c74-bab2-5d41-9e0c-42e7cbca2db1' AND dob IS NULL;

-- Aleksandr Kuimov (6a514194-8171-55dc-a5f6-ee36e3ad67eb) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '6a514194-8171-55dc-a5f6-ee36e3ad67eb' AND dob IS NULL;

-- Papawarin Boonkrom (6b99ab68-3ece-5459-8d9d-8de843babb04) -> DOB: '2014-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '6b99ab68-3ece-5459-8d9d-8de843babb04' AND dob IS NULL;

-- Huang Yu Tzu (6e4263c5-fa7d-5f0f-ac9f-1889811e809b) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '6e4263c5-fa7d-5f0f-ac9f-1889811e809b' AND dob IS NULL;

-- Andrei Melnikov (70116a32-eafa-5489-ad85-5e53c554ad26) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '70116a32-eafa-5489-ad85-5e53c554ad26' AND dob IS NULL;

-- Irfan Yusran Bin Md Said (70a80a6a-c406-46cc-8253-3037060eaa82) -> DOB: '2015-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; 22nd Langkawi International Regatta Perdana 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = '70a80a6a-c406-46cc-8253-3037060eaa82' AND dob IS NULL;

-- Monika Kochetovskaia (73123936-1c40-5eb2-87bc-938caf295d0a) -> DOB: '2012-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '73123936-1c40-5eb2-87bc-938caf295d0a' AND dob IS NULL;

-- Alisa Eangsantea (7b4c39c9-4e3c-511a-ad83-3d2871065992) -> DOB: '2011-01-01' (Source: 17th Eastern Seaboard Regatta 2025 — 420; Children’s Day Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '7b4c39c9-4e3c-511a-ad83-3d2871065992' AND dob IS NULL;

-- Kenan Kee Zen Tan (7baafbd0-cddb-4217-9727-a692f6902b79) -> DOB: '2007-01-01' (Source: 17th SAFYC Regatta 2021 (Optimist Gold); 18th SAFYC Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET dob = '2007-01-01'::date, updated_at = clock_timestamp()
WHERE id = '7baafbd0-cddb-4217-9727-a692f6902b79' AND dob IS NULL;

-- Muhammad Zulfan Akif Bin Mohd Zulkifly (7bea3cb4-93e5-4d24-acc5-2d19d538aa88) -> DOB: '2011-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4; 22nd Langkawi International Regatta Perdana 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '7bea3cb4-93e5-4d24-acc5-2d19d538aa88' AND dob IS NULL;

-- Timur Seleznev (802b99e3-2ef5-5c5c-9391-00ab8a672411) -> DOB: '2012-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '802b99e3-2ef5-5c5c-9391-00ab8a672411' AND dob IS NULL;

-- Patcharaphan Ongkaloy (8172e4c4-722d-5ba7-afde-e325ba965e6b) -> DOB: '2008-01-01' (Source: 2023 Optimist Asian & Oceanian Championship (Optimist Overall); Children’s Day Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8172e4c4-722d-5ba7-afde-e325ba965e6b' AND dob IS NULL;

-- Min Sngjun (82a4cec5-7b0b-569b-804d-ddafa887123a) -> DOB: '1970-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1970-01-01'::date, updated_at = clock_timestamp()
WHERE id = '82a4cec5-7b0b-569b-804d-ddafa887123a' AND dob IS NULL;

-- Muhammad Amsha Danish Bin Ruzaki (82a773a8-d54c-4da8-8488-fd592c468b52) -> DOB: '2011-01-01' (Source: 22nd Langkawi International Regatta Perdana 2026 — Optimist Gold; Thailand National Championship 2025 — Long Distance — Optimist)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '82a773a8-d54c-4da8-8488-fd592c468b52' AND dob IS NULL;

-- Nur Ariana Sofea Binti Adzarul Fadzlie (82a97410-99ec-49b8-8eb7-95b023cbe6f8) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; 22nd Langkawi International Regatta Perdana 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '82a97410-99ec-49b8-8eb7-95b023cbe6f8' AND dob IS NULL;

-- Nicole Ashley Quek (83852500-a6d8-4363-80b4-224aa85d0af5) -> DOB: '2009-01-01' (Source: 17th SAFYC Regatta 2021 (Optimist Gold); 18th SAFYC Regatta 2022 (Optimist Gold))
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = '83852500-a6d8-4363-80b4-224aa85d0af5' AND dob IS NULL;

-- Shinya Sratongsang (844cf291-9c9d-584f-aef0-ca2c46cb4d5c) -> DOB: '2015-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = '844cf291-9c9d-584f-aef0-ca2c46cb4d5c' AND dob IS NULL;

-- Aurick Leow You Shun (85614793-d030-483c-9ce8-57f7edcc4add) -> DOB: '2008-01-01' (Source: 17th SAFYC Regatta 2021 (Optimist Gold); 18th SAFYC Regatta 2022 (Optimist Gold))
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = '85614793-d030-483c-9ce8-57f7edcc4add' AND dob IS NULL;

-- Nur Alia Amera Binti Mohamad Latif (8813d941-a761-5ea0-8a0b-f6ed49ff38b8) -> DOB: '2003-01-01' (Source: 2024 ILCA Asian Open Championship (ILCA 6 Women); ILCA Thailand National Championships 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2003-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' AND dob IS NULL;

-- Aleksei Tugov (8957725b-2ee0-58b6-86a8-f0dac300f5e8) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8957725b-2ee0-58b6-86a8-f0dac300f5e8' AND dob IS NULL;

-- Mr.Antony Grover (896f126d-aafb-5064-908d-ac7dac738531) -> DOB: '1970-01-01' (Source: 2025 YRAT Cup Series 5 — ILCA 7 Master)
UPDATE public.sailors
SET dob = '1970-01-01'::date, updated_at = clock_timestamp()
WHERE id = '896f126d-aafb-5064-908d-ac7dac738531' AND dob IS NULL;

-- Manitho Henry (8ab2a9fd-f982-5e3c-9da5-09078d65cc7a) -> DOB: '2008-01-01' (Source: Children’s Day Regatta 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8ab2a9fd-f982-5e3c-9da5-09078d65cc7a' AND dob IS NULL;

-- Bao Yuan Lou (8acdb854-5826-56d3-80b5-e7b01b56691e) -> DOB: '2014-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8acdb854-5826-56d3-80b5-e7b01b56691e' AND dob IS NULL;

-- Patara Pongsai (8b07b00f-6a88-53c2-9a92-10435ba36b2f) -> DOB: '2013-01-01' (Source: Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8b07b00f-6a88-53c2-9a92-10435ba36b2f' AND dob IS NULL;

-- Miss Kodchaporn Peungchimplee (8b4d492f-a4f3-5d3b-b131-9b33a47eb387) -> DOB: '2015-01-01' (Source: 2025 YRAT Cup Series 5 — Optimist Silver; Trat Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8b4d492f-a4f3-5d3b-b131-9b33a47eb387' AND dob IS NULL;

-- Prapassorn Kaewprom (8d54107d-d292-5e13-9616-cf53bbd41c87) -> DOB: '2009-01-01' (Source: 2024 Optimist Asian & Oceanian Championship (Optimist Overall); ACDC Cup International Sailing Championship 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8d54107d-d292-5e13-9616-cf53bbd41c87' AND dob IS NULL;

-- Elliot Hansen (8f66574a-1cc9-557a-b01b-87608ee05c60) -> DOB: '1994-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1994-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8f66574a-1cc9-557a-b01b-87608ee05c60' AND dob IS NULL;

-- Gleb Shibaev (911bee8f-8fc9-58b7-adf7-4326404aa970) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '911bee8f-8fc9-58b7-adf7-4326404aa970' AND dob IS NULL;

-- Pamonporn Jimkratoke (921754b1-78cb-5f5c-a42e-6eebfc8b3122) -> DOB: '2011-01-01' (Source: Children’s Day Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '921754b1-78cb-5f5c-a42e-6eebfc8b3122' AND dob IS NULL;

-- Yun Xi Wang (932583e1-bd68-5d50-a689-8ff59e2ac673) -> DOB: '2014-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '932583e1-bd68-5d50-a689-8ff59e2ac673' AND dob IS NULL;

-- Isaac Goh (93fc1c81-1ec7-4600-b9a1-bc613d11449c) -> DOB: '2007-01-01' (Source: 17th SAFYC Regatta 2021 (Optimist Gold); 18th SAFYC Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET dob = '2007-01-01'::date, updated_at = clock_timestamp()
WHERE id = '93fc1c81-1ec7-4600-b9a1-bc613d11449c' AND dob IS NULL;

-- Casey Algra (957c49e1-11ff-5bd5-adbe-e59de172eb0c) -> DOB: '1951-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1951-01-01'::date, updated_at = clock_timestamp()
WHERE id = '957c49e1-11ff-5bd5-adbe-e59de172eb0c' AND dob IS NULL;

-- Piyapat Tiathongchai (98786c00-1b5f-5272-98bf-14a3d4c0c3a1) -> DOB: '2012-01-01' (Source: Children’s Day Regatta 2025 — ILCA 4; EGAT and YRAT Regatta 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '98786c00-1b5f-5272-98bf-14a3d4c0c3a1' AND dob IS NULL;

-- Phakphum Woraras (9d8ac17e-a6e5-5076-937f-bfbdab210ff9) -> DOB: '2014-01-01' (Source: Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '9d8ac17e-a6e5-5076-937f-bfbdab210ff9' AND dob IS NULL;

-- Yong Ai Chuang (9e435ef8-0d1f-5789-bd82-eab75023cf9d) -> DOB: '2015-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = '9e435ef8-0d1f-5789-bd82-eab75023cf9d' AND dob IS NULL;

-- Purisa Ngamwannakul (9f4dfeee-c388-5557-8000-48a31d88d676) -> DOB: '2014-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver; Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '9f4dfeee-c388-5557-8000-48a31d88d676' AND dob IS NULL;

-- Thiraya Sungthong (9f63cb3f-b61c-58fd-b16d-f7da2885ce64) -> DOB: '2014-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver; Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '9f63cb3f-b61c-58fd-b16d-f7da2885ce64' AND dob IS NULL;

-- Hon Muk Sen (9fc4186f-e2cd-500e-879a-551b4a812776) -> DOB: '2012-01-01' (Source: Thailand National Championship 2025 — Long Distance — Optimist)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '9fc4186f-e2cd-500e-879a-551b4a812776' AND dob IS NULL;

-- Karuna Ampolsak (a424a6dd-9220-5774-8868-71ab684ea413) -> DOB: '2014-01-01' (Source: Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'a424a6dd-9220-5774-8868-71ab684ea413' AND dob IS NULL;

-- Supanada Singcharoen (a55dde8c-8470-53e9-8bc7-77aed0109e73) -> DOB: '2012-01-01' (Source: Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'a55dde8c-8470-53e9-8bc7-77aed0109e73' AND dob IS NULL;

-- Danielle Lai (a95b6b0a-6c38-40b6-a0bc-2dcaa9bcb9e2) -> DOB: '2009-01-01' (Source: 17th SAFYC Regatta 2021 (Optimist Silver); 18th SAFYC Regatta 2022 (Optimist Gold))
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'a95b6b0a-6c38-40b6-a0bc-2dcaa9bcb9e2' AND dob IS NULL;

-- Myat Toe Khant (a98245bb-cdc1-5316-b2fb-a3a3b6abe97a) -> DOB: '2018-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2018-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'a98245bb-cdc1-5316-b2fb-a3a3b6abe97a' AND dob IS NULL;

-- Nikolai Voloshenko (a9a349ff-216c-5d03-9e82-b8b156dd8179) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'a9a349ff-216c-5d03-9e82-b8b156dd8179' AND dob IS NULL;

-- Nattanun Pimpirujanun (abbc2601-9ac8-54ef-a6cc-b00c35c8cfe5) -> DOB: '2005-01-01' (Source: Thailand National Championship 2025 — Long Distance — ILCA 7)
UPDATE public.sailors
SET dob = '2005-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'abbc2601-9ac8-54ef-a6cc-b00c35c8cfe5' AND dob IS NULL;

-- Nur Zafrina Syuhada Binti Mohd Zailan (b33f7ace-2a40-5394-8858-007b26ae3163) -> DOB: '2008-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 6; 2024 ILCA Asian Open Championship (ILCA 4 Youth Girls U18))
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'b33f7ace-2a40-5394-8858-007b26ae3163' AND dob IS NULL;

-- Finn Alexander (b4938406-56a7-51fc-8f9f-0f449391879e) -> DOB: '1998-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1998-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'b4938406-56a7-51fc-8f9f-0f449391879e' AND dob IS NULL;

-- Boonbaramee Sonchai (b84ee6d4-653e-5333-b76a-4ffc05fab46f) -> DOB: '2009-01-01' (Source: ACDC Cup International Sailing Championship 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'b84ee6d4-653e-5333-b76a-4ffc05fab46f' AND dob IS NULL;

-- Harry Cooper (b8cbccdc-a8ce-47cf-8728-5011daab6617) -> DOB: '2015-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; 2025 Musto Australian Optimist Championship — Optimist Silver)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'b8cbccdc-a8ce-47cf-8728-5011daab6617' AND dob IS NULL;

-- Owen Wong-Forhart (b9cf87e5-6fa9-5f79-909f-1814c8d79999) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'b9cf87e5-6fa9-5f79-909f-1814c8d79999' AND dob IS NULL;

-- Klorkwan Visuttiprapanont (b9d6802f-7420-5d7a-8c2c-86bb6c6d0486) -> DOB: '2008-01-01' (Source: Children’s Day Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'b9d6802f-7420-5d7a-8c2c-86bb6c6d0486' AND dob IS NULL;

-- Ting-Jen Lin (bbc40d80-aedd-5383-8e46-063b2f8cabe0) -> DOB: '2011-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'bbc40d80-aedd-5383-8e46-063b2f8cabe0' AND dob IS NULL;

-- Yun Tae Yang (bc2d10a9-4ca3-5841-9029-478101b36964) -> DOB: '2008-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'bc2d10a9-4ca3-5841-9029-478101b36964' AND dob IS NULL;

-- Xiu Yu Zhao (bde172a1-ab89-5cb9-a372-2dbb98bd8337) -> DOB: '2010-01-01' (Source: ACDC Cup International Sailing Championship 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'bde172a1-ab89-5cb9-a372-2dbb98bd8337' AND dob IS NULL;

-- Muhamad Faizal Bin Ahmad Asri (c0f5986d-b0c5-58fc-b6d0-6324db45b52e) -> DOB: '2004-01-01' (Source: 2024 ILCA Asian Open Championship (ILCA 7 Men); ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '2004-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' AND dob IS NULL;

-- Anusara Polchai (c4d90d22-b468-5cd7-becf-dbcd7c7cb8ab) -> DOB: '2012-01-01' (Source: Children’s Day Regatta 2025 — Optimist Silver; Thailand National Championship 2025 — Long Distance — Optimist)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'c4d90d22-b468-5cd7-becf-dbcd7c7cb8ab' AND dob IS NULL;

-- Nond Sukapattee (c9bafcd3-940d-5bd4-a7d3-ae516e71583d) -> DOB: '2011-01-01' (Source: ACDC Cup International Sailing Championship 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'c9bafcd3-940d-5bd4-a7d3-ae516e71583d' AND dob IS NULL;

-- Vera Karaman (cdbf4c0c-cfd5-566e-a1bf-2a7ffc482906) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'cdbf4c0c-cfd5-566e-a1bf-2a7ffc482906' AND dob IS NULL;

-- Ali Enki (d4f28d24-04a7-57fd-bdb4-96e9541efe95) -> DOB: '2011-01-01' (Source: Children’s Day Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95' AND dob IS NULL;

-- Ian Goh (d52d284f-c0d7-4a72-b86d-45c57b963c6c) -> DOB: '2009-01-01' (Source: 17th SAFYC Regatta 2021 (Optimist Gold); 18th SAFYC Regatta 2022 (Optimist Gold))
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'd52d284f-c0d7-4a72-b86d-45c57b963c6c' AND dob IS NULL;

-- Muhammad Iskandar Zulqarnain Bin Daniel Tay Abdullah (d5420b7d-7c56-5026-8bc1-c3c568b26bce) -> DOB: '2013-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'd5420b7d-7c56-5026-8bc1-c3c568b26bce' AND dob IS NULL;

-- Galaxy Wong (d66b6031-06a2-5d18-a360-56adb4a2ff81) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'd66b6031-06a2-5d18-a360-56adb4a2ff81' AND dob IS NULL;

-- Thit Bone Khant Nyar (d878c3d4-9655-5857-b7e6-d576942f4cb3) -> DOB: '2015-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver; ACDC Cup International Sailing Championship 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'd878c3d4-9655-5857-b7e6-d576942f4cb3' AND dob IS NULL;

-- Chanatip Tongglum (d9337400-b506-5662-9c3c-9c657c5c947b) -> DOB: '2008-01-01' (Source: 2023 Optimist Asian & Oceanian Championship (Optimist Overall); Trat Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'd9337400-b506-5662-9c3c-9c657c5c947b' AND dob IS NULL;

-- Supakan Kerdsakul (dbfe3720-bd69-5832-8ab6-4636b2cac830) -> DOB: '2007-01-01' (Source: Children’s Day Regatta 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2007-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'dbfe3720-bd69-5832-8ab6-4636b2cac830' AND dob IS NULL;

-- Khitsana Phetmak (dd386a5a-b2df-5bcb-8105-d4f4bcdb315b) -> DOB: '2012-01-01' (Source: Trat Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'dd386a5a-b2df-5bcb-8105-d4f4bcdb315b' AND dob IS NULL;

-- Suppakorn Chaisanam (dd826db3-dc59-5d54-af52-2dd38d5bb690) -> DOB: '2005-01-01' (Source: Thailand National Championship 2025 — Long Distance — ILCA 7)
UPDATE public.sailors
SET dob = '2005-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'dd826db3-dc59-5d54-af52-2dd38d5bb690' AND dob IS NULL;

-- Thanapat Siricharoen (de0550e0-b07f-5842-b791-00b8a2d9d4a1) -> DOB: '2006-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 6; Pattaya Regatta 2026 — ILCA 6)
UPDATE public.sailors
SET dob = '2006-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'de0550e0-b07f-5842-b791-00b8a2d9d4a1' AND dob IS NULL;

-- Ryan Lo Jun Han (df7c6bd6-12f7-412b-994a-f116e820e30d) -> DOB: '1997-01-01' (Source: 19th Asian Games Hangzhou 2022 (Men''s Dinghy - ILCA 7); 2024 National Slalom (WingFoil))
UPDATE public.sailors
SET dob = '1997-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' AND dob IS NULL;

-- Theo Remy Samane Maulave (dfea9eff-816e-5aaf-b38c-2223966d7a87) -> DOB: '2010-01-01' (Source: Trat Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'dfea9eff-816e-5aaf-b38c-2223966d7a87' AND dob IS NULL;

-- Neil Semple (e0305f5b-6b9e-5132-881d-420f1a7cc54c) -> DOB: '1961-01-01' (Source: ILCA District Championship 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1961-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e0305f5b-6b9e-5132-881d-420f1a7cc54c' AND dob IS NULL;

-- Nantiphat Kerdsakul (e0c694d1-6e8c-5fef-85b8-14263e35dc02) -> DOB: '2011-01-01' (Source: Children’s Day Regatta 2025 — Optimist Gold)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e0c694d1-6e8c-5fef-85b8-14263e35dc02' AND dob IS NULL;

-- Suwichada Ditkingsakearaj (e185b55c-0cb8-53fb-938c-0cecc7665701) -> DOB: '2013-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver; Trat Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e185b55c-0cb8-53fb-938c-0cecc7665701' AND dob IS NULL;

-- Kritsada Noisaeng (e19f47a5-41b4-55b2-801a-199795398f0f) -> DOB: '2013-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver; Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e19f47a5-41b4-55b2-801a-199795398f0f' AND dob IS NULL;

-- Yeji Lee (e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7) -> DOB: '2008-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7' AND dob IS NULL;

-- Xiaoxi Dong (e380242b-42e5-4e83-8b8d-06e1586d4e3b) -> DOB: '2016-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver; Singapore National Sailing Championships 2026 (Gold))
UPDATE public.sailors
SET dob = '2016-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e380242b-42e5-4e83-8b8d-06e1586d4e3b' AND dob IS NULL;

-- Robert Kochetovskiy (e58690e7-073b-5573-b2ae-f4ce1be100d9) -> DOB: '2009-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e58690e7-073b-5573-b2ae-f4ce1be100d9' AND dob IS NULL;

-- Kankao Peungchimplee (e5a2cd0f-d08b-5984-9b75-e19f4242e1ff) -> DOB: '2011-01-01' (Source: Trat Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e5a2cd0f-d08b-5984-9b75-e19f4242e1ff' AND dob IS NULL;

-- Pailin Wongsarapanchai (e6b88544-3b8f-57a1-8a74-6b56b95b3f9f) -> DOB: '2013-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Gold)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e6b88544-3b8f-57a1-8a74-6b56b95b3f9f' AND dob IS NULL;

-- Shota Sratongsang (e89161ab-34e7-5022-a08c-5b00bea6532b) -> DOB: '2010-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Gold; Children’s Day Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e89161ab-34e7-5022-a08c-5b00bea6532b' AND dob IS NULL;

-- Khairul Iman Bin Mohd Afendy (e8d57d7a-4bfb-451e-a661-11c8ecaf805d) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4; 22nd Langkawi International Regatta Perdana 2026 — Optimist Gold)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e8d57d7a-4bfb-451e-a661-11c8ecaf805d' AND dob IS NULL;

-- Phyu Cin Thadar (e9c8f1e1-acff-5660-ba36-6f75834f3421) -> DOB: '2014-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e9c8f1e1-acff-5660-ba36-6f75834f3421' AND dob IS NULL;

-- Vantanee Naiswasdi (ec218b8c-3eb8-5259-abe7-f0d5a6b5378d) -> DOB: '2014-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver; Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'ec218b8c-3eb8-5259-abe7-f0d5a6b5378d' AND dob IS NULL;

-- Zwel La Yaung (eccf0a0e-a600-599a-b300-79f74309a169) -> DOB: '2016-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET dob = '2016-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'eccf0a0e-a600-599a-b300-79f74309a169' AND dob IS NULL;

-- Pakwan Nirachatsuwan (eced49b4-094d-5264-8a99-443ccc1602d0) -> DOB: '2015-01-01' (Source: 2025 YRAT Cup Series 5 — Optimist Silver)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'eced49b4-094d-5264-8a99-443ccc1602d0' AND dob IS NULL;

-- Punnaphak Suppakritkanont (edb63198-25a9-5d1c-9d8d-fbec20b1533d) -> DOB: '2012-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Gold)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'edb63198-25a9-5d1c-9d8d-fbec20b1533d' AND dob IS NULL;

-- Phumsamut Watetakarn (ef51229e-76d0-5295-ab12-5b7250335f85) -> DOB: '2011-01-01' (Source: Children’s Day Regatta 2025 — ILCA 4; Trat Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'ef51229e-76d0-5295-ab12-5b7250335f85' AND dob IS NULL;

-- Benn Manomaiphan (f1087502-d280-5212-9309-aab1b554ad3f) -> DOB: '2015-01-01' (Source: ACDC Cup International Sailing Championship 2025 — Optimist Silver; Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'f1087502-d280-5212-9309-aab1b554ad3f' AND dob IS NULL;

-- Oonorn Visuttiprapanont (f248ce9b-7121-51a5-8831-8e0aaea4c830) -> DOB: '2010-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4; Children’s Day Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'f248ce9b-7121-51a5-8831-8e0aaea4c830' AND dob IS NULL;

-- Lavinia Liu (f26ce470-48a0-419e-967e-b1e936dad712) -> DOB: '2012-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; 2025 Musto Australian Optimist Championship — Optimist Silver)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'f26ce470-48a0-419e-967e-b1e936dad712' AND dob IS NULL;

-- Patcharapa Kamutatira (f5b54087-6410-5b40-8bd9-51308c69a391) -> DOB: '2015-01-01' (Source: Children’s Day Regatta 2025 — Optimist Green)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'f5b54087-6410-5b40-8bd9-51308c69a391' AND dob IS NULL;

-- Yufu Wang (f5f68b83-bb5b-4523-963f-3f367d5b4771) -> DOB: '2012-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Gold; 2025 Musto Australian Optimist Championship — Optimist Silver)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'f5f68b83-bb5b-4523-963f-3f367d5b4771' AND dob IS NULL;

-- Sheng He Jiang (f8f60bca-c6e1-5c1c-870a-50f06a57015d) -> DOB: '2013-01-01' (Source: 2025 Organic Garden International Optimist Victorian & Open Championship — Optimist Open; ACDC Cup International Sailing Championship 2025 — Optimist Gold)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'f8f60bca-c6e1-5c1c-870a-50f06a57015d' AND dob IS NULL;

-- Zac Littlewood (f9eac5fc-e4e6-5c17-b598-2a5321ba843d) -> DOB: '2001-01-01' (Source: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open; ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '2001-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'f9eac5fc-e4e6-5c17-b598-2a5321ba843d' AND dob IS NULL;

-- Wikki Bhanubandh (fc1cce04-098d-596c-84b4-a0e8d7df6be1) -> DOB: '1978-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '1978-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'fc1cce04-098d-596c-84b4-a0e8d7df6be1' AND dob IS NULL;

-- Sarah Seow Hui Yan (fc5e098b-be2e-4466-8b92-bada3a3479db) -> DOB: '2007-01-01' (Source: 18th SAFYC Regatta 2022 (ILCA 4); 19th SAFYC Regatta 2023 (ILCA 4))
UPDATE public.sailors
SET dob = '2007-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'fc5e098b-be2e-4466-8b92-bada3a3479db' AND dob IS NULL;

-- Ting-En Lin (fc743756-eaa4-5d96-9dc9-b9c22ffe845c) -> DOB: '2011-01-01' (Source: 18th Eastern Seaboard Regatta 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'fc743756-eaa4-5d96-9dc9-b9c22ffe845c' AND dob IS NULL;

-- Yunki Oh (fcd04292-61ab-57c7-95ff-42dc151c5854) -> DOB: '2007-01-01' (Source: ILCA Thailand National Championships 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '2007-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'fcd04292-61ab-57c7-95ff-42dc151c5854' AND dob IS NULL;

-- Chairat Dangdeemark (fce9b8f0-b102-5c86-9923-ecc223eb3eb8) -> DOB: '1985-01-01' (Source: Trat Regatta 2025 — ILCA 7)
UPDATE public.sailors
SET dob = '1985-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'fce9b8f0-b102-5c86-9923-ecc223eb3eb8' AND dob IS NULL;

-- Iqbal Nazham Bin Musmuliadi (ffa6f01a-8891-4c9a-a169-33a1008ecd31) -> DOB: '2008-01-01' (Source: 2024 ILCA Asian Open Championship (ILCA 4 Youth Boys U18); ILCA Thailand National Championships 2025 — ILCA 4)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' AND dob IS NULL;

-- ============================================================================
-- 3. KEEP-SEPARATE REGISTRATION & AUDIT LOG
-- ============================================================================

-- Register keep-separate pair for Yong Ai Chuang / Yong Ray Chuang
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '9e435ef8-0d1f-5789-bd82-eab75023cf9d',
  'Yong Ai Chuang / Yong Ray Chuang',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'aId', '9e435ef8-0d1f-5789-bd82-eab75023cf9d',
    'aName', 'Yong Ai Chuang',
    'bId', '6b018765-b6a9-5682-ada3-f3002829594e',
    'bName', 'Yong Ray Chuang',
    'pairKey', '9e435ef8-0d1f-5789-bd82-eab75023cf9d|6b018765-b6a9-5682-ada3-f3002829594e',
    'reason', 'Distinct athletes: Yong Ai Chuang is female, born 2015; Yong Ray Chuang is male, born 2011 (brother and sister competing under Royal Varuna Yacht Club / TPE).'
  ),
  'migration_166',
  clock_timestamp()
);

-- Log overall demographic enrichment
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.demographics_enrichment',
  'sailor',
  '00000000-0000-0000-0000-000000000000',
  'Demographic Enrichment — Batch 166',
  'Enriched gender for 68 active sailors and date of birth for 193 active sailors from verified official championship results; registered keep-separate decision for Yong Ai Chuang / Yong Ray Chuang.',
  jsonb_build_object(
    'genders_updated', 68,
    'dobs_updated', 193,
    'total_unique_sailors', 255
  ),
  'migration_166',
  clock_timestamp()
);

COMMIT;
