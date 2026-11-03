-- Migration 179: Import 2026 KSAF President's Cup National Youth Sailing Championships
-- (2026 대한요트협회장배(청소년) 전국요트대회)
-- Sanctioned and organized by the Korea Sailing Federation (KSAF / 대한요트협회)
-- Held at Seoul Water Leisure Sports Center, Hangang River, Seoul, South Korea (May 8-11, 2026)
-- Classes: Optimist (38), ILCA 4 (12), ILCA 6 (12), ILCA 7 (9), 420 (9 pairs), iQFoil (15)
-- 100% mathematically verified race scores, discards, and net totals.

BEGIN;

-- 1. Regatta Event Insert
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer,
    classes, nor_url, created_at, updated_at
) VALUES (
    '3eab275b-24b8-5e99-8c85-79df5829649a',
    '2026 KSAF President''s Cup National Youth Sailing Championships',
    'ksaf-presidents-cup-youth-nationals-2026',
    '2026-05-08',
    '2026-05-11',
    'Seoul Water Leisure Sports Center, Hangang River, Seoul, South Korea',
    'Korea Sailing Federation (대한요트협회 / KSAF)',
    '["optimist", "ILCA 4", "ILCA 6", "ILCA 7", "420", "iQFoil"]'::jsonb,
    'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    classes = EXCLUDED.classes,
    updated_at = clock_timestamp();

-- 2. Sailors Upsert
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '90b36217-ca95-4a90-b8f3-a502537842ab', 'Ashlea Tham Yan Shuang', 'ashlea-tham-yan-shuang-d97dc3', '175', 'Singapore Sailing Federation', 'SGP', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '156283b1-fac6-48ba-a530-bd5a78d77114', 'Ethan Chia Han Wei', 'ethan-chia-han-wei-c00136', '121', 'Singapore Sailing Federation', 'SGP', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a6f17bae-88f1-5370-b19d-c56e570449f6', 'Minyul Kang', 'minyul-kang-c27d8a', 'O571', '포남초등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '55396d27-0ef3-5d59-95b4-617aebe2ba31', 'Minha Kang', 'minha-kang-caa3e7', 'O578', '포남초등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '53b7939f-62de-5cb9-b87b-ba62072f9deb', 'Hyunwoo Kang', 'hyunwoo-kang-f7ae66', 'B7317', '현화고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6073f676-f634-50e1-a48b-d4768bef9ff6', 'Minseo Go', 'minseo-go-9b81f2', 'O583', '보성비봉마리나요트스포츠클럽', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '909d02a5-34df-5bff-891f-f9859541fe97', 'Dayeon Kim', 'dayeon-kim-ed8975', 'O478', '보령시요트스포츠클럽', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6399eec6-91f6-5873-95c7-cbd9608d1979', 'Dana Kim', 'dana-kim-daede2', 'O462', '여수공공스포츠클럽', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '969d699b-ac23-51dc-b1ac-00e7070595e1', 'Dohwan Kim', 'dohwan-kim-9bd0b9', 'O564', '장기중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '07894fb8-a2bc-5b17-9023-8b9030bd855b', 'Mingyu Kim', 'mingyu-kim-52ad25', 'B5522', '포항고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3f836035-f916-5df9-8b3f-3c3db9299b71', 'Minhu Kim', 'minhu-kim-dc4dd8', 'L4673', '포항고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6ce5e010-7a12-52a3-a859-b177972902ac', 'Baha Kim', 'baha-kim-b4c41d', 'O513', '부산주니어세일링클럽', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd0a7e399-5ee4-597a-a950-029e30c7c6bc', 'Sandeul Kim', 'sandeul-kim-1d82aa', 'O579', '율곡중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ed51d9cf-9d54-5b2d-81e2-244893a26957', 'Sunwoo Kim', 'sunwoo-kim-f42a50', 'Q356', '해강고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '65e15ab2-5157-51ad-85d8-9f12a42cdea8', 'Seyun Kim', 'seyun-kim-a6df8d', 'L2080', '여수고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '614aed23-b0ac-51bc-85bb-0f526dffe60c', 'Eunju Kim', 'eunju-kim-ad6b7e', 'R1038', '현화고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '006a707f-4ed4-5496-94d3-4046ca6b43bd', 'Jaehoon Kim', 'jaehoon-kim-d75bd2', 'B6338', '강릉문성고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7302a702-2b88-5d53-a946-0bd10f257f43', 'Jeongyeon Kim', 'jeongyeon-kim-f03be5', 'L8818', '강릉문성고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '297d4ae4-e6e4-523f-bbe1-86660370ad87', 'Jungwoo Kim', 'jungwoo-kim-4f3c5e', 'O519', '강릉초등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0d87c76a-54be-5d3d-acfe-8ce144c04ca1', 'Junmo Kim', 'junmo-kim-4ed046', 'A4680', '장기중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b42c9278-742b-5d1a-a60e-ec352f9c5f0b', 'Jian Kim', 'jian-kim-8a75fa', 'L9717', '동원고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3cb782c6-537a-5311-bf3f-99cea54f43a2', 'Jiwon Kim', 'jiwon-kim-d7d6c7', 'O574', '여수공공스포츠클럽', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e', 'Jihoo Kim', 'jihoo-kim-d93c28', 'O562', '중앙중학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f816db7a-a669-54ff-87d5-8f6c89e91439', 'Jihee Kim', 'jihee-kim-42dbf5', 'O533', '중앙중학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '589b14b6-5008-5a64-ad4c-5b893e9a92ff', 'Chaerin Kim', 'chaerin-kim-12e455', 'R5573', '전북베이커리고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fdc27789-fa73-57f3-889a-b6baf8711377', 'Chaewon Kim', 'chaewon-kim-8f6491', 'O552', '면온초등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '02a6f67c-b3be-5c22-bb14-f34af8fa4468', 'Chaeyoon Kim', 'chaeyoon-kim-accbd8', 'O502', 'PohangYachtClub', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9c0c85a6-95b5-5578-8743-f0491d93602f', 'Taerin Kim', 'taerin-kim-e5a6a0', 'B7263', '충남해양과학고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3e989539-35f1-5ad0-8c53-86191f5a6c16', 'Taeseok Kim', 'taeseok-kim-d67093', 'Q358', '전북베이커리고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1aa1d4b8-da4f-54ae-9af5-05a93c266c87', 'Taeyoon Kim', 'taeyoon-kim-fdb519', 'B7061', '동원고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '311a8261-7da7-5863-abcd-aa01baa52874', 'Taehee Kim', 'taehee-kim-1831c8', 'O400', '서생중학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e81fdf9a-f7b1-52e9-a930-f45bbc64d7a5', 'Hyunjae Kim', 'hyunjae-kim-db43c7', 'Q342', '동원고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c212fd0e-196b-572d-a188-ac4d7675e388', 'Hyorin Kim', 'hyorin-kim-fca200', 'O538', '장기중학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e862331e-b4f6-55e8-9a68-bd418a09d0f8', 'Yejun Nam', 'yejun-nam-441697', 'O520', '초당초등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4f07e11b-6571-5bb0-9ebc-9cc563ff792a', 'Dongwoo Ryu', 'dongwoo-ryu-2a7c90', 'B7633', '동원고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6c87b06c-4440-5a0c-a932-cbdefa4436f6', 'Hyunwoo Moon', 'hyunwoo-moon-f67426', 'Q375', '충남해양과학고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '641df9b4-7692-5a50-b293-786f33e29582', 'Seongbin Min', 'seongbin-min-365a6d', 'O532', '동원중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5c71a2fa-f1d9-4e55-9e7a-f3ace88044a3', 'Daol Park', 'daol-park-4d8c6a', 'O463', '보성비봉마리나요트스포츠클럽', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '81f7dac1-afaa-58e3-aee8-55002af74eed', 'Seonghee Park', 'seonghee-park-d63625', 'R2078', '부영여자고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bf7c461a-4dda-51b3-ba94-34a4d9ec8f73', 'Iruda Park', 'iruda-park-4c394f', 'A3840', '보성비봉마리나요트스포츠클럽', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '18d5835a-63bb-57e2-bc9e-357856d46310', 'Junsoo Park', 'junsoo-park-82cc80', 'R2952', '보성비봉마리나요트스포츠클럽', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2626c2a3-e937-5606-a38f-683128a5cf5d', 'Chanyul Park', 'chanyul-park-acf232', 'Q359', '해강중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ed96e55d-4d69-57f4-a1b8-5d3edb20cf0f', 'Hamin Park', 'hamin-park-cbae42', 'B7633', '동원고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd9f3075d-4b63-576d-b544-b7991dcaa603', 'Hayul Park', 'hayul-park-2a5d47', 'O474', '고덕함박초등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '933e48c3-26c8-5a72-8e69-3be06badaaad', 'Minwoo Bang', 'minwoo-bang-a79cd7', 'O475', '청파초등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a1a323c7-a3c7-53d4-a607-785ac6486dc7', 'Jihoon Bae', 'jihoon-bae-d28951', 'Q365', '여수고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6ad1338e-d664-5d54-9a7f-2b9fff1dd255', 'Gayeon Baek', 'gayeon-baek-6e75da', 'Q343', '해강고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2489ba3e-0f35-5218-9c00-35eb0a75a894', 'Minjun Seo', 'minjun-seo-187856', 'B5236', '보성비봉마리나요트스포츠클럽', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c653fec4-e7e6-5ea1-80ce-b78378290196', 'Seungjun Seo', 'seungjun-seo-4e9600', 'O584', '보성비봉마리나요트스포츠클럽', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd90e0657-29ef-5e28-b503-087e4eb9d103', 'Arim Seo', 'arim-seo-012988', 'O565', '포항이동중학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'cca4fc13-ba46-5ea5-a1fb-135b0a28f9aa', 'Irin Sung', 'irin-sung-03209c', 'A8075', '서울요트클럽', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '06a13acb-1638-50a4-a45b-05a6be56a480', 'Jeongwon So', 'jeongwon-so-afc051', 'Q364', '광남고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7aa738e9-eccd-519d-a72d-63593fc30e55', 'Siwoo Son', 'siwoo-son-353914', 'A5618', '서울요트클럽', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e5323bec-c571-506d-8bdc-4a61b55f480f', 'Yujin Son', 'yujin-son-f40489', 'B5522', '포항여자고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '48a62823-a8c0-5110-ab3b-35a1363380df', 'Minseo Song', 'minseo-song-8a5b07', 'R1044', '충남해양과학고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd86ac1bf-fcbc-54bc-892b-63b75a5ecdcc', 'Haeseo Song', 'haeseo-song-2ce23c', 'L2076', '여수고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '77fe64ce-78c6-57de-ae98-0284823bb995', 'Youngjun Shim', 'youngjun-shim-df7a62', 'O511', '동원중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '12c20a73-79f0-561c-8805-c6fe4afebbe2', 'Hajin Shim', 'hajin-shim-fb74f6', 'Q376', '보성비봉마리나요트스포츠클럽', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '40a23367-69df-42e3-8907-be4a7919fb4e', 'Seoyi An', 'seoyi-an-f36367', 'A5363', '율곡중학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '50acb7b9-4896-454d-83a8-9c2dc2e1ed2b', 'Siyeon An', 'siyeon-an-feb7df', 'O589', '율곡중학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5323ee8f-c8cb-557e-9f7c-a3b2b812c1a7', 'Haeun An', 'haeun-an-6cae5b', 'O401', '서생중학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f6f97b49-c55b-511b-b4f2-59ec89c45dfd', 'Dayeon Yang', 'dayeon-yang-02a86c', 'R4349', '강릉문성고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7b8ecdf3-6c9d-553e-9ff5-3e57eb0a46b8', 'Seungwoo Oh', 'seungwoo-oh-3c31bb', 'O479', '현화중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '875b9a65-f63f-5eab-9c35-827c98e4679d', 'Seunghun Oh', 'seunghun-oh-3a1828', 'O591', '현화중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f436984f-1cac-551f-ad5d-230a79f84173', 'Yoon Oh', 'yoon-oh-b83756', 'O577', '인천광역시요트협회', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '68a6d815-84df-533f-8539-02fb4a93f3b0', 'A-in Won', 'a-in-won-ba6bf1', 'O568', '현화중학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3b9f6c7a-40dd-598a-b297-eb8258252fee', 'Gaon Yoo', 'gaon-yoo-a455dd', 'O144', '숲실초등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2e113407-8fa8-53d2-98a4-2c53d3ed524b', 'Seobin Yoo', 'seobin-yoo-081b4e', 'O505', 'PohangYachtClub', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7ee0b8e9-a533-55b6-9d84-f329e3ca4819', 'Jaemin Yoo', 'jaemin-yoo-a4030e', 'Q346', '현화고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '20f258f8-799b-57d0-90d0-1c6d1cf76505', 'Jihyeok Yoo', 'jihyeok-yoo-7a3db7', 'Q347', '현화중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'cb88ac82-b4e7-5945-b345-fbe3d2b33745', 'Jiho Yoo', 'jiho-yoo-e1e708', 'Q348', '현화중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a2c367fd-110a-5da1-94e6-ca3e7228712d', 'Hyunji Yoo', 'hyunji-yoo-6292ff', 'A6472', '서생중학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1e708b51-d534-50db-9704-50e75dc9e016', 'Minsang Yoon', 'minsang-yoon-9efc94', 'B7317', '현화고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '494ea92f-06f2-5fbd-98ee-7e1bd445d2c1', 'Taeyang Yoon', 'taeyang-yoon-cdd688', 'R7988', '신목고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd3bdd575-51a9-46c8-8b02-b254b18b100d', 'Songha Lee', 'songha-lee-2d15de', 'A0006', '강릉문성고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c43c92c7-4890-5d5d-9f9e-b938fc455ad6', 'Soomin Lee', 'soomin-lee-80d19d', 'A2951', '동원고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9f9b8891-c4ea-556c-a816-c4e421ef258e', 'Joshua Lee', 'joshua-lee-adeae7', 'O587', '후포중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'eb4e503b-fd7a-5a05-bd7a-3908567eab8f', 'Yeji Lee', 'yeji-lee-ed44bd', 'B6338', '강릉문성고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5f0599cb-4ec2-5bfa-bf38-aa408971c70e', 'Changjeong Lee', 'changjeong-lee-3520f0', 'L2077', '보령시요트스포츠클럽', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '16dadfda-5198-534a-a0f4-232c47a23b59', 'Taeo Lee', 'taeo-lee-db2b83', 'A0133', '서울수상레포츠센터', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd456f933-1422-5605-b2eb-d3121e7e932f', 'Hyunbin Lee', 'hyunbin-lee-6a8e93', 'O566', '전북요트협회', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a41bf47a-883a-577e-9493-e7fb8bfebf96', 'Hyein Lee', 'hyein-lee-016573', 'Q357', '후포고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd5950089-a98b-528b-83d6-3582f48dacb9', 'Woojun Lim', 'woojun-lim-93f26f', 'L6910', '보성비봉마리나요트스포츠클럽', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '14fe3b82-94ea-56e4-a9ee-4b783aa82a58', 'Chayun Lim', 'chayun-lim-bb6e95', 'R5056', '전북베이커리고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd18a63e1-9764-55a9-a664-ee3363093cab', 'Hyeok Lim', 'hyeok-lim-10fb5b', 'O457', '청파초등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ebc54a7f-d9ff-597a-8bed-78b8a7667b32', 'Hyundo Jang', 'hyundo-jang-a25506', 'R9165', '후포고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'cbe7bbbc-52f2-53ca-b5f4-ad6ae2d538a7', 'Minsol Jeon', 'minsol-jeon-852a3e', 'R8141', '강릉문성고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '190686bb-516d-43ec-a519-b0158e48f963', 'Hyunwoo Jeon', 'hyunwoo-jeon-29dff3', 'A5619', '율곡중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '03c8a506-8bf4-52b0-abe8-1909b707d95f', 'Sia Jung', 'sia-jung-1ddf85', 'Q355', '율곡중학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '86f5a930-4f9a-5f9e-b24d-6389c66465f0', 'Jihyeok Jung', 'jihyeok-jung-ece9ca', 'B5236', '보성비봉마리나요트스포츠클럽', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4a0c6b2c-f3bb-5744-88a2-c11838bff08b', 'Hyunwoo Jung', 'hyunwoo-jung-710487', 'R6512', '청담고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '762f5777-88d4-5d5d-b10a-7e530b9de461', 'Wonjun Cho', 'wonjun-cho-48d88b', 'A1954', '인천광역시요트협회', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0de245e7-525c-5ac9-ab89-9eea812f5b04', 'Jaemin Cho', 'jaemin-cho-2e8de1', 'A6471', '영등포구요트협회', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ecbc3b3f-489f-5177-b240-1b7b4976360f', 'Sihoon Joo', 'sihoon-joo-9e2c1d', 'O572', '율곡중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '250182ae-9801-5596-877f-adfaf2585d07', 'Gaeun Choi', 'gaeun-choi-844ea1', 'B7263', '충남해양과학고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7230e023-0c19-5215-b2ad-eeaaf22361de', 'Soyoon Choi', 'soyoon-choi-b4352a', 'B6677', '전북베이커리고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bd4ab586-80f4-4c5e-81c0-d2a069d773ed', 'Unho Choi', 'unho-choi-737e31', 'O523', '여수공공스포츠클럽', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c3b6da21-0901-5707-ba5f-2a793b2bbece', 'Juyoung Choi', 'juyoung-choi-29c32d', 'O516', '해운대중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '079c881f-4633-528b-9557-64ecb31de251', 'Junhwan Choi', 'junhwan-choi-6cbd95', 'Q362', '해강고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5590ae28-9ad5-580b-8b62-f4cd0b6b1c93', 'Nara Han', 'nara-han-71f85f', 'L3204', '강릉문성고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5264ce32-f38f-507a-8d4b-e4757f4b2e64', 'Jun Han', 'jun-han-66f4e9', 'L9715', '대구체육고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5f2f7947-57b4-41ba-b642-ed27263d0e05', 'Mingyu Hong', 'mingyu-hong-00f9f8', 'B7061', '동원고등학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '691c0dfb-32c6-5f83-9373-5b18473000c0', 'Jihwang Hong', 'jihwang-hong-a4a3f2', 'R0007', '서생중학교', 'KOR', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '746ae16d-2826-50c6-ac71-1ec9e139a0e2', 'Jaeyoon Hwang', 'jaeyoon-hwang-d08efe', 'B6677', '전북베이커리고등학교', 'KOR', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = COALESCE(NULLIF(EXCLUDED.club, ''), public.sailors.club),
    sail_number = CASE WHEN public.sailors.sail_number IS NULL OR public.sailors.sail_number = '' THEN EXCLUDED.sail_number ELSE public.sailors.sail_number END,
    updated_at = clock_timestamp();

-- 3. Regattas & Results Upsert

INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '5bed362b-6ab7-5fbd-895c-38c101845b78',
    '3eab275b-24b8-5e99-8c85-79df5829649a',
    '2026 KSAF President''s Cup National Youth Sailing Championships — Optimist',
    'ksaf-presidents-cup-youth-nationals-2026-optimist',
    '2026-05-08',
    '2026-05-11',
    38,
    'Open',
    8,
    'KOR',
    'optimist',
    'individual',
    1,
    1,
    false,
    'Seoul Water Leisure Sports Center, Hangang River, Seoul, South Korea',
    'Korea Sailing Federation (대한요트협회 / KSAF)',
    'published',
    'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf',
    '2026 대한요트협회장배(청소년) 전국요트대회 — optimist Open. Official KSAF Final Results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '5497cb92-1bbc-51c8-b282-1de4021b7923', '5c71a2fa-f1d9-4e55-9e7a-f3ace88044a3', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Daol Park', 'O463', 'individual', 1,
    54.0, 34.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4c303a5d-114c-581b-960c-e6d8e75bcbc5', '5497cb92-1bbc-51c8-b282-1de4021b7923', '5c71a2fa-f1d9-4e55-9e7a-f3ace88044a3', 'Daol Park', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '74e742e0-ffd2-56fc-802a-c809a48d84ab', '5497cb92-1bbc-51c8-b282-1de4021b7923', 1, 4.0, NULL, false, '4 트스포', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '70b0d35b-75b1-58be-b22f-d8319be269f9', '5497cb92-1bbc-51c8-b282-1de4021b7923', 2, 5.0, NULL, false, '5 츠클', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '362b106e-640d-5e1e-a7fe-4cc8bea04aec', '5497cb92-1bbc-51c8-b282-1de4021b7923', 3, 4.0, NULL, false, '4 럽', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f16a4b73-f53c-5722-bc29-a9dfe73024ad', '5497cb92-1bbc-51c8-b282-1de4021b7923', 4, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '598fb92e-fa53-56c9-9525-7c29ff97fd16', '5497cb92-1bbc-51c8-b282-1de4021b7923', 5, 20.0, NULL, true, '(20)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '51a59f22-a95d-5cb5-a742-881b5d1b0b34', '5497cb92-1bbc-51c8-b282-1de4021b7923', 6, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '777cb7a2-d0bf-5826-94a1-664986a4f377', '5497cb92-1bbc-51c8-b282-1de4021b7923', 7, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5f666eb2-48bc-55bb-8156-e206ae82214e', '5497cb92-1bbc-51c8-b282-1de4021b7923', 8, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '1025a22c-3f1b-52f6-bcfb-115b5e8d8a41', '50acb7b9-4896-454d-83a8-9c2dc2e1ed2b', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Siyeon An', 'O589', 'individual', 2,
    49.0, 38.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '15483b51-198e-5636-b23d-7c3bd8f2dccf', '1025a22c-3f1b-52f6-bcfb-115b5e8d8a41', '50acb7b9-4896-454d-83a8-9c2dc2e1ed2b', 'Siyeon An', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ffc9bfd0-6016-5c7b-85eb-05a19b1c2a8d', '1025a22c-3f1b-52f6-bcfb-115b5e8d8a41', 1, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6ad08232-0037-5d87-83f0-421a49c63a56', '1025a22c-3f1b-52f6-bcfb-115b5e8d8a41', 2, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '48a244b2-d0bf-59ef-8885-aaec26b61164', '1025a22c-3f1b-52f6-bcfb-115b5e8d8a41', 3, 11.0, NULL, true, '(11)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '71770e40-440b-5818-ad45-ae157e6d4132', '1025a22c-3f1b-52f6-bcfb-115b5e8d8a41', 4, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b738eefe-73c5-56bb-a037-de9427d9f028', '1025a22c-3f1b-52f6-bcfb-115b5e8d8a41', 5, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd5a1c89f-456d-5451-a024-5841106da4f3', '1025a22c-3f1b-52f6-bcfb-115b5e8d8a41', 6, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f415bb30-5f32-506c-88a2-03b48efb035a', '1025a22c-3f1b-52f6-bcfb-115b5e8d8a41', 7, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f523165b-768d-587e-96fc-e06acc37a930', '1025a22c-3f1b-52f6-bcfb-115b5e8d8a41', 8, 8.0, 'SCP', false, '6+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '7fc585a5-5ee2-51b0-aa68-d1aaf88374b1', 'c653fec4-e7e6-5ea1-80ce-b78378290196', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Seungjun Seo', 'O584', 'individual', 3,
    80.0, 41.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '927d7878-051d-5b8d-b497-7fe1b5fdfbd9', '7fc585a5-5ee2-51b0-aa68-d1aaf88374b1', 'c653fec4-e7e6-5ea1-80ce-b78378290196', 'Seungjun Seo', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a01c3b66-2bde-5ede-ae7b-83fb996196bb', '7fc585a5-5ee2-51b0-aa68-d1aaf88374b1', 1, 39.0, 'DNC', true, '(39) 트스포 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c979e694-3631-5417-b433-81b4d3245fd9', '7fc585a5-5ee2-51b0-aa68-d1aaf88374b1', 2, 2.0, NULL, false, '2 츠클', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e8eebe1d-9bd1-503f-837e-6a4c31e22178', '7fc585a5-5ee2-51b0-aa68-d1aaf88374b1', 3, 9.0, NULL, false, '9 럽', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '026dd95e-3f95-5ead-98f7-367ef65b9f94', '7fc585a5-5ee2-51b0-aa68-d1aaf88374b1', 4, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '092a26b7-232e-5d4e-9039-4940858ad887', '7fc585a5-5ee2-51b0-aa68-d1aaf88374b1', 5, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a41a9fe5-b680-54a4-a149-393424748db0', '7fc585a5-5ee2-51b0-aa68-d1aaf88374b1', 6, 15.0, NULL, false, '15', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '574940b7-9d1b-5027-8770-33d887211132', '7fc585a5-5ee2-51b0-aa68-d1aaf88374b1', 7, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8ea24b87-ae84-51ab-bcee-d2ba4f07222b', '7fc585a5-5ee2-51b0-aa68-d1aaf88374b1', 8, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'b9d2f981-77f5-5e9a-80dd-aaafefc70962', 'bd4ab586-80f4-4c5e-81c0-d2a069d773ed', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Unho Choi', 'O523', 'individual', 4,
    68.0, 49.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0d6b6b95-4d7f-58d4-ae63-69f392b474cf', 'b9d2f981-77f5-5e9a-80dd-aaafefc70962', 'bd4ab586-80f4-4c5e-81c0-d2a069d773ed', 'Unho Choi', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5b4f0b9e-a8c7-533b-8e4f-03a9d309006d', 'b9d2f981-77f5-5e9a-80dd-aaafefc70962', 1, 2.0, NULL, false, '2 럽', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'cb2a5eb3-36f1-53a8-9acb-f5b1f52a6570', 'b9d2f981-77f5-5e9a-80dd-aaafefc70962', 2, 12.0, NULL, false, '12', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e0ec515f-c88f-55da-aa5f-43c0daeff606', 'b9d2f981-77f5-5e9a-80dd-aaafefc70962', 3, 18.0, NULL, false, '18', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ba0b38a1-4b16-513f-b9fa-b395e7caef35', 'b9d2f981-77f5-5e9a-80dd-aaafefc70962', 4, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5d3b1cd0-20cb-5f48-a826-0ea3a816c0e4', 'b9d2f981-77f5-5e9a-80dd-aaafefc70962', 5, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9457d50f-0415-590c-997d-330ede8bae1d', 'b9d2f981-77f5-5e9a-80dd-aaafefc70962', 6, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'cb866b5a-fc33-57ee-a061-ffdaa82f5bed', 'b9d2f981-77f5-5e9a-80dd-aaafefc70962', 7, 19.0, NULL, true, '(19)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4e8944b4-9387-56bc-8d03-be857d066c44', 'b9d2f981-77f5-5e9a-80dd-aaafefc70962', 8, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '92f84704-ddb9-567d-8646-a678712355e3', '933e48c3-26c8-5a72-8e69-3be06badaaad', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Minwoo Bang', 'O475', 'individual', 5,
    71.0, 54.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd721ce5c-3a6d-54f2-9bb1-47fa9957d3a0', '92f84704-ddb9-567d-8646-a678712355e3', '933e48c3-26c8-5a72-8e69-3be06badaaad', 'Minwoo Bang', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e3c055fd-acf4-5e99-a472-7323b77135de', '92f84704-ddb9-567d-8646-a678712355e3', 1, 14.0, NULL, false, '14', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0a1cd25c-0f80-539b-bf93-508b9f1a6a39', '92f84704-ddb9-567d-8646-a678712355e3', 2, 13.0, NULL, false, '13', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2e7725bb-5182-5edf-9aa4-322c2df15fdf', '92f84704-ddb9-567d-8646-a678712355e3', 3, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f7dfea71-a537-5904-abd6-93440d47c54d', '92f84704-ddb9-567d-8646-a678712355e3', 4, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4d4a6f23-5db6-5077-b3c3-0e17a99d6286', '92f84704-ddb9-567d-8646-a678712355e3', 5, 17.0, NULL, true, '(17)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4451931f-385b-5e09-a39d-d95cdc14e084', '92f84704-ddb9-567d-8646-a678712355e3', 6, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '599255e3-1c4c-597e-b805-5422b94a01f8', '92f84704-ddb9-567d-8646-a678712355e3', 7, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a0a7ea7e-4de9-59a2-85c4-853dbeb75bc2', '92f84704-ddb9-567d-8646-a678712355e3', 8, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '8ce2d7ef-b985-517e-b117-aa55e604daeb', '969d699b-ac23-51dc-b1ac-00e7070595e1', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Dohwan Kim', 'O564', 'individual', 6,
    75.0, 57.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '997f3b14-4e2d-51e0-90a6-d2d64a2c8dd5', '8ce2d7ef-b985-517e-b117-aa55e604daeb', '969d699b-ac23-51dc-b1ac-00e7070595e1', 'Dohwan Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8ec1b256-a604-539a-89e3-8fc4aefbb330', '8ce2d7ef-b985-517e-b117-aa55e604daeb', 1, 17.0, NULL, false, '17', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ca668851-fddb-5116-87c3-b79695aadcd7', '8ce2d7ef-b985-517e-b117-aa55e604daeb', 2, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '50ae94e2-c1cf-585b-a0ab-1152788fb2ab', '8ce2d7ef-b985-517e-b117-aa55e604daeb', 3, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a7d85f0c-f20d-5606-aa6e-1a3faa3c4e8f', '8ce2d7ef-b985-517e-b117-aa55e604daeb', 4, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '915efeff-36a1-5766-9148-17d4488c1aab', '8ce2d7ef-b985-517e-b117-aa55e604daeb', 5, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7c70e808-cdd2-5adf-a831-a6382190c20d', '8ce2d7ef-b985-517e-b117-aa55e604daeb', 6, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f55d5160-a68b-58d5-94cc-2391aedfc413', '8ce2d7ef-b985-517e-b117-aa55e604daeb', 7, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c51d35dc-7ea6-553f-a7d0-74525c8a005c', '8ce2d7ef-b985-517e-b117-aa55e604daeb', 8, 18.0, NULL, true, '(18)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '2b2c8ee3-c9e9-5d2e-a5df-9d94f76a6d72', '6073f676-f634-50e1-a48b-d4768bef9ff6', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Minseo Go', 'O583', 'individual', 7,
    79.0, 58.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'aa0a25ed-5369-5787-a102-82abcf4cc5b7', '2b2c8ee3-c9e9-5d2e-a5df-9d94f76a6d72', '6073f676-f634-50e1-a48b-d4768bef9ff6', 'Minseo Go', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd36e1262-760c-5121-ae25-6bb9ac8f109c', '2b2c8ee3-c9e9-5d2e-a5df-9d94f76a6d72', 1, 1.0, NULL, false, '1 트스포', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '688cd665-3f53-54ed-8bd0-47041c6a4aa3', '2b2c8ee3-c9e9-5d2e-a5df-9d94f76a6d72', 2, 3.0, NULL, false, '3 츠클', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '79fc57fe-1c9e-5e69-89bd-560f41aefc2a', '2b2c8ee3-c9e9-5d2e-a5df-9d94f76a6d72', 3, 21.0, NULL, true, '(21) 럽', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '29a956be-dce6-5261-9b7f-4d4561d7cb41', '2b2c8ee3-c9e9-5d2e-a5df-9d94f76a6d72', 4, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0b01da2d-3f6d-59e6-9f59-222513b5d08f', '2b2c8ee3-c9e9-5d2e-a5df-9d94f76a6d72', 5, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'db47d440-4d9d-59a7-bd48-110f6380d9d5', '2b2c8ee3-c9e9-5d2e-a5df-9d94f76a6d72', 6, 14.0, NULL, false, '14', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd535fe40-4c11-58a2-ba18-e214ec8eab74', '2b2c8ee3-c9e9-5d2e-a5df-9d94f76a6d72', 7, 14.0, NULL, false, '14', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5e949079-914b-5d06-a8e1-da5a26b0948a', '2b2c8ee3-c9e9-5d2e-a5df-9d94f76a6d72', 8, 12.0, NULL, false, '12', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '25858756-d8ef-5063-a267-0268bd2baa82', '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Jihoo Kim', 'O562', 'individual', 8,
    86.0, 67.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0a9d9215-cedf-5026-b73f-1b3bd13af3a1', '25858756-d8ef-5063-a267-0268bd2baa82', '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e', 'Jihoo Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ef56c41c-7351-56a6-becf-69ea0171d440', '25858756-d8ef-5063-a267-0268bd2baa82', 1, 19.0, NULL, true, '(19)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3b45dfa2-1f77-592d-a4e0-04dcccd5d7ed', '25858756-d8ef-5063-a267-0268bd2baa82', 2, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '62046542-ab5c-588b-b6c0-d0afe9f43260', '25858756-d8ef-5063-a267-0268bd2baa82', 3, 15.0, NULL, false, '15', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'dc12adfb-e4bc-5af5-9b5a-043ddbcade10', '25858756-d8ef-5063-a267-0268bd2baa82', 4, 16.0, NULL, false, '16', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f929e81c-651b-5a88-8ca2-9772cc5a9fd6', '25858756-d8ef-5063-a267-0268bd2baa82', 5, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a5b1e8d9-f9e4-59b8-83e3-87b9491f5612', '25858756-d8ef-5063-a267-0268bd2baa82', 6, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e06d939a-ff0f-54af-8e6a-a6614c95d906', '25858756-d8ef-5063-a267-0268bd2baa82', 7, 17.0, NULL, false, '17', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '01a32c5b-9d4b-5756-909c-b6efb6db8cc6', '25858756-d8ef-5063-a267-0268bd2baa82', 8, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '9e2fd3f0-d48d-5d85-9f5e-1b6af4d46107', 'f816db7a-a669-54ff-87d5-8f6c89e91439', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Jihee Kim', 'O533', 'individual', 9,
    100.0, 68.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd85499cc-406c-5d4b-8802-c3685bbf5dc4', '9e2fd3f0-d48d-5d85-9f5e-1b6af4d46107', 'f816db7a-a669-54ff-87d5-8f6c89e91439', 'Jihee Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '01ec53e3-919a-5784-b393-4770711755d0', '9e2fd3f0-d48d-5d85-9f5e-1b6af4d46107', 1, 18.0, NULL, false, '18', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '16366b98-cd9d-5f25-b460-599a3da56576', '9e2fd3f0-d48d-5d85-9f5e-1b6af4d46107', 2, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '70b0f3a4-a41b-5292-95b7-0f2fdb5e5092', '9e2fd3f0-d48d-5d85-9f5e-1b6af4d46107', 3, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '21c06edb-90c1-57ab-8a9c-08206b96c4dd', '9e2fd3f0-d48d-5d85-9f5e-1b6af4d46107', 4, 20.0, NULL, false, '20', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4b56b6ad-defe-5c65-8f35-abe92127da5a', '9e2fd3f0-d48d-5d85-9f5e-1b6af4d46107', 5, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ba9ea16c-faad-5707-9265-c68865f2d870', '9e2fd3f0-d48d-5d85-9f5e-1b6af4d46107', 6, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '23f8b73b-cc1c-53b0-ae8a-ab05878e1a1b', '9e2fd3f0-d48d-5d85-9f5e-1b6af4d46107', 7, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '389c9909-9d9f-50d8-86fc-f6538a380fe4', '9e2fd3f0-d48d-5d85-9f5e-1b6af4d46107', 8, 32.0, NULL, true, '(32)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '7c4b119c-4808-5794-bf32-bf45738b8eb1', '68a6d815-84df-533f-8539-02fb4a93f3b0', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'A-in Won', 'O568', 'individual', 10,
    109.0, 70.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0e8a3700-4501-5956-96cb-ce8ba20e1595', '7c4b119c-4808-5794-bf32-bf45738b8eb1', '68a6d815-84df-533f-8539-02fb4a93f3b0', 'A-in Won', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1fdbf9e9-53e2-5a75-ad1d-2df0daefb0a0', '7c4b119c-4808-5794-bf32-bf45738b8eb1', 1, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'be3fff0b-a661-5543-ac80-2178e7523b0b', '7c4b119c-4808-5794-bf32-bf45738b8eb1', 2, 15.0, NULL, false, '15', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '516cb443-602c-55d4-8c33-9535efe889cd', '7c4b119c-4808-5794-bf32-bf45738b8eb1', 3, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd0ed33ef-e360-5158-bcf9-e256dc5f58aa', '7c4b119c-4808-5794-bf32-bf45738b8eb1', 4, 15.0, NULL, false, '15', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fd885de1-fe4d-576e-a76c-ad1355ef3ebb', '7c4b119c-4808-5794-bf32-bf45738b8eb1', 5, 16.0, NULL, false, '16', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd77e6f12-d426-563c-8931-e18a34e732f2', '7c4b119c-4808-5794-bf32-bf45738b8eb1', 6, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7e7e3971-2056-5242-918e-684430990d6a', '7c4b119c-4808-5794-bf32-bf45738b8eb1', 7, 39.0, 'UFD', true, '(39) UFD', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7cfb5389-6f2d-5a99-8fb1-b3716f2e63ca', '7c4b119c-4808-5794-bf32-bf45738b8eb1', 8, 15.0, NULL, false, '15', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'c5beb2bb-5464-5a8c-8cb2-21a98f151976', '02a6f67c-b3be-5c22-bb14-f34af8fa4468', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Chaeyoon Kim', 'O502', 'individual', 11,
    103.0, 77.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b6d44c53-5a50-595b-bc23-f988bbcff08e', 'c5beb2bb-5464-5a8c-8cb2-21a98f151976', '02a6f67c-b3be-5c22-bb14-f34af8fa4468', 'Chaeyoon Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0dd1142d-3aea-5eaa-8db7-6459b9c6cc85', 'c5beb2bb-5464-5a8c-8cb2-21a98f151976', 1, 12.0, NULL, false, '12 5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '99c3e3b5-d776-5d43-8e36-79662f6b99b7', 'c5beb2bb-5464-5a8c-8cb2-21a98f151976', 2, 14.0, NULL, false, '14', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9b8f6cdd-56a1-5356-a8b0-8228a9936f50', 'c5beb2bb-5464-5a8c-8cb2-21a98f151976', 3, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '29e4aeae-c406-57aa-80fd-f6e3b7916d33', 'c5beb2bb-5464-5a8c-8cb2-21a98f151976', 4, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b04fa92d-ca88-5a9c-9b34-1f2631f0dd90', 'c5beb2bb-5464-5a8c-8cb2-21a98f151976', 5, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fdd721db-8da7-5f7d-bae7-57eb70afbc66', 'c5beb2bb-5464-5a8c-8cb2-21a98f151976', 6, 26.0, NULL, true, '(26)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9772af87-44cf-5341-8dc8-c1745d554f5b', 'c5beb2bb-5464-5a8c-8cb2-21a98f151976', 7, 15.0, NULL, false, '15', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd681df62-4266-523e-8bc2-f2079be0fd57', 'c5beb2bb-5464-5a8c-8cb2-21a98f151976', 8, 20.0, NULL, false, '20', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'd943814d-f814-5c2e-9067-e5843d77768c', '9f9b8891-c4ea-556c-a816-c4e421ef258e', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Joshua Lee', 'O587', 'individual', 12,
    117.0, 78.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bf9820b8-6475-5a7b-a88d-a893002a4c7f', 'd943814d-f814-5c2e-9067-e5843d77768c', '9f9b8891-c4ea-556c-a816-c4e421ef258e', 'Joshua Lee', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '46dc2194-1696-5de0-a18f-efa96e56b9a2', 'd943814d-f814-5c2e-9067-e5843d77768c', 1, 39.0, 'DNF', true, '(39) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'edfcd04b-6a8f-5cd0-8c01-0641fc463414', 'd943814d-f814-5c2e-9067-e5843d77768c', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '05e8141a-8fba-5e52-981b-6991842fbc71', 'd943814d-f814-5c2e-9067-e5843d77768c', 3, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2905c925-16f6-58cf-b07c-f2384fafb0d2', 'd943814d-f814-5c2e-9067-e5843d77768c', 4, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '93cfe415-0dfb-5b9b-a6f6-b88570ee4874', 'd943814d-f814-5c2e-9067-e5843d77768c', 5, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9395ed10-b289-54b1-867a-2eade6e64efb', 'd943814d-f814-5c2e-9067-e5843d77768c', 6, 12.0, NULL, false, '12', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9a9234eb-f1ed-56d9-aee9-4f6e48d0e329', 'd943814d-f814-5c2e-9067-e5843d77768c', 7, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '757d13a3-72e6-5a92-829b-14c1a82cde34', 'd943814d-f814-5c2e-9067-e5843d77768c', 8, 3.0, 'SCP', false, '1+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '12b3febb-3515-5ca4-9f33-7bbd7f0d7167', '875b9a65-f63f-5eab-9c35-827c98e4679d', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Seunghun Oh', 'O591', 'individual', 13,
    99.0, 78.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e715bfe6-2a9f-5b5b-ade5-b7eb023cd3fc', '12b3febb-3515-5ca4-9f33-7bbd7f0d7167', '875b9a65-f63f-5eab-9c35-827c98e4679d', 'Seunghun Oh', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9a3d6130-78e1-5bf3-9d61-dee63d42638c', '12b3febb-3515-5ca4-9f33-7bbd7f0d7167', 1, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fccfb691-2251-54ae-b249-266296fecafe', '12b3febb-3515-5ca4-9f33-7bbd7f0d7167', 2, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ed57f14f-a273-556e-8533-8e06671c14e3', '12b3febb-3515-5ca4-9f33-7bbd7f0d7167', 3, 13.0, NULL, false, '13', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b0eacdb8-dc50-5465-891f-d3644ffdbd4a', '12b3febb-3515-5ca4-9f33-7bbd7f0d7167', 4, 21.0, NULL, true, '(21)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '907f55c9-63fe-5988-9119-c5ba0a264e1d', '12b3febb-3515-5ca4-9f33-7bbd7f0d7167', 5, 15.0, NULL, false, '15', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd6729464-eb88-5118-b304-afff10ac94e2', '12b3febb-3515-5ca4-9f33-7bbd7f0d7167', 6, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e78a346c-4074-5e91-b2de-9da0bd39bc98', '12b3febb-3515-5ca4-9f33-7bbd7f0d7167', 7, 12.0, NULL, false, '12', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '65df852d-e934-5335-b54a-0abd74ad1778', '12b3febb-3515-5ca4-9f33-7bbd7f0d7167', 8, 14.0, NULL, false, '14', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'c94cad8a-d9c3-5db2-90a8-380c57db5167', '55396d27-0ef3-5d59-95b4-617aebe2ba31', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Minha Kang', 'O578', 'individual', 14,
    105.0, 79.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '30de37c7-7f9c-5a06-ac29-e93c581b5f8e', 'c94cad8a-d9c3-5db2-90a8-380c57db5167', '55396d27-0ef3-5d59-95b4-617aebe2ba31', 'Minha Kang', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '20a3f0c4-19bc-5cd1-8e1a-17394042948d', 'c94cad8a-d9c3-5db2-90a8-380c57db5167', 1, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '49f09b7a-5d6e-5fa1-b75e-fd3b01213f93', 'c94cad8a-d9c3-5db2-90a8-380c57db5167', 2, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4be6868e-09de-5b6c-91f0-46a0a49f0db2', 'c94cad8a-d9c3-5db2-90a8-380c57db5167', 3, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a6f38a22-f9ae-5aea-b847-59b85a96acbb', 'c94cad8a-d9c3-5db2-90a8-380c57db5167', 4, 18.0, NULL, false, '18', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'bef9bb95-da24-5524-a948-1f9835654a78', 'c94cad8a-d9c3-5db2-90a8-380c57db5167', 5, 26.0, NULL, true, '(26)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7a3c90f4-5d35-5367-b22e-882dbd92c1f5', 'c94cad8a-d9c3-5db2-90a8-380c57db5167', 6, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd89301f2-6418-5836-8b0e-80f6d25b181f', 'c94cad8a-d9c3-5db2-90a8-380c57db5167', 7, 21.0, NULL, false, '21', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b3975816-56db-562b-8556-179e59081717', 'c94cad8a-d9c3-5db2-90a8-380c57db5167', 8, 13.0, NULL, false, '13', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'cca7bc7f-5871-5acb-978e-e8d9b6dd1bcc', 'c212fd0e-196b-572d-a188-ac4d7675e388', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Hyorin Kim', 'O538', 'individual', 15,
    104.0, 80.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd545e5e8-4299-539e-8ed3-0cecd45cc9de', 'cca7bc7f-5871-5acb-978e-e8d9b6dd1bcc', 'c212fd0e-196b-572d-a188-ac4d7675e388', 'Hyorin Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8d367728-732e-5c7f-85cf-0d23aa9a02e4', 'cca7bc7f-5871-5acb-978e-e8d9b6dd1bcc', 1, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b9a5cc4d-6af4-5e5c-a10b-32a0f1116e69', 'cca7bc7f-5871-5acb-978e-e8d9b6dd1bcc', 2, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '69c857d8-788c-5954-a204-62fc813ed5d4', 'cca7bc7f-5871-5acb-978e-e8d9b6dd1bcc', 3, 17.0, NULL, false, '17', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '46455784-fddb-5fb2-9694-b60f0243cb43', 'cca7bc7f-5871-5acb-978e-e8d9b6dd1bcc', 4, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a9cdcd79-aecb-5f96-bdbf-24e1d09b54de', 'cca7bc7f-5871-5acb-978e-e8d9b6dd1bcc', 5, 24.0, NULL, true, '(24)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1f9a00dd-15fc-556c-9567-03f600ef35f7', 'cca7bc7f-5871-5acb-978e-e8d9b6dd1bcc', 6, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f9e848bc-7246-5f42-8570-5b10086b5c41', 'cca7bc7f-5871-5acb-978e-e8d9b6dd1bcc', 7, 20.0, NULL, false, '20', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8d207f53-67c4-5d3e-a54c-e9b7913bb254', 'cca7bc7f-5871-5acb-978e-e8d9b6dd1bcc', 8, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '42a3507f-c352-54e0-b8fa-8d9cda594d2e', '3cb782c6-537a-5311-bf3f-99cea54f43a2', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Jiwon Kim', 'O574', 'individual', 16,
    131.0, 92.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '24499684-e82f-5678-a48f-dd72289812de', '42a3507f-c352-54e0-b8fa-8d9cda594d2e', '3cb782c6-537a-5311-bf3f-99cea54f43a2', 'Jiwon Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '45a49413-e0ff-575f-9773-b4b830bba28a', '42a3507f-c352-54e0-b8fa-8d9cda594d2e', 1, 39.0, 'DNF', true, '(39) 럽 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '27a4c850-b4ed-5cfd-a231-b5b8f2254570', '42a3507f-c352-54e0-b8fa-8d9cda594d2e', 2, 16.0, NULL, false, '16', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f14fee2d-dd53-5d15-af4a-aa2c60f07ae3', '42a3507f-c352-54e0-b8fa-8d9cda594d2e', 3, 20.0, NULL, false, '20', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5219c3a1-de3d-52d3-9d91-c619dee65116', '42a3507f-c352-54e0-b8fa-8d9cda594d2e', 4, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c5cfe89d-fd13-540a-9090-e644e55535b1', '42a3507f-c352-54e0-b8fa-8d9cda594d2e', 5, 18.0, NULL, false, '18', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '960e14bd-12b4-5430-b59e-6a27c4a42803', '42a3507f-c352-54e0-b8fa-8d9cda594d2e', 6, 20.0, NULL, false, '20', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '01be062b-bbab-5bba-9585-64e48c7e8d48', '42a3507f-c352-54e0-b8fa-8d9cda594d2e', 7, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '71da2a85-c6d5-539b-bb8c-0533b93ffab0', '42a3507f-c352-54e0-b8fa-8d9cda594d2e', 8, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '4d7c4064-64a6-5fef-8ff7-02fa8a6859ec', '909d02a5-34df-5bff-891f-f9859541fe97', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Dayeon Kim', 'O478', 'individual', 17,
    124.0, 100.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '06390029-ffed-5a0f-a9e1-4cad5a8ee541', '4d7c4064-64a6-5fef-8ff7-02fa8a6859ec', '909d02a5-34df-5bff-891f-f9859541fe97', 'Dayeon Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e11f0634-5002-5b43-bc85-344789113d09', '4d7c4064-64a6-5fef-8ff7-02fa8a6859ec', 1, 13.0, NULL, false, '13 클럽', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1ef5e1eb-7dfa-5120-9d4a-61662d65a513', '4d7c4064-64a6-5fef-8ff7-02fa8a6859ec', 2, 24.0, NULL, true, '(24)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2aa1353a-7091-5bc9-becc-818a30a84563', '4d7c4064-64a6-5fef-8ff7-02fa8a6859ec', 3, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fd7fb50d-f0e8-5239-9530-51ec16ff13df', '4d7c4064-64a6-5fef-8ff7-02fa8a6859ec', 4, 19.0, NULL, false, '19', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd5d74f14-3741-5579-8cc6-fa8d6eb433b9', '4d7c4064-64a6-5fef-8ff7-02fa8a6859ec', 5, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6e31b677-00bc-5b40-821e-817c844db176', '4d7c4064-64a6-5fef-8ff7-02fa8a6859ec', 6, 21.0, NULL, false, '21', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd164d723-8458-5335-ac12-1c79ac442e3a', '4d7c4064-64a6-5fef-8ff7-02fa8a6859ec', 7, 13.0, NULL, false, '13', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c5c7746c-2c0f-5009-b0d1-7b8a487a083e', '4d7c4064-64a6-5fef-8ff7-02fa8a6859ec', 8, 17.0, NULL, false, '17', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '70bc9ed0-21d1-52a6-9f3f-b5827edab231', 'd0a7e399-5ee4-597a-a950-029e30c7c6bc', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Sandeul Kim', 'O579', 'individual', 18,
    130.0, 104.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '527263f7-ff02-5876-a53e-79ddf17625ec', '70bc9ed0-21d1-52a6-9f3f-b5827edab231', 'd0a7e399-5ee4-597a-a950-029e30c7c6bc', 'Sandeul Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd16a2cbc-cbcf-5cf2-a592-2ae0024c23ed', '70bc9ed0-21d1-52a6-9f3f-b5827edab231', 1, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'da559227-083e-5184-9954-df672f294302', '70bc9ed0-21d1-52a6-9f3f-b5827edab231', 2, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c94e003e-4246-59c1-b3bb-59123bba1b32', '70bc9ed0-21d1-52a6-9f3f-b5827edab231', 3, 24.0, NULL, false, '24', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7a8d4448-4b65-5d0a-8460-f051cd428426', '70bc9ed0-21d1-52a6-9f3f-b5827edab231', 4, 14.0, NULL, false, '14', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '603bb413-5254-5c87-9006-c9a157b69a0f', '70bc9ed0-21d1-52a6-9f3f-b5827edab231', 5, 25.0, NULL, false, '25', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9d3937ef-a39c-5e4b-845f-4da1132fcb10', '70bc9ed0-21d1-52a6-9f3f-b5827edab231', 6, 17.0, NULL, false, '17', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ef0084d1-89e0-5aec-b29d-71eab047b7bb', '70bc9ed0-21d1-52a6-9f3f-b5827edab231', 7, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2ed908bc-1018-517c-aee3-c2ea975d7eff', '70bc9ed0-21d1-52a6-9f3f-b5827edab231', 8, 26.0, NULL, true, '(26)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'f342cd61-61d9-5456-bf1f-a98387c89317', 'a6f17bae-88f1-5370-b19d-c56e570449f6', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Minyul Kang', 'O571', 'individual', 19,
    149.0, 110.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b535720a-a67a-5bf3-9208-70878f5522fb', 'f342cd61-61d9-5456-bf1f-a98387c89317', 'a6f17bae-88f1-5370-b19d-c56e570449f6', 'Minyul Kang', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fab3727d-c81d-524e-b69c-a7c47e4fb3bc', 'f342cd61-61d9-5456-bf1f-a98387c89317', 1, 16.0, NULL, false, '16', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '81b77847-3caf-5ea2-8952-7bda468bd5da', 'f342cd61-61d9-5456-bf1f-a98387c89317', 2, 17.0, NULL, false, '17', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6d5a28b8-d8bc-544b-ab2c-0f1f0ed8afb6', 'f342cd61-61d9-5456-bf1f-a98387c89317', 3, 39.0, 'OCS', true, '(39) OCS', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ccd383af-8ef8-5727-ba82-635052c30407', 'f342cd61-61d9-5456-bf1f-a98387c89317', 4, 17.0, NULL, false, '17', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ae18f880-1b9e-546b-b44d-a80d941325a1', 'f342cd61-61d9-5456-bf1f-a98387c89317', 5, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9e7767dc-9881-5f33-8064-2b6d2d72785b', 'f342cd61-61d9-5456-bf1f-a98387c89317', 6, 22.0, NULL, false, '22', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'db96228a-d536-521e-bda8-a4a3ad71c2fe', 'f342cd61-61d9-5456-bf1f-a98387c89317', 7, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '81fba95e-3fab-5f57-8d11-48057436be6d', 'f342cd61-61d9-5456-bf1f-a98387c89317', 8, 18.0, 'SCP', false, '16+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'c0e9e17f-7706-5fd8-8949-a7f0f90d41bf', 'd90e0657-29ef-5e28-b503-087e4eb9d103', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Arim Seo', 'O565', 'individual', 20,
    135.0, 113.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '873307eb-6da6-557b-a0a8-a2ea2a0aff08', 'c0e9e17f-7706-5fd8-8949-a7f0f90d41bf', 'd90e0657-29ef-5e28-b503-087e4eb9d103', 'Arim Seo', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1c87baf1-20f2-5e85-adb4-13b739cb8b95', 'c0e9e17f-7706-5fd8-8949-a7f0f90d41bf', 1, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd6c9d587-010f-50b3-805b-88b8e122814c', 'c0e9e17f-7706-5fd8-8949-a7f0f90d41bf', 2, 19.0, NULL, false, '19', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c331e0bd-6917-57ea-8495-f4bbe1c2781d', 'c0e9e17f-7706-5fd8-8949-a7f0f90d41bf', 3, 22.0, NULL, true, '(22)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ddb688d5-45bc-5698-9a01-ea3c35ea3037', 'c0e9e17f-7706-5fd8-8949-a7f0f90d41bf', 4, 13.0, NULL, false, '13', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0ef024e9-67ce-5b66-9d93-bca287ba61b2', 'c0e9e17f-7706-5fd8-8949-a7f0f90d41bf', 5, 12.0, NULL, false, '12', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd45ed8e7-9571-528b-acdb-48a4d9c03e70', 'c0e9e17f-7706-5fd8-8949-a7f0f90d41bf', 6, 19.0, NULL, false, '19', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e71ecdd1-cd32-5d30-9346-25d9ad5c4cfd', 'c0e9e17f-7706-5fd8-8949-a7f0f90d41bf', 7, 22.0, NULL, false, '22', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e9e7480a-edf5-557e-9abb-f4f0fbe28ac4', 'c0e9e17f-7706-5fd8-8949-a7f0f90d41bf', 8, 21.0, NULL, false, '21', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'dd6750b5-9bf0-5c5c-aa94-b607d4286581', '7b8ecdf3-6c9d-553e-9ff5-3e57eb0a46b8', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Seungwoo Oh', 'O479', 'individual', 21,
    151.0, 123.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd81381f1-4318-575f-9ac6-22d8eeddce14', 'dd6750b5-9bf0-5c5c-aa94-b607d4286581', '7b8ecdf3-6c9d-553e-9ff5-3e57eb0a46b8', 'Seungwoo Oh', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b6738822-8ce7-5ff7-a64b-15ab21f2dbd0', 'dd6750b5-9bf0-5c5c-aa94-b607d4286581', 1, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b780a811-da89-5971-a61d-09fecf9aee85', 'dd6750b5-9bf0-5c5c-aa94-b607d4286581', 2, 18.0, NULL, false, '18', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b0468b87-b652-5e43-a641-da18ff9453dd', 'dd6750b5-9bf0-5c5c-aa94-b607d4286581', 3, 12.0, NULL, false, '12', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6252d187-44bb-535a-b13d-f5778b54c8c9', 'dd6750b5-9bf0-5c5c-aa94-b607d4286581', 4, 28.0, NULL, true, '(28)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'dd07e09b-6dd6-5db4-8897-27d1ce0c8c5e', 'dd6750b5-9bf0-5c5c-aa94-b607d4286581', 5, 23.0, NULL, false, '23', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '78ffe546-0957-5ebc-9742-a5d8b3781012', 'dd6750b5-9bf0-5c5c-aa94-b607d4286581', 6, 25.0, NULL, false, '25', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '59f18bc2-0dd7-5baa-9265-b39e294ee12b', 'dd6750b5-9bf0-5c5c-aa94-b607d4286581', 7, 24.0, NULL, false, '24', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0a4dc6fa-bde2-59d3-8794-e4b061e0937e', 'dd6750b5-9bf0-5c5c-aa94-b607d4286581', 8, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '557570a8-260d-5d10-927f-9079c8258ce7', 'ecbc3b3f-489f-5177-b240-1b7b4976360f', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Sihoon Joo', 'O572', 'individual', 22,
    178.0, 139.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f30cf79d-8321-5f87-9594-0e189089869b', '557570a8-260d-5d10-927f-9079c8258ce7', 'ecbc3b3f-489f-5177-b240-1b7b4976360f', 'Sihoon Joo', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '957f3c43-74ee-503a-a799-d36747f4b4dd', '557570a8-260d-5d10-927f-9079c8258ce7', 1, 39.0, 'DNF', true, '(39) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '05466cd1-8f6d-592b-be8e-a8226e8d0f4b', '557570a8-260d-5d10-927f-9079c8258ce7', 2, 20.0, NULL, false, '20', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '62750871-d528-5618-97a6-b53842e5bbc7', '557570a8-260d-5d10-927f-9079c8258ce7', 3, 16.0, NULL, false, '16', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c760ddcd-10f4-5d22-afa1-394d7269654e', '557570a8-260d-5d10-927f-9079c8258ce7', 4, 23.0, NULL, false, '23', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'abdd445e-4b21-5f80-b574-21734074c1c9', '557570a8-260d-5d10-927f-9079c8258ce7', 5, 13.0, NULL, false, '13', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f25bcd68-cbd2-5abf-8ef9-991264b0725c', '557570a8-260d-5d10-927f-9079c8258ce7', 6, 23.0, NULL, false, '23', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '03550415-bd2c-5023-abd2-fe401a0715a6', '557570a8-260d-5d10-927f-9079c8258ce7', 7, 25.0, NULL, false, '25', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '82367d19-4a63-5f00-8fe5-ed901efe5ac5', '557570a8-260d-5d10-927f-9079c8258ce7', 8, 19.0, NULL, false, '19', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'ffcca8b0-4a5a-59f3-9660-2c6485f5ddd0', 'fdc27789-fa73-57f3-889a-b6baf8711377', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Chaewon Kim', 'O552', 'individual', 23,
    172.0, 142.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8c4e3d61-3500-51ef-a93f-bd3163f67807', 'ffcca8b0-4a5a-59f3-9660-2c6485f5ddd0', 'fdc27789-fa73-57f3-889a-b6baf8711377', 'Chaewon Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '52761a72-e802-53de-a118-8a047dc2cf42', 'ffcca8b0-4a5a-59f3-9660-2c6485f5ddd0', 1, 15.0, NULL, false, '15', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4a7efa5c-fd80-5353-83dc-a96c331d95eb', 'ffcca8b0-4a5a-59f3-9660-2c6485f5ddd0', 2, 21.0, NULL, false, '21', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '684395c3-c20b-5a54-b91b-5b25ea79cc63', 'ffcca8b0-4a5a-59f3-9660-2c6485f5ddd0', 3, 23.0, NULL, false, '23', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'df0cb5eb-8010-5a2f-bbd1-8ff1b642ff5c', 'ffcca8b0-4a5a-59f3-9660-2c6485f5ddd0', 4, 27.0, NULL, false, '27', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '83bb7c81-bc1f-5f2a-83e7-af2a2012beb7', 'ffcca8b0-4a5a-59f3-9660-2c6485f5ddd0', 5, 14.0, NULL, false, '14', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '869fd165-0635-5df1-8bf0-5e146beda8f9', 'ffcca8b0-4a5a-59f3-9660-2c6485f5ddd0', 6, 18.0, NULL, false, '18', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'add0a2d8-4d7a-5fbf-bd06-81703cb58814', 'ffcca8b0-4a5a-59f3-9660-2c6485f5ddd0', 7, 30.0, NULL, true, '(30)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1a43d377-c9d3-5d77-8162-1376385a478c', 'ffcca8b0-4a5a-59f3-9660-2c6485f5ddd0', 8, 24.0, NULL, false, '24', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'c7e60380-0947-5720-8ba4-f570944371a8', '641df9b4-7692-5a50-b293-786f33e29582', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Seongbin Min', 'O532', 'individual', 24,
    210.0, 171.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b983a435-28de-58e2-a49f-3a3209b4c926', 'c7e60380-0947-5720-8ba4-f570944371a8', '641df9b4-7692-5a50-b293-786f33e29582', 'Seongbin Min', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6b98f6b5-0032-5f47-bae7-0a53d6497cf8', 'c7e60380-0947-5720-8ba4-f570944371a8', 1, 39.0, 'DNS', true, '(39) DNS', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2ceca1ea-b3eb-594f-8e50-310b83ee2285', 'c7e60380-0947-5720-8ba4-f570944371a8', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c036adb2-afd1-5561-bdaa-9e933d178739', 'c7e60380-0947-5720-8ba4-f570944371a8', 3, 25.0, NULL, false, '25', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c16acdf5-4c07-5b25-8662-2613d93fa49c', 'c7e60380-0947-5720-8ba4-f570944371a8', 4, 39.0, 'RET', false, '39 RET', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '62352c4a-1592-57bc-8354-658624a42be1', 'c7e60380-0947-5720-8ba4-f570944371a8', 5, 19.0, NULL, false, '19', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '982789f2-7df5-52bc-b94c-1188b220300d', 'c7e60380-0947-5720-8ba4-f570944371a8', 6, 16.0, NULL, false, '16', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b78523a6-8a60-585b-beaa-9bf9c1c6d149', 'c7e60380-0947-5720-8ba4-f570944371a8', 7, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'da1f1ebf-96f3-5444-bdcd-4e127eab358b', 'c7e60380-0947-5720-8ba4-f570944371a8', 8, 27.0, NULL, false, '27', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '524fc3fa-ca88-58ee-89d9-013a4f08b473', 'd456f933-1422-5605-b2eb-d3121e7e932f', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Hyunbin Lee', 'O566', 'individual', 25,
    210.0, 171.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f96e6487-ae0b-5bd1-a823-c0aec518683d', '524fc3fa-ca88-58ee-89d9-013a4f08b473', 'd456f933-1422-5605-b2eb-d3121e7e932f', 'Hyunbin Lee', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '610f143c-7e1c-5361-ab2d-f62b83063a3c', '524fc3fa-ca88-58ee-89d9-013a4f08b473', 1, 39.0, 'DNC', true, '(39) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f6742245-6a62-54a0-bac1-0599f6a7fcd2', '524fc3fa-ca88-58ee-89d9-013a4f08b473', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6b5bfe98-f40f-5f25-a6af-b0071f9c8949', '524fc3fa-ca88-58ee-89d9-013a4f08b473', 3, 26.0, NULL, false, '26', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8b60a4ce-2b34-5afb-879f-c65ab5b9ba8e', '524fc3fa-ca88-58ee-89d9-013a4f08b473', 4, 22.0, NULL, false, '22', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2edffd49-9b36-5221-83d7-cacd1b4304d9', '524fc3fa-ca88-58ee-89d9-013a4f08b473', 5, 32.0, NULL, false, '32', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e7b2cbf5-050e-58a4-8a06-e8a575df0978', '524fc3fa-ca88-58ee-89d9-013a4f08b473', 6, 13.0, NULL, false, '13', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'dbea325c-3455-5a15-90a8-0d3c65e3add4', '524fc3fa-ca88-58ee-89d9-013a4f08b473', 7, 28.0, NULL, false, '28', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4e324c58-c7b2-529b-8370-a168abbe8b58', '524fc3fa-ca88-58ee-89d9-013a4f08b473', 8, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '8c7dd4ed-abd1-55ba-bd92-09cf1e9877a9', 'd18a63e1-9764-55a9-a664-ee3363093cab', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Hyeok Lim', 'O457', 'individual', 26,
    223.0, 184.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4214d267-cfe5-580f-8451-70abc465ad39', '8c7dd4ed-abd1-55ba-bd92-09cf1e9877a9', 'd18a63e1-9764-55a9-a664-ee3363093cab', 'Hyeok Lim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2efbf498-cae4-598e-a3bf-adec8782e463', '8c7dd4ed-abd1-55ba-bd92-09cf1e9877a9', 1, 39.0, 'DNC', true, '(39) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8f9de883-3d5a-596c-a7bd-611e1e329bdb', '8c7dd4ed-abd1-55ba-bd92-09cf1e9877a9', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c0bfc924-7dc0-5b38-b7a6-1b5f0ff2bbf0', '8c7dd4ed-abd1-55ba-bd92-09cf1e9877a9', 3, 30.0, NULL, false, '30', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9a36d57a-d751-5ac7-bd03-b613b7e5f057', '8c7dd4ed-abd1-55ba-bd92-09cf1e9877a9', 4, 26.0, NULL, false, '26', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ea4365c4-c919-56d7-a217-2ebac016931f', '8c7dd4ed-abd1-55ba-bd92-09cf1e9877a9', 5, 21.0, NULL, false, '21', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2fb941e7-8913-5a56-bfa1-1bc689c9b2fd', '8c7dd4ed-abd1-55ba-bd92-09cf1e9877a9', 6, 29.0, NULL, false, '29', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '41c374d8-0e41-5b48-9baa-49d850a5ac0e', '8c7dd4ed-abd1-55ba-bd92-09cf1e9877a9', 7, 16.0, NULL, false, '16', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '45db1431-331a-59ab-88f0-5f0365bc7f74', '8c7dd4ed-abd1-55ba-bd92-09cf1e9877a9', 8, 23.0, NULL, false, '23', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '40f70fe0-fc46-561c-b434-99455f64bc90', 'c3b6da21-0901-5707-ba5f-2a793b2bbece', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Juyoung Choi', 'O516', 'individual', 27,
    226.0, 187.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9f5eea8e-2318-572a-9721-c168a6dba7d2', '40f70fe0-fc46-561c-b434-99455f64bc90', 'c3b6da21-0901-5707-ba5f-2a793b2bbece', 'Juyoung Choi', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd064c35b-c6a8-5315-9ceb-2bb0f9333273', '40f70fe0-fc46-561c-b434-99455f64bc90', 1, 39.0, 'DNF', true, '(39) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5568e036-3c16-5d98-af30-b9bcc06ee60a', '40f70fe0-fc46-561c-b434-99455f64bc90', 2, 22.0, NULL, false, '22', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '68834e7d-3632-5587-9585-3c3ed498ac31', '40f70fe0-fc46-561c-b434-99455f64bc90', 3, 32.0, NULL, false, '32', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b24d1ada-47f6-5c7a-96ec-0c39782ac69a', '40f70fe0-fc46-561c-b434-99455f64bc90', 4, 25.0, NULL, false, '25', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e6845bc1-6198-5d7d-8ee5-db903fe58f4b', '40f70fe0-fc46-561c-b434-99455f64bc90', 5, 39.0, 'RET', false, '39 RET', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1de34058-ee7f-5bf7-9be4-87b6890230de', '40f70fe0-fc46-561c-b434-99455f64bc90', 6, 29.0, 'SCP', false, '27+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a5e2085f-7b3e-55b7-8363-4e882e269464', '40f70fe0-fc46-561c-b434-99455f64bc90', 7, 18.0, NULL, false, '18', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9e073114-0def-559c-ab16-d1a9678232e7', '40f70fe0-fc46-561c-b434-99455f64bc90', 8, 22.0, NULL, false, '22', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '5e6a0d6e-d902-583c-99a0-b5d6a1111d6e', '297d4ae4-e6e4-523f-bbe1-86660370ad87', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Jungwoo Kim', 'O519', 'individual', 28,
    230.0, 191.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5cdfe45c-ded1-5151-b705-9afedaa231b2', '5e6a0d6e-d902-583c-99a0-b5d6a1111d6e', '297d4ae4-e6e4-523f-bbe1-86660370ad87', 'Jungwoo Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0954dac6-af0d-542b-8e54-6fb365454a99', '5e6a0d6e-d902-583c-99a0-b5d6a1111d6e', 1, 39.0, 'DNC', true, '(39) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd36be70a-d783-55e9-a5ab-03033c5b61e2', '5e6a0d6e-d902-583c-99a0-b5d6a1111d6e', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5e946572-a905-5447-b5ed-90e551912772', '5e6a0d6e-d902-583c-99a0-b5d6a1111d6e', 3, 14.0, NULL, false, '14', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '54bcdef4-496a-57d9-907b-69fcb2031cd9', '5e6a0d6e-d902-583c-99a0-b5d6a1111d6e', 4, 24.0, NULL, false, '24', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3eddf893-0269-5840-8c02-7d90a1c6fd4d', '5e6a0d6e-d902-583c-99a0-b5d6a1111d6e', 5, 31.0, NULL, false, '31', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'bcaebd53-cb56-5556-84dd-ebe0730ccc8d', '5e6a0d6e-d902-583c-99a0-b5d6a1111d6e', 6, 28.0, NULL, false, '28', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '797c4544-e67b-5c4a-860d-b67876a875e3', '5e6a0d6e-d902-583c-99a0-b5d6a1111d6e', 7, 26.0, NULL, false, '26', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ccf6f0ec-8e35-5452-8905-c33b8c4caf2c', '5e6a0d6e-d902-583c-99a0-b5d6a1111d6e', 8, 29.0, NULL, false, '29', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '951788e1-1e51-5f39-875e-32e972baac8f', '6ce5e010-7a12-52a3-a859-b177972902ac', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Baha Kim', 'O513', 'individual', 29,
    236.0, 197.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '88bc2707-b0d6-5638-98b0-8b25c7007315', '951788e1-1e51-5f39-875e-32e972baac8f', '6ce5e010-7a12-52a3-a859-b177972902ac', 'Baha Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2fe7b3e1-65d0-5ec6-b2b9-e5fcdd179d7f', '951788e1-1e51-5f39-875e-32e972baac8f', 1, 39.0, 'DNC', true, '(39) 클럽 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b663ee5e-be2d-5482-b3f8-fc25ff686edf', '951788e1-1e51-5f39-875e-32e972baac8f', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '98f2d9d8-f821-55ed-978b-e2106dd7e938', '951788e1-1e51-5f39-875e-32e972baac8f', 3, 19.0, NULL, false, '19', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '07dc35e3-bd51-5c3e-8796-528204e68297', '951788e1-1e51-5f39-875e-32e972baac8f', 4, 29.0, NULL, false, '29', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '71ec4af3-fa26-5278-bb38-0b66ddf45e13', '951788e1-1e51-5f39-875e-32e972baac8f', 5, 29.0, NULL, false, '29', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c728ce5b-e680-5e20-8100-8b56b2e3333c', '951788e1-1e51-5f39-875e-32e972baac8f', 6, 24.0, NULL, false, '24', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '704ed386-14ab-59fa-b41e-b0ecbdf36fa5', '951788e1-1e51-5f39-875e-32e972baac8f', 7, 25.0, 'SCP', false, '23+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f04e37f1-37a7-597f-9385-a043978b5187', '951788e1-1e51-5f39-875e-32e972baac8f', 8, 32.0, 'SCP', false, '30+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'a5f91fb7-4d3d-5724-a58c-7c3c91855307', '6399eec6-91f6-5873-95c7-cbd9608d1979', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Dana Kim', 'O462', 'individual', 30,
    261.0, 222.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e0cc3dd3-2b39-5811-bc0d-16ab4cae7146', 'a5f91fb7-4d3d-5724-a58c-7c3c91855307', '6399eec6-91f6-5873-95c7-cbd9608d1979', 'Dana Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0643a371-c6a0-5024-8c1b-9208b27ed81c', 'a5f91fb7-4d3d-5724-a58c-7c3c91855307', 1, 39.0, 'DNF', true, '(39) 럽 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4b2f00d8-0dce-530c-8824-0e67e5028061', 'a5f91fb7-4d3d-5724-a58c-7c3c91855307', 2, 23.0, NULL, false, '23', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'adb8f7e1-9c9e-551d-805f-3b83447b4953', 'a5f91fb7-4d3d-5724-a58c-7c3c91855307', 3, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b0e2f004-c8a5-5a5b-aa11-1057a5fffcdc', 'a5f91fb7-4d3d-5724-a58c-7c3c91855307', 4, 31.0, NULL, false, '31', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd06e0f45-cc51-58a6-abae-c04249938816', 'a5f91fb7-4d3d-5724-a58c-7c3c91855307', 5, 39.0, 'DNF', false, '39 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1a06be8f-f9c4-5afb-bc93-a71f20649c2b', 'a5f91fb7-4d3d-5724-a58c-7c3c91855307', 6, 32.0, NULL, false, '32', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5f40ef6b-2580-5ccb-b31f-7e94b9325341', 'a5f91fb7-4d3d-5724-a58c-7c3c91855307', 7, 33.0, NULL, false, '33', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e9f0ed21-6e68-5999-ab70-051ff6e5229a', 'a5f91fb7-4d3d-5724-a58c-7c3c91855307', 8, 25.0, NULL, false, '25', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '5ce88104-ed22-5db0-9ead-3b7a47b5b64b', 'e862331e-b4f6-55e8-9a68-bd418a09d0f8', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Yejun Nam', 'O520', 'individual', 31,
    267.0, 228.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '63a5d368-1488-5100-85a0-0ee31d491753', '5ce88104-ed22-5db0-9ead-3b7a47b5b64b', 'e862331e-b4f6-55e8-9a68-bd418a09d0f8', 'Yejun Nam', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5ab28c2f-a356-54e7-9f74-f7bd90774ef7', '5ce88104-ed22-5db0-9ead-3b7a47b5b64b', 1, 39.0, 'DNC', true, '(39) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ffae1408-4876-5edd-874c-dde39a459a06', '5ce88104-ed22-5db0-9ead-3b7a47b5b64b', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '45b21732-2f9a-5d84-b66e-b954dd49f6d5', '5ce88104-ed22-5db0-9ead-3b7a47b5b64b', 3, 27.0, NULL, false, '27', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ad8eba52-d827-5d04-858a-6a816b91095a', '5ce88104-ed22-5db0-9ead-3b7a47b5b64b', 4, 32.0, NULL, false, '32', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '769c4f14-aacb-56ac-ab7a-831c7f3e24b9', '5ce88104-ed22-5db0-9ead-3b7a47b5b64b', 5, 27.0, NULL, false, '27', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4e17e97a-27c4-5ebc-8717-1804708dbc51', '5ce88104-ed22-5db0-9ead-3b7a47b5b64b', 6, 37.0, 'SCP', false, '35+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '903b5432-718d-5797-a63d-49f9a94e2b98', '5ce88104-ed22-5db0-9ead-3b7a47b5b64b', 7, 31.0, NULL, false, '31', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b8dc30e3-9e2d-5154-9ad4-0ea9a7d6666b', '5ce88104-ed22-5db0-9ead-3b7a47b5b64b', 8, 35.0, NULL, false, '35', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '2a0f8286-dd95-571c-808a-c2f39fac3279', '311a8261-7da7-5863-abcd-aa01baa52874', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Taehee Kim', 'O400', 'individual', 32,
    272.0, 233.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ec76f3d2-f5d9-5dc6-a79c-30f0cdaafc5c', '2a0f8286-dd95-571c-808a-c2f39fac3279', '311a8261-7da7-5863-abcd-aa01baa52874', 'Taehee Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ce0ed64a-8027-5c6e-b5af-b79350e604d7', '2a0f8286-dd95-571c-808a-c2f39fac3279', 1, 39.0, 'DNC', true, '(39) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '04cc0410-9e9d-5c76-9ec3-a92199745421', '2a0f8286-dd95-571c-808a-c2f39fac3279', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5f78100c-7845-5fb2-9375-f161be4e1c0b', '2a0f8286-dd95-571c-808a-c2f39fac3279', 3, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd511a2ca-559d-5c25-9d21-b1934572ada8', '2a0f8286-dd95-571c-808a-c2f39fac3279', 4, 12.0, NULL, false, '12', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '236c4dd1-02fd-5ca0-8a1f-68a43492ad1b', '2a0f8286-dd95-571c-808a-c2f39fac3279', 5, 39.0, 'DNF', false, '39 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '12679e62-0d12-52d3-b040-52694f67c46b', '2a0f8286-dd95-571c-808a-c2f39fac3279', 6, 31.0, NULL, false, '31', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e2831de1-1ad0-5ff7-a08f-292deaef387c', '2a0f8286-dd95-571c-808a-c2f39fac3279', 7, 39.0, 'DNS', false, '39 DNS', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c0f240c2-05ed-5b12-9c7d-53a9702d11e5', '2a0f8286-dd95-571c-808a-c2f39fac3279', 8, 34.0, NULL, false, '34', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'c2390e5a-8566-5e86-96d2-a4ecb4b683d5', '77fe64ce-78c6-57de-ae98-0284823bb995', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Youngjun Shim', 'O511', 'individual', 33,
    273.0, 234.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '28d2bf24-5ac5-5e21-b00c-d28cf8be4558', 'c2390e5a-8566-5e86-96d2-a4ecb4b683d5', '77fe64ce-78c6-57de-ae98-0284823bb995', 'Youngjun Shim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '700b81b2-72e1-5a0e-a78d-b02a155e1493', 'c2390e5a-8566-5e86-96d2-a4ecb4b683d5', 1, 39.0, 'DNC', true, '(39) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd16fabf5-1c09-59b0-91f2-e1bf88221b22', 'c2390e5a-8566-5e86-96d2-a4ecb4b683d5', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e6346eb7-d7c0-54cd-a411-6f6acc07a5aa', 'c2390e5a-8566-5e86-96d2-a4ecb4b683d5', 3, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'db7d8a04-51bb-5ec3-ae8f-c0cccc0b7dec', 'c2390e5a-8566-5e86-96d2-a4ecb4b683d5', 4, 34.0, NULL, false, '34', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '75e4b9c1-a6c6-57e0-b7b5-62a2ac5d0b19', 'c2390e5a-8566-5e86-96d2-a4ecb4b683d5', 5, 30.0, NULL, false, '30', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9b3c3463-9af7-5bda-8cd9-e77b55b8df62', 'c2390e5a-8566-5e86-96d2-a4ecb4b683d5', 6, 33.0, NULL, false, '33', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '797f28a1-5574-53d5-a750-669032804968', 'c2390e5a-8566-5e86-96d2-a4ecb4b683d5', 7, 31.0, 'SCP', false, '29+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b73e0690-e78a-58fe-bdf9-a8d93574012a', 'c2390e5a-8566-5e86-96d2-a4ecb4b683d5', 8, 28.0, NULL, false, '28', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '532ab08d-c6f6-551f-a8d6-07d7c43688bc', '3b9f6c7a-40dd-598a-b297-eb8258252fee', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Gaon Yoo', 'O144', 'individual', 34,
    275.0, 236.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6d28a3a9-afcb-59da-bfb5-e771334eee2a', '532ab08d-c6f6-551f-a8d6-07d7c43688bc', '3b9f6c7a-40dd-598a-b297-eb8258252fee', 'Gaon Yoo', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f9580647-8a56-5338-83c4-2afd695d1922', '532ab08d-c6f6-551f-a8d6-07d7c43688bc', 1, 39.0, 'DNF', true, '(39) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f679164f-97cd-5ec9-ba34-6d67a2498e60', '532ab08d-c6f6-551f-a8d6-07d7c43688bc', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f56a9df0-9fd6-579a-ad48-e1294d922da3', '532ab08d-c6f6-551f-a8d6-07d7c43688bc', 3, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '73c76152-a56a-55cc-ab38-ad1ab8033056', '532ab08d-c6f6-551f-a8d6-07d7c43688bc', 4, 30.0, NULL, false, '30', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '692a06fe-165a-59f4-bef2-c54134e5c90b', '532ab08d-c6f6-551f-a8d6-07d7c43688bc', 5, 22.0, NULL, false, '22', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '96c78b58-c6db-56be-9567-332acd8fb133', '532ab08d-c6f6-551f-a8d6-07d7c43688bc', 6, 38.0, 'SCP', false, '36+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'dca950f9-eb5b-5bbf-981b-4ecbef3de781', '532ab08d-c6f6-551f-a8d6-07d7c43688bc', 7, 32.0, NULL, false, '32', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3f05009b-18e2-54e3-b939-e7b1e003bbb9', '532ab08d-c6f6-551f-a8d6-07d7c43688bc', 8, 36.0, NULL, false, '36', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '1ef8d11f-3c59-5f59-b0a7-df1718e9c66b', 'f436984f-1cac-551f-ad5d-230a79f84173', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Yoon Oh', 'O577', 'individual', 35,
    275.0, 236.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9955fbac-f6e7-5755-ac80-b2325f44b084', '1ef8d11f-3c59-5f59-b0a7-df1718e9c66b', 'f436984f-1cac-551f-ad5d-230a79f84173', 'Yoon Oh', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a4c5ec19-2bef-58f8-a4c2-18acedd8d7ab', '1ef8d11f-3c59-5f59-b0a7-df1718e9c66b', 1, 39.0, 'DNC', true, '(39) 회 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd0230215-cd31-5683-82d5-84c6b626e5de', '1ef8d11f-3c59-5f59-b0a7-df1718e9c66b', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fc460a13-38af-56eb-870e-bc0735c71596', '1ef8d11f-3c59-5f59-b0a7-df1718e9c66b', 3, 29.0, NULL, false, '29', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '62f54ce2-5449-55c1-8896-a549150f25f5', '1ef8d11f-3c59-5f59-b0a7-df1718e9c66b', 4, 33.0, NULL, false, '33', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e89c7337-43d8-52ad-b544-95c0577c0432', '1ef8d11f-3c59-5f59-b0a7-df1718e9c66b', 5, 39.0, 'DNF', false, '39 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a1ce6e95-bbd0-5bc8-b7b1-9d4735f2844e', '1ef8d11f-3c59-5f59-b0a7-df1718e9c66b', 6, 30.0, NULL, false, '30', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f4c86cdf-f0e5-52bd-a178-e48f5b557314', '1ef8d11f-3c59-5f59-b0a7-df1718e9c66b', 7, 27.0, NULL, false, '27', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7b2405ed-9e23-5ee6-a2c4-e0b4a2e4f6e2', '1ef8d11f-3c59-5f59-b0a7-df1718e9c66b', 8, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '394cebbe-6e90-54e9-92f1-90e322a0cf77', '2e113407-8fa8-53d2-98a4-2c53d3ed524b', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Seobin Yoo', 'O505', 'individual', 36,
    276.0, 237.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1e3f4522-b1b4-5a75-bd57-4575bbd71bdf', '394cebbe-6e90-54e9-92f1-90e322a0cf77', '2e113407-8fa8-53d2-98a4-2c53d3ed524b', 'Seobin Yoo', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3a25471b-81b5-5665-b14d-8d7e83d67336', '394cebbe-6e90-54e9-92f1-90e322a0cf77', 1, 39.0, 'DNF', true, '(39) 5 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8429a8d8-5526-5b53-8273-21d19a5a3086', '394cebbe-6e90-54e9-92f1-90e322a0cf77', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '79c60cab-34fa-5261-b52c-340300f6d486', '394cebbe-6e90-54e9-92f1-90e322a0cf77', 3, 31.0, NULL, false, '31', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b19a3af9-6038-57eb-8fc8-baf5290b6cfa', '394cebbe-6e90-54e9-92f1-90e322a0cf77', 4, 36.0, NULL, false, '36', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f579bb26-9ce6-549b-beeb-eb4d80ce5224', '394cebbe-6e90-54e9-92f1-90e322a0cf77', 5, 28.0, NULL, false, '28', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1c69104b-266c-57c9-bd55-535c29d8168d', '394cebbe-6e90-54e9-92f1-90e322a0cf77', 6, 36.0, 'SCP', false, '34+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'df474146-a0a9-5679-aae7-fe4532961e04', '394cebbe-6e90-54e9-92f1-90e322a0cf77', 7, 34.0, NULL, false, '34', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '11e6f048-a4e8-5694-9b8f-3fd8be30ad23', '394cebbe-6e90-54e9-92f1-90e322a0cf77', 8, 33.0, NULL, false, '33', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '1464d5cb-ac8d-509c-acff-45e3666b7b82', '5323ee8f-c8cb-557e-9f7c-a3b2b812c1a7', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Haeun An', 'O401', 'individual', 37,
    289.0, 250.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '43adfcb5-851a-58b2-97fd-b9e1deee90a3', '1464d5cb-ac8d-509c-acff-45e3666b7b82', '5323ee8f-c8cb-557e-9f7c-a3b2b812c1a7', 'Haeun An', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4d4d229a-cb47-562d-9abf-ebdc32e73078', '1464d5cb-ac8d-509c-acff-45e3666b7b82', 1, 39.0, 'DNC', true, '(39) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'cdadfe65-707d-5cc5-9ac6-edcfb0e86d55', '1464d5cb-ac8d-509c-acff-45e3666b7b82', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1d29bf4d-2bde-51c8-b361-d6c167a58b43', '1464d5cb-ac8d-509c-acff-45e3666b7b82', 3, 28.0, NULL, false, '28', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c2be14a8-0261-5abd-a0ab-d1490e927fce', '1464d5cb-ac8d-509c-acff-45e3666b7b82', 4, 35.0, NULL, false, '35', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fa1175b9-0f62-5348-af2c-180179ee10a7', '1464d5cb-ac8d-509c-acff-45e3666b7b82', 5, 39.0, 'DNF', false, '39 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ca1b1d8b-0d13-501b-abf9-e29745287e04', '1464d5cb-ac8d-509c-acff-45e3666b7b82', 6, 39.0, 'SCP', false, '37+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '288b1326-c295-5b1f-af44-57bba4297c77', '1464d5cb-ac8d-509c-acff-45e3666b7b82', 7, 39.0, 'DNS', false, '39 DNS', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0b0512ed-e9c0-5a03-87d5-1acf24ecf600', '1464d5cb-ac8d-509c-acff-45e3666b7b82', 8, 31.0, NULL, false, '31', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '17f13230-ffdc-5178-b156-0e5925324eb8', 'd9f3075d-4b63-576d-b544-b7991dcaa603', '5bed362b-6ab7-5fbd-895c-38c101845b78', 'Hayul Park', 'O474', 'individual', 38,
    310.0, 271.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2052e4c3-4543-542d-93e0-23dca8fe7208', '17f13230-ffdc-5178-b156-0e5925324eb8', 'd9f3075d-4b63-576d-b544-b7991dcaa603', 'Hayul Park', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3f2cf26c-b596-5653-9809-e68f168725c8', '17f13230-ffdc-5178-b156-0e5925324eb8', 1, 39.0, 'DNC', true, '(39) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '708e41dc-1be4-5601-a7fb-1e5ae4a4d91f', '17f13230-ffdc-5178-b156-0e5925324eb8', 2, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e0c40dc2-9e78-5226-996f-03cdd86b206a', '17f13230-ffdc-5178-b156-0e5925324eb8', 3, 39.0, 'DNF', false, '39 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6d3d795f-1426-5849-aeb2-89cff092839a', '17f13230-ffdc-5178-b156-0e5925324eb8', 4, 37.0, NULL, false, '37', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'dee3e598-8bcf-5617-99c7-6aae7c943799', '17f13230-ffdc-5178-b156-0e5925324eb8', 5, 39.0, 'DNF', false, '39 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd2c428d0-3944-533e-9495-a9bad24503f3', '17f13230-ffdc-5178-b156-0e5925324eb8', 6, 39.0, 'RET', false, '39 RET', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd7a4ffb1-8c53-502b-bc61-a1862820ba92', '17f13230-ffdc-5178-b156-0e5925324eb8', 7, 39.0, 'DNC', false, '39 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a042c828-687a-5ed7-8e6d-d84d6e9bb66d', '17f13230-ffdc-5178-b156-0e5925324eb8', 8, 39.0, 'DNS', false, '39 DNS', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();

INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '1ec2aab3-fff1-5800-922e-cf5d5f583c68',
    '3eab275b-24b8-5e99-8c85-79df5829649a',
    '2026 KSAF President''s Cup National Youth Sailing Championships — ILCA 4',
    'ksaf-presidents-cup-youth-nationals-2026-ilca-4',
    '2026-05-08',
    '2026-05-11',
    12,
    'Open',
    9,
    'KOR',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Seoul Water Leisure Sports Center, Hangang River, Seoul, South Korea',
    'Korea Sailing Federation (대한요트협회 / KSAF)',
    'published',
    'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf',
    '2026 대한요트협회장배(청소년) 전국요트대회 — ILCA 4 Open. Official KSAF Final Results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'f9d3154e-5a71-5d60-bfe4-d24e698dfcc4', '0d87c76a-54be-5d3d-acfe-8ce144c04ca1', '1ec2aab3-fff1-5800-922e-cf5d5f583c68', 'Junmo Kim', 'A4680', 'individual', 1,
    27.0, 14.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7a24ce41-4fc6-5fc7-89b6-37792e2a85bf', 'f9d3154e-5a71-5d60-bfe4-d24e698dfcc4', '0d87c76a-54be-5d3d-acfe-8ce144c04ca1', 'Junmo Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'cdd09038-96a1-5bbe-bf69-8cdf80c32590', 'f9d3154e-5a71-5d60-bfe4-d24e698dfcc4', 1, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'de34eb4b-9dc7-5261-9dbc-b03494d49304', 'f9d3154e-5a71-5d60-bfe4-d24e698dfcc4', 2, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b80a1409-ca18-53fb-9930-e7def4dae317', 'f9d3154e-5a71-5d60-bfe4-d24e698dfcc4', 3, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5e60e124-7e4e-5cb7-9082-15e683222f8e', 'f9d3154e-5a71-5d60-bfe4-d24e698dfcc4', 4, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8ec74302-518d-5cfd-a8c9-30b409356623', 'f9d3154e-5a71-5d60-bfe4-d24e698dfcc4', 5, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '231e145f-05b1-5e89-b875-dbced8256a7f', 'f9d3154e-5a71-5d60-bfe4-d24e698dfcc4', 6, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e41122bc-3ad3-5221-8a3c-c7a3678ca7dd', 'f9d3154e-5a71-5d60-bfe4-d24e698dfcc4', 7, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ea493627-53e5-5213-b9a6-4e4ed160fa00', 'f9d3154e-5a71-5d60-bfe4-d24e698dfcc4', 8, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fc4cf408-5a02-50ba-848c-d21eb8237f8c', 'f9d3154e-5a71-5d60-bfe4-d24e698dfcc4', 9, 13.0, 'DNC', true, '(13) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '5eb17407-278c-56e6-afa6-e77866a9c59c', 'd3bdd575-51a9-46c8-8b02-b254b18b100d', '1ec2aab3-fff1-5800-922e-cf5d5f583c68', 'Songha Lee', 'A0006', 'individual', 2,
    21.0, 17.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9b5be358-2f9d-5e0a-86f0-300dfb8b5c12', '5eb17407-278c-56e6-afa6-e77866a9c59c', 'd3bdd575-51a9-46c8-8b02-b254b18b100d', 'Songha Lee', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1912e011-4a89-5e43-a4be-2a7dfb0c9df7', '5eb17407-278c-56e6-afa6-e77866a9c59c', 1, 4.0, NULL, true, '(4)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '046a3a54-c826-5520-9be6-7f554b1fa913', '5eb17407-278c-56e6-afa6-e77866a9c59c', 2, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2a5979af-deea-5c49-b5c0-e1f70994d655', '5eb17407-278c-56e6-afa6-e77866a9c59c', 3, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3d89fc5f-b06b-5f0f-8d09-590b63c20804', '5eb17407-278c-56e6-afa6-e77866a9c59c', 4, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6910e1c1-239a-5366-b050-fc1885f04ba1', '5eb17407-278c-56e6-afa6-e77866a9c59c', 5, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ce757b71-27c3-5401-9335-ecb7396ca4ab', '5eb17407-278c-56e6-afa6-e77866a9c59c', 6, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '45043c6f-77b7-59cf-93cc-f87f0c00910c', '5eb17407-278c-56e6-afa6-e77866a9c59c', 7, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1ae7fb71-b788-5d23-85eb-cb4a31171a47', '5eb17407-278c-56e6-afa6-e77866a9c59c', 8, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5a32288e-e83b-50fd-bb83-eacf3cb0c3fe', '5eb17407-278c-56e6-afa6-e77866a9c59c', 9, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'd304bb51-9072-5a76-a929-2cc38502a03d', '190686bb-516d-43ec-a519-b0158e48f963', '1ec2aab3-fff1-5800-922e-cf5d5f583c68', 'Hyunwoo Jeon', 'A5619', 'individual', 3,
    23.0, 19.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '84241982-2d11-53f2-bed5-49433f388eae', 'd304bb51-9072-5a76-a929-2cc38502a03d', '190686bb-516d-43ec-a519-b0158e48f963', 'Hyunwoo Jeon', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b10b7ec4-1144-5ea3-b069-c87841fe6a77', 'd304bb51-9072-5a76-a929-2cc38502a03d', 1, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0249e2b7-82aa-5972-b362-c9add0160731', 'd304bb51-9072-5a76-a929-2cc38502a03d', 2, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '414642b7-c014-56ce-af0e-0a5b1c79a98a', 'd304bb51-9072-5a76-a929-2cc38502a03d', 3, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '074472a0-a735-5e9f-9597-3887eda856c8', 'd304bb51-9072-5a76-a929-2cc38502a03d', 4, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'bcc1aba8-87a5-57a9-88f9-54960005e241', 'd304bb51-9072-5a76-a929-2cc38502a03d', 5, 4.0, NULL, true, '(4)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '91a4a9fe-5349-548c-8492-acd12b4d8d30', 'd304bb51-9072-5a76-a929-2cc38502a03d', 6, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '93117687-9e99-50b0-b77d-bf70f5754dd0', 'd304bb51-9072-5a76-a929-2cc38502a03d', 7, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '09c3eae6-c072-568a-9ba8-8eb652bc6d69', 'd304bb51-9072-5a76-a929-2cc38502a03d', 8, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '414446b3-6601-5b07-b906-961e3b27fa3c', 'd304bb51-9072-5a76-a929-2cc38502a03d', 9, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'd1dd5345-6df0-5c42-a196-b911ee214313', 'c43c92c7-4890-5d5d-9f9e-b938fc455ad6', '1ec2aab3-fff1-5800-922e-cf5d5f583c68', 'Soomin Lee', 'A2951', 'individual', 4,
    32.0, 26.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3f6b9eda-7fdf-513a-87c0-713e619bc596', 'd1dd5345-6df0-5c42-a196-b911ee214313', 'c43c92c7-4890-5d5d-9f9e-b938fc455ad6', 'Soomin Lee', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '184c532c-c6ce-5ad6-8e9a-7a7aa3e7e9b3', 'd1dd5345-6df0-5c42-a196-b911ee214313', 1, 6.0, NULL, true, '(6)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5e6e9f92-a8a9-58d3-a7c5-7fb92b2d3630', 'd1dd5345-6df0-5c42-a196-b911ee214313', 2, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'db00656f-4d1d-55cb-b151-3502b0691a46', 'd1dd5345-6df0-5c42-a196-b911ee214313', 3, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8658b994-0e74-545b-8d74-316424870382', 'd1dd5345-6df0-5c42-a196-b911ee214313', 4, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '47dcb8d9-ab3c-53c3-9b47-d5c6b4c44df6', 'd1dd5345-6df0-5c42-a196-b911ee214313', 5, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c0a40ed7-1921-5adf-9730-3da62a0a282d', 'd1dd5345-6df0-5c42-a196-b911ee214313', 6, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e4109060-c2af-55e3-a54b-9d8dfac12e6c', 'd1dd5345-6df0-5c42-a196-b911ee214313', 7, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'da878fcd-ed8f-5119-9ff7-2592e82b8ed7', 'd1dd5345-6df0-5c42-a196-b911ee214313', 8, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'efe565fe-ea79-5de1-a619-9e8db8b0cd2b', 'd1dd5345-6df0-5c42-a196-b911ee214313', 9, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '8373faf0-e8ab-52df-8b6e-5b1bf65b93d1', '40a23367-69df-42e3-8907-be4a7919fb4e', '1ec2aab3-fff1-5800-922e-cf5d5f583c68', 'Seoyi An', 'A5363', 'individual', 5,
    58.0, 45.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '59b9a655-d977-57f9-85dd-291ea1e0ea1f', '8373faf0-e8ab-52df-8b6e-5b1bf65b93d1', '40a23367-69df-42e3-8907-be4a7919fb4e', 'Seoyi An', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ae9c23c1-d7db-5980-8a61-f375380f5d77', '8373faf0-e8ab-52df-8b6e-5b1bf65b93d1', 1, 5.0, 'SCP', false, '3+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c0f2afa4-39dd-52d9-907d-0be0f6700e08', '8373faf0-e8ab-52df-8b6e-5b1bf65b93d1', 2, 13.0, 'DNC', true, '(13) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '98e7f89d-7f38-520f-bc8a-c1a2e2805d68', '8373faf0-e8ab-52df-8b6e-5b1bf65b93d1', 3, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '672f0d24-ff90-5769-bada-17d0f55a05b7', '8373faf0-e8ab-52df-8b6e-5b1bf65b93d1', 4, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '04b32655-3a41-5ff1-925c-d3b807f1b0e1', '8373faf0-e8ab-52df-8b6e-5b1bf65b93d1', 5, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ae29579a-e936-5d31-86cd-4759babf7beb', '8373faf0-e8ab-52df-8b6e-5b1bf65b93d1', 6, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '365809af-a24a-502f-85a5-7b8726be4e99', '8373faf0-e8ab-52df-8b6e-5b1bf65b93d1', 7, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9f4e1ea6-81c0-564c-9546-3370725a4e00', '8373faf0-e8ab-52df-8b6e-5b1bf65b93d1', 8, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '75a893da-45ba-5dab-9809-97675eafdab1', '8373faf0-e8ab-52df-8b6e-5b1bf65b93d1', 9, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '88338e74-c6c9-5e8a-b095-ffad86602b0a', '7aa738e9-eccd-519d-a72d-63593fc30e55', '1ec2aab3-fff1-5800-922e-cf5d5f583c68', 'Siwoo Son', 'A5618', 'individual', 6,
    76.0, 63.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4afdaa2d-49f3-5889-8058-8ca7341407a8', '88338e74-c6c9-5e8a-b095-ffad86602b0a', '7aa738e9-eccd-519d-a72d-63593fc30e55', 'Siwoo Son', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '099090f2-a379-5867-9901-90d33c0dc78a', '88338e74-c6c9-5e8a-b095-ffad86602b0a', 1, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '196c69c8-0842-5d9c-a3a9-2b293d1794f5', '88338e74-c6c9-5e8a-b095-ffad86602b0a', 2, 13.0, 'DNC', true, '(13) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3d4c9daa-c141-5b16-9b2f-8f0f158426ce', '88338e74-c6c9-5e8a-b095-ffad86602b0a', 3, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'cf97b544-5181-5e17-a1a2-53b1d42afe98', '88338e74-c6c9-5e8a-b095-ffad86602b0a', 4, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '02e3ca20-b233-5945-bd91-e11f5520dffd', '88338e74-c6c9-5e8a-b095-ffad86602b0a', 5, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '76097737-38e4-5aa4-ae07-eecba2e715b6', '88338e74-c6c9-5e8a-b095-ffad86602b0a', 6, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e7cbb129-538b-5f00-9bd5-ef9c126275e2', '88338e74-c6c9-5e8a-b095-ffad86602b0a', 7, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7d4088bf-1746-5f5a-ac71-09dcdcb5b621', '88338e74-c6c9-5e8a-b095-ffad86602b0a', 8, 11.0, 'SCP', false, '9+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '004509d9-54e9-5570-b88b-e3e08f795a40', '88338e74-c6c9-5e8a-b095-ffad86602b0a', 9, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '1f45e957-66ce-5adc-a5d4-9c6038ce59a2', 'bf7c461a-4dda-51b3-ba94-34a4d9ec8f73', '1ec2aab3-fff1-5800-922e-cf5d5f583c68', 'Iruda Park', 'A3840', 'individual', 7,
    81.0, 68.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6c0e068e-92d7-5134-9825-93d720f1c242', '1f45e957-66ce-5adc-a5d4-9c6038ce59a2', 'bf7c461a-4dda-51b3-ba94-34a4d9ec8f73', 'Iruda Park', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f132d11b-fb05-5ac8-b922-611f6fb0a8a7', '1f45e957-66ce-5adc-a5d4-9c6038ce59a2', 1, 13.0, 'DNC', true, '(13) 트스포 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4979220d-3ebe-50e4-83bf-feb21bc9b826', '1f45e957-66ce-5adc-a5d4-9c6038ce59a2', 2, 13.0, 'DNC', false, '13 츠클 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8d38c1cc-d09f-5f78-bf9f-335ab3f2962f', '1f45e957-66ce-5adc-a5d4-9c6038ce59a2', 3, 13.0, 'DNC', false, '13 럽 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9db832d3-1775-5870-a720-510ace1dfd8c', '1f45e957-66ce-5adc-a5d4-9c6038ce59a2', 4, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c6775297-e59e-5bf9-b740-f0deeae4c77c', '1f45e957-66ce-5adc-a5d4-9c6038ce59a2', 5, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '074bd50e-d3c3-57d1-b88f-38383df12705', '1f45e957-66ce-5adc-a5d4-9c6038ce59a2', 6, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '38b432e4-eb1b-5069-b5b2-2c99ffc6cbe1', '1f45e957-66ce-5adc-a5d4-9c6038ce59a2', 7, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '549a2a27-abd3-50eb-9d26-3ae4085de622', '1f45e957-66ce-5adc-a5d4-9c6038ce59a2', 8, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '57bbd845-db3d-5297-aeb2-b0eb94b3d67d', '1f45e957-66ce-5adc-a5d4-9c6038ce59a2', 9, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '5cb69df0-aa3a-5de3-a2f3-30f4b9ed6972', 'a2c367fd-110a-5da1-94e6-ca3e7228712d', '1ec2aab3-fff1-5800-922e-cf5d5f583c68', 'Hyunji Yoo', 'A6472', 'individual', 8,
    90.0, 77.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2b2fbc7b-a6aa-5288-a6b2-ba26d2fbd93b', '5cb69df0-aa3a-5de3-a2f3-30f4b9ed6972', 'a2c367fd-110a-5da1-94e6-ca3e7228712d', 'Hyunji Yoo', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7060119c-36b7-5903-b6bc-0bf13c77ba13', '5cb69df0-aa3a-5de3-a2f3-30f4b9ed6972', 1, 13.0, 'DNC', true, '(13) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4d3d92b9-7444-5c46-ac39-0539d4b8f38a', '5cb69df0-aa3a-5de3-a2f3-30f4b9ed6972', 2, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9609a170-e60d-5910-9dda-4daf0f2f74ef', '5cb69df0-aa3a-5de3-a2f3-30f4b9ed6972', 3, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'eafcf3f9-b044-5a57-8330-86bafab133fb', '5cb69df0-aa3a-5de3-a2f3-30f4b9ed6972', 4, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'cf4ba816-77c7-5eae-bbe6-4304ffed86f2', '5cb69df0-aa3a-5de3-a2f3-30f4b9ed6972', 5, 13.0, 'DNF', false, '13 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8ad5b8e9-8294-5742-b50c-735af160ab33', '5cb69df0-aa3a-5de3-a2f3-30f4b9ed6972', 6, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5d1e8834-8acd-51d4-b628-9be533290ffb', '5cb69df0-aa3a-5de3-a2f3-30f4b9ed6972', 7, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3753ab76-b39a-5564-a50e-9b94c5fab8bb', '5cb69df0-aa3a-5de3-a2f3-30f4b9ed6972', 8, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'cd3e85f9-4226-574f-9728-532fef7f7a9e', '5cb69df0-aa3a-5de3-a2f3-30f4b9ed6972', 9, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '4cb06987-c75b-5a93-8ef0-34b9705a5b7e', '762f5777-88d4-5d5d-b10a-7e530b9de461', '1ec2aab3-fff1-5800-922e-cf5d5f583c68', 'Wonjun Cho', 'A1954', 'individual', 9,
    90.0, 77.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1bc16dc8-0aa1-589b-9706-d37097f8b248', '4cb06987-c75b-5a93-8ef0-34b9705a5b7e', '762f5777-88d4-5d5d-b10a-7e530b9de461', 'Wonjun Cho', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1e031c76-a8d4-5232-9d16-245e6b37b790', '4cb06987-c75b-5a93-8ef0-34b9705a5b7e', 1, 13.0, 'DNF', true, '(13) 회 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5e9bd1ee-9fc0-5837-9da1-0b979008c29b', '4cb06987-c75b-5a93-8ef0-34b9705a5b7e', 2, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd5aa1702-fc79-5181-836b-5543d177d88d', '4cb06987-c75b-5a93-8ef0-34b9705a5b7e', 3, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4151dba9-73f2-55ab-8f45-01ba9e36df5c', '4cb06987-c75b-5a93-8ef0-34b9705a5b7e', 4, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1019bc6f-9c39-5f51-bd31-d7f3f04df43b', '4cb06987-c75b-5a93-8ef0-34b9705a5b7e', 5, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a636f37c-d0b6-585c-ba9b-b7b3d3172ff0', '4cb06987-c75b-5a93-8ef0-34b9705a5b7e', 6, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0947e90e-1788-54ca-a9bc-5cffd3a16942', '4cb06987-c75b-5a93-8ef0-34b9705a5b7e', 7, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2d9f0757-0840-5eb4-9676-9c0c8390a0dd', '4cb06987-c75b-5a93-8ef0-34b9705a5b7e', 8, 9.0, 'SCP', false, '7+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '65ec11a5-8c2d-5125-884f-5bfb9716412a', '4cb06987-c75b-5a93-8ef0-34b9705a5b7e', 9, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '4808aa23-28f4-58b7-920f-5cf4eaf545f0', 'cca4fc13-ba46-5ea5-a1fb-135b0a28f9aa', '1ec2aab3-fff1-5800-922e-cf5d5f583c68', 'Irin Sung', 'A8075', 'individual', 10,
    104.0, 91.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '801f2f5b-6974-57d2-a08c-05a453282b39', '4808aa23-28f4-58b7-920f-5cf4eaf545f0', 'cca4fc13-ba46-5ea5-a1fb-135b0a28f9aa', 'Irin Sung', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fb9ad983-cca4-54fa-a537-6533addc64cd', '4808aa23-28f4-58b7-920f-5cf4eaf545f0', 1, 13.0, 'DNC', true, '(13) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e0e69076-fcb0-567b-a867-f5e51542f9c4', '4808aa23-28f4-58b7-920f-5cf4eaf545f0', 2, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2071ad49-c2d9-5d8c-8848-4866cd5b3463', '4808aa23-28f4-58b7-920f-5cf4eaf545f0', 3, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '37ef3fe9-6209-5915-90d7-d478fa39186d', '4808aa23-28f4-58b7-920f-5cf4eaf545f0', 4, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '41331a5b-bb57-58fc-a683-5816b40bd33f', '4808aa23-28f4-58b7-920f-5cf4eaf545f0', 5, 9.0, 'SCP', false, '7+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '10288c7a-e382-5317-82a2-5a2ab307e158', '4808aa23-28f4-58b7-920f-5cf4eaf545f0', 6, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '30062b1e-1d5e-5223-841d-5b395ca1d564', '4808aa23-28f4-58b7-920f-5cf4eaf545f0', 7, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2903b1bb-743c-589b-8551-eb5dc4847c27', '4808aa23-28f4-58b7-920f-5cf4eaf545f0', 8, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2a6ad0a5-5d4b-5fe4-9196-06ba2647241a', '4808aa23-28f4-58b7-920f-5cf4eaf545f0', 9, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'e68a7c9a-19f4-5d5b-b0b5-cacbc1693f3a', '16dadfda-5198-534a-a0f4-232c47a23b59', '1ec2aab3-fff1-5800-922e-cf5d5f583c68', 'Taeo Lee', 'A0133', 'individual', 11,
    106.0, 93.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2ab94afd-a971-5c0e-8f75-fa528f3177cb', 'e68a7c9a-19f4-5d5b-b0b5-cacbc1693f3a', '16dadfda-5198-534a-a0f4-232c47a23b59', 'Taeo Lee', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '10b1fb86-33dd-587e-a129-5901d01344c7', 'e68a7c9a-19f4-5d5b-b0b5-cacbc1693f3a', 1, 13.0, 'DNC', true, '(13) 터 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'cf8987bc-2dfd-5f5a-ad11-efeaedbc4438', 'e68a7c9a-19f4-5d5b-b0b5-cacbc1693f3a', 2, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '31f9c100-e5a5-5442-a399-bbeb342b51b5', 'e68a7c9a-19f4-5d5b-b0b5-cacbc1693f3a', 3, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2a90bbc5-a029-5e89-959a-7c44902074ee', 'e68a7c9a-19f4-5d5b-b0b5-cacbc1693f3a', 4, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8d956e57-6d42-5640-99c1-4f4b7f51eeca', 'e68a7c9a-19f4-5d5b-b0b5-cacbc1693f3a', 5, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2af904f4-a53c-5817-a658-fa27258592bb', 'e68a7c9a-19f4-5d5b-b0b5-cacbc1693f3a', 6, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1fa60e57-a5c9-573b-9e04-60f32380f597', 'e68a7c9a-19f4-5d5b-b0b5-cacbc1693f3a', 7, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7f995489-ff5e-53f8-b08b-214dceac9aeb', 'e68a7c9a-19f4-5d5b-b0b5-cacbc1693f3a', 8, 12.0, 'SCP', false, '10+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b791bfa7-2c79-5c95-b9b4-53d758668c9a', 'e68a7c9a-19f4-5d5b-b0b5-cacbc1693f3a', 9, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'e956a4d5-6d78-5f3b-981b-0a1b1ee9dc78', '0de245e7-525c-5ac9-ab89-9eea812f5b04', '1ec2aab3-fff1-5800-922e-cf5d5f583c68', 'Jaemin Cho', 'A6471', 'individual', 12,
    113.0, 100.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '840b1905-b6c8-5d43-a83c-5eaf9a6fe50e', 'e956a4d5-6d78-5f3b-981b-0a1b1ee9dc78', '0de245e7-525c-5ac9-ab89-9eea812f5b04', 'Jaemin Cho', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7908fe1d-6709-53ed-8755-95b9f8033986', 'e956a4d5-6d78-5f3b-981b-0a1b1ee9dc78', 1, 13.0, 'DNC', true, '(13) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0206b374-720f-5efd-8c83-fb7b15b8f111', 'e956a4d5-6d78-5f3b-981b-0a1b1ee9dc78', 2, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd9955ea8-cf48-5265-b0e5-db6d3695022e', 'e956a4d5-6d78-5f3b-981b-0a1b1ee9dc78', 3, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2be1acc0-67ef-5bc7-b87f-6310488bdba3', 'e956a4d5-6d78-5f3b-981b-0a1b1ee9dc78', 4, 13.0, 'DNF', false, '13 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ace7e6d2-8ba6-5e95-85ca-6288025bd30f', 'e956a4d5-6d78-5f3b-981b-0a1b1ee9dc78', 5, 13.0, 'DNF', false, '13 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f7a68937-cd9f-5dc0-8846-7accb36b7fc9', 'e956a4d5-6d78-5f3b-981b-0a1b1ee9dc78', 6, 13.0, 'DNF', false, '13 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9d3010fc-fd86-5553-94c1-0dbdecabd6fa', 'e956a4d5-6d78-5f3b-981b-0a1b1ee9dc78', 7, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4a6ead2c-d0f6-5e96-b38a-adee1da92c4f', 'e956a4d5-6d78-5f3b-981b-0a1b1ee9dc78', 8, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '56eac5cc-ae97-5b67-a1d4-f928c8d22748', 'e956a4d5-6d78-5f3b-981b-0a1b1ee9dc78', 9, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();

INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '6e663267-8607-54a3-9cb8-73407f719ab6',
    '3eab275b-24b8-5e99-8c85-79df5829649a',
    '2026 KSAF President''s Cup National Youth Sailing Championships — ILCA 6',
    'ksaf-presidents-cup-youth-nationals-2026-ilca-6',
    '2026-05-08',
    '2026-05-11',
    12,
    'Open',
    7,
    'KOR',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Seoul Water Leisure Sports Center, Hangang River, Seoul, South Korea',
    'Korea Sailing Federation (대한요트협회 / KSAF)',
    'published',
    'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf',
    '2026 대한요트협회장배(청소년) 전국요트대회 — ILCA 6 Open. Official KSAF Final Results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '3391d49b-14c1-5b98-9fd1-b506c4491af1', '494ea92f-06f2-5fbd-98ee-7e1bd445d2c1', '6e663267-8607-54a3-9cb8-73407f719ab6', 'Taeyang Yoon', 'R7988', 'individual', 1,
    21.0, 15.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '704f1d37-33ad-5f34-a77c-48c8305d4672', '3391d49b-14c1-5b98-9fd1-b506c4491af1', '494ea92f-06f2-5fbd-98ee-7e1bd445d2c1', 'Taeyang Yoon', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '84a7127b-e5f4-5afb-8c82-21f1b08fedd3', '3391d49b-14c1-5b98-9fd1-b506c4491af1', 1, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1d126081-fbc4-5324-a190-1207dda98996', '3391d49b-14c1-5b98-9fd1-b506c4491af1', 2, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '12bd8c0d-f655-5dac-8f49-1b2734c8c29c', '3391d49b-14c1-5b98-9fd1-b506c4491af1', 3, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '90364aba-4219-55c0-a7c1-4dea2fbd8777', '3391d49b-14c1-5b98-9fd1-b506c4491af1', 4, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '489e0ee4-fed4-5595-af0d-b1ae24bd294d', '3391d49b-14c1-5b98-9fd1-b506c4491af1', 5, 6.0, NULL, true, '(6)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3cce7f73-d3e4-5c5a-ac31-19cf856f0eb1', '3391d49b-14c1-5b98-9fd1-b506c4491af1', 6, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '58b0b843-ea0c-5853-af9e-062527ed8386', '3391d49b-14c1-5b98-9fd1-b506c4491af1', 7, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '258938fa-b345-5ca8-90ba-06721d1cd9f7', '589b14b6-5008-5a64-ad4c-5b893e9a92ff', '6e663267-8607-54a3-9cb8-73407f719ab6', 'Chaerin Kim', 'R5573', 'individual', 2,
    22.0, 15.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '24f5eca1-2db6-53b7-8199-0665322ada21', '258938fa-b345-5ca8-90ba-06721d1cd9f7', '589b14b6-5008-5a64-ad4c-5b893e9a92ff', 'Chaerin Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '445341aa-53aa-547e-91ae-8f70eab0d3b8', '258938fa-b345-5ca8-90ba-06721d1cd9f7', 1, 2.0, NULL, false, '2 학교', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd45aff6c-c8ae-5a27-b46e-6979d56578e6', '258938fa-b345-5ca8-90ba-06721d1cd9f7', 2, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '349c8c60-31d2-5b57-8361-2fa63e536953', '258938fa-b345-5ca8-90ba-06721d1cd9f7', 3, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e5139c2b-2376-56b0-bb68-b6ab0c375017', '258938fa-b345-5ca8-90ba-06721d1cd9f7', 4, 7.0, NULL, true, '(7)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0b35c87e-41ba-5b41-8888-23bfb6a44bc8', '258938fa-b345-5ca8-90ba-06721d1cd9f7', 5, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c89a2b7b-e406-5a8b-8425-b1dc044bbcee', '258938fa-b345-5ca8-90ba-06721d1cd9f7', 6, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2cbbc225-2ee6-5344-a45c-95afb38ae544', '258938fa-b345-5ca8-90ba-06721d1cd9f7', 7, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '0e1e621e-5c4e-50b1-8e2c-61a075160415', 'ebc54a7f-d9ff-597a-8bed-78b8a7667b32', '6e663267-8607-54a3-9cb8-73407f719ab6', 'Hyundo Jang', 'R9165', 'individual', 3,
    26.0, 20.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '04c0bf91-a235-5746-8a54-6b76d0ef5185', '0e1e621e-5c4e-50b1-8e2c-61a075160415', 'ebc54a7f-d9ff-597a-8bed-78b8a7667b32', 'Hyundo Jang', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8313349b-d3fb-5f05-87e2-bfec41759556', '0e1e621e-5c4e-50b1-8e2c-61a075160415', 1, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8dbfdce4-6493-593d-8b84-4d0ea7e393dd', '0e1e621e-5c4e-50b1-8e2c-61a075160415', 2, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '78ecda92-fa40-5012-b8d5-4488a47aa5f6', '0e1e621e-5c4e-50b1-8e2c-61a075160415', 3, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4ea7fb19-3d9f-5770-9a19-a35fc14bdf32', '0e1e621e-5c4e-50b1-8e2c-61a075160415', 4, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2be07499-9fb8-53cf-8df0-e69f3bd6de81', '0e1e621e-5c4e-50b1-8e2c-61a075160415', 5, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '87bf5781-15f3-5fc9-9c88-5d4c11c880da', '0e1e621e-5c4e-50b1-8e2c-61a075160415', 6, 6.0, NULL, true, '(6)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7bf724a0-d170-5fcd-93f1-88594359b698', '0e1e621e-5c4e-50b1-8e2c-61a075160415', 7, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'e4270a9a-f19c-5b2c-80e6-40350dcfa157', 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd', '6e663267-8607-54a3-9cb8-73407f719ab6', 'Dayeon Yang', 'R4349', 'individual', 4,
    35.0, 27.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a313df3e-d06e-5268-a5c2-8ca3e3fe5d62', 'e4270a9a-f19c-5b2c-80e6-40350dcfa157', 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd', 'Dayeon Yang', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e06cdb75-f4e5-5ca1-aee6-c566706b849a', 'e4270a9a-f19c-5b2c-80e6-40350dcfa157', 1, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd4a9b87c-8994-58c6-987a-8a91412677ac', 'e4270a9a-f19c-5b2c-80e6-40350dcfa157', 2, 8.0, NULL, true, '(8)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b9ee7997-2e54-5e89-9473-5f3f389f261b', 'e4270a9a-f19c-5b2c-80e6-40350dcfa157', 3, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4ff74e16-153f-57ec-96ed-97f19ea6dc71', 'e4270a9a-f19c-5b2c-80e6-40350dcfa157', 4, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'cf2948d3-f112-5aa0-b2e0-39be65a28ad4', 'e4270a9a-f19c-5b2c-80e6-40350dcfa157', 5, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2e9e97be-25d8-5ed7-8509-a07f955a3e13', 'e4270a9a-f19c-5b2c-80e6-40350dcfa157', 6, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8dce8d3e-f07d-5798-8308-d433977b6e98', 'e4270a9a-f19c-5b2c-80e6-40350dcfa157', 7, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '159b5e41-56a1-5576-8ae7-1e6027da854d', '614aed23-b0ac-51bc-85bb-0f526dffe60c', '6e663267-8607-54a3-9cb8-73407f719ab6', 'Eunju Kim', 'R1038', 'individual', 5,
    42.0, 29.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ec044b82-86a6-5127-a70c-0693edec99c8', '159b5e41-56a1-5576-8ae7-1e6027da854d', '614aed23-b0ac-51bc-85bb-0f526dffe60c', 'Eunju Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f0c82f14-95a0-5f70-9e66-ef0db830cd2f', '159b5e41-56a1-5576-8ae7-1e6027da854d', 1, 13.0, 'DNF', true, '(13) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8aa7c95a-e6a9-5759-9d99-d30da1aae88d', '159b5e41-56a1-5576-8ae7-1e6027da854d', 2, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b95f905a-c015-590c-b1a9-eb05df36d0e0', '159b5e41-56a1-5576-8ae7-1e6027da854d', 3, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3f215ffb-3197-5edd-98b9-191b1eda081e', '159b5e41-56a1-5576-8ae7-1e6027da854d', 4, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '47155b65-1ce4-549b-9396-f65ecdc13b07', '159b5e41-56a1-5576-8ae7-1e6027da854d', 5, 9.0, 'SCP', false, '7+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '91d3bbc8-70f9-5d36-9e97-93a6f97efa81', '159b5e41-56a1-5576-8ae7-1e6027da854d', 6, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '593bfc8c-7382-51b8-95a4-dcd4233a45f8', '159b5e41-56a1-5576-8ae7-1e6027da854d', 7, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '9a51e421-33eb-5b3c-9230-2d3a54530124', 'cbe7bbbc-52f2-53ca-b5f4-ad6ae2d538a7', '6e663267-8607-54a3-9cb8-73407f719ab6', 'Minsol Jeon', 'R8141', 'individual', 6,
    44.0, 31.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3816a95b-b5a2-5a5a-9aba-53c3fa09a1ad', '9a51e421-33eb-5b3c-9230-2d3a54530124', 'cbe7bbbc-52f2-53ca-b5f4-ad6ae2d538a7', 'Minsol Jeon', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '40fd22f0-6e6e-566b-9f8d-ddf0754e7d1c', '9a51e421-33eb-5b3c-9230-2d3a54530124', 1, 13.0, 'DNF', true, '(13) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ca24aeaa-cd55-5dff-9185-48849f6a64a2', '9a51e421-33eb-5b3c-9230-2d3a54530124', 2, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3637969e-4523-5e84-880e-b4ce346e7015', '9a51e421-33eb-5b3c-9230-2d3a54530124', 3, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f244e58e-10f5-55b8-a44b-9f6be68c3954', '9a51e421-33eb-5b3c-9230-2d3a54530124', 4, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '953455c5-613b-58f6-9776-51d9064fc5c7', '9a51e421-33eb-5b3c-9230-2d3a54530124', 5, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9156977b-0239-571b-873f-21fe829a3f0a', '9a51e421-33eb-5b3c-9230-2d3a54530124', 6, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '01c4b701-7ae0-517d-a2df-ca1b8d782880', '9a51e421-33eb-5b3c-9230-2d3a54530124', 7, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '39ad2c11-6805-54df-9830-19f1058bd323', '18d5835a-63bb-57e2-bc9e-357856d46310', '6e663267-8607-54a3-9cb8-73407f719ab6', 'Junsoo Park', 'R2952', 'individual', 7,
    39.0, 31.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '327e7c4d-e42a-5b7c-bd60-5d6c59c05447', '39ad2c11-6805-54df-9830-19f1058bd323', '18d5835a-63bb-57e2-bc9e-357856d46310', 'Junsoo Park', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2af8a5f0-85a1-5555-b318-60c9f68cfc3d', '39ad2c11-6805-54df-9830-19f1058bd323', 1, 4.0, NULL, false, '4 트스포', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '604ca67e-b21c-5671-8b3e-4f30b99c4e9e', '39ad2c11-6805-54df-9830-19f1058bd323', 2, 6.0, NULL, false, '6 츠클', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '00365ae7-07dc-5423-876a-486a9c2174cd', '39ad2c11-6805-54df-9830-19f1058bd323', 3, 7.0, NULL, false, '7 럽', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '76384a00-b477-5b76-a79e-dc23fdd92894', '39ad2c11-6805-54df-9830-19f1058bd323', 4, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2d4d455c-56e6-5097-8759-7a57012303fe', '39ad2c11-6805-54df-9830-19f1058bd323', 5, 7.0, 'SCP', false, '5+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '77e3d6b6-98c4-51ce-9937-49d79d814954', '39ad2c11-6805-54df-9830-19f1058bd323', 6, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '00f8a231-496a-51e1-a2ee-fda3f07895ea', '39ad2c11-6805-54df-9830-19f1058bd323', 7, 8.0, NULL, true, '(8)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'c4c8d81a-87e1-52fc-a0bb-df5e686c1e0f', '81f7dac1-afaa-58e3-aee8-55002af74eed', '6e663267-8607-54a3-9cb8-73407f719ab6', 'Seonghee Park', 'R2078', 'individual', 8,
    51.0, 38.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c9d71824-6959-5d0e-8759-266fce7b29ea', 'c4c8d81a-87e1-52fc-a0bb-df5e686c1e0f', '81f7dac1-afaa-58e3-aee8-55002af74eed', 'Seonghee Park', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7227c19b-52c5-5899-8fa5-b964893d4252', 'c4c8d81a-87e1-52fc-a0bb-df5e686c1e0f', 1, 13.0, 'DNF', true, '(13) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e83dadd0-f46f-5283-9e7d-1e1d9dd196ad', 'c4c8d81a-87e1-52fc-a0bb-df5e686c1e0f', 2, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'bcb3f9ce-d824-57f9-aca4-55f54e3a71a2', 'c4c8d81a-87e1-52fc-a0bb-df5e686c1e0f', 3, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd956be34-52e2-584e-a73e-4a82e7ab58b2', 'c4c8d81a-87e1-52fc-a0bb-df5e686c1e0f', 4, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4ff8af0a-dca0-54c0-95af-57efe9ac5f12', 'c4c8d81a-87e1-52fc-a0bb-df5e686c1e0f', 5, 6.0, 'SCP', false, '4+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6b024e67-e72e-536f-b42a-efd257d139b1', 'c4c8d81a-87e1-52fc-a0bb-df5e686c1e0f', 6, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7616be5a-81f7-5758-b75d-6f1ffc35d477', 'c4c8d81a-87e1-52fc-a0bb-df5e686c1e0f', 7, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'e5909132-131e-5a36-b3d0-88a7fffc673e', '691c0dfb-32c6-5f83-9373-5b18473000c0', '6e663267-8607-54a3-9cb8-73407f719ab6', 'Jihwang Hong', 'R0007', 'individual', 9,
    73.0, 60.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f194fd72-c88e-5b51-b882-5a920b641cfd', 'e5909132-131e-5a36-b3d0-88a7fffc673e', '691c0dfb-32c6-5f83-9373-5b18473000c0', 'Jihwang Hong', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6cb25998-6525-5b8c-bc82-0e03f078d1b2', 'e5909132-131e-5a36-b3d0-88a7fffc673e', 1, 13.0, 'DNF', true, '(13) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'bfdf3874-bdd9-53c0-80dd-da4480c5c0b2', 'e5909132-131e-5a36-b3d0-88a7fffc673e', 2, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1502c7fc-e0f3-5960-b534-fe5fb89f90f7', 'e5909132-131e-5a36-b3d0-88a7fffc673e', 3, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b0303134-515f-5e2a-906b-69f9afc0c038', 'e5909132-131e-5a36-b3d0-88a7fffc673e', 4, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5ce86075-44e6-54de-a1ca-8fbaafe24712', 'e5909132-131e-5a36-b3d0-88a7fffc673e', 5, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2fdc9cc7-f33e-5d88-a3ee-de26f4d37c30', 'e5909132-131e-5a36-b3d0-88a7fffc673e', 6, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7d8fb78d-9c3a-519a-9bf7-eb786da71667', 'e5909132-131e-5a36-b3d0-88a7fffc673e', 7, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '72ac8542-833a-50cf-9632-6500e7fd3c4e', '48a62823-a8c0-5110-ab3b-35a1363380df', '6e663267-8607-54a3-9cb8-73407f719ab6', 'Minseo Song', 'R1044', 'individual', 10,
    80.0, 67.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0c494346-a55d-5085-bbe6-ac4c90f2f6d0', '72ac8542-833a-50cf-9632-6500e7fd3c4e', '48a62823-a8c0-5110-ab3b-35a1363380df', 'Minseo Song', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'cfcba5a4-38eb-5f0c-b4b7-6585c9d5898b', '72ac8542-833a-50cf-9632-6500e7fd3c4e', 1, 13.0, 'DNF', true, '(13) 학교 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'eab11f78-6e81-549b-ad00-761f9681a8cf', '72ac8542-833a-50cf-9632-6500e7fd3c4e', 2, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3e1c6995-cb38-54dd-abb0-3bee4f129576', '72ac8542-833a-50cf-9632-6500e7fd3c4e', 3, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e57cfd13-d340-56d2-b04c-b2287c14433b', '72ac8542-833a-50cf-9632-6500e7fd3c4e', 4, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ebd64a39-b66e-5775-93ac-9de42c7534a5', '72ac8542-833a-50cf-9632-6500e7fd3c4e', 5, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '81067448-cf7b-5b5b-b7f0-5ff07a9c2f1d', '72ac8542-833a-50cf-9632-6500e7fd3c4e', 6, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fb6732f9-64e6-5378-bf24-bd1b124418f6', '72ac8542-833a-50cf-9632-6500e7fd3c4e', 7, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '3abac4a4-b31c-57c3-9938-007b2995f226', '14fe3b82-94ea-56e4-a9ee-4b783aa82a58', '6e663267-8607-54a3-9cb8-73407f719ab6', 'Chayun Lim', 'R5056', 'individual', 11,
    82.0, 69.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ea9df275-b3a9-55c2-b871-e9d399f3285d', '3abac4a4-b31c-57c3-9938-007b2995f226', '14fe3b82-94ea-56e4-a9ee-4b783aa82a58', 'Chayun Lim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5f8b5d16-17a5-53b7-ba4c-e0d10c773300', '3abac4a4-b31c-57c3-9938-007b2995f226', 1, 13.0, 'DNF', true, '(13) 학교 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4cb5cb55-de85-5c02-ae8e-fbc57643a785', '3abac4a4-b31c-57c3-9938-007b2995f226', 2, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9dcc70bd-e001-58fd-8c9f-11c1ff57eafd', '3abac4a4-b31c-57c3-9938-007b2995f226', 3, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd7b6ad45-1ac2-5d27-a243-292d7923524c', '3abac4a4-b31c-57c3-9938-007b2995f226', 4, 10.0, NULL, false, '10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ba1ce1f0-a842-5235-80b9-1718ee98da48', '3abac4a4-b31c-57c3-9938-007b2995f226', 5, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ead4b232-d23c-589e-8e46-10c7f87f1d44', '3abac4a4-b31c-57c3-9938-007b2995f226', 6, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '26d0d6a5-25bc-5b85-9570-43601ac487f6', '3abac4a4-b31c-57c3-9938-007b2995f226', 7, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '57349a12-ae17-5cc7-a874-f8d7ba3b414d', '4a0c6b2c-f3bb-5744-88a2-c11838bff08b', '6e663267-8607-54a3-9cb8-73407f719ab6', 'Hyunwoo Jung', 'R6512', 'individual', 12,
    86.0, 73.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2582cceb-62a6-5b2d-bb27-cfc2001a2548', '57349a12-ae17-5cc7-a874-f8d7ba3b414d', '4a0c6b2c-f3bb-5744-88a2-c11838bff08b', 'Hyunwoo Jung', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6d879b81-ca0c-5a4b-ba58-a653897d1dd9', '57349a12-ae17-5cc7-a874-f8d7ba3b414d', 1, 13.0, 'DNF', true, '(13) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd827541b-7795-5018-a2d5-db36021fea1f', '57349a12-ae17-5cc7-a874-f8d7ba3b414d', 2, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e7613715-5f84-5135-a5a0-fa2671417b76', '57349a12-ae17-5cc7-a874-f8d7ba3b414d', 3, 13.0, 'DNC', false, '13 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3e07ec08-f33a-5dde-b22f-d06e338781f9', '57349a12-ae17-5cc7-a874-f8d7ba3b414d', 4, 12.0, NULL, false, '12', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4943f1e4-437f-5011-8c41-838832d7acb9', '57349a12-ae17-5cc7-a874-f8d7ba3b414d', 5, 12.0, NULL, false, '12', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '467fd05b-ded7-56d8-a92c-aaa8d24e1692', '57349a12-ae17-5cc7-a874-f8d7ba3b414d', 6, 12.0, NULL, false, '12', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2c6889d1-3b2c-54f5-8ca9-8573cfd49dcd', '57349a12-ae17-5cc7-a874-f8d7ba3b414d', 7, 11.0, NULL, false, '11', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();

INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '7fb12354-3a00-5691-9088-9bc5cd7bd3d4',
    '3eab275b-24b8-5e99-8c85-79df5829649a',
    '2026 KSAF President''s Cup National Youth Sailing Championships — ILCA 7',
    'ksaf-presidents-cup-youth-nationals-2026-ilca-7',
    '2026-05-08',
    '2026-05-11',
    9,
    'High School Boys',
    8,
    'KOR',
    'ILCA 7',
    'individual',
    1,
    1,
    false,
    'Seoul Water Leisure Sports Center, Hangang River, Seoul, South Korea',
    'Korea Sailing Federation (대한요트협회 / KSAF)',
    'published',
    'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf',
    '2026 대한요트협회장배(청소년) 전국요트대회 — ILCA 7 High School Boys. Official KSAF Final Results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '32555637-7baa-5083-8364-b1981af824c6', '5264ce32-f38f-507a-8d4b-e4757f4b2e64', '7fb12354-3a00-5691-9088-9bc5cd7bd3d4', 'Jun Han', 'L9715', 'individual', 1,
    20.0, 10.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0ca14c34-c27f-56d8-95e9-cf3447568d7c', '32555637-7baa-5083-8364-b1981af824c6', '5264ce32-f38f-507a-8d4b-e4757f4b2e64', 'Jun Han', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c5bfb1c2-ef05-59bc-8e31-6c90a4afc2bc', '32555637-7baa-5083-8364-b1981af824c6', 1, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '182b5918-5c28-5775-b318-b27ef88f0ad6', '32555637-7baa-5083-8364-b1981af824c6', 2, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0d22b347-8cb3-5fe3-9a2b-f9b6c923d940', '32555637-7baa-5083-8364-b1981af824c6', 3, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fd8c6cef-87cb-5ab8-8b34-a0a9c19567a7', '32555637-7baa-5083-8364-b1981af824c6', 4, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ff20db24-a3fa-5855-8fb1-dd59242f3cc4', '32555637-7baa-5083-8364-b1981af824c6', 5, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f2e00fb8-5b8d-5663-a64d-36d162b372b9', '32555637-7baa-5083-8364-b1981af824c6', 6, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '453794be-001d-5102-b9dc-be3e0ffbf229', '32555637-7baa-5083-8364-b1981af824c6', 7, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e0304f0b-36a7-578f-9455-9d2a6794e1d0', '32555637-7baa-5083-8364-b1981af824c6', 8, 10.0, 'DNC', true, '(10) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '20ce66f8-643c-56cd-b1b8-7089729034e9', '65e15ab2-5157-51ad-85d8-9f12a42cdea8', '7fb12354-3a00-5691-9088-9bc5cd7bd3d4', 'Seyun Kim', 'L2080', 'individual', 2,
    24.0, 14.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c870036f-6a47-5d09-b2f2-eac75ff231f8', '20ce66f8-643c-56cd-b1b8-7089729034e9', '65e15ab2-5157-51ad-85d8-9f12a42cdea8', 'Seyun Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '653d6239-8849-5598-a57a-c05506020ace', '20ce66f8-643c-56cd-b1b8-7089729034e9', 1, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e5bd9719-74da-53e7-b77c-7238de5c0bdd', '20ce66f8-643c-56cd-b1b8-7089729034e9', 2, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8d9ef009-d03f-5dbc-808f-884f6b57f355', '20ce66f8-643c-56cd-b1b8-7089729034e9', 3, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c6b5ba35-b4ec-5bd5-8bd5-2615293c645f', '20ce66f8-643c-56cd-b1b8-7089729034e9', 4, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '21809466-a337-5b15-a707-42e0ec843119', '20ce66f8-643c-56cd-b1b8-7089729034e9', 5, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '79792cd9-166b-5c0b-8726-dd060b001f41', '20ce66f8-643c-56cd-b1b8-7089729034e9', 6, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4c41954c-50a8-5ab8-be35-02524cda9d64', '20ce66f8-643c-56cd-b1b8-7089729034e9', 7, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a8e8ada3-e82b-54c4-ac8a-417d7b63cd14', '20ce66f8-643c-56cd-b1b8-7089729034e9', 8, 10.0, 'DNC', true, '(10) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'fee39172-6165-540f-af2b-15e520484fa3', '3f836035-f916-5df9-8b3f-3c3db9299b71', '7fb12354-3a00-5691-9088-9bc5cd7bd3d4', 'Minhu Kim', 'L4673', 'individual', 3,
    39.0, 29.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1c6db66d-2324-54d1-b341-cc438748a9ec', 'fee39172-6165-540f-af2b-15e520484fa3', '3f836035-f916-5df9-8b3f-3c3db9299b71', 'Minhu Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '550a909f-c05e-53dc-a3a3-e87904f0546e', 'fee39172-6165-540f-af2b-15e520484fa3', 1, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b1164e15-2e68-5460-ada8-426b506a975d', 'fee39172-6165-540f-af2b-15e520484fa3', 2, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2692a6f5-22fb-5b3e-bd65-c37d1c737074', 'fee39172-6165-540f-af2b-15e520484fa3', 3, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6cd538be-5ed4-5680-bbe9-aabf210d6b8e', 'fee39172-6165-540f-af2b-15e520484fa3', 4, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c09b4cac-df44-5dfb-a6d1-e7481f7acf15', 'fee39172-6165-540f-af2b-15e520484fa3', 5, 6.0, 'SCP', false, '4+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '638a8adf-1d9d-52ca-8e00-dd1aabb64626', 'fee39172-6165-540f-af2b-15e520484fa3', 6, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c5847c29-6e25-583e-8d1d-4bb127af1279', 'fee39172-6165-540f-af2b-15e520484fa3', 7, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd56d6551-a5c0-5147-b5ea-65b7f22c5198', 'fee39172-6165-540f-af2b-15e520484fa3', 8, 10.0, 'DNC', true, '(10) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '6c5da39f-fdf4-5379-96d0-0752af6b969c', '7302a702-2b88-5d53-a946-0bd10f257f43', '7fb12354-3a00-5691-9088-9bc5cd7bd3d4', 'Jeongyeon Kim', 'L8818', 'individual', 4,
    42.0, 32.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'eefad704-da65-523c-a614-87e0ba779460', '6c5da39f-fdf4-5379-96d0-0752af6b969c', '7302a702-2b88-5d53-a946-0bd10f257f43', 'Jeongyeon Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9d28ef20-278a-5729-8a42-363470f21413', '6c5da39f-fdf4-5379-96d0-0752af6b969c', 1, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '13d4e256-c4cc-5b94-9350-9067c1f3d678', '6c5da39f-fdf4-5379-96d0-0752af6b969c', 2, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a2b8679c-bd14-52d1-9987-bca5a4c9815a', '6c5da39f-fdf4-5379-96d0-0752af6b969c', 3, 7.0, 'SCP', false, '5+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c6996ccc-8e7b-55a0-8749-4b32e9b12278', '6c5da39f-fdf4-5379-96d0-0752af6b969c', 4, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fb49010f-7f9d-554e-b3f8-a757b8426d24', '6c5da39f-fdf4-5379-96d0-0752af6b969c', 5, 10.0, 'OCS', true, '(10) OCS', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b6ee6383-2062-5a16-9743-8e6110fe8941', '6c5da39f-fdf4-5379-96d0-0752af6b969c', 6, 10.0, 'OCS', false, '10 OCS', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6f9e581c-b24d-5a1f-80c8-9c05dcfe9972', '6c5da39f-fdf4-5379-96d0-0752af6b969c', 7, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9cad5f57-38d1-5f04-ba8b-6146db1f47f4', '6c5da39f-fdf4-5379-96d0-0752af6b969c', 8, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '073dc250-fe40-59f0-b332-f139f20e7da9', '5590ae28-9ad5-580b-8b62-f4cd0b6b1c93', '7fb12354-3a00-5691-9088-9bc5cd7bd3d4', 'Nara Han', 'L3204', 'individual', 5,
    42.0, 32.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '69b0f164-3697-5d03-8f9f-a92651809355', '073dc250-fe40-59f0-b332-f139f20e7da9', '5590ae28-9ad5-580b-8b62-f4cd0b6b1c93', 'Nara Han', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '544c35b2-7d75-5734-99b5-7107bbe5e6ad', '073dc250-fe40-59f0-b332-f139f20e7da9', 1, 10.0, 'DNF', true, '(10) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '295bde55-693d-50fa-a1b3-5b4cad727031', '073dc250-fe40-59f0-b332-f139f20e7da9', 2, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'be455479-a46a-5e48-9487-a3cd2ef48f55', '073dc250-fe40-59f0-b332-f139f20e7da9', 3, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f1d0c4c1-0397-5740-a439-55354be79701', '073dc250-fe40-59f0-b332-f139f20e7da9', 4, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f002fe25-7b63-5c08-8aa4-0c877b5d267d', '073dc250-fe40-59f0-b332-f139f20e7da9', 5, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8e008c4a-555e-5c1a-8f56-030262ff7271', '073dc250-fe40-59f0-b332-f139f20e7da9', 6, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '35888d95-03c1-503a-8b26-a82960eee946', '073dc250-fe40-59f0-b332-f139f20e7da9', 7, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4b74a5e8-3563-56e0-be6a-5eb130901d85', '073dc250-fe40-59f0-b332-f139f20e7da9', 8, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'd2a178a6-702f-55e2-b9d6-7b6df460ade4', 'd86ac1bf-fcbc-54bc-892b-63b75a5ecdcc', '7fb12354-3a00-5691-9088-9bc5cd7bd3d4', 'Haeseo Song', 'L2076', 'individual', 6,
    44.0, 35.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1eae6caf-5c9f-5b5c-adac-bc00b6f48d8d', 'd2a178a6-702f-55e2-b9d6-7b6df460ade4', 'd86ac1bf-fcbc-54bc-892b-63b75a5ecdcc', 'Haeseo Song', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '06d60562-53fb-5dbf-975c-c9bd0664e314', 'd2a178a6-702f-55e2-b9d6-7b6df460ade4', 1, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '073cdaa0-f879-55c4-b9a4-385f55fd1908', 'd2a178a6-702f-55e2-b9d6-7b6df460ade4', 2, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9a2bada6-051f-54e2-8dda-bb278dd1023b', 'd2a178a6-702f-55e2-b9d6-7b6df460ade4', 3, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9da821f5-81e0-54cb-92cb-55f0583dd21e', 'd2a178a6-702f-55e2-b9d6-7b6df460ade4', 4, 9.0, NULL, true, '(9)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'df1ec76c-7a08-5ecc-af6d-c3e2a8775144', 'd2a178a6-702f-55e2-b9d6-7b6df460ade4', 5, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c8700e64-669f-52fe-b887-4faa6f1cf444', 'd2a178a6-702f-55e2-b9d6-7b6df460ade4', 6, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f5725f14-3b26-5786-89ad-5146dc2dc197', 'd2a178a6-702f-55e2-b9d6-7b6df460ade4', 7, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '229f03d2-ba7f-5a3d-a5e7-411b520c8b7a', 'd2a178a6-702f-55e2-b9d6-7b6df460ade4', 8, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '843bd039-11fc-5580-b245-f8595c072919', 'b42c9278-742b-5d1a-a60e-ec352f9c5f0b', '7fb12354-3a00-5691-9088-9bc5cd7bd3d4', 'Jian Kim', 'L9717', 'individual', 7,
    49.0, 39.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '21f7fac7-275b-5313-a529-6541733eea85', '843bd039-11fc-5580-b245-f8595c072919', 'b42c9278-742b-5d1a-a60e-ec352f9c5f0b', 'Jian Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd16fe3ac-6b62-5ed8-a632-ad1ea0925523', '843bd039-11fc-5580-b245-f8595c072919', 1, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'aa4492bf-32fa-50c5-84f0-96ff8ff1f6e1', '843bd039-11fc-5580-b245-f8595c072919', 2, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1e2f1bfa-f3a6-5bc3-bcc2-8f6c2571b2bf', '843bd039-11fc-5580-b245-f8595c072919', 3, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fbe08f45-2abf-56d9-8069-c151eac70fa3', '843bd039-11fc-5580-b245-f8595c072919', 4, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8bab5e49-8069-5684-bfa7-7f7e9fc206db', '843bd039-11fc-5580-b245-f8595c072919', 5, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '73803ab8-38c2-5ebd-b2b0-19fcf554dd79', '843bd039-11fc-5580-b245-f8595c072919', 6, 10.0, 'OCS', true, '(10) OCS', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e713d953-af8d-5c63-8973-da76e5ece36f', '843bd039-11fc-5580-b245-f8595c072919', 7, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0d66b087-1187-5cfc-ac93-30bfe69dc8d0', '843bd039-11fc-5580-b245-f8595c072919', 8, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '11c24572-b1a4-59a9-98e7-8f74c9fc3377', 'd5950089-a98b-528b-83d6-3582f48dacb9', '7fb12354-3a00-5691-9088-9bc5cd7bd3d4', 'Woojun Lim', 'L6910', 'individual', 8,
    65.0, 55.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0049f784-ed55-5b3b-b3e9-dcb8e9038b9e', '11c24572-b1a4-59a9-98e7-8f74c9fc3377', 'd5950089-a98b-528b-83d6-3582f48dacb9', 'Woojun Lim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e9a6b8bf-efc0-5828-a3a4-21536c6f53d9', '11c24572-b1a4-59a9-98e7-8f74c9fc3377', 1, 5.0, NULL, false, '5 트스포', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '17986f3e-ca4c-54ec-b406-4837f5d8143e', '11c24572-b1a4-59a9-98e7-8f74c9fc3377', 2, 10.0, 'DNC', true, '(10) 츠클 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '88b2f0a5-a4a1-5268-8dda-0cde54cebce4', '11c24572-b1a4-59a9-98e7-8f74c9fc3377', 3, 10.0, 'DNC', false, '10 럽 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '28ecc816-c71c-59d9-9622-60007229af02', '11c24572-b1a4-59a9-98e7-8f74c9fc3377', 4, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '01d19f50-72cd-5d9b-a654-e204faee8a03', '11c24572-b1a4-59a9-98e7-8f74c9fc3377', 5, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '379de0c3-516b-5589-8062-f7b381522e6e', '11c24572-b1a4-59a9-98e7-8f74c9fc3377', 6, 10.0, 'OCS', false, '10 OCS', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3f702981-eb48-5d95-a9da-13a0ea72714b', '11c24572-b1a4-59a9-98e7-8f74c9fc3377', 7, 10.0, 'DNF', false, '10 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4df88f35-491f-5466-a471-039ac9dd9f8a', '11c24572-b1a4-59a9-98e7-8f74c9fc3377', 8, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '1ae22b28-107a-5535-ad7c-f4f5606436f7', '5f0599cb-4ec2-5bfa-bf38-aa408971c70e', '7fb12354-3a00-5691-9088-9bc5cd7bd3d4', 'Changjeong Lee', 'L2077', 'individual', 9,
    66.0, 56.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7da38209-7761-5329-ac63-89020455d613', '1ae22b28-107a-5535-ad7c-f4f5606436f7', '5f0599cb-4ec2-5bfa-bf38-aa408971c70e', 'Changjeong Lee', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9c36a0c4-d745-5e2b-9fb2-1959d8f21621', '1ae22b28-107a-5535-ad7c-f4f5606436f7', 1, 10.0, 'DNF', true, '(10) 클럽 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5b114ec7-f602-50fb-9b16-8b3373de802c', '1ae22b28-107a-5535-ad7c-f4f5606436f7', 2, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ed11010a-350f-589c-9a14-7c9958682b02', '1ae22b28-107a-5535-ad7c-f4f5606436f7', 3, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e6bc9838-c05d-5ff8-838f-34b9cf51aa66', '1ae22b28-107a-5535-ad7c-f4f5606436f7', 4, 9.0, 'SCP', false, '7+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '71ba298b-f898-5213-aa61-e7e7e96064c5', '1ae22b28-107a-5535-ad7c-f4f5606436f7', 5, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'baa35b2e-c66e-5f88-8bb3-d1cf03dc293a', '1ae22b28-107a-5535-ad7c-f4f5606436f7', 6, 8.0, 'SCP', false, '6+2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4d5f4e10-166a-5b8c-8a37-d69fe974b55f', '1ae22b28-107a-5535-ad7c-f4f5606436f7', 7, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'dac12b10-cb62-5994-9124-74d78aa467d2', '1ae22b28-107a-5535-ad7c-f4f5606436f7', 8, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();

INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '16e59a47-683f-5b49-9fa2-509e71504cf6',
    '3eab275b-24b8-5e99-8c85-79df5829649a',
    '2026 KSAF President''s Cup National Youth Sailing Championships — 420',
    'ksaf-presidents-cup-youth-nationals-2026-420',
    '2026-05-08',
    '2026-05-11',
    9,
    'Open',
    8,
    'KOR',
    '420',
    'crew',
    2,
    2,
    false,
    'Seoul Water Leisure Sports Center, Hangang River, Seoul, South Korea',
    'Korea Sailing Federation (대한요트협회 / KSAF)',
    'published',
    'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf',
    '2026 대한요트협회장배(청소년) 전국요트대회 — 420 Open. Official KSAF Final Results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'cdafed22-fcd4-5ddb-aae9-968c651a9ef7', '4f07e11b-6571-5bb0-9ebc-9cc563ff792a', '16e59a47-683f-5b49-9fa2-509e71504cf6', 'Dongwoo Ryu / Hamin Park', 'B7633', 'crew', 1,
    19.0, 9.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6f92b09d-5bde-5609-8cd5-32a6bf750faf', 'cdafed22-fcd4-5ddb-aae9-968c651a9ef7', '4f07e11b-6571-5bb0-9ebc-9cc563ff792a', 'Dongwoo Ryu', 1, 'helm', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '575f9a76-4f5d-59ec-abca-aef3907c6942', 'cdafed22-fcd4-5ddb-aae9-968c651a9ef7', 'ed96e55d-4d69-57f4-a1b8-5d3edb20cf0f', 'Hamin Park', 2, 'crew', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b319c7b9-5646-5e3a-a446-ab31334f74ea', 'cdafed22-fcd4-5ddb-aae9-968c651a9ef7', 1, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b79ff077-c4bd-5d81-80e5-4c4e328cd5b6', 'cdafed22-fcd4-5ddb-aae9-968c651a9ef7', 2, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '610e8b63-6938-53eb-b251-ca560e1f7d47', 'cdafed22-fcd4-5ddb-aae9-968c651a9ef7', 3, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '506de30e-7364-5744-b09b-642b9c34c71f', 'cdafed22-fcd4-5ddb-aae9-968c651a9ef7', 4, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '99fa4518-7d56-5c35-8509-eb5c77f8645c', 'cdafed22-fcd4-5ddb-aae9-968c651a9ef7', 5, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7647a94e-2795-5d8a-9bba-b0b49dbc8f2d', 'cdafed22-fcd4-5ddb-aae9-968c651a9ef7', 6, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '40d9c92b-c270-5a25-9e24-ecf06e772cf3', 'cdafed22-fcd4-5ddb-aae9-968c651a9ef7', 7, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '157dd966-9747-5b2a-852f-f4f4fb25de7a', 'cdafed22-fcd4-5ddb-aae9-968c651a9ef7', 8, 10.0, 'DNC', true, 'DNC 10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '4e3fe9d1-6e21-504e-adc2-eabfe57d6054', '250182ae-9801-5596-877f-adfaf2585d07', '16e59a47-683f-5b49-9fa2-509e71504cf6', 'Gaeun Choi / Taerin Kim', 'B7263', 'crew', 2,
    21.0, 15.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'cee1901c-3f2f-54ae-acd9-887467dba2d4', '4e3fe9d1-6e21-504e-adc2-eabfe57d6054', '250182ae-9801-5596-877f-adfaf2585d07', 'Gaeun Choi', 1, 'helm', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b2a4fe97-2100-55cb-a677-73bc35adc15c', '4e3fe9d1-6e21-504e-adc2-eabfe57d6054', '9c0c85a6-95b5-5578-8743-f0491d93602f', 'Taerin Kim', 2, 'crew', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5575a5a6-e6a0-5cd2-b67f-2dab33a4bd9c', '4e3fe9d1-6e21-504e-adc2-eabfe57d6054', 1, 3.0, 'SCP', false, '3 (+2)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3827c565-0645-5aac-9dc8-ca8376d0622c', '4e3fe9d1-6e21-504e-adc2-eabfe57d6054', 2, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1b614c46-c8c6-5805-b517-895c24dd8efd', '4e3fe9d1-6e21-504e-adc2-eabfe57d6054', 3, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e28cac53-c99b-56b5-b9f7-858267ab9cbe', '4e3fe9d1-6e21-504e-adc2-eabfe57d6054', 4, 6.0, NULL, true, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2325e1f6-e4d5-5053-9dbf-7a80e518ffba', '4e3fe9d1-6e21-504e-adc2-eabfe57d6054', 5, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '933cdf33-2a46-584b-936d-eba6a5ea1d00', '4e3fe9d1-6e21-504e-adc2-eabfe57d6054', 6, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2957bf8b-828b-5773-bb64-ffab54d6d3a3', '4e3fe9d1-6e21-504e-adc2-eabfe57d6054', 7, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2cdc12c6-1bbb-514a-9597-c68180bfc493', '4e3fe9d1-6e21-504e-adc2-eabfe57d6054', 8, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'accb6cab-f49b-555b-8f32-aa3b115b5e20', 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f', '16e59a47-683f-5b49-9fa2-509e71504cf6', 'Yeji Lee / Jaehoon Kim', 'B6338', 'crew', 3,
    28.0, 24.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ac03950a-5ed9-5322-9e10-242e2598aac8', 'accb6cab-f49b-555b-8f32-aa3b115b5e20', 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f', 'Yeji Lee', 1, 'helm', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f96dba4e-6018-554b-ba19-a06fcaa686bc', 'accb6cab-f49b-555b-8f32-aa3b115b5e20', '006a707f-4ed4-5496-94d3-4046ca6b43bd', 'Jaehoon Kim', 2, 'crew', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a381541e-2859-5ef4-a56d-c8c0e6a88a65', 'accb6cab-f49b-555b-8f32-aa3b115b5e20', 1, 4.0, NULL, true, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'aadaa403-dc20-5405-b4a5-a231375bfb6a', 'accb6cab-f49b-555b-8f32-aa3b115b5e20', 2, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f35c4685-48c3-54c7-bc99-567603abebf4', 'accb6cab-f49b-555b-8f32-aa3b115b5e20', 3, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b235cd3d-f238-5e6c-96c6-f08a89ff43ab', 'accb6cab-f49b-555b-8f32-aa3b115b5e20', 4, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '854b256d-4248-503a-98bc-12979d5d59b2', 'accb6cab-f49b-555b-8f32-aa3b115b5e20', 5, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '879734ad-f27b-5b82-8334-fe47518e345d', 'accb6cab-f49b-555b-8f32-aa3b115b5e20', 6, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a076b8b8-3c99-5f2b-a951-eda16a1acd1d', 'accb6cab-f49b-555b-8f32-aa3b115b5e20', 7, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '68343563-f2aa-51fd-a94d-c3df38dedc7f', 'accb6cab-f49b-555b-8f32-aa3b115b5e20', 8, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '2ea881fc-c8b7-55ed-81d2-ce2f24763c70', '90b36217-ca95-4a90-b8f3-a502537842ab', '16e59a47-683f-5b49-9fa2-509e71504cf6', 'Ashlea Tham Yan Shuang / Ethan Chia Han Wei', 'B1614', 'crew', 4,
    37.0, 27.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'SGP', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f46f9a51-78a0-5e42-8a40-6051efe743ae', '2ea881fc-c8b7-55ed-81d2-ce2f24763c70', '90b36217-ca95-4a90-b8f3-a502537842ab', 'Ashlea Tham Yan Shuang', 1, 'helm', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6991b108-f6af-5dad-8da9-03b2d7b55e74', '2ea881fc-c8b7-55ed-81d2-ce2f24763c70', '156283b1-fac6-48ba-a530-bd5a78d77114', 'Ethan Chia Han Wei', 2, 'crew', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'efcd0f80-4f2b-596c-8b42-f574acc7e834', '2ea881fc-c8b7-55ed-81d2-ce2f24763c70', 1, 10.0, 'DNF', true, 'DNF 10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b3dccd8b-2582-52d9-9849-e82153d08040', '2ea881fc-c8b7-55ed-81d2-ce2f24763c70', 2, 6.0, 'SCP', false, '6 (+2)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '271ec5b9-153f-5bec-b7a6-672610756702', '2ea881fc-c8b7-55ed-81d2-ce2f24763c70', 3, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '66f1c43c-ddbf-55fe-a477-de70cc2da3ba', '2ea881fc-c8b7-55ed-81d2-ce2f24763c70', 4, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'bb61f74f-78e0-5c77-b9af-7ac9a96bcd50', '2ea881fc-c8b7-55ed-81d2-ce2f24763c70', 5, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5f411e8f-86a7-5ce6-91d3-2d960e6c0a06', '2ea881fc-c8b7-55ed-81d2-ce2f24763c70', 6, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '09eab0db-24f7-5c65-826c-cfbeacacca0f', '2ea881fc-c8b7-55ed-81d2-ce2f24763c70', 7, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e887cdfc-6ec7-5f75-9935-067970cb5a08', '2ea881fc-c8b7-55ed-81d2-ce2f24763c70', 8, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'e2bdaf9b-2b29-5a4b-b13d-94c5ce41197f', '86f5a930-4f9a-5f9e-b24d-6389c66465f0', '16e59a47-683f-5b49-9fa2-509e71504cf6', 'Jihyeok Jung / Minjun Seo', 'B5236', 'crew', 5,
    42.0, 33.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '41c60f52-c040-572f-a4f3-54f000450942', 'e2bdaf9b-2b29-5a4b-b13d-94c5ce41197f', '86f5a930-4f9a-5f9e-b24d-6389c66465f0', 'Jihyeok Jung', 1, 'helm', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bcc7b4d0-a385-5fa0-bb70-89aa4dc79ddd', 'e2bdaf9b-2b29-5a4b-b13d-94c5ce41197f', '2489ba3e-0f35-5218-9c00-35eb0a75a894', 'Minjun Seo', 2, 'crew', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ed6a60fc-e8fa-585b-bb6d-9d6ac397f0b5', 'e2bdaf9b-2b29-5a4b-b13d-94c5ce41197f', 1, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9f4f6998-e952-548d-9592-16f73a3b76b5', 'e2bdaf9b-2b29-5a4b-b13d-94c5ce41197f', 2, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9811a6a5-7392-51d2-b451-acc6ef1f3ffd', 'e2bdaf9b-2b29-5a4b-b13d-94c5ce41197f', 3, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7cfed64c-d173-5e79-bec2-8e53779bd595', 'e2bdaf9b-2b29-5a4b-b13d-94c5ce41197f', 4, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5a958f3e-86d4-5385-b46b-4bcedfcae8ad', 'e2bdaf9b-2b29-5a4b-b13d-94c5ce41197f', 5, 9.0, NULL, true, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a766e56f-ad4d-56e3-807a-2e19b2fb0fa2', 'e2bdaf9b-2b29-5a4b-b13d-94c5ce41197f', 6, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3f78b7f6-03d7-56af-a658-0b6b7fa6d373', 'e2bdaf9b-2b29-5a4b-b13d-94c5ce41197f', 7, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'bab89a06-a6cd-5603-9796-a6640b994dde', 'e2bdaf9b-2b29-5a4b-b13d-94c5ce41197f', 8, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '197aec6c-63da-5997-b9ce-e9b2753d4288', 'e5323bec-c571-506d-8bdc-4a61b55f480f', '16e59a47-683f-5b49-9fa2-509e71504cf6', 'Yujin Son / Mingyu Kim', 'B5522', 'crew', 6,
    50.0, 41.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '65aafb76-c89b-5c61-808b-8d5180b4f970', '197aec6c-63da-5997-b9ce-e9b2753d4288', 'e5323bec-c571-506d-8bdc-4a61b55f480f', 'Yujin Son', 1, 'helm', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '03a4527f-94e4-59ca-b2b6-dff21458945a', '197aec6c-63da-5997-b9ce-e9b2753d4288', '07894fb8-a2bc-5b17-9023-8b9030bd855b', 'Mingyu Kim', 2, 'crew', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3e3735e1-3a01-5ec0-8645-dc1331e1dab7', '197aec6c-63da-5997-b9ce-e9b2753d4288', 1, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '96fe819e-5c95-59ea-83d2-d45f23f8af59', '197aec6c-63da-5997-b9ce-e9b2753d4288', 2, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '33e4345a-6b1f-567a-829b-449cecb6d1a9', '197aec6c-63da-5997-b9ce-e9b2753d4288', 3, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '83f49b66-f83b-5c86-a11d-ad27c02b877e', '197aec6c-63da-5997-b9ce-e9b2753d4288', 4, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'eeb036d3-7a35-5f11-a752-43085552bd1f', '197aec6c-63da-5997-b9ce-e9b2753d4288', 5, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '79e1b300-8a8a-557d-ab63-1bb1887da0ba', '197aec6c-63da-5997-b9ce-e9b2753d4288', 6, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '516f4429-36ff-549f-b4eb-4a86afe07060', '197aec6c-63da-5997-b9ce-e9b2753d4288', 7, 9.0, NULL, true, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6bcd1cf3-47f6-5ed6-acf2-64326c5274ad', '197aec6c-63da-5997-b9ce-e9b2753d4288', 8, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '5ef5b691-07be-5094-b5d5-e2e63a28d1fb', '53b7939f-62de-5cb9-b87b-ba62072f9deb', '16e59a47-683f-5b49-9fa2-509e71504cf6', 'Hyunwoo Kang / Minsang Yoon', 'B7317', 'crew', 7,
    50.0, 41.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a0cea7da-6fd4-56ea-b5fc-868c342842f5', '5ef5b691-07be-5094-b5d5-e2e63a28d1fb', '53b7939f-62de-5cb9-b87b-ba62072f9deb', 'Hyunwoo Kang', 1, 'helm', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '97a524d8-3b19-565f-8e84-91863d76ce52', '5ef5b691-07be-5094-b5d5-e2e63a28d1fb', '1e708b51-d534-50db-9704-50e75dc9e016', 'Minsang Yoon', 2, 'crew', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ad426521-1d89-52a0-9523-db7740e8ffc9', '5ef5b691-07be-5094-b5d5-e2e63a28d1fb', 1, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c6b5f2aa-bb08-5615-98fc-3f1148856acf', '5ef5b691-07be-5094-b5d5-e2e63a28d1fb', 2, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a4174dfc-8656-56f6-9e28-24fe3a0e0b14', '5ef5b691-07be-5094-b5d5-e2e63a28d1fb', 3, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd2b396f8-9906-5119-9a2b-3b153452f84a', '5ef5b691-07be-5094-b5d5-e2e63a28d1fb', 4, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c30aff93-640c-5a35-ac9e-ba4fbb6a8b5c', '5ef5b691-07be-5094-b5d5-e2e63a28d1fb', 5, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0d7484b8-80b0-5e5e-94aa-175672326ae0', '5ef5b691-07be-5094-b5d5-e2e63a28d1fb', 6, 9.0, NULL, true, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ec6931af-e7a5-5e1a-8af6-e90678c13337', '5ef5b691-07be-5094-b5d5-e2e63a28d1fb', 7, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c8f4b0b6-2229-58f1-a44f-e0cacda77168', '5ef5b691-07be-5094-b5d5-e2e63a28d1fb', 8, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '14d97788-9e84-5026-acc1-eb3a33955cdb', '746ae16d-2826-50c6-ac71-1ec9e139a0e2', '16e59a47-683f-5b49-9fa2-509e71504cf6', 'Jaeyoon Hwang / Soyoon Choi', 'B6677', 'crew', 8,
    57.0, 48.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7ebf0910-6ac3-580b-9d82-9eeed354473e', '14d97788-9e84-5026-acc1-eb3a33955cdb', '746ae16d-2826-50c6-ac71-1ec9e139a0e2', 'Jaeyoon Hwang', 1, 'helm', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5d69dfdb-d2c7-564d-a711-7ef7b1063d18', '14d97788-9e84-5026-acc1-eb3a33955cdb', '7230e023-0c19-5215-b2ad-eeaaf22361de', 'Soyoon Choi', 2, 'crew', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'bf7ceaed-6e75-55b7-878d-314cd2b9d715', '14d97788-9e84-5026-acc1-eb3a33955cdb', 1, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd16653c1-fdcc-57d7-a768-bd805c75fc0c', '14d97788-9e84-5026-acc1-eb3a33955cdb', 2, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '861dc24a-0b22-55ad-9558-4a15600b52d1', '14d97788-9e84-5026-acc1-eb3a33955cdb', 3, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0f03ac67-c19e-5bf5-ad39-698bc1195dbc', '14d97788-9e84-5026-acc1-eb3a33955cdb', 4, 9.0, NULL, true, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1621486c-678a-59e9-830e-af014612b3ac', '14d97788-9e84-5026-acc1-eb3a33955cdb', 5, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '80ebe529-760f-54c1-b602-49a61ce47866', '14d97788-9e84-5026-acc1-eb3a33955cdb', 6, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4e522187-6835-5b0e-b235-db798c63d19c', '14d97788-9e84-5026-acc1-eb3a33955cdb', 7, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7877e35b-1425-5d76-97dd-22448086a991', '14d97788-9e84-5026-acc1-eb3a33955cdb', 8, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '72b7bd7b-6156-5a55-9a98-ba0726df215e', '5f2f7947-57b4-41ba-b642-ed27263d0e05', '16e59a47-683f-5b49-9fa2-509e71504cf6', 'Mingyu Hong / Taeyoon Kim', 'B7061', 'crew', 9,
    66.0, 56.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '093366bd-f73c-517c-8d83-f13c6c0843fc', '72b7bd7b-6156-5a55-9a98-ba0726df215e', '5f2f7947-57b4-41ba-b642-ed27263d0e05', 'Mingyu Hong', 1, 'helm', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b82a466a-7527-5e12-b3f5-112e5b11a08c', '72b7bd7b-6156-5a55-9a98-ba0726df215e', '1aa1d4b8-da4f-54ae-9af5-05a93c266c87', 'Taeyoon Kim', 2, 'crew', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a7d2d239-388b-54ee-bee7-f339c5c542e7', '72b7bd7b-6156-5a55-9a98-ba0726df215e', 1, 10.0, 'DNC', true, 'DNC 10', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '78d9bfe5-44b9-5f94-b176-42774a39e6a2', '72b7bd7b-6156-5a55-9a98-ba0726df215e', 2, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '77317ea1-c112-5ebd-8e5e-a2135806b101', '72b7bd7b-6156-5a55-9a98-ba0726df215e', 3, 9.0, NULL, false, '9', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1d215897-f251-5805-8cee-8a2385743a05', '72b7bd7b-6156-5a55-9a98-ba0726df215e', 4, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9e825cbf-8427-5113-a339-ff35aeb24d0f', '72b7bd7b-6156-5a55-9a98-ba0726df215e', 5, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd6998264-a11f-5647-98f0-4f608ab530a8', '72b7bd7b-6156-5a55-9a98-ba0726df215e', 6, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6ee9edec-07e7-5a91-8a98-d6405660bb4d', '72b7bd7b-6156-5a55-9a98-ba0726df215e', 7, 9.0, 'SCP', false, '9 (+2)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '23b4b2b1-8b20-5dc8-9816-324e0d5fc83e', '72b7bd7b-6156-5a55-9a98-ba0726df215e', 8, 8.0, NULL, false, '8', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();

INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '326d86b7-6e95-5aa4-85ea-a48196f13576',
    '3eab275b-24b8-5e99-8c85-79df5829649a',
    '2026 KSAF President''s Cup National Youth Sailing Championships — iQFoil High School Boys',
    'ksaf-presidents-cup-youth-nationals-2026-iqfoil-hs-boys',
    '2026-05-08',
    '2026-05-11',
    9,
    'High School Boys',
    9,
    'KOR',
    'iQFoil',
    'individual',
    1,
    1,
    false,
    'Seoul Water Leisure Sports Center, Hangang River, Seoul, South Korea',
    'Korea Sailing Federation (대한요트협회 / KSAF)',
    'published',
    'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf',
    '2026 대한요트협회장배(청소년) 전국요트대회 — iQFoil High School Boys. Official KSAF Final Results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '9e96c3af-d876-5260-b150-ee5c64250e84', '7ee0b8e9-a533-55b6-9d84-f329e3ca4819', '326d86b7-6e95-5aa4-85ea-a48196f13576', 'Jaemin Yoo', 'Q346', 'individual', 1,
    10.0, 8.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '849b22b5-9863-5d0b-9bab-052d6ebd9468', '9e96c3af-d876-5260-b150-ee5c64250e84', '7ee0b8e9-a533-55b6-9d84-f329e3ca4819', 'Jaemin Yoo', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '82ed3b31-5b70-5582-b09f-9fb1a0cbbb1f', '9e96c3af-d876-5260-b150-ee5c64250e84', 1, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '25a8e61a-4b5b-575d-8d01-31d9c6e6f7b6', '9e96c3af-d876-5260-b150-ee5c64250e84', 2, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '801a7cf2-2b4c-53d7-9bf0-54233891d02c', '9e96c3af-d876-5260-b150-ee5c64250e84', 3, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '152eb416-4ec1-52b3-97e6-3e01a16b9efb', '9e96c3af-d876-5260-b150-ee5c64250e84', 4, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0fa18de0-44e2-592c-8a6a-6a60b09f3e4e', '9e96c3af-d876-5260-b150-ee5c64250e84', 5, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '68eff1fb-562b-5993-b23f-e9193ffc8683', '9e96c3af-d876-5260-b150-ee5c64250e84', 6, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7e8c438a-c361-5524-aee9-38638e19ec64', '9e96c3af-d876-5260-b150-ee5c64250e84', 7, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a252ce3f-87f2-5af2-a4b4-d3beea696393', '9e96c3af-d876-5260-b150-ee5c64250e84', 8, 2.0, NULL, true, '(2)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f07eb93d-4ab1-52e5-8ff5-c77c46e2386e', '9e96c3af-d876-5260-b150-ee5c64250e84', 9, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '4a8068d0-5470-5945-b098-2f45f3c11dc0', '3e989539-35f1-5ad0-8c53-86191f5a6c16', '326d86b7-6e95-5aa4-85ea-a48196f13576', 'Taeseok Kim', 'Q358', 'individual', 2,
    28.0, 22.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '90768fc2-ef9c-5858-9b87-38c1c27d6390', '4a8068d0-5470-5945-b098-2f45f3c11dc0', '3e989539-35f1-5ad0-8c53-86191f5a6c16', 'Taeseok Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '65667482-4d41-5bca-a21e-ad944ce8b6ac', '4a8068d0-5470-5945-b098-2f45f3c11dc0', 1, 3.0, NULL, false, '3 학교', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c515da64-6646-50a6-ab54-f2a6b9e74e7b', '4a8068d0-5470-5945-b098-2f45f3c11dc0', 2, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '641a9870-304a-559a-94ea-59e86181cbd0', '4a8068d0-5470-5945-b098-2f45f3c11dc0', 3, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'efd1bc4e-f76d-5e46-ba7b-103415dd09f1', '4a8068d0-5470-5945-b098-2f45f3c11dc0', 4, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fe95ff3f-e6ea-53db-815a-1979cdd288bf', '4a8068d0-5470-5945-b098-2f45f3c11dc0', 5, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7133d6c7-02b7-5461-beb2-85f783be7714', '4a8068d0-5470-5945-b098-2f45f3c11dc0', 6, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '74d4245a-7739-5ace-a963-43225e6478a4', '4a8068d0-5470-5945-b098-2f45f3c11dc0', 7, 6.0, NULL, true, '(6)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '222c10a7-c28f-5dd0-abdb-be0fc0a5b4c5', '4a8068d0-5470-5945-b098-2f45f3c11dc0', 8, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '58389b5c-0d91-5ede-9e25-8c10c729076c', '4a8068d0-5470-5945-b098-2f45f3c11dc0', 9, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '22c382ea-63e7-5760-a054-fbab9edf4fe6', 'a41bf47a-883a-577e-9493-e7fb8bfebf96', '326d86b7-6e95-5aa4-85ea-a48196f13576', 'Hyein Lee', 'Q357', 'individual', 3,
    28.0, 24.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd4b1388e-1bf9-56e8-a862-ec6bd05d84a1', '22c382ea-63e7-5760-a054-fbab9edf4fe6', 'a41bf47a-883a-577e-9493-e7fb8bfebf96', 'Hyein Lee', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c8f93978-9f0e-5610-8bd3-e201ef1e39c1', '22c382ea-63e7-5760-a054-fbab9edf4fe6', 1, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '575250fa-5bca-52c5-b727-cc01fcabca5c', '22c382ea-63e7-5760-a054-fbab9edf4fe6', 2, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7623e5e2-3e80-5a2b-a643-02c1b5c3c411', '22c382ea-63e7-5760-a054-fbab9edf4fe6', 3, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b6cb975a-245e-5390-9447-0c0c95239c5b', '22c382ea-63e7-5760-a054-fbab9edf4fe6', 4, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '40eb010c-9699-56c3-b8a0-b19249318524', '22c382ea-63e7-5760-a054-fbab9edf4fe6', 5, 10.0, 'BFD', false, '10 BFD', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5a142ba5-ac42-59a2-bc2c-f3adc92352ae', '22c382ea-63e7-5760-a054-fbab9edf4fe6', 6, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f19fa399-77e5-5ef5-b2e7-478c52e0a6dc', '22c382ea-63e7-5760-a054-fbab9edf4fe6', 7, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3452d201-6068-58b3-9410-ade0d2683794', '22c382ea-63e7-5760-a054-fbab9edf4fe6', 8, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '281aa4f9-b637-5922-bc20-68a361e6c6e1', '22c382ea-63e7-5760-a054-fbab9edf4fe6', 9, 4.0, NULL, true, '(4)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '15d3f10b-62ff-5057-b3ac-4974b70a995d', 'ed51d9cf-9d54-5b2d-81e2-244893a26957', '326d86b7-6e95-5aa4-85ea-a48196f13576', 'Sunwoo Kim', 'Q356', 'individual', 4,
    42.0, 32.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '59a7c489-d403-528f-a04e-81c285314810', '15d3f10b-62ff-5057-b3ac-4974b70a995d', 'ed51d9cf-9d54-5b2d-81e2-244893a26957', 'Sunwoo Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a525cd30-80ab-5f48-879e-ba04eb193f33', '15d3f10b-62ff-5057-b3ac-4974b70a995d', 1, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ba32c9ef-dfa8-5218-9ec0-e0d5701a20f9', '15d3f10b-62ff-5057-b3ac-4974b70a995d', 2, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'eb17b37d-2adf-52ab-83d7-2158f4868feb', '15d3f10b-62ff-5057-b3ac-4974b70a995d', 3, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f71dcfea-e877-5766-81e6-9f1ecc6820d6', '15d3f10b-62ff-5057-b3ac-4974b70a995d', 4, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e37aa82c-ad53-5602-a118-382a85f05cf7', '15d3f10b-62ff-5057-b3ac-4974b70a995d', 5, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fce8a6fa-3d80-51b3-b316-216099c05ce0', '15d3f10b-62ff-5057-b3ac-4974b70a995d', 6, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'cf3ac446-7c24-5852-ba9b-04f49e5c57cd', '15d3f10b-62ff-5057-b3ac-4974b70a995d', 7, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7542223f-df29-5211-b66d-3cf191b966b2', '15d3f10b-62ff-5057-b3ac-4974b70a995d', 8, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9bd04616-696a-52ab-b34f-cf16462efd0d', '15d3f10b-62ff-5057-b3ac-4974b70a995d', 9, 10.0, 'DNF', true, '(10) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'fd060771-c3a8-5485-8421-fb207dffcd80', '079c881f-4633-528b-9557-64ecb31de251', '326d86b7-6e95-5aa4-85ea-a48196f13576', 'Junhwan Choi', 'Q362', 'individual', 5,
    54.0, 44.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '806f104e-6f6e-53f3-abcf-397334470b46', 'fd060771-c3a8-5485-8421-fb207dffcd80', '079c881f-4633-528b-9557-64ecb31de251', 'Junhwan Choi', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a0f674cc-55f5-5abc-aadf-d6f1359ed41a', 'fd060771-c3a8-5485-8421-fb207dffcd80', 1, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '784327ac-b4e4-57e4-a070-9023c8abc62d', 'fd060771-c3a8-5485-8421-fb207dffcd80', 2, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9b247717-e667-5258-9bf6-8afef66392ec', 'fd060771-c3a8-5485-8421-fb207dffcd80', 3, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4ba3352c-ca6b-570e-a817-f776ebb5ea7d', 'fd060771-c3a8-5485-8421-fb207dffcd80', 4, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '47d73ed7-7ca2-5e1f-84e4-08ab23524023', 'fd060771-c3a8-5485-8421-fb207dffcd80', 5, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '04e0a9b1-28d8-5ddc-b2e6-d599a2f1ce37', 'fd060771-c3a8-5485-8421-fb207dffcd80', 6, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'dfab7b03-b3da-51e1-bc7d-4407e21ed648', 'fd060771-c3a8-5485-8421-fb207dffcd80', 7, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ff5a6e99-e8e0-55fb-be15-ab78d52f4220', 'fd060771-c3a8-5485-8421-fb207dffcd80', 8, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b974526a-5ea8-514b-89a8-5e6e5730e0c0', 'fd060771-c3a8-5485-8421-fb207dffcd80', 9, 10.0, 'DNF', true, '(10) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '832f439c-22df-536a-9903-d40a84a8ee2c', 'a1a323c7-a3c7-53d4-a607-785ac6486dc7', '326d86b7-6e95-5aa4-85ea-a48196f13576', 'Jihoon Bae', 'Q365', 'individual', 6,
    62.0, 52.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '762f36b2-bd94-5ae2-9f08-5fd637ba31f1', '832f439c-22df-536a-9903-d40a84a8ee2c', 'a1a323c7-a3c7-53d4-a607-785ac6486dc7', 'Jihoon Bae', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7f5be220-c142-576f-8014-bb4859c1e8ce', '832f439c-22df-536a-9903-d40a84a8ee2c', 1, 10.0, 'DNF', true, '(10) DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a51c55c7-b06e-58fa-b77c-f01423897c1f', '832f439c-22df-536a-9903-d40a84a8ee2c', 2, 10.0, 'DNF', false, '10 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7b4264fa-86bb-5706-99da-39a63e3446f4', '832f439c-22df-536a-9903-d40a84a8ee2c', 3, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '76d9e00e-5856-5d9d-8d24-0ba2fbd5b6d8', '832f439c-22df-536a-9903-d40a84a8ee2c', 4, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '67a6474f-d326-59b2-8c15-0ea2c2d33758', '832f439c-22df-536a-9903-d40a84a8ee2c', 5, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd48361b0-3e4a-5a2c-89b9-84bd89baf39f', '832f439c-22df-536a-9903-d40a84a8ee2c', 6, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '18a278ad-a186-5771-8a08-843ec2503f54', '832f439c-22df-536a-9903-d40a84a8ee2c', 7, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0af941c5-1698-5bda-8b34-a5782d839d1e', '832f439c-22df-536a-9903-d40a84a8ee2c', 8, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a6c0ec31-482a-5b20-855a-030991b6e25f', '832f439c-22df-536a-9903-d40a84a8ee2c', 9, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '2efed114-bb7e-5f89-be4f-836c991a5b74', 'e81fdf9a-f7b1-52e9-a930-f45bbc64d7a5', '326d86b7-6e95-5aa4-85ea-a48196f13576', 'Hyunjae Kim', 'Q342', 'individual', 7,
    63.0, 53.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '40393d47-a161-5845-96f2-068610e9e224', '2efed114-bb7e-5f89-be4f-836c991a5b74', 'e81fdf9a-f7b1-52e9-a930-f45bbc64d7a5', 'Hyunjae Kim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '29a6ee6b-ce3c-582f-8b63-1cb906d5bac9', '2efed114-bb7e-5f89-be4f-836c991a5b74', 1, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b92ed27c-cdc9-5935-b791-5f10c87a3c70', '2efed114-bb7e-5f89-be4f-836c991a5b74', 2, 6.0, NULL, false, '6', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'cde1e2b0-0ff3-572a-a5c0-63cd1c0c398f', '2efed114-bb7e-5f89-be4f-836c991a5b74', 3, 10.0, 'RET', true, '(10) RET', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b6c1cebe-a7b6-594d-88da-c0c33291f231', '2efed114-bb7e-5f89-be4f-836c991a5b74', 4, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'dfca9907-ef9a-5514-af50-39204b9f3272', '2efed114-bb7e-5f89-be4f-836c991a5b74', 5, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '449f611a-05ec-5cb9-9305-0dbc9c8b61d7', '2efed114-bb7e-5f89-be4f-836c991a5b74', 6, 5.0, NULL, false, '5', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c5da4564-dee8-5621-936e-71c97beac29e', '2efed114-bb7e-5f89-be4f-836c991a5b74', 7, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '1ddc6eb0-646e-5698-b231-f48b42bf7688', '2efed114-bb7e-5f89-be4f-836c991a5b74', 8, 7.0, NULL, false, '7', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd2b4efba-6f45-51f0-93cb-f506b433d206', '2efed114-bb7e-5f89-be4f-836c991a5b74', 9, 10.0, 'DNF', false, '10 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'cec74770-7d14-5f21-a212-72c704a8ae77', '6c87b06c-4440-5a0c-a932-cbdefa4436f6', '326d86b7-6e95-5aa4-85ea-a48196f13576', 'Hyunwoo Moon', 'Q375', 'individual', 8,
    90.0, 80.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0f45ac48-696c-5835-91f8-eed6d4555f0c', 'cec74770-7d14-5f21-a212-72c704a8ae77', '6c87b06c-4440-5a0c-a932-cbdefa4436f6', 'Hyunwoo Moon', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e360067d-5f20-5a75-b739-d865c6678225', 'cec74770-7d14-5f21-a212-72c704a8ae77', 1, 10.0, 'DNC', true, '(10) 학교 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ba7fc3b0-be26-5f72-a069-0690093fcc22', 'cec74770-7d14-5f21-a212-72c704a8ae77', 2, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '4ab7fcd7-a44d-5c9a-bf28-5fa892a90b2d', 'cec74770-7d14-5f21-a212-72c704a8ae77', 3, 10.0, 'DNF', false, '10 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b3ef4f16-e177-5e0c-a5a9-4d2c42576317', 'cec74770-7d14-5f21-a212-72c704a8ae77', 4, 10.0, 'DNF', false, '10 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '994e743c-7057-5327-94f1-bd3a3a65c856', 'cec74770-7d14-5f21-a212-72c704a8ae77', 5, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ac4d3ab4-9f06-533c-b59d-52a03d2fd659', 'cec74770-7d14-5f21-a212-72c704a8ae77', 6, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd354906d-034f-5e1d-bc15-515e9c789949', 'cec74770-7d14-5f21-a212-72c704a8ae77', 7, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '92257a21-7081-595b-b93f-7f7833535c87', 'cec74770-7d14-5f21-a212-72c704a8ae77', 8, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '99048c95-1848-51b1-8280-6df73ea1f0d4', 'cec74770-7d14-5f21-a212-72c704a8ae77', 9, 10.0, 'DNF', false, '10 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'b55a8e4d-d708-5908-abe9-2b30307e01c6', '12c20a73-79f0-561c-8805-c6fe4afebbe2', '326d86b7-6e95-5aa4-85ea-a48196f13576', 'Hajin Shim', 'Q376', 'individual', 9,
    90.0, 80.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd2816391-f801-5c34-9f62-087c7b652f09', 'b55a8e4d-d708-5908-abe9-2b30307e01c6', '12c20a73-79f0-561c-8805-c6fe4afebbe2', 'Hajin Shim', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '11b972ff-5156-5915-bd09-3db27e3c4096', 'b55a8e4d-d708-5908-abe9-2b30307e01c6', 1, 10.0, 'DNF', true, '(10) 트스포 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '279d7be3-1b54-566e-a1a3-01ccf0d2ad1f', 'b55a8e4d-d708-5908-abe9-2b30307e01c6', 2, 10.0, 'DNF', false, '10 츠클 DNF', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '841f9bb5-87ca-557c-8146-048da088a831', 'b55a8e4d-d708-5908-abe9-2b30307e01c6', 3, 10.0, 'DNC', false, '10 럽 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'bc89e48e-3203-5082-975d-b0b1a01cc9e3', 'b55a8e4d-d708-5908-abe9-2b30307e01c6', 4, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '68df83eb-f9e7-55d8-b75d-392d047672cc', 'b55a8e4d-d708-5908-abe9-2b30307e01c6', 5, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '568b99de-4653-5793-aec6-f1f00ecdf693', 'b55a8e4d-d708-5908-abe9-2b30307e01c6', 6, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f00cfe00-85c7-572b-909b-84b3f81e1cec', 'b55a8e4d-d708-5908-abe9-2b30307e01c6', 7, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ec267341-70d1-5b7d-aaa0-b40bf80b86e4', 'b55a8e4d-d708-5908-abe9-2b30307e01c6', 8, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f2e2f394-3653-5037-b8d4-46894285461c', 'b55a8e4d-d708-5908-abe9-2b30307e01c6', 9, 10.0, 'DNC', false, '10 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();

INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '084291b3-cde8-5668-9266-b9cdec58771c',
    '3eab275b-24b8-5e99-8c85-79df5829649a',
    '2026 KSAF President''s Cup National Youth Sailing Championships — iQFoil High School Girls',
    'ksaf-presidents-cup-youth-nationals-2026-iqfoil-hs-girls',
    '2026-05-08',
    '2026-05-11',
    2,
    'High School Girls',
    8,
    'KOR',
    'iQFoil',
    'individual',
    1,
    1,
    false,
    'Seoul Water Leisure Sports Center, Hangang River, Seoul, South Korea',
    'Korea Sailing Federation (대한요트협회 / KSAF)',
    'published',
    'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf',
    '2026 대한요트협회장배(청소년) 전국요트대회 — iQFoil High School Girls. Official KSAF Final Results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'ffe077b2-82a9-509f-823e-77c2676dbac1', '6ad1338e-d664-5d54-9a7f-2b9fff1dd255', '084291b3-cde8-5668-9266-b9cdec58771c', 'Gayeon Baek', 'Q343', 'individual', 1,
    8.0, 7.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e34e475d-3140-527a-a07f-7f6426a4e2c5', 'ffe077b2-82a9-509f-823e-77c2676dbac1', '6ad1338e-d664-5d54-9a7f-2b9fff1dd255', 'Gayeon Baek', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'c0d3e486-93a6-5644-afd2-5bbc6442b578', 'ffe077b2-82a9-509f-823e-77c2676dbac1', 1, 1.0, NULL, true, '(1)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5b4fc94d-7bc6-5886-863f-2ce48dd81019', 'ffe077b2-82a9-509f-823e-77c2676dbac1', 2, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '16d184d7-73b5-5f8f-92b6-6844cf1c7ced', 'ffe077b2-82a9-509f-823e-77c2676dbac1', 3, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3cd79705-f64c-509a-a1df-59ba847f7c14', 'ffe077b2-82a9-509f-823e-77c2676dbac1', 4, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'ed5e9235-c546-5e50-aab6-33683b598511', 'ffe077b2-82a9-509f-823e-77c2676dbac1', 5, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0cb942e3-bba0-519e-96d6-e673008f2ee8', 'ffe077b2-82a9-509f-823e-77c2676dbac1', 6, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5ed0d8f5-a611-53c4-b01f-d617b1f53f93', 'ffe077b2-82a9-509f-823e-77c2676dbac1', 7, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'a6ddc5ea-af2b-5b88-86f7-1eea4b51a859', 'ffe077b2-82a9-509f-823e-77c2676dbac1', 8, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '60d76344-3330-5000-82de-6d10b87d7344', '06a13acb-1638-50a4-a45b-05a6be56a480', '084291b3-cde8-5668-9266-b9cdec58771c', 'Jeongwon So', 'Q364', 'individual', 2,
    20.0, 17.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '938b9475-510e-5bbb-bf59-4219b191c52d', '60d76344-3330-5000-82de-6d10b87d7344', '06a13acb-1638-50a4-a45b-05a6be56a480', 'Jeongwon So', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '68a5f919-6f91-5d8f-9afe-0fa3719aef46', '60d76344-3330-5000-82de-6d10b87d7344', 1, 3.0, 'DNC', true, '(3) DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5d83041c-cf1d-5f4e-a321-83dc124c9bcb', '60d76344-3330-5000-82de-6d10b87d7344', 2, 3.0, 'RET', false, '3 RET', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '8f4e270a-a382-5d8c-83f2-11e39b4aa20b', '60d76344-3330-5000-82de-6d10b87d7344', 3, 3.0, 'DNC', false, '3 DNC', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '707cd219-8238-5158-83f8-1f2348decab9', '60d76344-3330-5000-82de-6d10b87d7344', 4, 3.0, 'RET', false, '3 RET', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '704f9ec1-df64-5769-a1fb-2970f7d9da99', '60d76344-3330-5000-82de-6d10b87d7344', 5, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '30ad94ed-8c69-57ab-b92f-8339d181b298', '60d76344-3330-5000-82de-6d10b87d7344', 6, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '53997dd6-a3b9-5972-8386-85eef5729f16', '60d76344-3330-5000-82de-6d10b87d7344', 7, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '95980dfd-a894-5525-9597-742fa2d1436e', '60d76344-3330-5000-82de-6d10b87d7344', 8, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();

INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '681c2d55-c3ee-5611-8e7e-7e14b29c4fd5',
    '3eab275b-24b8-5e99-8c85-79df5829649a',
    '2026 KSAF President''s Cup National Youth Sailing Championships — iQFoil Middle School',
    'ksaf-presidents-cup-youth-nationals-2026-iqfoil-ms',
    '2026-05-08',
    '2026-05-11',
    4,
    'Middle School',
    8,
    'KOR',
    'iQFoil',
    'individual',
    1,
    1,
    false,
    'Seoul Water Leisure Sports Center, Hangang River, Seoul, South Korea',
    'Korea Sailing Federation (대한요트협회 / KSAF)',
    'published',
    'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf',
    '2026 대한요트협회장배(청소년) 전국요트대회 — iQFoil Middle School. Official KSAF Final Results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'a7cbda74-57ea-534a-83be-ac28b4918de2', '20f258f8-799b-57d0-90d0-1c6d1cf76505', '681c2d55-c3ee-5611-8e7e-7e14b29c4fd5', 'Jihyeok Yoo', 'Q347', 'individual', 1,
    8.0, 7.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'afea2218-cc8c-5b90-b751-a3cebc7a31a0', 'a7cbda74-57ea-534a-83be-ac28b4918de2', '20f258f8-799b-57d0-90d0-1c6d1cf76505', 'Jihyeok Yoo', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '61da93e9-4b89-513f-950b-cc74000cb709', 'a7cbda74-57ea-534a-83be-ac28b4918de2', 1, 1.0, NULL, true, '(1)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2e33fb50-2edd-5ae1-9835-ecb9433635eb', 'a7cbda74-57ea-534a-83be-ac28b4918de2', 2, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b7e19fea-6640-5bb3-9ff7-08ed5f529e15', 'a7cbda74-57ea-534a-83be-ac28b4918de2', 3, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f3c7eb9f-548e-57ef-af4d-6035af044025', 'a7cbda74-57ea-534a-83be-ac28b4918de2', 4, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fb3106cb-3148-5bfb-a9bd-ed75a18f126d', 'a7cbda74-57ea-534a-83be-ac28b4918de2', 5, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '7350c276-10a9-5b6a-b7c0-a4020ee47ac3', 'a7cbda74-57ea-534a-83be-ac28b4918de2', 6, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'de310d1a-e414-5e5a-aad3-7c4f60805539', 'a7cbda74-57ea-534a-83be-ac28b4918de2', 7, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '0380b09f-2aa1-5767-b1e2-d166234c1115', 'a7cbda74-57ea-534a-83be-ac28b4918de2', 8, 1.0, NULL, false, '1', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '29dd1acc-390b-587d-9381-63de4946cb5b', 'cb88ac82-b4e7-5945-b345-fbe3d2b33745', '681c2d55-c3ee-5611-8e7e-7e14b29c4fd5', 'Jiho Yoo', 'Q348', 'individual', 2,
    17.0, 14.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3e571e16-a6ee-5e1e-85ca-efe6e256cd46', '29dd1acc-390b-587d-9381-63de4946cb5b', 'cb88ac82-b4e7-5945-b345-fbe3d2b33745', 'Jiho Yoo', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '041027fb-31dd-54fa-89d5-df625fdb5ab2', '29dd1acc-390b-587d-9381-63de4946cb5b', 1, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '41ec37c8-2eee-54d7-83ea-81955b4ba15e', '29dd1acc-390b-587d-9381-63de4946cb5b', 2, 3.0, NULL, true, '(3)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'd9c9cee4-f371-5657-b97f-3426a6a72c6d', '29dd1acc-390b-587d-9381-63de4946cb5b', 3, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f079c6f2-7440-533f-ba8e-1ebfbdd5c553', '29dd1acc-390b-587d-9381-63de4946cb5b', 4, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '841134cf-fdd6-51fe-b77b-375f4bd3dd7d', '29dd1acc-390b-587d-9381-63de4946cb5b', 5, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '76f5253d-6669-59ab-945f-7875efe784df', '29dd1acc-390b-587d-9381-63de4946cb5b', 6, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '39f227d3-bd00-59ad-a420-0352eb2f0e4f', '29dd1acc-390b-587d-9381-63de4946cb5b', 7, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '299e6827-058f-5644-af6e-e13c0d1b736f', '29dd1acc-390b-587d-9381-63de4946cb5b', 8, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    'a6c388a3-983f-5861-8a8c-64dcdf24d1c0', '2626c2a3-e937-5606-a38f-683128a5cf5d', '681c2d55-c3ee-5611-8e7e-7e14b29c4fd5', 'Chanyul Park', 'Q359', 'individual', 3,
    23.0, 20.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4755cc7d-cf83-5e96-918a-17931461159b', 'a6c388a3-983f-5861-8a8c-64dcdf24d1c0', '2626c2a3-e937-5606-a38f-683128a5cf5d', 'Chanyul Park', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '2e550b9d-fee5-5f4f-9063-7bb7689752cb', 'a6c388a3-983f-5861-8a8c-64dcdf24d1c0', 1, 3.0, NULL, true, '(3)', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9378ac0b-ab55-59d1-9426-2e1373a5a222', 'a6c388a3-983f-5861-8a8c-64dcdf24d1c0', 2, 2.0, NULL, false, '2', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'e1a61560-7019-5f63-b04d-68980bdbf9d9', 'a6c388a3-983f-5861-8a8c-64dcdf24d1c0', 3, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '25ced444-f218-5cdd-b145-64f8c1115869', 'a6c388a3-983f-5861-8a8c-64dcdf24d1c0', 4, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '3881e309-c7bd-5dbc-b685-96c6989ae6a0', 'a6c388a3-983f-5861-8a8c-64dcdf24d1c0', 5, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f487f421-0003-5ac5-befb-ac591afbaf77', 'a6c388a3-983f-5861-8a8c-64dcdf24d1c0', 6, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fc2653ff-b996-5072-b024-3bc79d83c115', 'a6c388a3-983f-5861-8a8c-64dcdf24d1c0', 7, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '10db82be-26f6-578a-a7e7-d48ac80a677a', 'a6c388a3-983f-5861-8a8c-64dcdf24d1c0', 8, 3.0, NULL, false, '3', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    nationality, created_at, updated_at
) VALUES (
    '216e7cb7-11f4-5002-856b-2dc23b6bb369', '03c8a506-8bf4-52b0-abe8-1909b707d95f', '681c2d55-c3ee-5611-8e7e-7e14b29c4fd5', 'Sia Jung', 'Q355', 'individual', 4,
    36.0, 31.0, false, false, 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=', 'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    '성적_공식_2026.05.11.(월)_2026 대한요트협회장배(청소년) 전국요트대회.pdf', 'pdf', '100% verified against KSAF official final results PDF and screenshots',
    'verified', clock_timestamp(), 'KOR', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e2ca9771-58f8-589f-9e90-f929424047b1', '216e7cb7-11f4-5002-856b-2dc23b6bb369', '03c8a506-8bf4-52b0-abe8-1909b707d95f', 'Sia Jung', 1, 'solo', 'matched', true, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'f5317951-266c-5c44-88d7-b403effdaefd', '216e7cb7-11f4-5002-856b-2dc23b6bb369', 1, 5.0, 'RET', true, '(5) RET', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '5de2a2fc-4d0b-5094-8033-25150088ab2d', '216e7cb7-11f4-5002-856b-2dc23b6bb369', 2, 5.0, 'RET', false, '5 RET', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'fe44b180-9dc4-5ad8-98d0-83a2efc8494b', '216e7cb7-11f4-5002-856b-2dc23b6bb369', 3, 5.0, 'RET', false, '5 RET', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '13a4385f-6408-5ae2-9c78-25bec763aaca', '216e7cb7-11f4-5002-856b-2dc23b6bb369', 4, 5.0, 'RET', false, '5 RET', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '6556f651-c0c9-541b-a22b-8c6de77ad405', '216e7cb7-11f4-5002-856b-2dc23b6bb369', 5, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    'b71d8773-d802-59ef-a4de-0c98b4ff0825', '216e7cb7-11f4-5002-856b-2dc23b6bb369', 6, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '423d3af8-5811-55a5-87d4-8c526e06e470', '216e7cb7-11f4-5002-856b-2dc23b6bb369', 7, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
) VALUES (
    '9bc7cf1f-24b8-59a1-b212-12710ad39045', '216e7cb7-11f4-5002-856b-2dc23b6bb369', 8, 4.0, NULL, false, '4', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    score = EXCLUDED.score,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = clock_timestamp();

COMMIT;
