-- Migration: Backfill sailor dates of birth (Batch 12: Diacritic normalization and extended compound variants from World Sailing)
-- Strict non-overwriting: only updates records where dob IS NULL.
BEGIN;

-- Nicolas Sixto (ARG) matched variant 'Nicolas Sixto' -> Nicolás Sixto [ARGNS11]
UPDATE public.sailors SET dob = '2008-02-26' WHERE id = '4bc621e4-f8f1-5e73-8868-a9a59984907c'::uuid AND dob IS NULL;

-- Vinicio Vila (ARG) matched variant 'Vinicio Vila' -> Vinicio Vilá [ARGVV8]
UPDATE public.sailors SET dob = '2011-01-09' WHERE id = '60f833cb-5458-5297-bc95-b43cb3023a03'::uuid AND dob IS NULL;

-- Mia Catalina De Bernardis (ARG) matched variant 'Mia De Bernardis' -> Mía De Bernardis [ARGMD20]
UPDATE public.sailors SET dob = '2010-09-10' WHERE id = 'babe0530-20a6-5659-a12c-cd0f87a688f8'::uuid AND dob IS NULL;

-- Luis Bohm (AUT) matched variant 'Luis Bohm' -> Luis Böhm [AUTLB12]
UPDATE public.sailors SET dob = '2004-01-13' WHERE id = 'bf5cedec-4ec4-55fe-8f4c-9bccddeeefee'::uuid AND dob IS NULL;

-- João Lucena (BRA) matched variant 'João Lucena' -> Joao Lucena [BRAJL25]
UPDATE public.sailors SET dob = '2012-09-17' WHERE id = 'a7feb49f-cb12-5475-be67-fce7a9c52b4f'::uuid AND dob IS NULL;

-- Dorota Graczova (CZE) matched variant 'Dorota Graczova' -> Dorota Gráczová [CZEDG2]
UPDATE public.sailors SET dob = '2011-05-09' WHERE id = 'c30c21f4-122e-5bee-8073-f49a7008a8f2'::uuid AND dob IS NULL;

-- Ela Berntova (CZE) matched variant 'Ela Berntova' -> Ela Berntová [CZEEB3]
UPDATE public.sailors SET dob = '2011-06-28' WHERE id = '42848b82-7e21-571e-a62c-f6c1e74352d3'::uuid AND dob IS NULL;

-- Hynek Zakoucky (CZE) matched variant 'Hynek Zakoucky' -> Hynek Zákoucký [CZEHZ1]
UPDATE public.sailors SET dob = '2011-12-05' WHERE id = '9ae1fda8-894e-5d80-8e6b-86a7c7a2c2fc'::uuid AND dob IS NULL;

-- Katerina Tomolova (CZE) matched variant 'Katerina Tomolova' -> Kateřina Tomolová [CZEKT1]
UPDATE public.sailors SET dob = '2012-04-14' WHERE id = 'd46f792a-9340-5429-8065-9a9a3ae3a368'::uuid AND dob IS NULL;

-- Sofia Vaclavkova (CZE) matched variant 'Sofia Vaclavkova' -> Sofia Václavková [CZESV1]
UPDATE public.sailors SET dob = '2009-08-23' WHERE id = '47748721-d285-5316-be3d-25acd499097f'::uuid AND dob IS NULL;

-- Ivan Saez (ESP) matched variant 'Ivan Saez' -> Iván Sáez [ESPIS29]
UPDATE public.sailors SET dob = '2012-02-17' WHERE id = '70e2c965-b18e-5b94-a708-14b518f3ee98'::uuid AND dob IS NULL;

-- Miquel Pericas Perez (ESP) matched variant 'Miquel Pericas Perez' -> Miquel Pericás Pérez [ESPMP108]
UPDATE public.sailors SET dob = '2013-09-15' WHERE id = 'e9f2c195-47b2-50a6-a87d-69e4bb901d23'::uuid AND dob IS NULL;

-- Neus Pericas Perez (ESP) matched variant 'Neus Pericas Perez' -> Neus Pericás Pérez [ESPNP10]
UPDATE public.sailors SET dob = '2011-06-25' WHERE id = '2f6ae528-716d-5c06-a2bb-9e037a8e6093'::uuid AND dob IS NULL;

-- Gustav Poschke (GER) matched variant 'Gustav Poschke' -> Gustav Pöschke [GERGP14]
UPDATE public.sailors SET dob = '2010-01-31' WHERE id = 'b04f743f-9e30-5630-858b-09e10c033cc4'::uuid AND dob IS NULL;

-- Leo Maximilian Mügge (GER) matched variant 'Leo Mügge' -> Leo Mügge [GERLM50]
UPDATE public.sailors SET dob = '2014-06-15' WHERE id = '981d12a4-46b6-5343-a18a-4858e3c6a03b'::uuid AND dob IS NULL;

-- Botond Virag (HUN) matched variant 'Botond Virag' -> Botond Virág [HUNBV7]
UPDATE public.sailors SET dob = '2010-07-14' WHERE id = '199b7e4d-7603-5b91-8ab9-92360e611d69'::uuid AND dob IS NULL;

-- Mark Lacko (HUN) matched variant 'Mark Lacko' -> Márk Lackó [HUNML2]
UPDATE public.sailors SET dob = '2012-02-08' WHERE id = '4b98b449-44eb-5ed5-9480-df3484fa71a1'::uuid AND dob IS NULL;

-- M K Pragathi (IND) matched variant 'M Pragathi' -> M Pragathi [INDMP5]
UPDATE public.sailors SET dob = '2010-10-13' WHERE id = '378ddb93-2062-544c-ab39-a23ddebc9f86'::uuid AND dob IS NULL;

-- Thaneesha J (IND) matched variant 'Thaneesha J' -> Thaneesha J [INDTJ2]
UPDATE public.sailors SET dob = '2008-04-09' WHERE id = '46da83a6-e46b-5c98-992b-e493747f67d1'::uuid AND dob IS NULL;

-- Ruairí Slattery (IRL) matched variant 'Ruairí Slattery' -> Ruairi Slattery [IRLRS32]
UPDATE public.sailors SET dob = '2012-05-24' WHERE id = 'e6dfa586-3016-5416-b4a8-37bf54bb091a'::uuid AND dob IS NULL;

-- 宇留野 遥斗 (JPN) matched variant '遥斗 宇留野' -> 遥斗 宇留野 [JPN遥宇1]
UPDATE public.sailors SET dob = '2009-10-28' WHERE id = '17808d6a-0599-592b-a66f-7e33cb3acda5'::uuid AND dob IS NULL;

-- 舩澤 夏子 (JPN) matched variant '夏子 舩澤' -> 夏子 舩澤 [JPN夏舩1]
UPDATE public.sailors SET dob = '2010-09-07' WHERE id = '96dac3a2-4d7f-53b0-af17-808c44056f3d'::uuid AND dob IS NULL;

-- Conis Lacis (LAT) matched variant 'Conis Lacis' -> Čonis Lācis [LATČL1]
UPDATE public.sailors SET dob = '2012-02-26' WHERE id = 'ffb3aad8-4238-5198-87da-4c5d380c0fcf'::uuid AND dob IS NULL;

-- Balsa Banicevic (MNE) matched variant 'Balsa Banicevic' -> Balša Banićević [MNEBB1]
UPDATE public.sailors SET dob = '2012-07-10' WHERE id = '57542518-d33e-5ff0-81e3-119ecd8cf03b'::uuid AND dob IS NULL;

-- Helena Vukasovic (MNE) matched variant 'Helena Vukasovic' -> Helena Vukasović [MNEHV1]
UPDATE public.sailors SET dob = '2013-09-22' WHERE id = '963053ec-a31b-5f90-a040-b9a51a53ba46'::uuid AND dob IS NULL;

-- Nikola Matijevic (MNE) matched variant 'Nikola Matijevic' -> Nikola Matijević [MNENM1]
UPDATE public.sailors SET dob = '2014-09-25' WHERE id = '5634ebf6-b037-5367-910d-cba46f531a98'::uuid AND dob IS NULL;

-- Fran Samuel Mejarito (PHI) matched variant 'Fran Mejarito' -> Fran Mejarito [PHIFM2]
UPDATE public.sailors SET dob = '2010-12-09' WHERE id = '40dd5b66-d007-42f6-ba79-88ae35d1e060'::uuid AND dob IS NULL;

-- Szymon Cieslak (POL) matched variant 'Szymon Cieslak' -> Szymon Cieślak [POLSC10]
UPDATE public.sailors SET dob = '2007-08-01' WHERE id = 'f6efda0d-7a21-56bc-bc99-df20350bd44c'::uuid AND dob IS NULL;

-- Lan Cernac Skofic (SLO) matched variant 'Lan Skofic' -> Lan Škofič [SLOLŠ5]
UPDATE public.sailors SET dob = '2011-11-12' WHERE id = '8929c627-83ed-5a9e-8629-ca352eacb4ff'::uuid AND dob IS NULL;

-- Mateja Radovanovic (SRB) matched variant 'Mateja Radovanovic' -> Mateja Radovanović [SRBMR2]
UPDATE public.sailors SET dob = '2013-06-21' WHERE id = '542c064e-643b-5b8a-a92b-31db78e23af2'::uuid AND dob IS NULL;

-- Oliver Björkman (SWE) matched variant 'Oliver Björkman' -> Oliver Bjorkman [SWEOB15]
UPDATE public.sailors SET dob = '2011-04-21' WHERE id = '67217416-8f04-59aa-b2b0-aa13ef6463e9'::uuid AND dob IS NULL;

-- Alp Gencalp (TUR) matched variant 'Alp Gencalp' -> Alp Gençalp [TURAG26]
UPDATE public.sailors SET dob = '2013-11-03' WHERE id = '0f574e06-fb50-5581-b400-92155ecfb730'::uuid AND dob IS NULL;

-- Derin Değişen (TUR) matched variant 'Derin Değişen' -> Derin Degisen [TURDD20]
UPDATE public.sailors SET dob = '2009-09-28' WHERE id = '49c1d070-6df1-473d-becb-db56d6fda678'::uuid AND dob IS NULL;

-- Emir Tombuloğlu (TUR) matched variant 'Emir Tombuloğlu' -> Emir Tombuloglu [TURET13]
UPDATE public.sailors SET dob = '2013-03-21' WHERE id = '5627904a-7b8e-5415-bedc-1603543e2f8f'::uuid AND dob IS NULL;

-- Thanh Nhat Mai (VIE) matched variant 'Nhat Mai' -> Nhật Mai [VIENM1]
UPDATE public.sailors SET dob = '2010-05-09' WHERE id = 'b7076ceb-74cd-5fbc-b529-681c6842ebd1'::uuid AND dob IS NULL;

-- Synchronize regatta_results.birth_year with updated sailor DOBs
UPDATE public.regatta_results rr
SET birth_year = EXTRACT(YEAR FROM s.dob)::integer
FROM public.sailors s
WHERE rr.sailor_id = s.id
  AND s.dob IS NOT NULL
  AND (rr.birth_year IS NULL OR rr.birth_year != EXTRACT(YEAR FROM s.dob)::integer);

COMMIT;