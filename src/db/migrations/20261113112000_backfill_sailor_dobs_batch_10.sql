-- Migration: Backfill sailor date of birth (Batch 10 - World Sailing Registry)
-- Total verified sailors: 505
-- Corroboration: Official World Sailing Athlete Registry via World Sailing Datafeed API
-- Precision guarantee: Strict country code and name token alignment. Non-overwriting (WHERE dob IS NULL).

BEGIN;

-- Gino Pichetti (ARG) -> World Sailing: Gino Pichetti [ARGGP17] | DOB: 2011-01-03
UPDATE public.sailors SET dob = '2011-01-03' WHERE id = 'b1f00db6-e02c-5c87-832c-23b813cef366'::uuid AND dob IS NULL;
-- Adelaide O''Donoghue (AUS) -> World Sailing: Adelaide O''Donoghue [AUSAO14] | DOB: 2006-09-08
UPDATE public.sailors SET dob = '2006-09-08' WHERE id = '5932ee8c-7887-526e-91f4-bf994aec32bd'::uuid AND dob IS NULL;
-- Aidan Simmons (AUS) -> World Sailing: Aidan Simmons [AUSAS86] | DOB: 2007-12-26
UPDATE public.sailors SET dob = '2007-12-26' WHERE id = 'b9e3a54d-35ee-5e5a-9df2-0733ad07ad53'::uuid AND dob IS NULL;
-- Alana HARRISON (AUS) -> World Sailing: Alana Harrison [AUSAH77] | DOB: 2011-12-28
UPDATE public.sailors SET dob = '2011-12-28' WHERE id = 'f8b30de7-c14e-5da4-9f8c-90c2cd61aa1b'::uuid AND dob IS NULL;
-- Alastair Kernaghan (AUS) -> World Sailing: alastair kernaghan [AUSAK35] | DOB: 2011-04-05
UPDATE public.sailors SET dob = '2011-04-05' WHERE id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9'::uuid AND dob IS NULL;
-- Alexander BURDETT (AUS) -> World Sailing: Alexander Burdett [AUSAB92] | DOB: 2011-10-31
UPDATE public.sailors SET dob = '2011-10-31' WHERE id = 'e94714af-6dde-5000-8b06-b85a2d87c404'::uuid AND dob IS NULL;
-- Alexander Macpherson (AUS) -> World Sailing: Alexander MacPherson [AUSAM112] | DOB: 2008-12-02
UPDATE public.sailors SET dob = '2008-12-02' WHERE id = '560c8435-71fe-5510-b7a8-d7b8dd28cac3'::uuid AND dob IS NULL;
-- Alice Travlos (AUS) -> World Sailing: Alice Travlos [AUSAT34] | DOB: 2008-07-14
UPDATE public.sailors SET dob = '2008-07-14' WHERE id = '9346e9e0-9710-5750-a8ba-aef360915dca'::uuid AND dob IS NULL;
-- Andy Allt-Graham (AUS) -> World Sailing: Andy Allt-graham [AUSAA27] | DOB: 2009-09-17
UPDATE public.sailors SET dob = '2009-09-17' WHERE id = '81fcced4-6ca3-54d1-82c4-3c37f45f706b'::uuid AND dob IS NULL;
-- Angus KEDDIE (AUS) -> World Sailing: Angus Keddie [AUSAK32] | DOB: 2013-12-15
UPDATE public.sailors SET dob = '2013-12-15' WHERE id = 'fecf8f46-3610-5eed-8fe6-a917cc6d0660'::uuid AND dob IS NULL;
-- Annabelle Sampson (AUS) -> World Sailing: annabelle sampson [AUSAS93] | DOB: 2009-05-03
UPDATE public.sailors SET dob = '2009-05-03' WHERE id = 'fa4f83f1-7f42-5257-815c-ad62f803cd11'::uuid AND dob IS NULL;
-- Archie Mcquillen (AUS) -> World Sailing: Archie McQuillen [AUSAM106] | DOB: 2012-02-12
UPDATE public.sailors SET dob = '2012-02-12' WHERE id = '1df827c0-2382-44b6-a361-ce6becf2bdcd'::uuid AND dob IS NULL;
-- Argon Palmer (AUS) -> World Sailing: Argon Palmer [AUSAP53] | DOB: 2008-08-05
UPDATE public.sailors SET dob = '2008-08-05' WHERE id = 'dc9afb5f-4f17-5c3e-ade0-7bedb6c0b108'::uuid AND dob IS NULL;
-- Ash Napper (AUS) -> World Sailing: Ash Napper [AUSAN20] | DOB: 2010-06-17
UPDATE public.sailors SET dob = '2010-06-17' WHERE id = 'fa1ca3ae-8d43-5a4e-ad83-440a55838ee2'::uuid AND dob IS NULL;
-- Ashlea Tan (AUS) -> World Sailing: Ashlea Tan [AUSAT38] | DOB: 2010-02-20
UPDATE public.sailors SET dob = '2010-02-20' WHERE id = '7444930d-cadc-56aa-8674-8a72fc595fc0'::uuid AND dob IS NULL;
-- Atlas Miller (AUS) -> World Sailing: Atlas Miller [AUSAM97] | DOB: 2010-01-14
UPDATE public.sailors SET dob = '2010-01-14' WHERE id = 'abf791c2-8de8-5603-9304-48a1eaa36338'::uuid AND dob IS NULL;
-- Atticus Tan (AUS) -> World Sailing: Atticus Tan [AUSAT39] | DOB: 2008-10-10
UPDATE public.sailors SET dob = '2008-10-10' WHERE id = '63f933e0-6a60-55fb-b4af-22655d5c18e6'::uuid AND dob IS NULL;
-- Augustas Buividas (AUS) -> World Sailing: Augustas Buividas [AUSAB94] | DOB: 2009-12-14
UPDATE public.sailors SET dob = '2009-12-14' WHERE id = '7f65ccce-144b-4c72-9b6d-550043029b69'::uuid AND dob IS NULL;
-- Austin Higgins (AUS) -> World Sailing: Austin Higgins [AUSAH84] | DOB: 2007-03-24
UPDATE public.sailors SET dob = '2007-03-24' WHERE id = '204ec49b-39ff-53d9-bb39-e1891d13b0a8'::uuid AND dob IS NULL;
-- Beau McGilvray (AUS) -> World Sailing: Beau McGilvray [AUSBM54] | DOB: 2013-04-03
UPDATE public.sailors SET dob = '2013-04-03' WHERE id = 'eecd6289-95c4-52df-aad7-c448c1f87d7a'::uuid AND dob IS NULL;
-- Bentley O''Sullivan (AUS) -> World Sailing: Bentley O''Sullivan [AUSBO12] | DOB: 2010-11-21
UPDATE public.sailors SET dob = '2010-11-21' WHERE id = 'e01674c0-6b49-5ef6-ad1d-6ae769676c6c'::uuid AND dob IS NULL;
-- Caelan Byrt (AUS) -> World Sailing: Caelan Byrt [AUSCB70] | DOB: 2007-09-21
UPDATE public.sailors SET dob = '2007-09-21' WHERE id = '4dc3441d-98ec-5902-a2e1-da489f634193'::uuid AND dob IS NULL;
-- Caitlin Shaw (AUS) -> World Sailing: Caitlin Shaw [AUSCS53] | DOB: 2001-05-27
UPDATE public.sailors SET dob = '2001-05-27' WHERE id = 'f22ace1a-c1db-50c7-9c09-1c001e685db1'::uuid AND dob IS NULL;
-- Caleb McCarthy (AUS) -> World Sailing: Caleb McCarthy [AUSCM65] | DOB: 2017-07-02
UPDATE public.sailors SET dob = '2017-07-02' WHERE id = '0ffd03e1-cd9b-5ef7-b8e6-e650960caae6'::uuid AND dob IS NULL;
-- Calin Went (AUS) -> World Sailing: Calin Went [AUSCW61] | DOB: 2010-04-03
UPDATE public.sailors SET dob = '2010-04-03' WHERE id = 'e1bc4653-0eca-52c3-9bea-655cd4e398e3'::uuid AND dob IS NULL;
-- Callum Simmons (AUS) -> World Sailing: Callum Simmons [AUSCS74] | DOB: 2009-11-01
UPDATE public.sailors SET dob = '2009-11-01' WHERE id = '469939e8-2215-51ea-afa9-bbc6d1157143'::uuid AND dob IS NULL;
-- Cate Mccoy (AUS) -> World Sailing: Cate McCoy [AUSCM62] | DOB: 2007-08-03
UPDATE public.sailors SET dob = '2007-08-03' WHERE id = '8df00974-6881-5a8e-b674-ae1baa36e61c'::uuid AND dob IS NULL;
-- Caterina Meyer (AUS) -> World Sailing: Caterina Meyer [AUSCM55] | DOB: 2008-03-12
UPDATE public.sailors SET dob = '2008-03-12' WHERE id = 'ea191ba9-cbf0-5fb3-8818-c750df27f300'::uuid AND dob IS NULL;
-- Celina Trinh (AUS) -> World Sailing: Celina Trinh [AUSCT35] | DOB: 2011-08-05
UPDATE public.sailors SET dob = '2011-08-05' WHERE id = '6e259f62-b106-565f-8e3a-1676eee7c5f4'::uuid AND dob IS NULL;
-- Charles O''Kane (AUS) -> World Sailing: Charles O''Kane [AUSCO14] | DOB: 2009-07-20
UPDATE public.sailors SET dob = '2009-07-20' WHERE id = 'b813abaf-48e2-5af9-b941-5088c73691b0'::uuid AND dob IS NULL;
-- Charles Toyn (AUS) -> World Sailing: Charles Toyn [AUSCT30] | DOB: 2006-11-17
UPDATE public.sailors SET dob = '2006-11-17' WHERE id = '439dfc05-d7d5-50ca-b33b-0ddd13e28a8d'::uuid AND dob IS NULL;
-- Charlotte Kratz (AUS) -> World Sailing: Charlotte Kratz [AUSCK20] | DOB: 2011-08-10
UPDATE public.sailors SET dob = '2011-08-10' WHERE id = 'c18ae950-df89-5f53-a89e-995adac6b936'::uuid AND dob IS NULL;
-- Cordelia Davey (AUS) -> World Sailing: Cordelia Davey [AUSCD39] | DOB: 2010-10-13
UPDATE public.sailors SET dob = '2010-10-13' WHERE id = '7aef598e-4e70-5197-8723-f86ea8c9c571'::uuid AND dob IS NULL;
-- Darcy Brinkmann-Gray (AUS) -> World Sailing: Darcy Brinkmann-Gray [AUSDB83] | DOB: 2010-02-15
UPDATE public.sailors SET dob = '2010-02-15' WHERE id = '5bbc268e-2f64-5021-94f3-1f7f668549c9'::uuid AND dob IS NULL;
-- Darcy Higgins (AUS) -> World Sailing: Darcy Higgins [AUSDH72] | DOB: 2009-10-18
UPDATE public.sailors SET dob = '2009-10-18' WHERE id = '1fb2f059-b733-5654-a875-7579d6267cd5'::uuid AND dob IS NULL;
-- Digby Taylor (AUS) -> World Sailing: Digby Taylor [AUSDT39] | DOB: 2007-05-17
UPDATE public.sailors SET dob = '2007-05-17' WHERE id = '54939adf-f6db-55b1-aed7-a88a3aaf6a89'::uuid AND dob IS NULL;
-- Eddie Cleverly (AUS) -> World Sailing: Eddie Cleverly [AUSEC32] | DOB: 2010-10-01
UPDATE public.sailors SET dob = '2010-10-01' WHERE id = 'ff6cfae4-b54d-5c85-9536-fe393faeb0e8'::uuid AND dob IS NULL;
-- Edward Alexander (AUS) -> World Sailing: Edward Alexander [AUSEA9] | DOB: 2007-09-04
UPDATE public.sailors SET dob = '2007-09-04' WHERE id = '29d79e10-6424-5ab6-96ff-a2cbd84f8bae'::uuid AND dob IS NULL;
-- Edward Johannessen (AUS) -> World Sailing: Edward Johannessen [AUSEJ3] | DOB: 2009-08-10
UPDATE public.sailors SET dob = '2009-08-10' WHERE id = '7b776d1a-0195-5e12-92f8-841ff8f8e15f'::uuid AND dob IS NULL;
-- Eliska van der Veen (AUS) -> World Sailing: Eliska van der Veen [AUSEV3] | DOB: 2010-04-11
UPDATE public.sailors SET dob = '2010-04-11' WHERE id = '7e4d9798-8cca-57e8-bf4b-4da631568fa1'::uuid AND dob IS NULL;
-- Ellen Sampson (AUS) -> World Sailing: Ellen Sampson [AUSES16] | DOB: 2007-10-09
UPDATE public.sailors SET dob = '2007-10-09' WHERE id = '55328c1d-cb80-516e-b5cb-d4c605b13a8a'::uuid AND dob IS NULL;
-- Eloise Chernoff (AUS) -> World Sailing: ELOISE CHERNOFF [AUSEC30] | DOB: 2010-01-18
UPDATE public.sailors SET dob = '2010-01-18' WHERE id = '3b09bbca-acba-5d35-ae13-e5ae6ab60a37'::uuid AND dob IS NULL;
-- Elouise Morgan (AUS) -> World Sailing: elouise morgan [AUSEM25] | DOB: 2008-06-17
UPDATE public.sailors SET dob = '2008-06-17' WHERE id = 'eac3e33d-9cec-583d-80cb-395c8d7a7edd'::uuid AND dob IS NULL;
-- Elspeth Clifford (AUS) -> World Sailing: Elspeth Clifford [AUSEC34] | DOB: 2011-05-12
UPDATE public.sailors SET dob = '2011-05-12' WHERE id = '004c973c-d86e-5802-beb3-a7c64cb6acc5'::uuid AND dob IS NULL;
-- Elysia Albery (AUS) -> World Sailing: Elysia Albery [AUSEA10] | DOB: 2008-11-05
UPDATE public.sailors SET dob = '2008-11-05' WHERE id = '18b535e7-6b39-5cf5-80b7-2a69feb1e80d'::uuid AND dob IS NULL;
-- Emerald Jacobsen (AUS) -> World Sailing: Emerald Jacobsen [AUSEJ2] | DOB: 2012-01-20
UPDATE public.sailors SET dob = '2012-01-20' WHERE id = '6e620e7e-5678-525f-8760-caaacf2266a9'::uuid AND dob IS NULL;
-- Emily Armitstead (AUS) -> World Sailing: Emily Armitstead [AUSEA12] | DOB: 2010-11-08
UPDATE public.sailors SET dob = '2010-11-08' WHERE id = '214f5a87-ddc9-58e0-86a2-22353c891a36'::uuid AND dob IS NULL;
-- Ethan Wilkinson (AUS) -> World Sailing: Ethan Wilkinson [AUSEW15] | DOB: 2011-06-03
UPDATE public.sailors SET dob = '2011-06-03' WHERE id = '75d11452-5b81-5de3-9776-14179aa88951'::uuid AND dob IS NULL;
-- Evie Saunders (AUS) -> World Sailing: Evie Saunders [AUSES12] | DOB: 2005-08-30
UPDATE public.sailors SET dob = '2005-08-30' WHERE id = 'c5eb8987-b420-5cc1-8dc3-bf39aa4fbc9c'::uuid AND dob IS NULL;
-- Finley Symonds (AUS) -> World Sailing: Finley symonds [AUSFS11] | DOB: 2009-11-09
UPDATE public.sailors SET dob = '2009-11-09' WHERE id = '8198dd01-ace2-5c18-b21e-0f108ca58d10'::uuid AND dob IS NULL;
-- Finn Buckley (AUS) -> World Sailing: Finn Buckley [AUSFB12] | DOB: 2002-02-16
UPDATE public.sailors SET dob = '2002-02-16' WHERE id = '4f67db59-425d-57d3-afa8-4e3bf35c3ff3'::uuid AND dob IS NULL;
-- Finn Walker (AUS) -> World Sailing: FINN WALKER [AUSFW10] | DOB: 2012-02-01
UPDATE public.sailors SET dob = '2012-02-01' WHERE id = '37790a47-efee-47f0-a6d3-fe96f8dd67ac'::uuid AND dob IS NULL;
-- Fletcher Morse (AUS) -> World Sailing: Fletcher Morse [AUSFM4] | DOB: 2008-06-20
UPDATE public.sailors SET dob = '2008-06-20' WHERE id = '9d795e20-865b-54b7-9285-510d54261ce5'::uuid AND dob IS NULL;
-- Frances Gibson (AUS) -> World Sailing: Frances Gibson [AUSFG9] | DOB: 2010-11-23
UPDATE public.sailors SET dob = '2010-11-23' WHERE id = '46e12d7c-229a-5cf9-8654-bc400609fc13'::uuid AND dob IS NULL;
-- Francesca Del Favero (AUS) -> World Sailing: Francesca Del Favero [AUSFD7] | DOB: 2011-09-10
UPDATE public.sailors SET dob = '2011-09-10' WHERE id = '33cb97ea-b645-52fc-822b-9e4d2d8c2f81'::uuid AND dob IS NULL;
-- Fraser Baker (AUS) -> World Sailing: Fraser Baker [AUSFB13] | DOB: 2009-05-27
UPDATE public.sailors SET dob = '2009-05-27' WHERE id = '5f3ccfc2-191c-5c24-bc07-d2f12f895671'::uuid AND dob IS NULL;
-- Gary McLennan (AUS) -> World Sailing: Gary McLennan [AUSGM46] | DOB: 1961-09-01
UPDATE public.sailors SET dob = '1961-09-01' WHERE id = '22c6ad0b-54bc-54fc-af03-e2739dc7665d'::uuid AND dob IS NULL;
-- Glenn Beebe (AUS) -> World Sailing: Glenn Beebe [AUSGB53] | DOB: 1965-02-20
UPDATE public.sailors SET dob = '1965-02-20' WHERE id = 'b9e0129c-a727-5153-a738-003c299dff0d'::uuid AND dob IS NULL;
-- Goro Tomishima (AUS) -> World Sailing: Goro Tomishima [AUSGT21] | DOB: 2010-02-19
UPDATE public.sailors SET dob = '2010-02-19' WHERE id = 'a6b4e58d-fbba-5f54-9d91-ea3336356cf4'::uuid AND dob IS NULL;
-- Grace STORY (AUS) -> World Sailing: Grace Story [AUSGS59] | DOB: 2012-12-10
UPDATE public.sailors SET dob = '2012-12-10' WHERE id = '91ff9d94-adc9-57f1-8fce-325e443bf374'::uuid AND dob IS NULL;
-- Grady Sayers (AUS) -> World Sailing: Grady Sayers [AUSGS55] | DOB: 2007-10-16
UPDATE public.sailors SET dob = '2007-10-16' WHERE id = '0eebc696-d6e4-57c7-9249-99f72e3d72d8'::uuid AND dob IS NULL;
-- Hamish Crabb (AUS) -> World Sailing: Hamish Crabb [AUSHC12] | DOB: 2008-04-08
UPDATE public.sailors SET dob = '2008-04-08' WHERE id = 'c312a763-dc4b-5e27-8a00-b6152362fd33'::uuid AND dob IS NULL;
-- Hamish Skelton (AUS) -> World Sailing: Hamish Skelton [AUSHS16] | DOB: 2012-06-22
UPDATE public.sailors SET dob = '2012-06-22' WHERE id = '32fbb190-a161-5777-b3b3-b9b594afd9ef'::uuid AND dob IS NULL;
-- Harriet Behrens (AUS) -> World Sailing: Harriet Behrens [AUSHB20] | DOB: 2012-12-17
UPDATE public.sailors SET dob = '2012-12-17' WHERE id = '3e8649b1-935e-436e-b72a-510dba915078'::uuid AND dob IS NULL;
-- Harrison Gehrke (AUS) -> World Sailing: Harrison Gehrke [AUSHG7] | DOB: 2012-03-12
UPDATE public.sailors SET dob = '2012-03-12' WHERE id = '979e5981-e04c-51bb-aa14-02563e9ad078'::uuid AND dob IS NULL;
-- Harry Pilkington (AUS) -> World Sailing: Harry Pilkington [AUSHP8] | DOB: 2009-04-27
UPDATE public.sailors SET dob = '2009-04-27' WHERE id = '360387e8-85ab-57f2-a4c7-ea887bbe07db'::uuid AND dob IS NULL;
-- Healy Ryan (AUS) -> World Sailing: Healy Ryan [AUSHR10] | DOB: 2009-01-04
UPDATE public.sailors SET dob = '2009-01-04' WHERE id = 'feb6f782-9522-5185-a89d-532a1353e703'::uuid AND dob IS NULL;
-- Heath Jones (AUS) -> World Sailing: Heath Jones [AUSHJ12] | DOB: 2009-01-22
UPDATE public.sailors SET dob = '2009-01-22' WHERE id = '4fbcae61-3fe9-5c67-b60d-fb8be25bdf37'::uuid AND dob IS NULL;
-- Heidi Bates (AUS) -> World Sailing: Heidi Bates [AUSHB19] | DOB: 2008-09-24
UPDATE public.sailors SET dob = '2008-09-24' WHERE id = '3e67d0f9-dee0-5803-a4eb-bf98e18c734e'::uuid AND dob IS NULL;
-- Henri Levenspiel (AUS) -> World Sailing: Henri Levenspiel [AUSHL14] | DOB: 2009-06-02
UPDATE public.sailors SET dob = '2009-06-02' WHERE id = 'bd36fa38-3d39-5440-9c12-df5604a63c69'::uuid AND dob IS NULL;
-- Henry Campbell (AUS) -> World Sailing: Henry Campbell [AUSHC14] | DOB: 2012-05-05
UPDATE public.sailors SET dob = '2012-05-05' WHERE id = 'b4522674-e289-551e-bdc3-136bf47f62c6'::uuid AND dob IS NULL;
-- Henry Li (AUS) -> World Sailing: Henry Li [AUSHL15] | DOB: 2012-10-27
UPDATE public.sailors SET dob = '2012-10-27' WHERE id = '8ad6d5b8-855d-5580-8b02-495e5419f434'::uuid AND dob IS NULL;
-- Henry Mcquillen (AUS) -> World Sailing: Henry McQuillen [AUSHM25] | DOB: 2009-08-28
UPDATE public.sailors SET dob = '2009-08-28' WHERE id = '9b54bc2d-924d-5f5f-b7f7-39872371c754'::uuid AND dob IS NULL;
-- Henry Myers (AUS) -> World Sailing: Henry Myers [AUSHM19] | DOB: 2007-05-23
UPDATE public.sailors SET dob = '2007-05-23' WHERE id = '96d8f9b2-4473-54dc-909e-fa4c2ab89488'::uuid AND dob IS NULL;
-- Henry Piggott (AUS) -> World Sailing: Henry Piggott [AUSHP5] | DOB: 2009-02-07
UPDATE public.sailors SET dob = '2009-02-07' WHERE id = '120ba651-a311-5d92-8686-85ccc90e2c3f'::uuid AND dob IS NULL;
-- Henry Turner (AUS) -> World Sailing: Henry Turner [AUSHT9] | DOB: 2011-05-17
UPDATE public.sailors SET dob = '2011-05-17' WHERE id = 'f4e42acf-1ee8-5e76-8a8b-d599aa3f98fe'::uuid AND dob IS NULL;
-- Hiro Jacobsen (AUS) -> World Sailing: Hiro Jacobsen [AUSHJ11] | DOB: 2010-07-24
UPDATE public.sailors SET dob = '2010-07-24' WHERE id = '07344ea1-1ecc-552c-bbf8-9e2f502e579f'::uuid AND dob IS NULL;
-- Hugh Healy (AUS) -> World Sailing: Hugh Healy [AUSHH21] | DOB: 2009-07-02
UPDATE public.sailors SET dob = '2009-07-02' WHERE id = '349d2aaf-38ba-5138-97e9-5cee69c510bb'::uuid AND dob IS NULL;
-- Huon Jones (AUS) -> World Sailing: Huon Jones [AUSHJ10] | DOB: 2014-01-31
UPDATE public.sailors SET dob = '2014-01-31' WHERE id = '6732309a-18bb-5161-b260-d1e99b94e4dc'::uuid AND dob IS NULL;
-- Huon Williams (AUS) -> World Sailing: Huon Williams [AUSHW15] | DOB: 2008-11-22
UPDATE public.sailors SET dob = '2008-11-22' WHERE id = 'b953361a-07e9-5476-b78b-81e8b1c41679'::uuid AND dob IS NULL;
-- Iris Beebe (AUS) -> World Sailing: Iris Beebe [AUSIB16] | DOB: 2007-07-25
UPDATE public.sailors SET dob = '2007-07-25' WHERE id = '39efba31-ad63-58d3-8666-a09ac59206ce'::uuid AND dob IS NULL;
-- Isaac Archer (AUS) -> World Sailing: Isaac Archer [AUSIA5] | DOB: 2010-12-23
UPDATE public.sailors SET dob = '2010-12-23' WHERE id = '648e9900-3772-5c6e-a162-d993f6cbb123'::uuid AND dob IS NULL;
-- Isaac Schotte (AUS) -> World Sailing: Isaac Schotte [AUSIS14] | DOB: 2005-06-05
UPDATE public.sailors SET dob = '2005-06-05' WHERE id = '3f4073e1-ee94-55e4-b20a-15194d6ad81f'::uuid AND dob IS NULL;
-- Isabella Lozevski (AUS) -> World Sailing: Isabella Lozevski [AUSIL9] | DOB: 2008-11-04
UPDATE public.sailors SET dob = '2008-11-04' WHERE id = '4d0ce9b2-543b-5f0d-a3b2-555fddfa5f1a'::uuid AND dob IS NULL;
-- Issac Biczo (AUS) -> World Sailing: Issac Biczo [AUSIB15] | DOB: 2007-07-10
UPDATE public.sailors SET dob = '2007-07-10' WHERE id = '6570232e-a302-57ab-bdc2-53796e7a1e0b'::uuid AND dob IS NULL;
-- Jack Jones (AUS) -> World Sailing: Jack Jones [AUSJJ24] | DOB: 2014-10-27
UPDATE public.sailors SET dob = '2014-10-27' WHERE id = '442aeca1-7757-55cd-b547-0d3985748850'::uuid AND dob IS NULL;
-- Jackson Black (AUS) -> World Sailing: Jackson Black [AUSJB114] | DOB: 2010-02-18
UPDATE public.sailors SET dob = '2010-02-18' WHERE id = 'fc557110-c437-50af-9f7e-58469d838a87'::uuid AND dob IS NULL;
-- Jago Tucker (AUS) -> World Sailing: Jago Tucker [AUSJT57] | DOB: 2008-10-31
UPDATE public.sailors SET dob = '2008-10-31' WHERE id = 'bc7aab6e-9445-5012-8c03-08915ed0292b'::uuid AND dob IS NULL;
-- James Dale (AUS) -> World Sailing: James Dale [AUSJD88] | DOB: 2010-01-17
UPDATE public.sailors SET dob = '2010-01-17' WHERE id = 'a4a732c0-21ea-5f8b-a714-c87c398cf352'::uuid AND dob IS NULL;
-- Jasper Stay (AUS) -> World Sailing: Jasper Stay [AUSJS103] | DOB: 2008-06-12
UPDATE public.sailors SET dob = '2008-06-12' WHERE id = '6b96ae16-4077-54dd-b438-30147aa14bb7'::uuid AND dob IS NULL;
-- Jayden Wang (AUS) -> World Sailing: Jayden Wang [AUSJW82] | DOB: 2012-12-14
UPDATE public.sailors SET dob = '2012-12-14' WHERE id = 'b64cc6ae-a6e8-47a4-b702-b067d02e1f19'::uuid AND dob IS NULL;
-- Jeremy Atwell (AUS) -> World Sailing: Jeremy Atwell [AUSJA39] | DOB: 2004-01-31
UPDATE public.sailors SET dob = '2004-01-31' WHERE id = '4629e1b0-74cf-5239-9f00-6c84db765d41'::uuid AND dob IS NULL;
-- Jess Wardell (AUS) -> World Sailing: Jess Wardell [AUSJW88] | DOB: 2010-06-04
UPDATE public.sailors SET dob = '2010-06-04' WHERE id = 'beedd447-d06d-5ff8-b403-7a3bf04f5aa1'::uuid AND dob IS NULL;
-- Jessica Higgins (AUS) -> World Sailing: Jessica Higgins [AUSJH98] | DOB: 2012-08-08
UPDATE public.sailors SET dob = '2012-08-08' WHERE id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94'::uuid AND dob IS NULL;
-- Joe Corbel (AUS) -> World Sailing: Joe Corbel [AUSJC129] | DOB: 2008-10-24
UPDATE public.sailors SET dob = '2008-10-24' WHERE id = '416106d3-5759-5607-be1f-e5c4125f8a9c'::uuid AND dob IS NULL;
-- Joe Thompson (AUS) -> World Sailing: Joe Thompson [AUSJT56] | DOB: 2009-05-30
UPDATE public.sailors SET dob = '2009-05-30' WHERE id = '1c950636-ccab-528c-afa3-ef3b6a7d51b5'::uuid AND dob IS NULL;
-- Jonas Moeller (AUS) -> World Sailing: Jonas Moeller [AUSJM123] | DOB: 2010-08-25
UPDATE public.sailors SET dob = '2010-08-25' WHERE id = '7c6ff2dc-a8f2-5276-9bee-094a92a2be8a'::uuid AND dob IS NULL;
-- Joshua Till (AUS) -> World Sailing: Joshua Till [AUSJT59] | DOB: 2007-04-30
UPDATE public.sailors SET dob = '2007-04-30' WHERE id = 'c28de5dc-fdd3-5db1-a146-28296f7b3b6a'::uuid AND dob IS NULL;
-- Jozee Fowler (AUS) -> World Sailing: Jozee Fowler [AUSJF41] | DOB: 2012-05-25
UPDATE public.sailors SET dob = '2012-05-25' WHERE id = '83fa263e-034d-55f8-aaaa-452f7b43fa85'::uuid AND dob IS NULL;
-- Kai Lawson (AUS) -> World Sailing: Kai Lawson [AUSKL20] | DOB: 2009-10-12
UPDATE public.sailors SET dob = '2009-10-12' WHERE id = '69843896-764b-5fbd-8754-f3b8fba0d252'::uuid AND dob IS NULL;
-- Kalen Linton (AUS) -> World Sailing: Kalen Linton [AUSKL22] | DOB: 2010-02-09
UPDATE public.sailors SET dob = '2010-02-09' WHERE id = '4705978e-886c-5136-bb62-aa45abc0dac3'::uuid AND dob IS NULL;
-- Kirra Howell (AUS) -> World Sailing: Kirra Howell [AUSKH29] | DOB: 2011-07-16
UPDATE public.sailors SET dob = '2011-07-16' WHERE id = 'c52c2d2b-be97-5d50-9cca-dd8499e29539'::uuid AND dob IS NULL;
-- Klara Travlos (AUS) -> World Sailing: Klara Travlos [AUSKT13] | DOB: 2009-09-22
UPDATE public.sailors SET dob = '2009-09-22' WHERE id = 'fd68b50e-e289-50ec-8e83-14c1c57c46cc'::uuid AND dob IS NULL;
-- Lachlan Prior (AUS) -> World Sailing: Lachlan Prior [AUSLP28] | DOB: 2012-08-09
UPDATE public.sailors SET dob = '2012-08-09' WHERE id = 'aeca69e7-705c-451e-a0eb-363a1f6ab757'::uuid AND dob IS NULL;
-- Laken Eaton (AUS) -> World Sailing: Laken Eaton [AUSLE7] | DOB: 2010-12-17
UPDATE public.sailors SET dob = '2010-12-17' WHERE id = '088825f9-8fff-5123-8ee3-5e890100d28d'::uuid AND dob IS NULL;
-- Laura Davison (AUS) -> World Sailing: Laura Davison [AUSLD26] | DOB: 2015-07-21
UPDATE public.sailors SET dob = '2015-07-21' WHERE id = '0d34c48d-8cd6-588a-8541-c4e3de4141e4'::uuid AND dob IS NULL;
-- Lawson BARNES (AUS) -> World Sailing: Lawson Barnes [AUSLB35] | DOB: 2013-02-11
UPDATE public.sailors SET dob = '2013-02-11' WHERE id = 'da44e466-7859-5a6f-820e-d5d1e8f4314e'::uuid AND dob IS NULL;
-- Lawson McAullay (AUS) -> World Sailing: Lawson McAullay [AUSLM18] | DOB: 2004-06-05
UPDATE public.sailors SET dob = '2004-06-05' WHERE id = '2cc8de67-36e1-5c57-af62-2d5659661335'::uuid AND dob IS NULL;
-- Leon-Wei Petit (AUS) -> World Sailing: Leon-Wei PETIT [AUSLP31] | DOB: 2011-05-01
UPDATE public.sailors SET dob = '2011-05-01' WHERE id = 'fde99d54-7a87-5633-bbf6-852ab9a30c00'::uuid AND dob IS NULL;
-- Lia Rafart (AUS) -> World Sailing: Lia Rafart [AUSLR22] | DOB: 2008-10-27
UPDATE public.sailors SET dob = '2008-10-27' WHERE id = '73113a69-9463-5ba6-8ea9-86facf4f9ccd'::uuid AND dob IS NULL;
-- Lily Zahab (AUS) -> World Sailing: Lily Zahab [AUSLZ2] | DOB: 2012-01-15
UPDATE public.sailors SET dob = '2012-01-15' WHERE id = '79d6d1fe-2427-4b45-ab45-6cd4658e5571'::uuid AND dob IS NULL;
-- Louis Davis (AUS) -> World Sailing: Louis Davis [AUSLD23] | DOB: 2015-01-04
UPDATE public.sailors SET dob = '2015-01-04' WHERE id = '888d0e66-7810-52a3-859d-e4bcaf6b9b38'::uuid AND dob IS NULL;
-- Louise Swart (AUS) -> World Sailing: Louise Swart [AUSLS37] | DOB: 2010-04-29
UPDATE public.sailors SET dob = '2010-04-29' WHERE id = '154b862a-2ccd-576d-8628-e0d297c46bc4'::uuid AND dob IS NULL;
-- Luca Von Bibra (AUS) -> World Sailing: Luca von Bibra [AUSLV8] | DOB: 2013-07-26
UPDATE public.sailors SET dob = '2013-07-26' WHERE id = '10ebfe56-5763-4270-bb43-ad01e524c0ca'::uuid AND dob IS NULL;
-- Lucy Cree (AUS) -> World Sailing: Lucy Cree [AUSLC43] | DOB: 2009-07-08
UPDATE public.sailors SET dob = '2009-07-08' WHERE id = '0a96fc6c-3d91-5752-9f56-5504215d30ab'::uuid AND dob IS NULL;
-- Luke Carrick (AUS) -> World Sailing: Luke Carrick [AUSLC37] | DOB: 2007-11-09
UPDATE public.sailors SET dob = '2007-11-09' WHERE id = 'd21788fb-ab25-5974-a3de-2c1e42431fa2'::uuid AND dob IS NULL;
-- Matilda Tarring (AUS) -> World Sailing: Matilda Tarring [AUSMT56] | DOB: 2012-07-23
UPDATE public.sailors SET dob = '2012-07-23' WHERE id = '43b9d0a2-01e0-5674-99aa-f4a050ad1cd6'::uuid AND dob IS NULL;
-- Matthew Pilkington (AUS) -> World Sailing: Matthew Pilkington [AUSMP50] | DOB: 1982-10-01
UPDATE public.sailors SET dob = '1982-10-01' WHERE id = '9734b9b9-30ab-52e2-8a49-cf91c3d0eb0a'::uuid AND dob IS NULL;
-- Max Sturman (AUS) -> World Sailing: Max Sturman [AUSMS99] | DOB: 2005-05-03
UPDATE public.sailors SET dob = '2005-05-03' WHERE id = '4f37539b-5627-5b21-abeb-37fce5aa9322'::uuid AND dob IS NULL;
-- Max Williams (AUS) -> World Sailing: Max Williams [AUSMW80] | DOB: 2003-01-07
UPDATE public.sailors SET dob = '2003-01-07' WHERE id = 'c47f8c1e-033a-50b3-968b-766160e9a717'::uuid AND dob IS NULL;
-- Maxwell Boulton (AUS) -> World Sailing: Maxwell Boulton [AUSMB110] | DOB: 2013-05-08
UPDATE public.sailors SET dob = '2013-05-08' WHERE id = '39a4c7ef-6f5f-4988-abda-887a645cf3ff'::uuid AND dob IS NULL;
-- Mia Austin (AUS) -> World Sailing: Mia Austin [AUSMA17] | DOB: 2009-01-25
UPDATE public.sailors SET dob = '2009-01-25' WHERE id = 'c560b015-7d93-5b95-bef6-f59c52cf271e'::uuid AND dob IS NULL;
-- Miles Levenspiel (AUS) -> World Sailing: Miles Levenspiel [AUSML49] | DOB: 2009-06-02
UPDATE public.sailors SET dob = '2009-06-02' WHERE id = 'c35e575b-b2bc-5ce3-b73b-a3e3c3733451'::uuid AND dob IS NULL;
-- Molli McIlwaine (AUS) -> World Sailing: Molli Mcilwaine [AUSMM94] | DOB: 2008-12-05
UPDATE public.sailors SET dob = '2008-12-05' WHERE id = '6b6deac2-18ea-59be-a761-521789b7cdde'::uuid AND dob IS NULL;
-- Molly Schotte (AUS) -> World Sailing: Molly Schotte [AUSMS94] | DOB: 2007-07-10
UPDATE public.sailors SET dob = '2007-07-10' WHERE id = '8a1740ce-cbba-52f6-8f43-a2d68014538c'::uuid AND dob IS NULL;
-- Mylo Huang (AUS) -> World Sailing: MYLO HUANG [AUSMH90] | DOB: 2009-12-25
UPDATE public.sailors SET dob = '2009-12-25' WHERE id = '67ec7325-4ad7-5551-894d-03f19977e25a'::uuid AND dob IS NULL;
-- Nathaniel Mccarthy (AUS) -> World Sailing: Nathaniel McCarthy [AUSNM27] | DOB: 2010-10-14
UPDATE public.sailors SET dob = '2010-10-14' WHERE id = '0684279e-31e1-5e7c-843b-a562a008600b'::uuid AND dob IS NULL;
-- Nicholas Schoe (AUS) -> World Sailing: Nicholas Schoe [AUSNS31] | DOB: 2010-04-06
UPDATE public.sailors SET dob = '2010-04-06' WHERE id = 'b95e8687-cc0d-503d-879b-a972a600245e'::uuid AND dob IS NULL;
-- Nora Leon Hernandez (AUS) -> World Sailing: Nora Leon Hernandez [AUSNL10] | DOB: 2010-06-19
UPDATE public.sailors SET dob = '2010-06-19' WHERE id = '3158f3c0-cd04-59da-869c-8cdd7eae5da4'::uuid AND dob IS NULL;
-- Olive HOOPER (AUS) -> World Sailing: Olive Hooper [AUSOH8] | DOB: 2010-05-16
UPDATE public.sailors SET dob = '2010-05-16' WHERE id = 'efc471b6-0373-5273-9c4e-c161594a1a43'::uuid AND dob IS NULL;
-- Olivia Barr (AUS) -> World Sailing: Olivia Barr [AUSOB4] | DOB: 2011-08-15
UPDATE public.sailors SET dob = '2011-08-15' WHERE id = 'f0e4a9b7-53f2-5673-9852-b9b882846b62'::uuid AND dob IS NULL;
-- Olivia Cameron (AUS) -> World Sailing: Olivia Cameron [AUSOC4] | DOB: 2007-09-03
UPDATE public.sailors SET dob = '2007-09-03' WHERE id = '65388d04-67e1-56a6-b864-00361cc33a71'::uuid AND dob IS NULL;
-- Olivia Lee (AUS) -> World Sailing: Olivia Lee [AUSOL5] | DOB: 2009-11-29
UPDATE public.sailors SET dob = '2009-11-29' WHERE id = 'a30884c9-2fc8-5a8e-ae51-ccfe7cd7acaa'::uuid AND dob IS NULL;
-- Orlando Sadlik (AUS) -> World Sailing: Orlando Sadlik [AUSOS10] | DOB: 2006-04-13
UPDATE public.sailors SET dob = '2006-04-13' WHERE id = 'f36c114e-1da0-5507-8e4b-4ec4bdf7c14a'::uuid AND dob IS NULL;
-- Oscar Gaylard (AUS) -> World Sailing: Oscar Gaylard [AUSOG4] | DOB: 2011-01-07
UPDATE public.sailors SET dob = '2011-01-07' WHERE id = '53552b36-236f-58d8-b189-d1c7a9086d1c'::uuid AND dob IS NULL;
-- Oskar Bromberger (AUS) -> World Sailing: Oskar Bromberger [AUSOB6] | DOB: 2010-03-04
UPDATE public.sailors SET dob = '2010-03-04' WHERE id = 'f2512712-39ec-5aac-9284-087252628007'::uuid AND dob IS NULL;
-- Paige Grigg (AUS) -> World Sailing: Paige Grigg [AUSPG35] | DOB: 2008-12-23
UPDATE public.sailors SET dob = '2008-12-23' WHERE id = 'b11f8bb9-78dc-583a-9536-9665f0baef65'::uuid AND dob IS NULL;
-- Patrick Cummin (AUS) -> World Sailing: Patrick Cummin [AUSPC51] | DOB: 2006-05-05
UPDATE public.sailors SET dob = '2006-05-05' WHERE id = '4b113283-cd00-5f49-b510-b341d4c83335'::uuid AND dob IS NULL;
-- Patrick Mclachlan (AUS) -> World Sailing: Patrick McLachlan [AUSPM77] | DOB: 2010-09-23
UPDATE public.sailors SET dob = '2010-09-23' WHERE id = '7a792141-18ac-4cd4-a36d-4e93fe36a3a5'::uuid AND dob IS NULL;
-- Patrick Moore (AUS) -> World Sailing: Patrick Moore [AUSPM61] | DOB: 1990-05-15
UPDATE public.sailors SET dob = '1990-05-15' WHERE id = '948f00d5-2133-5e3f-9704-19d73a626e57'::uuid AND dob IS NULL;
-- Patrick Scally (AUS) -> World Sailing: Patrick Scally [AUSPS52] | DOB: 2003-12-03
UPDATE public.sailors SET dob = '2003-12-03' WHERE id = '2a532c9b-dab9-55cb-be2c-217bf15f51b6'::uuid AND dob IS NULL;
-- Pia Hooper (AUS) -> World Sailing: Pia Hooper [AUSPH44] | DOB: 2008-07-22
UPDATE public.sailors SET dob = '2008-07-22' WHERE id = '95b428af-a7f1-5d68-ac5c-8eb052bebc92'::uuid AND dob IS NULL;
-- Riley Cantwell (AUS) -> World Sailing: Riley Cantwell [AUSRC55] | DOB: 2008-01-17
UPDATE public.sailors SET dob = '2008-01-17' WHERE id = 'f4fad826-06d6-5bb0-90a1-203230f2ec03'::uuid AND dob IS NULL;
-- Robert Deards (AUS) -> World Sailing: Robert Deards [AUSRD36] | DOB: 2008-05-27
UPDATE public.sailors SET dob = '2008-05-27' WHERE id = '4759381e-50b3-5fa0-813e-2183e0914382'::uuid AND dob IS NULL;
-- Robyn Tutty (AUS) -> World Sailing: Robyn Tutty [AUSRT34] | DOB: 2010-11-14
UPDATE public.sailors SET dob = '2010-11-14' WHERE id = '7d964f7a-a837-5385-99e3-d4d7d866cc24'::uuid AND dob IS NULL;
-- Samantha Archer (AUS) -> World Sailing: Samantha Archer [AUSSA27] | DOB: 2012-07-06
UPDATE public.sailors SET dob = '2012-07-06' WHERE id = '35c9ca94-001c-49f5-9c63-e939cbfa82b3'::uuid AND dob IS NULL;
-- Samuel Hart (AUS) -> World Sailing: Samuel Hart [AUSSH73] | DOB: 2008-07-07
UPDATE public.sailors SET dob = '2008-07-07' WHERE id = '78f78712-4830-5322-8055-fdbcc975c080'::uuid AND dob IS NULL;
-- Sarah Reynolds (AUS) -> World Sailing: Sarah Reynolds [AUSSR49] | DOB: 2008-07-15
UPDATE public.sailors SET dob = '2008-07-15' WHERE id = 'e78454e7-3055-5db1-b03c-0d649b98f555'::uuid AND dob IS NULL;
-- Sophia Homes (AUS) -> World Sailing: Sophia Homes [AUSSH76] | DOB: 2009-11-20
UPDATE public.sailors SET dob = '2009-11-20' WHERE id = 'e8a6eca1-7e94-40ff-951c-a75326a4cea5'::uuid AND dob IS NULL;
-- Sophie Borner Harrison (AUS) -> World Sailing: Sophie Borner Harrison [AUSSB91] | DOB: 2009-03-20
UPDATE public.sailors SET dob = '2009-03-20' WHERE id = 'e44fd47b-50f6-5442-a65a-757d0f664933'::uuid AND dob IS NULL;
-- Sophie Brazier (AUS) -> World Sailing: Sophie Brazier [AUSSB87] | DOB: 2011-11-29
UPDATE public.sailors SET dob = '2011-11-29' WHERE id = 'a40240ca-39bb-5fa6-b5ff-f798ed556877'::uuid AND dob IS NULL;
-- Steve Gunther (AUS) -> World Sailing: Steve Gunther [AUSSG32] | DOB: 1957-07-15
UPDATE public.sailors SET dob = '1957-07-15' WHERE id = '16b5cf8a-2862-52a0-a1fe-5533422847aa'::uuid AND dob IS NULL;
-- Stirling Marshall (AUS) -> World Sailing: Stirling Marshall [AUSSM86] | DOB: 2011-09-20
UPDATE public.sailors SET dob = '2011-09-20' WHERE id = 'a08688e8-35e4-4ca6-9574-bd909c551806'::uuid AND dob IS NULL;
-- Tanner ARENDSEN (AUS) -> World Sailing: Tanner Arendsen [AUSTA21] | DOB: 2014-08-10
UPDATE public.sailors SET dob = '2014-08-10' WHERE id = 'eb15fc76-40b7-5b07-811c-0bb09f19094f'::uuid AND dob IS NULL;
-- Thomas Cooper (AUS) -> World Sailing: Thomas Cooper [AUSTC36] | DOB: 2010-11-04
UPDATE public.sailors SET dob = '2010-11-04' WHERE id = '87b5a49b-135e-5b1f-82f2-ea37b3c109ed'::uuid AND dob IS NULL;
-- Thomas Jackson (AUS) -> World Sailing: Thomas Jackson [AUSTJ10] | DOB: 2007-11-24
UPDATE public.sailors SET dob = '2007-11-24' WHERE id = '630166d6-ace3-59fa-9061-f549cb4ad6f1'::uuid AND dob IS NULL;
-- Thomas Pitt (AUS) -> World Sailing: Thomas Pitt [AUSTP24] | DOB: 2012-07-12
UPDATE public.sailors SET dob = '2012-07-12' WHERE id = '2ce7f341-53ee-4434-a35f-106f45110f47'::uuid AND dob IS NULL;
-- Toby YUEN (AUS) -> World Sailing: Toby Yuen [AUSTY2] | DOB: 2012-07-02
UPDATE public.sailors SET dob = '2012-07-02' WHERE id = '2d6a86d3-e3c2-5805-ba50-b08cc77aba98'::uuid AND dob IS NULL;
-- Tom Fader (AUS) -> World Sailing: Tom Fader [AUSTF17] | DOB: 2007-12-28
UPDATE public.sailors SET dob = '2007-12-28' WHERE id = '041934b8-4c11-58f7-a337-899d8c23b89b'::uuid AND dob IS NULL;
-- Tom PATTERSON (AUS) -> World Sailing: Tom Patterson [AUSTP25] | DOB: 2012-10-23
UPDATE public.sailors SET dob = '2012-10-23' WHERE id = '5608d729-327f-5521-9023-6d7c5c588fae'::uuid AND dob IS NULL;
-- Tucker McKeon (AUS) -> World Sailing: Tucker McKeon [AUSTM45] | DOB: 2009-03-15
UPDATE public.sailors SET dob = '2009-03-15' WHERE id = '0deba605-0d91-5f15-8ac4-c9bfdbc3281d'::uuid AND dob IS NULL;
-- Victoria Lin (AUS) -> World Sailing: Victoria Lin [AUSVL4] | DOB: 2010-02-20
UPDATE public.sailors SET dob = '2010-02-20' WHERE id = '1366873d-9230-48ae-9dc3-6ef8e8355301'::uuid AND dob IS NULL;
-- Wil Lodge (AUS) -> World Sailing: Wil Lodge [AUSWL6] | DOB: 2008-12-13
UPDATE public.sailors SET dob = '2008-12-13' WHERE id = 'ad8ee99b-0a11-5967-b167-7fce6b8f0383'::uuid AND dob IS NULL;
-- Wilbur Bright (AUS) -> World Sailing: Wilbur Bright [AUSWB24] | DOB: 2010-04-22
UPDATE public.sailors SET dob = '2010-04-22' WHERE id = 'bd4e7fae-3f4b-5edc-9a56-1164fed5486c'::uuid AND dob IS NULL;
-- Will James (AUS) -> World Sailing: Will James [AUSWJ7] | DOB: 2008-08-18
UPDATE public.sailors SET dob = '2008-08-18' WHERE id = '80c83919-78b9-5f7b-964c-50985463f6e0'::uuid AND dob IS NULL;
-- William Tribe (AUS) -> World Sailing: William Tribe [AUSWT10] | DOB: 2011-07-04
UPDATE public.sailors SET dob = '2011-07-04' WHERE id = '021701c2-1fd0-528d-b29b-853368260d68'::uuid AND dob IS NULL;
-- William Whitehead (AUS) -> World Sailing: William Whitehead [AUSWW16] | DOB: 2011-11-03
UPDATE public.sailors SET dob = '2011-11-03' WHERE id = '82e71b4f-ebf4-5a48-83c0-3688bfb37f32'::uuid AND dob IS NULL;
-- Zac Howell (AUS) -> World Sailing: Zac Howell [AUSZH2] | DOB: 2010-01-08
UPDATE public.sailors SET dob = '2010-01-08' WHERE id = 'fd76cf0f-efe1-53bd-a6ef-3eb77be730cc'::uuid AND dob IS NULL;
-- Zachary Patrick (AUS) -> World Sailing: Zachary Patrick [AUSZP3] | DOB: 2010-10-21
UPDATE public.sailors SET dob = '2010-10-21' WHERE id = '4964900e-be4b-5123-b515-6f123af03a66'::uuid AND dob IS NULL;
-- Zane Taylor (AUS) -> World Sailing: Zane Taylor [AUSZT4] | DOB: 2008-04-23
UPDATE public.sailors SET dob = '2008-04-23' WHERE id = '1692bd9b-eddc-5ddf-ba96-ad67b45df7c8'::uuid AND dob IS NULL;
-- Zara Challis (AUS) -> World Sailing: Zara Challis [AUSZC2] | DOB: 2001-06-25
UPDATE public.sailors SET dob = '2001-06-25' WHERE id = '17a6ee20-f7d5-5df2-a96a-ad1143337947'::uuid AND dob IS NULL;
-- Zara Marks (AUS) -> World Sailing: Zara Marks [AUSZM3] | DOB: 2010-02-19
UPDATE public.sailors SET dob = '2010-02-19' WHERE id = 'c6909a4b-71df-5bc8-9180-669be9e4bd10'::uuid AND dob IS NULL;
-- Zoe Heffernan (AUS) -> World Sailing: Zoe Heffernan [AUSZH5] | DOB: 2007-09-14
UPDATE public.sailors SET dob = '2007-09-14' WHERE id = '65cd895f-0dce-51a8-b686-bb207c549ef7'::uuid AND dob IS NULL;
-- Zoe Jackson (AUS) -> World Sailing: Zoe Jackson [AUSZJ1] | DOB: 2009-08-07
UPDATE public.sailors SET dob = '2009-08-07' WHERE id = 'f2f55d93-2529-5601-b26b-649c9b8a54ee'::uuid AND dob IS NULL;
-- Daniel Haslauer (AUT) -> World Sailing: Daniel Haslauer [AUTDH8] | DOB: 2011-08-12
UPDATE public.sailors SET dob = '2011-08-12' WHERE id = 'f7a91c5f-3a31-51c4-b415-0028ab095663'::uuid AND dob IS NULL;
-- Tim Jacobs (AUT) -> World Sailing: Tim Jacobs [AUTTJ4] | DOB: 2011-03-21
UPDATE public.sailors SET dob = '2011-03-21' WHERE id = '59fc987f-5df6-5344-8aaa-07560d372417'::uuid AND dob IS NULL;
-- Ade Heyse (BEL) -> World Sailing: Ade Heyse [BELAH6] | DOB: 2014-03-04
UPDATE public.sailors SET dob = '2014-03-04' WHERE id = '82839cfe-bd41-5ae2-b3ae-2f26af6856d2'::uuid AND dob IS NULL;
-- Emmanuel Lagrange (BEL) -> World Sailing: Emmanuel Lagrange [BELEL7] | DOB: 2008-06-09
UPDATE public.sailors SET dob = '2008-06-09' WHERE id = '6f9d3c25-8000-401a-b440-13c2e1c836e7'::uuid AND dob IS NULL;
-- Finn Ysewyn (BEL) -> World Sailing: Finn Ysewyn [BELFY1] | DOB: 2013-03-12
UPDATE public.sailors SET dob = '2013-03-12' WHERE id = '459ea7fe-689c-57a8-a7bc-44808337df8f'::uuid AND dob IS NULL;
-- Sara Celis (BEL) -> World Sailing: Sara Celis [BELSC4] | DOB: 2011-06-14
UPDATE public.sailors SET dob = '2011-06-14' WHERE id = 'f5f62074-1d7e-588b-9a3e-b3c56e1ae25e'::uuid AND dob IS NULL;
-- Siebe Paesmans (BEL) -> World Sailing: Siebe Paesmans [BELSP3] | DOB: 2011-10-04
UPDATE public.sailors SET dob = '2011-10-04' WHERE id = '58a1ff0a-f0e1-5fc4-9a21-c657ecbba50f'::uuid AND dob IS NULL;
-- Alexandre Moreira (BRA) -> World Sailing: Alexandre Moreira [BRAAM57] | DOB: 2011-07-28
UPDATE public.sailors SET dob = '2011-07-28' WHERE id = 'e311aba8-004c-5f4a-978a-6e44cb50c817'::uuid AND dob IS NULL;
-- Felipe Hutzler (BRA) -> World Sailing: Felipe Hutzler [BRAFH15] | DOB: 2012-08-06
UPDATE public.sailors SET dob = '2012-08-06' WHERE id = '085dd20a-20e7-56dd-9a79-ca372a08fdd6'::uuid AND dob IS NULL;
-- Laura Neves (BRA) -> World Sailing: Laura Neves [BRALN8] | DOB: 2009-06-11
UPDATE public.sailors SET dob = '2009-06-11' WHERE id = '48d1fd13-30a9-45ee-ae27-4a543229e466'::uuid AND dob IS NULL;
-- Rafael Girdwood (BRA) -> World Sailing: Rafael Girdwood [BRARG28] | DOB: 2008-09-07
UPDATE public.sailors SET dob = '2008-09-07' WHERE id = '4b681e8b-23bc-47be-82d8-c2a8a463bbc0'::uuid AND dob IS NULL;
-- Uma Creixell (BRA) -> World Sailing: Uma Creixell [BRAUC1] | DOB: 2011-02-07
UPDATE public.sailors SET dob = '2011-02-07' WHERE id = '94271c9d-a0a9-4364-b123-1fcec5dc124e'::uuid AND dob IS NULL;
-- Karolina Cenova (BUL) -> World Sailing: Karolina Cenova [BULKC1] | DOB: 2011-03-03
UPDATE public.sailors SET dob = '2011-03-03' WHERE id = 'fa8e9277-33ed-50f2-aaa7-c047f2cca9af'::uuid AND dob IS NULL;
-- Ryan Kirby (CAN) -> World Sailing: Ryan Kirby [CANRK20] | DOB: 2012-09-28
UPDATE public.sailors SET dob = '2012-09-28' WHERE id = '6afabc94-a3be-578a-b3f9-ecee65a069f9'::uuid AND dob IS NULL;
-- Tia Kinnear (CAN) -> World Sailing: Tia Kinnear [CANTK14] | DOB: 2011-10-06
UPDATE public.sailors SET dob = '2011-10-06' WHERE id = '21313b4d-bd52-5a5b-855b-247b7ea2738f'::uuid AND dob IS NULL;
-- Baoling Yu (CHN) -> World Sailing: Baoling Yu [CHNBY3] | DOB: 2003-12-22
UPDATE public.sailors SET dob = '2003-12-22' WHERE id = 'c07bdc06-a80a-5b16-a022-2774ae6069f0'::uuid AND dob IS NULL;
-- BingJie Yan (CHN) -> World Sailing: BINGJIE YAN [CHNBY2] | DOB: 2014-03-01
UPDATE public.sailors SET dob = '2014-03-01' WHERE id = '58fb912f-79c6-5649-8b60-27ac74b3f452'::uuid AND dob IS NULL;
-- Boxuan Yu (CHN) -> World Sailing: Boxuan Yu [CHNBY4] | DOB: 2011-06-21
UPDATE public.sailors SET dob = '2011-06-21' WHERE id = '3590c7e0-16bf-4193-973e-2d94d3a9e37d'::uuid AND dob IS NULL;
-- Cheng Zhang (CHN) -> World Sailing: Cheng Zhang [CHNCZ11] | DOB: 2011-05-04
UPDATE public.sailors SET dob = '2011-05-04' WHERE id = 'bc7f0507-db8c-5f57-afa5-2e9884b85466'::uuid AND dob IS NULL;
-- Chengjin Yi (CHN) -> World Sailing: CHENGJIN YI [CHNCY7] | DOB: 2010-03-22
UPDATE public.sailors SET dob = '2010-03-22' WHERE id = '564035e5-db60-598e-9f1e-66ff281b6a55'::uuid AND dob IS NULL;
-- CongGuo Huang (CHN) -> World Sailing: Congguo Huang [CHNCH8] | DOB: 2009-02-02
UPDATE public.sailors SET dob = '2009-02-02' WHERE id = '5242c095-094d-4bbf-9823-86b1e9bce128'::uuid AND dob IS NULL;
-- Dapeng Ming (CHN) -> World Sailing: Dapeng Ming [CHNDM1] | DOB: 2009-09-02
UPDATE public.sailors SET dob = '2009-09-02' WHERE id = 'ff2b9f52-ba58-5fe2-a0f2-d4169564171f'::uuid AND dob IS NULL;
-- Fang Yu Fu (CHN) -> World Sailing: Fang Yu Fu [CHNFF3] | DOB: 2006-03-23
UPDATE public.sailors SET dob = '2006-03-23' WHERE id = '2a3d638a-3eef-5eff-88c0-a9d7dbdb6d28'::uuid AND dob IS NULL;
-- Fanqi Shen (CHN) -> World Sailing: Fanqi Shen [CHNFS2] | DOB: 2011-09-28
UPDATE public.sailors SET dob = '2011-09-28' WHERE id = '8324ef6a-1d2b-491c-a8c3-b7589a5bd1c3'::uuid AND dob IS NULL;
-- Guanguo Xie (CHN) -> World Sailing: Guanguo Xie [CHNGX1] | DOB: 2008-05-12
UPDATE public.sailors SET dob = '2008-05-12' WHERE id = '74649a91-150b-563f-af61-e9ad39199bfa'::uuid AND dob IS NULL;
-- Guo Yuan (CHN) -> World Sailing: guo yuan [CHNGY1] | DOB: 2007-08-27
UPDATE public.sailors SET dob = '2007-08-27' WHERE id = '612c9d98-1eb6-58ca-b38b-dd5e265b32b3'::uuid AND dob IS NULL;
-- Guoguo Yan (CHN) -> World Sailing: GUOGUO YAN [CHNGY5] | DOB: 2009-09-30
UPDATE public.sailors SET dob = '2009-09-30' WHERE id = 'f7c5c2e7-a371-584d-8b60-ae56f00fbace'::uuid AND dob IS NULL;
-- Guoxin Qin (CHN) -> World Sailing: GuoXin Qin [CHNGQ3] | DOB: 2009-03-02
UPDATE public.sailors SET dob = '2009-03-02' WHERE id = '20029686-86c4-5038-b617-0a3c3cd48950'::uuid AND dob IS NULL;
-- HaoWei Zhuang (CHN) -> World Sailing: Haowei Zhuang [CHNHZ12] | DOB: 2011-04-08
UPDATE public.sailors SET dob = '2011-04-08' WHERE id = '9f669bbf-2799-5cc5-9fc2-a26dc4813862'::uuid AND dob IS NULL;
-- Haotian Li (CHN) -> World Sailing: haotian Li [CHNHL20] | DOB: 2002-11-07
UPDATE public.sailors SET dob = '2002-11-07' WHERE id = 'be8460e4-3337-536d-a1c0-b0a2c5ecb08d'::uuid AND dob IS NULL;
-- He Lv (CHN) -> World Sailing: he lv [CHNHL25] | DOB: 2011-03-26
UPDATE public.sailors SET dob = '2011-03-26' WHERE id = '9dc548f8-eaa5-51b2-b7c0-d283adf7c776'::uuid AND dob IS NULL;
-- He Qu (CHN) -> World Sailing: he qu [CHNHQ4] | DOB: 2010-04-21
UPDATE public.sailors SET dob = '2010-04-21' WHERE id = '7abfdde4-90ff-55c8-81a1-76c6f2eea4e0'::uuid AND dob IS NULL;
-- HongJun Wang (CHN) -> World Sailing: hongjun Wang [CHNHW10] | DOB: 2012-06-27
UPDATE public.sailors SET dob = '2012-06-27' WHERE id = '511db3ec-2851-50b0-bba8-da974a79936f'::uuid AND dob IS NULL;
-- Hongxiang Chen (CHN) -> World Sailing: Hongxiang Chen [CHNHC8] | DOB: 2007-02-23
UPDATE public.sailors SET dob = '2007-02-23' WHERE id = '55d48d99-79a3-531d-a623-062f911c1238'::uuid AND dob IS NULL;
-- Huiting Xu (CHN) -> World Sailing: Huiting Xu [CHNHX10] | DOB: 2007-09-18
UPDATE public.sailors SET dob = '2007-09-18' WHERE id = 'e0a973ec-5c34-5cde-bfe9-73a88263e902'::uuid AND dob IS NULL;
-- Huixia Fu (CHN) -> World Sailing: Huixia Fu [CHNHF3] | DOB: 2010-11-02
UPDATE public.sailors SET dob = '2010-11-02' WHERE id = '6dd80388-c0cd-507a-926b-06f08260adf3'::uuid AND dob IS NULL;
-- Ji Wang (CHN) -> World Sailing: ji wang [CHNJW25] | DOB: 2010-04-02
UPDATE public.sailors SET dob = '2010-04-02' WHERE id = '7be19c4b-130a-593f-848e-40888dd7024f'::uuid AND dob IS NULL;
-- Jiahan Chen (CHN) -> World Sailing: Jiahan Chen [CHNJC9] | DOB: 2007-11-05
UPDATE public.sailors SET dob = '2007-11-05' WHERE id = '51d18c99-93e2-5bce-b886-c45036a30286'::uuid AND dob IS NULL;
-- Jiahao Zhuang (CHN) -> World Sailing: JIAHAO ZHUANG [CHNJZ20] | DOB: 2009-01-12
UPDATE public.sailors SET dob = '2009-01-12' WHERE id = '96708f94-34d4-5d8c-b8be-85203b783841'::uuid AND dob IS NULL;
-- Jiahua Liu (CHN) -> World Sailing: Jiahua Liu [CHNJL27] | DOB: 2005-10-06
UPDATE public.sailors SET dob = '2005-10-06' WHERE id = '23401c6b-c3bd-5f81-9cf7-1e944f8c5468'::uuid AND dob IS NULL;
-- Jiajia Tang (CHN) -> World Sailing: Jiajia Tang [CHNJT6] | DOB: 2005-10-04
UPDATE public.sailors SET dob = '2005-10-04' WHERE id = 'b3a29923-9d56-5e07-82f0-b0708d6f1419'::uuid AND dob IS NULL;
-- Jiale Geng (CHN) -> World Sailing: Jiale Geng [CHNJG5] | DOB: 2010-03-18
UPDATE public.sailors SET dob = '2010-03-18' WHERE id = '94da7557-e28f-5096-b25f-e36836f38c09'::uuid AND dob IS NULL;
-- Jiaqi Liu (CHN) -> World Sailing: Jiaqi Liu [CHNJL28] | DOB: 2006-06-12
UPDATE public.sailors SET dob = '2006-06-12' WHERE id = 'cc50d043-c2e0-520f-b4e6-dc65ce55e28b'::uuid AND dob IS NULL;
-- Jimeng Chen (CHN) -> World Sailing: Jimeng Chen [CHNJC7] | DOB: 2001-10-19
UPDATE public.sailors SET dob = '2001-10-19' WHERE id = '02749d3a-ea20-5171-a857-0d819f991798'::uuid AND dob IS NULL;
-- Jindong Kong (CHN) -> World Sailing: Jindong Kong [CHNJK1] | DOB: 2002-11-01
UPDATE public.sailors SET dob = '2002-11-01' WHERE id = 'd2c623ee-eeca-55e7-bb37-3a0f54b601bf'::uuid AND dob IS NULL;
-- Jinhang Yu (CHN) -> World Sailing: jinhang yu [CHNJY14] | DOB: 2009-04-13
UPDATE public.sailors SET dob = '2009-04-13' WHERE id = '3bdb185e-6937-5641-86f5-3d735c4e85c2'::uuid AND dob IS NULL;
-- Jishuo Zhang (CHN) -> World Sailing: Jishuo Zhang [CHNJZ19] | DOB: 2012-07-30
UPDATE public.sailors SET dob = '2012-07-30' WHERE id = '43219fd4-b508-5eb7-873a-7c615ce7e38e'::uuid AND dob IS NULL;
-- Juncheng Zhou (CHN) -> World Sailing: juncheng zhou [CHNJZ17] | DOB: 2007-05-31
UPDATE public.sailors SET dob = '2007-05-31' WHERE id = 'f591f4b2-9114-580f-b2dd-367b067094f7'::uuid AND dob IS NULL;
-- Junjie Qiu (CHN) -> World Sailing: Junjie Qiu [CHNJQ4] | DOB: 2008-12-16
UPDATE public.sailors SET dob = '2008-12-16' WHERE id = '34b7c1ef-c8bc-5a54-abf7-368cb63474e2'::uuid AND dob IS NULL;
-- Junqi Gao (CHN) -> World Sailing: Junqi Gao [CHNJG4] | DOB: 2006-08-24
UPDATE public.sailors SET dob = '2006-08-24' WHERE id = '4b50b47b-1492-57dd-9f30-f445a2d1dc00'::uuid AND dob IS NULL;
-- Junxi Ding (CHN) -> World Sailing: junxi ding [CHNJD3] | DOB: 2009-04-21
UPDATE public.sailors SET dob = '2009-04-21' WHERE id = '88f2c39e-13a5-5729-8c4a-485791836852'::uuid AND dob IS NULL;
-- Leyan Huang (CHN) -> World Sailing: Leyan Huang [CHNLH9] | DOB: 2008-01-22
UPDATE public.sailors SET dob = '2008-01-22' WHERE id = '4f0601e7-97b8-56e2-8f35-16b373dac4eb'::uuid AND dob IS NULL;
-- Li Huang (CHN) -> World Sailing: Li Huang [CHNLH13] | DOB: 2008-01-19
UPDATE public.sailors SET dob = '2008-01-19' WHERE id = 'd1b87ec8-57e4-5173-9da2-9cc80de2bb8c'::uuid AND dob IS NULL;
-- Li Junda (CHN) -> World Sailing: Li junda [CHNLJ6] | DOB: 2008-01-06
UPDATE public.sailors SET dob = '2008-01-06' WHERE id = '748f90c5-4811-5dfe-8d23-657eeaf91af8'::uuid AND dob IS NULL;
-- Linger Zhou (CHN) -> World Sailing: LINGER ZHOU [CHNLZ13] | DOB: 2010-07-17
UPDATE public.sailors SET dob = '2010-07-17' WHERE id = 'aa564db6-5ef3-5666-a821-425146fc692e'::uuid AND dob IS NULL;
-- Linhan Zhang (CHN) -> World Sailing: Linhan Zhang [CHNLZ8] | DOB: 2009-07-23
UPDATE public.sailors SET dob = '2009-07-23' WHERE id = '9e8db81c-630b-5879-bcfe-2c1ea4030c25'::uuid AND dob IS NULL;
-- Luo Enzo (CHN) -> World Sailing: Luo Enzo [CHNLE1] | DOB: 2009-07-02
UPDATE public.sailors SET dob = '2009-07-02' WHERE id = '58b608ad-1fc2-51df-85b7-11c47ee41a39'::uuid AND dob IS NULL;
-- Luo Yi (CHN) -> World Sailing: Luo yi [CHNLY7] | DOB: 2008-12-27
UPDATE public.sailors SET dob = '2008-12-27' WHERE id = '4199028f-a4dc-5a9b-9b33-e7e208ab9191'::uuid AND dob IS NULL;
-- Meifang Zhao (CHN) -> World Sailing: meifang zhao [CHNMZ10] | DOB: 2007-08-22
UPDATE public.sailors SET dob = '2007-08-22' WHERE id = 'd4a73837-9aea-512a-a508-6463f255d349'::uuid AND dob IS NULL;
-- Meixiu Zhao (CHN) -> World Sailing: Meixiu Zhao [CHNMZ6] | DOB: 2007-08-22
UPDATE public.sailors SET dob = '2007-08-22' WHERE id = '7dac82e6-2cc0-5681-8b9a-75a9deba9edb'::uuid AND dob IS NULL;
-- Mengyao Yu (CHN) -> World Sailing: Mengyao Yu [CHNMY2] | DOB: 2002-12-14
UPDATE public.sailors SET dob = '2002-12-14' WHERE id = 'fff0cbea-df5b-53f7-9d2b-a5c715ff066f'::uuid AND dob IS NULL;
-- Min Zhang (CHN) -> World Sailing: Min Zhang [CHNMZ9] | DOB: 2009-05-06
UPDATE public.sailors SET dob = '2009-05-06' WHERE id = '0a157383-ee45-5e8c-aa06-ec12fbf2ad2c'::uuid AND dob IS NULL;
-- Muyun Chen (CHN) -> World Sailing: Muyun Chen [CHNMC6] | DOB: 2011-09-16
UPDATE public.sailors SET dob = '2011-09-16' WHERE id = 'ada503c8-8ef8-4214-ad67-2d16f5782432'::uuid AND dob IS NULL;
-- Nan Chen (CHN) -> World Sailing: Nan Chen [CHNNC2] | DOB: 2006-12-13
UPDATE public.sailors SET dob = '2006-12-13' WHERE id = '9d364cd0-cc84-585c-bb0b-768f10d5af1d'::uuid AND dob IS NULL;
-- Pan Bo Wen (CHN) -> World Sailing: Pan Bo Wen [CHNPB1] | DOB: 2008-08-31
UPDATE public.sailors SET dob = '2008-08-31' WHERE id = '660ca0bb-1d40-5077-9dac-ceb48cc11001'::uuid AND dob IS NULL;
-- Peixuan Sun (CHN) -> World Sailing: peixuan sun [CHNPS3] | DOB: 2011-06-22
UPDATE public.sailors SET dob = '2011-06-22' WHERE id = 'cc8ae5de-5c68-5cff-98da-fb7e571162c8'::uuid AND dob IS NULL;
-- Qinghua Hu (CHN) -> World Sailing: Qinghua Hu [CHNQH2] | DOB: 2010-09-27
UPDATE public.sailors SET dob = '2010-09-27' WHERE id = '03beb519-c2a4-45e7-a7a1-faf0d1cc0879'::uuid AND dob IS NULL;
-- Qinyi Li (CHN) -> World Sailing: QINYI LI [CHNQL15] | DOB: 2009-09-19
UPDATE public.sailors SET dob = '2009-09-19' WHERE id = 'c8b3175b-1b32-50de-8dc1-e72517d42c0e'::uuid AND dob IS NULL;
-- Ruihan Chen (CHN) -> World Sailing: ruihan chen [CHNRC2] | DOB: 2010-09-27
UPDATE public.sailors SET dob = '2010-09-27' WHERE id = '5cd84010-dcdf-5676-b97b-6b5958db5f3c'::uuid AND dob IS NULL;
-- Ruoqi Zhang (CHN) -> World Sailing: Ruoqi Zhang [CHNRZ6] | DOB: 2011-02-19
UPDATE public.sailors SET dob = '2011-02-19' WHERE id = '50b3e0fd-0917-4cf1-b223-34ee0dcf9574'::uuid AND dob IS NULL;
-- Ruoque Su (CHN) -> World Sailing: Ruoque Su [CHNRS2] | DOB: 2006-10-09
UPDATE public.sailors SET dob = '2006-10-09' WHERE id = '56af1cd1-f3d9-5298-956c-274f294de03e'::uuid AND dob IS NULL;
-- Ruoxian Wu (CHN) -> World Sailing: ruoxian Wu [CHNRW4] | DOB: 2010-01-01
UPDATE public.sailors SET dob = '2010-01-01' WHERE id = 'e686d1dd-9808-56ce-b22a-088ec1ae401f'::uuid AND dob IS NULL;
-- Ruoyu Su (CHN) -> World Sailing: Ruoyu Su [CHNRS3] | DOB: 2006-10-09
UPDATE public.sailors SET dob = '2006-10-09' WHERE id = 'a989031e-5d1b-546f-994b-7dd84b80bfb3'::uuid AND dob IS NULL;
-- Saiya Lu (CHN) -> World Sailing: SAIYA LU [CHNSL11] | DOB: 2008-06-10
UPDATE public.sailors SET dob = '2008-06-10' WHERE id = 'cb704cef-5d6a-5ab1-8c50-53efdc57a5ba'::uuid AND dob IS NULL;
-- Shaohui Zhang (CHN) -> World Sailing: ShaoHui Zhang [CHNSZ12] | DOB: 2009-04-03
UPDATE public.sailors SET dob = '2009-04-03' WHERE id = 'ba8931d0-550c-51d0-8910-091f8a3615d4'::uuid AND dob IS NULL;
-- Shengxin Fan (CHN) -> World Sailing: Shengxin Fan [CHNSF1] | DOB: 2000-05-10
UPDATE public.sailors SET dob = '2000-05-10' WHERE id = '59438234-857e-53f3-8e9e-349204931a73'::uuid AND dob IS NULL;
-- Tianle Wang (CHN) -> World Sailing: Tianle Wang [CHNTW7] | DOB: 2011-06-18
UPDATE public.sailors SET dob = '2011-06-18' WHERE id = '50f1720d-1f44-5ce2-a5f7-5507e56fb87f'::uuid AND dob IS NULL;
-- Wanjia He (CHN) -> World Sailing: Wanjia He [CHNWH8] | DOB: 2011-12-19
UPDATE public.sailors SET dob = '2011-12-19' WHERE id = 'd62589f0-8e56-49df-9295-428a064c02ea'::uuid AND dob IS NULL;
-- Weijie Zheng (CHN) -> World Sailing: Weijie Zheng [CHNWZ12] | DOB: 2004-07-16
UPDATE public.sailors SET dob = '2004-07-16' WHERE id = 'f560f344-f301-5698-bdf2-efa8a44a7238'::uuid AND dob IS NULL;
-- Wentai Yang (CHN) -> World Sailing: Wentai Yang [CHNWY4] | DOB: 2008-11-23
UPDATE public.sailors SET dob = '2008-11-23' WHERE id = '783eafcb-6263-569c-b52c-ad504b85af62'::uuid AND dob IS NULL;
-- Wenxing Cheng (CHN) -> World Sailing: WENXING Cheng [CHNWC4] | DOB: 2010-06-10
UPDATE public.sailors SET dob = '2010-06-10' WHERE id = 'a748849b-bfa8-5666-8471-7e3286774b63'::uuid AND dob IS NULL;
-- Xi Wei (CHN) -> World Sailing: Xi Wei [CHNXW16] | DOB: 2009-05-29
UPDATE public.sailors SET dob = '2009-05-29' WHERE id = 'b07bb6a9-3979-44fe-ba76-5343051aa478'::uuid AND dob IS NULL;
-- Xiaoyou Pan (CHN) -> World Sailing: XIAOYOU PAN [CHNXP3] | DOB: 2011-07-07
UPDATE public.sailors SET dob = '2011-07-07' WHERE id = '92d3a445-ad48-5c1f-b990-1d574359bb47'::uuid AND dob IS NULL;
-- Xu Xiaorong (CHN) -> World Sailing: Xu Xiaorong [CHNXX12] | DOB: 2009-05-25
UPDATE public.sailors SET dob = '2009-05-25' WHERE id = 'c261ebe9-0054-4de8-ad6f-31899871703f'::uuid AND dob IS NULL;
-- Xunhao Zheng (CHN) -> World Sailing: Xunhao Zheng [CHNXZ21] | DOB: 2010-02-12
UPDATE public.sailors SET dob = '2010-02-12' WHERE id = '56ea1e8c-631b-568f-b6eb-8096cf9ec9e4'::uuid AND dob IS NULL;
-- Yang Meng (CHN) -> World Sailing: Yang Meng [CHNYM4] | DOB: 2004-12-17
UPDATE public.sailors SET dob = '2004-12-17' WHERE id = 'c7a2f767-ff62-59fc-871a-7d4bea39f6e0'::uuid AND dob IS NULL;
-- Yaozhuang Chen (CHN) -> World Sailing: Yaozhuang Chen [CHNYC20] | DOB: 2009-04-21
UPDATE public.sailors SET dob = '2009-04-21' WHERE id = '870db169-c3dd-5ccf-b16a-6fdd6204e099'::uuid AND dob IS NULL;
-- Yaxuan Luo (CHN) -> World Sailing: Yaxuan Luo [CHNYL38] | DOB: 2007-03-02
UPDATE public.sailors SET dob = '2007-03-02' WHERE id = '2386b36f-2ea0-54f6-9d2f-244c22cacda4'::uuid AND dob IS NULL;
-- Ye Xin Yang (CHN) -> World Sailing: ye xin Yang [CHNYY16] | DOB: 2006-06-07
UPDATE public.sailors SET dob = '2006-06-07' WHERE id = '56fe38fa-7759-59a5-9432-ff0a4b518898'::uuid AND dob IS NULL;
-- Yebin Guo (CHN) -> World Sailing: yebin guo [CHNYG4] | DOB: 2005-04-10
UPDATE public.sailors SET dob = '2005-04-10' WHERE id = 'ece31428-b9e2-5ba4-b5d6-79e4f7b84dd7'::uuid AND dob IS NULL;
-- Yihong Xu (CHN) -> World Sailing: yihong xu [CHNYX11] | DOB: 2005-08-06
UPDATE public.sailors SET dob = '2005-08-06' WHERE id = '6abcf385-0642-56a7-8dc5-e310566104d9'::uuid AND dob IS NULL;
-- Yijia Su (CHN) -> World Sailing: YIJIA SU [CHNYS10] | DOB: 2008-05-18
UPDATE public.sailors SET dob = '2008-05-18' WHERE id = '0a36ac43-cca1-5864-8081-62ed058052b7'::uuid AND dob IS NULL;
-- Yinping Huang (CHN) -> World Sailing: Yinping Huang [CHNYH15] | DOB: 2008-06-05
UPDATE public.sailors SET dob = '2008-06-05' WHERE id = 'fa5c9979-8c33-5788-bd9f-2587309397ad'::uuid AND dob IS NULL;
-- Yongyi Chen (CHN) -> World Sailing: Yongyi Chen [CHNYC16] | DOB: 2010-01-20
UPDATE public.sailors SET dob = '2010-01-20' WHERE id = '9f8ac816-e8cf-5f65-b065-75cc967b6842'::uuid AND dob IS NULL;
-- Yuanshuai Tang (CHN) -> World Sailing: Yuanshuai Tang [CHNYT2] | DOB: 2004-03-16
UPDATE public.sailors SET dob = '2004-03-16' WHERE id = '03fe14f0-5ced-502b-98b0-a351c62258e5'::uuid AND dob IS NULL;
-- Yufei Chen (CHN) -> World Sailing: Yufei Chen [CHNYC17] | DOB: 2008-08-16
UPDATE public.sailors SET dob = '2008-08-16' WHERE id = 'bd3f9394-9eb2-47c0-8c60-2b5cc89359fd'::uuid AND dob IS NULL;
-- Yujia Wang (CHN) -> World Sailing: yujia wang [CHNYW26] | DOB: 2011-03-17
UPDATE public.sailors SET dob = '2011-03-17' WHERE id = 'e3023b48-b403-5d59-96fd-243fe9fd9c1d'::uuid AND dob IS NULL;
-- Yujiao Cao (CHN) -> World Sailing: Yujiao Cao [CHNYC19] | DOB: 2009-06-01
UPDATE public.sailors SET dob = '2009-06-01' WHERE id = '16282942-59b2-5a34-b49f-be513445eebe'::uuid AND dob IS NULL;
-- Yukun Chen (CHN) -> World Sailing: yukun Chen [CHNYC21] | DOB: 2005-12-28
UPDATE public.sailors SET dob = '2005-12-28' WHERE id = '7ad0d090-eb1c-5d17-a999-67f811ab3def'::uuid AND dob IS NULL;
-- Yukun Zhao (CHN) -> World Sailing: Yukun Zhao [CHNYZ30] | DOB: 2005-07-05
UPDATE public.sailors SET dob = '2005-07-05' WHERE id = 'e4dbf95a-8b82-5500-b709-346f51a21d81'::uuid AND dob IS NULL;
-- Yunru Zhang (CHN) -> World Sailing: Yunru Zhang [CHNYZ28] | DOB: 2011-05-27
UPDATE public.sailors SET dob = '2011-05-27' WHERE id = '831e3e52-4c88-53b8-ac69-7a0ab3d96476'::uuid AND dob IS NULL;
-- Yunzhe Tao (CHN) -> World Sailing: Yunzhe Tao [CHNYT3] | DOB: 2013-08-16
UPDATE public.sailors SET dob = '2013-08-16' WHERE id = 'f7b6991a-030c-5479-96e8-32f8073470ca'::uuid AND dob IS NULL;
-- Yutong Cai (CHN) -> World Sailing: Yutong Cai [CHNYC18] | DOB: 2008-05-01
UPDATE public.sailors SET dob = '2008-05-01' WHERE id = '7b2c8ce4-104a-5776-a9cd-728b6bb13061'::uuid AND dob IS NULL;
-- Yuxiang Tao (CHN) -> World Sailing: YUXIANG TAO [CHNYT6] | DOB: 2010-10-04
UPDATE public.sailors SET dob = '2010-10-04' WHERE id = 'f1ba1b44-0e92-5bff-b041-b6584719fc28'::uuid AND dob IS NULL;
-- Yuxiao Deng (CHN) -> World Sailing: Yuxiao Deng [CHNYD4] | DOB: 2011-07-12
UPDATE public.sailors SET dob = '2011-07-12' WHERE id = '23ae179a-311b-5dc8-86d6-bf0d0869b788'::uuid AND dob IS NULL;
-- Yuxuan Liu (CHN) -> World Sailing: YUXUAN LIU [CHNYL34] | DOB: 2011-10-16
UPDATE public.sailors SET dob = '2011-10-16' WHERE id = 'fe1f0a00-1e15-4ad0-b83d-05ec5d33dac2'::uuid AND dob IS NULL;
-- Zeen Huang (CHN) -> World Sailing: zeen huang [CHNZH7] | DOB: 2004-07-01
UPDATE public.sailors SET dob = '2004-07-01' WHERE id = '9bb223e1-a98f-570a-9beb-fbbb3e794e45'::uuid AND dob IS NULL;
-- Zeren Xiong (CHN) -> World Sailing: ZEREN XIONG [CHNZX9] | DOB: 2013-03-19
UPDATE public.sailors SET dob = '2013-03-19' WHERE id = 'ffaacf08-cae5-533c-b8d6-040e168d92d6'::uuid AND dob IS NULL;
-- ZhiYuan Xu (CHN) -> World Sailing: zhiyuan xu [CHNZX6] | DOB: 2010-01-22
UPDATE public.sailors SET dob = '2010-01-22' WHERE id = '9d0b9c9d-9abc-593a-bda0-2c1f2194ec2e'::uuid AND dob IS NULL;
-- Zhihao Gu (CHN) -> World Sailing: zhihao Gu [CHNZG3] | DOB: 2004-03-03
UPDATE public.sailors SET dob = '2004-03-03' WHERE id = '206be18b-6b97-5f65-a0f6-8cde177e997c'::uuid AND dob IS NULL;
-- Zhongling Qi (CHN) -> World Sailing: ZHONGLING QI [CHNZQ4] | DOB: 2013-01-23
UPDATE public.sailors SET dob = '2013-01-23' WHERE id = '4220cbc3-f523-5575-8abd-00610c01c3c3'::uuid AND dob IS NULL;
-- Zidong Yang (CHN) -> World Sailing: Zidong Yang [CHNZY11] | DOB: 2009-07-12
UPDATE public.sailors SET dob = '2009-07-12' WHERE id = '4153958b-e800-5ac9-b07f-880665c136af'::uuid AND dob IS NULL;
-- Zifan Feng (CHN) -> World Sailing: Zifan Feng [CHNZF5] | DOB: 2007-03-03
UPDATE public.sailors SET dob = '2007-03-03' WHERE id = '738ea9d2-24d6-58a4-b283-7519c083f4c1'::uuid AND dob IS NULL;
-- Zihan Sun (CHN) -> World Sailing: zihan sun [CHNZS9] | DOB: 2011-01-09
UPDATE public.sailors SET dob = '2011-01-09' WHERE id = 'bb977df0-36a5-580b-8efb-f2faefa1cb2a'::uuid AND dob IS NULL;
-- Zihan Tang (CHN) -> World Sailing: zihan tang [CHNZT1] | DOB: 2011-08-30
UPDATE public.sailors SET dob = '2011-08-30' WHERE id = '27ae7a69-b946-5f11-8e82-d9ae359687e6'::uuid AND dob IS NULL;
-- Zihao Zhi (CHN) -> World Sailing: zihao Zhi [CHNZZ19] | DOB: 2008-05-22
UPDATE public.sailors SET dob = '2008-05-22' WHERE id = 'bce9e13d-67b0-58e3-89d3-fcd5648feba8'::uuid AND dob IS NULL;
-- Zongchen Wei (CHN) -> World Sailing: Zongchen Wei [CHNZW17] | DOB: 2009-01-23
UPDATE public.sailors SET dob = '2009-01-23' WHERE id = '0daa3f08-a322-5498-ace7-9fb3088e97c3'::uuid AND dob IS NULL;
-- David Palinić (CRO) -> World Sailing: David Palinić [CRODP11] | DOB: 2012-12-20
UPDATE public.sailors SET dob = '2012-12-20' WHERE id = '3b7b6d5d-d581-56bd-a286-5be9fad01436'::uuid AND dob IS NULL;
-- Viktor Vaclavek (CZE) -> World Sailing: Viktor Vaclavek [CZEVV7] | DOB: 2013-02-23
UPDATE public.sailors SET dob = '2013-02-23' WHERE id = '2206e542-e092-5e4c-9017-d13167f4c1ef'::uuid AND dob IS NULL;
-- Gerard Rius (ESP) -> World Sailing: Gerard Rius [ESPGR21] | DOB: 2008-05-15
UPDATE public.sailors SET dob = '2008-05-15' WHERE id = '2fb7813e-8316-53ba-9ca4-e339ffe58877'::uuid AND dob IS NULL;
-- Jan Palou (ESP) -> World Sailing: JAN PALOU [ESPJP124] | DOB: 2013-05-18
UPDATE public.sailors SET dob = '2013-05-18' WHERE id = 'e9146ccc-3392-5ae5-8541-240d155bc588'::uuid AND dob IS NULL;
-- Maksym Oberemko (ESP) -> World Sailing: Maksym OBEREMKO [ESPMO19] | DOB: 1978-01-25
UPDATE public.sailors SET dob = '1978-01-25' WHERE id = 'ef830f33-4bd4-5ad9-b6d7-06428e06ccb3'::uuid AND dob IS NULL;
-- Maria De Lluc Bestard (ESP) -> World Sailing: MARIA DE LLUC BESTARD [ESPMB59] | DOB: 2011-05-20
UPDATE public.sailors SET dob = '2011-05-20' WHERE id = 'dfd246af-af84-5079-b4a9-341d34fa8479'::uuid AND dob IS NULL;
-- Platon Kuzmenko (ESP) -> World Sailing: Platon Kuzmenko [ESPPK2] | DOB: 2008-05-09
UPDATE public.sailors SET dob = '2008-05-09' WHERE id = '09e553ec-35f2-5a56-ad5c-6aec7a889346'::uuid AND dob IS NULL;
-- Valentina Cifre Garcia (ESP) -> World Sailing: VALENTINA CIFRE Garcia [ESPVC18] | DOB: 2011-07-11
UPDATE public.sailors SET dob = '2011-07-11' WHERE id = '5ac3dc36-1b71-5b57-99ae-f762617cb4d3'::uuid AND dob IS NULL;
-- Christofer Kasin (EST) -> World Sailing: Christofer Kasin [ESTCK3] | DOB: 2013-12-18
UPDATE public.sailors SET dob = '2013-12-18' WHERE id = '2211d8ea-168a-5295-9f10-d8c6ddbd3e0f'::uuid AND dob IS NULL;
-- Robert Matt (EST) -> World Sailing: Robert Matt [ESTRM5] | DOB: 2012-12-21
UPDATE public.sailors SET dob = '2012-12-21' WHERE id = '449a7aba-5446-5492-86d8-d5e7ea63d5c8'::uuid AND dob IS NULL;
-- Malia Sukanavanua (FIJ) -> World Sailing: Malia Sukanavanua [FIJMS1] | DOB: 2011-10-04
UPDATE public.sailors SET dob = '2011-10-04' WHERE id = '99f33497-e97c-4232-9be9-229eaecaf8e6'::uuid AND dob IS NULL;
-- Elsi Grönholm (FIN) -> World Sailing: Elsi Grönholm [FINEG5] | DOB: 2011-07-24
UPDATE public.sailors SET dob = '2011-07-24' WHERE id = '65cf516e-c694-5ba6-ad9c-2d17209c4232'::uuid AND dob IS NULL;
-- Alizée Chinot (FRA) -> World Sailing: Alizée CHINOT [FRAAC122] | DOB: 2008-08-04
UPDATE public.sailors SET dob = '2008-08-04' WHERE id = 'f83bce39-e933-5471-8206-8eeb2ff5128f'::uuid AND dob IS NULL;
-- Baptiste Loire (FRA) -> World Sailing: Baptiste Loire [FRABL59] | DOB: 2009-07-07
UPDATE public.sailors SET dob = '2009-07-07' WHERE id = 'e34d9c2a-a50a-50ef-8e1d-b9b054011563'::uuid AND dob IS NULL;
-- Bastien Cerrato (FRA) -> World Sailing: Bastien CERRATO [FRABC75] | DOB: 2011-11-14
UPDATE public.sailors SET dob = '2011-11-14' WHERE id = '06e85e75-987c-50be-99ba-2e2553587505'::uuid AND dob IS NULL;
-- Enoha Laurent (FRA) -> World Sailing: ENOHA LAURENT [FRAEL88] | DOB: 2010-08-27
UPDATE public.sailors SET dob = '2010-08-27' WHERE id = 'dbc2496e-bb1c-553d-a19a-2601cf6c92bb'::uuid AND dob IS NULL;
-- Lilou Backes (FRA) -> World Sailing: Lilou BACKES [FRALB105] | DOB: 2013-10-24
UPDATE public.sailors SET dob = '2013-10-24' WHERE id = 'f7aff6ef-837b-5e48-be7d-72ff7050c7bb'::uuid AND dob IS NULL;
-- Paul Lenoir (FRA) -> World Sailing: Paul LENOIR [FRAPL96] | DOB: 2013-11-10
UPDATE public.sailors SET dob = '2013-11-10' WHERE id = '044dcc66-6fa6-5cc6-8ab1-fc652531fdf0'::uuid AND dob IS NULL;
-- Finn Ramus (GBR) -> World Sailing: Finn Ramus [GBRFR12] | DOB: 2011-02-18
UPDATE public.sailors SET dob = '2011-02-18' WHERE id = '334e7864-c1c2-4473-a72f-8f11181aec1e'::uuid AND dob IS NULL;
-- Hugo Fletcher (GBR) -> World Sailing: Hugo Fletcher [GBRHF25] | DOB: 2010-04-14
UPDATE public.sailors SET dob = '2010-04-14' WHERE id = '0f141f8e-dc8f-4efd-8438-6e2cb6a5e11e'::uuid AND dob IS NULL;
-- Isabelle Fellows (GBR) -> World Sailing: Isabelle Fellows [GBRIF12] | DOB: 1999-10-11
UPDATE public.sailors SET dob = '1999-10-11' WHERE id = '2f818c8a-bd29-5972-b81a-ae8f25b65d10'::uuid AND dob IS NULL;
-- Jacques Kent (GBR) -> World Sailing: Jacques Kent [GBRJK58] | DOB: 2011-08-30
UPDATE public.sailors SET dob = '2011-08-30' WHERE id = '53e893de-fbde-5f41-9c18-1e1eb71ce507'::uuid AND dob IS NULL;
-- Nick Goodchild (GBR) -> World Sailing: Nick Goodchild [GBRNG43] | DOB: 1980-01-23
UPDATE public.sailors SET dob = '1980-01-23' WHERE id = '8a0e074d-57d3-587c-81fd-a211ed37dd16'::uuid AND dob IS NULL;
-- Pippa Shepherd (GBR) -> World Sailing: Pippa Shepherd [GBRPS100] | DOB: 2010-02-26
UPDATE public.sailors SET dob = '2010-02-26' WHERE id = '1833a3a7-5adc-4144-b479-68756ac2b7e6'::uuid AND dob IS NULL;
-- Ruby Holmes (GBR) -> World Sailing: Ruby Holmes [GBRRH127] | DOB: 2011-04-08
UPDATE public.sailors SET dob = '2011-04-08' WHERE id = '9306c824-5006-51d6-9c6f-34daaa4b5dd7'::uuid AND dob IS NULL;
-- Thomas Keegan (GBR) -> World Sailing: Thomas Keegan [GBRTK28] | DOB: 2012-01-21
UPDATE public.sailors SET dob = '2012-01-21' WHERE id = '90ce7edb-6fef-5e35-882e-6b07626c9634'::uuid AND dob IS NULL;
-- William Woolston (GBR) -> World Sailing: William Woolston [GBRWW31] | DOB: 2006-02-04
UPDATE public.sailors SET dob = '2006-02-04' WHERE id = 'f2d90982-885f-501f-9bdf-a461bffdb701'::uuid AND dob IS NULL;
-- Giorgi Grigolia (GEO) -> World Sailing: Giorgi Grigolia [GEOGG2] | DOB: 2015-05-20
UPDATE public.sailors SET dob = '2015-05-20' WHERE id = 'ae811564-cf8e-5b81-a776-3500ffafd467'::uuid AND dob IS NULL;
-- Bent Goldenbow (GER) -> World Sailing: Bent Goldenbow [GERBG21] | DOB: 2013-01-22
UPDATE public.sailors SET dob = '2013-01-22' WHERE id = '29350185-2d00-5fc2-942d-7a3ecf66d7e8'::uuid AND dob IS NULL;
-- Gustaf Schimanski (GER) -> World Sailing: Gustaf Schimanski [GERGS38] | DOB: 2014-02-28
UPDATE public.sailors SET dob = '2014-02-28' WHERE id = '6701677c-125f-5ed2-8c20-eadab37886aa'::uuid AND dob IS NULL;
-- Paris Kolokotronis (GRE) -> World Sailing: Paris Kolokotronis [GREPK40] | DOB: 2010-07-27
UPDATE public.sailors SET dob = '2010-07-27' WHERE id = '265bf7c3-bd8e-5be2-8cb3-9a21cd69488d'::uuid AND dob IS NULL;
-- Adam Huxley Cheng Hou Kan (HKG) -> World Sailing: Adam Huxley Cheng Hou Kan [HKGAK2] | DOB: 2011-05-06
UPDATE public.sailors SET dob = '2011-05-06' WHERE id = '058e8046-aa70-5145-9b4f-2270f6683891'::uuid AND dob IS NULL;
-- Allan McDonald (HKG) -> World Sailing: Allan McDonald [HKGAM5] | DOB: 2012-11-16
UPDATE public.sailors SET dob = '2012-11-16' WHERE id = '90be5de1-70f1-455b-8d51-b69637bb8f0c'::uuid AND dob IS NULL;
-- Ayden Pang (HKG) -> World Sailing: Ayden Pang [HKGAP4] | DOB: 2007-12-01
UPDATE public.sailors SET dob = '2007-12-01' WHERE id = 'c53b02b5-9285-5325-9edd-12e07f01e4e1'::uuid AND dob IS NULL;
-- Bernice Pang (HKG) -> World Sailing: Bernice Pang [HKGBP1] | DOB: 2009-08-01
UPDATE public.sailors SET dob = '2009-08-01' WHERE id = '7a100c0d-c2d4-5355-988a-90ca7ab2d776'::uuid AND dob IS NULL;
-- Carine Leung (HKG) -> World Sailing: Carine Leung [HKGCL27] | DOB: 2011-01-31
UPDATE public.sailors SET dob = '2011-01-31' WHERE id = '8569264f-6410-4308-b9e2-222e3a1af748'::uuid AND dob IS NULL;
-- Charalampos Velianitis (HKG) -> World Sailing: Charalampos Velianitis [HKGCV1] | DOB: 2008-06-24
UPDATE public.sailors SET dob = '2008-06-24' WHERE id = '1efbd4b8-343f-43e4-bcce-659e65a06e56'::uuid AND dob IS NULL;
-- Chiying Ng (HKG) -> World Sailing: Chiying Ng [HKGCN2] | DOB: 2010-07-16
UPDATE public.sailors SET dob = '2010-07-16' WHERE id = '80e86b2d-0731-5ad8-a303-fb7fc53ae46e'::uuid AND dob IS NULL;
-- Era Lin (HKG) -> World Sailing: Era Lin [HKGEL6] | DOB: 2001-06-19
UPDATE public.sailors SET dob = '2001-06-19' WHERE id = '4efa5a7e-e5e0-57b7-bf93-530b137991ea'::uuid AND dob IS NULL;
-- Hantao Zhou (HKG) -> World Sailing: Hantao Zhou [HKGHZ4] | DOB: 2012-08-23
UPDATE public.sailors SET dob = '2012-08-23' WHERE id = '1786db56-c0d4-591a-abbe-ca84f336058c'::uuid AND dob IS NULL;
-- Lok Hin Luk (HKG) -> World Sailing: Lok Hin Luk [HKGLL8] | DOB: 2005-09-28
UPDATE public.sailors SET dob = '2005-09-28' WHERE id = 'd93fa781-901e-5532-bbc2-c38a9f653fb0'::uuid AND dob IS NULL;
-- Louis Polson (HKG) -> World Sailing: Louis Polson [HKGLP1] | DOB: 2011-06-08
UPDATE public.sailors SET dob = '2011-06-08' WHERE id = '3e1da03f-d00f-5604-b46e-716456fd72ee'::uuid AND dob IS NULL;
-- Mack Wong (HKG) -> World Sailing: Mack Wong [HKGMW4] | DOB: 2009-10-19
UPDATE public.sailors SET dob = '2009-10-19' WHERE id = '983252bf-8a99-5f85-a6ea-837957551ac6'::uuid AND dob IS NULL;
-- McCarley Wong (HKG) -> World Sailing: McCarley WONG [HKGMW6] | DOB: 2008-06-25
UPDATE public.sailors SET dob = '2008-06-25' WHERE id = '0035813f-6b37-5dad-970e-1d43e5fde57c'::uuid AND dob IS NULL;
-- Meghan Cohen-Addad (HKG) -> World Sailing: Meghan Cohen-Addad [HKGMC16] | DOB: 2013-09-09
UPDATE public.sailors SET dob = '2013-09-09' WHERE id = '6c2afa7d-2cd5-4eec-8869-3cbc3c2fcede'::uuid AND dob IS NULL;
-- Owen Ou (HKG) -> World Sailing: Owen Ou [HKGOO1] | DOB: 2011-12-29
UPDATE public.sailors SET dob = '2011-12-29' WHERE id = '4b6e6b85-ad06-5f70-aba9-242c899d8c30'::uuid AND dob IS NULL;
-- Peter Jessop (HKG) -> World Sailing: Peter Jessop [HKGPJ2] | DOB: 2008-05-09
UPDATE public.sailors SET dob = '2008-05-09' WHERE id = '3df2c6a7-b3fa-5b9d-80a8-20e66638c2f5'::uuid AND dob IS NULL;
-- Sirui Huang (HKG) -> World Sailing: SIRUI HUANG [HKGSH3] | DOB: 2013-12-26
UPDATE public.sailors SET dob = '2013-12-26' WHERE id = '2d1c8bed-36a9-5332-8cd4-89f0b6657f28'::uuid AND dob IS NULL;
-- Wanzhi Elva Li (HKG) -> World Sailing: Wanzhi Elva Li [HKGWL9] | DOB: 2011-02-07
UPDATE public.sailors SET dob = '2011-02-07' WHERE id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b'::uuid AND dob IS NULL;
-- Xavier Wilde (HKG) -> World Sailing: Xavier Wilde [HKGXW2] | DOB: 2010-04-12
UPDATE public.sailors SET dob = '2010-04-12' WHERE id = '3a1abf10-28a8-55a8-95be-53f5a8d13ed9'::uuid AND dob IS NULL;
-- Balazs Vincze (HUN) -> World Sailing: Balazs Vincze [HUNBV5] | DOB: 1983-05-07
UPDATE public.sailors SET dob = '1983-05-07' WHERE id = '1354dfd0-b9aa-49d2-976c-b7e8cb840d91'::uuid AND dob IS NULL;
-- Gabor Csaszar (HUN) -> World Sailing: Gabor Csaszar [HUNGC8] | DOB: 2011-12-29
UPDATE public.sailors SET dob = '2011-12-29' WHERE id = '7afa46d2-43bd-57a7-a7fb-e834b1c94b5f'::uuid AND dob IS NULL;
-- Kora Polacsko-Szenasi (HUN) -> World Sailing: Kora Polacsko-Szenasi [HUNKP7] | DOB: 2014-08-28
UPDATE public.sailors SET dob = '2014-08-28' WHERE id = '8e072380-7c85-5754-8b72-5cbd3ceca3d5'::uuid AND dob IS NULL;
-- Alif Thaariq Sutrisno (INA) -> World Sailing: Alif thaariq Sutrisno [INAAS3] | DOB: 1999-08-29
UPDATE public.sailors SET dob = '1999-08-29' WHERE id = '2c76ae25-c4e6-5bdd-8ef4-a1935ef47fcf'::uuid AND dob IS NULL;
-- Gregory Roger Wardojo (INA) -> World Sailing: Gregory Roger Wardojo [INAGW1] | DOB: 2002-08-14
UPDATE public.sailors SET dob = '2002-08-14' WHERE id = 'd2d167b4-52fc-532a-8d72-11ffb103a300'::uuid AND dob IS NULL;
-- Kirana Wardojo (INA) -> World Sailing: Kirana Wardojo [INAKW1] | DOB: 1999-03-14
UPDATE public.sailors SET dob = '1999-03-14' WHERE id = '79c6406b-143d-542d-a3fc-b8a328b93f96'::uuid AND dob IS NULL;
-- Omar Agoes (INA) -> World Sailing: Omar Agoes [INAOA1] | DOB: 1972-03-14
UPDATE public.sailors SET dob = '1972-03-14' WHERE id = '0951d7ed-7faf-4fab-a660-ca9bb034dc4d'::uuid AND dob IS NULL;
-- Anshu Yadav (IND) -> World Sailing: Anshu Yadav [INDAY6] | DOB: 2009-01-17
UPDATE public.sailors SET dob = '2009-01-17' WHERE id = '12eea3c7-a3f1-52e0-a805-156f9fe959a6'::uuid AND dob IS NULL;
-- Badrinath Nirudu (IND) -> World Sailing: Badrinath Nirudu [INDBN2] | DOB: 2011-08-29
UPDATE public.sailors SET dob = '2011-08-29' WHERE id = '6808bfda-3c71-4f2f-b348-3e033d6fd86c'::uuid AND dob IS NULL;
-- Luv Sakpal (IND) -> World Sailing: Luv Sakpal [INDLS3] | DOB: 2006-09-24
UPDATE public.sailors SET dob = '2006-09-24' WHERE id = 'd3cee486-e212-55da-a651-a9f268c665ed'::uuid AND dob IS NULL;
-- Naavya Kaku (IND) -> World Sailing: NAAVYA KAKU [INDNK5] | DOB: 2013-09-12
UPDATE public.sailors SET dob = '2013-09-12' WHERE id = '55dc6187-4dba-4ea4-a471-8ae326e2f5e9'::uuid AND dob IS NULL;
-- Ovie Nair Shaffi (IND) -> World Sailing: Ovie Nair Shaffi [INDON1] | DOB: 2009-01-07
UPDATE public.sailors SET dob = '2009-01-07' WHERE id = '085b8740-0b8a-4773-a645-c5444cdb033e'::uuid AND dob IS NULL;
-- Priyanshi Patil (IND) -> World Sailing: Priyanshi Patil [INDPP13] | DOB: 2012-04-05
UPDATE public.sailors SET dob = '2012-04-05' WHERE id = 'd3c196d0-0d41-4ff1-83e6-0cb2fa7c1831'::uuid AND dob IS NULL;
-- Sai Patil (IND) -> World Sailing: Sai Patil [INDSP21] | DOB: 2008-10-15
UPDATE public.sailors SET dob = '2008-10-15' WHERE id = '6d854ee4-0227-4dfa-a86e-ad75f4a6b5f0'::uuid AND dob IS NULL;
-- Sanjana Bhasin (IND) -> World Sailing: Sanjana Bhasin [INDSB12] | DOB: 2009-10-15
UPDATE public.sailors SET dob = '2009-10-15' WHERE id = '25b634be-2ebc-54d9-bfa6-3b2b38bc63cf'::uuid AND dob IS NULL;
-- Sumant Arunachalam (IND) -> World Sailing: Sumant Arunachalam [INDSA6] | DOB: 2006-11-01
UPDATE public.sailors SET dob = '2006-11-01' WHERE id = '4169ee8d-16da-57a3-b36d-e4961251a34d'::uuid AND dob IS NULL;
-- Vinod Dandu (IND) -> World Sailing: Vinod Dandu [INDVD1] | DOB: 2011-01-06
UPDATE public.sailors SET dob = '2011-01-06' WHERE id = '78fa82e7-f50b-4c47-88bc-f84a195f6a5a'::uuid AND dob IS NULL;
-- Emily Donagh (IRL) -> World Sailing: Emily Donagh [IRLED13] | DOB: 2011-08-18
UPDATE public.sailors SET dob = '2011-08-18' WHERE id = 'abe00407-0b6b-51ef-996c-8029c5485666'::uuid AND dob IS NULL;
-- Felix Crinion (IRL) -> World Sailing: Felix Crinion [IRLFC20] | DOB: 2012-09-06
UPDATE public.sailors SET dob = '2012-09-06' WHERE id = '63e7e3df-b70c-555d-8d1f-16d49c808fd2'::uuid AND dob IS NULL;
-- Holly Cantwell (IRL) -> World Sailing: Holly Cantwell [IRLHC10] | DOB: 2011-12-06
UPDATE public.sailors SET dob = '2011-12-06' WHERE id = '6530fa88-9a13-52e8-a9ab-ad59c577560a'::uuid AND dob IS NULL;
-- Isaac Vaughan (IRL) -> World Sailing: isaac vaughan [IRLIV2] | DOB: 2012-02-03
UPDATE public.sailors SET dob = '2012-02-03' WHERE id = 'e70e6a88-d887-5af7-b7fd-e86ac8836acc'::uuid AND dob IS NULL;
-- Philippa Arthurs (IRL) -> World Sailing: Philippa Arthurs [IRLPA6] | DOB: 2012-07-02
UPDATE public.sailors SET dob = '2012-07-02' WHERE id = 'ae201856-26e5-52e0-9b86-8d6dbf9687cb'::uuid AND dob IS NULL;
-- Andrea Demurtas (ITA) -> World Sailing: ANDREA DEMURTAS [ITAAD165] | DOB: 2011-03-12
UPDATE public.sailors SET dob = '2011-03-12' WHERE id = '3f0bcba1-9d94-59aa-acf7-fcb8a7dbc00e'::uuid AND dob IS NULL;
-- Anna Chiara Merlo (ITA) -> World Sailing: Anna Chiara Merlo [ITAAM257] | DOB: 2009-07-09
UPDATE public.sailors SET dob = '2009-07-09' WHERE id = 'e59e7866-2b57-4edb-8f12-d1a593854433'::uuid AND dob IS NULL;
-- Bianca Marchesini (ITA) -> World Sailing: Bianca Marchesini [ITABM42] | DOB: 2010-08-25
UPDATE public.sailors SET dob = '2010-08-25' WHERE id = '84741e8c-41c5-407f-b8d1-16eda8644e13'::uuid AND dob IS NULL;
-- Filippo Nardocci (ITA) -> World Sailing: Filippo Nardocci [ITAFN35] | DOB: 2013-07-09
UPDATE public.sailors SET dob = '2013-07-09' WHERE id = 'acf03c42-a8e2-5e78-bd5b-338aeaf2d67b'::uuid AND dob IS NULL;
-- Irene Cozzolino (ITA) -> World Sailing: Irene COZZOLINO [ITAIC20] | DOB: 2011-03-18
UPDATE public.sailors SET dob = '2011-03-18' WHERE id = '72a04f83-c2d5-682e-fd04-76e01c6a072b'::uuid AND dob IS NULL;
-- Leandro Scialpi (ITA) -> World Sailing: LEANDRO SCIALPI [ITALS130] | DOB: 2010-10-20
UPDATE public.sailors SET dob = '2010-10-20' WHERE id = '739bafaf-746d-b574-b00f-bbcdb24b955b'::uuid AND dob IS NULL;
-- Mattia Di Martino (ITA) -> World Sailing: Mattia Di Martino [ITAMD201] | DOB: 2009-02-25
UPDATE public.sailors SET dob = '2009-02-25' WHERE id = '665e0fd0-ac67-4ec3-8299-674eeeaed5a3'::uuid AND dob IS NULL;
-- Pietro Lucchesi (ITA) -> World Sailing: Pietro Lucchesi [ITAPL36] | DOB: 2011-08-09
UPDATE public.sailors SET dob = '2011-08-09' WHERE id = '6a6cc356-8999-4bd0-89a9-064183047d42'::uuid AND dob IS NULL;
-- Sara Anzellotti (ITA) -> World Sailing: Sara Anzellotti [ITASA51] | DOB: 2009-09-08
UPDATE public.sailors SET dob = '2009-09-08' WHERE id = '32066b3f-df93-42f6-b661-87b8b9fcdcd5'::uuid AND dob IS NULL;
-- Daiki Tanaka (JPN) -> World Sailing: Daiki Tanaka [JPNDT3] | DOB: 2010-06-28
UPDATE public.sailors SET dob = '2010-06-28' WHERE id = 'c3fd872d-5143-537e-9b7e-6d600698b8d1'::uuid AND dob IS NULL;
-- Haru Okada (JPN) -> World Sailing: HARU OKADA [JPNHO13] | DOB: 2010-02-02
UPDATE public.sailors SET dob = '2010-02-02' WHERE id = '925c5c1f-89e3-56b1-a55a-6710f685f836'::uuid AND dob IS NULL;
-- Hiroto Hayakawa (JPN) -> World Sailing: Hiroto Hayakawa [JPNHH16] | DOB: 2005-06-10
UPDATE public.sailors SET dob = '2005-06-10' WHERE id = '0fec5c2e-b0ae-5f30-a16c-28530ca3ab5e'::uuid AND dob IS NULL;
-- Hozumi Mitani (JPN) -> World Sailing: Hozumi Mitani [JPNHM33] | DOB: 2007-09-01
UPDATE public.sailors SET dob = '2007-09-01' WHERE id = '9273ce46-fe2e-5658-b104-c000d5da8286'::uuid AND dob IS NULL;
-- Izuho Nakagawa (JPN) -> World Sailing: izuho nakagawa [JPNIN3] | DOB: 2010-02-20
UPDATE public.sailors SET dob = '2010-02-20' WHERE id = '1fe3068b-75d8-5e02-95ed-3091397cb211'::uuid AND dob IS NULL;
-- Kizuku Otsubo (JPN) -> World Sailing: Kizuku Otsubo [JPNKO30] | DOB: 2010-01-07
UPDATE public.sailors SET dob = '2010-01-07' WHERE id = 'e7c0d225-0597-5c0a-9c12-a52a252b430e'::uuid AND dob IS NULL;
-- Kokone Imaizumi (JPN) -> World Sailing: Kokone Imaizumi [JPNKI49] | DOB: 2008-02-14
UPDATE public.sailors SET dob = '2008-02-14' WHERE id = 'cf1098b5-824f-5cb8-a1c2-6520bf00f8ac'::uuid AND dob IS NULL;
-- Koyo Nishimura (JPN) -> World Sailing: Koyo Nishimura [JPNKN45] | DOB: 2009-08-01
UPDATE public.sailors SET dob = '2009-08-01' WHERE id = '214f82fe-8d5a-5467-ad7d-91538135ca86'::uuid AND dob IS NULL;
-- Maiko Higaki (JPN) -> World Sailing: Maiko Higaki [JPNMH30] | DOB: 2015-02-23
UPDATE public.sailors SET dob = '2015-02-23' WHERE id = 'd4749289-b2f3-5607-9ae1-fa33bdbcdad5'::uuid AND dob IS NULL;
-- Masato Kozono (JPN) -> World Sailing: Masato Kozono [JPNMK47] | DOB: 2008-01-23
UPDATE public.sailors SET dob = '2008-01-23' WHERE id = '3e471eca-8ea2-4581-b1aa-ba927a70b474'::uuid AND dob IS NULL;
-- Nana Funazawa (JPN) -> World Sailing: Nana Funazawa [JPNNF8] | DOB: 2007-10-19
UPDATE public.sailors SET dob = '2007-10-19' WHERE id = '5ec2f363-6683-5607-8bd8-b2984890b6c2'::uuid AND dob IS NULL;
-- Nanako Higaki (JPN) -> World Sailing: Nanako Higaki [JPNNH10] | DOB: 2013-01-25
UPDATE public.sailors SET dob = '2013-01-25' WHERE id = 'c764b218-e565-5b0b-905e-d56b0c7d4a9d'::uuid AND dob IS NULL;
-- Naoki Sato (JPN) -> World Sailing: Naoki Sato [JPNNS12] | DOB: 2008-05-02
UPDATE public.sailors SET dob = '2008-05-02' WHERE id = 'ac34f6c4-dc1d-5fc7-81b0-1b5003d913ec'::uuid AND dob IS NULL;
-- Riho Sanematsu (JPN) -> World Sailing: riho sanematsu [JPNRS11] | DOB: 2008-04-19
UPDATE public.sailors SET dob = '2008-04-19' WHERE id = 'a63cb70f-12ad-480b-8fd6-f919ceea28f3'::uuid AND dob IS NULL;
-- Ryo Mizusawa (JPN) -> World Sailing: Ryo Mizusawa [JPNRM23] | DOB: 2008-08-07
UPDATE public.sailors SET dob = '2008-08-07' WHERE id = '1b7b24d6-73be-5e9e-9c3c-d2c547bbf760'::uuid AND dob IS NULL;
-- Ryusei Toyozumi (JPN) -> World Sailing: ryusei toyozumi [JPNRT14] | DOB: 2009-11-21
UPDATE public.sailors SET dob = '2009-11-21' WHERE id = 'f3067517-6265-457b-a621-4b8bd67ca8b1'::uuid AND dob IS NULL;
-- Sosuke Inaba (JPN) -> World Sailing: SOSUKE INABA [JPNSI19] | DOB: 2010-11-24
UPDATE public.sailors SET dob = '2010-11-24' WHERE id = '674f9bc2-4a18-5325-b0c5-b50cb0b1d46e'::uuid AND dob IS NULL;
-- Tomoharu Shiratori (JPN) -> World Sailing: Tomoharu Shiratori [JPNTS50] | DOB: 2009-03-10
UPDATE public.sailors SET dob = '2009-03-10' WHERE id = 'b3bdcadb-0d08-413f-9f25-91fba40a802a'::uuid AND dob IS NULL;
-- Tomohiro Kawakita (JPN) -> World Sailing: Tomohiro Kawakita [JPNTK51] | DOB: 2009-03-21
UPDATE public.sailors SET dob = '2009-03-21' WHERE id = '3e5c315f-7c0b-4888-8f3b-61a735092505'::uuid AND dob IS NULL;
-- Toshitada Higaki (JPN) -> World Sailing: Toshitada Higaki [JPNTH31] | DOB: 2010-09-29
UPDATE public.sailors SET dob = '2010-09-29' WHERE id = 'a79fd718-f18f-596a-8548-70605f2b3452'::uuid AND dob IS NULL;
-- Yuka Kubota (JPN) -> World Sailing: Yuka Kubota [JPNYK49] | DOB: 2009-03-07
UPDATE public.sailors SET dob = '2009-03-07' WHERE id = 'e09f7ecb-f03a-5cc0-bbf7-38f2c588cf6a'::uuid AND dob IS NULL;
-- Yuzuki Kubota (JPN) -> World Sailing: YUZUKI KUBOTA [JPNYK39] | DOB: 2013-12-09
UPDATE public.sailors SET dob = '2013-12-09' WHERE id = '2e14e145-fef6-5982-b963-d801f1bb6a31'::uuid AND dob IS NULL;
-- Yuzuki Yoshioka (JPN) -> World Sailing: Yuzuki Yoshioka [JPNYY18] | DOB: 2012-06-29
UPDATE public.sailors SET dob = '2012-06-29' WHERE id = 'e373e71d-025b-55b0-acf6-ce6dfb8eb06c'::uuid AND dob IS NULL;
-- Ivanov Ilya (KAZ) -> World Sailing: Ivanov Ilya [KAZII1] | DOB: 2010-06-17
UPDATE public.sailors SET dob = '2010-06-17' WHERE id = 'e4de7f08-2ddc-578b-b2cd-db9ec7152e05'::uuid AND dob IS NULL;
-- Otegen Shyngys (KAZ) -> World Sailing: OTEGEN SHYNGYS [KAZOS1] | DOB: 2007-04-17
UPDATE public.sailors SET dob = '2007-04-17' WHERE id = '5e91e718-63f1-5fc6-8e86-3b1df4857321'::uuid AND dob IS NULL;
-- Yerkebulan Sardarbekov (KAZ) -> World Sailing: Yerkebulan Sardarbekov [KAZYS1] | DOB: 2006-03-04
UPDATE public.sailors SET dob = '2006-03-04' WHERE id = '49e37e87-02fe-5b3a-b081-77312424e6ab'::uuid AND dob IS NULL;
-- Hyein Lee (KOR) -> World Sailing: hyein lee [KORHL10] | DOB: 2009-04-17
UPDATE public.sailors SET dob = '2009-04-17' WHERE id = 'a41bf47a-883a-577e-9493-e7fb8bfebf96'::uuid AND dob IS NULL;
-- Jaemin Yoo (KOR) -> World Sailing: JaeMin Yoo [KORJY9] | DOB: 2008-01-19
UPDATE public.sailors SET dob = '2008-01-19' WHERE id = '7ee0b8e9-a533-55b6-9d84-f329e3ca4819'::uuid AND dob IS NULL;
-- Jiho Yoo (KOR) -> World Sailing: Jiho Yoo [KORJY7] | DOB: 2011-07-05
UPDATE public.sailors SET dob = '2011-07-05' WHERE id = 'cb88ac82-b4e7-5945-b345-fbe3d2b33745'::uuid AND dob IS NULL;
-- Jihyeok Yoo (KOR) -> World Sailing: Jihyeok Yoo [KORJY8] | DOB: 2011-07-05
UPDATE public.sailors SET dob = '2011-07-05' WHERE id = '20f258f8-799b-57d0-90d0-1c6d1cf76505'::uuid AND dob IS NULL;
-- Minkwan Chang (KOR) -> World Sailing: minkwan chang [KORMC3] | DOB: 2012-09-07
UPDATE public.sailors SET dob = '2012-09-07' WHERE id = '1aa36e44-2f42-4f33-a30e-81ffaf66337b'::uuid AND dob IS NULL;
-- Raon Kim (KOR) -> World Sailing: RAON KIM [KORRK1] | DOB: 2012-01-03
UPDATE public.sailors SET dob = '2012-01-03' WHERE id = 'f47be704-3a2b-4fcb-a1d9-d3d53a246681'::uuid AND dob IS NULL;
-- Siyou Sung (KOR) -> World Sailing: siyou sung [KORSS8] | DOB: 2005-02-21
UPDATE public.sailors SET dob = '2005-02-21' WHERE id = '7c3fec16-1a4b-596e-aebf-ed02c0beb585'::uuid AND dob IS NULL;
-- Taerin Kim (KOR) -> World Sailing: taerin Kim [KORTK7] | DOB: 2008-05-11
UPDATE public.sailors SET dob = '2008-05-11' WHERE id = '9c0c85a6-95b5-5578-8743-f0491d93602f'::uuid AND dob IS NULL;
-- Ameena Shah (KUW) -> World Sailing: Ameena Shah [KUWAS2] | DOB: 2001-01-24
UPDATE public.sailors SET dob = '2001-01-24' WHERE id = 'c8aa8931-e608-5dd1-bb56-7babc54470c1'::uuid AND dob IS NULL;
-- Damir Djesevic (MNE) -> World Sailing: Damir Djesevic [MNEDD1] | DOB: 2012-07-13
UPDATE public.sailors SET dob = '2012-07-13' WHERE id = 'a90941e6-dd48-5f0b-9f8f-f3314564e19f'::uuid AND dob IS NULL;
-- Risto Milojevic (MNE) -> World Sailing: Risto Milojevic [MNERM1] | DOB: 2012-10-01
UPDATE public.sailors SET dob = '2012-10-01' WHERE id = '3c37e208-2064-54b4-9fe1-1040b9aaaff7'::uuid AND dob IS NULL;
-- Valentina Djordjevic (MNE) -> World Sailing: Valentina Djordjevic [MNEVD1] | DOB: 2012-10-17
UPDATE public.sailors SET dob = '2012-10-17' WHERE id = '560238b4-d809-5381-9eca-0d13a34e5d25'::uuid AND dob IS NULL;
-- Annemijn De Ridder (NED) -> World Sailing: Annemijn de Ridder [NEDAD32] | DOB: 2013-01-25
UPDATE public.sailors SET dob = '2013-01-25' WHERE id = '32326c58-aab9-5a7f-b595-41bafea2fb92'::uuid AND dob IS NULL;
-- Benthe Van Rooij (NED) -> World Sailing: Benthe van Rooij [NEDBV51] | DOB: 2012-04-14
UPDATE public.sailors SET dob = '2012-04-14' WHERE id = '7710f9cd-e712-56ef-834e-56355e8371cf'::uuid AND dob IS NULL;
-- Hendrik Wismeijer (NED) -> World Sailing: Hendrik Wismeijer [NEDHW12] | DOB: 2011-06-05
UPDATE public.sailors SET dob = '2011-06-05' WHERE id = '850799a8-48a4-5f2c-a301-504dff753ece'::uuid AND dob IS NULL;
-- Liselot Bijlsma (NED) -> World Sailing: Liselot Bijlsma [NEDLB17] | DOB: 2012-04-08
UPDATE public.sailors SET dob = '2012-04-08' WHERE id = '047f8f26-777f-5cb2-b184-8b0dc7375faf'::uuid AND dob IS NULL;
-- Liv Jägers (NED) -> World Sailing: Liv Jägers [NEDLJ4] | DOB: 2011-06-03
UPDATE public.sailors SET dob = '2011-06-03' WHERE id = '381b0046-0cbe-5051-95a8-f66e0d982f3c'::uuid AND dob IS NULL;
-- Luc Van Rooij (NED) -> World Sailing: Luc van Rooij [NEDLV49] | DOB: 2010-05-09
UPDATE public.sailors SET dob = '2010-05-09' WHERE id = '40e26eca-67b8-4f04-8ade-6cbf0b45e5d8'::uuid AND dob IS NULL;
-- Nicholas Koekkoek (NED) -> World Sailing: Nicholas Koekkoek [NEDNK11] | DOB: 2011-04-08
UPDATE public.sailors SET dob = '2011-04-08' WHERE id = '7e974e24-ec93-5bfd-a16e-2e89c4c1dfe9'::uuid AND dob IS NULL;
-- Torre De Leeuw (NED) -> World Sailing: Torre de Leeuw [NEDTD20] | DOB: 2011-09-23
UPDATE public.sailors SET dob = '2011-09-23' WHERE id = '00bd0dc2-bfe4-5e69-ade2-9fdd4e64e71a'::uuid AND dob IS NULL;
-- Axel Espeli-Blankholm (NOR) -> World Sailing: Axel Espeli-Blankholm [NORAE7] | DOB: 2009-07-31
UPDATE public.sailors SET dob = '2009-07-31' WHERE id = '559456f1-1ac1-5a06-aed5-a816bd556070'::uuid AND dob IS NULL;
-- David Bratli (NOR) -> World Sailing: David Bratli [NORDB7] | DOB: 2008-10-18
UPDATE public.sailors SET dob = '2008-10-18' WHERE id = 'f8e81dde-809d-5703-a5d9-46371f4eb9cd'::uuid AND dob IS NULL;
-- Jonathan Bleikvin (NOR) -> World Sailing: Jonathan Bleikvin [NORJB17] | DOB: 2006-10-25
UPDATE public.sailors SET dob = '2006-10-25' WHERE id = '6df74fc6-02fb-5c0e-914b-04ceed664af6'::uuid AND dob IS NULL;
-- Blake Batten (NZL) -> World Sailing: Blake Batten [NZLBB11] | DOB: 2010-09-06
UPDATE public.sailors SET dob = '2010-09-06' WHERE id = 'eadffdaa-a56d-4954-ad10-6ed291c0710e'::uuid AND dob IS NULL;
-- Finloe Gaites (NZL) -> World Sailing: Finloe Gaites [NZLFG3] | DOB: 2012-03-19
UPDATE public.sailors SET dob = '2012-03-19' WHERE id = '202f4bec-2441-4d56-90f2-d9dbe79d9cc0'::uuid AND dob IS NULL;
-- Luca Blundell (NZL) -> World Sailing: Luca Blundell [NZLLB6] | DOB: 2010-05-06
UPDATE public.sailors SET dob = '2010-05-06' WHERE id = '054abe5a-284d-4b32-9667-6b122a389008'::uuid AND dob IS NULL;
-- Zofia Wells (NZL) -> World Sailing: Zofia Wells [NZLZW1] | DOB: 2011-10-17
UPDATE public.sailors SET dob = '2011-10-17' WHERE id = 'bb76c3b0-ff83-4036-b394-81810960a177'::uuid AND dob IS NULL;
-- Antonio Remy (PER) -> World Sailing: Antonio Remy [PERAR6] | DOB: 2014-07-14
UPDATE public.sailors SET dob = '2014-07-14' WHERE id = 'cda568e3-7d30-5857-a19d-1cc8f4245d4e'::uuid AND dob IS NULL;
-- Carolina Cadarso (PER) -> World Sailing: Carolina Cadarso [PERCC1] | DOB: 2013-06-17
UPDATE public.sailors SET dob = '2013-06-17' WHERE id = '81a6424e-e5bd-5f94-a8ab-67f01c28be5a'::uuid AND dob IS NULL;
-- Lorenzo De Bernardis (PER) -> World Sailing: Lorenzo De Bernardis [PERLD1] | DOB: 2015-07-01
UPDATE public.sailors SET dob = '2015-07-01' WHERE id = 'd77081af-932d-5f3b-bfa9-bb5c49f46591'::uuid AND dob IS NULL;
-- Sofia Carrillo (PER) -> World Sailing: Sofia Carrillo [PERSC4] | DOB: 2011-05-26
UPDATE public.sailors SET dob = '2011-05-26' WHERE id = '0ff392dd-5414-5557-8759-a7d06775c1f1'::uuid AND dob IS NULL;
-- Benjaminson Lee Villena (PHI) -> World Sailing: Benjaminson Lee Villena [PHIBV1] | DOB: 2010-10-19
UPDATE public.sailors SET dob = '2010-10-19' WHERE id = 'bb4b7b96-28a7-459c-aeb2-8ba378575646'::uuid AND dob IS NULL;
-- Daven Balangue (PHI) -> World Sailing: Daven Balangue [PHIDB1] | DOB: 2001-11-12
UPDATE public.sailors SET dob = '2001-11-12' WHERE id = '428e0d02-34c2-5e83-a520-341e5dbc4c1e'::uuid AND dob IS NULL;
-- Josa Gonzales (PHI) -> World Sailing: Josa Gonzales [PHIJG3] | DOB: 2008-12-08
UPDATE public.sailors SET dob = '2008-12-08' WHERE id = '3d9efcfe-3ac7-5368-8783-93f288ab531b'::uuid AND dob IS NULL;
-- Kelsy Loryn Moreno (PHI) -> World Sailing: Kelsy Loryn Moreno [PHIKM1] | DOB: 2009-11-12
UPDATE public.sailors SET dob = '2009-11-12' WHERE id = '0f664096-c007-56a0-9edc-c7226be5a9da'::uuid AND dob IS NULL;
-- Khian Cuerdo (PHI) -> World Sailing: Khian Cuerdo [PHIKC2] | DOB: 2009-06-30
UPDATE public.sailors SET dob = '2009-06-30' WHERE id = 'fb14cb2c-b4dd-5f8c-a74c-1f5fd93579ed'::uuid AND dob IS NULL;
-- Khim Ashley Albo (PHI) -> World Sailing: Khim Ashley Albo [PHIKA1] | DOB: 2008-06-21
UPDATE public.sailors SET dob = '2008-06-21' WHERE id = '108d0eda-d379-5e23-bcde-6732a7f489cb'::uuid AND dob IS NULL;
-- Raya Mithi Samson (PHI) -> World Sailing: Raya Mithi Samson [PHIRS1] | DOB: 2011-05-01
UPDATE public.sailors SET dob = '2011-05-01' WHERE id = 'f51d67a0-2e8c-47eb-9f01-74144117e993'::uuid AND dob IS NULL;
-- Antoni Lutomski (POL) -> World Sailing: Antoni Lutomski [POLAL21] | DOB: 2009-01-05
UPDATE public.sailors SET dob = '2009-01-05' WHERE id = '79dc82ab-f5c6-52b3-9a10-f1025cd88d37'::uuid AND dob IS NULL;
-- Bartosz Peczka (POL) -> World Sailing: Bartosz Peczka [POLBP12] | DOB: 2007-08-24
UPDATE public.sailors SET dob = '2007-08-24' WHERE id = 'd2a6d4a1-ccd4-5578-bd61-58c3a8b18d47'::uuid AND dob IS NULL;
-- Blanka Jerzelkowska (POL) -> World Sailing: Blanka Jerzelkowska [POLBJ6] | DOB: 2012-02-21
UPDATE public.sailors SET dob = '2012-02-21' WHERE id = '6c10262d-0470-5431-9240-bc9e2b67a52a'::uuid AND dob IS NULL;
-- Ignacy Koterski (POL) -> World Sailing: Ignacy Koterski [POLIK8] | DOB: 2012-07-01
UPDATE public.sailors SET dob = '2012-07-01' WHERE id = '1f49409e-7404-5609-ae2b-5531ebd5f205'::uuid AND dob IS NULL;
-- Kacper Hryniewicz (POL) -> World Sailing: Kacper Hryniewicz [POLKH5] | DOB: 2013-09-07
UPDATE public.sailors SET dob = '2013-09-07' WHERE id = '68d312c7-d92f-5765-bc79-00987e96e3e6'::uuid AND dob IS NULL;
-- Maksymilian Ambroziak (POL) -> World Sailing: Maksymilian Ambroziak [POLMA9] | DOB: 2012-05-10
UPDATE public.sailors SET dob = '2012-05-10' WHERE id = '20e3d4d4-b4bd-5480-93bb-536187a5f0ec'::uuid AND dob IS NULL;
-- Marcelina Korszon (POL) -> World Sailing: Marcelina Korszon [POLMK61] | DOB: 2002-05-12
UPDATE public.sailors SET dob = '2002-05-12' WHERE id = 'cb92bd1e-9a7e-5922-83e7-70b0b26d88bd'::uuid AND dob IS NULL;
-- Milan Puskar (POL) -> World Sailing: Milan Puskar [POLMP77] | DOB: 2012-04-23
UPDATE public.sailors SET dob = '2012-04-23' WHERE id = '232739bd-1de0-58fe-8df1-1613ec604dfd'::uuid AND dob IS NULL;
-- Diogo Costa (POR) -> World Sailing: Diogo Costa [PORDC11] | DOB: 1997-08-23
UPDATE public.sailors SET dob = '1997-08-23' WHERE id = '6b6566dc-79b4-583f-9c6d-a514d07593ef'::uuid AND dob IS NULL;
-- Guilherme Costa (POR) -> World Sailing: Guilherme Costa [PORGC17] | DOB: 2013-05-27
UPDATE public.sailors SET dob = '2013-05-27' WHERE id = '999f1008-454e-5814-a91c-afebee57e7b8'::uuid AND dob IS NULL;
-- Angel Chew (SGP) -> World Sailing: Angel Chew [SGPAC1] | DOB: 2004-07-05
UPDATE public.sailors SET dob = '2004-07-05' WHERE id = 'd8f05612-be68-4e4d-af1d-e1cadbfb7669'::uuid AND dob IS NULL;
-- Eddie Tan (SGP) -> World Sailing: Eddie Tan [SGPET6] | DOB: 1978-02-18
UPDATE public.sailors SET dob = '1978-02-18' WHERE id = 'c40d2c19-a81b-411c-a00e-8805518050e3'::uuid AND dob IS NULL;
-- Jack Keable (SGP) -> World Sailing: Jack Keable [SGPJK3] | DOB: 2005-12-20
UPDATE public.sailors SET dob = '2005-12-20' WHERE id = '0b522907-6183-5f03-b3c2-7386790abf3d'::uuid AND dob IS NULL;
-- Jackson Ho (SGP) -> World Sailing: Jackson Ho [SGPJH2] | DOB: 1988-03-20
UPDATE public.sailors SET dob = '1988-03-20' WHERE id = 'cd1dbf6b-5afe-4719-9cc3-2f27841b602e'::uuid AND dob IS NULL;
-- Joe Chua (SGP) -> World Sailing: Joe Chua [SGPJC1] | DOB: 1951-11-02
UPDATE public.sailors SET dob = '1951-11-02' WHERE id = 'a3d9b6f7-b2ad-445f-c188-6fbd3e5c9076'::uuid AND dob IS NULL;
-- Joy Chen (SGP) -> World Sailing: Joy Chen [SGPJC7] | DOB: 2008-01-14
UPDATE public.sailors SET dob = '2008-01-14' WHERE id = 'd9865e26-0538-4286-b89e-e55a1accd250'::uuid AND dob IS NULL;
-- Lucas Quek (SGP) -> World Sailing: Lucas Quek [SGPLQ1] | DOB: 2009-03-18
UPDATE public.sailors SET dob = '2009-03-18' WHERE id = '82f58cc6-5b08-4031-86b8-805aa130d11e'::uuid AND dob IS NULL;
-- Malo Pichoir (SGP) -> World Sailing: malo pichoir [SGPMP1] | DOB: 2012-08-26
UPDATE public.sailors SET dob = '2012-08-26' WHERE id = '5f452462-2823-4bc0-b371-3b3ee8622778'::uuid AND dob IS NULL;
-- Mark Wong (SGP) -> World Sailing: Mark Wong [SGPMW1] | DOB: 2009-04-07
UPDATE public.sailors SET dob = '2009-04-07' WHERE id = 'c1fef555-4202-4814-8fd3-b397ad4fa912'::uuid AND dob IS NULL;
-- Ralf Chang (SGP) -> World Sailing: Ralf Chang [SGPRC3] | DOB: 2009-01-13
UPDATE public.sailors SET dob = '2009-01-13' WHERE id = '17cf453c-3258-4226-9e94-d9a40a5bfd1a'::uuid AND dob IS NULL;
-- Simone Ng (SGP) -> World Sailing: Simone Ng [SGPSN2] | DOB: 2008-11-25
UPDATE public.sailors SET dob = '2008-11-25' WHERE id = '7d1839b5-23a8-4efc-ad91-3597eac4d0d9'::uuid AND dob IS NULL;
-- Francesco Maria Paparella (SLO) -> World Sailing: Francesco Maria Paparella [SLOFP1] | DOB: 2013-10-30
UPDATE public.sailors SET dob = '2013-10-30' WHERE id = '5a84ccb7-b317-5ecb-90df-ff0c731473c0'::uuid AND dob IS NULL;
-- Akaine Ubayasiri (SRI) -> World Sailing: Akaine Ubayasiri [SRIAU1] | DOB: 2010-01-29
UPDATE public.sailors SET dob = '2010-01-29' WHERE id = '16ef0da7-2a70-4547-b298-a136b9f07037'::uuid AND dob IS NULL;
-- Binal Perera (SRI) -> World Sailing: Binal Perera [SRIBP1] | DOB: 2010-07-23
UPDATE public.sailors SET dob = '2010-07-23' WHERE id = '3db621df-d3f0-492e-8669-08bfd8ab0c86'::uuid AND dob IS NULL;
-- Muazzam Imtiaz (SRI) -> World Sailing: Muazzam Imtiaz [SRIMI1] | DOB: 2009-03-17
UPDATE public.sailors SET dob = '2009-03-17' WHERE id = '1c17fca4-b745-4af1-a0d2-b07878fe28be'::uuid AND dob IS NULL;
-- Randira Hangarangoda (SRI) -> World Sailing: Randira Hangarangoda [SRIRH1] | DOB: 2009-08-06
UPDATE public.sailors SET dob = '2009-08-06' WHERE id = 'e742813f-c85a-4566-861a-f3e7c656162a'::uuid AND dob IS NULL;
-- Sohanya De Mel (SRI) -> World Sailing: Sohanya De Mel [SRISD2] | DOB: 2009-08-05
UPDATE public.sailors SET dob = '2009-08-05' WHERE id = 'f7b4e2aa-85f0-4b4b-9db9-a2e42e6f290c'::uuid AND dob IS NULL;
-- Yusef Hazari (SRI) -> World Sailing: Yusef Hazari [SRIYH1] | DOB: 2008-10-20
UPDATE public.sailors SET dob = '2008-10-20' WHERE id = '8c0d0bab-3020-4fbe-8ff3-e20daee8d2b7'::uuid AND dob IS NULL;
-- Adrian Koller (SUI) -> World Sailing: Adrian Koller [SUIAK18] | DOB: 2012-03-03
UPDATE public.sailors SET dob = '2012-03-03' WHERE id = '00af9a09-32c7-5810-a7dd-d52094da44fb'::uuid AND dob IS NULL;
-- Devin Hauser (SUI) -> World Sailing: Devin Hauser [SUIDH9] | DOB: 2007-11-16
UPDATE public.sailors SET dob = '2007-11-16' WHERE id = 'b47d955e-8a30-58c1-9c7f-7d058c8fcd87'::uuid AND dob IS NULL;
-- Theo Bruhin (SUI) -> World Sailing: Theo Bruhin [SUITB14] | DOB: 2011-05-02
UPDATE public.sailors SET dob = '2011-05-02' WHERE id = 'c5753c6e-b638-5f2a-9cd4-fc6a545fed8b'::uuid AND dob IS NULL;
-- Carl Birgersson (SWE) -> World Sailing: Carl Birgersson [SWECB30] | DOB: 2011-10-17
UPDATE public.sailors SET dob = '2011-10-17' WHERE id = '691e47b3-3ada-582b-a8e6-576466fdffbc'::uuid AND dob IS NULL;
-- Didrik Dahlberg (SWE) -> World Sailing: Didrik Dahlberg [SWEDD6] | DOB: 2011-06-28
UPDATE public.sailors SET dob = '2011-06-28' WHERE id = '8052c652-5212-578b-958a-a265a22293ac'::uuid AND dob IS NULL;
-- Hilda Wallström (SWE) -> World Sailing: Hilda Wallström [SWEHW21] | DOB: 2009-06-14
UPDATE public.sailors SET dob = '2009-06-14' WHERE id = 'c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8'::uuid AND dob IS NULL;
-- Klara Ekstrand (SWE) -> World Sailing: Klara Ekstrand [SWEKE10] | DOB: 2011-05-21
UPDATE public.sailors SET dob = '2011-05-21' WHERE id = 'f085147e-a3e5-5ce6-a257-e901cc4d6edf'::uuid AND dob IS NULL;
-- Lisa Nilsson (SWE) -> World Sailing: Lisa Nilsson [SWELN9] | DOB: 2011-08-08
UPDATE public.sailors SET dob = '2011-08-08' WHERE id = '574aabac-66fb-5c3e-8bea-d49ab67dbbe5'::uuid AND dob IS NULL;
-- Lovisa Arnell (SWE) -> World Sailing: Lovisa Arnell [SWELA20] | DOB: 2009-01-28
UPDATE public.sailors SET dob = '2009-01-28' WHERE id = '23f1bd6e-e974-4661-94c6-ce6458d14e0d'::uuid AND dob IS NULL;
-- Oskar Annwall (SWE) -> World Sailing: oskar annwall [SWEOA11] | DOB: 2009-07-19
UPDATE public.sailors SET dob = '2009-07-19' WHERE id = '81e2280d-3d84-41f7-accc-86ee510f5c93'::uuid AND dob IS NULL;
-- Phatchara Nari (THA) -> World Sailing: Phatchara Nari [THAPN2] | DOB: 2010-11-25
UPDATE public.sailors SET dob = '2010-11-25' WHERE id = 'dc53f7b9-6c62-5b56-a8af-126c740c3310'::uuid AND dob IS NULL;
-- Suphachai Chueatathong (THA) -> World Sailing: Suphachai Chueatathong [THASC9] | DOB: 2009-10-08
UPDATE public.sailors SET dob = '2009-10-08' WHERE id = 'c4a8af93-b344-5b96-a9e4-bef4c6f0107b'::uuid AND dob IS NULL;
-- Suphachok Chueatathong (THA) -> World Sailing: Suphachok Chueatathong [THASC8] | DOB: 2009-10-08
UPDATE public.sailors SET dob = '2009-10-08' WHERE id = 'bf5455bc-c310-5bc1-85f1-372889e90934'::uuid AND dob IS NULL;
-- Wachirawit Manbumrung (THA) -> World Sailing: Wachirawit Manbumrung [THAWM3] | DOB: 2009-12-10
UPDATE public.sailors SET dob = '2009-12-10' WHERE id = 'efbd9517-2dd8-5c0b-8e29-3642c9e1c338'::uuid AND dob IS NULL;
-- Chi-Hsi Lin (TPE) -> World Sailing: CHI-HSI LIN [TPECL6] | DOB: 2012-11-17
UPDATE public.sailors SET dob = '2012-11-17' WHERE id = 'd9fae5c5-d3db-400e-9896-d2d00d7d8d83'::uuid AND dob IS NULL;
-- En-Rui Hsu (TPE) -> World Sailing: En-Rui Hsu [TPEEH1] | DOB: 2010-09-27
UPDATE public.sailors SET dob = '2010-09-27' WHERE id = '70371bac-6222-4625-8df8-296f67f622dc'::uuid AND dob IS NULL;
-- Hao-Ran Hsu (TPE) -> World Sailing: Hao-Ran Hsu [TPEHH7] | DOB: 2009-06-12
UPDATE public.sailors SET dob = '2009-06-12' WHERE id = '6ed1c6b7-6a64-4ce5-9565-ddedf27b12a5'::uuid AND dob IS NULL;
-- Pin-Chieh Chen (TPE) -> World Sailing: Pin-Chieh Chen [TPEPC3] | DOB: 2004-01-16
UPDATE public.sailors SET dob = '2004-01-16' WHERE id = 'e263fbe8-e092-5c21-9677-b7b94f69aaa1'::uuid AND dob IS NULL;
-- Waixiang Yang (TPE) -> World Sailing: Waixiang Yang [TPEWY1] | DOB: 2007-10-25
UPDATE public.sailors SET dob = '2007-10-25' WHERE id = '30fc62cd-a394-5f7f-93fa-ace8448becb6'::uuid AND dob IS NULL;
-- Yi San Huang (TPE) -> World Sailing: Yi San Huang [TPEYH7] | DOB: 2006-07-03
UPDATE public.sailors SET dob = '2006-07-03' WHERE id = '2bb09661-11b7-5714-a6b2-a495ed6f517f'::uuid AND dob IS NULL;
-- Yong-Fen Yang (TPE) -> World Sailing: Yong-Fen Yang [TPEYY3] | DOB: 2011-07-10
UPDATE public.sailors SET dob = '2011-07-10' WHERE id = '6e1c5516-938f-44fa-9898-f997676aa998'::uuid AND dob IS NULL;
-- Yu-Cheng Kao (TPE) -> World Sailing: Yu-cheng Kao [TPEYK1] | DOB: 2008-10-17
UPDATE public.sailors SET dob = '2008-10-17' WHERE id = '309280c8-279c-518f-8673-2496c0bf7172'::uuid AND dob IS NULL;
-- Alp Yavrucuk (TUR) -> World Sailing: Alp Yavrucuk [TURAY17] | DOB: 2012-06-27
UPDATE public.sailors SET dob = '2012-06-27' WHERE id = '642f0809-b1f7-5fae-977e-fd97f4aa8def'::uuid AND dob IS NULL;
-- Asilkan Öğüt (TUR) -> World Sailing: Asilkan Öğüt [TURAO26] | DOB: 2009-08-24
UPDATE public.sailors SET dob = '2009-08-24' WHERE id = '5f1150c3-b0ee-087c-b8a1-3ef963b7146c'::uuid AND dob IS NULL;
-- Asrın Hepbayraktar (TUR) -> World Sailing: Asrın Hepbayraktar [TURAH5] | DOB: 2010-04-09
UPDATE public.sailors SET dob = '2010-04-09' WHERE id = '0cc0e606-5279-499b-b662-44a9b6f895be'::uuid AND dob IS NULL;
-- Asya Anastasya Varicioglu (TUR) -> World Sailing: Asya Anastasya VARICIOGLU [TURAV5] | DOB: 2002-04-19
UPDATE public.sailors SET dob = '2002-04-19' WHERE id = 'f71c369b-b7cd-51f7-9717-e13be2930771'::uuid AND dob IS NULL;
-- Fikret Tacar (TUR) -> World Sailing: FİKRET TACAR [TURFT8] | DOB: 2010-01-01
UPDATE public.sailors SET dob = '2010-01-01' WHERE id = 'a42f2f50-1990-485c-9317-619a387fb247'::uuid AND dob IS NULL;
-- Kerem Çifter (TUR) -> World Sailing: Kerem Çifter [TURKÇ5] | DOB: 2011-01-08
UPDATE public.sailors SET dob = '2011-01-08' WHERE id = 'a54c502b-3936-b5a8-4eed-05471dd4ab64'::uuid AND dob IS NULL;
-- Yağmur Öztekin (TUR) -> World Sailing: Yağmur Öztekin [TURYÖ14] | DOB: 2011-07-11
UPDATE public.sailors SET dob = '2011-07-11' WHERE id = 'd482e0df-808e-5d95-a8e8-53e13636614e'::uuid AND dob IS NULL;
-- Alyazya Alhammadi (UAE) -> World Sailing: Alyazya Alhammadi [UAEAA52] | DOB: 2011-06-29
UPDATE public.sailors SET dob = '2011-06-29' WHERE id = '5f14d7c9-dc29-5dcc-af50-065637d5730d'::uuid AND dob IS NULL;
-- Andrii Bondariuk (UKR) -> World Sailing: Andrii Bondariuk [UKRAB7] | DOB: 2013-03-18
UPDATE public.sailors SET dob = '2013-03-18' WHERE id = '394cb6e6-b50e-5b6f-9260-82b694cfe3b8'::uuid AND dob IS NULL;
-- Arturo Zizold (USA) -> World Sailing: Arturo Zizold [USAAZ21] | DOB: 2010-09-30
UPDATE public.sailors SET dob = '2010-09-30' WHERE id = 'e22fd724-a226-4940-9030-d2e4ad8bae4f'::uuid AND dob IS NULL;
-- Elisa de Becker (USA) -> World Sailing: Elisa De Becker [USAED90] | DOB: 2009-11-07
UPDATE public.sailors SET dob = '2009-11-07' WHERE id = '12d4d973-0a73-89aa-d6a0-b07e3fadc14f'::uuid AND dob IS NULL;
-- Ethan Doyle (USA) -> World Sailing: ethan doyle [USAED35] | DOB: 1978-12-19
UPDATE public.sailors SET dob = '1978-12-19' WHERE id = '4da0abee-3842-5a53-8671-0b0047b7db67'::uuid AND dob IS NULL;
-- Finnegan Grainger (USA) -> World Sailing: Finnegan Grainger [USAFG16] | DOB: 2010-01-21
UPDATE public.sailors SET dob = '2010-01-21' WHERE id = '0610ce1f-797c-4d82-a606-4565af1e36b8'::uuid AND dob IS NULL;
-- Holland Vierling (USA) -> World Sailing: Holland Vierling [USAHV14] | DOB: 2008-11-26
UPDATE public.sailors SET dob = '2008-11-26' WHERE id = '9643a3c3-c78d-52b0-8ad2-84a1f359cb38'::uuid AND dob IS NULL;
-- Jackson Rushing (USA) -> World Sailing: Jackson Rushing [USAJR298] | DOB: 2008-01-22
UPDATE public.sailors SET dob = '2008-01-22' WHERE id = 'e60e175a-54f5-4448-bf18-3c50e012715c'::uuid AND dob IS NULL;
-- Kai Mirel (USA) -> World Sailing: Kai Mirel [USAKM211] | DOB: 2005-03-24
UPDATE public.sailors SET dob = '2005-03-24' WHERE id = 'd8731a69-3a18-5033-bff5-e67f0f5da684'::uuid AND dob IS NULL;
-- Oscar Melet (USA) -> World Sailing: Oscar Melet [USAOM11] | DOB: 2008-07-29
UPDATE public.sailors SET dob = '2008-07-29' WHERE id = 'a04d2517-7846-5f06-bfc0-abb5e9f1e73b'::uuid AND dob IS NULL;
-- Sander Block (USA) -> World Sailing: Sander Block [USASB239] | DOB: 2009-07-25
UPDATE public.sailors SET dob = '2009-07-25' WHERE id = 'a03c141d-7ae5-435a-873c-2b353ee9d5d0'::uuid AND dob IS NULL;
-- William Whidden (USA) -> World Sailing: William Whidden [USAWW102] | DOB: 2010-06-22
UPDATE public.sailors SET dob = '2010-06-22' WHERE id = '08b184aa-3881-464d-99c4-f73050a881d2'::uuid AND dob IS NULL;

-- Synchronize regatta_results.birth_year with updated sailors.dob
UPDATE public.regatta_results rr
SET birth_year = EXTRACT(YEAR FROM s.dob)::integer
FROM public.sailors s
WHERE rr.sailor_id = s.id
  AND s.dob IS NOT NULL
  AND rr.birth_year IS DISTINCT FROM EXTRACT(YEAR FROM s.dob)::integer;

COMMIT;
