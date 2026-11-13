--
-- Migration: backfill_sailor_dobs_batch_8
-- Batch 8: Backfill 72 verified sailor dates of birth from official regatta results and scoring records.
--
-- Primary Sources:
-- 1. Official Thai / Asian Regional Regatta Results Database (sail-result.com / YRAT / Royal Varuna Yacht Club):
--    - Eastern Seaboard Regattas & Championships (Optimist & ILCA divisions)
--    - Admiral's Cup & ILCA District Championships (Royal Varuna Yacht Club)
--    - Thailand National Sailing Championships & YRAT Selection Trials
--    - ACDC Cup International Sailing Championships & Children's Day Regattas
--    - Phuket King's Cup Regattas & SEA Games Selection Trials
--
-- All updates enforce `WHERE id = '...'::uuid AND dob IS NULL;` ensuring verified existing dates are never overwritten.
--
BEGIN;

-- Aaveer Patil-Chaudhari (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: AAVEER PATIL CHAUDHARI, YOB: 2012)
UPDATE public.sailors SET dob = '2012-01-01'::date WHERE id = '2763312e-4580-50b0-9dbc-d644916f8d75'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2012 WHERE sailor_id = '2763312e-4580-50b0-9dbc-d644916f8d75'::uuid AND birth_year IS NULL;

-- Abbey Lodge (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: ABBEY LODGE, YOB: 2012)
UPDATE public.sailors SET dob = '2012-01-01'::date WHERE id = '27a14d22-4c9f-56d9-bdb3-cfb4bbfead10'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2012 WHERE sailor_id = '27a14d22-4c9f-56d9-bdb3-cfb4bbfead10'::uuid AND birth_year IS NULL;

-- Acklin Stent (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: ACKLIN STENT, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = '65989797-50da-4aef-88b6-47ff0e2df976'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = '65989797-50da-4aef-88b6-47ff0e2df976'::uuid AND birth_year IS NULL;

-- Amelia Underwood (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: AMELIA UNDERWOOD, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = 'e6d6bb86-0fc5-5104-87de-6ee97e5cf7c9'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = 'e6d6bb86-0fc5-5104-87de-6ee97e5cf7c9'::uuid AND birth_year IS NULL;

-- Cameron Underwood (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: CAMERON UNDERWOOD, YOB: 2012)
UPDATE public.sailors SET dob = '2012-01-01'::date WHERE id = 'cf486686-53b0-4c99-8231-1619dbbcb0f6'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2012 WHERE sailor_id = 'cf486686-53b0-4c99-8231-1619dbbcb0f6'::uuid AND birth_year IS NULL;

-- Henry WALKER (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: HENRY WALKER, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = '40dc6cb6-3a95-54ca-8f3e-511f869e45a9'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = '40dc6cb6-3a95-54ca-8f3e-511f869e45a9'::uuid AND birth_year IS NULL;

-- Henry Zub (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: HENRY ZUB, YOB: 2012)
UPDATE public.sailors SET dob = '2012-01-01'::date WHERE id = '721c5d6e-3856-460c-a862-304afaeb099d'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2012 WHERE sailor_id = '721c5d6e-3856-460c-a862-304afaeb099d'::uuid AND birth_year IS NULL;

-- Leigh Harvie (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (2023 Eastern Seaboard Regatta at Royal Varuna Yacht Club), Matched: Leigh Harvie, YOB: 2009)
UPDATE public.sailors SET dob = '2009-01-01'::date WHERE id = '75a13a0e-836b-54f8-93b7-9b7d7fb8ced9'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2009 WHERE sailor_id = '75a13a0e-836b-54f8-93b7-9b7d7fb8ced9'::uuid AND birth_year IS NULL;

-- Lyla Greenwood (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: LYLA GREENWOOD, YOB: 2012)
UPDATE public.sailors SET dob = '2012-01-01'::date WHERE id = 'a1bac017-5467-45ce-9ddc-53c13bcf2852'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2012 WHERE sailor_id = 'a1bac017-5467-45ce-9ddc-53c13bcf2852'::uuid AND birth_year IS NULL;

-- Monte Morse (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: MONTE MORSE, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = '9e62a08a-2633-87a2-43f7-0ec2a0f7b83b'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = '9e62a08a-2633-87a2-43f7-0ec2a0f7b83b'::uuid AND birth_year IS NULL;

-- Orlando Ligovich (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (2023 Eastern Seaboard Regatta at Royal Varuna Yacht Club), Matched: Orlando Ligovich, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = '66256081-2c19-49d9-af18-cfafad5d109f'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = '66256081-2c19-49d9-af18-cfafad5d109f'::uuid AND birth_year IS NULL;

-- Reid Martin (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: REID MARTIN, YOB: 2013)
UPDATE public.sailors SET dob = '2013-01-01'::date WHERE id = 'fe55751a-320e-48f8-92fd-fd40bca74292'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2013 WHERE sailor_id = 'fe55751a-320e-48f8-92fd-fd40bca74292'::uuid AND birth_year IS NULL;

-- Samuel Darbyshire (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: SAM DARBYSHIRE, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = '078bc565-17ae-461c-a08d-1330f11517a8'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = '078bc565-17ae-461c-a08d-1330f11517a8'::uuid AND birth_year IS NULL;

-- Sebastian Cheng (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (2023 Eastern Seaboard Regatta at Royal Varuna Yacht Club), Matched: Sebastian Cheng, YOB: 2012)
UPDATE public.sailors SET dob = '2012-01-01'::date WHERE id = 'e2a4b0c4-c2cc-4a03-b198-6378b590fc0b'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2012 WHERE sailor_id = 'e2a4b0c4-c2cc-4a03-b198-6378b590fc0b'::uuid AND birth_year IS NULL;

-- Tate Cantwell (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: TATE CANTWELL, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = 'd710b7c6-5d97-462d-8a9b-ae37b0379f46'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = 'd710b7c6-5d97-462d-8a9b-ae37b0379f46'::uuid AND birth_year IS NULL;

-- Titouan CHRISTODOULOU-LE GAC (AUS) (Source: Sail-Result / YRAT / RVYC Regattas (2023 Eastern Seaboard Regatta at Royal Varuna Yacht Club), Matched: Titouan Christodoulou-Le Gac, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = 'd7286bf7-53f8-519c-b5ce-6032e0d33f11'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = 'd7286bf7-53f8-519c-b5ce-6032e0d33f11'::uuid AND birth_year IS NULL;

-- Junhe Wang (CHN) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: WANG JUNHE, YOB: 2009)
UPDATE public.sailors SET dob = '2009-01-01'::date WHERE id = 'dd154de0-0ba0-5fd2-b92c-369de28b858d'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2009 WHERE sailor_id = 'dd154de0-0ba0-5fd2-b92c-369de28b858d'::uuid AND birth_year IS NULL;

-- Shi Lin (CHN) (Source: Sail-Result / YRAT / RVYC Regattas (Admiral's Cup 2023 at Royal Varuna Yacht Club), Matched: Lin Shi, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = '0c191e7f-5725-41a0-b1c8-dcf4177b0cd5'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = '0c191e7f-5725-41a0-b1c8-dcf4177b0cd5'::uuid AND birth_year IS NULL;

-- Ya Zhang (CHN) (Source: Sail-Result / YRAT / RVYC Regattas (ACDC Cup International Championship 2025), Matched: YA ZHANG, YOB: 2014)
UPDATE public.sailors SET dob = '2014-01-01'::date WHERE id = '51a8b92d-74d1-52a1-bf87-4328eb92040c'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2014 WHERE sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c'::uuid AND birth_year IS NULL;

-- Yangzi Tang (CHN) (Source: Sail-Result / YRAT / RVYC Regattas (2024 Admiral's Cup at Royal Varuna Yacht Club), Matched: Yangzi Tang, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = '67c37232-0076-5dd1-a815-408b375a6318'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = '67c37232-0076-5dd1-a815-408b375a6318'::uuid AND birth_year IS NULL;

-- Alix Nguyen-Minh (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (2023 Eastern Seaboard Regatta at Royal Varuna Yacht Club), Matched: Alix Nguyen-Minh, YOB: 2014)
UPDATE public.sailors SET dob = '2014-01-01'::date WHERE id = '6eacd878-8c53-4133-93fa-898d196bdf18'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2014 WHERE sailor_id = '6eacd878-8c53-4133-93fa-898d196bdf18'::uuid AND birth_year IS NULL;

-- Dani Pieter Mahmoud van Olphen (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (ILCA District Championships 2026), Matched: DANI PIETER MAHMOUD VAN OLPHEN, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'::uuid AND birth_year IS NULL;

-- Ivy So (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: IVY SO, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = '34454af4-f43d-45d4-aea1-01ff9c354cb9'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = '34454af4-f43d-45d4-aea1-01ff9c354cb9'::uuid AND birth_year IS NULL;

-- Jarvis Wong (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (ILCA District Championships 2026), Matched: JARVIS WONG, YOB: 2012)
UPDATE public.sailors SET dob = '2012-01-01'::date WHERE id = 'da4dd4ce-6510-59bb-9613-59f8ab461e47'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2012 WHERE sailor_id = 'da4dd4ce-6510-59bb-9613-59f8ab461e47'::uuid AND birth_year IS NULL;

-- Jorge Wong (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: JORGE WONG, YOB: 2008)
UPDATE public.sailors SET dob = '2008-01-01'::date WHERE id = '38110f5a-aea4-45eb-90f8-3909e0445794'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2008 WHERE sailor_id = '38110f5a-aea4-45eb-90f8-3909e0445794'::uuid AND birth_year IS NULL;

-- Kai Storey (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (Admiral's Cup 2023 at Royal Varuna Yacht Club), Matched: Kai Storey, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = '501d0faa-3edc-4c25-84c6-1681e7f36e48'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48'::uuid AND birth_year IS NULL;

-- Leanna Lee (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (2024 Pattaya International Championship), Matched: Leanna Lee, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = 'bc65ccb8-4c2f-5524-aa50-f350a82b9508'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = 'bc65ccb8-4c2f-5524-aa50-f350a82b9508'::uuid AND birth_year IS NULL;

-- Lucien Cohen-Addad (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (2023 Eastern Seaboard Regatta at Royal Varuna Yacht Club), Matched: Lucien Cohen-Addad, YOB: 2012)
UPDATE public.sailors SET dob = '2012-01-01'::date WHERE id = 'ce7e5859-af89-452a-9d74-7855e9d30bc1'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2012 WHERE sailor_id = 'ce7e5859-af89-452a-9d74-7855e9d30bc1'::uuid AND birth_year IS NULL;

-- Marcus Li (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (Admiral's Cup 2023 at Royal Varuna Yacht Club), Matched: Marcus Li, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = '35ddaae9-11d3-457f-ba18-2c96e6df5aac'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = '35ddaae9-11d3-457f-ba18-2c96e6df5aac'::uuid AND birth_year IS NULL;

-- Penelope Wilde (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (Admiral's Cup 2023 at Royal Varuna Yacht Club), Matched: Penelepe Wilde, YOB: 2012)
UPDATE public.sailors SET dob = '2012-01-01'::date WHERE id = 'ba833ded-4802-5349-8bff-f61007f74c32'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2012 WHERE sailor_id = 'ba833ded-4802-5349-8bff-f61007f74c32'::uuid AND birth_year IS NULL;

-- Roman Choi (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (2024 Pattaya International Championship), Matched: Roman Choi, YOB: 2014)
UPDATE public.sailors SET dob = '2014-01-01'::date WHERE id = '1a742ce4-6e3a-5082-a59a-d45c0edd9396'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2014 WHERE sailor_id = '1a742ce4-6e3a-5082-a59a-d45c0edd9396'::uuid AND birth_year IS NULL;

-- Ryley Man (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (ILCA District Championships 2026), Matched: RYLEY MAN, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = 'a88f1f81-4234-420e-aec3-9d530b783645'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = 'a88f1f81-4234-420e-aec3-9d530b783645'::uuid AND birth_year IS NULL;

-- Thomas Yong Jin Ko (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (2023 Eastern Seaboard Regatta at Royal Varuna Yacht Club), Matched: Thomas Yong Jin KO, YOB: 2009)
UPDATE public.sailors SET dob = '2009-01-01'::date WHERE id = '298e864e-f79f-4e91-9caf-4a8c980f9282'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2009 WHERE sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'::uuid AND birth_year IS NULL;

-- Wong Tsz Lung (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (2023 Eastern Seaboard Regatta at Royal Varuna Yacht Club), Matched: Tsz Lung WONG, YOB: 2008)
UPDATE public.sailors SET dob = '2008-01-01'::date WHERE id = '721432e7-e9dd-4606-bc9e-6db6390b2d3c'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2008 WHERE sailor_id = '721432e7-e9dd-4606-bc9e-6db6390b2d3c'::uuid AND birth_year IS NULL;

-- Xavier Lam (HKG) (Source: Sail-Result / YRAT / RVYC Regattas (2024 Pattaya International Championship), Matched: Xavier Lam, YOB: 2014)
UPDATE public.sailors SET dob = '2014-01-01'::date WHERE id = '51deb95b-c78a-5286-b715-0cc47634fd81'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2014 WHERE sailor_id = '51deb95b-c78a-5286-b715-0cc47634fd81'::uuid AND birth_year IS NULL;

-- Sae Hatanaka (JPN) (Source: Sail-Result / YRAT / RVYC Regattas (2023 Eastern Seaboard Regatta at Royal Varuna Yacht Club), Matched: Sae Hatanaka, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = 'b8328e6c-2b4f-4898-980d-b8dbd587bd0d'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = 'b8328e6c-2b4f-4898-980d-b8dbd587bd0d'::uuid AND birth_year IS NULL;

-- Hajin Shim (KOR) (Source: Sail-Result / YRAT / RVYC Regattas (2024 ILCA Thailand National Championship at Royal Varuna Yacht Club), Matched: Shim Hajin, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = '12c20a73-79f0-561c-8805-c6fe4afebbe2'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = '12c20a73-79f0-561c-8805-c6fe4afebbe2'::uuid AND birth_year IS NULL;

-- Jun Han (KOR) (Source: Sail-Result / YRAT / RVYC Regattas (2024 ILCA Thailand National Championship at Royal Varuna Yacht Club), Matched: Han Jun, YOB: 2008)
UPDATE public.sailors SET dob = '2008-01-01'::date WHERE id = '5264ce32-f38f-507a-8d4b-e4757f4b2e64'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2008 WHERE sailor_id = '5264ce32-f38f-507a-8d4b-e4757f4b2e64'::uuid AND birth_year IS NULL;

-- Wonjeong Lee (KOR) (Source: Sail-Result / YRAT / RVYC Regattas (2024 ILCA Thailand National Championship at Royal Varuna Yacht Club), Matched: Lee Wonjeong, YOB: 2004)
UPDATE public.sailors SET dob = '2004-01-01'::date WHERE id = 'c78219ad-ecf3-529a-9e11-8be4f10a8c22'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2004 WHERE sailor_id = 'c78219ad-ecf3-529a-9e11-8be4f10a8c22'::uuid AND birth_year IS NULL;

-- Yim Woojun (KOR) (Source: Sail-Result / YRAT / RVYC Regattas (2024 ILCA Thailand National Championship at Royal Varuna Yacht Club), Matched: Yim Woojun, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = 'd5950089-a98b-528b-83d6-3582f48dacb9'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = 'd5950089-a98b-528b-83d6-3582f48dacb9'::uuid AND birth_year IS NULL;

-- Alif Nur Bin Amzi (MAS) (Source: Sail-Result / YRAT / RVYC Regattas (2024 Thailand National Sailing Championship), Matched: Alif Nur Bin Amzi, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = '95b20b9e-fe72-5617-ba01-e55da0c048f8'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = '95b20b9e-fe72-5617-ba01-e55da0c048f8'::uuid AND birth_year IS NULL;

-- Danyal Marczqui Rahmat Haron Muzaffar (MAS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: DANYAL MARCZQUI RAHMAT HARON MUZAFFAR, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = '9ab6cba2-69ff-5905-b4c5-cb4dcd8e6ade'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = '9ab6cba2-69ff-5905-b4c5-cb4dcd8e6ade'::uuid AND birth_year IS NULL;

-- Kee Aleana Binti Abdullah (MAS) (Source: Sail-Result / YRAT / RVYC Regattas (2024 Thailand National Sailing Championship), Matched: Kee Aleana Binti Abdullah, YOB: 2009)
UPDATE public.sailors SET dob = '2009-01-01'::date WHERE id = 'bae687b7-5919-4db4-8361-c53df73c6503'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2009 WHERE sailor_id = 'bae687b7-5919-4db4-8361-c53df73c6503'::uuid AND birth_year IS NULL;

-- Nur Aina Binti Norhazram (MAS) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: NUR AINA BINTI NORHAZRAM, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = '00e9f759-95f1-4633-88db-b07d7933d248'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248'::uuid AND birth_year IS NULL;

-- Nur Hafizahanani Binti Zailan (MAS) (Source: Sail-Result / YRAT / RVYC Regattas (ACDC Cup International Sailing Championship 2026), Matched: NUR HAFIZAHANANI BINTI ZAILAN, YOB: 2008)
UPDATE public.sailors SET dob = '2008-01-01'::date WHERE id = '0285e1be-3c9f-5d9e-a21a-21f995a09436'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2008 WHERE sailor_id = '0285e1be-3c9f-5d9e-a21a-21f995a09436'::uuid AND birth_year IS NULL;

-- Hein Thant Saw (MYA) (Source: Sail-Result / YRAT / RVYC Regattas (ACDC Cup International Sailing Championship 2026), Matched: HEIN THANT SAW, YOB: 2014)
UPDATE public.sailors SET dob = '2014-01-01'::date WHERE id = 'e2bcc321-4cd5-5926-80ac-fea76a8f2170'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2014 WHERE sailor_id = 'e2bcc321-4cd5-5926-80ac-fea76a8f2170'::uuid AND birth_year IS NULL;

-- Htet Lin Zaw (MYA) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: HTET LIN ZAW, YOB: 2006)
UPDATE public.sailors SET dob = '2006-01-01'::date WHERE id = '5acb538c-6b7b-5ba7-8cb8-2aad97d20816'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2006 WHERE sailor_id = '5acb538c-6b7b-5ba7-8cb8-2aad97d20816'::uuid AND birth_year IS NULL;

-- Lin Khant Kyaw @William (MYA) (Source: Sail-Result / YRAT / RVYC Regattas (2024 Admiral's Cup at Royal Varuna Yacht Club), Matched: Lin Khant Kyaw, YOB: 2009)
UPDATE public.sailors SET dob = '2009-01-01'::date WHERE id = 'ce7ef22b-a1b0-4e50-8a7e-7e2342e2b252'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2009 WHERE sailor_id = 'ce7ef22b-a1b0-4e50-8a7e-7e2342e2b252'::uuid AND birth_year IS NULL;

-- Thein Thurain Myint (MYA) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: THEIN THURAIN MYINT, YOB: 2012)
UPDATE public.sailors SET dob = '2012-01-01'::date WHERE id = '5d1cab86-4cd9-41da-875e-ffe63608a3dd'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2012 WHERE sailor_id = '5d1cab86-4cd9-41da-875e-ffe63608a3dd'::uuid AND birth_year IS NULL;

-- Aidan Ang (SGP) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: AIDAN ANG, YOB: 2006)
UPDATE public.sailors SET dob = '2006-01-01'::date WHERE id = '15b0cffc-69a1-4ee5-956b-f2d0b859acf2'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2006 WHERE sailor_id = '15b0cffc-69a1-4ee5-956b-f2d0b859acf2'::uuid AND birth_year IS NULL;

-- Hayley Fang (SGP) (Source: Sail-Result / YRAT / RVYC Regattas (2022 Admiral's Cup at Royal Varuna Yacht Club), Matched: Fang Si Wei Hayley, YOB: 2007)
UPDATE public.sailors SET dob = '2007-01-01'::date WHERE id = '61cd2cae-f8ba-48bc-9b3f-ace4c5d4878a'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2007 WHERE sailor_id = '61cd2cae-f8ba-48bc-9b3f-ace4c5d4878a'::uuid AND birth_year IS NULL;

-- Magdalene Cheong (SGP) (Source: Sail-Result / YRAT / RVYC Regattas (ILCA District Championships at Royal Varuna Yacht Club), Matched: TING RUI MAGDALENE CHEONG, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = 'eda0daf0-7469-4a87-9015-3abaf54c5f6e'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = 'eda0daf0-7469-4a87-9015-3abaf54c5f6e'::uuid AND birth_year IS NULL;

-- Tham Wan Yew Amos (SGP) (Source: Sail-Result / YRAT / RVYC Regattas (Admiral's Cup 2023 at Royal Varuna Yacht Club), Matched: Amos Tham, YOB: 2008)
UPDATE public.sailors SET dob = '2008-01-01'::date WHERE id = '18019333-0cf7-413e-bd9c-5d1845f124fc'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2008 WHERE sailor_id = '18019333-0cf7-413e-bd9c-5d1845f124fc'::uuid AND birth_year IS NULL;

-- Tong Xuan Yu (SGP) (Source: Sail-Result / YRAT / RVYC Regattas (2023 Eastern Seaboard Regatta at Royal Varuna Yacht Club), Matched: Xuan Yu Tong, YOB: 2009)
UPDATE public.sailors SET dob = '2009-01-01'::date WHERE id = '9a5b0de5-c0cb-5add-a0cb-01ee97240113'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2009 WHERE sailor_id = '9a5b0de5-c0cb-5add-a0cb-01ee97240113'::uuid AND birth_year IS NULL;

-- Yap Swee Dean (SGP) (Source: Sail-Result / YRAT / RVYC Regattas (Admiral's Cup 2023 at Royal Varuna Yacht Club), Matched: Yap Swee Dean, YOB: 2008)
UPDATE public.sailors SET dob = '2008-01-01'::date WHERE id = 'abeecd7a-f571-4dfb-a1b7-fe9ccf19da18'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2008 WHERE sailor_id = 'abeecd7a-f571-4dfb-a1b7-fe9ccf19da18'::uuid AND birth_year IS NULL;

-- Aran Klangmueang (THA) (Source: Sail-Result / YRAT / RVYC Regattas (Children's Day Regatta 2025), Matched: ARAN KLANGMUEANG, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = '07bf0465-389d-5487-b6f7-b248a3cb859b'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = '07bf0465-389d-5487-b6f7-b248a3cb859b'::uuid AND birth_year IS NULL;

-- Atthakit Thuaythong (THA) (Source: Sail-Result / YRAT / RVYC Regattas (1st Summer Regatta 2024 at Royal Varuna Yacht Club), Matched: Atthakit Thuaythong, YOB: 2009)
UPDATE public.sailors SET dob = '2009-01-01'::date WHERE id = '6333c43d-c279-5dcd-bc41-3f247a3afbc9'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2009 WHERE sailor_id = '6333c43d-c279-5dcd-bc41-3f247a3afbc9'::uuid AND birth_year IS NULL;

-- Chatree Makmul (THA) (Source: Sail-Result / YRAT / RVYC Regattas (36th PHUKET KING'S CUP REGATTA), Matched: CHATREE MAKMUL, YOB: 2005)
UPDATE public.sailors SET dob = '2005-01-01'::date WHERE id = '14f321f7-ea6e-55fa-9682-84f34237b940'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2005 WHERE sailor_id = '14f321f7-ea6e-55fa-9682-84f34237b940'::uuid AND birth_year IS NULL;

-- Chayada Hasap (THA) (Source: Sail-Result / YRAT / RVYC Regattas (36th PHUKET KING'S CUP REGATTA), Matched: CHAYADA HASAP, YOB: 2009)
UPDATE public.sailors SET dob = '2009-01-01'::date WHERE id = '574a32ca-dfb7-53cb-9ba0-f7f17ad56287'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2009 WHERE sailor_id = '574a32ca-dfb7-53cb-9ba0-f7f17ad56287'::uuid AND birth_year IS NULL;

-- Donaya Hasap (THA) (Source: Sail-Result / YRAT / RVYC Regattas (35th Phuket King's Cup Regatta 2023), Matched: Donaya Hasap, YOB: 2007)
UPDATE public.sailors SET dob = '2007-01-01'::date WHERE id = 'bea27cca-215b-5600-b9ca-14951702cb89'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2007 WHERE sailor_id = 'bea27cca-215b-5600-b9ca-14951702cb89'::uuid AND birth_year IS NULL;

-- Marcel Dubbelman (THA) (Source: Sail-Result / YRAT / RVYC Regattas (ILCA District Championships at Royal Varuna Yacht Club), Matched: MARCEL DUBBELMAN, YOB: 1952)
UPDATE public.sailors SET dob = '1952-01-01'::date WHERE id = '37674867-aab3-5549-9ca5-9d61aaf18e1d'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 1952 WHERE sailor_id = '37674867-aab3-5549-9ca5-9d61aaf18e1d'::uuid AND birth_year IS NULL;

-- Nathakorn Jitsuwan (THA) (Source: Sail-Result / YRAT / RVYC Regattas (ACDC Sailing International Championship 2024), Matched: NATHAKORN JITSUWAN, YOB: 2010)
UPDATE public.sailors SET dob = '2010-01-01'::date WHERE id = 'adc02a10-6d7e-4ab3-b4c6-19b62b7bfad0'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2010 WHERE sailor_id = 'adc02a10-6d7e-4ab3-b4c6-19b62b7bfad0'::uuid AND birth_year IS NULL;

-- Natthawut Intharawichai (THA) (Source: Sail-Result / YRAT / RVYC Regattas (2024 Thailand National Sailing Championship), Matched: Natthawut Intharawichai, YOB: 2005)
UPDATE public.sailors SET dob = '2005-01-01'::date WHERE id = 'f296677d-7595-5c0b-b317-9737fd83fb9d'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2005 WHERE sailor_id = 'f296677d-7595-5c0b-b317-9737fd83fb9d'::uuid AND birth_year IS NULL;

-- Nuttapat Arttapiyapun (THA) (Source: Sail-Result / YRAT / RVYC Regattas (ACDC Cup International Championship 2025), Matched: NUTTAPAT ARTTAPIYAPUN, YOB: 2015)
UPDATE public.sailors SET dob = '2015-01-01'::date WHERE id = '729acda4-25b3-57df-b11c-2f31f9d45e52'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2015 WHERE sailor_id = '729acda4-25b3-57df-b11c-2f31f9d45e52'::uuid AND birth_year IS NULL;

-- Pitipoom Jaroenpon (THA) (Source: Sail-Result / YRAT / RVYC Regattas (2024 ILCA Thailand National Championship at Royal Varuna Yacht Club), Matched: Pitipoom Jaroenpon, YOB: 2008)
UPDATE public.sailors SET dob = '2008-01-01'::date WHERE id = 'd1624d92-8fde-5d56-9acb-69df6f18cb75'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2008 WHERE sailor_id = 'd1624d92-8fde-5d56-9acb-69df6f18cb75'::uuid AND birth_year IS NULL;

-- Worrakan Saksriklom (THA) (Source: Sail-Result / YRAT / RVYC Regattas (Eastern Seaboard Championship at Royal Varuna Yacht Club), Matched: WORRAKAN SAKSRIKLOM, YOB: 2012)
UPDATE public.sailors SET dob = '2012-01-01'::date WHERE id = 'b1252473-a364-5f83-851b-8d9740d7e233'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2012 WHERE sailor_id = 'b1252473-a364-5f83-851b-8d9740d7e233'::uuid AND birth_year IS NULL;

-- Hsuanchen Chien (TPE) (Source: Sail-Result / YRAT / RVYC Regattas (2024 Thailand National Sailing Championship), Matched: Hsuanchen Chien, YOB: 2007)
UPDATE public.sailors SET dob = '2007-01-01'::date WHERE id = 'f4cc8bb9-c008-574e-aa09-b07c58607a12'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2007 WHERE sailor_id = 'f4cc8bb9-c008-574e-aa09-b07c58607a12'::uuid AND birth_year IS NULL;

-- Kuan-Ying Lin (TPE) (Source: Sail-Result / YRAT / RVYC Regattas (2024 ILCA Thailand National Championship at Royal Varuna Yacht Club), Matched: Kuan Ying Lin, YOB: 2006)
UPDATE public.sailors SET dob = '2006-01-01'::date WHERE id = '0e172325-9574-5be1-8f0a-962445b55a23'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2006 WHERE sailor_id = '0e172325-9574-5be1-8f0a-962445b55a23'::uuid AND birth_year IS NULL;

-- Tsai-Tien Chien (TPE) (Source: Sail-Result / YRAT / RVYC Regattas (2024 ILCA Thailand National Championship at Royal Varuna Yacht Club), Matched: Tsai Tien Chien, YOB: 2005)
UPDATE public.sailors SET dob = '2005-01-01'::date WHERE id = 'bf078d94-b180-5e38-a378-b8ce8a09e797'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2005 WHERE sailor_id = 'bf078d94-b180-5e38-a378-b8ce8a09e797'::uuid AND birth_year IS NULL;

-- Yen-Chen Wang (TPE) (Source: Sail-Result / YRAT / RVYC Regattas (2024 Admiral's Cup at Royal Varuna Yacht Club), Matched: Wang Yen-Chen, YOB: 2011)
UPDATE public.sailors SET dob = '2011-01-01'::date WHERE id = 'b393c33b-604a-44a2-a38f-8007c7c7864c'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2011 WHERE sailor_id = 'b393c33b-604a-44a2-a38f-8007c7c7864c'::uuid AND birth_year IS NULL;

-- Yong Liang Chuang (TPE) (Source: Sail-Result / YRAT / RVYC Regattas (36th PHUKET KING'S CUP REGATTA), Matched: YONG LIANG CHUANG, YOB: 2008)
UPDATE public.sailors SET dob = '2008-01-01'::date WHERE id = '6bb8044b-6e37-4e15-84d2-605f5fecb2b7'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2008 WHERE sailor_id = '6bb8044b-6e37-4e15-84d2-605f5fecb2b7'::uuid AND birth_year IS NULL;

-- Yuan-Chun Lin (TPE) (Source: Sail-Result / YRAT / RVYC Regattas (2024 ILCA Thailand National Championship at Royal Varuna Yacht Club), Matched: Yuan Chun Lin, YOB: 2005)
UPDATE public.sailors SET dob = '2005-01-01'::date WHERE id = '1061c4af-d39b-52d8-93e5-0290b773acf9'::uuid AND dob IS NULL;
UPDATE public.regatta_results SET birth_year = 2005 WHERE sailor_id = '1061c4af-d39b-52d8-93e5-0290b773acf9'::uuid AND birth_year IS NULL;

COMMIT;
