--
-- Migration: 20261113110500_backfill_sailor_dobs_batch_9.sql
-- Purpose: Backfill verified dates of birth for 405 international and youth sailors
-- Sources: World Sailing Official Athlete Registry (matched via official WS IDs from ILCA 4 Youth World Championship result books) + Wikipedia Olympic biographies
--
BEGIN;

-- 1. Senior & Olympic Sailors (Wikipedia & World Sailing)
-- DongShuang Zhang (Wikipedia (Chinese Olympian, Laser Radial))
UPDATE public.sailors SET dob = '1989-12-13' WHERE id = '5c303689-5519-5f35-80d7-81475fe236cd'::uuid AND dob IS NULL;
-- Duko Bos (Wikipedia (Dutch Olympian, ILCA 7))
UPDATE public.sailors SET dob = '1995-04-22' WHERE id = '19d8aee4-1615-5b53-9cef-5014d05723df'::uuid AND dob IS NULL;
-- Emma Plasschaert (Wikipedia (Belgian World Champion / Olympian, ILCA 6))
UPDATE public.sailors SET dob = '1993-11-01' WHERE id = 'a9bdb50f-9032-56d7-a9cf-576926415498'::uuid AND dob IS NULL;
-- Finn Lynch (Wikipedia (Irish Olympian, ILCA 7))
UPDATE public.sailors SET dob = '1996-04-23' WHERE id = '1b86d843-127b-5105-84b5-60f02923264b'::uuid AND dob IS NULL;
-- Ines Gmati (Wikipedia (Tunisian Olympian, ILCA 6))
UPDATE public.sailors SET dob = '1997-04-05' WHERE id = '73a455e9-db92-4fb7-9926-c81c304804bd'::uuid AND dob IS NULL;
-- Misaki Tanaka (Wikipedia (Japanese Olympian, 49er FX))
UPDATE public.sailors SET dob = '1997-11-23' WHERE id = 'f2659406-cdbc-55fb-b6bb-760cd11e2d0e'::uuid AND dob IS NULL;

-- 2. ILCA 4 Youth World Championship Sailors (World Sailing Athlete Profiles via WS ID)
-- John James Dwyer (JPN) - WS ID: AUSJD94
UPDATE public.sailors SET dob = '2013-09-16' WHERE id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'::uuid AND dob IS NULL;
-- Leo Weber (GER) - WS ID: GERLW42
UPDATE public.sailors SET dob = '2011-11-11' WHERE id = '770102ac-189e-d61b-aabc-ebd3944d8174'::uuid AND dob IS NULL;
-- Bjørn Otto Lund-fjell (DEN) - WS ID: DENBL3
UPDATE public.sailors SET dob = '2012-03-26' WHERE id = '946228ae-0c01-5c88-0c57-cc84239d6a08'::uuid AND dob IS NULL;
-- Niklas Alexander Kremser (GER) - WS ID: GERNK39
UPDATE public.sailors SET dob = '2011-09-12' WHERE id = '1274a95f-27e8-108c-5c26-5e4f6b608fcb'::uuid AND dob IS NULL;
-- Frederik Eilertsen (DEN) - WS ID: DENFE2
UPDATE public.sailors SET dob = '2010-11-10' WHERE id = '78bd3880-3938-f1c7-5af0-240ff5858cc9'::uuid AND dob IS NULL;
-- Parker Lilly (USA) - WS ID: USAPL95
UPDATE public.sailors SET dob = '2011-01-25' WHERE id = '22ca7d12-ffda-36a2-55c6-e523ce640c49'::uuid AND dob IS NULL;
-- Giorgos Papavasileiou (MON) - WS ID: GREGP49
UPDATE public.sailors SET dob = '2013-01-05' WHERE id = '8ece753b-6d66-acf3-f6c0-f7b73cef8100'::uuid AND dob IS NULL;
-- Charles-Henry Bonne (BEL) - WS ID: BELCB9
UPDATE public.sailors SET dob = '2009-10-11' WHERE id = 'a382f62c-51ca-a306-af09-e9324b2cf055'::uuid AND dob IS NULL;
-- George Miller (CAN) - WS ID: CANGM38
UPDATE public.sailors SET dob = '2014-12-31' WHERE id = '07bc3a75-eba9-7afc-7469-a8ac4de36865'::uuid AND dob IS NULL;
-- Feike de Jong (NED) - WS ID: NEDFJ5
UPDATE public.sailors SET dob = '2009-04-02' WHERE id = 'aed56490-1921-5a11-283e-4fbcc02d74e6'::uuid AND dob IS NULL;
-- Adrien Scache (CAN) - WS ID: CANAS75
UPDATE public.sailors SET dob = '2010-11-24' WHERE id = '19a94dda-2699-73c0-be9c-848292f4a6a7'::uuid AND dob IS NULL;
-- Leo Gosling (SUI) - WS ID: SUILG18
UPDATE public.sailors SET dob = '2010-10-08' WHERE id = 'e47e2468-a471-05fc-46bd-5b591acd1a30'::uuid AND dob IS NULL;
-- Stefanos Samaras (GRE) - WS ID: GRESS22
UPDATE public.sailors SET dob = '2010-01-05' WHERE id = '2c1d6eef-b58d-2022-5dcd-8aaab195538b'::uuid AND dob IS NULL;
-- Pablo Munoz Montes (USA) - WS ID: USAPM201
UPDATE public.sailors SET dob = '2010-10-18' WHERE id = '1faf8bf7-7011-cc2f-0ab4-e670f7b19f5d'::uuid AND dob IS NULL;
-- Alexander Montagu (USA) - WS ID: USAAM247
UPDATE public.sailors SET dob = '2010-07-14' WHERE id = '3183ea00-6fb5-971b-392a-d1d6c91cb6e9'::uuid AND dob IS NULL;
-- Enrico Morina (ITA) - WS ID: ITAEM98
UPDATE public.sailors SET dob = '2010-05-10' WHERE id = 'a4184509-f20c-997d-eb3b-ea6c9700b94f'::uuid AND dob IS NULL;
-- Alexander Gavelfalt Forssen (SWE) - WS ID: SWEAG15
UPDATE public.sailors SET dob = '2010-07-13' WHERE id = '4a2f8a34-0ee4-184a-da3b-47e25e6f6d07'::uuid AND dob IS NULL;
-- Lorenzo Bertolino (CRO) - WS ID: CROLB16
UPDATE public.sailors SET dob = '2010-04-26' WHERE id = '6319fbd0-3101-ffe8-5ce5-105409537ff6'::uuid AND dob IS NULL;
-- Michail Akalestos (GRE) - WS ID: GREMA8
UPDATE public.sailors SET dob = '2010-12-22' WHERE id = '2a800cac-408d-7471-cefd-b56a7cae06b0'::uuid AND dob IS NULL;
-- Unai de Ugarte (ESP) - WS ID: ESPUD1
UPDATE public.sailors SET dob = '2010-07-05' WHERE id = '08a1cdf4-340a-0d0a-9f4b-387f7a6d8677'::uuid AND dob IS NULL;
-- Alessio Lucantoni (ITA) - WS ID: ITAAL124
UPDATE public.sailors SET dob = '2009-08-04' WHERE id = '6b8bf4cc-2287-a04d-9002-635ef94f3574'::uuid AND dob IS NULL;
-- Tayfun Türk (TUR) - WS ID: TURTT13
UPDATE public.sailors SET dob = '2009-08-31' WHERE id = '64bf8023-fc96-a103-f615-e7ad98e9b917'::uuid AND dob IS NULL;
-- Orestis Papadimitriou (GRE) - WS ID: GREOP8
UPDATE public.sailors SET dob = '2009-02-24' WHERE id = 'c72d6d0a-4d92-672b-4d0d-e83069fc8e2f'::uuid AND dob IS NULL;
-- Arel Hangul (TUR) - WS ID: TURAH3
UPDATE public.sailors SET dob = '2011-06-28' WHERE id = '362707cd-01e1-b09e-4b1c-9f3be9e514f1'::uuid AND dob IS NULL;
-- Jiun Choi (KOR) - WS ID: KORJC7
UPDATE public.sailors SET dob = '2011-01-18' WHERE id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'::uuid AND dob IS NULL;
-- Johan Peitersen Højland (DEN) - WS ID: DENJH40
UPDATE public.sailors SET dob = '2013-02-13' WHERE id = '6d89bc51-e3a4-648c-a6fa-02a1a470c7c1'::uuid AND dob IS NULL;
-- Dimitrios Ntoulas (GRE) - WS ID: GREDN2
UPDATE public.sailors SET dob = '2009-11-04' WHERE id = '7da32d2d-b969-9397-ad13-1b925c968b8a'::uuid AND dob IS NULL;
-- Anastasis Papageorgiou (GRE) - WS ID: GREAP82
UPDATE public.sailors SET dob = '2010-09-16' WHERE id = '4b5dc183-c6e4-feb0-8e94-84749dd47839'::uuid AND dob IS NULL;
-- Leonidas Kalpogiannakis (GRE) - WS ID: GRELK7
UPDATE public.sailors SET dob = '2011-10-08' WHERE id = 'b81e973e-2d1f-a3f6-6c30-3420f4b3f7f3'::uuid AND dob IS NULL;
-- Xuacu García Rigo (ESP) - WS ID: ESPXG9
UPDATE public.sailors SET dob = '2011-04-19' WHERE id = '5d3902e8-9c3e-a7b2-dd09-56b0cb396123'::uuid AND dob IS NULL;
-- Charles Julien (USA) - WS ID: USACJ68
UPDATE public.sailors SET dob = '2010-09-05' WHERE id = 'c523def4-c991-1dbb-d6ba-1c9ed8a8b513'::uuid AND dob IS NULL;
-- Marco Emanuele Aloisi (ITA) - WS ID: ITAMA137
UPDATE public.sailors SET dob = '2011-07-15' WHERE id = 'e4af1b88-72c6-12c0-77f1-d408dbe160b1'::uuid AND dob IS NULL;
-- Ahmet Efe Çanakçı (TUR) - WS ID: TURAC18
UPDATE public.sailors SET dob = '2010-02-17' WHERE id = '47f5a0aa-d9fe-9732-c97c-aadcd57b7525'::uuid AND dob IS NULL;
-- Demir Saygın (TUR) - WS ID: TURDS19
UPDATE public.sailors SET dob = '2011-08-26' WHERE id = '40d31474-70a2-d2c4-dfb7-0da03473029c'::uuid AND dob IS NULL;
-- Che Liu (CHN) - WS ID: CHNCL14
UPDATE public.sailors SET dob = '2010-10-05' WHERE id = 'b7214229-e97e-4c39-b342-cc4e99ff0623'::uuid AND dob IS NULL;
-- Juraj Lencovic (CRO) - WS ID: CROJL5
UPDATE public.sailors SET dob = '2011-04-22' WHERE id = 'a8bb3f80-8324-d353-deaf-b8fe64272fed'::uuid AND dob IS NULL;
-- Martino Paone Mittner (ITA) - WS ID: ITAMP306
UPDATE public.sailors SET dob = '2011-02-09' WHERE id = '38d3b264-f77c-3d80-1458-1cc8977349bb'::uuid AND dob IS NULL;
-- Teodoro Guadagnin (BRA) - WS ID: BRATG6
UPDATE public.sailors SET dob = '2009-07-21' WHERE id = '79ebd511-8699-b497-8d9c-b5cec2813307'::uuid AND dob IS NULL;
-- Mattia Cesare Valentini (ITA) - WS ID: ITAMV100
UPDATE public.sailors SET dob = '2012-02-09' WHERE id = '85f12c75-b048-8b83-9f4c-987c34b8beca'::uuid AND dob IS NULL;
-- Vincent Krueger Amengual (ESP) - WS ID: ESPVK1
UPDATE public.sailors SET dob = '2010-02-23' WHERE id = '692b63e3-b854-013a-be54-27f0100d19fe'::uuid AND dob IS NULL;
-- Evaggelos Antonopoulos (GRE) - WS ID: GREEA18
UPDATE public.sailors SET dob = '2009-09-11' WHERE id = '50a431be-a2f8-8d4c-8b7b-6257d34710f5'::uuid AND dob IS NULL;
-- Moritz Engel (GER) - WS ID: GERME35
UPDATE public.sailors SET dob = '2010-11-22' WHERE id = 'e786e029-2c66-1b6d-6ae7-93ce024b82cf'::uuid AND dob IS NULL;
-- Giorgos Bougiouris (GRE) - WS ID: GREGB12
UPDATE public.sailors SET dob = '2009-11-02' WHERE id = 'd3cead9c-2ffb-ddce-b4b5-74d5cdf9152f'::uuid AND dob IS NULL;
-- András Márton (HUN) - WS ID: HUNAM14
UPDATE public.sailors SET dob = '2010-05-15' WHERE id = '0cdaf7aa-0653-23f5-793e-52163ad4717e'::uuid AND dob IS NULL;
-- Guillermo Bravo de Laguna Ferrer (ESP) - WS ID: ESPGB22
UPDATE public.sailors SET dob = '2009-01-23' WHERE id = 'cd84c93f-b0c0-7b6b-1a4a-be1e5301e81d'::uuid AND dob IS NULL;
-- Julian Lhoest (NED) - WS ID: NEDJL13
UPDATE public.sailors SET dob = '2011-09-17' WHERE id = '4681018b-038b-e069-e181-248f77140be3'::uuid AND dob IS NULL;
-- Apostolos Karkalias (GRE) - WS ID: GREAK97
UPDATE public.sailors SET dob = '2009-12-08' WHERE id = 'ab95ad72-c6ad-b595-b9c1-80fac93c752e'::uuid AND dob IS NULL;
-- Macgregor Lewis (ESP) - WS ID: ESPML57
UPDATE public.sailors SET dob = '2010-04-04' WHERE id = 'ff6f6e49-a675-de28-44bd-6d26187cd01f'::uuid AND dob IS NULL;
-- Marek Stolba (CZE) - WS ID: CZEMS19
UPDATE public.sailors SET dob = '2011-07-31' WHERE id = '24d94377-38f3-daf6-2ff7-8b640d259a55'::uuid AND dob IS NULL;
-- Mattia Panvini (ITA) - WS ID: ITAMP295
UPDATE public.sailors SET dob = '2012-02-12' WHERE id = '9c2dd24e-94b2-822d-c0bb-3d6cb8748126'::uuid AND dob IS NULL;
-- Elias Ellinas (CYP) - WS ID: CYPEE3
UPDATE public.sailors SET dob = '2010-07-23' WHERE id = 'c54637bc-0402-5478-602d-5a2ce92c8dcd'::uuid AND dob IS NULL;
-- Alejandro Pérez Otero (ESP) - WS ID: ESPAP74
UPDATE public.sailors SET dob = '2009-02-23' WHERE id = 'b5d33559-bb07-ebb5-93d1-1844fd18a6be'::uuid AND dob IS NULL;
-- Gustav Holm Enander (SWE) - WS ID: SWEGH11
UPDATE public.sailors SET dob = '2011-09-21' WHERE id = 'ab84c41c-a216-5861-c30e-853bee3e1531'::uuid AND dob IS NULL;
-- Wojciech Gralak (POL) - WS ID: POLWG20
UPDATE public.sailors SET dob = '2011-08-06' WHERE id = 'db48fec9-2936-0679-aa0c-460b64558d57'::uuid AND dob IS NULL;
-- Harry Hogan (AUS) - WS ID: AUSHH19
UPDATE public.sailors SET dob = '2009-02-09' WHERE id = '4e02a253-8f83-c46c-039b-db45a805981b'::uuid AND dob IS NULL;
-- Panagiotis Vogiatzis (GRE) - WS ID: GREPV7
UPDATE public.sailors SET dob = '2011-01-09' WHERE id = '8094633e-f140-bf0f-cd76-2972a162b0c7'::uuid AND dob IS NULL;
-- Wikke van Der Meulen (NED) - WS ID: NEDWV34
UPDATE public.sailors SET dob = '2010-10-20' WHERE id = '4545ce6c-2e58-41bc-08bf-d323e8d5fbd9'::uuid AND dob IS NULL;
-- Zoran Jakić (CRO) - WS ID: CROZJ4
UPDATE public.sailors SET dob = '2010-01-05' WHERE id = '40777a95-ed59-c8b0-e583-4506ae7cadb0'::uuid AND dob IS NULL;
-- Marko Pezelj (CRO) - WS ID: CROMP32
UPDATE public.sailors SET dob = '2012-07-19' WHERE id = 'c245f409-1fe6-3f78-871c-59fbb066c73a'::uuid AND dob IS NULL;
-- Timothy Liu (USA) - WS ID: USATL120
UPDATE public.sailors SET dob = '2010-03-04' WHERE id = '49187380-5b01-020c-10af-43148781c4d6'::uuid AND dob IS NULL;
-- Carl Thrane (DEN) - WS ID: DENCT13
UPDATE public.sailors SET dob = '2009-12-15' WHERE id = '884c529c-808d-d065-5bbd-b6de272d5613'::uuid AND dob IS NULL;
-- Alfonso Murube (ESP) - WS ID: ESPAM161
UPDATE public.sailors SET dob = '2011-01-26' WHERE id = '2e4a5a29-f246-30b3-5e38-d98336febf4e'::uuid AND dob IS NULL;
-- Juanfran Chumilla (ESP) - WS ID: ESPJQ14
UPDATE public.sailors SET dob = '2010-03-04' WHERE id = '3de293c6-597e-751a-71cb-ab3bfb3b1b40'::uuid AND dob IS NULL;
-- Ignacio Murube (ESP) - WS ID: ESPIM44
UPDATE public.sailors SET dob = '2012-08-06' WHERE id = '1aa01637-4c6f-91b1-2cbf-143ef999438b'::uuid AND dob IS NULL;
-- Martin Mesic (CRO) - WS ID: CROMM47
UPDATE public.sailors SET dob = '2011-10-04' WHERE id = 'ca779115-f6c7-10f0-b86d-481fbb1ad096'::uuid AND dob IS NULL;
-- Emil Ocal (TUR) - WS ID: TUREO31
UPDATE public.sailors SET dob = '2010-05-24' WHERE id = 'b7111dee-8206-c529-c51b-820cdd17fa02'::uuid AND dob IS NULL;
-- Julian van Hoving (NED) - WS ID: NEDJV122
UPDATE public.sailors SET dob = '2009-07-01' WHERE id = '5f1496c6-1045-1741-0f83-8356eb1bb31b'::uuid AND dob IS NULL;
-- van Dong Andrea Folli (ITA) - WS ID: ITAVF26
UPDATE public.sailors SET dob = '2010-05-03' WHERE id = '89d47e34-0e2c-e978-d789-e8443543f4ab'::uuid AND dob IS NULL;
-- Oscar Wetter (SWE) - WS ID: SWEOW10
UPDATE public.sailors SET dob = '2009-07-30' WHERE id = '22c0e385-b6ab-7ffa-e425-4195c0db9d09'::uuid AND dob IS NULL;
-- Koren Koriel (ISR) - WS ID: ISRKK3
UPDATE public.sailors SET dob = '2011-06-04' WHERE id = 'f49a35dd-c8e9-686a-859e-a2d0cab7dcf5'::uuid AND dob IS NULL;
-- Alexander Mørup-petersen (DEN) - WS ID: DENAM14
UPDATE public.sailors SET dob = '2012-01-08' WHERE id = 'd4f2f0e0-c147-9935-7513-74f3be3c3ba8'::uuid AND dob IS NULL;
-- Marlon Münt (EST) - WS ID: ESTMM20
UPDATE public.sailors SET dob = '2009-07-02' WHERE id = '2129a3ac-0a72-2230-2d3a-f548103aed8d'::uuid AND dob IS NULL;
-- Mark Slotboom (MON) - WS ID: SUIMS46
UPDATE public.sailors SET dob = '2011-07-17' WHERE id = 'fb1901c9-319b-8180-7310-a0ba953118d3'::uuid AND dob IS NULL;
-- Torben Verjovsky (BRA) - WS ID: BRATV7
UPDATE public.sailors SET dob = '2010-03-31' WHERE id = '6dd6b262-d41f-3288-7c91-0f80eeb58d22'::uuid AND dob IS NULL;
-- Marcel Marfà Munmany (ESP) - WS ID: ESPMM121
UPDATE public.sailors SET dob = '2011-09-15' WHERE id = '7a5bf10d-c1f0-6ad0-6529-0a4f85456d2c'::uuid AND dob IS NULL;
-- Alberto Dessena (ITA) - WS ID: ITAAD188
UPDATE public.sailors SET dob = '2011-02-20' WHERE id = '09923c77-e258-45c3-bd78-4590dac2634c'::uuid AND dob IS NULL;
-- Moritz Thiel (GER) - WS ID: GERMT42
UPDATE public.sailors SET dob = '2010-01-16' WHERE id = '78403511-6d27-7584-dccf-a2fef0e2ec13'::uuid AND dob IS NULL;
-- Petro Gribov (UKR) - WS ID: UKRPG1
UPDATE public.sailors SET dob = '2011-08-13' WHERE id = '55ae0f43-c3a4-4b96-abdd-3b43d9309c6a'::uuid AND dob IS NULL;
-- Vito Skufca (CRO) - WS ID: CROVS5
UPDATE public.sailors SET dob = '2010-05-25' WHERE id = 'aff153a1-356e-61e4-985c-53fdc73b8e2f'::uuid AND dob IS NULL;
-- Noah Emanuel Schweichler (GER) - WS ID: GERNS53
UPDATE public.sailors SET dob = '2010-07-06' WHERE id = '1440b451-a296-5dbd-e091-790ee3b9edb4'::uuid AND dob IS NULL;
-- Filippo Noto (ITA) - WS ID: ITAFN31
UPDATE public.sailors SET dob = '2012-05-18' WHERE id = '69c9ef7c-608b-c79f-fe46-8f632f48bce3'::uuid AND dob IS NULL;
-- Panagiotis Stathopoulos (GRE) - WS ID: GREPS23
UPDATE public.sailors SET dob = '2010-01-22' WHERE id = '65613b37-e8f5-8fe9-3e82-7edec20ad34c'::uuid AND dob IS NULL;
-- Francesco Giuseppe Bo (ITA) - WS ID: ITAFB231
UPDATE public.sailors SET dob = '2010-11-27' WHERE id = '9215db74-9375-e805-ae9b-3f0cd0bc6690'::uuid AND dob IS NULL;
-- Grant Chin (USA) - WS ID: USAGC91
UPDATE public.sailors SET dob = '2011-09-14' WHERE id = 'e3f433a1-0aa6-e626-916b-cf948b5e2cd4'::uuid AND dob IS NULL;
-- Emanuele Vincenzi (ITA) - WS ID: ITAEV38
UPDATE public.sailors SET dob = '2010-12-29' WHERE id = '5aa3f62e-31b7-7c3d-3f50-aedce4116913'::uuid AND dob IS NULL;
-- Murray Duthie (AUS) - WS ID: AUSMD70
UPDATE public.sailors SET dob = '2010-03-05' WHERE id = '52cb6720-a4d6-0ad1-0a79-2b04ddba1da3'::uuid AND dob IS NULL;
-- Toby Turner (GBR) - WS ID: GBRTT66
UPDATE public.sailors SET dob = '2011-12-21' WHERE id = '8d6d6b25-370c-1520-0d4b-ee322239ab7b'::uuid AND dob IS NULL;
-- Hugo J Eklöv (SWE) - WS ID: SWEHJ13
UPDATE public.sailors SET dob = '2011-09-08' WHERE id = 'd38fd6a1-4da7-1afe-dee9-78cbd07ea646'::uuid AND dob IS NULL;
-- Dani Martinez (ESP) - WS ID: ESPDV11
UPDATE public.sailors SET dob = '2011-07-21' WHERE id = 'dc7c6a88-ad84-c22e-d7b9-d81207d2796b'::uuid AND dob IS NULL;
-- Maxime van Acker (BEL) - WS ID: BELMV24
UPDATE public.sailors SET dob = '2010-07-11' WHERE id = '1431ddb5-44aa-cb35-ceb8-d3f826b2147e'::uuid AND dob IS NULL;
-- Emiio Bolivar (PER) - WS ID: PEREB1
UPDATE public.sailors SET dob = '2009-04-01' WHERE id = 'd2d73361-374f-0b25-511b-5399257ad43a'::uuid AND dob IS NULL;
-- Michal Malagocki (POL) - WS ID: POLMM100
UPDATE public.sailors SET dob = '2011-07-26' WHERE id = '5e84a6be-101e-d411-1f62-0db4c4cf2aaf'::uuid AND dob IS NULL;
-- Julian Rivera Fernandez (PUR) - WS ID: PURJR9
UPDATE public.sailors SET dob = '2010-12-18' WHERE id = 'dd11d455-db72-51dc-5e33-f202c2fee182'::uuid AND dob IS NULL;
-- Nick Lahme (GER) - WS ID: GERNL19
UPDATE public.sailors SET dob = '2012-07-14' WHERE id = '0b0ab550-2e96-932b-02da-6a88138bd2f8'::uuid AND dob IS NULL;
-- Miguel Morela (BRA) - WS ID: BRAMM74
UPDATE public.sailors SET dob = '2011-06-20' WHERE id = 'e6ca5829-d7d0-7291-e0f8-3c824d6c00ae'::uuid AND dob IS NULL;
-- Ferrante de Pieri (ITA) - WS ID: ITAFD149
UPDATE public.sailors SET dob = '2010-09-01' WHERE id = '63207222-5863-a4f5-34c4-7c92808db9dc'::uuid AND dob IS NULL;
-- Remy Maris (BEL) - WS ID: BELRM2
UPDATE public.sailors SET dob = '2010-12-22' WHERE id = 'c03b9d5f-e9a4-ddc8-5ad6-de5cc15a305a'::uuid AND dob IS NULL;
-- Jerzy Rulka (POL) - WS ID: POLJR31
UPDATE public.sailors SET dob = '2011-09-09' WHERE id = '7be1602a-33de-154d-a68a-62f20ccca5fd'::uuid AND dob IS NULL;
-- Amédée Margueron (SUI) - WS ID: SUIAM188
UPDATE public.sailors SET dob = '2010-05-19' WHERE id = '4d39903d-70b0-9df6-9e6f-aef48147d76c'::uuid AND dob IS NULL;
-- Leonardo Denti (ITA) - WS ID: ITALD124
UPDATE public.sailors SET dob = '2009-02-19' WHERE id = '0be1aa7d-c7d4-87bc-0180-e28092219133'::uuid AND dob IS NULL;
-- Panagioths Tsatrafilhs (GRE) - WS ID: GREPT17
UPDATE public.sailors SET dob = '2009-07-31' WHERE id = 'be71ff57-c6e4-f957-1e32-f8a8654ab3ea'::uuid AND dob IS NULL;
-- Fraser Hakes (GBR) - WS ID: GBRFH21
UPDATE public.sailors SET dob = '2012-05-27' WHERE id = '362cf45d-af32-f869-42dd-1cb48d598465'::uuid AND dob IS NULL;
-- Lauri Sepponen (FIN) - WS ID: FINLS7
UPDATE public.sailors SET dob = '2011-09-26' WHERE id = '7cbc849c-90d1-168b-680d-d4742bd9be61'::uuid AND dob IS NULL;
-- Arthur Moulton (CAN) - WS ID: CANAM76
UPDATE public.sailors SET dob = '2010-08-11' WHERE id = '50dd3eed-a549-b8a4-f05c-25d198db40c4'::uuid AND dob IS NULL;
-- Alexandros Shailos (CYP) - WS ID: CYPAS5
UPDATE public.sailors SET dob = '2010-12-02' WHERE id = 'd61706c5-4bf7-ead0-3509-e56864108320'::uuid AND dob IS NULL;
-- Toma Kukuljan (CRO) - WS ID: CROTK10
UPDATE public.sailors SET dob = '2011-12-28' WHERE id = '95df8cac-d83c-4a85-f692-c1593dcd535b'::uuid AND dob IS NULL;
-- Callum Marshall (GBR) - WS ID: GBRCM135
UPDATE public.sailors SET dob = '2011-12-28' WHERE id = '7f1da828-602a-c234-cd22-5ddc26bb5dd4'::uuid AND dob IS NULL;
-- Cesare Pierdomenico (ITA) - WS ID: ITACP73
UPDATE public.sailors SET dob = '2010-07-11' WHERE id = 'c0695acd-123e-ce44-b625-b2825e85a67e'::uuid AND dob IS NULL;
-- Paul Fiete Hickstein (GER) - WS ID: GERPH55
UPDATE public.sailors SET dob = '2010-09-21' WHERE id = 'c909a3b6-bb2a-ae1b-a021-a7f35ec0af8f'::uuid AND dob IS NULL;
-- Olof Aldor (SWE) - WS ID: SWEOA12
UPDATE public.sailors SET dob = '2011-09-29' WHERE id = 'fe6c351a-2054-89d2-8155-79134a4d3011'::uuid AND dob IS NULL;
-- David Hruby (CZE) - WS ID: CZEDH3
UPDATE public.sailors SET dob = '2012-07-29' WHERE id = 'ca59336f-5acc-b173-a90c-16c17b2d76ec'::uuid AND dob IS NULL;
-- Alessandro Verani (ITA) - WS ID: ITAAV116
UPDATE public.sailors SET dob = '2009-03-10' WHERE id = 'c9f75c7d-8fc1-3ad7-81bf-a05972ebc762'::uuid AND dob IS NULL;
-- Sebastian Behrens (AUS) - WS ID: AUSSB94
UPDATE public.sailors SET dob = '2010-10-04' WHERE id = '9aa94500-7b7a-dae6-54e6-70d409e0f2fe'::uuid AND dob IS NULL;
-- Maurice de Beukelaar (BEL) - WS ID: BELMD25
UPDATE public.sailors SET dob = '2011-10-01' WHERE id = 'e3364429-97bd-0a5b-b0ae-4b034470958c'::uuid AND dob IS NULL;
-- Anastasios Antoniou (GRE) - WS ID: GREAA45
UPDATE public.sailors SET dob = '2012-12-11' WHERE id = '59ad1cf4-5370-6477-24b1-bdf98cfdf724'::uuid AND dob IS NULL;
-- Nitay Lin (ISR) - WS ID: ISRNL5
UPDATE public.sailors SET dob = '2011-05-21' WHERE id = 'bac94ffa-de2d-eebf-2f4b-811faba07214'::uuid AND dob IS NULL;
-- Harry Dence (GBR) - WS ID: GBRHD24
UPDATE public.sailors SET dob = '2010-01-13' WHERE id = '4253707a-b571-e8cc-8d7a-6c67ce2aea59'::uuid AND dob IS NULL;
-- Nicolò Santoro (ITA) - WS ID: ITANS36
UPDATE public.sailors SET dob = '2012-02-19' WHERE id = '8209f592-8b22-ae42-015d-543455068520'::uuid AND dob IS NULL;
-- Adam Laurin (SWE) - WS ID: SWEAL51
UPDATE public.sailors SET dob = '2010-01-15' WHERE id = 'f3adead6-c6e4-c88d-4c81-f8c0305ae1f4'::uuid AND dob IS NULL;
-- Jonas Aminoff (FIN) - WS ID: FINJA19
UPDATE public.sailors SET dob = '2010-09-18' WHERE id = '15012e88-24c1-c977-aeff-e60cb97e9daa'::uuid AND dob IS NULL;
-- Cittadini Giovanni (ITA) - WS ID: ITACG67
UPDATE public.sailors SET dob = '2012-02-24' WHERE id = '92b59846-2742-a51a-af2f-75b0962be12f'::uuid AND dob IS NULL;
-- Iivari Salo (FIN) - WS ID: FINIS7
UPDATE public.sailors SET dob = '2010-12-16' WHERE id = 'bc771f18-fe98-c5cb-718e-f58a4e4c0a18'::uuid AND dob IS NULL;
-- Dougal Jackson (GBR) - WS ID: GBRDJ33
UPDATE public.sailors SET dob = '2010-08-07' WHERE id = 'b190de35-6214-4ddf-f086-74ac6885ceb3'::uuid AND dob IS NULL;
-- Marc Fuster (ESP) - WS ID: ESPMF54
UPDATE public.sailors SET dob = '2009-01-21' WHERE id = '0c535dde-a743-157d-3dd5-8391208838fc'::uuid AND dob IS NULL;
-- Marcus Durlach (USA) - WS ID: USAMD209
UPDATE public.sailors SET dob = '2009-09-21' WHERE id = 'a85ab47f-fbb5-b738-8932-07ae5af6fd1e'::uuid AND dob IS NULL;
-- Adriano Gasparrini (ITA) - WS ID: ITAAG192
UPDATE public.sailors SET dob = '2010-08-22' WHERE id = '93cd51ed-3183-e611-bb57-a255bdf622e6'::uuid AND dob IS NULL;
-- Akin Hammas (GER) - WS ID: GERAH82
UPDATE public.sailors SET dob = '2011-05-16' WHERE id = '783be517-fd37-18b5-c9e0-c1b49eabe4c3'::uuid AND dob IS NULL;
-- Olivier Rikmans (NED) - WS ID: NEDOR2
UPDATE public.sailors SET dob = '2011-09-26' WHERE id = '858df2f7-3282-940b-8add-5b883f8355ec'::uuid AND dob IS NULL;
-- Tommaso Netti (ITA) - WS ID: ITATN11
UPDATE public.sailors SET dob = '2010-12-19' WHERE id = '01e6f162-7099-4733-3d12-dbd817010c7f'::uuid AND dob IS NULL;
-- Mate Pozsonyi (HUN) - WS ID: HUNMP7
UPDATE public.sailors SET dob = '2011-04-26' WHERE id = '34a44c63-fc05-31d9-3102-ef9467e9805f'::uuid AND dob IS NULL;
-- Antonino Mortillaro (ITA) - WS ID: ITAAM311
UPDATE public.sailors SET dob = '2012-03-24' WHERE id = '377f7693-af81-e8cd-a188-334caaa2d147'::uuid AND dob IS NULL;
-- Liam Bernstein (GER) - WS ID: GERLB74
UPDATE public.sailors SET dob = '2010-05-21' WHERE id = '17c93e75-edea-74d7-c267-4e169c2b37cd'::uuid AND dob IS NULL;
-- Gonzalo Martin Canales (ESP) - WS ID: ESPGM42
UPDATE public.sailors SET dob = '2010-10-15' WHERE id = '90a717b0-4502-2924-04f6-5294f7c2d6c3'::uuid AND dob IS NULL;
-- Henri Lagrange (BEL) - WS ID: BELHL2
UPDATE public.sailors SET dob = '2010-09-21' WHERE id = 'dc7f89f1-1406-86eb-bcd8-bf7886d41eb9'::uuid AND dob IS NULL;
-- Antonis Kolitsas (GRE) - WS ID: GREAK94
UPDATE public.sailors SET dob = '2010-02-16' WHERE id = 'ee867bea-ab86-209e-75d9-eee3b03cfabe'::uuid AND dob IS NULL;
-- Marco Crocenzi (SUI) - WS ID: SUIMC13
UPDATE public.sailors SET dob = '2011-10-13' WHERE id = 'bc924ad6-f9fb-e767-370d-cfa4f0527b8d'::uuid AND dob IS NULL;
-- Jingbo Jacob Tu (CAN) - WS ID: CANJT17
UPDATE public.sailors SET dob = '2011-02-02' WHERE id = 'c0b1d729-85ce-5d29-8907-29d41046790c'::uuid AND dob IS NULL;
-- Armaan Manwatkar (BAH) - WS ID: BAHAM3
UPDATE public.sailors SET dob = '2010-10-13' WHERE id = '81d88adb-2443-de6d-6014-ec323d261cc5'::uuid AND dob IS NULL;
-- Alexandros Doukas (GRE) - WS ID: GREAD33
UPDATE public.sailors SET dob = '2010-07-06' WHERE id = '44d01755-046e-5cd8-7f13-bf8acfa00105'::uuid AND dob IS NULL;
-- Jason Lin (CHN) - WS ID: USAJL289
UPDATE public.sailors SET dob = '2011-02-25' WHERE id = '79dc7d49-7373-44e4-9d0d-b3be10d33eca'::uuid AND dob IS NULL;
-- Kousei Nakata (JPN) - WS ID: JPNKN47
UPDATE public.sailors SET dob = '2009-04-05' WHERE id = '05561d97-4881-92b3-d50e-c9a0314929ee'::uuid AND dob IS NULL;
-- Giovanni Magnetti (SUI) - WS ID: SUIGM10
UPDATE public.sailors SET dob = '2010-09-28' WHERE id = '9ed7b0b2-1e16-28b4-a797-10a1d2feb729'::uuid AND dob IS NULL;
-- Piotr Malitowski (POL) - WS ID: POLPM28
UPDATE public.sailors SET dob = '2011-12-19' WHERE id = '87b61146-e738-913d-fee1-f82f629a0e20'::uuid AND dob IS NULL;
-- Massimiliano Chiarella (PER) - WS ID: PERMC5
UPDATE public.sailors SET dob = '2010-10-22' WHERE id = 'e79224d1-badd-aca5-b912-7fc667bcaca0'::uuid AND dob IS NULL;
-- Johann Lerch (GER) - WS ID: GERJL70
UPDATE public.sailors SET dob = '2009-01-01' WHERE id = 'aa7fc0e5-d0f8-a9ab-ebd3-845d05d6b3f7'::uuid AND dob IS NULL;
-- Riccardo Giorgio Fini (ITA) - WS ID: ITARF55
UPDATE public.sailors SET dob = '2009-01-11' WHERE id = '4a3a031a-ddbd-a64e-839b-7eaa3d125c75'::uuid AND dob IS NULL;
-- Oleksandr Bolsunovskyi (CYP) - WS ID: UKROB5
UPDATE public.sailors SET dob = '2009-09-04' WHERE id = '79baedcc-8fea-6e29-457e-2142b3dde85f'::uuid AND dob IS NULL;
-- Demir Gogulan (TUR) - WS ID: TURDG9
UPDATE public.sailors SET dob = '2009-03-17' WHERE id = '4411ab3f-483f-4c51-bf26-d82c7aba4efc'::uuid AND dob IS NULL;
-- Christian Horjen Møller (NOR) - WS ID: NORCM4
UPDATE public.sailors SET dob = '2010-10-21' WHERE id = 'cc89493a-0734-dd1a-02fd-5cef66246490'::uuid AND dob IS NULL;
-- Harry Brown (GBR) - WS ID: GBRHB77
UPDATE public.sailors SET dob = '2010-10-08' WHERE id = '883d26b2-997c-bb8e-a3e2-6a2bca5203e8'::uuid AND dob IS NULL;
-- Michail Rimikis (GRE) - WS ID: GREMR4
UPDATE public.sailors SET dob = '2010-12-06' WHERE id = 'd4b6fefc-83c6-7e5a-b5bc-f9864c9f1516'::uuid AND dob IS NULL;
-- Maxime Vallotton (SUI) - WS ID: SUIMV17
UPDATE public.sailors SET dob = '2011-09-11' WHERE id = '3d9e694d-458f-595d-abcb-3028b2f68369'::uuid AND dob IS NULL;
-- Harrison Ward (USA) - WS ID: USAHW37
UPDATE public.sailors SET dob = '2010-12-08' WHERE id = 'b147d697-049d-f9fd-b5f6-08b0dd0f7e3f'::uuid AND dob IS NULL;
-- Marius Andersen (DEN) - WS ID: DENMA19
UPDATE public.sailors SET dob = '2011-11-03' WHERE id = '120136f6-b9bd-8bf7-0475-7e2a0867da20'::uuid AND dob IS NULL;
-- Bram Ten Berge (NED) - WS ID: NEDBB36
UPDATE public.sailors SET dob = '2011-06-12' WHERE id = '8c0d6fd5-e584-92e9-7be5-5822c7fe03b5'::uuid AND dob IS NULL;
-- Tim Ambos (SUI) - WS ID: GERTA18
UPDATE public.sailors SET dob = '2011-01-10' WHERE id = '984e9f9f-59dc-456c-85d0-64a6f12f8143'::uuid AND dob IS NULL;
-- Marinos Nikolaides (CYP) - WS ID: CYPMN1
UPDATE public.sailors SET dob = '2009-09-07' WHERE id = '3f10785b-7ebd-b50c-2a3a-5787a7b762ef'::uuid AND dob IS NULL;
-- Diego de Teran (USA) - WS ID: SUIDD9
UPDATE public.sailors SET dob = '2010-12-07' WHERE id = '06d4aa27-3f02-6073-415c-a895f40ce258'::uuid AND dob IS NULL;
-- Roy Mass (ISR) - WS ID: ISRRM8
UPDATE public.sailors SET dob = '2011-10-27' WHERE id = '9ede96d4-fb66-e2e4-4123-0885acba2f19'::uuid AND dob IS NULL;
-- Hynek Dokoupil (CZE) - WS ID: CZEHD1
UPDATE public.sailors SET dob = '2011-09-26' WHERE id = '235db898-a158-50e0-91ff-4fa5dec9decb'::uuid AND dob IS NULL;
-- Tomas Grodl (CZE) - WS ID: CZETG3
UPDATE public.sailors SET dob = '2010-02-17' WHERE id = 'e799f125-dcfe-082f-8cdb-f83adecf304b'::uuid AND dob IS NULL;
-- Giorgio de Franceschi (ITA) - WS ID: ITAGD173
UPDATE public.sailors SET dob = '2010-05-12' WHERE id = '58f6b2c1-11e0-e6c1-d665-810d8eed7525'::uuid AND dob IS NULL;
-- Asher Baurley (USA) - WS ID: USAAB287
UPDATE public.sailors SET dob = '2011-01-07' WHERE id = 'a16e8e6d-6f06-f121-d86b-aa44108b6ea0'::uuid AND dob IS NULL;
-- Johannes Busck (DEN) - WS ID: DENJB39
UPDATE public.sailors SET dob = '2011-03-20' WHERE id = '90fc7623-be17-cf93-4d3f-cdb2a8fcc5d7'::uuid AND dob IS NULL;
-- Quirin Klapper (GER) - WS ID: GERQK2
UPDATE public.sailors SET dob = '2010-01-27' WHERE id = '3bd8098b-6221-f5ca-3002-de181b54c944'::uuid AND dob IS NULL;
-- Rasmus Buck (GER) - WS ID: GERRB46
UPDATE public.sailors SET dob = '2012-09-24' WHERE id = '62221f89-0d16-7be6-7226-ec4daedb4bd2'::uuid AND dob IS NULL;
-- Francesco Zalar (ITA) - WS ID: ITAFZ36
UPDATE public.sailors SET dob = '2011-11-04' WHERE id = 'fed102c1-9142-5c2f-fb27-301363704425'::uuid AND dob IS NULL;
-- Filippo Colace (ITA) - WS ID: ITAFC252
UPDATE public.sailors SET dob = '2009-08-15' WHERE id = 'ccbd10d4-03e1-efa7-f229-5ba085c6e456'::uuid AND dob IS NULL;
-- Jason Wang (USA) - WS ID: USAJW327
UPDATE public.sailors SET dob = '2010-11-17' WHERE id = 'a7274c7f-5129-9eec-433d-1db3f094681d'::uuid AND dob IS NULL;
-- Johannes Seippel-sivertsen (NOR) - WS ID: NORJS32
UPDATE public.sailors SET dob = '2009-12-24' WHERE id = 'fbb9891b-4600-5b1d-ec7c-78d884ceeb18'::uuid AND dob IS NULL;
-- Harry Whelan (GBR) - WS ID: GBRHW69
UPDATE public.sailors SET dob = '2010-02-17' WHERE id = '536f7fb1-a148-ec60-a600-17f9fad68510'::uuid AND dob IS NULL;
-- Matteo di Dio (ITA) - WS ID: ITAMD221
UPDATE public.sailors SET dob = '2009-12-25' WHERE id = 'cbba8f08-276c-aff9-0e92-d213542a0c3e'::uuid AND dob IS NULL;
-- Nikos Beckmann (GER) - WS ID: GERNB41
UPDATE public.sailors SET dob = '2010-10-12' WHERE id = '08193638-f2ba-db53-02d5-964793395fb6'::uuid AND dob IS NULL;
-- Felipe Pachón Pérez (ESP) - WS ID: ESPFP49
UPDATE public.sailors SET dob = '2010-02-01' WHERE id = 'e13f388b-c4de-4484-f000-f656fc2cc8cb'::uuid AND dob IS NULL;
-- Stefano Pagano (ITA) - WS ID: ITASP119
UPDATE public.sailors SET dob = '2009-07-25' WHERE id = '9725a92c-80a3-96e1-b2a7-4f28d4747479'::uuid AND dob IS NULL;
-- Jonathan Westerheider (GER) - WS ID: GERJW92
UPDATE public.sailors SET dob = '2011-01-21' WHERE id = '1d456d09-620d-cd57-b6fc-72009c557a34'::uuid AND dob IS NULL;
-- Carl-Anton Stollner (GER) - WS ID: GERCS124
UPDATE public.sailors SET dob = '2011-07-18' WHERE id = '3bbce5de-bfce-7b82-826e-724e1833020c'::uuid AND dob IS NULL;
-- Noah Mathers (GBR) - WS ID: GBRNM87
UPDATE public.sailors SET dob = '2010-01-26' WHERE id = 'b6238d57-7a3a-67b6-cfc4-2a6550e05eff'::uuid AND dob IS NULL;
-- Niko Noponen (FIN) - WS ID: FINNN2
UPDATE public.sailors SET dob = '2010-08-31' WHERE id = 'f46a9524-a230-5f36-fa5c-b3deea39565b'::uuid AND dob IS NULL;
-- Jackson Clark (IRL) - WS ID: IRLJC64
UPDATE public.sailors SET dob = '2010-06-08' WHERE id = '424bb5b9-b278-ab36-0aeb-2e831519ed59'::uuid AND dob IS NULL;
-- Rasmus Lönnqvist (FIN) - WS ID: FINRL16
UPDATE public.sailors SET dob = '2010-07-05' WHERE id = '6253fc79-c45a-6fb4-8880-70a99b1665a0'::uuid AND dob IS NULL;
-- Martim Amaral (BRA) - WS ID: BRAMA35
UPDATE public.sailors SET dob = '2010-01-08' WHERE id = '4f8f9c44-317c-752b-a748-32fe5f67fcb4'::uuid AND dob IS NULL;
-- Eryk Krause (POL) - WS ID: POLEK11
UPDATE public.sailors SET dob = '2011-12-28' WHERE id = 'da62d047-4999-7518-5a95-cd674e9ba31a'::uuid AND dob IS NULL;
-- Camill V Manstein (GER) - WS ID: GERCV21
UPDATE public.sailors SET dob = '2010-09-13' WHERE id = '48510205-5d4e-adff-d0ba-7df219713651'::uuid AND dob IS NULL;
-- Yuval Harlamp (ISR) - WS ID: ISRYH4
UPDATE public.sailors SET dob = '2012-08-07' WHERE id = 'ffcc652d-64fe-4e2c-dfd3-28c62320661a'::uuid AND dob IS NULL;
-- Thani Shams (QAT) - WS ID: QATTS1
UPDATE public.sailors SET dob = '2011-10-15' WHERE id = 'ddaaec0c-2b9c-23de-07d8-fdd54c947761'::uuid AND dob IS NULL;
-- Valentin Rangnow (GER) - WS ID: GERVR14
UPDATE public.sailors SET dob = '2011-01-03' WHERE id = '7df0e075-a49b-e4d6-83aa-cefb86780949'::uuid AND dob IS NULL;
-- Elias Kienzler (GER) - WS ID: GEREK20
UPDATE public.sailors SET dob = '2009-09-13' WHERE id = '0cd56a8a-615f-6188-1135-248bec3afec0'::uuid AND dob IS NULL;
-- Georgios Kalaitzis (GRE) - WS ID: GREGK50
UPDATE public.sailors SET dob = '2011-01-05' WHERE id = '9ef64ada-6a58-1fb2-6fa8-2f3f8a9726cf'::uuid AND dob IS NULL;
-- Johan Gundborg (DEN) - WS ID: DENJG13
UPDATE public.sailors SET dob = '2010-10-12' WHERE id = '99bfca54-ba60-8740-3384-b9deb8c867a0'::uuid AND dob IS NULL;
-- Atle Homme Håland (NOR) - WS ID: NORAH35
UPDATE public.sailors SET dob = '2011-06-05' WHERE id = '5d812d42-7796-de37-cc24-050cddd9848c'::uuid AND dob IS NULL;
-- Jonas Tschentscher (GER) - WS ID: GERJT38
UPDATE public.sailors SET dob = '2010-09-17' WHERE id = '33ad9091-ba6a-953f-c7c5-c00e76a4c378'::uuid AND dob IS NULL;
-- Antonin Brückner (CZE) - WS ID: CZEAB4
UPDATE public.sailors SET dob = '2010-03-30' WHERE id = 'd0626819-43f6-b04f-7030-c2355f22aa5b'::uuid AND dob IS NULL;
-- Friedrich Beckmann (GER) - WS ID: GERFB77
UPDATE public.sailors SET dob = '2011-08-10' WHERE id = '6e2a00eb-3095-3a79-66db-5427b0d457e0'::uuid AND dob IS NULL;
-- Michel Wagner (GER) - WS ID: GERMW85
UPDATE public.sailors SET dob = '2011-03-08' WHERE id = '657dc49e-0057-bde0-811a-7cdbf2b06ee6'::uuid AND dob IS NULL;
-- Marius Eiane (NOR) - WS ID: NORME14
UPDATE public.sailors SET dob = '2010-06-15' WHERE id = 'c361c7f7-cda6-830f-7e00-60f2bea8df78'::uuid AND dob IS NULL;
-- Emile Rogers (BEL) - WS ID: BELER2
UPDATE public.sailors SET dob = '2009-09-09' WHERE id = 'b6c55402-19eb-b6fd-397b-21d564542c91'::uuid AND dob IS NULL;
-- Louis Lathioor (BEL) - WS ID: BELLL4
UPDATE public.sailors SET dob = '2010-03-26' WHERE id = '69a135be-b90b-cc0e-7bd6-4d5bd2488072'::uuid AND dob IS NULL;
-- Aksel Laustsen (DEN) - WS ID: DENAL20
UPDATE public.sailors SET dob = '2010-02-01' WHERE id = '854a18b7-f949-f9c9-9cd6-a6b10d4a3025'::uuid AND dob IS NULL;
-- Aggelos Rafael Mperios (GRE) - WS ID: GREAM43
UPDATE public.sailors SET dob = '2010-07-23' WHERE id = 'e75f0cdd-d4f7-033c-6240-4264dc4e883c'::uuid AND dob IS NULL;
-- Carlos Martinez de Ubago (ESP) - WS ID: ESPCM70
UPDATE public.sailors SET dob = '2010-08-21' WHERE id = '82444647-8f19-acae-3c40-98162b676988'::uuid AND dob IS NULL;
-- Philipp Mitsch (GER) - WS ID: GERPM35
UPDATE public.sailors SET dob = '2010-12-22' WHERE id = 'b8ec9e3a-b660-37ac-8dea-12b329cf8dcd'::uuid AND dob IS NULL;
-- Ole Heitmann (GER) - WS ID: GEROH22
UPDATE public.sailors SET dob = '2010-04-11' WHERE id = '274c5828-c53d-4cf8-8bb8-63ea396e6b20'::uuid AND dob IS NULL;
-- Ian Wang (MLT) - WS ID: MLTIW1
UPDATE public.sailors SET dob = '2011-05-03' WHERE id = 'f0d4d6ea-05cc-e6b8-f248-ac11abdd641a'::uuid AND dob IS NULL;
-- Javier Salamanca Alba (ESP) - WS ID: ESPJA111
UPDATE public.sailors SET dob = '2010-11-12' WHERE id = '3ae71ee6-f7b1-427f-064b-02ea7a4a3386'::uuid AND dob IS NULL;
-- Shelby Gibbs (USA) - WS ID: USASG158
UPDATE public.sailors SET dob = '2008-02-02' WHERE id = 'ef6538e5-d4b8-cac3-9edc-622ae35b0bec'::uuid AND dob IS NULL;
-- Benjamin Wilton (GBR) - WS ID: GBRBW59
UPDATE public.sailors SET dob = '2011-01-09' WHERE id = 'd07430ff-2d47-20d4-24ca-b335f327bcbb'::uuid AND dob IS NULL;
-- Edmund Bierer (USA) - WS ID: USAEB170
UPDATE public.sailors SET dob = '2013-02-01' WHERE id = '8ff99a81-0db9-5d3f-7cbd-aa6be1eb418e'::uuid AND dob IS NULL;
-- Thor Husted Frank (DEN) - WS ID: DENTF6
UPDATE public.sailors SET dob = '2011-09-05' WHERE id = '76d8ad61-8f3c-21f7-38c6-1d6a2cabd9c3'::uuid AND dob IS NULL;
-- Jai Mutreja (GBR) - WS ID: GBRJM243
UPDATE public.sailors SET dob = '2009-05-01' WHERE id = '0f2fe122-19b5-923b-ed72-02a8e6fefd59'::uuid AND dob IS NULL;
-- Artis Kristers Graudums (LAT) - WS ID: LATAG1
UPDATE public.sailors SET dob = '2009-05-06' WHERE id = '00e87aeb-a7e8-572f-7ed7-f664e3e9c7fa'::uuid AND dob IS NULL;
-- Jelte Book (GER) - WS ID: GERJB145
UPDATE public.sailors SET dob = '2011-07-23' WHERE id = '0f89efe6-5d59-f956-c1cf-e717dc5ea63a'::uuid AND dob IS NULL;
-- Mátyás Vágó (HUN) - WS ID: HUNMV5
UPDATE public.sailors SET dob = '2011-08-09' WHERE id = '9a94452f-7dc9-fdff-2bf8-dfa00efa8bfc'::uuid AND dob IS NULL;
-- Theodor Waldow (GER) - WS ID: GERTW49
UPDATE public.sailors SET dob = '2011-10-11' WHERE id = '67a62f04-9ed1-409c-86d0-322debe2fb36'::uuid AND dob IS NULL;
-- John Meade (USA) - WS ID: USAJM621
UPDATE public.sailors SET dob = '2010-12-13' WHERE id = '832347b0-7009-6a84-adea-7d6564f84542'::uuid AND dob IS NULL;
-- Abdulla Alzubaidi (UAE) - WS ID: UAEAA54
UPDATE public.sailors SET dob = '2009-01-29' WHERE id = '3391e467-327f-d0f9-d962-392ddf37837d'::uuid AND dob IS NULL;
-- Bennett Lamb (USA) - WS ID: USABL131
UPDATE public.sailors SET dob = '2011-04-22' WHERE id = 'e07f1635-690a-ae04-c2b1-8db4288c2574'::uuid AND dob IS NULL;
-- Ažbe Erbežnik Novak (SLO) - WS ID: SLOAE1
UPDATE public.sailors SET dob = '2011-03-25' WHERE id = 'dfd29a3d-89ea-41d0-6ee8-9d38e657c652'::uuid AND dob IS NULL;
-- Jacob Carl Delia (MLT) - WS ID: MLTJD2
UPDATE public.sailors SET dob = '2009-07-24' WHERE id = '6f839a28-b533-aba9-bb3b-0e063f094557'::uuid AND dob IS NULL;
-- Max Valenta (CZE) - WS ID: CZEMV7
UPDATE public.sailors SET dob = '2011-10-26' WHERE id = 'f0bbcf2a-1fc4-506d-9638-80edc2957e71'::uuid AND dob IS NULL;
-- Sebastian Samano (USA) - WS ID: USASS342
UPDATE public.sailors SET dob = '2010-10-30' WHERE id = 'cf238395-8247-47fd-3df9-c5a1060e9e8a'::uuid AND dob IS NULL;
-- Ernst Aakesson (SWE) - WS ID: SWEEA31
UPDATE public.sailors SET dob = '2010-03-24' WHERE id = 'd2a353a1-5d16-d84d-af2f-f0dfea7f56c1'::uuid AND dob IS NULL;
-- Lenno Leefmans (NED) - WS ID: NEDLL5
UPDATE public.sailors SET dob = '2009-09-07' WHERE id = '733b8679-e855-76d5-8210-b0d353602dca'::uuid AND dob IS NULL;
-- Sam Dence (GBR) - WS ID: GBRSD94
UPDATE public.sailors SET dob = '2011-06-17' WHERE id = '7a8865c4-23a3-3522-9788-2259152e88ba'::uuid AND dob IS NULL;
-- Dylan Thomley (USA) - WS ID: USADT98
UPDATE public.sailors SET dob = '2012-02-05' WHERE id = '0e9b28fe-e194-e8e1-6056-3551503770f3'::uuid AND dob IS NULL;
-- Emiliano Rodriguez Sanchez Huerta (MEX) - WS ID: MEXER5
UPDATE public.sailors SET dob = '2010-02-17' WHERE id = 'ddadfa0d-45c2-2dc8-4a27-d4e4978f1801'::uuid AND dob IS NULL;
-- Piet Baars (GER) - WS ID: GERPB55
UPDATE public.sailors SET dob = '2010-08-25' WHERE id = 'f4c08e6f-2a31-ffd1-641e-5f85096f3839'::uuid AND dob IS NULL;
-- Emil Schimanski (GER) - WS ID: GERES44
UPDATE public.sailors SET dob = '2011-04-24' WHERE id = '6d664a3d-2311-9128-8093-a1e2d17e484d'::uuid AND dob IS NULL;
-- Keanu Schadrack (GER) - WS ID: GERKS91
UPDATE public.sailors SET dob = '2011-02-12' WHERE id = 'ead80b7d-69e9-b6d4-ec72-4463c1c42975'::uuid AND dob IS NULL;
-- Branislav Opalka (SVK) - WS ID: SVKBO2
UPDATE public.sailors SET dob = '2010-12-13' WHERE id = 'c4abf09e-f99a-e8e2-ac7a-439d94b72510'::uuid AND dob IS NULL;
-- Jose Perez Biedermann (ESP) - WS ID: ESPJP129
UPDATE public.sailors SET dob = '2010-10-24' WHERE id = 'b0dddb56-624e-f4b5-e81a-809f5ace6ab0'::uuid AND dob IS NULL;
-- Li van Den Berg (NED) - WS ID: NEDLV51
UPDATE public.sailors SET dob = '2010-10-05' WHERE id = 'f76acb66-aaa6-2ced-33e6-caaa6802d55c'::uuid AND dob IS NULL;
-- Adriano Manfioletti (SUI) - WS ID: SUIAM190
UPDATE public.sailors SET dob = '2010-07-01' WHERE id = 'c44522d9-cd6f-4ca2-c011-1c8679d8c6b2'::uuid AND dob IS NULL;
-- Robin Wright (GBR) - WS ID: GBRRW131
UPDATE public.sailors SET dob = '2010-04-25' WHERE id = '42353e3e-6060-f84d-c6e7-e231b3c7da01'::uuid AND dob IS NULL;
-- Enzo Sain Adam (SUI) - WS ID: SUIES14
UPDATE public.sailors SET dob = '2010-12-06' WHERE id = '2688171b-1f4f-d674-e730-43c26ab8173a'::uuid AND dob IS NULL;
-- Gustaf Arvmyren (SWE) - WS ID: SWEGA10
UPDATE public.sailors SET dob = '2010-02-06' WHERE id = 'cafcea21-c8d0-12f1-1ead-35e36b9b83a9'::uuid AND dob IS NULL;
-- Dimitrios Papadopoulos (GRE) - WS ID: GREDP43
UPDATE public.sailors SET dob = '2012-01-11' WHERE id = 'e23e1826-f95f-0e54-bba0-9ffa59de30a8'::uuid AND dob IS NULL;
-- Leon Zarchan (BAH) - WS ID: BAHLZ1
UPDATE public.sailors SET dob = '2011-11-06' WHERE id = 'f303b27d-e840-1d7a-83d7-a557321c4a84'::uuid AND dob IS NULL;
-- Joshua Weinhardt (VIN) - WS ID: VINJW1
UPDATE public.sailors SET dob = '2012-01-26' WHERE id = 'b22901d3-a247-a2b5-e60c-43e2763b7928'::uuid AND dob IS NULL;
-- Daniel Beroun (CZE) - WS ID: CZEDB7
UPDATE public.sailors SET dob = '2009-02-06' WHERE id = 'eec7d6d4-abac-a16e-452c-9db10e98e3e3'::uuid AND dob IS NULL;
-- David Porzecanski (USA) - WS ID: USADP144
UPDATE public.sailors SET dob = '2011-03-24' WHERE id = 'acf3525c-ebd7-729a-1fb9-4fd85fceada2'::uuid AND dob IS NULL;
-- Julian Konrad Garbe (GER) - WS ID: GERJG56
UPDATE public.sailors SET dob = '2012-09-30' WHERE id = 'b66b65e6-dc2d-670e-cfe2-6d6eed358dc9'::uuid AND dob IS NULL;
-- Finlay Rhodes (GBR) - WS ID: GBRFR11
UPDATE public.sailors SET dob = '2012-10-03' WHERE id = 'cf17192b-f518-3cbe-79b5-09108a87b9c0'::uuid AND dob IS NULL;
-- Alex Butcher (IRL) - WS ID: IRLAB49
UPDATE public.sailors SET dob = '2012-03-14' WHERE id = 'c49a2ef5-4e45-b80f-01d2-8cf2a27107ea'::uuid AND dob IS NULL;
-- George Hunter (GBR) - WS ID: GBRGH64
UPDATE public.sailors SET dob = '2011-04-05' WHERE id = 'e1b79148-8775-b10b-3665-c92bb4044b2c'::uuid AND dob IS NULL;
-- Ahti Vehkamäki (FIN) - WS ID: FINAV10
UPDATE public.sailors SET dob = '2012-07-29' WHERE id = '336f1a7d-caba-f9de-804b-52208b206db5'::uuid AND dob IS NULL;
-- Miles Franck (BEL) - WS ID: BELMF3
UPDATE public.sailors SET dob = '2009-11-10' WHERE id = '16681d86-abc3-f1fe-8408-ad3a45e46d90'::uuid AND dob IS NULL;
-- John Kenny (IRL) - WS ID: IRLJK42
UPDATE public.sailors SET dob = '2010-12-16' WHERE id = '3eb6056c-7801-9fb2-e219-a2ea5a3211b8'::uuid AND dob IS NULL;
-- Marek Beroun (CZE) - WS ID: CZEMB12
UPDATE public.sailors SET dob = '2012-03-03' WHERE id = 'b94acf09-7320-da69-90bd-2aacbf0e2308'::uuid AND dob IS NULL;
-- Spencer Bergendahl (USA) - WS ID: USASB250
UPDATE public.sailors SET dob = '2009-08-10' WHERE id = '90838e14-4ddd-7dbe-254c-8777e675a61e'::uuid AND dob IS NULL;
-- Ethan Cox (USA) - WS ID: USAEC113
UPDATE public.sailors SET dob = '2011-01-07' WHERE id = '8421aa58-6709-3d65-8b22-d25d4fba2b80'::uuid AND dob IS NULL;
-- Max Ottosson (SWE) - WS ID: SWEMO14
UPDATE public.sailors SET dob = '2010-10-12' WHERE id = 'aa79bd9a-18b3-65a8-2e77-adc0970d9e6a'::uuid AND dob IS NULL;
-- Gregor Lerch (GER) - WS ID: GERGL11
UPDATE public.sailors SET dob = '2011-09-01' WHERE id = '9b20e178-e8b6-aebf-41f7-4acb7efe5ae9'::uuid AND dob IS NULL;
-- Ferdinand Buck-hansen (DEN) - WS ID: DENFB10
UPDATE public.sailors SET dob = '2011-10-27' WHERE id = 'ddc7e07d-7ccd-551b-fd9c-106d90077071'::uuid AND dob IS NULL;
-- James Crawford (IRL) - WS ID: IRLJC65
UPDATE public.sailors SET dob = '2010-10-13' WHERE id = '30351acf-84e0-75fb-dfd3-62764ff192cf'::uuid AND dob IS NULL;
-- Louis Albert Dumontier (CAN) - WS ID: CANLD14
UPDATE public.sailors SET dob = '2009-11-20' WHERE id = 'd52216e8-6ccd-10cf-8ee1-56749280ae45'::uuid AND dob IS NULL;
-- Abhijith Srinivasan (SKN) - WS ID: SKNAS1
UPDATE public.sailors SET dob = '2011-12-09' WHERE id = '325c2856-abf7-30cf-f775-a8a896ac566a'::uuid AND dob IS NULL;
-- Will Keys-batson (GBR) - WS ID: GBRWK9
UPDATE public.sailors SET dob = '2011-05-17' WHERE id = '9bde00b1-31fe-0f51-c6e2-0ebc155765fc'::uuid AND dob IS NULL;
-- Harris He (CAN) - WS ID: CANHH12
UPDATE public.sailors SET dob = '2011-02-21' WHERE id = '03ac7c40-1490-5267-a3da-d9982059ea59'::uuid AND dob IS NULL;
-- Nils Knoke (DEN) - WS ID: DENNK11
UPDATE public.sailors SET dob = '2010-02-19' WHERE id = '10adfbec-8d9a-cb3f-8f2f-49f78b8fd9be'::uuid AND dob IS NULL;
-- Filip Pátek (CZE) - WS ID: CZEFP3
UPDATE public.sailors SET dob = '2011-01-20' WHERE id = 'db076213-5c33-f8bd-713a-dba678ae15fa'::uuid AND dob IS NULL;
-- Esteban Texidor (PUR) - WS ID: PURET5
UPDATE public.sailors SET dob = '2011-01-15' WHERE id = '06807b40-3dea-69c2-3b1d-467c32810740'::uuid AND dob IS NULL;
-- Andrés Lomelí (MEX) - WS ID: MEXAL6
UPDATE public.sailors SET dob = '2011-03-04' WHERE id = '6dd4813d-f3dc-a19c-afbd-56df7e351d04'::uuid AND dob IS NULL;
-- Erik Olaf Beutling (GER) - WS ID: GEREB24
UPDATE public.sailors SET dob = '2011-04-29' WHERE id = '2d78664d-9128-6f7e-712f-1c6b7bb2321d'::uuid AND dob IS NULL;
-- Laurenz Engelke (GER) - WS ID: GERLE17
UPDATE public.sailors SET dob = '2011-10-23' WHERE id = '1b90be65-0406-bb90-79e5-95e02dad4de5'::uuid AND dob IS NULL;
-- Cary Wang (USA) - WS ID: USACW199
UPDATE public.sailors SET dob = '2009-01-09' WHERE id = '05169e4b-a362-04c9-6bcb-cf411f9b3628'::uuid AND dob IS NULL;
-- Vincent Busschodts (BEL) - WS ID: BELVB3
UPDATE public.sailors SET dob = '2011-07-27' WHERE id = '409d26a6-0bac-6124-bd5c-ba097b3d8f3e'::uuid AND dob IS NULL;
-- Jentel van Nieuwenhuyse Masset (BEL) - WS ID: BELJV34
UPDATE public.sailors SET dob = '2011-07-15' WHERE id = '0fd80987-9fd9-f16e-ebf4-812503073c1e'::uuid AND dob IS NULL;
-- Kasper Palmås (SWE) - WS ID: SWEKP3
UPDATE public.sailors SET dob = '2010-03-04' WHERE id = '0ee72246-af04-8c17-abff-48430aca5f7f'::uuid AND dob IS NULL;
-- Leonard Paul Müller (GER) - WS ID: GERLM46
UPDATE public.sailors SET dob = '2012-05-18' WHERE id = 'aafe8fcf-20e7-72cb-44aa-882e1ffa400d'::uuid AND dob IS NULL;
-- Blake Brown (GBR) - WS ID: GBRBB66
UPDATE public.sailors SET dob = '2012-06-19' WHERE id = '884bee79-97f3-cc42-04f4-073b0587a75b'::uuid AND dob IS NULL;
-- Augie Wise (USA) - WS ID: USAAW145
UPDATE public.sailors SET dob = '2013-08-09' WHERE id = '41ab840d-2cd2-0a2b-d89b-c500a25befa4'::uuid AND dob IS NULL;
-- Eleni Triantou (GRE) - WS ID: GREET18
UPDATE public.sailors SET dob = '2011-01-11' WHERE id = '1d414d0a-32dc-859d-4f25-8ad290036c73'::uuid AND dob IS NULL;
-- Blanca Ferrando Babe (ESP) - WS ID: ESPBF11
UPDATE public.sailors SET dob = '2009-11-04' WHERE id = 'e3eb5a2a-5945-4afc-45a6-272bf72d1b93'::uuid AND dob IS NULL;
-- Despoina Theodorakopoulou (GRE) - WS ID: GREDT24
UPDATE public.sailors SET dob = '2009-04-06' WHERE id = '3003c3ca-61b8-5db2-c482-078fb4a8c839'::uuid AND dob IS NULL;
-- Cassandra Jansch (GER) - WS ID: GERCJ16
UPDATE public.sailors SET dob = '2011-01-29' WHERE id = '0adab026-3bc3-70d6-3a9d-30d5a190eac0'::uuid AND dob IS NULL;
-- Alexandra Ivanova (CRO) - WS ID: CROAI1
UPDATE public.sailors SET dob = '2010-04-29' WHERE id = '5c4cc3cd-ecf5-1c85-8a9d-7cb48b77ca04'::uuid AND dob IS NULL;
-- Chloe Grayton (GBR) - WS ID: GBRCG71
UPDATE public.sailors SET dob = '2011-12-27' WHERE id = '7115c232-2618-3e1f-7d9b-dbf65b7ceefa'::uuid AND dob IS NULL;
-- Zala Sterni (ITA) - WS ID: ITAZS2
UPDATE public.sailors SET dob = '2009-09-18' WHERE id = 'acaae086-5eb9-fde1-e70b-9bb2596921b4'::uuid AND dob IS NULL;
-- Adele Ramm-ericson (SWE) - WS ID: SWEAR21
UPDATE public.sailors SET dob = '2009-12-05' WHERE id = '8773d99f-62ed-ba24-7621-1e3270ca83a2'::uuid AND dob IS NULL;
-- Derin Degisen (TUR) - WS ID: TURDD20
UPDATE public.sailors SET dob = '2009-09-28' WHERE id = '09de28f8-5f76-df28-8364-ca55a2eaa447'::uuid AND dob IS NULL;
-- Marina Garau I Sala (ESP) - WS ID: ESPMG103
UPDATE public.sailors SET dob = '2009-01-04' WHERE id = '70ffa5bb-8f94-04e7-bda4-44e921a862c4'::uuid AND dob IS NULL;
-- Ruby Carter (AUS) - WS ID: AUSRC58
UPDATE public.sailors SET dob = '2010-10-01' WHERE id = 'ff06770a-d0e1-53d5-415c-ca42dd65e12e'::uuid AND dob IS NULL;
-- Tanja Ozretić (CRO) - WS ID: CROTO1
UPDATE public.sailors SET dob = '2009-08-28' WHERE id = 'b1cf8bb0-2842-62f3-d21f-5d461ae26869'::uuid AND dob IS NULL;
-- Leah Bernhardtz (SWE) - WS ID: SWELB33
UPDATE public.sailors SET dob = '2009-06-13' WHERE id = '34026437-ce7a-0cc6-00ae-d5d3d85ecb9c'::uuid AND dob IS NULL;
-- Marta Ferrando Babe (ESP) - WS ID: ESPMF59
UPDATE public.sailors SET dob = '2011-04-04' WHERE id = '5a76fd6a-c7bb-6be2-50a5-7f06f59622af'::uuid AND dob IS NULL;
-- Tereza Chlumska (CZE) - WS ID: CZETC3
UPDATE public.sailors SET dob = '2010-05-24' WHERE id = '089769fa-f05d-f366-757d-6cc5ae227d96'::uuid AND dob IS NULL;
-- Giorgia Tumbarello (ITA) - WS ID: ITAGT110
UPDATE public.sailors SET dob = '2009-11-19' WHERE id = 'fe116bab-ac2e-3fcb-a854-a721ba093a5a'::uuid AND dob IS NULL;
-- Zixi Huang (HKG) - WS ID: HKGZH3
UPDATE public.sailors SET dob = '2011-11-10' WHERE id = 'e3ea45d8-9cd9-4bd0-98dc-58aa3e8aaeb9'::uuid AND dob IS NULL;
-- Ada Canuysal (TUR) - WS ID: TURAC23
UPDATE public.sailors SET dob = '2010-12-17' WHERE id = 'b7b2c5cb-0b30-d1b5-4166-8659702e9d8f'::uuid AND dob IS NULL;
-- Martina Corno (ITA) - WS ID: ITAMC360
UPDATE public.sailors SET dob = '2009-03-31' WHERE id = '5deee915-e01e-3f76-32fa-a14e51ba96bb'::uuid AND dob IS NULL;
-- Alba Maria Zardetto (ITA) - WS ID: ITAAZ54
UPDATE public.sailors SET dob = '2009-05-02' WHERE id = '34ee978f-d815-26e3-5c0c-9426d3a2bc66'::uuid AND dob IS NULL;
-- Mila Krum (LTU) - WS ID: LTUMK14
UPDATE public.sailors SET dob = '2011-01-14' WHERE id = '2d948411-768f-d56f-5def-aed7bdcf4e66'::uuid AND dob IS NULL;
-- Gabriela Mascarenhas (USA) - WS ID: USAGM126
UPDATE public.sailors SET dob = '2010-04-08' WHERE id = 'c4390bce-a686-0b5d-fc21-d3fe5e3c4c28'::uuid AND dob IS NULL;
-- Lara Rubini (PER) - WS ID: PERLR2
UPDATE public.sailors SET dob = '2009-06-17' WHERE id = '8c9458a8-583f-9360-3243-bc0472c61999'::uuid AND dob IS NULL;
-- Victoria Helene Loeck (GER) - WS ID: GERVL12
UPDATE public.sailors SET dob = '2010-08-01' WHERE id = 'bcfb55f7-6342-7098-21c0-5183625be6f8'::uuid AND dob IS NULL;
-- Margherita Giannantonio (ITA) - WS ID: ITAMG222
UPDATE public.sailors SET dob = '2011-07-15' WHERE id = 'fcb4ce4c-168d-b9ce-ac0b-d5d18ff2caae'::uuid AND dob IS NULL;
-- Louise Rahn (FRA) - WS ID: FRALR31
UPDATE public.sailors SET dob = '2009-12-28' WHERE id = 'bcbe4bc9-0e26-e063-70e9-25667e1fd80c'::uuid AND dob IS NULL;
-- Begoña Perez-manglano Sánchez (ESP) - WS ID: ESPBS17
UPDATE public.sailors SET dob = '2011-01-19' WHERE id = '33f8e64a-1c5c-f61b-6fb8-9cadb6db84b6'::uuid AND dob IS NULL;
-- Sara Maione (ITA) - WS ID: ITASM136
UPDATE public.sailors SET dob = '2009-12-22' WHERE id = '48a95245-91e6-cf39-3b76-9f6aff905ed9'::uuid AND dob IS NULL;
-- Zeynep Alpartun (TUR) - WS ID: TURZA3
UPDATE public.sailors SET dob = '2009-07-08' WHERE id = 'f3531ec0-5853-69c1-b530-655a67c5f0e9'::uuid AND dob IS NULL;
-- Iklim Ozcelik (TUR) - WS ID: TURIO9
UPDATE public.sailors SET dob = '2011-05-10' WHERE id = '86d6c892-aaab-3235-1d1f-4735b9954db5'::uuid AND dob IS NULL;
-- Sofia Bommartini (ITA) - WS ID: ITASB122
UPDATE public.sailors SET dob = '2009-04-14' WHERE id = 'c7ba9fc1-2821-7bf0-f6b5-cd23c8a873b7'::uuid AND dob IS NULL;
-- Milou van Kuilenburg (USA) - WS ID: USAMV67
UPDATE public.sailors SET dob = '2010-12-21' WHERE id = '68e6e0ca-0992-ec78-416c-6f303d4246f4'::uuid AND dob IS NULL;
-- Barbara Maruszczak (POL) - WS ID: POLBM15
UPDATE public.sailors SET dob = '2012-04-19' WHERE id = '66aa9fbf-725b-86ce-3670-3a87e3985a6b'::uuid AND dob IS NULL;
-- Livia Tavares Martini Quintas (BRA) - WS ID: BRALM57
UPDATE public.sailors SET dob = '2009-06-07' WHERE id = 'abc396f1-583d-4d7c-8238-81882ee6926e'::uuid AND dob IS NULL;
-- Kailee Moure (USA) - WS ID: USAKM210
UPDATE public.sailors SET dob = '2011-10-05' WHERE id = '45bfcb87-0e05-f50e-4700-36cfda7ee8e5'::uuid AND dob IS NULL;
-- Kateryna Filimonova (GER) - WS ID: UKRKF1
UPDATE public.sailors SET dob = '2010-02-03' WHERE id = '1df3c8e9-d659-ee4b-1ed7-3851c9952a3a'::uuid AND dob IS NULL;
-- Ginevra Natale (ITA) - WS ID: ITAGN53
UPDATE public.sailors SET dob = '2012-01-14' WHERE id = 'c5bf692f-0081-6613-bb89-ae3e69c200b3'::uuid AND dob IS NULL;
-- Eefje Lemmers (NED) - WS ID: NEDEL11
UPDATE public.sailors SET dob = '2010-08-27' WHERE id = '27c3e3bb-53a8-d4ee-8210-d7af805571b3'::uuid AND dob IS NULL;
-- Paloma Lopez de Silanes (FRA) - WS ID: FRAPL97
UPDATE public.sailors SET dob = '2009-10-28' WHERE id = 'dda97bd0-7169-4c3c-dbf6-aa25b3c164f1'::uuid AND dob IS NULL;
-- Samantha Axisa (MLT) - WS ID: MLTSA4
UPDATE public.sailors SET dob = '2011-06-27' WHERE id = '1b552d85-297f-ea1b-4493-461efae1da06'::uuid AND dob IS NULL;
-- Matilde Moules (POR) - WS ID: PORMM44
UPDATE public.sailors SET dob = '2009-06-04' WHERE id = 'a800f293-a5ec-1a99-1d98-c0b9a42799d7'::uuid AND dob IS NULL;
-- Ruby Coster (GBR) - WS ID: GBRRC130
UPDATE public.sailors SET dob = '2012-01-15' WHERE id = 'a09533fe-326f-0634-a3d8-c4362705281d'::uuid AND dob IS NULL;
-- Melissa Falica (ITA) - WS ID: ITAMF166
UPDATE public.sailors SET dob = '2011-11-19' WHERE id = 'abedc54b-2209-f95f-c838-b2f2d3d1a4f2'::uuid AND dob IS NULL;
-- Alexandra Bugacov (USA) - WS ID: USAAB286
UPDATE public.sailors SET dob = '2010-12-01' WHERE id = '09aeed26-1701-1ada-ad5f-6b6de0df060c'::uuid AND dob IS NULL;
-- Olivia Aitken (AUS) - WS ID: AUSOA3
UPDATE public.sailors SET dob = '2009-12-17' WHERE id = '1a03c067-51b3-1d4f-ccd3-79a9b482c429'::uuid AND dob IS NULL;
-- Arianna Anelli (ITA) - WS ID: ITAAA166
UPDATE public.sailors SET dob = '2010-07-11' WHERE id = 'd3a9fd4e-595b-78b4-8ce4-c79a673a6208'::uuid AND dob IS NULL;
-- Laura Matthiesen (GER) - WS ID: GERLM44
UPDATE public.sailors SET dob = '2011-03-30' WHERE id = 'b7bff5bd-a8c5-d989-8fed-e87e94e42333'::uuid AND dob IS NULL;
-- Mia Noritake (USA) - WS ID: USAMN84
UPDATE public.sailors SET dob = '2010-11-30' WHERE id = 'a647747e-c573-7046-6d51-18692fa5b675'::uuid AND dob IS NULL;
-- Amy Kieran (IRL) - WS ID: IRLAK25
UPDATE public.sailors SET dob = '2011-04-07' WHERE id = '6e2c9576-641e-3e0d-468a-b2b67f7e624e'::uuid AND dob IS NULL;
-- Isabella Wels (NED) - WS ID: NEDIW5
UPDATE public.sailors SET dob = '2010-08-18' WHERE id = '522ea66a-81df-aec7-4f6e-e19ca4ab78ae'::uuid AND dob IS NULL;
-- Barbora Ottova (CZE) - WS ID: CZEBO1
UPDATE public.sailors SET dob = '2009-06-05' WHERE id = '9d81f1f8-fcea-2db8-3440-d3d7ba0fb383'::uuid AND dob IS NULL;
-- Deniz Eraslan (TUR) - WS ID: TURDE9
UPDATE public.sailors SET dob = '2010-06-08' WHERE id = '999704ed-3859-5e8b-8816-a21950a859b4'::uuid AND dob IS NULL;
-- Clara Mattik (GER) - WS ID: GERCM75
UPDATE public.sailors SET dob = '2011-07-17' WHERE id = '5f4179e9-3fbd-f9a6-1441-12c4765d3baa'::uuid AND dob IS NULL;
-- Ugnè Trimonyte (LTU) - WS ID: LTUUT1
UPDATE public.sailors SET dob = '2010-05-07' WHERE id = 'a7930533-0c71-836b-ca28-71291e0d29f9'::uuid AND dob IS NULL;
-- Ebony Aloof (GBR) - WS ID: GBREA20
UPDATE public.sailors SET dob = '2009-08-11' WHERE id = 'b7b74dad-5373-1ba5-d9f9-22c3078e8911'::uuid AND dob IS NULL;
-- Ludovica Bancale (ITA) - WS ID: ITALB154
UPDATE public.sailors SET dob = '2011-02-14' WHERE id = '7d01fe46-f8ce-d6ba-88ac-f9f0d022a698'::uuid AND dob IS NULL;
-- Aria Miller (CAN) - WS ID: CANAM71
UPDATE public.sailors SET dob = '2011-12-01' WHERE id = 'cad8bd4c-1540-88a2-12ee-57a412219b9b'::uuid AND dob IS NULL;
-- Gali Romano (ISR) - WS ID: ISRGR4
UPDATE public.sailors SET dob = '2011-02-07' WHERE id = '9ae29446-cff1-941f-460b-dfada8ff3709'::uuid AND dob IS NULL;
-- Joanna Kaczmarska (POL) - WS ID: POLJK70
UPDATE public.sailors SET dob = '2013-10-01' WHERE id = '9f4921fe-6c00-38ae-79b7-74661812ebb8'::uuid AND dob IS NULL;
-- Alejandra Aldunate (CHI) - WS ID: CHIAA4
UPDATE public.sailors SET dob = '2009-03-02' WHERE id = '0539ccda-36d1-7030-ab2f-64b2dcd0e302'::uuid AND dob IS NULL;
-- Lale Sirin Goca (GER) - WS ID: GERLG41
UPDATE public.sailors SET dob = '2011-09-23' WHERE id = 'dcc00fca-b0de-f30d-49ca-918812545d5f'::uuid AND dob IS NULL;
-- Elsa Sellés Ferrándiz (ESP) - WS ID: ESPES17
UPDATE public.sailors SET dob = '2011-03-18' WHERE id = '96eda7ac-0ff0-62aa-8191-50d5edbc91bc'::uuid AND dob IS NULL;
-- Annemarie Siepmann (GER) - WS ID: GERAS130
UPDATE public.sailors SET dob = '2011-04-07' WHERE id = '51961964-efc6-e7bf-31f2-15703b8f54e9'::uuid AND dob IS NULL;
-- Lena Kasperczyk (POL) - WS ID: POLLK18
UPDATE public.sailors SET dob = '2011-09-14' WHERE id = 'f83a5a1a-5363-eac3-61af-728df68d87c2'::uuid AND dob IS NULL;
-- Meri Greenaway (GBR) - WS ID: GBRMG93
UPDATE public.sailors SET dob = '2010-12-22' WHERE id = 'bae7679d-8930-7cc6-b636-bcfe3360328d'::uuid AND dob IS NULL;
-- Marianna Orduña Biskupska (ESP) - WS ID: POLMB62
UPDATE public.sailors SET dob = '2011-05-05' WHERE id = '67e0c5ef-3e7d-1fd3-a166-cd698281735b'::uuid AND dob IS NULL;
-- Philippa Knights (GBR) - WS ID: GBRPK39
UPDATE public.sailors SET dob = '2011-08-01' WHERE id = 'fd5506de-d149-09fa-0954-aece85aa6e02'::uuid AND dob IS NULL;
-- Romina Vicent (ESP) - WS ID: ESPRV25
UPDATE public.sailors SET dob = '2011-06-27' WHERE id = '4c7c93b4-301f-7e2a-b562-2090a0578862'::uuid AND dob IS NULL;
-- Kurumi Iijima (JPN) - WS ID: JPNKI45
UPDATE public.sailors SET dob = '2010-12-16' WHERE id = '7026a48b-4801-6922-b0bf-095dd0134b83'::uuid AND dob IS NULL;
-- Ava Harris-scott (GBR) - WS ID: GBRAH188
UPDATE public.sailors SET dob = '2010-02-13' WHERE id = '901e88ee-89d0-dfbd-cb3e-ed0e8c6d23aa'::uuid AND dob IS NULL;
-- Mia Paoletti (ITA) - WS ID: ITAMP305
UPDATE public.sailors SET dob = '2012-09-21' WHERE id = '5df3a8e0-eb4b-019d-087b-157d0e02400f'::uuid AND dob IS NULL;
-- Elza Kristiana Reneslace (LAT) - WS ID: LATER3
UPDATE public.sailors SET dob = '2010-06-21' WHERE id = 'aa14074f-7f29-cb04-03d8-62b4729a3fa6'::uuid AND dob IS NULL;
-- Elena Perez-manglano Sanchez (ESP) - WS ID: ESPEP28
UPDATE public.sailors SET dob = '2011-01-19' WHERE id = '51384ccd-8de8-defa-97e1-bf878ed8327e'::uuid AND dob IS NULL;
-- Angela de Leo (MEX) - WS ID: MEXAD8
UPDATE public.sailors SET dob = '2011-08-22' WHERE id = 'e649d3c5-e975-62cc-5553-65fb58b499e3'::uuid AND dob IS NULL;
-- Elena Bazzoni (USA) - WS ID: USAEB161
UPDATE public.sailors SET dob = '2010-08-20' WHERE id = 'bbc6adfb-c34a-67ab-7214-91a71849ebdf'::uuid AND dob IS NULL;
-- Emma Feder (ISR) - WS ID: ISREF4
UPDATE public.sailors SET dob = '2012-02-08' WHERE id = 'fc5a0769-27af-2e97-7677-4526f9e187af'::uuid AND dob IS NULL;
-- Laura Cugalj (CRO) - WS ID: CROLC9
UPDATE public.sailors SET dob = '2010-12-29' WHERE id = '62852f6d-4845-bb38-0d9d-1f55bb11fe65'::uuid AND dob IS NULL;
-- Beatriz Caetano (POR) - WS ID: PORBC6
UPDATE public.sailors SET dob = '2009-10-14' WHERE id = '43a6db3a-3fdb-2594-3a89-d3a13963f88c'::uuid AND dob IS NULL;
-- Mila Gan (AUS) - WS ID: AUSMG62
UPDATE public.sailors SET dob = '2011-01-22' WHERE id = 'ce4342de-cec1-bc7d-553e-cb62f76e34ea'::uuid AND dob IS NULL;
-- Adela Prokopcova (SVK) - WS ID: SVKAP1
UPDATE public.sailors SET dob = '2009-04-20' WHERE id = '064a5bce-8e69-20ed-39eb-ef55ea878eb8'::uuid AND dob IS NULL;
-- Harper Spacey (AUS) - WS ID: AUSHS18
UPDATE public.sailors SET dob = '2009-10-11' WHERE id = '49a2d174-2a54-1543-08de-c43aa57fbf35'::uuid AND dob IS NULL;
-- Caroline Vikman (FIN) - WS ID: FINCV5
UPDATE public.sailors SET dob = '2010-09-22' WHERE id = 'a23df01c-889d-da51-549c-6d0ae2571356'::uuid AND dob IS NULL;
-- Kate Spain (IRL) - WS ID: IRLKS9
UPDATE public.sailors SET dob = '2010-06-10' WHERE id = '9a188e8e-f7c1-7aba-2851-87e9336c9f95'::uuid AND dob IS NULL;
-- Marit Durst (GER) - WS ID: GERMD49
UPDATE public.sailors SET dob = '2011-03-11' WHERE id = 'c5b67036-1bcc-851b-8c4f-3991e13731d3'::uuid AND dob IS NULL;
-- Amy Shelley (IRL) - WS ID: IRLAS16
UPDATE public.sailors SET dob = '2011-06-27' WHERE id = '276f4cd8-bef2-7f48-7498-df7c79a0942d'::uuid AND dob IS NULL;
-- Molly Kern (USA) - WS ID: USAMK201
UPDATE public.sailors SET dob = '2012-05-02' WHERE id = 'ebc5639f-e97d-c17b-3398-533b1db30041'::uuid AND dob IS NULL;
-- Isabella Hernández (PUR) - WS ID: PURIH1
UPDATE public.sailors SET dob = '2010-02-18' WHERE id = '1c3403dc-a9e0-ea18-4816-bb237589f1bc'::uuid AND dob IS NULL;
-- Emilia Seeck (FIN) - WS ID: FINES11
UPDATE public.sailors SET dob = '2011-08-05' WHERE id = '7d4059ab-e810-52f3-a94e-48f8894fceb1'::uuid AND dob IS NULL;
-- Victoria Nielsen (SWE) - WS ID: SWEVN3
UPDATE public.sailors SET dob = '2009-05-16' WHERE id = '6527a165-5e2b-20e2-32f0-953d0dc7174f'::uuid AND dob IS NULL;
-- Siiri Wiegand (FIN) - WS ID: FINSW4
UPDATE public.sailors SET dob = '2010-07-30' WHERE id = 'd18f8bfa-52e2-8f6b-b2e6-d78cfaf44e56'::uuid AND dob IS NULL;
-- Pia Hessen (NOR) - WS ID: NORPH18
UPDATE public.sailors SET dob = '2010-09-27' WHERE id = '8baa6992-2d32-1df1-fbbf-ed7bc4c1c704'::uuid AND dob IS NULL;
-- Teresa Soeiro (POR) - WS ID: PORTS9
UPDATE public.sailors SET dob = '2009-12-19' WHERE id = '0eb363bf-168f-0e68-d6ff-f0e0e7bc7b3f'::uuid AND dob IS NULL;
-- Kira Gremlitza (GER) - WS ID: GERKG21
UPDATE public.sailors SET dob = '2012-01-06' WHERE id = '2daab6e5-f4f8-fa6e-aa15-cb35e26e3ec8'::uuid AND dob IS NULL;
-- Eleni Vanparys (BEL) - WS ID: BELEV20
UPDATE public.sailors SET dob = '2009-12-25' WHERE id = 'e9982376-75b0-1bf5-58c3-cc2c210937c2'::uuid AND dob IS NULL;
-- Franziska Keil (GER) - WS ID: GERFK69
UPDATE public.sailors SET dob = '2011-05-24' WHERE id = '84a679c2-c78b-d3fa-f86c-8a473c5838f0'::uuid AND dob IS NULL;
-- Alma Lutter (GER) - WS ID: GERAL46
UPDATE public.sailors SET dob = '2012-05-11' WHERE id = '6ecf131f-6906-5f3b-7290-4c192f571a97'::uuid AND dob IS NULL;
-- Iga Kowalik (POL) - WS ID: POLIK10
UPDATE public.sailors SET dob = '2011-09-26' WHERE id = 'e3da550f-a18f-efa4-1cea-b8202d758d58'::uuid AND dob IS NULL;
-- Katrine Sennels (DEN) - WS ID: DENKS22
UPDATE public.sailors SET dob = '2011-01-11' WHERE id = 'ca4d2cb3-e065-dc1c-b2e8-8c0725ff0125'::uuid AND dob IS NULL;
-- Maddie Saladino (USA) - WS ID: USAMS434
UPDATE public.sailors SET dob = '2011-06-25' WHERE id = 'c002ea1b-27f5-8dee-589f-84398bec1b57'::uuid AND dob IS NULL;
-- Carla Schlonski (GER) - WS ID: GERCS122
UPDATE public.sailors SET dob = '2012-06-23' WHERE id = '654f61d8-e13a-dd65-d85f-4c3ec300f000'::uuid AND dob IS NULL;
-- Jessica Welch (GBR) - WS ID: GBRJW207
UPDATE public.sailors SET dob = '2009-05-01' WHERE id = '75d28385-0986-0474-18b7-672a93b61c6d'::uuid AND dob IS NULL;
-- Paula Tammemäe (EST) - WS ID: ESTPT5
UPDATE public.sailors SET dob = '2010-05-09' WHERE id = 'f8801765-28ee-3f2c-0f38-fbbb0fb454b2'::uuid AND dob IS NULL;
-- Jette Spee (NED) - WS ID: NEDJS52
UPDATE public.sailors SET dob = '2010-05-28' WHERE id = '63cfcec7-ed94-d72a-53a7-8c6e8729a47c'::uuid AND dob IS NULL;
-- Marion Smith (USA) - WS ID: USAMS432
UPDATE public.sailors SET dob = '2011-01-06' WHERE id = 'c71eddc8-c1fd-b7b6-985a-a1dfa153d0c5'::uuid AND dob IS NULL;
-- Anna Reimer (CAN) - WS ID: CANAR35
UPDATE public.sailors SET dob = '2009-02-08' WHERE id = '1278221a-40e7-d357-a5c0-4795f5404c5a'::uuid AND dob IS NULL;
-- Léonie Monleau (FRA) - WS ID: FRALM82
UPDATE public.sailors SET dob = '2011-04-27' WHERE id = 'eeca544c-a21b-d700-bea6-c76877f337fe'::uuid AND dob IS NULL;
-- Mia Acuña Carrión (MEX) - WS ID: MEXMA6
UPDATE public.sailors SET dob = '2010-11-16' WHERE id = 'f34dbee5-0001-a0e2-e295-91f8eb9f89bb'::uuid AND dob IS NULL;
-- Marwa Alhammadi (UAE) - WS ID: UAEMA36
UPDATE public.sailors SET dob = '2010-06-09' WHERE id = '157c0b9e-a4af-4e48-9429-1570688c6333'::uuid AND dob IS NULL;
-- Daniela Mayor (PHI) - WS ID: PHIDM1
UPDATE public.sailors SET dob = '2011-11-05' WHERE id = '7b927e81-db43-6629-1296-8e09329a33d5'::uuid AND dob IS NULL;
-- Mimi Langner (GER) - WS ID: GERML65
UPDATE public.sailors SET dob = '2012-08-04' WHERE id = 'a7360bbc-0be7-6b2c-319e-e419b696dd27'::uuid AND dob IS NULL;
-- Isabella Købke (DEN) - WS ID: DENIK1
UPDATE public.sailors SET dob = '2010-11-09' WHERE id = 'b0f4c0a3-ee33-b81f-86ce-fffbdd7ef58e'::uuid AND dob IS NULL;
-- Greta Bergenthal (GER) - WS ID: GERGB29
UPDATE public.sailors SET dob = '2009-02-03' WHERE id = '80f572d7-ab1e-5fdd-a5f3-1e8fc069b48d'::uuid AND dob IS NULL;
-- Faith Turner (GBR) - WS ID: GBRFT12
UPDATE public.sailors SET dob = '2010-09-28' WHERE id = '1809e094-c961-f447-6653-f2078003c578'::uuid AND dob IS NULL;
-- Addison Greenwood (AUS) - WS ID: AUSAG48
UPDATE public.sailors SET dob = '2010-09-27' WHERE id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812'::uuid AND dob IS NULL;
-- Sienna Jones (BAH) - WS ID: BAHSJ1
UPDATE public.sailors SET dob = '2009-11-02' WHERE id = '919483ca-b618-9238-451c-00c5b011d611'::uuid AND dob IS NULL;
-- Flora Cole (USA) - WS ID: USAFC38
UPDATE public.sailors SET dob = '2010-02-05' WHERE id = '44617b68-1560-2d82-4fa8-6dfabc12d741'::uuid AND dob IS NULL;
-- Luzia Ender (GER) - WS ID: GERLE16
UPDATE public.sailors SET dob = '2012-05-07' WHERE id = 'e3f81bf1-b0a4-6add-99c0-e5b560bd67ae'::uuid AND dob IS NULL;
-- Elisabeth Michel (USA) - WS ID: USAEM145
UPDATE public.sailors SET dob = '2010-07-09' WHERE id = 'c2b832e0-cec9-35c4-eacd-b72a7e1c29f0'::uuid AND dob IS NULL;
-- Amanda Lamont (CAN) - WS ID: CANAL52
UPDATE public.sailors SET dob = '2009-11-08' WHERE id = 'db65bc16-a110-f29b-f29b-301c50089a63'::uuid AND dob IS NULL;
-- Bigna Mäder (SUI) - WS ID: SUIBM12
UPDATE public.sailors SET dob = '2011-06-13' WHERE id = '84b0a661-e8f3-a9c8-884d-0b9917602a23'::uuid AND dob IS NULL;
-- Lauma Riekstina (LAT) - WS ID: LATLR3
UPDATE public.sailors SET dob = '2010-09-26' WHERE id = 'e9a1d70a-ba49-4f78-492f-55b958e178ee'::uuid AND dob IS NULL;
-- Gemma Ziervogel (GER) - WS ID: GERGZ3
UPDATE public.sailors SET dob = '2012-11-18' WHERE id = '2d1932c4-c844-c948-941a-d5ec349adf71'::uuid AND dob IS NULL;
-- Anna Samsioe (SWE) - WS ID: SWEAS41
UPDATE public.sailors SET dob = '2011-04-14' WHERE id = '301e763e-5537-26ee-3b15-54eaffba3124'::uuid AND dob IS NULL;
-- Annalisa Gilardi (SUI) - WS ID: SUIAG26
UPDATE public.sailors SET dob = '2009-04-09' WHERE id = 'deefe768-414e-e72d-a90a-beb932371a3c'::uuid AND dob IS NULL;
-- Martha Frölén (SWE) - WS ID: SWEMF22
UPDATE public.sailors SET dob = '2009-01-28' WHERE id = '678b18f1-ce5c-f67b-33e0-ee5461a5c1ac'::uuid AND dob IS NULL;
-- Oliva Skytte (DEN) - WS ID: DENOS4
UPDATE public.sailors SET dob = '2011-02-07' WHERE id = '3c98d387-e05e-a2af-2986-9fdc7dcd9b74'::uuid AND dob IS NULL;
-- Maja Giak (NOR) - WS ID: NORMG13
UPDATE public.sailors SET dob = '2009-05-24' WHERE id = '9e1fcf15-a182-59b9-3ced-43de23b7f078'::uuid AND dob IS NULL;

-- 3. Synchronize regatta_results.birth_year
UPDATE public.regatta_results rr
SET birth_year = EXTRACT(YEAR FROM s.dob)::integer
FROM public.sailors s
WHERE rr.sailor_id = s.id
  AND s.dob IS NOT NULL
  AND (rr.birth_year IS NULL OR rr.birth_year != EXTRACT(YEAR FROM s.dob)::integer);

COMMIT;
