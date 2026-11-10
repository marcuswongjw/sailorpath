-- Migration 184: Google-Researched Sailor Enrichments, Sail Number '0' Backfills, Gender Normalization, and Verified Olympian Portraits
--
-- 1. Normalizes legacy 'W' -> 'F' and 'Unknown' -> NULL genders across all sailors.
-- 2. Backfills 80 sail numbers currently set to '0' with official entry_sail_number values.
-- 3. Enriches 1 nationality, 12 genders, 29 DOBs, 37 clubs, and 33 schools from Google Search & Olympic/Federation records.
-- 4. Attaches 18 verified official Olympic athlete portraits and clears Victoria Chan's unverified placeholder.

BEGIN;

-- ============================================================================
-- 1. GENDER NORMALIZATION ('W' -> 'F', 'Unknown' -> NULL)
-- ============================================================================
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE gender = 'W';
UPDATE public.sailors SET gender = NULL, updated_at = clock_timestamp() WHERE gender = 'Unknown';

-- ============================================================================
-- 2. SAIL NUMBER '0' BACKFILLS (80 SAILORS)
-- ============================================================================
-- Nicholas Cooper (63cff499-1b7e-4eea-9311-163e9716097b) -> Sail #225577 (from 2026 Zhik Youth Sail Western Australia — ILCA 4, 2026-09-26)
UPDATE public.sailors
SET sail_number = '225577', sail_number_ilca4 = COALESCE(sail_number_ilca4, '225577'), updated_at = clock_timestamp()
WHERE id = '63cff499-1b7e-4eea-9311-163e9716097b' AND sail_number = '0';

-- Cheung Shou Jeng Declan (13f6c6f4-e730-43ff-b42a-1d957daab9dc) -> Sail #214728 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = '214728', sail_number_ilca4 = COALESCE(sail_number_ilca4, '214728'), updated_at = clock_timestamp()
WHERE id = '13f6c6f4-e730-43ff-b42a-1d957daab9dc' AND sail_number = '0';

-- Khun Tun Oo (378474e8-cb1e-4163-96b9-e88857ea86d3) -> Sail #MYA 218749 (from 33rd SEA Games 2025 — Sailing — ILCA 4 Boys, 2025-12-09)
UPDATE public.sailors
SET sail_number = 'MYA 218749', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'MYA 218749'), updated_at = clock_timestamp()
WHERE id = '378474e8-cb1e-4163-96b9-e88857ea86d3' AND sail_number = '0';

-- Conrad Loh Yong (ed139811-7d1e-41c7-8b24-b069c80d0db4) -> Sail #4536 (from CSC Optimist Championships 2022 (Optimist Silver), 2022-12-07)
UPDATE public.sailors
SET sail_number = '4536', updated_at = clock_timestamp()
WHERE id = 'ed139811-7d1e-41c7-8b24-b069c80d0db4' AND sail_number = '0';

-- Dani Pieter Mahmoud van Olphen (1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d) -> Sail #213234 (from Hong Kong Race Week 2026 (ILCA 4), 2026-01-27)
UPDATE public.sailors
SET sail_number = '213234', sail_number_ilca4 = COALESCE(sail_number_ilca4, '213234'), updated_at = clock_timestamp()
WHERE id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d' AND sail_number = '0';

-- Ang Zhi Shan Jewel (aec8aceb-bcec-4e63-a653-e9d2ea620edf) -> Sail #193911 (from 46th Singapore ILCA Open 2023 (ILCA 4), 2023-12-02)
UPDATE public.sailors
SET sail_number = '193911', sail_number_ilca4 = COALESCE(sail_number_ilca4, '193911'), updated_at = clock_timestamp()
WHERE id = 'aec8aceb-bcec-4e63-a653-e9d2ea620edf' AND sail_number = '0';

-- Nicole Ng Hui Hong (0701bebf-cbd2-4bb7-9d1b-34f48fad4f86) -> Sail #3446 (from 18th SAFYC Regatta 2022 (Optimist Gold), 2022-04-09)
UPDATE public.sailors
SET sail_number = '3446', updated_at = clock_timestamp()
WHERE id = '0701bebf-cbd2-4bb7-9d1b-34f48fad4f86' AND sail_number = '0';

-- Kiitchakhun Somkhanngoen (90a471f5-bd58-400f-a995-e115951ee1ed) -> Sail #225917 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = '225917', sail_number_ilca4 = COALESCE(sail_number_ilca4, '225917'), updated_at = clock_timestamp()
WHERE id = '90a471f5-bd58-400f-a995-e115951ee1ed' AND sail_number = '0';

-- Ashira Phangrak (9fcccf71-f1d8-4f83-818b-bc2eb6422676) -> Sail #218744 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = '218744', sail_number_ilca4 = COALESCE(sail_number_ilca4, '218744'), updated_at = clock_timestamp()
WHERE id = '9fcccf71-f1d8-4f83-818b-bc2eb6422676' AND sail_number = '0';

-- Thitiworada Johnjaitrong (87248310-cc92-4094-accd-afe96addeeef) -> Sail #222685 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = '222685', sail_number_ilca4 = COALESCE(sail_number_ilca4, '222685'), updated_at = clock_timestamp()
WHERE id = '87248310-cc92-4094-accd-afe96addeeef' AND sail_number = '0';

-- Suwaphak Plumjit (a5a0ff6f-0576-4a4c-b583-149f6f6d7304) -> Sail #THA222589 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = 'THA222589', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA222589'), updated_at = clock_timestamp()
WHERE id = 'a5a0ff6f-0576-4a4c-b583-149f6f6d7304' AND sail_number = '0';

-- Cleo Seah En Rui (bee71ffd-0b62-4fda-af0a-5b931c110e57) -> Sail #224379 (from Singapore Youth Sailing Championships 2025 (ILCA 4), 2025-03-15)
UPDATE public.sailors
SET sail_number = '224379', sail_number_ilca4 = COALESCE(sail_number_ilca4, '224379'), updated_at = clock_timestamp()
WHERE id = 'bee71ffd-0b62-4fda-af0a-5b931c110e57' AND sail_number = '0';

-- Nina Wang (0b42963a-efa1-4010-9029-b50953b6f1fb) -> Sail #CHN 221551 (from ILCA District Championship 2025 — ILCA 4, 2025-10-31)
UPDATE public.sailors
SET sail_number = 'CHN 221551', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'CHN 221551'), updated_at = clock_timestamp()
WHERE id = '0b42963a-efa1-4010-9029-b50953b6f1fb' AND sail_number = '0';

-- Tim Ambos (984e9f9f-59dc-456c-85d0-64a6f12f8143) -> Sail #GER 222938 (from 2026 ILCA 4 Youth World Championships (Boys), 2026-08-03)
UPDATE public.sailors
SET sail_number = 'GER 222938', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'GER 222938'), updated_at = clock_timestamp()
WHERE id = '984e9f9f-59dc-456c-85d0-64a6f12f8143' AND sail_number = '0';

-- Aidan Ang (15b0cffc-69a1-4ee5-956b-f2d0b859acf2) -> Sail #SGP209051 (from 46th Singapore ILCA Open 2023 (ILCA 6), 2023-12-02)
UPDATE public.sailors
SET sail_number = 'SGP209051', updated_at = clock_timestamp()
WHERE id = '15b0cffc-69a1-4ee5-956b-f2d0b859acf2' AND sail_number = '0';

-- Meghan Tan (53d87092-1fc5-4f0b-94fa-39b2dc9f981f) -> Sail #205778 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = '205778', sail_number_ilca4 = COALESCE(sail_number_ilca4, '205778'), updated_at = clock_timestamp()
WHERE id = '53d87092-1fc5-4f0b-94fa-39b2dc9f981f' AND sail_number = '0';

-- Carlstein Jade Dulay (243ed8f1-783f-4c3c-b69c-5a39442342ab) -> Sail #PHI 03 (from 33rd SEA Games 2025 — Sailing — Optimist Boys, 2025-12-09)
UPDATE public.sailors
SET sail_number = 'PHI 03', updated_at = clock_timestamp()
WHERE id = '243ed8f1-783f-4c3c-b69c-5a39442342ab' AND sail_number = '0';

-- Oon Cheaung Qi (86094beb-e0db-4194-8bd5-ffd9d6946fcb) -> Sail #41 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = '41', sail_number_ilca4 = COALESCE(sail_number_ilca4, '41'), updated_at = clock_timestamp()
WHERE id = '86094beb-e0db-4194-8bd5-ffd9d6946fcb' AND sail_number = '0';

-- Mahi Verma (448629c9-4150-4b57-a991-2721ad070d18) -> Sail #IND 228703 (from 2026 ILCA 4 Youth World Championships (Girls), 2026-08-03)
UPDATE public.sailors
SET sail_number = 'IND 228703', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'IND 228703'), updated_at = clock_timestamp()
WHERE id = '448629c9-4150-4b57-a991-2721ad070d18' AND sail_number = '0';

-- Tulsi Patle (c3964c71-ae91-4215-91e4-f035597ccf14) -> Sail #226794 (from Singapore Youth Sailing Championships 2026 (ILCA 4), 2026-03-14)
UPDATE public.sailors
SET sail_number = '226794', sail_number_ilca4 = COALESCE(sail_number_ilca4, '226794'), updated_at = clock_timestamp()
WHERE id = 'c3964c71-ae91-4215-91e4-f035597ccf14' AND sail_number = '0';

-- Jolin Zheng (018b6ed4-9636-47e1-8d40-aa5e21a22f32) -> Sail #209319 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = '209319', sail_number_ilca4 = COALESCE(sail_number_ilca4, '209319'), updated_at = clock_timestamp()
WHERE id = '018b6ed4-9636-47e1-8d40-aa5e21a22f32' AND sail_number = '0';

-- Zildjan Martin Samson (350e86ba-c58a-4a8a-a276-ee4b93eb84da) -> Sail #225455 (from 2026 ILCA Asian Cup (ILCA 4), 2026-03-19)
UPDATE public.sailors
SET sail_number = '225455', sail_number_ilca4 = COALESCE(sail_number_ilca4, '225455'), updated_at = clock_timestamp()
WHERE id = '350e86ba-c58a-4a8a-a276-ee4b93eb84da' AND sail_number = '0';

-- Pacharapol Rumvisai (8663b84c-2a24-4fc7-ab61-6598b3ff1fa3) -> Sail #7 (from EGAT and YRAT Regatta 2026 — ILCA 4, 2026-07-04)
UPDATE public.sailors
SET sail_number = '7', sail_number_ilca4 = COALESCE(sail_number_ilca4, '7'), updated_at = clock_timestamp()
WHERE id = '8663b84c-2a24-4fc7-ab61-6598b3ff1fa3' AND sail_number = '0';

-- Wong Tsz Lung (721432e7-e9dd-4606-bc9e-6db6390b2d3c) -> Sail #211703 (from Singapore Youth Sailing Championships 2025 (ILCA 4), 2025-03-15)
UPDATE public.sailors
SET sail_number = '211703', sail_number_ilca4 = COALESCE(sail_number_ilca4, '211703'), updated_at = clock_timestamp()
WHERE id = '721432e7-e9dd-4606-bc9e-6db6390b2d3c' AND sail_number = '0';

-- Shagun Jha (ff26b05c-8ff8-4175-83cb-82cce1817d7c) -> Sail #222267 (from Singapore Youth Sailing Championships 2025 (ILCA 4), 2025-03-15)
UPDATE public.sailors
SET sail_number = '222267', sail_number_ilca4 = COALESCE(sail_number_ilca4, '222267'), updated_at = clock_timestamp()
WHERE id = 'ff26b05c-8ff8-4175-83cb-82cce1817d7c' AND sail_number = '0';

-- Ethan Kiu (abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6) -> Sail #3354 (from Hong Kong Race Week 2026 — 29er Asian Championship, 2026-02-01)
UPDATE public.sailors
SET sail_number = '3354', updated_at = clock_timestamp()
WHERE id = 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6' AND sail_number = '0';

-- Joshua Dale (b6eb51a6-5190-41d7-a8c5-be1f4817428d) -> Sail #226523 (from 2026 Zhik Youth Sail Queensland — ILCA 4, 2026-09-21)
UPDATE public.sailors
SET sail_number = '226523', sail_number_ilca4 = COALESCE(sail_number_ilca4, '226523'), updated_at = clock_timestamp()
WHERE id = 'b6eb51a6-5190-41d7-a8c5-be1f4817428d' AND sail_number = '0';

-- Seb Tucker (a8621760-ffb6-4283-8e2e-12bb7890d8a4) -> Sail #1771 (from 2026 ACT Optimist Championship — Open Fleet, 2026-10-24)
UPDATE public.sailors
SET sail_number = '1771', updated_at = clock_timestamp()
WHERE id = 'a8621760-ffb6-4283-8e2e-12bb7890d8a4' AND sail_number = '0';

-- Katyayani Kaushik (780fb3f3-c6a4-4a85-b95f-488dd01758db) -> Sail #211801 (from Singapore Youth Sailing Championships 2026 (ILCA 4), 2026-03-14)
UPDATE public.sailors
SET sail_number = '211801', sail_number_ilca4 = COALESCE(sail_number_ilca4, '211801'), updated_at = clock_timestamp()
WHERE id = '780fb3f3-c6a4-4a85-b95f-488dd01758db' AND sail_number = '0';

-- Thanaporn Phokaew (55b6a2bc-3e2e-4ec6-adb3-4e849d8c8380) -> Sail #THA 225426 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = 'THA 225426', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA 225426'), updated_at = clock_timestamp()
WHERE id = '55b6a2bc-3e2e-4ec6-adb3-4e849d8c8380' AND sail_number = '0';

-- Zihan Liu (3ecd12a0-9c8f-42e7-adfe-1094e760c0b3) -> Sail #HKG 161 (from 2024 Optimist Asian & Oceanian Championship (Optimist Overall), 2024-12-29)
UPDATE public.sailors
SET sail_number = 'HKG 161', updated_at = clock_timestamp()
WHERE id = '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3' AND sail_number = '0';

-- Chloe Kong (6591a20e-7f52-4b81-b6cf-2b450a6410b5) -> Sail #3355 (from Hong Kong Race Week 2026 — 29er Asian Championship, 2026-02-01)
UPDATE public.sailors
SET sail_number = '3355', updated_at = clock_timestamp()
WHERE id = '6591a20e-7f52-4b81-b6cf-2b450a6410b5' AND sail_number = '0';

-- Pinchanok Klaysomboon (2746f84b-a6bf-40cb-b95d-1beb6652f8e6) -> Sail #225985 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = '225985', sail_number_ilca4 = COALESCE(sail_number_ilca4, '225985'), updated_at = clock_timestamp()
WHERE id = '2746f84b-a6bf-40cb-b95d-1beb6652f8e6' AND sail_number = '0';

-- Karit Phrammanee (8263464a-01a9-4e55-b8f1-46d96d0173c4) -> Sail #THA 178105 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = 'THA 178105', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA 178105'), updated_at = clock_timestamp()
WHERE id = '8263464a-01a9-4e55-b8f1-46d96d0173c4' AND sail_number = '0';

-- Eklavya Batham (a455659e-591a-4932-8a2b-61f559a45a96) -> Sail #222317 (from Singapore Youth Sailing Championships 2025 (ILCA 4), 2025-03-15)
UPDATE public.sailors
SET sail_number = '222317', sail_number_ilca4 = COALESCE(sail_number_ilca4, '222317'), updated_at = clock_timestamp()
WHERE id = 'a455659e-591a-4932-8a2b-61f559a45a96' AND sail_number = '0';

-- Ajay Gajji (4dbef3ea-81af-429e-9231-615cd1193d1c) -> Sail #211783 (from Singapore Youth Sailing Championships 2025 (ILCA 4), 2025-03-15)
UPDATE public.sailors
SET sail_number = '211783', sail_number_ilca4 = COALESCE(sail_number_ilca4, '211783'), updated_at = clock_timestamp()
WHERE id = '4dbef3ea-81af-429e-9231-615cd1193d1c' AND sail_number = '0';

-- Gan Ha Joon (4c2bb410-36c0-4c67-8211-49ed5e3c1b7c) -> Sail #4420 (from 18th SAFYC Regatta 2022 (Optimist Silver), 2022-04-09)
UPDATE public.sailors
SET sail_number = '4420', updated_at = clock_timestamp()
WHERE id = '4c2bb410-36c0-4c67-8211-49ed5e3c1b7c' AND sail_number = '0';

-- Jonathan Ho Jian Yi (dd2d0d83-4cb8-4ea5-bc90-59531d262be2) -> Sail #214848 (from Singapore Youth Sailing Championships 2025 (ILCA 4), 2025-03-15)
UPDATE public.sailors
SET sail_number = '214848', sail_number_ilca4 = COALESCE(sail_number_ilca4, '214848'), updated_at = clock_timestamp()
WHERE id = 'dd2d0d83-4cb8-4ea5-bc90-59531d262be2' AND sail_number = '0';

-- Iqbal Nazham Bin Musmuliadi (ffa6f01a-8891-4c9a-a169-33a1008ecd31) -> Sail #209875 (from Singapore Youth Sailing Championships 2025 (ILCA 4), 2025-03-15)
UPDATE public.sailors
SET sail_number = '209875', sail_number_ilca4 = COALESCE(sail_number_ilca4, '209875'), updated_at = clock_timestamp()
WHERE id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' AND sail_number = '0';

-- Sharanya Yuvaraj Jadhav (81b1a95a-45c8-4299-a05d-7aeddd0ca6c2) -> Sail #222622 (from Singapore Youth Sailing Championships 2025 (ILCA 4), 2025-03-15)
UPDATE public.sailors
SET sail_number = '222622', sail_number_ilca4 = COALESCE(sail_number_ilca4, '222622'), updated_at = clock_timestamp()
WHERE id = '81b1a95a-45c8-4299-a05d-7aeddd0ca6c2' AND sail_number = '0';

-- George Pilkington (0128db78-9ac9-4f9a-9c42-5db398ec5415) -> Sail #216151 (from 2026 Zhik Youth Sail Tasmania — ILCA 4, 2026-03-07)
UPDATE public.sailors
SET sail_number = '216151', sail_number_ilca4 = COALESCE(sail_number_ilca4, '216151'), updated_at = clock_timestamp()
WHERE id = '0128db78-9ac9-4f9a-9c42-5db398ec5415' AND sail_number = '0';

-- Charlie Cheung (45afcc54-b554-4f74-b9c3-f25a38f9c392) -> Sail #213357 (from Hong Kong Race Week 2026 (ILCA 4), 2026-01-27)
UPDATE public.sailors
SET sail_number = '213357', sail_number_ilca4 = COALESCE(sail_number_ilca4, '213357'), updated_at = clock_timestamp()
WHERE id = '45afcc54-b554-4f74-b9c3-f25a38f9c392' AND sail_number = '0';

-- Eunice Tan Yi Ning (d7452539-48a3-4903-8a1d-f031ebe2a5e6) -> Sail #224664 (from Singapore Youth Sailing Championships 2025 (ILCA 4), 2025-03-15)
UPDATE public.sailors
SET sail_number = '224664', sail_number_ilca4 = COALESCE(sail_number_ilca4, '224664'), updated_at = clock_timestamp()
WHERE id = 'd7452539-48a3-4903-8a1d-f031ebe2a5e6' AND sail_number = '0';

-- Jayden Khor Xin Jie (1bfbc092-0325-4e8f-aa32-0eeeded7a7ae) -> Sail #SGP 203110 (from 46th Singapore ILCA Open 2023 (ILCA 4), 2023-12-02)
UPDATE public.sailors
SET sail_number = 'SGP 203110', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'SGP 203110'), updated_at = clock_timestamp()
WHERE id = '1bfbc092-0325-4e8f-aa32-0eeeded7a7ae' AND sail_number = '0';

-- Ruiqiao Bu (75f10506-9163-486d-858a-27730adc0d47) -> Sail #98 (from Singapore Youth Sailing Championships 2026 (ILCA 4), 2026-03-14)
UPDATE public.sailors
SET sail_number = '98', sail_number_ilca4 = COALESCE(sail_number_ilca4, '98'), updated_at = clock_timestamp()
WHERE id = '75f10506-9163-486d-858a-27730adc0d47' AND sail_number = '0';

-- Seth Low Yu Herng (1fffd15a-65eb-4fd7-86af-d0f99cbcf2fa) -> Sail #4643 (from CSC Optimist Championships 2019 (Optimist Gold), 2019-12-10)
UPDATE public.sailors
SET sail_number = '4643', updated_at = clock_timestamp()
WHERE id = '1fffd15a-65eb-4fd7-86af-d0f99cbcf2fa' AND sail_number = '0';

-- Ikuto Mori (61334a08-e796-43d7-aeb8-ac70f6bf6f30) -> Sail #JPN 221687 (from ILCA District Championship 2025 — ILCA 4, 2025-10-31)
UPDATE public.sailors
SET sail_number = 'JPN 221687', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'JPN 221687'), updated_at = clock_timestamp()
WHERE id = '61334a08-e796-43d7-aeb8-ac70f6bf6f30' AND sail_number = '0';

-- Ramakant Ramakant (85972df9-0595-4195-b72b-09706875ffa0) -> Sail #221143 (from Singapore Youth Sailing Championships 2025 (ILCA 6), 2025-03-15)
UPDATE public.sailors
SET sail_number = '221143', updated_at = clock_timestamp()
WHERE id = '85972df9-0595-4195-b72b-09706875ffa0' AND sail_number = '0';

-- Brendan Bock (16163225-f84a-4b68-8836-e15d3abfcf28) -> Sail #SGP 3257 (from Raffles Marina Optimist Regatta 2023 (Optimist Gold), 2023-05-27)
UPDATE public.sailors
SET sail_number = 'SGP 3257', updated_at = clock_timestamp()
WHERE id = '16163225-f84a-4b68-8836-e15d3abfcf28' AND sail_number = '0';

-- Sarah Yong (82ab4ba4-a693-4e7d-a9c5-6531752cea6e) -> Sail #214438 (from Singapore Youth Sailing Championships 2025 (ILCA 4), 2025-03-15)
UPDATE public.sailors
SET sail_number = '214438', sail_number_ilca4 = COALESCE(sail_number_ilca4, '214438'), updated_at = clock_timestamp()
WHERE id = '82ab4ba4-a693-4e7d-a9c5-6531752cea6e' AND sail_number = '0';

-- Samuel Tan-Hardy (f7c2cdc3-b794-4d79-9ed1-fa6262298665) -> Sail #221934 (from Hong Kong Race Week 2026 (ILCA 6), 2026-02-01)
UPDATE public.sailors
SET sail_number = '221934', updated_at = clock_timestamp()
WHERE id = 'f7c2cdc3-b794-4d79-9ed1-fa6262298665' AND sail_number = '0';

-- Chow Yi Jun, Ian (5f93827a-355d-4512-b132-acd84d578fe6) -> Sail #SGP203535 (from 46th Singapore ILCA Open 2023 (ILCA 6), 2023-12-02)
UPDATE public.sailors
SET sail_number = 'SGP203535', updated_at = clock_timestamp()
WHERE id = '5f93827a-355d-4512-b132-acd84d578fe6' AND sail_number = '0';

-- James Sullivan (5bda2468-4e6b-407f-81ce-d293659c0a26) -> Sail #221628 (from 46th Singapore ILCA Open 2023 (ILCA 7), 2023-12-02)
UPDATE public.sailors
SET sail_number = '221628', updated_at = clock_timestamp()
WHERE id = '5bda2468-4e6b-407f-81ce-d293659c0a26' AND sail_number = '0';

-- Khoo Zi Jay, Jethro (65e1fe8b-81bf-4a78-af55-9f9a241c0eb5) -> Sail #3284 (from CSC Optimist Championships 2022 (Optimist Gold), 2022-12-13)
UPDATE public.sailors
SET sail_number = '3284', updated_at = clock_timestamp()
WHERE id = '65e1fe8b-81bf-4a78-af55-9f9a241c0eb5' AND sail_number = '0';

-- Wong Weikai Zachary (ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a) -> Sail #229276 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = '229276', sail_number_ilca4 = COALESCE(sail_number_ilca4, '229276'), updated_at = clock_timestamp()
WHERE id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a' AND sail_number = '0';

-- Lo Jin Keith (d80da417-a89f-4cfb-8be0-be4fc5abc8c1) -> Sail #21484 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = '21484', sail_number_ilca4 = COALESCE(sail_number_ilca4, '21484'), updated_at = clock_timestamp()
WHERE id = 'd80da417-a89f-4cfb-8be0-be4fc5abc8c1' AND sail_number = '0';

-- Jonathan Zeppezauer (fb44dcf5-6915-4334-9904-5259ed064710) -> Sail #215308 (from Hong Kong Race Week 2026 (ILCA 4), 2026-01-27)
UPDATE public.sailors
SET sail_number = '215308', sail_number_ilca4 = COALESCE(sail_number_ilca4, '215308'), updated_at = clock_timestamp()
WHERE id = 'fb44dcf5-6915-4334-9904-5259ed064710' AND sail_number = '0';

-- Ou Xin Ying (1e7ec0fd-1ec7-4e83-bbcd-0ada192b7e1f) -> Sail #214760 (from 46th Singapore ILCA Open 2023 (ILCA 6), 2023-12-02)
UPDATE public.sailors
SET sail_number = '214760', updated_at = clock_timestamp()
WHERE id = '1e7ec0fd-1ec7-4e83-bbcd-0ada192b7e1f' AND sail_number = '0';

-- Jiale Yang (cd54414f-3108-4f1f-87c7-45b12ba3b4d9) -> Sail #220808 (from Hong Kong Race Week 2025 (ILCA 4), 2025-02-11)
UPDATE public.sailors
SET sail_number = '220808', sail_number_ilca4 = COALESCE(sail_number_ilca4, '220808'), updated_at = clock_timestamp()
WHERE id = 'cd54414f-3108-4f1f-87c7-45b12ba3b4d9' AND sail_number = '0';

-- Ruben Steel (59556a86-6d0f-4500-8a46-4ab111fe1479) -> Sail #224757 (from 2026 Zhik Youth Sail New South Wales — ILCA 4, 2026-09-30)
UPDATE public.sailors
SET sail_number = '224757', sail_number_ilca4 = COALESCE(sail_number_ilca4, '224757'), updated_at = clock_timestamp()
WHERE id = '59556a86-6d0f-4500-8a46-4ab111fe1479' AND sail_number = '0';

-- Natthapong Neelasavee (39f63d3e-5e9b-4643-9261-bccc97cfd343) -> Sail #THA215071 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = 'THA215071', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA215071'), updated_at = clock_timestamp()
WHERE id = '39f63d3e-5e9b-4643-9261-bccc97cfd343' AND sail_number = '0';

-- Prapada Peeranantapanya (f90c9f74-fc6a-4ac4-a2ce-74a584e36038) -> Sail #THA223567 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = 'THA223567', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA223567'), updated_at = clock_timestamp()
WHERE id = 'f90c9f74-fc6a-4ac4-a2ce-74a584e36038' AND sail_number = '0';

-- Aktanon Jongjukaphan (fda6a9f7-be61-4f3b-8f64-7f29c75592c1) -> Sail #222687 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = '222687', sail_number_ilca4 = COALESCE(sail_number_ilca4, '222687'), updated_at = clock_timestamp()
WHERE id = 'fda6a9f7-be61-4f3b-8f64-7f29c75592c1' AND sail_number = '0';

-- Natnathee Peepanich (f0755dca-49d2-415e-8623-12ff3291b73f) -> Sail #THA11 (from 18th Eastern Seaboard Regatta 2026 — Optimist Silver, 2026-10-28)
UPDATE public.sailors
SET sail_number = 'THA11', updated_at = clock_timestamp()
WHERE id = 'f0755dca-49d2-415e-8623-12ff3291b73f' AND sail_number = '0';

-- Sarutiya Rattanadechakorn (a080465e-2c15-42a8-b8e4-ee24afb5fe74) -> Sail #22268 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = '22268', sail_number_ilca4 = COALESCE(sail_number_ilca4, '22268'), updated_at = clock_timestamp()
WHERE id = 'a080465e-2c15-42a8-b8e4-ee24afb5fe74' AND sail_number = '0';

-- Hussaluk Srinakorn (d73dd129-1d4d-4229-b0fc-3e7e67007681) -> Sail #225982 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = '225982', sail_number_ilca4 = COALESCE(sail_number_ilca4, '225982'), updated_at = clock_timestamp()
WHERE id = 'd73dd129-1d4d-4229-b0fc-3e7e67007681' AND sail_number = '0';

-- Preet Siwal (d41014b8-67ad-4e56-9e87-55d51612d5a8) -> Sail #211778 (from Singapore Youth Sailing Championships 2026 (ILCA 4), 2026-03-14)
UPDATE public.sailors
SET sail_number = '211778', sail_number_ilca4 = COALESCE(sail_number_ilca4, '211778'), updated_at = clock_timestamp()
WHERE id = 'd41014b8-67ad-4e56-9e87-55d51612d5a8' AND sail_number = '0';

-- Darwin Hsu (735e74cd-7ea1-473f-bd4f-c181e97fa781) -> Sail #THA 0 (from Thailand National Sailing Championship 2026 - 3rd Event — ILCA 6, 2026-05-08)
UPDATE public.sailors
SET sail_number = 'THA 0', updated_at = clock_timestamp()
WHERE id = '735e74cd-7ea1-473f-bd4f-c181e97fa781' AND sail_number = '0';

-- Darius Low Xian Rui (8ec46c01-1663-4341-9c77-40da9edfe4ce) -> Sail #SGP 8 (from ILCA District Championship 2025 — ILCA 6, 2025-10-31)
UPDATE public.sailors
SET sail_number = 'SGP 8', updated_at = clock_timestamp()
WHERE id = '8ec46c01-1663-4341-9c77-40da9edfe4ce' AND sail_number = '0';

-- Ankit Singh Sisodiya (fb2cf4bb-32bc-4e9e-a043-0487c30db99a) -> Sail #225477 (from Singapore Youth Sailing Championships 2026 (ILCA 4), 2026-03-14)
UPDATE public.sailors
SET sail_number = '225477', sail_number_ilca4 = COALESCE(sail_number_ilca4, '225477'), updated_at = clock_timestamp()
WHERE id = 'fb2cf4bb-32bc-4e9e-a043-0487c30db99a' AND sail_number = '0';

-- Shubham Yadav (dde1d11b-b8e9-410f-94c7-1daee5ecdd4e) -> Sail #IND 210439 (from 2026 ILCA 4 Youth World Championships (Boys), 2026-08-03)
UPDATE public.sailors
SET sail_number = 'IND 210439', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'IND 210439'), updated_at = clock_timestamp()
WHERE id = 'dde1d11b-b8e9-410f-94c7-1daee5ecdd4e' AND sail_number = '0';

-- Ruoqi Zhang (50b3e0fd-0917-4cf1-b223-34ee0dcf9574) -> Sail #211672 (from Singapore Youth Sailing Championships 2026 (ILCA 4), 2026-03-14)
UPDATE public.sailors
SET sail_number = '211672', sail_number_ilca4 = COALESCE(sail_number_ilca4, '211672'), updated_at = clock_timestamp()
WHERE id = '50b3e0fd-0917-4cf1-b223-34ee0dcf9574' AND sail_number = '0';

-- Wanjia He (d62589f0-8e56-49df-9295-428a064c02ea) -> Sail #211751 (from Singapore Youth Sailing Championships 2026 (ILCA 4), 2026-03-14)
UPDATE public.sailors
SET sail_number = '211751', sail_number_ilca4 = COALESCE(sail_number_ilca4, '211751'), updated_at = clock_timestamp()
WHERE id = 'd62589f0-8e56-49df-9295-428a064c02ea' AND sail_number = '0';

-- Daqi He (35164380-d568-477e-a007-5d48b1130855) -> Sail #211682 (from Singapore Youth Sailing Championships 2026 (ILCA 4), 2026-03-14)
UPDATE public.sailors
SET sail_number = '211682', sail_number_ilca4 = COALESCE(sail_number_ilca4, '211682'), updated_at = clock_timestamp()
WHERE id = '35164380-d568-477e-a007-5d48b1130855' AND sail_number = '0';

-- Prin Subying (4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8) -> Sail #THA 222687 (from 33rd SEA Games 2025 — Sailing — ILCA 4 Girls, 2025-12-09)
UPDATE public.sailors
SET sail_number = 'THA 222687', sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA 222687'), updated_at = clock_timestamp()
WHERE id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8' AND sail_number = '0';

-- Huanran Zheng (87cc8912-d304-407f-934f-5cadd7a4921e) -> Sail #209319 (from 2026 ILCA Asian Cup (ILCA 4), 2026-03-19)
UPDATE public.sailors
SET sail_number = '209319', sail_number_ilca4 = COALESCE(sail_number_ilca4, '209319'), updated_at = clock_timestamp()
WHERE id = '87cc8912-d304-407f-934f-5cadd7a4921e' AND sail_number = '0';

-- Lau Yhi Sun (7f956a1d-8b92-494d-968e-ae66577d4e9d) -> Sail #3456 (from CSC Optimist Championships 2022 (Optimist Gold), 2022-12-13)
UPDATE public.sailors
SET sail_number = '3456', updated_at = clock_timestamp()
WHERE id = '7f956a1d-8b92-494d-968e-ae66577d4e9d' AND sail_number = '0';

-- Zack Vaikath (3f94c0a6-68b4-4174-be0e-6ea460c2aeab) -> Sail #38 (from CSC ILCA Monsoon Regatta 2023 (ILCA 4 — Day 1 only), 2023-02-18)
UPDATE public.sailors
SET sail_number = '38', sail_number_ilca4 = COALESCE(sail_number_ilca4, '38'), updated_at = clock_timestamp()
WHERE id = '3f94c0a6-68b4-4174-be0e-6ea460c2aeab' AND sail_number = '0';

-- Danielle Lai (a95b6b0a-6c38-40b6-a0bc-2dcaa9bcb9e2) -> Sail #222257 (from Singapore Youth Sailing Championships 2025 (ILCA 4), 2025-03-15)
UPDATE public.sailors
SET sail_number = '222257', sail_number_ilca4 = COALESCE(sail_number_ilca4, '222257'), updated_at = clock_timestamp()
WHERE id = 'a95b6b0a-6c38-40b6-a0bc-2dcaa9bcb9e2' AND sail_number = '0';

-- Ian Goh (d52d284f-c0d7-4a72-b86d-45c57b963c6c) -> Sail #222713 (from 20th Asian Games 2026 (ILCA 4), 2026-09-26)
UPDATE public.sailors
SET sail_number = '222713', sail_number_ilca4 = COALESCE(sail_number_ilca4, '222713'), updated_at = clock_timestamp()
WHERE id = 'd52d284f-c0d7-4a72-b86d-45c57b963c6c' AND sail_number = '0';

-- ============================================================================
-- 3. NATIONALITY ENRICHMENTS (1 SAILOR)
-- ============================================================================
-- Rob Carmichael (cf4da8f7-43df-56b6-a81c-ac839da9753b) -> THA (UWC Thailand / Phuket King's Cup ILCA 7)
UPDATE public.sailors SET nationality = 'THA', updated_at = clock_timestamp() WHERE id = 'cf4da8f7-43df-56b6-a81c-ac839da9753b' AND (nationality IS NULL OR nationality = '');

-- ============================================================================
-- 4. GENDER ENRICHMENTS (12 SAILORS)
-- ============================================================================
-- Charles Lim (91d872b9-db2a-4d54-a62b-16cd7852e967) -> 'M' (Singapore Sailing Olympian (SGP))
UPDATE public.sailors SET gender = 'M', updated_at = clock_timestamp() WHERE id = '91d872b9-db2a-4d54-a62b-16cd7852e967' AND (gender IS NULL OR gender = '');

-- Rob Carmichael (cf4da8f7-43df-56b6-a81c-ac839da9753b) -> 'M' (Phuket King's Cup ILCA 7 Men)
UPDATE public.sailors SET gender = 'M', updated_at = clock_timestamp() WHERE id = 'cf4da8f7-43df-56b6-a81c-ac839da9753b' AND (gender IS NULL OR gender = '');

-- William Lawson (2552c01d-6467-5dbf-b858-c798384746a4) -> 'M' (HHSC Australian Optimist Fleet)
UPDATE public.sailors SET gender = 'M', updated_at = clock_timestamp() WHERE id = '2552c01d-6467-5dbf-b858-c798384746a4' AND (gender IS NULL OR gender = '');

-- Tom Kefford (6bb33423-d331-5bde-9731-2e09ea2eba83) -> 'M' (CYC Australian Optimist Fleet)
UPDATE public.sailors SET gender = 'M', updated_at = clock_timestamp() WHERE id = '6bb33423-d331-5bde-9731-2e09ea2eba83' AND (gender IS NULL OR gender = '');

-- Edward Payne (045b2495-820a-5df1-b744-8439ea2e3d13) -> 'M' (HHSC Australian Optimist Fleet)
UPDATE public.sailors SET gender = 'M', updated_at = clock_timestamp() WHERE id = '045b2495-820a-5df1-b744-8439ea2e3d13' AND (gender IS NULL OR gender = '');

-- Sienna Murray (15b5c0ed-ac08-584c-874e-b7d9271dd53a) -> 'F' (RPAYC Australian Optimist Fleet)
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '15b5c0ed-ac08-584c-874e-b7d9271dd53a' AND (gender IS NULL OR gender = '');

-- Olivia Dorling (22670cfa-0e57-5cbd-b6b0-aef9a8d515e7) -> 'F' (RPAYC Australian Optimist Fleet)
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '22670cfa-0e57-5cbd-b6b0-aef9a8d515e7' AND (gender IS NULL OR gender = '');

-- Kar Lai Kelly Lam (3135e21d-91df-583d-827a-80d284221734) -> 'F' (HKSF Hong Kong Optimist Fleet)
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '3135e21d-91df-583d-827a-80d284221734' AND (gender IS NULL OR gender = '');

-- Ka Wai Chloe Wan (56404476-ad63-55b6-84ab-5605f806f80f) -> 'F' (HKSF Hong Kong Optimist Fleet)
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '56404476-ad63-55b6-84ab-5605f806f80f' AND (gender IS NULL OR gender = '');

-- Isaac Wang (4e4b62c0-cedc-56aa-af56-4319aa348f68) -> 'M' (ABC Hong Kong Optimist Fleet)
UPDATE public.sailors SET gender = 'M', updated_at = clock_timestamp() WHERE id = '4e4b62c0-cedc-56aa-af56-4319aa348f68' AND (gender IS NULL OR gender = '');

-- Xavier Lam (51deb95b-c78a-5286-b715-0cc47634fd81) -> 'M' (HHYC Hong Kong Optimist Fleet)
UPDATE public.sailors SET gender = 'M', updated_at = clock_timestamp() WHERE id = '51deb95b-c78a-5286-b715-0cc47634fd81' AND (gender IS NULL OR gender = '');

-- Oliver Korn (365765e9-9ea4-5de4-8228-00156c596e49) -> 'M' (GRSC Australian Optimist Fleet)
UPDATE public.sailors SET gender = 'M', updated_at = clock_timestamp() WHERE id = '365765e9-9ea4-5de4-8228-00156c596e49' AND (gender IS NULL OR gender = '');

-- ============================================================================
-- 5. DOB ENRICHMENTS (29 SAILORS)
-- ============================================================================
-- Matt Wearn (680d176e-85d5-54f6-b2df-01ca565b7ecb) -> '1995-09-30' (Source: Olympedia / Australian Olympic Committee)
UPDATE public.sailors
SET dob = '1995-09-30'::date, updated_at = clock_timestamp()
WHERE id = '680d176e-85d5-54f6-b2df-01ca565b7ecb' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Mara Stransky (2a7fedd4-73b4-5807-89ae-ec34197838c0) -> '1999-02-13' (Source: Olympedia (140654))
UPDATE public.sailors
SET dob = '1999-02-13'::date, updated_at = clock_timestamp()
WHERE id = '2a7fedd4-73b4-5807-89ae-ec34197838c0' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Zoe Thomson (0ac22efe-1376-54c7-bd3e-ee7afcea883b) -> '1998-04-02' (Source: Olympedia (153891))
UPDATE public.sailors
SET dob = '1998-04-02'::date, updated_at = clock_timestamp()
WHERE id = '0ac22efe-1376-54c7-bd3e-ee7afcea883b' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Elliot Hansen (8f66574a-1cc9-557a-b01b-87608ee05c60) -> '1994-02-12' (Source: Olympedia (143186))
UPDATE public.sailors
SET dob = '1994-02-12'::date, updated_at = clock_timestamp()
WHERE id = '8f66574a-1cc9-557a-b01b-87608ee05c60' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Lorenzo Brando Chiavarini (61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1) -> '1994-01-17' (Source: Olympedia (153999))
UPDATE public.sailors
SET dob = '1994-01-17'::date, updated_at = clock_timestamp()
WHERE id = '61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Nur Shazrin Mohamad Latif (e65296f7-fdc4-582a-b74b-fc2463ea8228) -> '1998-02-02' (Source: Olympedia (131040))
UPDATE public.sailors
SET dob = '1998-02-02'::date, updated_at = clock_timestamp()
WHERE id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Stephanie Norton (98bf4b68-3283-5b87-bbbe-d11c1977eafc) -> '2000-09-18' (Source: Olympedia (143573))
UPDATE public.sailors
SET dob = '2000-09-18'::date, updated_at = clock_timestamp()
WHERE id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Arthit Mikhail Romanyk (f724016b-a2d6-5d4b-82a0-5ad506ba3bfb) -> '2001-01-16' (Source: Olympedia (154051))
UPDATE public.sailors
SET dob = '2001-01-16'::date, updated_at = clock_timestamp()
WHERE id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Supakon Pongwichean (36b2c840-0917-5a4d-aa40-cd2be30c9780) -> '1995-04-20' (Source: Olympedia (1304108))
UPDATE public.sailors
SET dob = '1995-04-20'::date, updated_at = clock_timestamp()
WHERE id = '36b2c840-0917-5a4d-aa40-cd2be30c9780' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Sophia Montgomery (cf6c134b-acef-4bcb-a77c-8639b4251b65) -> '2003-04-04' (Source: Olympedia (154050))
UPDATE public.sailors
SET dob = '2003-04-04'::date, updated_at = clock_timestamp()
WHERE id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Khairulnizam Mohd Afendy (5179761d-9f8b-498d-bf0b-17cd8dcc4fd6) -> '1993-05-27' (Source: Olympedia (125480))
UPDATE public.sailors
SET dob = '1993-05-27'::date, updated_at = clock_timestamp()
WHERE id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Nicholas Halliday (06bd4877-4d96-44b0-9f66-c14f0061fe59) -> '1999-06-18' (Source: Olympedia (153984))
UPDATE public.sailors
SET dob = '1999-06-18'::date, updated_at = clock_timestamp()
WHERE id = '06bd4877-4d96-44b0-9f66-c14f0061fe59' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Ma Kwan Ching (85b27d22-63dd-4d37-a8a5-d5284edf08b2) -> '1997-08-31' (Source: Olympedia (153981))
UPDATE public.sailors
SET dob = '1997-08-31'::date, updated_at = clock_timestamp()
WHERE id = '85b27d22-63dd-4d37-a8a5-d5284edf08b2' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Cheng Ching Yin (d792628c-3845-4a63-bb2c-4811e9d2dd56) -> '1999-08-10' (Source: Olympedia (153983))
UPDATE public.sailors
SET dob = '1999-08-10'::date, updated_at = clock_timestamp()
WHERE id = 'd792628c-3845-4a63-bb2c-4811e9d2dd56' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Nethra Kumanan (fd29d27b-51f0-47b5-b350-47174654ba5e) -> '1997-08-21' (Source: Olympedia (143739))
UPDATE public.sailors
SET dob = '1997-08-21'::date, updated_at = clock_timestamp()
WHERE id = 'fd29d27b-51f0-47b5-b350-47174654ba5e' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Vishnu Saravanan (1b2c502f-5e5a-58e8-83f3-12817b1126f0) -> '1999-02-24' (Source: Olympedia (143783))
UPDATE public.sailors
SET dob = '1999-02-24'::date, updated_at = clock_timestamp()
WHERE id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Koh Seng Leong (f563ea85-dc20-5eb5-9f2a-4ae0a3427716) -> '1983-09-19' (Source: Olympedia (92947))
UPDATE public.sailors
SET dob = '1983-09-19'::date, updated_at = clock_timestamp()
WHERE id = 'f563ea85-dc20-5eb5-9f2a-4ae0a3427716' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Charles Lim (91d872b9-db2a-4d54-a62b-16cd7852e967) -> '1973-07-10' (Source: Olympedia (62775))
UPDATE public.sailors
SET dob = '1973-07-10'::date, updated_at = clock_timestamp()
WHERE id = '91d872b9-db2a-4d54-a62b-16cd7852e967' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Colin Cheng Xinru (e92c8a88-4f8a-5432-9e0d-42ad1e707486) -> '1989-09-10' (Source: Olympedia (121476))
UPDATE public.sailors
SET dob = '1989-09-10'::date, updated_at = clock_timestamp()
WHERE id = 'e92c8a88-4f8a-5432-9e0d-42ad1e707486' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Tan Wearn Haw (4657a5d7-770c-456a-a381-4fb261c5e6e8) -> '1978-11-12' (Source: Olympedia (92945))
UPDATE public.sailors
SET dob = '1978-11-12'::date, updated_at = clock_timestamp()
WHERE id = '4657a5d7-770c-456a-a381-4fb261c5e6e8' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Ryan Lo Jun Han (df7c6bd6-12f7-412b-994a-f116e820e30d) -> '1997-02-26' (Source: Olympedia (146534))
UPDATE public.sailors
SET dob = '1997-02-26'::date, updated_at = clock_timestamp()
WHERE id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Keira Carlyle (be779040-d45c-4052-b458-9c9e88803505) -> '2006-01-25' (Source: OCA Hangzhou 2022 Asian Games Profile)
UPDATE public.sailors
SET dob = '2006-01-25'::date, updated_at = clock_timestamp()
WHERE id = 'be779040-d45c-4052-b458-9c9e88803505' AND (dob IS NULL OR to_char(dob, 'MM-DD') = '01-01');

-- Casey Imeneo (20f686db-6a99-5bd1-8db1-23e5a24368d9) -> '1998-01-01' (Source: Victorian Institute of Sport Profile)
UPDATE public.sailors
SET dob = '1998-01-01'::date, updated_at = clock_timestamp()
WHERE id = '20f686db-6a99-5bd1-8db1-23e5a24368d9' AND dob IS NULL;

-- Jonathan Chan (0746fdb3-9981-4881-8b8d-0db869997999) -> '2008-01-01' (Source: Singapore Sailing 2025 Techno 293Plus Worlds (17yo in 2025))
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = '0746fdb3-9981-4881-8b8d-0db869997999' AND dob IS NULL;

-- Ethan Lee (c4e262cc-1d16-4e95-90a0-c168b25c2de1) -> '2011-01-01' (Source: Singapore Youth Sailing / Victoria School)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'c4e262cc-1d16-4e95-90a0-c168b25c2de1' AND dob IS NULL;

-- Wai Zhi Tong (903d2cf9-2099-4411-8cf0-e6074ac2c369) -> '2011-01-01' (Source: Singapore Youth Sailing / CHIJ Secondary)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '903d2cf9-2099-4411-8cf0-e6074ac2c369' AND dob IS NULL;

-- Rayson Lee Yin Yi (9ab9e8c2-896a-4d8f-8049-0878e7d210ba) -> '2013-01-01' (Source: racingrulesofsailing.org / Ai Tong School)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '9ab9e8c2-896a-4d8f-8049-0878e7d210ba' AND dob IS NULL;

-- Eitan Oh (922e1135-5c83-45cc-81cd-69c7b5a5ee65) -> '2008-01-01' (Source: racingrulesofsailing.org / Raffles Institution)
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = '922e1135-5c83-45cc-81cd-69c7b5a5ee65' AND dob IS NULL;

-- Foo Yuei Jit (38a04183-810a-478f-bb9f-6bd63314415c) -> '2009-01-01' (Source: racingrulesofsailing.org / SJI)
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = '38a04183-810a-478f-bb9f-6bd63314415c' AND dob IS NULL;

-- ============================================================================
-- 6. CLUB ENRICHMENTS (37 SAILORS)
-- ============================================================================
-- Axl Tan Yi En (d16d2658-3ee4-468c-8ee7-934c6a103fec) -> Club: 'Constant Wind SeaSports' (Source: racingrulesofsailing.org (Techno 293))
UPDATE public.sailors
SET club = 'Constant Wind SeaSports', updated_at = clock_timestamp()
WHERE id = 'd16d2658-3ee4-468c-8ee7-934c6a103fec' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Merelle Xuanying Tay (dcd324f6-84c3-4016-a2b3-29c3e485c27d) -> Club: 'SAF Yacht Club' (Source: racingrulesofsailing.org / Sailwave)
UPDATE public.sailors
SET club = 'SAF Yacht Club', updated_at = clock_timestamp()
WHERE id = 'dcd324f6-84c3-4016-a2b3-29c3e485c27d' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Low Hao Xuan Josh (eb65eaaf-fac7-47c4-bad7-ee573d6cb66a) -> Club: 'SAF Yacht Club' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET club = 'SAF Yacht Club', updated_at = clock_timestamp()
WHERE id = 'eb65eaaf-fac7-47c4-bad7-ee573d6cb66a' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Leopold Sayawaki-Kogut (20028ccf-ac2a-46af-b671-9e4cfba4d390) -> Club: 'Changi Sailing Club' (Source: Sailwave / Singapore regatta records)
UPDATE public.sailors
SET club = 'Changi Sailing Club', updated_at = clock_timestamp()
WHERE id = '20028ccf-ac2a-46af-b671-9e4cfba4d390' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Tham Wan Yew Amos (18019333-0cf7-413e-bd9c-5d1845f124fc) -> Club: 'MOE Sea Sports Centre' (Source: RSYC / MOE regatta records)
UPDATE public.sailors
SET club = 'MOE Sea Sports Centre', updated_at = clock_timestamp()
WHERE id = '18019333-0cf7-413e-bd9c-5d1845f124fc' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Moses Tan Hee (b612e573-d6df-45ee-b4ba-94d852ada2e8) -> Club: 'SAF Yacht Club' (Source: racingrulesofsailing.org / Sailwave)
UPDATE public.sailors
SET club = 'SAF Yacht Club', updated_at = clock_timestamp()
WHERE id = 'b612e573-d6df-45ee-b4ba-94d852ada2e8' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Yap Swee Dean (abeecd7a-f571-4dfb-a1b7-fe9ccf19da18) -> Club: 'SAF Yacht Club' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET club = 'SAF Yacht Club', updated_at = clock_timestamp()
WHERE id = 'abeecd7a-f571-4dfb-a1b7-fe9ccf19da18' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Balthazar Roche (2e005437-68a4-51ab-bc8b-d377f51d55eb) -> Club: 'Woollahra Sailing Club' (Source: sailingresults.net / SSCBC)
UPDATE public.sailors
SET club = 'Woollahra Sailing Club', updated_at = clock_timestamp()
WHERE id = '2e005437-68a4-51ab-bc8b-d377f51d55eb' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Luca De Giosa (5a61d861-917e-55b9-85db-9c122fcc9183) -> Club: 'Hunters Hill Sailing Club' (Source: sailingresults.net / HHSC)
UPDATE public.sailors
SET club = 'Hunters Hill Sailing Club', updated_at = clock_timestamp()
WHERE id = '5a61d861-917e-55b9-85db-9c122fcc9183' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Emerald Jacobsen (6e620e7e-5678-525f-8760-caaacf2266a9) -> Club: 'Woollahra Sailing Club' (Source: sailingresults.net)
UPDATE public.sailors
SET club = 'Woollahra Sailing Club', updated_at = clock_timestamp()
WHERE id = '6e620e7e-5678-525f-8760-caaacf2266a9' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Sijia Deng (9f1d45de-707d-5b7e-a92c-e88596d5233d) -> Club: 'Hunters Hill Sailing Club' (Source: sailingresults.net / mysailing.com.au)
UPDATE public.sailors
SET club = 'Hunters Hill Sailing Club', updated_at = clock_timestamp()
WHERE id = '9f1d45de-707d-5b7e-a92c-e88596d5233d' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Emma Tomkins (0f1eb283-e53c-533e-8113-55753e658647) -> Club: 'Hunters Hill Sailing Club' (Source: sailingresults.net)
UPDATE public.sailors
SET club = 'Hunters Hill Sailing Club', updated_at = clock_timestamp()
WHERE id = '0f1eb283-e53c-533e-8113-55753e658647' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Alix Nguyen-Minh (6eacd878-8c53-4133-93fa-898d196bdf18) -> Club: 'Aberdeen Boat Club' (Source: racingrulesofsailing.org / HKRW)
UPDATE public.sailors
SET club = 'Aberdeen Boat Club', updated_at = clock_timestamp()
WHERE id = '6eacd878-8c53-4133-93fa-898d196bdf18' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Soki Higuchi (eba0deb0-10e4-4d3e-a5e5-5e3fa6287288) -> Club: 'Shonan Junior Yacht Club' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET club = 'Shonan Junior Yacht Club', updated_at = clock_timestamp()
WHERE id = 'eba0deb0-10e4-4d3e-a5e5-5e3fa6287288' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Kotaro Matsunaga (2780f0eb-ea28-44e6-ba67-22a35fb9913d) -> Club: 'Chuo Junior Yacht Club' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET club = 'Chuo Junior Yacht Club', updated_at = clock_timestamp()
WHERE id = '2780f0eb-ea28-44e6-ba67-22a35fb9913d' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Natsumi Kubota (0c3ea04a-905c-45f1-abb7-a4a917e7da14) -> Club: 'B&G Hyogo Junior Ocean Club' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET club = 'B&G Hyogo Junior Ocean Club', updated_at = clock_timestamp()
WHERE id = '0c3ea04a-905c-45f1-abb7-a4a917e7da14' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Kaito Nakamura (89eed0ba-4c8d-49dc-a03e-6624a364f93c) -> Club: 'Yumenoshima Yacht Club' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET club = 'Yumenoshima Yacht Club', updated_at = clock_timestamp()
WHERE id = '89eed0ba-4c8d-49dc-a03e-6624a364f93c' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Riko Muranaka (3d7d17df-71ad-4195-b41d-abdebbed13bc) -> Club: 'B&G Hyogo Junior Ocean Club' (Source: JODA / objectstorage records)
UPDATE public.sailors
SET club = 'B&G Hyogo Junior Ocean Club', updated_at = clock_timestamp()
WHERE id = '3d7d17df-71ad-4195-b41d-abdebbed13bc' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Kaito Hirasawa (8e182f64-ea94-4254-9ae3-b4611981dc3b) -> Club: 'Team Koto' (Source: JODA records)
UPDATE public.sailors
SET club = 'Team Koto', updated_at = clock_timestamp()
WHERE id = '8e182f64-ea94-4254-9ae3-b4611981dc3b' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Tadanao Matsuoka (1ecee009-5449-4a68-be6c-a5e412d6b6c1) -> Club: 'B&G Matsuyama Sailing Club' (Source: JODA records)
UPDATE public.sailors
SET club = 'B&G Matsuyama Sailing Club', updated_at = clock_timestamp()
WHERE id = '1ecee009-5449-4a68-be6c-a5e412d6b6c1' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Luqmaan Aneeq (165daa17-07b6-4fc8-b4ce-60d74e99641f) -> Club: 'Royal College Sailing Team' (Source: slsports.lk / Daily News Sri Lanka)
UPDATE public.sailors
SET club = 'Royal College Sailing Team', updated_at = clock_timestamp()
WHERE id = '165daa17-07b6-4fc8-b4ce-60d74e99641f' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Mckaella Karunaratne (c5fb6a91-68f7-43c8-a701-bbd851f21426) -> Club: 'Ladies'' College Sailing Club' (Source: The Morning / Daily News Sri Lanka)
UPDATE public.sailors
SET club = 'Ladies'' College Sailing Club', updated_at = clock_timestamp()
WHERE id = 'c5fb6a91-68f7-43c8-a701-bbd851f21426' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Laila Hazari (bbe926c6-581b-4400-8ba3-0d8b1182abae) -> Club: 'Methodist College Sailing Club' (Source: Daily Mirror Sri Lanka)
UPDATE public.sailors
SET club = 'Methodist College Sailing Club', updated_at = clock_timestamp()
WHERE id = 'bbe926c6-581b-4400-8ba3-0d8b1182abae' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Aung Sitt Maung (3d2fede9-5b4d-444d-9eb1-49d05991d128) -> Club: 'Yangon Sailing Club' (Source: Myanmar Yachting Federation / ODAM)
UPDATE public.sailors
SET club = 'Yangon Sailing Club', updated_at = clock_timestamp()
WHERE id = '3d2fede9-5b4d-444d-9eb1-49d05991d128' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Sitt May Chit Po (3adcdfee-1b33-409f-9e45-a9d3fc4a2725) -> Club: 'Yangon Sailing Club' (Source: Myanmar Yachting Federation / ODAM)
UPDATE public.sailors
SET club = 'Yangon Sailing Club', updated_at = clock_timestamp()
WHERE id = '3adcdfee-1b33-409f-9e45-a9d3fc4a2725' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Aung Kaung Myat (fa4efa9c-d30f-47d0-897f-1f76370bf4e1) -> Club: 'Yangon Sailing Club' (Source: Myanmar Yachting Federation / ODAM)
UPDATE public.sailors
SET club = 'Yangon Sailing Club', updated_at = clock_timestamp()
WHERE id = 'fa4efa9c-d30f-47d0-897f-1f76370bf4e1' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Arman Aye (1fa4bb52-2067-5b56-8310-3be5d8c1a88e) -> Club: 'Yangon Sailing Club' (Source: Myanmar Yachting Federation / ODAM)
UPDATE public.sailors
SET club = 'Yangon Sailing Club', updated_at = clock_timestamp()
WHERE id = '1fa4bb52-2067-5b56-8310-3be5d8c1a88e' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Shoom Lai Khin (211be6ac-4572-54de-a423-89c4133f5ca8) -> Club: 'Yangon Sailing Club' (Source: Myanmar Yachting Federation / ODAM)
UPDATE public.sailors
SET club = 'Yangon Sailing Club', updated_at = clock_timestamp()
WHERE id = '211be6ac-4572-54de-a423-89c4133f5ca8' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Eaint Po Mo Chit (27313b52-7844-52a0-a4cf-1c5d279f9130) -> Club: 'Yangon Sailing Club' (Source: Myanmar Yachting Federation / ODAM)
UPDATE public.sailors
SET club = 'Yangon Sailing Club', updated_at = clock_timestamp()
WHERE id = '27313b52-7844-52a0-a4cf-1c5d279f9130' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Rob Carmichael (cf4da8f7-43df-56b6-a81c-ac839da9753b) -> Club: 'UWC Thailand' (Source: Phuket / UWC Thailand)
UPDATE public.sailors
SET club = 'UWC Thailand', updated_at = clock_timestamp()
WHERE id = 'cf4da8f7-43df-56b6-a81c-ac839da9753b' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Tan Wearn Haw (4657a5d7-770c-456a-a381-4fb261c5e6e8) -> Club: 'Singapore Sailing Federation' (Source: SNOC / Olympedia)
UPDATE public.sailors
SET club = 'Singapore Sailing Federation', updated_at = clock_timestamp()
WHERE id = '4657a5d7-770c-456a-a381-4fb261c5e6e8' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Stephanie Norton (98bf4b68-3283-5b87-bbbe-d11c1977eafc) -> Club: 'Royal Hong Kong Yacht Club' (Source: HKSF / Olympedia)
UPDATE public.sailors
SET club = 'Royal Hong Kong Yacht Club', updated_at = clock_timestamp()
WHERE id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Nur Shazrin Mohamad Latif (e65296f7-fdc4-582a-b74b-fc2463ea8228) -> Club: 'Malaysian Sailing Association' (Source: Olympedia / MSA)
UPDATE public.sailors
SET club = 'Malaysian Sailing Association', updated_at = clock_timestamp()
WHERE id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Nicholas Halliday (06bd4877-4d96-44b0-9f66-c14f0061fe59) -> Club: 'Royal Hong Kong Yacht Club' (Source: HKSF)
UPDATE public.sailors
SET club = 'Royal Hong Kong Yacht Club', updated_at = clock_timestamp()
WHERE id = '06bd4877-4d96-44b0-9f66-c14f0061fe59' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Sophia Montgomery (cf6c134b-acef-4bcb-a77c-8639b4251b65) -> Club: 'Royal Varuna Yacht Club' (Source: YRAT)
UPDATE public.sailors
SET club = 'Royal Varuna Yacht Club', updated_at = clock_timestamp()
WHERE id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Nethra Kumanan (fd29d27b-51f0-47b5-b350-47174654ba5e) -> Club: 'Tamil Nadu Sailing Association' (Source: YAI / TNSA)
UPDATE public.sailors
SET club = 'Tamil Nadu Sailing Association', updated_at = clock_timestamp()
WHERE id = 'fd29d27b-51f0-47b5-b350-47174654ba5e' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- Vishnu Saravanan (1b2c502f-5e5a-58e8-83f3-12817b1126f0) -> Club: 'Army Yachting Node' (Source: YAI / Indian Army Sailing)
UPDATE public.sailors
SET club = 'Army Yachting Node', updated_at = clock_timestamp()
WHERE id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' AND club IN ('N/A', 'Imported official result', 'Official regatta entry', 'Others', '', 'HKG', 'THA', 'MAS', 'IND', 'SGP', 'CSC', 'WVPR');

-- ============================================================================
-- 7. SCHOOL ENRICHMENTS (33 SAILORS)
-- ============================================================================
-- Axl Tan Yi En (d16d2658-3ee4-468c-8ee7-934c6a103fec) -> School: 'Anglo-Chinese School (Barker Road)' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Anglo-Chinese School (Barker Road)', updated_at = clock_timestamp()
WHERE id = 'd16d2658-3ee4-468c-8ee7-934c6a103fec' AND (school IS NULL OR school = '');

-- Cleo Seah En Rui (bee71ffd-0b62-4fda-af0a-5b931c110e57) -> School: 'Nanyang Polytechnic' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Nanyang Polytechnic', updated_at = clock_timestamp()
WHERE id = 'bee71ffd-0b62-4fda-af0a-5b931c110e57' AND (school IS NULL OR school = '');

-- Elizabeth Victoria Say (1873b5fc-0682-4bfc-b02b-9e453e49f384) -> School: 'Dunman High School' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Dunman High School', updated_at = clock_timestamp()
WHERE id = '1873b5fc-0682-4bfc-b02b-9e453e49f384' AND (school IS NULL OR school = '');

-- Merelle Xuanying Tay (dcd324f6-84c3-4016-a2b3-29c3e485c27d) -> School: 'St. Hilda''s Secondary School' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'St. Hilda''s Secondary School', updated_at = clock_timestamp()
WHERE id = 'dcd324f6-84c3-4016-a2b3-29c3e485c27d' AND (school IS NULL OR school = '');

-- Low Hao Xuan Josh (eb65eaaf-fac7-47c4-bad7-ee573d6cb66a) -> School: 'Victoria School' (Source: moe.edu.sg / racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Victoria School', updated_at = clock_timestamp()
WHERE id = 'eb65eaaf-fac7-47c4-bad7-ee573d6cb66a' AND (school IS NULL OR school = '');

-- Leopold Sayawaki-Kogut (20028ccf-ac2a-46af-b671-9e4cfba4d390) -> School: 'The Japanese School' (Source: Sailwave / Singapore Youth Regatta)
UPDATE public.sailors
SET school = 'The Japanese School', updated_at = clock_timestamp()
WHERE id = '20028ccf-ac2a-46af-b671-9e4cfba4d390' AND (school IS NULL OR school = '');

-- Tham Wan Yew Amos (18019333-0cf7-413e-bd9c-5d1845f124fc) -> School: 'Victoria School' (Source: moe.edu.sg)
UPDATE public.sailors
SET school = 'Victoria School', updated_at = clock_timestamp()
WHERE id = '18019333-0cf7-413e-bd9c-5d1845f124fc' AND (school IS NULL OR school = '');

-- Moses Tan Hee (b612e573-d6df-45ee-b4ba-94d852ada2e8) -> School: 'Anglo-Chinese School (Junior)' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Anglo-Chinese School (Junior)', updated_at = clock_timestamp()
WHERE id = 'b612e573-d6df-45ee-b4ba-94d852ada2e8' AND (school IS NULL OR school = '');

-- Catherine Maiden (867f8d47-e58f-4e20-90c4-06ed0b1bf450) -> School: 'Opera Estate Primary School' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Opera Estate Primary School', updated_at = clock_timestamp()
WHERE id = '867f8d47-e58f-4e20-90c4-06ed0b1bf450' AND (school IS NULL OR school = '');

-- Cheung Kai Jeng Keenan (72093b8a-d68b-4d04-bcf6-3e6311c7aec6) -> School: 'Raffles Institution' (Source: Raffles Press / racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Raffles Institution', updated_at = clock_timestamp()
WHERE id = '72093b8a-d68b-4d04-bcf6-3e6311c7aec6' AND (school IS NULL OR school = '');

-- Cheung Shou Jeng Declan (13f6c6f4-e730-43ff-b42a-1d957daab9dc) -> School: 'Raffles Institution' (Source: moe.edu.sg / racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Raffles Institution', updated_at = clock_timestamp()
WHERE id = '13f6c6f4-e730-43ff-b42a-1d957daab9dc' AND (school IS NULL OR school = '');

-- Yap Swee Dean (abeecd7a-f571-4dfb-a1b7-fe9ccf19da18) -> School: 'Raffles Institution' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Raffles Institution', updated_at = clock_timestamp()
WHERE id = 'abeecd7a-f571-4dfb-a1b7-fe9ccf19da18' AND (school IS NULL OR school = '');

-- Rayson Lee Yin Yi (9ab9e8c2-896a-4d8f-8049-0878e7d210ba) -> School: 'Ai Tong School' (Source: moe.edu.sg / racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Ai Tong School', updated_at = clock_timestamp()
WHERE id = '9ab9e8c2-896a-4d8f-8049-0878e7d210ba' AND (school IS NULL OR school = '');

-- Eitan Oh (922e1135-5c83-45cc-81cd-69c7b5a5ee65) -> School: 'Raffles Institution' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Raffles Institution', updated_at = clock_timestamp()
WHERE id = '922e1135-5c83-45cc-81cd-69c7b5a5ee65' AND (school IS NULL OR school = '');

-- Foo Yuei Jit (38a04183-810a-478f-bb9f-6bd63314415c) -> School: 'Anderson Serangoon Junior College' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Anderson Serangoon Junior College', updated_at = clock_timestamp()
WHERE id = '38a04183-810a-478f-bb9f-6bd63314415c' AND (school IS NULL OR school = '');

-- Clive Wei Jun Seah (9feccee3-556f-494a-bb80-593be88884cc) -> School: 'Catholic Junior College' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Catholic Junior College', updated_at = clock_timestamp()
WHERE id = '9feccee3-556f-494a-bb80-593be88884cc' AND (school IS NULL OR school = '');

-- Mathias Yu Da Wong (f0858934-d4bc-46cc-b818-54cd5337ba3c) -> School: 'Raffles Institution' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Raffles Institution', updated_at = clock_timestamp()
WHERE id = 'f0858934-d4bc-46cc-b818-54cd5337ba3c' AND (school IS NULL OR school = '');

-- Ethan Lee (c4e262cc-1d16-4e95-90a0-c168b25c2de1) -> School: 'Victoria School' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Victoria School', updated_at = clock_timestamp()
WHERE id = 'c4e262cc-1d16-4e95-90a0-c168b25c2de1' AND (school IS NULL OR school = '');

-- Wai Zhi Tong (903d2cf9-2099-4411-8cf0-e6074ac2c369) -> School: 'CHIJ Secondary (Toa Payoh)' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'CHIJ Secondary (Toa Payoh)', updated_at = clock_timestamp()
WHERE id = '903d2cf9-2099-4411-8cf0-e6074ac2c369' AND (school IS NULL OR school = '');

-- Zeph Wan (e178e8d4-02b8-470f-9235-4a451f5eb31a) -> School: 'Anglo-Chinese School (Independent)' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Anglo-Chinese School (Independent)', updated_at = clock_timestamp()
WHERE id = 'e178e8d4-02b8-470f-9235-4a451f5eb31a' AND (school IS NULL OR school = '');

-- Desiree Lee Yuet Chi (7a1b19c2-78a8-414c-8acf-a6dc6f7fb617) -> School: 'Tanjong Katong Girls'' School' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Tanjong Katong Girls'' School', updated_at = clock_timestamp()
WHERE id = '7a1b19c2-78a8-414c-8acf-a6dc6f7fb617' AND (school IS NULL OR school = '');

-- Abigail Jia En Ling (659d2fab-d7dc-409c-8c87-22379c586910) -> School: 'Dunman High School' (Source: National School Games)
UPDATE public.sailors
SET school = 'Dunman High School', updated_at = clock_timestamp()
WHERE id = '659d2fab-d7dc-409c-8c87-22379c586910' AND (school IS NULL OR school = '');

-- Arabelle En Xi Tan (6057a852-a589-4ed9-b887-e96a2178a307) -> School: 'Tanjong Katong Girls'' School' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Tanjong Katong Girls'' School', updated_at = clock_timestamp()
WHERE id = '6057a852-a589-4ed9-b887-e96a2178a307' AND (school IS NULL OR school = '');

-- Elisha Lim Yu Ting (0273c8c6-3b9c-48a6-9f34-91c6c2b61e01) -> School: 'Raffles Girls'' School' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Raffles Girls'' School', updated_at = clock_timestamp()
WHERE id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01' AND (school IS NULL OR school = '');

-- Eugene Tan Yi Ze (dade0eb7-d235-412a-8d1a-3829a4849353) -> School: 'St. Joseph''s Institution Junior' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'St. Joseph''s Institution Junior', updated_at = clock_timestamp()
WHERE id = 'dade0eb7-d235-412a-8d1a-3829a4849353' AND (school IS NULL OR school = '');

-- Zachary Hong Yi Zhang (a841f654-dcfd-44ca-9546-a31595385ee0) -> School: 'St. Joseph''s Institution' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'St. Joseph''s Institution', updated_at = clock_timestamp()
WHERE id = 'a841f654-dcfd-44ca-9546-a31595385ee0' AND (school IS NULL OR school = '');

-- Jonathan Ho Jian Yi (dd2d0d83-4cb8-4ea5-bc90-59531d262be2) -> School: 'Anglo-Chinese School (Independent)' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Anglo-Chinese School (Independent)', updated_at = clock_timestamp()
WHERE id = 'dd2d0d83-4cb8-4ea5-bc90-59531d262be2' AND (school IS NULL OR school = '');

-- Aaron Abraham Say (4e344e28-9a6f-4ae4-93d8-537bc03e1813) -> School: 'Victoria School' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Victoria School', updated_at = clock_timestamp()
WHERE id = '4e344e28-9a6f-4ae4-93d8-537bc03e1813' AND (school IS NULL OR school = '');

-- Maia Kiran Lim Laurie (17707e61-bf21-437e-a84e-6e8f90a212ca) -> School: 'Singapore American School' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Singapore American School', updated_at = clock_timestamp()
WHERE id = '17707e61-bf21-437e-a84e-6e8f90a212ca' AND (school IS NULL OR school = '');

-- Misa Lim Laurie (3b802239-ec10-402e-8ced-5499c5a1ea57) -> School: 'Singapore American School' (Source: racingrulesofsailing.org)
UPDATE public.sailors
SET school = 'Singapore American School', updated_at = clock_timestamp()
WHERE id = '3b802239-ec10-402e-8ced-5499c5a1ea57' AND (school IS NULL OR school = '');

-- Luqmaan Aneeq (165daa17-07b6-4fc8-b4ce-60d74e99641f) -> School: 'Royal College, Colombo' (Source: slsports.lk)
UPDATE public.sailors
SET school = 'Royal College, Colombo', updated_at = clock_timestamp()
WHERE id = '165daa17-07b6-4fc8-b4ce-60d74e99641f' AND (school IS NULL OR school = '');

-- Mckaella Karunaratne (c5fb6a91-68f7-43c8-a701-bbd851f21426) -> School: 'Ladies'' College, Colombo' (Source: Daily News Sri Lanka)
UPDATE public.sailors
SET school = 'Ladies'' College, Colombo', updated_at = clock_timestamp()
WHERE id = 'c5fb6a91-68f7-43c8-a701-bbd851f21426' AND (school IS NULL OR school = '');

-- Laila Hazari (bbe926c6-581b-4400-8ba3-0d8b1182abae) -> School: 'Methodist College, Colombo' (Source: Daily Mirror Sri Lanka)
UPDATE public.sailors
SET school = 'Methodist College, Colombo', updated_at = clock_timestamp()
WHERE id = 'bbe926c6-581b-4400-8ba3-0d8b1182abae' AND (school IS NULL OR school = '');

-- ============================================================================
-- 8. VERIFIED OLYMPIC PORTRAITS (18 SAILORS + 1 CLEAR)
-- ============================================================================
-- Clear unverified placeholder for Victoria Chan (97cbde3f-9b92-5b2b-abbd-416a43ad32c9)
UPDATE public.sailors SET avatar_url = NULL, show_profile_photo_on_public_profile = false, updated_at = clock_timestamp() WHERE id = '97cbde3f-9b92-5b2b-abbd-416a43ad32c9';

-- Colin Cheng Xinru (e92c8a88-4f8a-5432-9e0d-42ad1e707486) -> https://sailorpath.com/athlete-portraits/team-singapore/colin-cheng-xinru.jpg (Olympedia 121476 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/team-singapore/colin-cheng-xinru.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = 'e92c8a88-4f8a-5432-9e0d-42ad1e707486';

-- Koh Seng Leong (f563ea85-dc20-5eb5-9f2a-4ae0a3427716) -> https://sailorpath.com/athlete-portraits/team-singapore/koh-seng-leong.jpg (Olympedia 92947 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/team-singapore/koh-seng-leong.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = 'f563ea85-dc20-5eb5-9f2a-4ae0a3427716';

-- Charles Lim (91d872b9-db2a-4d54-a62b-16cd7852e967) -> https://sailorpath.com/athlete-portraits/team-singapore/charles-lim.jpg (Olympedia 62775 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/team-singapore/charles-lim.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = '91d872b9-db2a-4d54-a62b-16cd7852e967';

-- Matt Wearn (680d176e-85d5-54f6-b2df-01ca565b7ecb) -> https://sailorpath.com/athlete-portraits/international/matt-wearn.jpg (Olympedia 140820 Tokyo 2020 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/matt-wearn.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = '680d176e-85d5-54f6-b2df-01ca565b7ecb';

-- Mara Stransky (2a7fedd4-73b4-5807-89ae-ec34197838c0) -> https://sailorpath.com/athlete-portraits/international/mara-stransky.jpg (Olympedia 140654 Tokyo 2020 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/mara-stransky.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = '2a7fedd4-73b4-5807-89ae-ec34197838c0';

-- Zoe Thomson (0ac22efe-1376-54c7-bd3e-ee7afcea883b) -> https://sailorpath.com/athlete-portraits/international/zoe-thomson.jpg (Olympedia 153891 Paris 2024 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/zoe-thomson.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = '0ac22efe-1376-54c7-bd3e-ee7afcea883b';

-- Elliot Hansen (8f66574a-1cc9-557a-b01b-87608ee05c60) -> https://sailorpath.com/athlete-portraits/international/elliot-hanson.jpg (Olympedia 143186 Tokyo 2020 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/elliot-hanson.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = '8f66574a-1cc9-557a-b01b-87608ee05c60';

-- Lorenzo Brando Chiavarini (61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1) -> https://sailorpath.com/athlete-portraits/international/lorenzo-chiavarini.jpg (Olympedia 153999 FIV official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/lorenzo-chiavarini.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = '61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1';

-- Nur Shazrin Mohamad Latif (e65296f7-fdc4-582a-b74b-fc2463ea8228) -> https://sailorpath.com/athlete-portraits/international/nur-shazrin-mohamad-latif.jpg (Olympedia 131040 29th SEA Games official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/nur-shazrin-mohamad-latif.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228';

-- Stephanie Norton (98bf4b68-3283-5b87-bbbe-d11c1977eafc) -> https://sailorpath.com/athlete-portraits/international/stephanie-norton.jpg (Olympedia 143573 SF&OC HK official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/stephanie-norton.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc';

-- Arthit Mikhail Romanyk (f724016b-a2d6-5d4b-82a0-5ad506ba3bfb) -> https://sailorpath.com/athlete-portraits/international/arthit-mikhail-romanyk.jpg (Olympedia 154051 Paris 2024 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/arthit-mikhail-romanyk.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb';

-- Sophia Montgomery (cf6c134b-acef-4bcb-a77c-8639b4251b65) -> https://sailorpath.com/athlete-portraits/international/sophia-montgomery.jpg (Olympedia 154050 Paris 2024 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/sophia-montgomery.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65';

-- Khairulnizam Mohd Afendy (5179761d-9f8b-498d-bf0b-17cd8dcc4fd6) -> https://sailorpath.com/athlete-portraits/international/khairulnizam-mohd-afendy.jpg (Olympedia 125480 29th SEA Games official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/khairulnizam-mohd-afendy.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6';

-- Nicholas Halliday (06bd4877-4d96-44b0-9f66-c14f0061fe59) -> https://sailorpath.com/athlete-portraits/international/nicholas-halliday.jpg (Olympedia 153984 Paris 2024 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/nicholas-halliday.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = '06bd4877-4d96-44b0-9f66-c14f0061fe59';

-- Ma Kwan Ching (85b27d22-63dd-4d37-a8a5-d5284edf08b2) -> https://sailorpath.com/athlete-portraits/international/ma-kwan-ching.jpg (Olympedia 153981 Paris 2024 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/ma-kwan-ching.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = '85b27d22-63dd-4d37-a8a5-d5284edf08b2';

-- Cheng Ching Yin (d792628c-3845-4a63-bb2c-4811e9d2dd56) -> https://sailorpath.com/athlete-portraits/international/cheng-ching-yin.jpg (Olympedia 153983 Paris 2024 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/cheng-ching-yin.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = 'd792628c-3845-4a63-bb2c-4811e9d2dd56';

-- Nethra Kumanan (fd29d27b-51f0-47b5-b350-47174654ba5e) -> https://sailorpath.com/athlete-portraits/international/nethra-kumanan.jpg (Olympedia 143739 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/nethra-kumanan.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = 'fd29d27b-51f0-47b5-b350-47174654ba5e';

-- Vishnu Saravanan (1b2c502f-5e5a-58e8-83f3-12817b1126f0) -> https://sailorpath.com/athlete-portraits/international/vishnu-saravanan.jpg (Olympedia 143783 official headshot)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/international/vishnu-saravanan.jpg', show_profile_photo_on_public_profile = true, updated_at = clock_timestamp()
WHERE id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0';

-- ============================================================================
-- 9. AUDIT LOG ENTRY
-- ============================================================================
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.demographics_enrichment',
  'sailor',
  '00000000-0000-0000-0000-000000000000',
  'Google Research Profile Enrichment — Migration 184',
  'Normalized genders, backfilled 80 sail_number=0 entries, enriched 29 DOBs, 37 clubs, 33 schools, 12 genders, and attached 18 verified Olympic athlete portraits.',
  jsonb_build_object(
    'sail_numbers_backfilled', 80,
    'genders_enriched', 12,
    'dobs_enriched', 29,
    'clubs_enriched', 37,
    'schools_enriched', 33,
    'photos_attached', 18
  ),
  'migration_184',
  clock_timestamp()
);

COMMIT;
