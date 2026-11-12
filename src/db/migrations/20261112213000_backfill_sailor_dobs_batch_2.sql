-- Backfill verified sailor dates of birth from public regatta / federation records (Batch 2).
-- When only the birth year is published, store YYYY-01-01 (01-01-YYYY).
-- Only updates rows where dob IS NULL so existing verified dates are preserved.

BEGIN;

-- Exact full dates of birth (Team Singapore / Olympedia / YAI / MSSM / Terengganu official records)
UPDATE public.sailors SET dob = '2006-12-16'::date, updated_at = now()
WHERE id = '7391eea1-a4e3-493f-855a-199af3494995'::uuid AND dob IS NULL; -- Jayson Tan Jian Sen (SGP)

UPDATE public.sailors SET dob = '1995-11-18'::date, updated_at = now()
WHERE id = '52df9045-7057-4db7-8ff0-d6ac163ecc0d'::uuid AND dob IS NULL; -- Kelapanda Chengappa Ganapathy (IND)

UPDATE public.sailors SET dob = '2008-09-27'::date, updated_at = now()
WHERE id = 'a455659e-591a-4932-8a2b-61f559a45a96'::uuid AND dob IS NULL; -- Eklavya Batham (IND)

UPDATE public.sailors SET dob = '2007-05-24'::date, updated_at = now()
WHERE id = '0dfd0784-1bca-5040-933c-b8ad1bd6c7b1'::uuid AND dob IS NULL; -- Shashank Batham (IND)

UPDATE public.sailors SET dob = '2012-01-07'::date, updated_at = now()
WHERE id = 'ae136587-161d-4a4b-8240-8c9f04c85eed'::uuid AND dob IS NULL; -- Samriddhi Batham (IND)

UPDATE public.sailors SET dob = '2009-05-06'::date, updated_at = now()
WHERE id = 'ff26b05c-8ff8-4175-83cb-82cce1817d7c'::uuid AND dob IS NULL; -- Shagun Jha (IND)

UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now()
WHERE id = 'dde1d11b-b8e9-410f-94c7-1daee5ecdd4e'::uuid AND dob IS NULL; -- Shubham Yadav (IND)

UPDATE public.sailors SET dob = '2010-12-17'::date, updated_at = now()
WHERE id = 'a7e5107d-faf3-4a7d-88f4-44613744a575'::uuid AND dob IS NULL; -- Lahari Kommaravelly (IND)

UPDATE public.sailors SET dob = '2008-02-24'::date, updated_at = now()
WHERE id = '81b1a95a-45c8-4299-a05d-7aeddd0ca6c2'::uuid AND dob IS NULL; -- Sharanya Yuvaraj Jadhav (IND)

UPDATE public.sailors SET dob = '2008-05-20'::date, updated_at = now()
WHERE id = 'a7b69130-87f2-59ad-a0bb-c8f5bcd3f4c8'::uuid AND dob IS NULL; -- Maanya Reddy (IND)

UPDATE public.sailors SET dob = '2008-03-05'::date, updated_at = now()
WHERE id = '4dbef3ea-81af-429e-9231-615cd1193d1c'::uuid AND dob IS NULL; -- Ajay Gajji (IND)

UPDATE public.sailors SET dob = '2011-09-10'::date, updated_at = now()
WHERE id = '98b02ce5-6ecd-5cf6-99e1-d66e78c0f9ac'::uuid AND dob IS NULL; -- Freyana Driver (IND)

UPDATE public.sailors SET dob = '2008-05-13'::date, updated_at = now()
WHERE id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48'::uuid AND dob IS NULL; -- Alia Sabreen Faisal (IND)

UPDATE public.sailors SET dob = '2009-01-06'::date, updated_at = now()
WHERE id = '848cd0b4-916c-4961-aee0-2b170dd4ac74'::uuid AND dob IS NULL; -- Vinay Vishwanath Kulabkar (IND)

UPDATE public.sailors SET dob = '2007-07-24'::date, updated_at = now()
WHERE id = '921d8704-688c-5561-8d1d-562bb7e78420'::uuid AND dob IS NULL; -- Kameshwar Thanuja (IND)

UPDATE public.sailors SET dob = '2006-10-01'::date, updated_at = now()
WHERE id = '4d4f65b6-cb72-5665-b991-427a6f366a95'::uuid AND dob IS NULL; -- V Vaishnavi (IND)

UPDATE public.sailors SET dob = '2012-07-07'::date, updated_at = now()
WHERE id = 'a41305c2-1e79-599a-9ead-bee0926e49aa'::uuid AND dob IS NULL; -- Shravan Jadhav (IND)

UPDATE public.sailors SET dob = '2010-08-21'::date, updated_at = now()
WHERE id = '2bda4fc0-b72c-4b0b-b21f-597107dc5ca8'::uuid AND dob IS NULL; -- Muaz Mujahid Bin Khamarul Azwan (MAS)

UPDATE public.sailors SET dob = '2010-08-02'::date, updated_at = now()
WHERE id = '1153aed7-1732-4cd4-a60b-b4229ddee14e'::uuid AND dob IS NULL; -- Muhammad Hilfi Nafael Bin Hasrizan (MAS)

UPDATE public.sailors SET dob = '2010-12-19'::date, updated_at = now()
WHERE id = '126eaba9-16e6-40ef-9f4b-822df0550b41'::uuid AND dob IS NULL; -- Sara Amanda Binti Mohd Noor Azman (MAS)

-- Verified birth years -> YYYY-01-01 (YAI / SUKMA / SAFYC / NSG / Chinese Taipei Sailing / JODA / NZIODA)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now()
WHERE id = '984587f3-ef91-53ad-9924-ec1b10d13d4c'::uuid AND dob IS NULL; -- Aakash Tangai (IND)

UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now()
WHERE id = '5878691c-f01b-4ab4-976c-e6ad27b8782d'::uuid AND dob IS NULL; -- Muhammad Adam Aierell Mohd Azizol Amirul (MAS)

UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now()
WHERE id = '070e7354-871c-58ed-872a-872a84c5e7f1'::uuid AND dob IS NULL; -- Gerard Tan (SGP)

UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now()
WHERE id = 'f0858934-d4bc-46cc-b818-54cd5337ba3c'::uuid AND dob IS NULL; -- Mathias Yu Da Wong (SGP)

UPDATE public.sailors SET dob = '2007-01-01'::date, updated_at = now()
WHERE id = '9feccee3-556f-494a-bb80-593be88884cc'::uuid AND dob IS NULL; -- Clive Wei Jun Seah (SGP)

UPDATE public.sailors SET dob = '2016-01-01'::date, updated_at = now()
WHERE id = 'd6c42baa-699b-49b8-b582-da935abd722e'::uuid AND dob IS NULL; -- Ng Teng Yu Tobias (SGP)

UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now()
WHERE id = '3b802239-ec10-402e-8ced-5499c5a1ea57'::uuid AND dob IS NULL; -- Misa Lim Laurie (USA/SGP)

UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now()
WHERE id = 'c755dfaa-75cc-4739-8a41-18eafa49dc9d'::uuid AND dob IS NULL; -- Kuan-Ying Lee (TPE)

UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now()
WHERE id = 'e81d9357-afbd-4c0b-a9e9-abfdead88975'::uuid AND dob IS NULL; -- Jung-Tsen Kao (TPE)

UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now()
WHERE id = '2780f0eb-ea28-44e6-ba67-22a35fb9913d'::uuid AND dob IS NULL; -- Kotaro Matsunaga (JPN)

UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now()
WHERE id = '0c3ea04a-905c-45f1-abb7-a4a917e7da14'::uuid AND dob IS NULL; -- Natsumi Kubota (JPN)

UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now()
WHERE id = 'eba0deb0-10e4-4d3e-a5e5-5e3fa6287288'::uuid AND dob IS NULL; -- Soki Higuchi (JPN)

UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now()
WHERE id = '89eed0ba-4c8d-49dc-a03e-6624a364f93c'::uuid AND dob IS NULL; -- Kaito Nakamura (JPN)

UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now()
WHERE id = '5458a103-48f0-5a10-aad5-41a33b02502e'::uuid AND dob IS NULL; -- Harry Strang (NZL)

UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now()
WHERE id = 'd0b664db-2b5a-4f4f-9253-ce63d33e5e90'::uuid AND dob IS NULL; -- Theo Dacre (NZL)

UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now()
WHERE id = 'c625bfe0-961e-4e21-b826-4a0c62dbcafe'::uuid AND dob IS NULL; -- Jake Dickey (NZL)

UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now()
WHERE id = '95ee889d-670c-4145-aca5-5b1f26cbf2cc'::uuid AND dob IS NULL; -- Stephen Wood (NZL)

UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now()
WHERE id = '5beb9daf-9310-48ad-b865-8c00a7dca56c'::uuid AND dob IS NULL; -- Summer Torbet (NZL)

UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now()
WHERE id = 'ff95dfaa-563f-49ec-9d09-7cdd09128577'::uuid AND dob IS NULL; -- Jungwon Park (NZL)

UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now()
WHERE id = 'e8292236-e9db-5939-85a0-7e5cff40738e'::uuid AND dob IS NULL; -- Jeffrey Chenglin Du (NZL)

UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now()
WHERE id = 'a022aaba-d485-5837-87c8-32e356e58b6d'::uuid AND dob IS NULL; -- Ally Burfoot (NZL)

UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now()
WHERE id = '54993c8c-28c9-596d-bcaf-21b07fa8e9b3'::uuid AND dob IS NULL; -- Zac Loader (NZL)

UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now()
WHERE id = '6867e710-d2ca-5975-8ec5-52d2757806e5'::uuid AND dob IS NULL; -- Zephyr Lane (NZL)

COMMIT;
