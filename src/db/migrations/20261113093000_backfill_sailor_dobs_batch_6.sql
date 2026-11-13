-- Migration: Backfill verified sailor dates of birth (Batch 6)
-- Sources:
-- - 19th Asian Games Hangzhou 2022 Official Results Book (Sailing.pdf, Olympic Council of Asia / Bornan Timing)
-- - Japanese Olympic Committee (JOC) official TEAM JAPAN registries (Ko Nagahori, Misaki Tsunomori)
-- Total sailors verified: 58

-- Bahrain (BRN)
UPDATE public.sailors SET dob = '1988-03-20' WHERE id = '1ab6a21f-5bfb-4907-8cc6-2f1fd000525b'::uuid AND dob IS NULL; -- Janahi Abdulla Mohamed Aqeel
UPDATE public.sailors SET dob = '2008-04-13' WHERE id = '22bc6b49-9fb6-46f3-a939-64cd75a51637'::uuid AND dob IS NULL; -- Aldoseri Khalifa Duaij Khalifa

-- Cambodia (CAM)
UPDATE public.sailors SET dob = '2002-05-20' WHERE id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde'::uuid AND dob IS NULL; -- Chan Nhov
UPDATE public.sailors SET dob = '2005-09-10' WHERE id = '189fb3d9-8997-4275-96b0-10880fb18f7a'::uuid AND dob IS NULL; -- Keo Pheanon

-- China (CHN)
UPDATE public.sailors SET dob = '1992-12-11' WHERE id = '714435d8-312f-577a-b678-088623ed34d6'::uuid AND dob IS NULL; -- Yinsheng Cui
UPDATE public.sailors SET dob = '1995-11-12' WHERE id = 'ccf7d778-5278-4f23-aebf-0144bbb01feb'::uuid AND dob IS NULL; -- Bi Kun
UPDATE public.sailors SET dob = '2001-05-26' WHERE id = 'c6728e70-c00a-46ae-8f5e-e34cc64f046b'::uuid AND dob IS NULL; -- Wen Zaiding
UPDATE public.sailors SET dob = '2000-01-07' WHERE id = '13f901c5-7b26-4656-a420-a2c130a60f4a'::uuid AND dob IS NULL; -- Liu Tian
UPDATE public.sailors SET dob = '1994-09-25' WHERE id = '20f409a1-0eb0-4b39-9144-10f77f0e299c'::uuid AND dob IS NULL; -- Gu Min
UPDATE public.sailors SET dob = '1997-09-09' WHERE id = '2d79e73f-86b7-4629-9af6-57080dcc023c'::uuid AND dob IS NULL; -- Huang Xianting
UPDATE public.sailors SET dob = '1999-09-20' WHERE id = 'd9fbe4e7-4163-4f8f-928b-2aa5454c88d4'::uuid AND dob IS NULL; -- Hu Xiaoyu
UPDATE public.sailors SET dob = '2000-07-23' WHERE id = '88e786e8-32db-4591-a4f1-b8487c1bf9bc'::uuid AND dob IS NULL; -- Shan Mengyuan

-- Hong Kong (HKG)
UPDATE public.sailors SET dob = '1992-10-30' WHERE id = 'c4ccf651-74bb-48fb-a415-4e7eb6c25566'::uuid AND dob IS NULL; -- Sakai Akira Luke
UPDATE public.sailors SET dob = '2007-02-27' WHERE id = '45738280-8614-4370-8d08-cc59775ec6a3'::uuid AND dob IS NULL; -- Chan Kin Chung
UPDATE public.sailors SET dob = '1999-05-20' WHERE id = '8dad3ad4-b8cd-42bf-93d7-e62cb67dcc44'::uuid AND dob IS NULL; -- Choi Wing Chi Sandy
UPDATE public.sailors SET dob = '2005-03-12' WHERE id = '1ae9e11a-34e0-4bdf-91ac-b1fc061dec63'::uuid AND dob IS NULL; -- Di Salvo Maddalena
UPDATE public.sailors SET dob = '2008-12-31' WHERE id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d'::uuid AND dob IS NULL; -- Ziyan Huang

-- Japan (JPN)
UPDATE public.sailors SET dob = '2000-06-22' WHERE id = '214cb231-78dd-4313-97d5-5b1adba75406'::uuid AND dob IS NULL; -- Suzuki Yoshihiro
UPDATE public.sailors SET dob = '1998-12-21' WHERE id = 'e6a112d8-8246-4fa6-a220-c6fe18cde7ae'::uuid AND dob IS NULL; -- Ikeda Kensei
UPDATE public.sailors SET dob = '1989-01-09' WHERE id = '99b69b3f-9b87-479a-8fe4-1f0786295e04'::uuid AND dob IS NULL; -- Furuya Shingen
UPDATE public.sailors SET dob = '1996-08-21' WHERE id = 'a8290133-62ae-4d22-b023-f369f3cda452'::uuid AND dob IS NULL; -- Takayanagi Akira
UPDATE public.sailors SET dob = '1990-07-21' WHERE id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac'::uuid AND dob IS NULL; -- Yumiko Tombe
UPDATE public.sailors SET dob = '1994-06-03' WHERE id = '55032df8-1f6c-4ed6-a311-7eaec9054991'::uuid AND dob IS NULL; -- Nagamatsu Sera
UPDATE public.sailors SET dob = '2011-01-15' WHERE id = '54929eac-b75e-5608-b958-ce4543b75bb2'::uuid AND dob IS NULL; -- Ko Nagahori
UPDATE public.sailors SET dob = '2009-08-19' WHERE id = '3992aa68-97b2-5974-8d82-b143cd0accca'::uuid AND dob IS NULL; -- Misaki Tsunomori

-- South Korea (KOR)
UPDATE public.sailors SET dob = '1989-03-21' WHERE id = '786547fe-011a-4163-86ae-8c3fee8c18ce'::uuid AND dob IS NULL; -- Ha Jee-min
UPDATE public.sailors SET dob = '1986-05-18' WHERE id = '4cc8b986-413f-4f70-96ad-1a5da3166db1'::uuid AND dob IS NULL; -- Lee Taehoon
UPDATE public.sailors SET dob = '1994-10-03' WHERE id = '75638b49-c309-4ced-9da1-7ec53098f44b'::uuid AND dob IS NULL; -- Kim Kyoungduk
UPDATE public.sailors SET dob = '1992-05-13' WHERE id = '39755372-d829-4b0b-92e1-b1a4d98d6bf9'::uuid AND dob IS NULL; -- Bae Sangwoo
UPDATE public.sailors SET dob = '2007-04-01' WHERE id = 'dda955b2-0587-4554-bb46-2fe4c03c13be'::uuid AND dob IS NULL; -- Seol Jaekyoung

-- Oman (OMA)
UPDATE public.sailors SET dob = '2000-03-04' WHERE id = 'd05fafac-e6bc-43ce-8ff5-f613a34ea23a'::uuid AND dob IS NULL; -- Al-Hadhrami Abdul Majeed 'abdallah.
UPDATE public.sailors SET dob = '1989-04-04' WHERE id = 'fbb4b442-17fb-441b-afd8-7a1f5dc60201'::uuid AND dob IS NULL; -- Al Hadi Musab Mohammed Sulaiyam
UPDATE public.sailors SET dob = '1992-06-21' WHERE id = '6dea5267-b837-41bf-a47c-827da9e2df1a'::uuid AND dob IS NULL; -- Al-Kendi Waleed Issa Al-Habashi
UPDATE public.sailors SET dob = '2008-08-21' WHERE id = '141e5173-2117-49ac-ac34-30e0cdf4f8aa'::uuid AND dob IS NULL; -- Al Qasmi 'abdul Latif Zayad

-- Pakistan (PAK)
UPDATE public.sailors SET dob = '1987-08-01' WHERE id = '38e157cb-16a0-458b-96ee-7d17e6d9974d'::uuid AND dob IS NULL; -- Muzammil Hassan
UPDATE public.sailors SET dob = '2006-09-10' WHERE id = '41240944-2cad-400e-9007-4e7c5dd42c5b'::uuid AND dob IS NULL; -- Raphael Javed
UPDATE public.sailors SET dob = '2008-06-12' WHERE id = 'e4b09103-7a35-463d-95cf-bcbfd660c76e'::uuid AND dob IS NULL; -- Zoya Asad Ali

-- Philippines (PHI)
UPDATE public.sailors SET dob = '2003-12-27' WHERE id = 'e7ea10fe-1eac-4135-8fe6-848d704fb647'::uuid AND dob IS NULL; -- Paz Arrianne Angela

-- Qatar (QAT)
UPDATE public.sailors SET dob = '1995-10-07' WHERE id = '7eea0d06-26ee-4ef0-85c4-bcb2d1a6e84f'::uuid AND dob IS NULL; -- Albakri Faris
UPDATE public.sailors SET dob = '2006-04-22' WHERE id = '6d0bf79f-1030-48b4-9d0b-6533b5390505'::uuid AND dob IS NULL; -- Almulla Ahmed

-- Singapore (SGP)
UPDATE public.sailors SET dob = '2005-06-04' WHERE id = 'dbe45d3e-6640-4242-b347-f8ce6030a26c'::uuid AND dob IS NULL; -- Elkan Oh
UPDATE public.sailors SET dob = '2001-03-02' WHERE id = 'd2c42f1a-b69c-4006-a762-60f9cbc0bfad'::uuid AND dob IS NULL; -- Koh Yi Nian
UPDATE public.sailors SET dob = '1996-05-03' WHERE id = 'e0956f90-ed93-48b8-baae-7fdb43fdc027'::uuid AND dob IS NULL; -- Tan Jen-E
UPDATE public.sailors SET dob = '1990-12-09' WHERE id = '97cbde3f-9b92-5b2b-abbd-416a43ad32c9'::uuid AND dob IS NULL; -- Victoria Chan
UPDATE public.sailors SET dob = '2001-01-19' WHERE id = '80419c1d-1ffc-4e6b-9c75-d94a7516df6b'::uuid AND dob IS NULL; -- Marsha Shahrin
UPDATE public.sailors SET dob = '1996-08-26' WHERE id = 'fde81842-e9a6-4520-b233-1e48a3e7db2a'::uuid AND dob IS NULL; -- Kimberly Min Lim
UPDATE public.sailors SET dob = '1991-04-01' WHERE id = '62779f65-6235-407b-a5a4-4cbb203d8888'::uuid AND dob IS NULL; -- Cecilia Rui Qi Low

-- Sri Lanka (SRI)
UPDATE public.sailors SET dob = '2007-01-15' WHERE id = '128d6234-3abd-4751-93a2-d5443aff3e62'::uuid AND dob IS NULL; -- Nanayakkara Tharen Kashyapa
UPDATE public.sailors SET dob = '2006-02-02' WHERE id = '72c574c1-ac78-4010-84da-a757b6107794'::uuid AND dob IS NULL; -- Tranchell Arianna Taalya

-- Thailand (THA)
UPDATE public.sailors SET dob = '2006-04-19' WHERE id = 'd1f44ac8-a2c8-4ef8-bb61-67eeed95251e'::uuid AND dob IS NULL; -- Mcmillan William
UPDATE public.sailors SET dob = '2007-04-14' WHERE id = '09598763-fe5a-4206-bb1b-9abe000cba1d'::uuid AND dob IS NULL; -- Kachachuen Kan
UPDATE public.sailors SET dob = '2004-01-30' WHERE id = 'bcd2059f-fbb8-4f36-b1bb-ac6b705327f3'::uuid AND dob IS NULL; -- Homraruen Aticha
UPDATE public.sailors SET dob = '1993-05-25' WHERE id = 'd68643a6-97eb-4acb-8902-af1cb9a96e6d'::uuid AND dob IS NULL; -- Satta Narisara
UPDATE public.sailors SET dob = '1993-11-20' WHERE id = '7455b53a-a31d-4d48-b32a-0ae4cef63bc8'::uuid AND dob IS NULL; -- Waiwai Nichapa

-- United Arab Emirates (UAE)
UPDATE public.sailors SET dob = '1988-03-31' WHERE id = 'f75703bd-788d-4bfa-a02e-1b68b07d817a'::uuid AND dob IS NULL; -- Albastaki Adil
UPDATE public.sailors SET dob = '2006-09-01' WHERE id = '316d5c78-b82a-4baa-94d3-2aebd8e10acb'::uuid AND dob IS NULL; -- Alzaabi Mohamed
UPDATE public.sailors SET dob = '2003-10-04' WHERE id = '1de1fad7-66d8-4920-8c1c-df05fa371de7'::uuid AND dob IS NULL; -- Albeshr Dhuha Mohammed
UPDATE public.sailors SET dob = '2009-08-03' WHERE id = 'dd19a5d2-39a5-4b51-ad5f-2ce8b741dd19'::uuid AND dob IS NULL; -- Alqubaisi Camellia
