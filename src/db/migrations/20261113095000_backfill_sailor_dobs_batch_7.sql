--
-- Migration: backfill_sailor_dobs_batch_7
-- Batch 7: Backfill verified sailor dates of birth from official regatta results and scoring records.
--
-- Primary Sources:
-- 1. Official Terengganu Sailing Association (TSA) / MSST regatta scoring records on Sailwave:
--    - https://sailwave.com/results/TSA/tsail_e01-OPTIMIST.html (Optimist Division & Overall)
--    - https://sailwave.com/results/TSA/tsail_e01-ILCA.html (ILCA 4/6/7 Fleets)
--    - https://sailwave.com/results/TSA/tsail_e01-dhanded.html (Double Handed Dinghy Fleets)
--    - https://sailwave.com/results/TSA/tsail-e01-windsurf.html (Windsurf Division)
--    - https://sailwave.com/results/TSA/tsail-e02_participants_list.html (Participant Registry)
--    - https://sailwave.com/results/twins/tstracewks01-List_Int420.html (Int 420 Class Registry)
--    - https://sailwave.com/results/twins/tstracewks01-List_ILCA6&7.html (ILCA 6 & 7 Registry)
--    - https://sailwave.com/results/twins/MSST_Optimist.htm (MSST Optimist Registry)
--    - https://sailwave.com/results/twins/sukma_open.htm (SUKMA Selection & Open)
--    - https://sailwave.com/results/twins/Sel_Trial-ILCA_7.htm (Selection Trial Registry)
--
-- All updates enforce `WHERE id = '...'::uuid AND dob IS NULL;` ensuring verified existing dates are never overwritten.
--
BEGIN;

-- Ruqayyah Binti Muhammad Nulhakim (Source: tsail_e01-OPTIMIST.html, raw: 28/9/2013)
UPDATE public.sailors SET dob = '2013-09-28'::date WHERE id = '7b1b70f9-6de9-41cc-9fc4-a1146358ed52'::uuid AND dob IS NULL;

-- Hanis Najihah bt Yusri Herman (Source: tsail_e01-OPTIMIST.html, raw: 23/1/2011)
UPDATE public.sailors SET dob = '2011-01-23'::date WHERE id = 'b869b416-4433-4d6f-8edd-de6fa57cb264'::uuid AND dob IS NULL;

-- Nur Qisya Qaisarah Binti Mohd Ruzaini (Source: tsail_e01-OPTIMIST.html, raw: 15/4/2013)
UPDATE public.sailors SET dob = '2013-04-15'::date WHERE id = 'b3ed5aae-29b6-49ce-8bc6-33e365466acf'::uuid AND dob IS NULL;

-- Aqil Rayyan Ramadhan Bin Mohamad Hashim (Source: tsail_e01-OPTIMIST.html, raw: 16/8/2011)
UPDATE public.sailors SET dob = '2011-08-16'::date WHERE id = 'ae04a81c-183d-4074-b1f2-67d43ac21913'::uuid AND dob IS NULL;

-- Amzar Syaaban Bin Mohd Noor Azman (Source: tsail_e01-OPTIMIST.html, raw: 3/6/2013)
UPDATE public.sailors SET dob = '2013-06-03'::date WHERE id = '39d15372-66c0-477f-a1a2-7524863abdbf'::uuid AND dob IS NULL;

-- Muhammad Elman Syahmi Bin Rashidi (Source: tsail_e01-OPTIMIST.html, raw: 3/2/2012)
UPDATE public.sailors SET dob = '2012-02-03'::date WHERE id = '6956fb76-e1de-428b-a46e-8630504b7b1b'::uuid AND dob IS NULL;

-- Firassyazwan Bin Zamri (Source: tsail_e01-OPTIMIST.html, raw: 10/7/2013)
UPDATE public.sailors SET dob = '2013-07-10'::date WHERE id = 'a034226c-a0e1-4d23-b543-542f07d0e1fa'::uuid AND dob IS NULL;

-- Haziq Danish Bin Azani (Source: tsail_e01-OPTIMIST.html, raw: 28/10/2012)
UPDATE public.sailors SET dob = '2012-10-28'::date WHERE id = 'e8e077fd-e850-49b3-967c-01504aed5f03'::uuid AND dob IS NULL;

-- Mohamad Ikhlas Redzki Najib Bin Bohani (Source: tsail_e01-OPTIMIST.html, raw: 2/10/2011)
UPDATE public.sailors SET dob = '2011-10-02'::date WHERE id = '70fb52c0-8777-4dbc-8d4c-340660ff0399'::uuid AND dob IS NULL;

-- Muhammad Nazmi Qusyairi Bin Mohd Nazri (Source: tstracewks01-List_Int420.html, raw: 21/8/2005)
UPDATE public.sailors SET dob = '2005-08-21'::date WHERE id = '580a0306-cd4c-548f-a98c-38bde8e7846c'::uuid AND dob IS NULL;

-- Ammar Bin Azali (Source: tstracewks01-List_ILCA6&7.html, raw: 12/6/2007)
UPDATE public.sailors SET dob = '2007-06-12'::date WHERE id = '8aabfea9-a419-5648-9b0d-b07ce894ea6e'::uuid AND dob IS NULL;

-- Bibi Qeesha Binti Mohd Faizal (Source: tsail_e01-dhanded.html, raw: 15/11/2008)
UPDATE public.sailors SET dob = '2008-11-15'::date WHERE id = '0ad44896-4a70-528f-88ea-a31f0f6d6538'::uuid AND dob IS NULL;

-- Nur Aqilah Raifana Binti Aslan (Source: tsail_e01-dhanded.html, raw: 5/9/2007)
UPDATE public.sailors SET dob = '2007-09-05'::date WHERE id = '7d79261f-75e1-5069-a10e-567d9c9816f3'::uuid AND dob IS NULL;

-- Muhammad Yusri Bin Syahrizan (Source: tsail_e01-dhanded.html, raw: 13/2/2008)
UPDATE public.sailors SET dob = '2008-02-13'::date WHERE id = 'c9df556b-7b8e-5944-92c8-0cc863207d9b'::uuid AND dob IS NULL;

-- Muhammad Idris Bin Mohd Zahawi (Source: tsail-e02_participants_list.html, raw: 28/8/2006)
UPDATE public.sailors SET dob = '2006-08-28'::date WHERE id = '9e4c2cd7-24d6-51e0-8d7e-5e6d91ee137a'::uuid AND dob IS NULL;

-- Nur 'Ain Binti Syahrizan (Source: tsail_e01-ILCA.html, raw: 18/10/2009)
UPDATE public.sailors SET dob = '2009-10-18'::date WHERE id = '36daa0e1-333c-5f4c-b5c1-435e38c6f948'::uuid AND dob IS NULL;

-- Mas Vanya Kirstyn Teruki (Source: tsail_e01-ILCA.html, raw: 22/1/2009)
UPDATE public.sailors SET dob = '2009-01-22'::date WHERE id = 'bb3a2667-c68d-5c1e-a0c9-571847f45b70'::uuid AND dob IS NULL;

-- Ainur Mardhiah Binti Mohd Shailannie (Source: tsail_e01-ILCA.html, raw: 11/8/2008)
UPDATE public.sailors SET dob = '2008-08-11'::date WHERE id = '0964f4f8-25aa-53a0-87c3-3cc4e4b93b58'::uuid AND dob IS NULL;

-- Farish Hanif Bin Zamri (Source: tsail_e01-ILCA.html, raw: 29/7/2007)
UPDATE public.sailors SET dob = '2007-07-29'::date WHERE id = '709a793b-9bc0-5708-89e4-18afc8c48d2d'::uuid AND dob IS NULL;

-- Haziem Hakimi Bin Edie Akbar (Source: tsail_e01-ILCA.html, raw: 15/4/2009)
UPDATE public.sailors SET dob = '2009-04-15'::date WHERE id = 'bcf5dfcc-5bea-5f87-8080-564805c9695e'::uuid AND dob IS NULL;

-- Fikri Izzan Bin Zamri (Source: tsail_e01-ILCA.html, raw: 19/12/2008)
UPDATE public.sailors SET dob = '2008-12-19'::date WHERE id = 'dffe8ea9-f134-5a78-9fc2-e7837c01e591'::uuid AND dob IS NULL;

-- Ammar Danish Bin Khairul Azhar (Source: tsail-e01-windsurf.html, raw: 14/3/2010)
UPDATE public.sailors SET dob = '2010-03-14'::date WHERE id = '5e56bd58-f094-5e35-8761-403ce2c7a21d'::uuid AND dob IS NULL;

-- Muhammad Hikmy Qhalif b. Mohd Hafiz (Source: tsail_e01-OPTIMIST.html, raw: 11/9/2011)
UPDATE public.sailors SET dob = '2011-09-11'::date WHERE id = '0e694abb-d4e1-4cd5-b306-df873651d5b1'::uuid AND dob IS NULL;

-- Muhammad Hizmy Qhalif b. Mohd Hafiz (Source: tsail_e01-OPTIMIST.html, raw: 2/10/2012)
UPDATE public.sailors SET dob = '2012-10-02'::date WHERE id = 'ef1612bf-6d44-445c-9aa3-54a8da76eea2'::uuid AND dob IS NULL;

-- Putra Hasief Haiqal Bin Erwanzee (Source: MSST_Optimist.htm, raw: 21/12/2011)
UPDATE public.sailors SET dob = '2011-12-21'::date WHERE id = 'fd7c88c7-16fb-4ac5-96c9-723b9522e043'::uuid AND dob IS NULL;

-- Tengku Nurani Ezaty Binti Tengku Kahirudeen (Source: sukma_open.htm, raw: 8/1/2004)
UPDATE public.sailors SET dob = '2004-01-08'::date WHERE id = '3f0aaa81-cb50-567d-bf36-63f802d41cf5'::uuid AND dob IS NULL;

-- Qaisarah Damia Binti Mohamad Faizal (Source: Sel_Trial-ILCA_7.htm, raw: 24/3/2009)
UPDATE public.sailors SET dob = '2009-03-24'::date WHERE id = 'd66bce28-eef0-57f8-8c00-679446eca2bd'::uuid AND dob IS NULL;

COMMIT;
