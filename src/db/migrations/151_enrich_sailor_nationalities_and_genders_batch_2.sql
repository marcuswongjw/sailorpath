-- Migration 151: Demographic Enrichment — Nationalities (126 Sailors) and Genders (39 Sailors)
--
-- 1. Updates nationality for all 126 remaining sailors without nationality based on verified
--    sail prefixes (SGP, UAE, AUS, MAS, USA), national club affiliations, and domestic championships.
-- 2. Updates gender for 39 sailors with 100% confidence based on official regatta result entries.
--
-- All operations executed in a single atomic transaction.

BEGIN;

-- ----------------------------------------------------------------------
-- Section 1: Update Nationalities (126 Sailors)
-- ----------------------------------------------------------------------
-- Abdulla Almarzooki (abdulla-almarzooki-sysc24) -> UAE (Result entry nationality: UAE in Singapore Youth Sailing Championships 2024 (ILCA 4))
UPDATE public.sailors
SET nationality = 'UAE', updated_at = clock_timestamp()
WHERE id = '1ed970be-2e88-471b-9f43-5e964882280d' AND (nationality IS NULL OR nationality = '');

-- Abdullah (abdullah-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'cad2b386-3c2b-559b-b859-ad15947eab25' AND (nationality IS NULL OR nationality = '');

-- Abigail Wut Yi Chiang (abigail-wut-yi-chiang-csc-history) -> SGP (Local Singapore historical regattas: CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4); 3rd CSC ILCA Open 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '852e9a49-11fc-58d2-880d-71f12575399c' AND (nationality IS NULL OR nationality = '');

-- Akos Rigo (akos-rigo-safyc-history) -> SGP (Local Singapore historical regattas: 3rd CSC ILCA Open 2022 (ILCA 7); 44th Singapore Laser Open 2021 (ILCA 7))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '06d0a05e-0f88-50e2-8209-2852fc49b75d' AND (nationality IS NULL OR nationality = '');

-- Alyazia Alhammadi (alyazia-alhammadi-sysc24) -> UAE (Result entry nationality: UAE in Singapore Youth Sailing Championships 2024 (ILCA 6))
UPDATE public.sailors
SET nationality = 'UAE', updated_at = clock_timestamp()
WHERE id = '1015180d-c672-43d9-a7ad-5493220f692a' AND (nationality IS NULL OR nationality = '');

-- Ange Chew (ange-chew-safyc23) -> SGP (Result entry nationality: SGP in Singapore National Sailing Championships 2025 (WingFoil))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '9ee77695-4c61-407a-a395-bd60e8b98204' AND (nationality IS NULL OR nationality = '');

-- Antoni Nils Swolkien (antoni-nils-swolkien-csc-history) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2020 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '0c85a560-ebd5-53d2-8c5b-71ec86b071ad' AND (nationality IS NULL OR nationality = '');

-- Benoit Cosserat (benoit-cosserat-safyc-history) -> SGP (Local Singapore historical regattas: 44th Singapore Laser Open 2021 (ILCA 7))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '2afb8b24-9601-51a3-bcba-952ca58aeeaa' AND (nationality IS NULL OR nationality = '');

-- Bernard Ha (historical-2024-national-slalom-wingfoil-2024-71c76d424570) -> SGP (WAS National Slalom & Northeast Monsoon GP (Singapore))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '8d5656f1-a50a-4845-9d02-aaa1249bdf7c' AND (nationality IS NULL OR nationality = '');

-- Brayden Teo (brayden-teo-safyc-history) -> SGP (Local Singapore historical regattas: 17th SAFYC Regatta 2021 (Optimist Silver); CSC Optimist Championships 2020 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '0db4af16-dae5-58a7-ac5e-e441f6384450' AND (nationality IS NULL OR nationality = '');

-- Caleb Yeo Shien Yee (caleb-yeo-shien-yee-safyc-history) -> SGP (Local Singapore historical regattas: CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4); 17th SAFYC Regatta 2021 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '561f3c1d-6cf8-5f58-a8bd-4c4aa59b8089' AND (nationality IS NULL OR nationality = '');

-- Cassandra Kwan (cassandra-kwan-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver); CSC Optimist Championships 2022 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '828ab5be-d594-5cf3-9c64-da4b2d6df255' AND (nationality IS NULL OR nationality = '');

-- Chan Hian Gee (historical-2024-national-slalom-windsurfing-2024-3d2333615bb6) -> SGP (Singapore domestic regattas: 2024 National Slalom (Slalom))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'ef2c3548-58ab-453c-9f32-0cc515703bb0' AND (nationality IS NULL OR nationality = '');

-- Charles Lim (historical-2024-northeast-monsoon-windfoil-2024-274a7871d124) -> SGP (WAS Northeast Monsoon GP (Singapore))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '91d872b9-db2a-4d54-a62b-16cd7852e967' AND (nationality IS NULL OR nationality = '');

-- Cheung Kai Jeng Keenan (cheung-kai-jeng-keenan-safyc23) -> SGP (Local Singapore historical regattas: 19th SAFYC Regatta 2023 (ILCA 6); 3rd CSC ILCA Open 2022 (ILCA 6))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '72093b8a-d68b-4d04-bcf6-3e6311c7aec6' AND (nationality IS NULL OR nationality = '');

-- Cheung Shou Jeng Declan (cheung-shou-jeng-declan-safyc24) -> SGP (Local Singapore historical regattas: CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4); 3rd CSC ILCA Open 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '13f6c6f4-e730-43ff-b42a-1d957daab9dc' AND (nationality IS NULL OR nationality = '');

-- Claudia Tan (historical-2024-northeast-monsoon-techno293-2024-0aba786742cd) -> SGP (WAS Northeast Monsoon GP (Singapore))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '29256983-d36f-4e36-91c9-ad282e895d93' AND (nationality IS NULL OR nationality = '');

-- Damien Erwan Edmond Gay (historical-2024-national-slalom-wingfoil-2024-60624833a5a9) -> SGP (WAS National Slalom & Northeast Monsoon GP (Singapore))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '8c7af807-d8ca-41a5-9c34-20da063edb9f' AND (nationality IS NULL OR nationality = '');

-- Daniel Hung (daniel-hung-safyc-history) -> SGP (Local Singapore historical regattas: 44th Singapore Laser Open 2021 (ILCA 6))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '7c8c70eb-d172-5740-b744-d097143bdfc5' AND (nationality IS NULL OR nationality = '');

-- Daniel Schwalb (historical-2024-northeast-monsoon-wingfoil-2024-9bdabc366c6f) -> SGP (WAS Northeast Monsoon GP (Singapore))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '9be222f7-5797-4ad9-8995-60fbf8c1745f' AND (nationality IS NULL OR nationality = '');

-- Daniel Wright (historical-2024-northeast-monsoon-wingfoil-2024-606b30da6dd0) -> SGP (WAS Northeast Monsoon GP (Singapore))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd03d6e47-9ef6-447c-9a62-f71df4abbb39' AND (nationality IS NULL OR nationality = '');

-- Daphne Lai (daphne-lai-csc-history) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '6047963a-326e-501a-97bf-5d28f950f90c' AND (nationality IS NULL OR nationality = '');

-- Darius Lee Kheng Wee (darius-lee-kheng-wee-safyc-history) -> SGP (Local Singapore historical regattas: CSC Laser & 29er Open 2021 (ILCA 6); 3rd CSC ILCA Open 2022 (ILCA 6))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'c1720b61-a80e-576e-92fc-3a6eb0700bfe' AND (nationality IS NULL OR nationality = '');

-- Darius Tan Chun Kang (darius-tan-chun-kang-csc-history) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2019 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '30177424-efb9-5947-95d1-595e2ec69490' AND (nationality IS NULL OR nationality = '');

-- Dylan Ng (dylan-ng-safyc-history) -> SGP (Local Singapore historical regattas: 17th SAFYC Regatta 2021 (Optimist Gold); CSC Optimist Championships 2020 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'edb13a03-54e6-56f4-bcfa-585ee3b1b673' AND (nationality IS NULL OR nationality = '');

-- Edmund (historical-2024-northeast-monsoon-wingfoil-2024-90f183db4f3b) -> SGP (WAS Northeast Monsoon GP (Singapore))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '254b4514-dd14-4893-bb1b-3af425acac4f' AND (nationality IS NULL OR nationality = '');

-- Edoardo Lancieri (edoardo-lancieri-safyc-history) -> SGP (Local Singapore historical regattas: CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4); 44th Singapore Laser Open 2021 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'bd91e770-5bee-5fdb-a35f-2cca0fd2943f' AND (nationality IS NULL OR nationality = '');

-- Elissaline Tan (elissaline-tan-safyc-history) -> SGP (Local Singapore historical regattas: CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4); 3rd CSC ILCA Open 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd52d3ac9-d290-56aa-9587-4f290a5a427e' AND (nationality IS NULL OR nationality = '');

-- Emilio Gallar (emilio-gallar-csc-history) -> SGP (Local Singapore historical regattas: CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '55c1ef99-f0c6-558b-a360-6a0f7d571cb9' AND (nationality IS NULL OR nationality = '');

-- Emma Teo Su Wen (emma-teo-su-wen-safyc-history) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2022 (Optimist Silver); 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '481e5995-d8a8-5c8b-b8fb-874b8b316d12' AND (nationality IS NULL OR nationality = '');

-- Ethan Kam Jun Kai (ethan-kam-jun-kai-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Gold); CSC Optimist Championships 2020 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '45bb1acf-0216-51ff-959b-71990b8969dd' AND (nationality IS NULL OR nationality = '');

-- Euan Tan (euan-tan-csc-history) -> SGP (Local Singapore historical regattas: CSC Laser & 29er Open 2021 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '1d21afa9-59b7-57e0-a1a3-096c3f6f474e' AND (nationality IS NULL OR nationality = '');

-- Gabriel Evans Oh (gabriel-evans-oh-csc-history) -> SGP (Local Singapore historical regattas: CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4); CSC Laser & 29er Open 2021 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '1ce32c9c-51db-529f-99c9-4737c8ce500b' AND (nationality IS NULL OR nationality = '');

-- Gabriel Lee Yee How (gabriel-lee-yee-how-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd4d562ed-1967-5c67-a5fd-f92d4fd1a54f' AND (nationality IS NULL OR nationality = '');

-- Gabriel Leow Eu Wei (gabriel-leow-eu-wei-safyc-history) -> SGP (Local Singapore historical regattas: 44th Singapore Laser Open 2021 (ILCA 4); 18th SAFYC Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '58abe088-0b5d-59da-bc96-911149797d9f' AND (nationality IS NULL OR nationality = '');

-- Gavin Siau Tze How (historical-2024-northeast-monsoon-wingfoil-2024-6dac75d6f80f) -> SGP (WAS Northeast Monsoon GP (Singapore))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '52f8894e-f1b7-4528-abe4-4b3065829e4e' AND (nationality IS NULL OR nationality = '');

-- Grace Ling Koy (grace-ling-koy-safyc-history) -> SGP (Local Singapore historical regattas: 17th SAFYC Regatta 2021 (Optimist Gold); CSC Optimist Championships 2020 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '4801f20b-66b8-5cf2-afc4-1e9c8cb4625b' AND (nationality IS NULL OR nationality = '');

-- Hayden Tan (hayden-tan-safyc-history) -> SGP (Local Singapore historical regattas: 17th SAFYC Regatta 2021 (Optimist Gold); 18th SAFYC Regatta 2022 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'fb09e037-a967-59b0-bce7-bdacb7570c58' AND (nationality IS NULL OR nationality = '');

-- Hongfei Chen (hongfei-chen-safyc-history) -> SGP (Local Singapore historical regattas: 46th Singapore ILCA Open 2023 (ILCA 6))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'f83db9e7-bc75-5d4e-9311-8a5ef8309d0a' AND (nationality IS NULL OR nationality = '');

-- Huang Yi Cheng Liam (huang-yi-cheng-liam-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '83809dc2-7999-54be-8ab9-5eae50286b93' AND (nationality IS NULL OR nationality = '');

-- Isabel McKeown (isabel-mckeown-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '65a253da-fe6c-5424-8f14-0102cd3ce3ca' AND (nationality IS NULL OR nationality = '');

-- Jacob Koh (jacob-koh-csc-history) -> SGP (Local Singapore historical regattas: CSC Laser & 29er Open 2021 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '59c93ae0-d116-5d07-adc0-fe56bef60d54' AND (nationality IS NULL OR nationality = '');

-- Jared Buckalew (jared-buckalew-safyc-history) -> SGP (Local Singapore historical regattas: 44th Singapore Laser Open 2021 (ILCA 4); 18th SAFYC Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'dd25a539-cf63-59b3-8c35-df1b08668046' AND (nationality IS NULL OR nationality = '');

-- Jarrett Tan Yi Jie (jarrett-tan-yi-jie-safyc-history) -> SGP (Local Singapore historical regattas: 44th Singapore Laser Open 2021 (ILCA 6))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '9830fd1f-a2d8-5d12-8df7-39ac874d9c26' AND (nationality IS NULL OR nationality = '');

-- Jeanette Tan Wan Wen (historical-2023-csc-optimist-silver-jeanette-tan-wan-wen-2017) -> SGP (Result entry nationality: SGP in Singapore National Sailing Championships 2023 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '1b2d7976-00d6-4492-ad83-41c94eeec5e7' AND (nationality IS NULL OR nationality = '');

-- Jiang Peiru (historical-2023-csc-optimist-silver-jiang-peiru-4637) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2023 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '7625c192-9bed-4194-9311-1269a8adb639' AND (nationality IS NULL OR nationality = '');

-- Jodi Lio (jodi-lio-csc-history) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '9f0bd21c-e10a-5cf7-a49e-d8a28ff49cbf' AND (nationality IS NULL OR nationality = '');

-- Joel Ng Junyang (joel-ng-junyang-safyc-history) -> SGP (Local Singapore historical regattas: 44th Singapore Laser Open 2021 (ILCA 4); CSC Optimist Championships 2020 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '474bc334-784d-59bb-aaca-39928cbfce66' AND (nationality IS NULL OR nationality = '');

-- Jonathan Gunn (jonathan-gunn-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '9e46bd44-b167-5219-a5e0-70fa536ebdd8' AND (nationality IS NULL OR nationality = '');

-- Jonathan Lio (jonathan-lio-safyc-history) -> SGP (Local Singapore historical regattas: CSC Laser & 29er Open 2021 (ILCA 6); 44th Singapore Laser Open 2021 (ILCA 6))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '10edc306-7c3e-5c73-890b-12be65fabfba' AND (nationality IS NULL OR nationality = '');

-- Joon Chyi Huey (historical-2024-national-slalom-windsurfing-2024-8f7cfe4fe353) -> SGP (National Slalom / Northeast Monsoon GP (Singapore, sail SGP11))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd4fc4a34-126d-452c-8020-97af1bd81daa' AND (nationality IS NULL OR nationality = '');

-- Joseph Kum Kok Liang (joseph-kum-kok-liang-safyc-history) -> SGP (Local Singapore historical regattas: 17th SAFYC Regatta 2021 (ILCA 4); 44th Singapore Laser Open 2021 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '10b3a025-cd46-5f9e-877a-675f6b2fe165' AND (nationality IS NULL OR nationality = '');

-- Josh Ang Shaal (historical-2024-csc-29er-jan-2024-4a6f736820416e6720) -> SGP (Local Singapore historical regattas: CSC ILCA & 29er Championships 2024 (29er); 17th SAFYC Regatta 2021 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '69a46a72-4a68-4e52-94b2-3b12cf76e886' AND (nationality IS NULL OR nationality = '');

-- Josh Isaac Choy (josh-isaac-choy-safyc-history) -> SGP (Local Singapore historical regattas: CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4); 17th SAFYC Regatta 2021 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '373ddc73-9322-5c2a-9312-8c06c3654f20' AND (nationality IS NULL OR nationality = '');

-- Josh Ng Junying (josh-ng-junying-safyc-history) -> SGP (Local Singapore historical regattas: 44th Singapore Laser Open 2021 (ILCA 4); CSC Optimist Championships 2020 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'a3c3968a-019d-514d-824e-57aeb3622f3e' AND (nationality IS NULL OR nationality = '');

-- Julia Zhong Chew (julia-zhong-chew-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '31a6ff14-4e27-5e21-a980-252278b8bf57' AND (nationality IS NULL OR nationality = '');

-- Kazuya Declan Yoshikawa (kazuya-declan-yoshikawa-safyc-history) -> SGP (Local Singapore historical regattas: 46th Singapore ILCA Open 2023 (ILCA 7))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'e3892131-5f25-5e3b-a3f2-ff01ec597df0' AND (nationality IS NULL OR nationality = '');

-- Koh Liang Shuo (koh-liang-shuo-csc-history) -> SGP (Local Singapore historical regattas: CSC Laser & 29er Open 2021 (ILCA 7))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '4a0c228f-f384-5dff-8023-0a374a495168' AND (nationality IS NULL OR nationality = '');

-- Koh Seng Leong (koh-seng-leong-csc-history) -> SGP (Local Singapore historical regattas: CSC Laser & 29er Open 2021 (ILCA 7))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'f563ea85-dc20-5eb5-9f2a-4ae0a3427716' AND (nationality IS NULL OR nationality = '');

-- Koh Yi Nian (koh-yi-nian) -> SGP (Pesta Sukan ILCA 6 (Singapore))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd2c42f1a-b69c-4006-a762-60f9cbc0bfad' AND (nationality IS NULL OR nationality = '');

-- Kong Meng Loong (kong-meng-loong) -> MAS (Bagan Ajam Sailing Club (Penang, Malaysia))
UPDATE public.sailors
SET nationality = 'MAS', updated_at = clock_timestamp()
WHERE id = '8fd48635-0def-4248-9682-9ef6bf66cb72' AND (nationality IS NULL OR nationality = '');

-- Kwan Zheng Kit (kwan-zheng-kit-safyc-history) -> SGP (Local Singapore historical regattas: 17th SAFYC Regatta 2021 (Optimist Gold); CSC Optimist Championships 2020 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'be3cdbd6-da4b-5d42-bbef-6ecb00db9081' AND (nationality IS NULL OR nationality = '');

-- Kyle Lim Khoon Leng (kyle-lim-khoon-leng-safyc-history) -> SGP (Singapore club affiliation: 'RI')
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '71032b2e-0bdd-5a9c-be65-f7c302dae704' AND (nationality IS NULL OR nationality = '');

-- Lachlan Prior (lachlan-prior-anz26-aeca69) -> AUS (Australian club affiliation: 'RYCT / SBSC')
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'aeca69e7-705c-451e-a0eb-363a1f6ab757' AND (nationality IS NULL OR nationality = '');

-- Lavinia Liu (lavinia-liu-anz26-f26ce4) -> AUS (2026 Musto Australian Optimist Championship (NSW/ACT, sail 1866))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f26ce470-48a0-419e-967e-b1e936dad712' AND (nationality IS NULL OR nationality = '');

-- Lawrence Ng (historical-2024-northeast-monsoon-wingfoil-2024-782762a9135e) -> SGP (WAS Northeast Monsoon GP (Singapore))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '9cec458c-fdc2-45ff-9284-feb6e522a369' AND (nationality IS NULL OR nationality = '');

-- Lee Peng Why (historical-2024-northeast-monsoon-windfoil-2024-c572b8885863) -> SGP (Northeast Monsoon GP (Singapore, sail SGX))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'f4ff684d-5d31-43ca-a69e-da39b766f08c' AND (nationality IS NULL OR nationality = '');

-- Lee Wonn Kye (lee-wonn-kye-safyc-history) -> SGP (Local Singapore historical regattas: 17th SAFYC Regatta 2021 (ILCA 7); 44th Singapore Laser Open 2021 (ILCA 7))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'ce2c2198-a4e7-503c-b00c-f2759b18c68c' AND (nationality IS NULL OR nationality = '');

-- Leopold Sayawaki-Kogut (leopold-sayawaki-kogut-safyc23) -> SGP (Sail number prefix SGP (SGP 710))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '20028ccf-ac2a-46af-b671-9e4cfba4d390' AND (nationality IS NULL OR nationality = '');

-- Li Xuanyi (historical-2023-csc-optimist-gold-li-xuanyi-8501) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2023 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '72f01cfc-b20c-451d-96c1-1f063b3bbffd' AND (nationality IS NULL OR nationality = '');

-- Liu Jia Jun (liu-jia-jun-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (ILCA 4); CSC Optimist Championships 2019 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '544c9e54-bd6d-56ed-9a80-af28a25e4681' AND (nationality IS NULL OR nationality = '');

-- Liu Sining (historical-2023-csc-optimist-gold-liu-sining-9077) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2023 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '4f847ed0-9a64-4679-a7f4-70c7bd447dd9' AND (nationality IS NULL OR nationality = '');

-- Louis Le Peutrec (louis-le-peutrec-anz26-5e17fd) -> AUS (Australian club affiliation: 'SRC')
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '5e17fd28-2265-4964-954f-612841ab9ca4' AND (nationality IS NULL OR nationality = '');

-- Low Xian Ming Damien (low-xian-ming-damien-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'be2e332d-f90c-5d81-b3c5-d8f65fd875d7' AND (nationality IS NULL OR nationality = '');

-- Lucas Xi Kun Wang (lucas-xi-kun-wang-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '14de52c7-8155-58b4-abc8-1608b41134ca' AND (nationality IS NULL OR nationality = '');

-- Lyla Greenwood (lyla-greenwood-anz26-a1bac0) -> AUS (Australian club affiliation: 'RQYS SYC')
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'a1bac017-5467-45ce-9ddc-53c13bcf2852' AND (nationality IS NULL OR nationality = '');

-- Lyu Zixuan (historical-2023-csc-optimist-gold-lyu-zixuan-9066) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2023 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '3ecd1161-25ff-421f-a1a1-5a7dca3891a1' AND (nationality IS NULL OR nationality = '');

-- Manikanda Durairaj Prathistta (manikanda-durairaj-prathistta-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (ILCA 6))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '11570c74-d0e2-5bdc-be29-d21d2e7a7de7' AND (nationality IS NULL OR nationality = '');

-- Marwa Alhammadi (marwa-alhammadi-sysc24) -> UAE (Result entry nationality: UAE in Singapore Youth Sailing Championships 2024 (ILCA 4))
UPDATE public.sailors
SET nationality = 'UAE', updated_at = clock_timestamp()
WHERE id = '157c0b9e-a4af-4e48-9429-1570688c6333' AND (nationality IS NULL OR nationality = '');

-- Matilde Gerdner Kalle (matilde-gerdner-kalle-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd2a04dfb-e69a-5102-ad8d-1c79ed95277d' AND (nationality IS NULL OR nationality = '');

-- Maurice Ng (maurice-ng-csc-history) -> SGP (Local Singapore historical regattas: CSC Laser & 29er Open 2021 (ILCA 6))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '5cc5a2f0-80cd-5212-81ff-a3012011f4fc' AND (nationality IS NULL OR nationality = '');

-- Max Teo Wei Kang (max-teo-wei-kang-nsc24) -> SGP (Singapore club affiliation: 'NTU Windsurfing Club')
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd60ce92a-e5d0-4782-f4bb-92e0618fc3a9' AND (nationality IS NULL OR nationality = '');

-- Migiwa Sueda (migiwa-sueda-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Gold); CSC Optimist Championships 2020 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '5f785349-435b-5947-9ab6-82c29e1b6a3c' AND (nationality IS NULL OR nationality = '');

-- Mohamed Alhosani (mohamed-alhosani-sysc24) -> UAE (Result entry nationality: UAE in Singapore Youth Sailing Championships 2024 (ILCA 6))
UPDATE public.sailors
SET nationality = 'UAE', updated_at = clock_timestamp()
WHERE id = '0687482b-456d-41e0-b949-dfc751dc2f1f' AND (nationality IS NULL OR nationality = '');

-- Mohamed Aqjl (mohamed-aqjl-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '2e12835a-0d8f-5e42-a9a7-727d0c15d604' AND (nationality IS NULL OR nationality = '');

-- Mohamed Qawiyyul Marthin (mohamed-qawiyyul-marthin-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver); CSC Optimist Championships 2019 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'e10a4a77-4434-5209-9a40-61c062aae1af' AND (nationality IS NULL OR nationality = '');

-- Mohammad Nur Iskandar Bin Marwan (asian-unk-mohammad-n-722ece) -> MAS (Langkawi International Regatta Perdana 2026 (Malaysia))
UPDATE public.sailors
SET nationality = 'MAS', updated_at = clock_timestamp()
WHERE id = '0bfe2ed2-e79b-49d2-a67b-da605602638f' AND (nationality IS NULL OR nationality = '');

-- Muhammad Raihan (muhammad-raihan-safyc-history) -> SGP (Local Singapore historical regattas: CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4); 3rd CSC ILCA Open 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'b2cb0184-1fdb-572a-946b-3d896081ea6a' AND (nationality IS NULL OR nationality = '');

-- Nadine Sng Wen Ting (nadine-sng-wen-ting-safyc-history) -> SGP (Local Singapore historical regattas: CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4); 3rd CSC ILCA Open 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '642bdf39-8351-5658-a35c-618ecc2962b8' AND (nationality IS NULL OR nationality = '');

-- Nathan Chang (nathan-chang-safyc23) -> SGP (Local Singapore historical regattas: CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4); 3rd CSC ILCA Open 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '391c7d21-39e1-4cee-80db-377eb4b3f509' AND (nationality IS NULL OR nationality = '');

-- Navya Gupta (navya-gupta-safyc-history) -> SGP (Local Singapore historical regattas: 44th Singapore Laser Open 2021 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'e9c0c49d-7b52-56d0-9f10-2052c568d861' AND (nationality IS NULL OR nationality = '');

-- Ng Yu En (ng-yu-en-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '90dd95df-0c3e-59b3-8c26-f7d227d54f50' AND (nationality IS NULL OR nationality = '');

-- Nicholas Peh (nicholas-peh-csc-history) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2020 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'bea7e9c1-5f45-5b35-a2e0-dc1f1e7594b6' AND (nationality IS NULL OR nationality = '');

-- Noah Ihsan (noah-ihsan-csc-history) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2019 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '8397c8dc-383b-5592-9953-0e45748c5ff8' AND (nationality IS NULL OR nationality = '');

-- Oon Chong Ren (oon-chong-ren-safyc-history) -> SGP (Local Singapore historical regattas: 17th SAFYC Regatta 2021 (ILCA 4); 44th Singapore Laser Open 2021 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '367c7249-ae30-5bc1-becb-0f9697c0ab32' AND (nationality IS NULL OR nationality = '');

-- Orson James Stewart (orson-james-stewart-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '14ca7e2e-1414-5059-8343-f4ac42b2e50b' AND (nationality IS NULL OR nationality = '');

-- Ou Xin Yu (ou-xin-yu-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '67f7725d-ae35-5bbc-bd04-b6e9de526984' AND (nationality IS NULL OR nationality = '');

-- Park In Joon (park-in-joon-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '3f60b228-11f1-5af5-8e79-5504eaec55b9' AND (nationality IS NULL OR nationality = '');

-- Poh Yong Ler (poh-yong-ler-csc-history) -> SGP (Local Singapore historical regattas: 44th Singapore Laser Open 2021 (ILCA 4); CSC Laser & 29er Open 2021 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'fbb5638a-234a-5bef-808d-2a714faf13d0' AND (nationality IS NULL OR nationality = '');

-- Poh Zi Qian Anderson (poh-zi-qian-anderson-safyc-history) -> SGP (Local Singapore historical regattas: 44th Singapore Laser Open 2021 (ILCA 4); 18th SAFYC Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'b2dde4ed-2e42-54fb-a36e-520b5cfb4667' AND (nationality IS NULL OR nationality = '');

-- Qin Weihan (qin-weihan-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '4eceb2e2-10d3-5f5a-a0e4-04b742e22ae3' AND (nationality IS NULL OR nationality = '');

-- Rachel Charis Ng (historical-2024-national-slalom-wingfoil-2024-d91046a95cb0) -> SGP (Singapore domestic regattas: 2024 National Slalom (WingFoil))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '2c76466a-7860-4020-ab3d-652a156dd020' AND (nationality IS NULL OR nationality = '');

-- Ralf Chang (ralf-chang-safyc23) -> SGP (Local Singapore historical regattas: 19th SAFYC Regatta 2023 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '17cf453c-3258-4226-9e94-d9a40a5bfd1a' AND (nationality IS NULL OR nationality = '');

-- Regina Koh (regina-koh-safyc-history) -> SGP (Local Singapore historical regattas: 17th SAFYC Regatta 2021 (ILCA 6); 44th Singapore Laser Open 2021 (ILCA 6))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '04a74ce3-5295-5869-a29d-b0bb5c398ba7' AND (nationality IS NULL OR nationality = '');

-- Ren Yinuo (historical-2023-csc-optimist-gold-ren-yinuo-3869) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2023 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'c1d6b04e-bb69-48e8-b4d1-c91047fc848f' AND (nationality IS NULL OR nationality = '');

-- Resi Tay (resi-tay-safyc-history) -> SGP (Local Singapore historical regattas: 17th SAFYC Regatta 2021 (Optimist Gold); CSC Optimist Championships 2020 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '82c776f2-9e64-524a-b786-80966f6b22fc' AND (nationality IS NULL OR nationality = '');

-- Richard Grant (richard-grant-csc-history) -> SGP (Local Singapore historical regattas: CSC Laser & 29er Open 2021 (ILCA 7))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '783e8859-0b79-5c62-add0-1c84147e1a49' AND (nationality IS NULL OR nationality = '');

-- Robert Finora (robert-finora) -> USA (Old Cove Yacht Club (New Suffolk, NY, USA))
UPDATE public.sailors
SET nationality = 'USA', updated_at = clock_timestamp()
WHERE id = '7cf5413a-a894-41b1-a5df-eceab42918bd' AND (nationality IS NULL OR nationality = '');

-- Russell Augustine Yom (russell-augustine-yom-safyc-history) -> SGP (Sail number prefix SGP (SGP 209051))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '14edaa7f-2990-5333-9865-3d3c2f28b06f' AND (nationality IS NULL OR nationality = '');

-- Ryan Kam Jun Le (ryan-kam-jun-le-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '440d1dae-308d-5e22-8170-5be1844b3f88' AND (nationality IS NULL OR nationality = '');

-- Samuel Hung (samuel-hung-safyc-history) -> SGP (Local Singapore historical regattas: 44th Singapore Laser Open 2021 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '915dce58-3ada-5bb6-9bb1-cf1d9434de11' AND (nationality IS NULL OR nationality = '');

-- Samuel Lee Yee Kiat (samuel-lee-yee-kiat-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '8d09fefa-263d-5b57-9c8a-72d45dcced21' AND (nationality IS NULL OR nationality = '');

-- Sherman Ong Chung Jun (sherman-ong-chung-jun-safyc24) -> SGP (Local Singapore historical regattas: 20th SAFYC Regatta 2024 (ILCA 6))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '81d31357-e95c-4fc3-9863-a0858f84d593' AND (nationality IS NULL OR nationality = '');

-- Shuban Jaitly (shuban-jaitly-safyc-history) -> SGP (Local Singapore historical regattas: 3rd CSC ILCA Open 2022 (ILCA 6); CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 6))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '4accb3bf-657b-51e3-9ac5-07c55f7f280e' AND (nationality IS NULL OR nationality = '');

-- Stanley Yong (stanley-yong-safyc-history) -> SGP (Local Singapore historical regattas: 18th SAFYC Regatta 2022 (ILCA 7))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'afdf74bb-68bb-5c75-885a-4b4be4297e44' AND (nationality IS NULL OR nationality = '');

-- Stirling Marshall (stirling-marshall-anz26-a08688) -> AUS (Australian club affiliation: 'AWSC and SYC')
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'a08688e8-35e4-4ca6-9574-bd909c551806' AND (nationality IS NULL OR nationality = '');

-- Thaddeus Lee (thaddeus-lee-csc-history) -> SGP (Local Singapore historical regattas: CSC Laser & 29er Open 2021 (ILCA 4))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '4d6bc711-a7c1-5d6b-b8cf-145e579aa119' AND (nationality IS NULL OR nationality = '');

-- Theophile Dorchies (theophile-dorchies-anz26-5f0f32) -> AUS (Australian club affiliation: 'SRC')
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '5f0f32e7-434f-4647-8132-2774e13be3da' AND (nationality IS NULL OR nationality = '');

-- Theresa Tan (theresa-tan-gqlr5h5) -> SGP (CSC Optimist Silver Dec 2024 (Singapore, sail 733))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '96c977ba-36ee-4560-8e7d-98f8460da16a' AND (nationality IS NULL OR nationality = '');

-- Tng Zong Heng (tng-zong-heng-safyc-history) -> SGP (Singapore club affiliation: 'Singapore Sailing')
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '6ca77f2f-bbdd-5dc5-802b-9acdb9818f8c' AND (nationality IS NULL OR nationality = '');

-- Tomohiko Inamura (tomohiko-inamura-safyc-history) -> SGP (Local Singapore historical regattas: 44th Singapore Laser Open 2021 (ILCA 7))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '2abdd2d8-c29e-5bee-a422-32efd930c234' AND (nationality IS NULL OR nationality = '');

-- Vincent Lam (historical-2024-national-slalom-wingfoil-2024-b0f8039a4d94) -> SGP (WAS National Slalom & Northeast Monsoon GP (Singapore))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '47b04ca3-1213-45af-aef4-66f7beedad18' AND (nationality IS NULL OR nationality = '');

-- William Teo (william-teo-csc-history) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2019 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'c684681b-dd3c-5dfc-b8f7-3e55e65f9bbf' AND (nationality IS NULL OR nationality = '');

-- Xavier Lau (xavier-lau-b3c87a) -> SGP (2025 Northeast Monsoon GP Wingfoil (Singapore))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '72d6e799-15fe-4e29-a181-857b8a1f8f73' AND (nationality IS NULL OR nationality = '');

-- Zach Low (zach-low-safyc-history) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2020 (Optimist Gold); 17th SAFYC Regatta 2021 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '22ecf967-dc85-5794-be41-f273c619064d' AND (nationality IS NULL OR nationality = '');

-- Zave Chua Kai Jun (zave-chua-kai-jun-csc-history) -> SGP (Local Singapore historical regattas: CSC Optimist Championships 2019 (Optimist Gold))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '50943605-13eb-54ae-9fae-5d8b75d774fc' AND (nationality IS NULL OR nationality = '');

-- ----------------------------------------------------------------------
-- Section 2: Update Genders (39 Sailors)
-- ----------------------------------------------------------------------
-- Abdulla Yahya (abdulla-yahya-it2digr) -> M (Result entry gender 'M' in Singapore Youth Sailing Championships 2024 (Optimist Gold))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '73e71932-9fc3-4180-8116-a31bc5304985' AND (gender IS NULL OR gender = '');

-- Abdurahman Al Bahri (abdurahman-al-bahri-iv4fl7q) -> M (Result entry gender 'M' in Singapore Youth Sailing Championships 2024 (Optimist Gold))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'aa1bd78d-d835-450c-85cf-fe7f28b2c0c6' AND (gender IS NULL OR gender = '');

-- Aidon Xiong (aidon-xiong-fck0fyr) -> M (Result entry gender 'M' in Singapore National Sailing Championships 2025 (Optimist Gold))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '3b4f7056-4c2e-4f40-a38c-17cbae6fe682' AND (gender IS NULL OR gender = '');

-- Ang Zhi Shan Jewel (ang-zhi-shan-jewel-safyc24) -> F (Result entry gender 'F' in 18th SAFYC Regatta 2022 (Optimist Silver))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'aec8aceb-bcec-4e63-a653-e9d2ea620edf' AND (gender IS NULL OR gender = '');

-- Cheung Shou Jeng Declan (cheung-shou-jeng-declan-safyc24) -> M (Result entry gender 'M' in CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '13f6c6f4-e730-43ff-b42a-1d957daab9dc' AND (gender IS NULL OR gender = '');

-- Chow Yi Jun, Ian (chow-yi-jun-ian-safyc24) -> M (Result entry gender 'M' in Singapore Youth Sailing Championships 2024 (ILCA 6))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '5f93827a-355d-4512-b132-acd84d578fe6' AND (gender IS NULL OR gender = '');

-- Cleo Badenach (cleo-badenach-fenbpez) -> F (Result entry gender 'F' in Singapore National Sailing Championships 2025 (Optimist Gold))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'ea64eb68-1514-4725-b361-d00c7c397d4d' AND (gender IS NULL OR gender = '');

-- Gene Sudjana (gene-sudjana-5w1auxf) -> M (Result entry gender 'M' in CSC Optimist Championships 2023 (Optimist Silver))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '69982b16-c249-45a6-b0d4-a27294f0ff99' AND (gender IS NULL OR gender = '');

-- Hao Li (hao-li-62ugjg6) -> M (Result entry gender 'M' in Pesta Sukan Regatta 2025 (Optimist Silver))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '9079bd3e-f325-4476-9429-ca33a14c71d1' AND (gender IS NULL OR gender = '');

-- Huang Xuchen (huang-xuchen-wgucmwo) -> M (Result entry gender 'M' in NSC 1 Silver (Dec 24))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '3631e260-02ea-4901-8f39-77f3edff72bf' AND (gender IS NULL OR gender = '');

-- Iman (iman-safyc-history) -> F (Result entry gender 'F' in 3rd CSC ILCA Open 2022 (ILCA 6))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '0734265d-4f61-5c1e-ae03-6f39847bbd1c' AND (gender IS NULL OR gender = '');

-- Ines Mendez Larminaux (ines-mendez-larminaux-hkrw-80c3e8) -> F (Result entry gender 'F' in 2026 Optimist World Championship (Optimist Overall))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '80c3e84a-7555-5a32-8585-33bcc74382d8' AND (gender IS NULL OR gender = '');

-- Jarrel Khoo Yu Feng (jarrel-khoo-yu-feng-safyc-history) -> M (Result entry gender 'M' in CSC Optimist Championships 2020 (Optimist Gold))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'ef75b8dc-7b66-5fcb-876b-907f980076b6' AND (gender IS NULL OR gender = '');

-- Julyet Lew (julyet-lew-safyc-history) -> F (Result entry gender 'F' in CSC Laser & 29er Open 2021 (ILCA 4))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'a01b175f-a7f0-5715-bab4-c70d81ab4e03' AND (gender IS NULL OR gender = '');

-- Kabir Manoj Daryanani (kabir-manoj-daryanani-y0n7p3o) -> M (Result entry gender 'M' in Raffles Marina Optimist Regatta 2024 (Silver))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'a7ed7eef-6234-410a-8e41-90033c42db44' AND (gender IS NULL OR gender = '');

-- Khalifa Ahmed Al Romaithi (khalifa-ahmed-al-romaithi-ix69b9o) -> M (Result entry gender 'M' in Singapore Youth Sailing Championships 2024 (Optimist Gold))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'ef60c046-800e-4971-b031-2431a91a3cc4' AND (gender IS NULL OR gender = '');

-- Kram Chantarawinij (kram-chantarawinij-ixuvlnw) -> M (Result entry gender 'M' in Singapore Youth Sailing Championships 2024 (Optimist Gold))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '2faf8eb3-aabb-4616-bc87-cea77c033f8c' AND (gender IS NULL OR gender = '');

-- Lahari Kommaravelly (lahari-kommaravelly-z9kxf37) -> F (Result entry gender 'F' in Singapore National Sailing Championships 2025 (Optimist Gold))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'a7e5107d-faf3-4a7d-88f4-44613744a575' AND (gender IS NULL OR gender = '');

-- Laurent Geiger (laurent-geiger-iar8shk) -> M (Result entry gender 'M' in NSC Cup 1 Silver (Mar 25))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '14df5dbd-818a-437f-b480-32f1407d766a' AND (gender IS NULL OR gender = '');

-- Liu Jia He (liu-jia-he-gt684dy) -> F (Result entry gender 'F' in NSC Cup 1 Silver (Mar 25))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '0e0979a0-e42b-412f-84d8-5a3908ea6ba2' AND (gender IS NULL OR gender = '');

-- Liu Jia Jun (liu-jia-jun-safyc-history) -> M (Result entry gender 'M' in CSC Optimist Championships 2019 (Optimist Silver))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '544c9e54-bd6d-56ed-9a80-af28a25e4681' AND (gender IS NULL OR gender = '');

-- Lo Jin Keith (lo-jin-keith-safyc24) -> M (Result entry gender 'M' in CSC ILCA & 29er Championships 2024 (ILCA 4))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'd80da417-a89f-4cfb-8be0-be4fc5abc8c1' AND (gender IS NULL OR gender = '');

-- Loan Ethan Schuhmann (loan-ethan-schuhmann-hkrw-768c2a) -> M (Result entry gender 'M' in CSC Optimist Championships 2022 (Optimist Gold))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '768c2aea-84f8-5675-890b-b00e66dc7d59' AND (gender IS NULL OR gender = '');

-- Mohamed Qawiyyul Marthin (mohamed-qawiyyul-marthin-safyc-history) -> M (Result entry gender 'M' in CSC Optimist Championships 2019 (Optimist Silver))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'e10a4a77-4434-5209-9a40-61c062aae1af' AND (gender IS NULL OR gender = '');

-- Nicole Ng Hui Hong (nicole-ng-hui-hong) -> F (Result entry gender 'F' in CSC ILCA & 29er Championships 2024 (29er))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '0701bebf-cbd2-4bb7-9d1b-34f48fad4f86' AND (gender IS NULL OR gender = '');

-- Ou Xin Ying (ou-xin-ying-safyc24) -> F (Result entry gender 'F' in Raffles Marina ILCA Championship 2024 (ILCA 6))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '1e7ec0fd-1ec7-4e83-bbcd-0ada192b7e1f' AND (gender IS NULL OR gender = '');

-- Rashed Al Neyadi (rashed-al-neyadi-j71p6mj) -> M (Result entry gender 'M' in Singapore Youth Sailing Championships 2024 (Optimist Gold))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '4d828529-455c-49d9-b5d1-26f451a8cec7' AND (gender IS NULL OR gender = '');

-- Rizwan Mohammed (rizwan-mohammed-zhbdtuu) -> M (Result entry gender 'M' in Singapore National Sailing Championships 2025 (Optimist Gold))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'ba485b02-3d8a-472c-b7f6-922bd692eebf' AND (gender IS NULL OR gender = '');

-- Ryan Sei (ryan-sei-safyc-history) -> M (Result entry gender 'M' in CSC Laser & 29er Open 2021 (ILCA 4))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '1454b040-3834-589e-8fc0-0a8e80a9f3d3' AND (gender IS NULL OR gender = '');

-- Sai Kit Tse (ilca4-hkg-sai-kit-tse-211740) -> M (Result entry gender 'M' in Singapore Youth Sailing Championships 2025 (ILCA 4))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887' AND (gender IS NULL OR gender = '');

-- Tom Griffiths (tom-griffiths-fd96wyi) -> M (Result entry gender 'M' in Singapore National Sailing Championships 2025 (Optimist Gold))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '30880421-1dc4-4a14-9c6b-8c00de39e4d8' AND (gender IS NULL OR gender = '');

-- Valentina Trevino (valentina-trevino-fdy9a7x) -> F (Result entry gender 'F' in Singapore National Sailing Championships 2025 (Optimist Gold))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '2d6309fb-f9af-4777-913d-f9dda49aaf76' AND (gender IS NULL OR gender = '');

-- Wang Tianyou (wang-tianyou-wg5es7g) -> M (Result entry gender 'M' in NSC 1 Silver (Dec 24))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '60b1447d-5e8f-4592-ac93-21d3363b4b48' AND (gender IS NULL OR gender = '');

-- Wang Yebin (wang-yebin-whjcf91) -> F (Result entry gender 'F' in NSC 1 Silver (Dec 24))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '63ce85aa-6f09-4391-bf5a-b00f2fdbe6f8' AND (gender IS NULL OR gender = '');

-- Wang Yian (wang-yian-wikhdmr) -> M (Result entry gender 'M' in NSC 1 Silver (Dec 24))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'bd2d3672-c1d6-4ba5-9d90-63cd3094edb6' AND (gender IS NULL OR gender = '');

-- Xuanye Chen (xuanye-chen-63izkoz) -> M (Result entry gender 'M' in Pesta Sukan Regatta 2025 (Optimist Silver))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'd0c77b8a-feb9-4b44-9483-59db4362ae43' AND (gender IS NULL OR gender = '');

-- Yilin Elaine Dong (ilca4-hkg-yilin-elaine-dong-211688) -> F (Result entry gender 'F' in Singapore Youth Sailing Championships 2025 (ILCA 4))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52' AND (gender IS NULL OR gender = '');

-- Zack Vaikath (zack-vaikath-safyc24) -> M (Result entry gender 'M' in CSC ILCA & 29er Championships 2024 (ILCA 4))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '3f94c0a6-68b4-4174-be0e-6ea460c2aeab' AND (gender IS NULL OR gender = '');

-- Zhuowen Sophie Shao (ilca4-hkg-zhuowen-sophie-shao-191718) -> F (Result entry gender 'F' in Singapore National Sailing Championships 2023 (Optimist Gold))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '51c49278-d004-470a-9cc5-4ca495ae17b7' AND (gender IS NULL OR gender = '');

-- ----------------------------------------------------------------------
-- Section 3: Audit Log Record
-- ----------------------------------------------------------------------
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.demographics_enrichment',
  'sailor',
  '00000000-0000-0000-0000-000000000000',
  'Demographic Enrichment Batch 2',
  'Enriched 126 sailor nationalities and 39 genders.',
  '{"nationalities_updated": 126, "genders_updated": 39}'::jsonb,
  'migration_151',
  clock_timestamp()
);

COMMIT;
