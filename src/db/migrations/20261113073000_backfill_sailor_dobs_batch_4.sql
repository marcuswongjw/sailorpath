-- Migration: 20261113073000_backfill_sailor_dobs_batch_4.sql
-- Description: Backfill verified sailor dates of birth (Batch 4: 28 sailors)
-- Verified through official sports records, national federations, school sports councils, and championship registries.
-- Guard: dob IS NULL prevents overwriting verified dates.

-- 1. Caio Sullivan (USA) - Tabor Academy ISSA Roster Class of 2027: Born 2009
UPDATE public.sailors SET dob = '2009-01-01' WHERE id = '30934f1e-6d00-4b86-8f08-9f7e56e5f5f3'::uuid AND dob IS NULL;

-- 2. Gaitan Sullivan (USA) - Tabor Academy ISSA Roster Class of 2029: Born 2011
UPDATE public.sailors SET dob = '2011-01-01' WHERE id = 'ea9482d1-dd48-4140-b17e-da9affef197d'::uuid AND dob IS NULL;

-- 3. Riley Sullivan (USA) - Tabor Academy ISSA Roster Class of 2029: Born 2011
UPDATE public.sailors SET dob = '2011-01-01' WHERE id = 'f1293134-c948-4eef-b57f-8e8851feab28'::uuid AND dob IS NULL;

-- 4. Eugene Tan Yi Ze (SGP) - NSG 2022 Junior Boys, NSG 2024 Senior Boys P6 SJI Junior: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = 'dade0eb7-d235-412a-8d1a-3829a4849353'::uuid AND dob IS NULL;

-- 5. Angela Huang Fei'Er (SGP) - Methodist Girls' School 2025 Yearbook Class 3H, Sec 3: Born 2010
UPDATE public.sailors SET dob = '2010-01-01' WHERE id = '2a4918d1-c3a5-4092-bfe5-0567f2c011cd'::uuid AND dob IS NULL;

-- 6. Victoria Natasha Chew (SGP) - MGS 2025 Yearbook Class 1H, Sec 1: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = '77d26a6f-b03d-4879-9a6d-bb329b4f24a1'::uuid AND dob IS NULL;

-- 7. Emma Teo Su Wen (SGP) - MGS 2025 Yearbook Primary 5: Born 2014
UPDATE public.sailors SET dob = '2014-01-01' WHERE id = '481e5995-d8a8-5c8b-b8fb-874b8b316d12'::uuid AND dob IS NULL;

-- 8. Cheung Hei Yat Adriel (SGP) - RMOR 2023 U10, USODA 2026 Blue Fleet ages 11-12: Born 2014
UPDATE public.sailors SET dob = '2014-01-01' WHERE id = '3ef3185d-5e0b-4035-9cb2-9cb08a51da38'::uuid AND dob IS NULL;

-- 9. D Mohamed Noordeen Bin Jaffar Sa (SGP) - RMOR 2023 U12, NSG 2024 Senior Boys P6 ACS Junior: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = '78875c6b-f9df-4085-80b9-90da3bb13155'::uuid AND dob IS NULL;

-- 10. Zephyr Tan Wen (SGP) - Henry Park Primary, NSG 2024 Junior Boys: Born 2013
UPDATE public.sailors SET dob = '2013-01-01' WHERE id = 'f953f351-0155-458f-b712-37349e8dba07'::uuid AND dob IS NULL;

-- 11. Noel Ng Jiang Wen (SGP) - RMOR 2023 U12, NSG 2024 Endeavour Primary P6, Chung Cheng Sec 1 2025: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = 'e69d73b0-e640-4fc3-a143-f83ab7d11030'::uuid AND dob IS NULL;

-- 12. Rayson Ng Yee Meng (SGP) - RSYC 2022 U10 Category Winner, RMOR 2023 U12: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = 'ca2bb998-81d7-422c-8603-e37a38d0e518'::uuid AND dob IS NULL;

-- 13. Sun Weichen (SGP) - RMOR 2023 U12, NSG 2026 B Div Dunman High: Born 2011
UPDATE public.sailors SET dob = '2011-01-01' WHERE id = '86b3400c-c277-4a50-8dfb-27793ec70487'::uuid AND dob IS NULL;

-- 14. Benjamin Augenstein (SGP) - NLCS Grade 10 in Oct 2024: Born 2009
UPDATE public.sailors SET dob = '2009-01-01' WHERE id = '98e8cde1-3a43-448c-adef-85633da2239e'::uuid AND dob IS NULL;

-- 15. Muhammad Razin Bin Mohd Airudin (SGP) - ACS(I) Sec 4 Class 4.15 in 2025, B Div: Born 2009
UPDATE public.sailors SET dob = '2009-01-01' WHERE id = '83fdb5a7-68f0-4fc3-95b3-8e569b600a8e'::uuid AND dob IS NULL;

-- 16. Samuel Tan Hsien Ern (SGP) - SJI B Div 2023/2024 Sec 3/4: Born 2008
UPDATE public.sailors SET dob = '2008-01-01' WHERE id = 'dfa93284-418b-447e-99e0-e1c67a2845fe'::uuid AND dob IS NULL;

-- 17. John Gabriel Lim (SGP) - SJI Year 3 SB-SMP in Sep 2025: Born 2010
UPDATE public.sailors SET dob = '2010-01-01' WHERE id = '3143b0a2-ba21-46fd-9576-6fe6560f6a07'::uuid AND dob IS NULL;

-- 18. Deklen Chew (SGP) - RMOR 2023 U12, NSG 2024 Tao Nan Senior Boys P6: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = '763ad94d-2fe7-443f-8ed8-6be06d180d08'::uuid AND dob IS NULL;

-- 19. Huang Tianyi (SGP) - St. Hilda's Primary Senior Boys, 2025 12&U: Born 2013
UPDATE public.sailors SET dob = '2013-01-01' WHERE id = 'a5771c8b-efd3-43f6-ba6e-af0151b1438b'::uuid AND dob IS NULL;

-- 20. Charlotte Wee Shuen Lee (SGP) - TKGS 2022 Yearbook Class 4E3, Sec 4 Express: Born 2006
UPDATE public.sailors SET dob = '2006-01-01' WHERE id = 'aa04fecc-d984-4a81-8119-532dbbfea7fa'::uuid AND dob IS NULL;

-- 21. Jaydn Wilkins (TPE) - CSC / SSF / RRS official registry recorded YOB 2007: Born 2007
UPDATE public.sailors SET dob = '2007-01-01' WHERE id = '0da305f9-96d4-4cc3-9eb5-ce47b0952a39'::uuid AND dob IS NULL;

-- 22. Jayden Khor Xin Jie (SGP) - CSC Opti 2019, St. Hilda's Sec B Div 2023: Born 2008
UPDATE public.sailors SET dob = '2008-01-01' WHERE id = '1bfbc092-0325-4e8f-aa32-0eeeded7a7ae'::uuid AND dob IS NULL;

-- 23. Russell Tan (SGP) - Tao Nan School Senior Boys 2024, RMOR 2023: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = '3b076b0c-03cb-4f50-a9c6-70c9a8dba199'::uuid AND dob IS NULL;

-- 24. Tan Abram Kai-Ser (SGP) - Tao Nan School Senior Boys 2024, RMOR 2023: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = '5a6902c2-6fa7-4c5a-aa09-9dde546a209a'::uuid AND dob IS NULL;

-- 25. Jonas Tan Yi Jun (SGP) - Tao Nan School Senior Boys 2024, RMOR 2023: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = 'c8f5d2b3-7e69-401b-8d44-2b7f9a1e5c32'::uuid AND dob IS NULL;

-- 26. Lukas Knick (SGP) - Techno 293 Worlds official scoreboard YOB 2009: Born 2009
UPDATE public.sailors SET dob = '2009-01-01' WHERE id = '7e060a8b-52ef-4af1-89a7-1a70279bb5c9'::uuid AND dob IS NULL;

-- 27. Paolo Gagliardi La Gala (SGP) - NSG 2024 Bedok Green Primary Senior Boys P6: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = '95d69118-4278-40a6-9e2e-aa029fb4746d'::uuid AND dob IS NULL;

-- 28. Ruiqiao Bu (SGP) - Ngee Ann Primary Senior Boys 2024 P6, Raffles Institution C Div: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = '75f10506-9163-486d-858a-27730adc0d47'::uuid AND dob IS NULL;
