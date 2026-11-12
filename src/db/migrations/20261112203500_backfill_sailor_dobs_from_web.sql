-- Backfill verified sailor dates of birth from public regatta / federation records.
-- When only the birth year is published, store YYYY-01-01 (01-01-YYYY).
-- Only updates rows where dob IS NULL so existing verified dates are preserved.

BEGIN;

-- Full dates of birth (YAI / KVS official Indian sailor registration records)
UPDATE public.sailors SET dob = '2011-02-28'::date, updated_at = now()
WHERE id = 'd41014b8-67ad-4e56-9e87-55d51612d5a8'::uuid AND dob IS NULL; -- Preet Siwal (IND)

UPDATE public.sailors SET dob = '2011-03-21'::date, updated_at = now()
WHERE id = '65696312-8374-428b-85ef-e46dfbaafc40'::uuid AND dob IS NULL; -- Aastha Pandey (IND)

UPDATE public.sailors SET dob = '2010-05-21'::date, updated_at = now()
WHERE id = '448629c9-4150-4b57-a991-2721ad070d18'::uuid AND dob IS NULL; -- Mahi Verma (IND)

UPDATE public.sailors SET dob = '2012-11-04'::date, updated_at = now()
WHERE id = '4dadff72-b3fe-4c5e-9b30-fbb6a47b25f5'::uuid AND dob IS NULL; -- Vasu Chandrawanshi (IND)

UPDATE public.sailors SET dob = '2010-10-10'::date, updated_at = now()
WHERE id = 'c3964c71-ae91-4215-91e4-f035597ccf14'::uuid AND dob IS NULL; -- Tulsi Patle (IND)

-- Birth year only -> YYYY-01-01 (RacingRulesOfSailing / SingaporeSailing / Team Singapore / World Sailing Youth Worlds)
UPDATE public.sailors SET dob = '1974-01-01'::date, updated_at = now()
WHERE id = '4df864cc-cc08-4652-bf36-bc4ef32af4af'::uuid AND dob IS NULL; -- Rohit Behl (IND)

UPDATE public.sailors SET dob = '1977-01-01'::date, updated_at = now()
WHERE id = 'ae3ec2c5-c6a9-4fcc-accd-724745911540'::uuid AND dob IS NULL; -- Carlo Ravera (ITA)

UPDATE public.sailors SET dob = '1968-01-01'::date, updated_at = now()
WHERE id = '527be10b-7526-4347-b0de-e9fd0df403ec'::uuid AND dob IS NULL; -- Lucien Franciscus Henricus van Riel (NED)

UPDATE public.sailors SET dob = '2007-01-01'::date, updated_at = now()
WHERE id = '7baafbd0-cddb-4217-9727-a692f6902b79'::uuid AND dob IS NULL; -- Kenan Kee Zen Tan (SGP)

UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now()
WHERE id = 'd7ce117b-5c64-40ea-86bd-79a7a73bb833'::uuid AND dob IS NULL; -- Austin Yeo Jia Yu (SGP)

UPDATE public.sailors SET dob = '2006-01-01'::date, updated_at = now()
WHERE id = 'be779040-d45c-4052-b458-9c9e88803505'::uuid AND dob IS NULL; -- Keira Carlyle (SGP)

UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now()
WHERE id = '20af3d01-7d86-4111-bad1-0c2be026e039'::uuid AND dob IS NULL; -- Nia Mehry Zahedi (SGP)

UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now()
WHERE id = 'ee4ffc51-2ad1-46fd-85d1-0d100676840f'::uuid AND dob IS NULL; -- Gabi Oh (SGP)

UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now()
WHERE id = '8203869d-2432-48ee-bd3e-0c591aeb9fdb'::uuid AND dob IS NULL; -- Wong Kai Lun (SGP)

UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now()
WHERE id = '21872802-7a58-4994-98cf-cfd93066af10'::uuid AND dob IS NULL; -- Jayden Teo Yuan Zhe (SGP)

UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now()
WHERE id = '8065d18f-d94f-4961-b18f-d126676ce052'::uuid AND dob IS NULL; -- Darren Lai (SGP)

UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now()
WHERE id = '38a04183-810a-478f-bb9f-6bd63314415c'::uuid AND dob IS NULL; -- Foo Yuei Jit (SGP)

UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now()
WHERE id = '922e1135-5c83-45cc-81cd-69c7b5a5ee65'::uuid AND dob IS NULL; -- Eitan Oh (SGP)

UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now()
WHERE id = '92ab705e-c63e-4989-9f00-4777b1618076'::uuid AND dob IS NULL; -- Tiffany Teo Yuan Qi (SGP)

UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now()
WHERE id = 'bff8a281-7801-428a-934c-3dc80816585b'::uuid AND dob IS NULL; -- Lu Zixi (CHN)

UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now()
WHERE id = 'bae4dea7-4f56-45a2-87ce-8950627a8616'::uuid AND dob IS NULL; -- Asher-James Nair (SGP)

UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now()
WHERE id = '8ec46c01-1663-4341-9c77-40da9edfe4ce'::uuid AND dob IS NULL; -- Darius Low Xian Rui (SGP)

UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now()
WHERE id = 'dd2d0d83-4cb8-4ea5-bc90-59531d262be2'::uuid AND dob IS NULL; -- Jonathan Ho Jian Yi (SGP)

UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now()
WHERE id = 'd21f2d3d-429d-4482-b72b-136f4b845cbf'::uuid AND dob IS NULL; -- Josiah Tan Zhi En (SGP)

UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now()
WHERE id = '6057a852-a589-4ed9-b887-e96a2178a307'::uuid AND dob IS NULL; -- Arabelle En Xi Tan (SGP)

UPDATE public.sailors SET dob = '2007-01-01'::date, updated_at = now()
WHERE id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01'::uuid AND dob IS NULL; -- Elisha Lim Yu Ting (SGP)

UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now()
WHERE id = '17707e61-bf21-437e-a84e-6e8f90a212ca'::uuid AND dob IS NULL; -- Maia Kiran Lim Laurie (SGP)

UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now()
WHERE id = 'e973857f-189c-4730-9732-7222bd1e6ee7'::uuid AND dob IS NULL; -- Tan Li Ying Kayler (SGP)

UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now()
WHERE id = '61fea959-614c-4a68-abfd-1ff8305d6eba'::uuid AND dob IS NULL; -- Akhshaya Santoz (SGP)

COMMIT;
