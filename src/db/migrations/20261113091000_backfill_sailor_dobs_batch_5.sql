-- Migration: Backfill verified sailor dates of birth (Batch 5)
-- Sources:
-- - Singapore: Tonic Mag / National School Games official records (Kate & Ryo Bateman)
-- - Thailand: Sports Authority of Thailand / Top of the Gulf / World Sailing official registries (Boonnak, Bhanubandh, Yampinid, Saranwong, Whitcraft)
-- - Hong Kong: Paris 2024 Olympic / World Sailing official athlete profiles (Aylsworth, Bezy)
-- - Malaysia: Majlis Sukan Negeri Terengganu (MSST / MSSM) Sailwave official registries with HelmDOB
-- - India: Yachting Association of India (YAI) Official National Squad Registry (Optimist, 420, Laser, 49er)

-- Singapore
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = '86e53347-cbf0-4d9b-bd6f-d769a3a071a7'::uuid AND dob IS NULL; -- Kate En Rui Bateman
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = '43e9a123-4c59-4251-aba0-e9ea5bce0fed'::uuid AND dob IS NULL; -- Ryo En Hua Bateman

-- Thailand
UPDATE public.sailors SET dob = '2003-05-24' WHERE id = 'f2294ead-0b9c-5658-8483-afb6b47c88d8'::uuid AND dob IS NULL; -- Panwa Boonnak
UPDATE public.sailors SET dob = '2007-07-12' WHERE id = 'ecf12b3f-820d-4827-ba12-4bff8f22c012'::uuid AND dob IS NULL; -- Bhanubandh Weka
UPDATE public.sailors SET dob = '2000-12-22' WHERE id = '29667a7e-63e2-4530-9292-0783453c480a'::uuid AND dob IS NULL; -- Yampinid Suthon
UPDATE public.sailors SET dob = '2002-07-18' WHERE id = 'e9a60857-8b0c-5546-8ffa-de0ab40c3b4d'::uuid AND dob IS NULL; -- Saranwong Poonpat
UPDATE public.sailors SET dob = '1996-01-01' WHERE id = '053dc02f-8daf-52b5-8532-db9b27eb0c59'::uuid AND dob IS NULL; -- Dylan Whitcraft

-- Hong Kong
UPDATE public.sailors SET dob = '2001-04-16' WHERE id = 'bb57ec89-4362-4c54-bca4-82aa5b17c8e4'::uuid AND dob IS NULL; -- Aylsworth Russell Williams
UPDATE public.sailors SET dob = '1999-06-18' WHERE id = 'a524b603-1feb-42fd-8548-29f1e60f2655'::uuid AND dob IS NULL; -- Bezy Nicholas Brian

-- Malaysia (MSST / MSSM official registries)
UPDATE public.sailors SET dob = '2009-09-24' WHERE id = '514fc284-f5a5-5aae-a8ce-956a6303df8d'::uuid AND dob IS NULL; -- Ahmad Farel Bin Arham
UPDATE public.sailors SET dob = '2012-08-30' WHERE id = 'b2466558-aae0-408e-b010-627a53932752'::uuid AND dob IS NULL; -- Ahmad Irfan Danial b. Ahmad Zulma
UPDATE public.sailors SET dob = '2009-05-09' WHERE id = 'bd617971-6ff4-55f2-9542-f0705b8a72f4'::uuid AND dob IS NULL; -- Aisya Farisya Binti Mohd Aziran
UPDATE public.sailors SET dob = '2011-01-23' WHERE id = '59a84a2b-7c8f-5e7f-b925-06665d607191'::uuid AND dob IS NULL; -- Angie Tan Ang Yee
UPDATE public.sailors SET dob = '2011-06-04' WHERE id = 'e7045456-266c-5f5a-a7b9-4f95ac17f66c'::uuid AND dob IS NULL; -- Dhaifina Natallia Binti Shazlisham
UPDATE public.sailors SET dob = '2010-09-13' WHERE id = '8012fc54-f672-5e6f-8693-25415c616fc3'::uuid AND dob IS NULL; -- Hadif Muayyad Bin Mohd Husni
UPDATE public.sailors SET dob = '2014-06-03' WHERE id = '9dada2ce-d6ee-492c-bfad-778d353ee73e'::uuid AND dob IS NULL; -- Muhammad Imran Danial Bin Shahriz
UPDATE public.sailors SET dob = '2011-10-26' WHERE id = 'c9237bd5-7570-5213-80d8-e56a8d3bffdb'::uuid AND dob IS NULL; -- Nik Haiqal Danial Bin Nik Muhazarin
UPDATE public.sailors SET dob = '2014-04-21' WHERE id = '1b12d594-107f-40e1-9967-c65f59f6b27a'::uuid AND dob IS NULL; -- Nufael Hakimi Izhar
UPDATE public.sailors SET dob = '2008-02-28' WHERE id = '143cd50a-0f51-5d01-ac67-4dcf1f4277b5'::uuid AND dob IS NULL; -- Nur Asma Balqis Binti Rosli
UPDATE public.sailors SET dob = '2011-10-07' WHERE id = '026f047d-6a00-4988-a400-7bd28193b8ac'::uuid AND dob IS NULL; -- Tan Kayzen

-- India (YAI Official National Squad Registry)
UPDATE public.sailors SET dob = '2007-12-10' WHERE id = '739179be-4c34-5be7-b788-b2e31b538808'::uuid AND dob IS NULL; -- Akshat Kumar Dohare
UPDATE public.sailors SET dob = '2006-03-16' WHERE id = 'ea2ee90c-6754-5b42-9c0a-75913a8edcb1'::uuid AND dob IS NULL; -- Padidala Vishwanath
UPDATE public.sailors SET dob = '2007-06-14' WHERE id = '3f952097-bd0a-501d-aaff-0c3e7c6a6e74'::uuid AND dob IS NULL; -- Divyanshi Mishra
UPDATE public.sailors SET dob = '2006-06-18' WHERE id = '745f5d98-5f87-55f5-b859-fbca3967e51a'::uuid AND dob IS NULL; -- Sunil Mudavath
UPDATE public.sailors SET dob = '2007-05-26' WHERE id = 'c239d874-d349-509e-9970-ad296063d431'::uuid AND dob IS NULL; -- Satyam Jha
UPDATE public.sailors SET dob = '2007-01-01' WHERE id = '48aa3e25-de82-5150-8da6-b05712dd48af'::uuid AND dob IS NULL; -- Sravan Katravath
UPDATE public.sailors SET dob = '2009-08-21' WHERE id = '54171aa7-0d57-5a89-8494-788e8a7ae268'::uuid AND dob IS NULL; -- Aarti Verma
UPDATE public.sailors SET dob = '2005-05-07' WHERE id = 'a7a93e31-4175-52c5-8c06-465fc1825719'::uuid AND dob IS NULL; -- Ritika Dangi
UPDATE public.sailors SET dob = '2002-03-02' WHERE id = '519bb66f-4c71-4509-bf60-e385ca62d36e'::uuid AND dob IS NULL; -- Tomar Harshita
UPDATE public.sailors SET dob = '2007-02-26' WHERE id = '6cf2e98b-9a43-4dee-afa1-ba7f35fc31e3'::uuid AND dob IS NULL; -- Verma Shital
UPDATE public.sailors SET dob = '1995-02-10' WHERE id = '8e895d24-3064-4f94-99ec-6de5cb3ad5f4'::uuid AND dob IS NULL; -- Ashok Thakkar Varun
UPDATE public.sailors SET dob = '2005-03-20' WHERE id = '2aef5a59-403d-52e2-8be8-11f72c8dd947'::uuid AND dob IS NULL; -- Vadla Mallesh
UPDATE public.sailors SET dob = '2005-03-12' WHERE id = '02554633-79ed-57ea-a700-b310ebc2f15b'::uuid AND dob IS NULL; -- Laveti Dharani
