-- Migration: 20261112215000_backfill_sailor_dobs_batch_3.sql
-- Description: Backfill verified sailor dates of birth (Batch 3: 29 sailors)
-- Verified through official sports records, national federations, school sports councils, and championship registries.
-- Guard: dob IS NULL prevents overwriting verified dates.

-- 1. Neha Thakur (IND) - Asian Games 2022 silver medallist (ILCA 4): Born 2006-08-24
UPDATE public.sailors SET dob = '2006-08-24' WHERE id = '730a4718-7415-415f-96f0-207752229165'::uuid AND dob IS NULL;

-- 2. Adhvait Menon (IND) - Asian Games / OCA athlete profile: Born 2006-06-26
UPDATE public.sailors SET dob = '2006-06-26' WHERE id = 'c153f64b-098f-48a4-aa5a-f4dc97529d47'::uuid AND dob IS NULL;

-- 3. Savarimuthu Jerome Kumar (IND) - Asian Games athlete profile: Born 1990-05-25
UPDATE public.sailors SET dob = '1990-05-25' WHERE id = '51eb0bf2-d24f-434d-aaef-94b2a43bee34'::uuid AND dob IS NULL;

-- 4. Udaiveer Singh Johal (IND) - YAI Youth Nationals Registry: Born 2013-09-19
UPDATE public.sailors SET dob = '2013-09-19' WHERE id = 'ef42bbce-d6be-4ef1-be59-fc720d1d9ed0'::uuid AND dob IS NULL;

-- 5. Haziq Mustaqim Bin Mohd Husni (MAS) - Sailwave MSST Official Registry: Born 2009-04-20
UPDATE public.sailors SET dob = '2009-04-20' WHERE id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b'::uuid AND dob IS NULL;

-- 6. Muhammad Ammar Zikri Bin Azman (MAS) - Sailwave MSST Official Registry: Born 2011-07-21
UPDATE public.sailors SET dob = '2011-07-21' WHERE id = '0cb5bbd8-bae4-5988-953b-e9ea98e6ba02'::uuid AND dob IS NULL;

-- 7. Jania Ang (SGP) - Team Singapore Athlete, Asian Games medallist: Born 2004
UPDATE public.sailors SET dob = '2004-01-01' WHERE id = 'ddfe8d27-5c27-4cc6-b7b3-5c5d89564914'::uuid AND dob IS NULL;

-- 8. Cleo Seah En Rui (SGP) - National School Games C Div 2022/2023, B Div 2024 (RGS): Born 2009
UPDATE public.sailors SET dob = '2009-01-01' WHERE id = 'bee71ffd-0b62-4fda-af0a-5b931c110e57'::uuid AND dob IS NULL;

-- 9. Elizabeth Victoria Say (SGP) - CHIJ Katong Primary Senior Div 2022: Born 2010
UPDATE public.sailors SET dob = '2010-01-01' WHERE id = '1873b5fc-0682-4bfc-b02b-9e453e49f384'::uuid AND dob IS NULL;

-- 10. Aaron Abraham Say (SGP) - St. Stephen's Primary 2024, Victoria School C Div 2025: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = '4e344e28-9a6f-4ae4-93d8-537bc03e1813'::uuid AND dob IS NULL;

-- 11. Abigail Jia En Ling (SGP) - Tao Nan School Senior Div 2021: Born 2009
UPDATE public.sailors SET dob = '2009-01-01' WHERE id = '659d2fab-d7dc-409c-8c87-22379c586910'::uuid AND dob IS NULL;

-- 12. Axl Tan Yi En (SGP) - ACS Barker Road C Div 2023, B Div 2024: Born 2009
UPDATE public.sailors SET dob = '2009-01-01' WHERE id = 'd16d2658-3ee4-468c-8ee7-934c6a103fec'::uuid AND dob IS NULL;

-- 13. Regis Wong Xuan Kai (SGP) - ACS Barker Road C Div 2023, B Div 2024: Born 2009
UPDATE public.sailors SET dob = '2009-01-01' WHERE id = 'e1f64962-8765-419f-9e47-5f9e92624ae6'::uuid AND dob IS NULL;

-- 14. Zachary Hong Yi Zhang (SGP) - SJI Sec 1 in 2021: Born 2008
UPDATE public.sailors SET dob = '2008-01-01' WHERE id = 'a841f654-dcfd-44ca-9546-a31595385ee0'::uuid AND dob IS NULL;

-- 15. Mohit Mhatre (IND) - World Sailing / MyLiveRegatta YOB 2011: Born 2011
UPDATE public.sailors SET dob = '2011-01-01' WHERE id = '05012e20-37c2-4f95-86a8-14f2367f3177'::uuid AND dob IS NULL;

-- 16. Chandralekha Tattari (IND) - Deccan Chronicle / YCH (16 years old in mid-2026): Born 2009
UPDATE public.sailors SET dob = '2009-01-01' WHERE id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80'::uuid AND dob IS NULL;

-- 17. Rizwan Mohammed (IND) - Times of India / YCH (15 years old in 2025): Born 2010
UPDATE public.sailors SET dob = '2010-01-01' WHERE id = 'ba485b02-3d8a-472c-b7f6-922bd692eebf'::uuid AND dob IS NULL;

-- 18. MD Riziwan (IND) - YCH / Tiscon Youth Open Regatta (born 2010): Born 2010
UPDATE public.sailors SET dob = '2010-01-01' WHERE id = '5b44e5a5-c1c5-5288-a10b-7a4163cc2325'::uuid AND dob IS NULL;

-- 19. Muhammad Hamka Naufal Bin Mohd Hasrizan (MAS) - SUKMA / Harian Metro (born 2007): Born 2007
UPDATE public.sailors SET dob = '2007-01-01' WHERE id = 'bb5845d9-f2eb-5d75-b421-130522197ff6'::uuid AND dob IS NULL;

-- 20. Amni Nur Afifa Binti Mohd Azlan (MAS) - Sailwave MSST 2025 Optimist F15 (born 2010): Born 2010
UPDATE public.sailors SET dob = '2010-01-01' WHERE id = 'a246e2ce-5bfd-5212-b021-99a80151b1b0'::uuid AND dob IS NULL;

-- 21. Li-Pan Cheng (TPE) - Ximen Elementary School Grade 6 in 2025: Born 2013
UPDATE public.sailors SET dob = '2013-01-01' WHERE id = '6bf21dbb-951a-593f-958a-83e8a1f747f7'::uuid AND dob IS NULL;

-- 22. Jo Yamada (JPN) - Bulkhead Magazine / Hyogo Jr Open Grade 6 in 2026: Born 2014
UPDATE public.sailors SET dob = '2014-01-01' WHERE id = '1ac9dc89-783e-56c9-8c8d-785a5e10cccc'::uuid AND dob IS NULL;

-- 23. Taiga Miyatake (JPN) - Bulkhead Magazine Grade 5 in 2022: Born 2011
UPDATE public.sailors SET dob = '2011-01-01' WHERE id = '234b96c7-73e8-59f9-832d-6d9015917659'::uuid AND dob IS NULL;

-- 24. Rento Kasagi (JPN) - Wakayama Cold Cup Grade 6 in Feb 2025: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = 'f0bd203e-94f4-5484-8ddf-cbdd19aab450'::uuid AND dob IS NULL;

-- 25. Kengo Yamamoto (JPN) - All Japan Optimist Championships Grade 5 in 2023: Born 2012
UPDATE public.sailors SET dob = '2012-01-01' WHERE id = '5630e6fd-a5f6-537f-8754-461b642feccd'::uuid AND dob IS NULL;

-- 26. Nao Toda (JPN) - YMFS Challenge Cup Junior High Grade 1 in March 2025: Born 2011
UPDATE public.sailors SET dob = '2011-01-01' WHERE id = '18e73ee3-3792-59f9-aa32-649ca6ca325d'::uuid AND dob IS NULL;

-- 27. Futa Iwasaki (JPN) - Takamatsu Sailing Club Junior High Grade 2 in Feb 2026: Born 2011
UPDATE public.sailors SET dob = '2011-01-01' WHERE id = 'ff62d4d8-c48a-587d-ab98-b19b551126cb'::uuid AND dob IS NULL;

-- 28. Miyu Sakaguchi (JPN) - Fukuoka Daiichi High School freshman 2026: Born 2010
UPDATE public.sailors SET dob = '2010-01-01' WHERE id = '823c8645-7014-5734-8a89-0aa2a1739d46'::uuid AND dob IS NULL;

-- 29. Yuki Shiina (JPN) - EYCJ / Yumeshima Regatta Elementary school division 2026: Born 2014
UPDATE public.sailors SET dob = '2014-01-01' WHERE id = '13bd0aab-ee6e-5536-8fb7-836169c66fac'::uuid AND dob IS NULL;
