-- Migration 141: Enrich Sailor Attributes (DOB, Gender, Club, Nationality)
-- Corroboration Sources:
-- 1. Official IODA Asian & Oceanian Championship profile manifests & continuation research
-- 2. Official Asian Cup / Asian Championships (Penghu) final results & division breakdowns
-- 3. Hong Kong Race Week 2025/2026 & HK Nationals competitor registrations (RRoS Events 12853, 9896, 13166)
-- 4. National championship results and official class manifests
-- 5. Standardized legacy gender values ('Male' -> 'M', 'Female' -> 'F')
-- Total updated sailors: 620

BEGIN;

-- Sailor: Shreya Krishna Lakshminarayanan (shreya-krishna-lakshminarayanan-yvqywlz)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc'::uuid;

-- Sailor: Tara Maliah (tara-maliah-j0xd6t3)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = 'bcb9374d-c256-4add-9abe-98b7832706cc'::uuid;

-- Sailor: Shiteng Huang (asian-chn-shiteng-hu-6ffa51)
UPDATE public.sailors SET club = 'CHENJINHAO RACE TEAM', updated_at = now() WHERE id = '3865e7dc-bcaf-4ca2-8099-2e06e3282fa8'::uuid;

-- Sailor: Yijia Ni (asian-chn-yijia-ni-a95941)
UPDATE public.sailors SET club = 'SYFLS', updated_at = now() WHERE id = 'dcd2c433-7acf-49a1-9c10-d94b52213f04'::uuid;

-- Sailor: Suthinan Nakpasom (suthinan-nakpasom-n1ztaan)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'f3e4cce1-2a81-4794-ba02-a570d43efb21'::uuid;

-- Sailor: Xinran Liu (xinran-liu-2mjr4jo)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = '7b299201-3c25-490e-9d7c-e92164369360'::uuid;

-- Sailor: Kian Anderson (kian-anderson-z370pjz)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '4275ed2a-d203-4a7f-b66a-230b5f39f8ff'::uuid;

-- Sailor: Eryk Kazimierczyk (asian-qat-eryk-kazim-df1f84)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = 'a2925bb9-d964-4975-b13a-8a833514216d'::uuid;

-- Sailor: Khairul Ilzani Bin Mohd Afendy (khairul-ilzani-bin-mohd-afendy-ynk9juj)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7'::uuid;

-- Sailor: Hamad Almasoud (asian-kuw-hamad-alma-79dd24)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4'::uuid;

-- Sailor: Hamad Almheiri (asian-uae-hamad-almh-5cd126)
UPDATE public.sailors SET dob = '2016-01-01'::date, updated_at = now() WHERE id = '88ef9bc3-5faf-47db-9c1e-9eb3ec9772e7'::uuid;

-- Sailor: Furkan Mustafayev (asian-aze-furkan-mus-1235bb)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '21eafab6-578c-4559-88e6-527864d7b90c'::uuid;

-- Sailor: Bongur Banny (bongur-banny-zicv5kk)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'c17c8a95-4c06-4544-8b84-e789466ecf36'::uuid;

-- Sailor: Muhammad Zahir Naiman Bin Ismail (muhammad-zahir-naiman-bin-ismail-ypp7h9q)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '6b9c77fe-5a8d-490a-bc66-34f60695132b'::uuid;

-- Sailor: Pattarakorn Poonpat (pattarakorn-poonpat-oe44pao)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '9fe16e38-700a-4ba6-8618-5f6779a9b23f'::uuid;

-- Sailor: Keira Hwang (keira-hwang-65gxcij)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '0f21b908-6234-4f3b-a34c-fbe589a75c7c'::uuid;

-- Sailor: Zakareya Bohamad (asian-kuw-zakareya-b-13b125)
UPDATE public.sailors SET dob = '2016-01-01'::date, updated_at = now() WHERE id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10'::uuid;

-- Sailor: Tarteel Al Hasani (asian-oma-tarteel-al-05a14c)
UPDATE public.sailors SET club = 'OMAN SAIL', updated_at = now() WHERE id = '09429d47-67b4-4953-b50c-c5da84fed18c'::uuid;

-- Sailor: Yunxi Jin (asian-mac-yunxi-jin-d5a1b5)
UPDATE public.sailors SET club = 'AVM/CHENJINHAO RACE TEAM', updated_at = now() WHERE id = '37038dfd-a3ba-4100-8505-90448e185cc2'::uuid;

-- Sailor: Hood Al Nofli (asian-oma-hood-al-no-403b7f)
UPDATE public.sailors SET club = 'OMAN SAIL', updated_at = now() WHERE id = 'ad45bec2-2ef9-44c6-8ac9-e440c71bcb97'::uuid;

-- Sailor: Abdulaziz Almansour (asian-kuw-abdulaziz--d30ffd)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = 'f264291a-405d-4edf-892e-0facabbee42f'::uuid;

-- Sailor: Mikayil Mammadzada (asian-aze-mikayil-ma-830ebe)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '228209bd-b4b2-4f5a-9a4d-27b1b717b872'::uuid;

-- Sailor: Hyunwoo Jeon (asian-kor-hyunwoo-je-6ae6db)
UPDATE public.sailors SET club = 'Gangwon', updated_at = now() WHERE id = '190686bb-516d-43ec-a519-b0158e48f963'::uuid;

-- Sailor: Daol Park (asian-kor-daol-park-30a849)
UPDATE public.sailors SET club = 'BOSEONG CLUB', updated_at = now() WHERE id = '5c71a2fa-f1d9-4e55-9e7a-f3ace88044a3'::uuid;

-- Sailor: Siyeon An (asian-kor-siyeon-an-08a833)
UPDATE public.sailors SET club = 'Gangwon', updated_at = now() WHERE id = '50acb7b9-4896-454d-83a8-9c2dc2e1ed2b'::uuid;

-- Sailor: Seoyi An (asian-kor-seoyi-an-4eb55a)
UPDATE public.sailors SET club = 'GANGWON SAILING TEAM', updated_at = now() WHERE id = '40a23367-69df-42e3-8907-be4a7919fb4e'::uuid;

-- Sailor: Ruben Steel (ruben-steel-0ajhhtd)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '59556a86-6d0f-4500-8a46-4ab111fe1479'::uuid;

-- Sailor: Chantal Henriksson (chantal-henriksson-worlds26)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '5544d0d2-66d2-569c-90b9-89a8ae5627e8'::uuid;

-- Sailor: Pakornkiat Chaiya-o-Cha (pakornkiat-chaiya-o-cha-h112x3c)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '71761d05-b857-411f-b37a-cd9522307777'::uuid;

-- Sailor: Itthichai Tiathongchai (itthichai-tiathongchai-iw2jhva)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '182f006d-6103-4990-a289-421c0d94e552'::uuid;

-- Sailor: Thawaree Raksapun (thawaree-raksapun-sd0d5wz)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'efc33f0d-a581-4dd3-99ee-2c245bb1c9cd'::uuid;

-- Sailor: Khamis Al Meshaikhi (asian-oma-khamis-al--d98d6b)
UPDATE public.sailors SET dob = '2010-01-01'::date, club = 'OMAN SAIL', updated_at = now() WHERE id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2'::uuid;

-- Sailor: Zayed Al Hosani (zayed-al-hosani-j60tt5c)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '9c1d9cbc-14f8-41c0-acaa-a0ce32bc2869'::uuid;

-- Sailor: Shi Lin (shi-lin-vysogv7)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '0c191e7f-5725-41a0-b1c8-dcf4177b0cd5'::uuid;

-- Sailor: Hadeel Al Mushaifri (asian-oma-hadeel-al--4654b6)
UPDATE public.sailors SET dob = '2010-01-01'::date, club = 'OMAN SAIL', updated_at = now() WHERE id = 'c522825b-efc4-47f6-8a48-a3becbf051e7'::uuid;

-- Sailor: Scarlett Tao Xinran (scarlett-tao-xinran-zn8iz60)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'b5748418-b045-44a6-a48b-53a3b30ffa5c'::uuid;

-- Sailor: Muyu Lu (asian-mac-muyu-lu-b0340c)
UPDATE public.sailors SET club = 'Macau Sailing Association', updated_at = now() WHERE id = '2cdb701a-9dab-466c-b58d-655f904a583c'::uuid;

-- Sailor: Chi In Jasper Tang (asian-mac-chi-in-jas-dd3094)
UPDATE public.sailors SET club = 'Macau Sailing Association', updated_at = now() WHERE id = '8120aa0b-f353-4cae-8751-b00fe278f2c3'::uuid;

-- Sailor: Gemma Chen Huang Heng (gemma-chen-huang-heng)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '688cc8ae-873e-40a3-9bc4-7d05a496994a'::uuid;

-- Sailor: Deklen Chew (deklen-chew-0ate62c)
UPDATE public.sailors SET nationality = 'SGP', updated_at = now() WHERE id = '763ad94d-2fe7-443f-8ed8-6be06d180d08'::uuid;

-- Sailor: John Raphael Lim (john-raphael-lim-0h6gqjh)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '6bc22d30-b06a-4e64-86a9-f4cb99535f33'::uuid;

-- Sailor: Jonas Tan Yi Jun (jonas-tan-yi-jun-nsc24)
UPDATE public.sailors SET nationality = 'SGP', updated_at = now() WHERE id = 'c8f5d2b3-7e69-401b-8d44-2b7f9a1e5c32'::uuid;

-- Sailor: Cheryl Ho Hai Yan (cheryl-ho-hai-yan-0mjmr1q)
UPDATE public.sailors SET nationality = 'SGP', updated_at = now() WHERE id = '61b1d74c-edcd-4730-b606-d3ae3264d658'::uuid;

-- Sailor: Wayne Yap Swee (wayne-yap-swee-0n7y2pu)
UPDATE public.sailors SET nationality = 'SGP', updated_at = now() WHERE id = 'fb679bba-d2d2-483b-aa2c-34262239cf91'::uuid;

-- Sailor: Yap Swee Dean (yap-swee-dean-safyc23)
UPDATE public.sailors SET nationality = 'SGP', updated_at = now() WHERE id = 'abeecd7a-f571-4dfb-a1b7-fe9ccf19da18'::uuid;

-- Sailor: Evan Teo Ee Wan (evan-teo-ee-wan-xxjuiuc)
UPDATE public.sailors SET nationality = 'SGP', updated_at = now() WHERE id = 'b1cf2a2e-7b34-4ff8-b544-ba624fce0195'::uuid;

-- Sailor: Tan Li Ying Kayler (tan-li-ying-kayler-oknv50k)
UPDATE public.sailors SET nationality = 'SGP', updated_at = now() WHERE id = 'e973857f-189c-4730-9732-7222bd1e6ee7'::uuid;

-- Sailor: Catherine Maiden (catherine-maiden-xyxid6m)
UPDATE public.sailors SET nationality = 'SGP', updated_at = now() WHERE id = '867f8d47-e58f-4e20-90c4-06ed0b1bf450'::uuid;

-- Sailor: Zihan Liu (zihan-liu-03kqgjl)
UPDATE public.sailors SET gender = 'F', club = 'HKSI', updated_at = now() WHERE id = '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3'::uuid;

-- Sailor: Chloe Kong (chloe-kong-04a7mpd)
UPDATE public.sailors SET club = 'HKSI/ABC', updated_at = now() WHERE id = '6591a20e-7f52-4b81-b6cf-2b450a6410b5'::uuid;

-- Sailor: Pinchanok Klaysomboon (pinchanok-klaysomboon-ofynlxk)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '2746f84b-a6bf-40cb-b95d-1beb6652f8e6'::uuid;

-- Sailor: Tammachat Sriopas (tammachat-sriopas-inv7x5v)
UPDATE public.sailors SET dob = '2012-01-01'::date, club = 'RTNYC', updated_at = now() WHERE id = '6a47226c-e5c9-4b83-b962-266bbd3c8ccd'::uuid;

-- Sailor: Jonathan Zeppezauer (jonathan-zeppezauer-04zqlkx)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = 'fb44dcf5-6915-4334-9904-5259ed064710'::uuid;

-- Sailor: Khun Tun Oo (khun-tun-oo-06ddzna)
UPDATE public.sailors SET dob = '2009-01-01'::date, gender = 'M', club = 'RVYC', updated_at = now() WHERE id = '378474e8-cb1e-4163-96b9-e88857ea86d3'::uuid;

-- Sailor: Ethan Kiu (ethan-kiu-08ghk01)
UPDATE public.sailors SET club = 'HKSI, RHKYC', updated_at = now() WHERE id = 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6'::uuid;

-- Sailor: Seb Tucker (seb-tucker-09584cg)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'a8621760-ffb6-4283-8e2e-12bb7890d8a4'::uuid;

-- Sailor: Jessica Liu (jessica-liu-dzgkrka)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = 'efbf3e52-e103-455f-af07-e182b5280b3c'::uuid;

-- Sailor: Wil Sayers (wil-sayers-09uhmo1)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '69649402-4eca-4416-8b40-442bdcbce5c1'::uuid;

-- Sailor: Muhammad Hilfi Nafael Bin Hasrizan (muhammad-hilfi-nafael-bin-hasrizan-yc6x4w1)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '1153aed7-1732-4cd4-a60b-b4229ddee14e'::uuid;

-- Sailor: Badrul Bakhtiar Bin Rowl (badrul-bakhtiar-bin-rowl-210q3td)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '30e7b208-fac8-4798-8ac6-75b5a019de23'::uuid;

-- Sailor: Sara Amanda Binti Mohd Noor Azman (sara-amanda-binti-mohd-noor-azman-ymi0q3h)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '126eaba9-16e6-40ef-9f4b-822df0550b41'::uuid;

-- Sailor: Shion Yamamoto (shion-yamamoto-21ov1mp)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '9163e61b-8e6d-4d3c-9429-d55309d9d91b'::uuid;

-- Sailor: Nur Aina Binti Norhazram (nur-aina-binti-norhazram-yyxtaiz)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '00e9f759-95f1-4633-88db-b07d7933d248'::uuid;

-- Sailor: Haziq Mustaqim b. Mohd Husni (haziq-mustaqim-b-mohd-husni-231fyyf)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949'::uuid;

-- Sailor: Riho Sanematsu (riho-sanematsu-24d7h3x)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'a63cb70f-12ad-480b-8fd6-f919ceea28f3'::uuid;

-- Sailor: Nanami Ikeda (nanami-ikeda-270m3uq)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '2beb1f39-b292-4b44-a2b2-19877dcd080b'::uuid;

-- Sailor: Tomohiro Kawakita (tomohiro-kawakita-28o6w61)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '3e5c315f-7c0b-4888-8f3b-61a735092505'::uuid;

-- Sailor: Muhammad Aiman Aqeel Bin Mohd Firdaus (muhammad-aiman-aqeel-bin-mohd-firdaus-29c7tud)
UPDATE public.sailors SET dob = '2010-01-01'::date, gender = 'M', club = 'SABAH', updated_at = now() WHERE id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'::uuid;

-- Sailor: Kee Aleana Binti Abdullah (kee-aleana-binti-abdullah-2a04cfe)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'bae687b7-5919-4db4-8361-c53df73c6503'::uuid;

-- Sailor: Siddart Ganesh (siddart-ganesh-2ibp0oy)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '3a9036ec-81cc-429f-84cb-3d21f8c0b3b3'::uuid;

-- Sailor: Toh Eu Hian Nathan (toh-eu-hian-nathan-izj0dyg)
UPDATE public.sailors SET nationality = 'SGP', updated_at = now() WHERE id = '64f6848e-20e4-4093-9c21-ca15f48cc3c8'::uuid;

-- Sailor: Kabir Das (kabir-das-j9s1goj)
UPDATE public.sailors SET nationality = 'SGP', updated_at = now() WHERE id = '065abb74-de3d-41d7-80c8-b1ce716d8db0'::uuid;

-- Sailor: Arne Sitar (arne-sitar-jagnxf4)
UPDATE public.sailors SET nationality = 'SGP', updated_at = now() WHERE id = 'c7cee35c-4307-44ff-8a0e-71ef89473388'::uuid;

-- Sailor: Karit Phrammanee (karit-phrammanee-of7ddfd)
UPDATE public.sailors SET dob = '2010-01-01'::date, gender = 'M', club = 'YRAT', updated_at = now() WHERE id = '8263464a-01a9-4e55-b8f1-46d96d0173c4'::uuid;

-- Sailor: Yong Ray Chuang (yong-ray-chuang-thai25-6b0187)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '6b018765-b6a9-5682-ada3-f3002829594e'::uuid;

-- Sailor: Kiitchakhun Somkhanngoen (kiitchakhun-somkhanngoen-sw3gwyp)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '90a471f5-bd58-400f-a995-e115951ee1ed'::uuid;

-- Sailor: Yeh Chen Yang (yeh-chen-yang-thai25-077c93)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'::uuid;

-- Sailor: Huang Chi Fang (huang-chi-fang-thai25-9bdb02)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'::uuid;

-- Sailor: Jolin Zheng (jolin-zheng-mdmobwq)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '018b6ed4-9636-47e1-8d40-aa5e21a22f32'::uuid;

-- Sailor: Kate Lee (kate-lee-thai25-977155)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '9771553e-0a20-5561-8f5e-403c21bae60a'::uuid;

-- Sailor: Ashira Phangrak (ashira-phangrak-oi7odm9)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '9fcccf71-f1d8-4f83-818b-bc2eb6422676'::uuid;

-- Sailor: Austin Lee (austin-lee-thai25-554015)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '55401544-18e4-5347-9967-69547a3cf03a'::uuid;

-- Sailor: Wang Zhenghan (wang-zhenghan-sr26-5d4e06)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d'::uuid;

-- Sailor: Thirawat Hankham (thirawat-hankham-39qtb48)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '3adcfc44-b8ad-443f-b2e9-c8d5da671014'::uuid;

-- Sailor: Natthapong Neelasavee (natthapong-neelasavee-91q0rru)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '39f63d3e-5e9b-4643-9261-bccc97cfd343'::uuid;

-- Sailor: Skye Hsu (skye-hsu-thai25-f61896)
UPDATE public.sailors SET dob = '2010-01-01'::date, gender = 'M', updated_at = now() WHERE id = 'f61896f2-3906-5258-82bc-494e2573ebfc'::uuid;

-- Sailor: Prapada Peeranantapanya (prapada-peeranantapanya-rz13syo)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'f90c9f74-fc6a-4ac4-a2ce-74a584e36038'::uuid;

-- Sailor: Natidej Termwattanapakdee (natidej-termwattanapakdee-thai25-8f2e85)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '8f2e850e-bd71-53f9-b24b-f34fe4148bd7'::uuid;

-- Sailor: Peerapat Yaponha (peerapat-yaponha-sr26-70a6f3)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '70a6f3e4-0d5d-50f5-9ffe-54de3fe9811a'::uuid;

-- Sailor: Tadol Ratinukulkit (tadol-ratinukulkit-sr26-d72c67)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = 'd72c67c6-b26b-5023-8072-64dca2034616'::uuid;

-- Sailor: Aktanon Jongjukaphan (aktanon-jongjukaphan-l50fjyf)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'fda6a9f7-be61-4f3b-8f64-7f29c75592c1'::uuid;

-- Sailor: Li Xinjie (li-xinjie-sr26-76560c)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '76560c4f-a4de-52b5-a6ed-1c80a7926940'::uuid;

-- Sailor: Roong Chantarawinij (roong-chantarawinij-odgizm0)
UPDATE public.sailors SET dob = '2014-01-01'::date, gender = 'F', updated_at = now() WHERE id = '87305a01-bdb1-494b-838c-5a9a0376ac7c'::uuid;

-- Sailor: Teepat Arttapiyapun (teepat-arttapiyapun-sr26-c2ee53)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = 'c2ee5326-5132-54b8-84a2-184817bd0719'::uuid;

-- Sailor: Puttaraksa Imraksa (puttaraksa-imraksa-sr26-5191c6)
UPDATE public.sailors SET dob = '2006-01-01'::date, updated_at = now() WHERE id = '5191c60e-3586-5a0d-b103-5512d9e35440'::uuid;

-- Sailor: Thitiworada Johnjaitrong (thitiworada-johnjaitrong-hd6qxkf)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '87248310-cc92-4094-accd-afe96addeeef'::uuid;

-- Sailor: Suwaphak Plumjit (suwaphak-plumjit-8glzaqs)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'a5a0ff6f-0576-4a4c-b583-149f6f6d7304'::uuid;

-- Sailor: Pichalee Hungsavanus (pichalee-hungsavanus-sr26-07faac)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '07faac7e-53ea-54b3-8d4d-8077fb2e2a4c'::uuid;

-- Sailor: Mohammad Syahieradham Bin Raiman (mohammad-syahieradham-bin-raiman-sr26-76b64b)
UPDATE public.sailors SET dob = '2007-01-01'::date, updated_at = now() WHERE id = '76b64bcc-6b88-515a-8759-89e4c015ca3d'::uuid;

-- Sailor: Supakon Pongwichean (sub-lt-supakon-pongwichean-sr26-36b2c8)
UPDATE public.sailors SET dob = '1995-01-01'::date, updated_at = now() WHERE id = '36b2c840-0917-5a4d-aa40-cd2be30c9780'::uuid;

-- Sailor: Voravong Rachrattanaruk (voravong-rachrattanaruk-sr26-2b3246)
UPDATE public.sailors SET dob = '2000-01-01'::date, updated_at = now() WHERE id = '2b3246a1-72eb-5606-b101-8c38c82d9afe'::uuid;

-- Sailor: Napat Ladsowhae (napat-ladsowhae-84tq4nu)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'a58d8928-2693-4a99-a36c-693cda63fd03'::uuid;

-- Sailor: Pitipat Paphawannasri (pitipat-paphawannasri-glihk3d)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '7efdd2b0-bd08-4529-afef-3ebfe91fcb06'::uuid;

-- Sailor: Chayut Phunnarungsi (chayut-phunnarungsi-sfy532f)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '1a3a6f55-afa6-41ba-8ecd-f898eeb7a567'::uuid;

-- Sailor: Tewmek Chulagasyena (tewmek-chulagasyena-ztu8lnq)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '3ad792e4-52ba-4efe-8285-89deb8b551ba'::uuid;

-- Sailor: Thanaphol Lertrungamorn (thanaphol-lertrungamorn-tnc26-0ae5e520)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = '0ae5e520-693e-4437-8595-d3c9f2f66a5a'::uuid;

-- Sailor: Kachamon Thongrod (kachamon-thongrod-sr26-ed63f1)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = 'ed63f110-a4be-57c1-936f-bf71f861dc38'::uuid;

-- Sailor: Lapatrada Boonsopawong (lapatrada-boonsopawong-sr26-6da26b)
UPDATE public.sailors SET dob = '2016-01-01'::date, updated_at = now() WHERE id = '6da26bf5-4240-5aa4-9379-b39438d4efa1'::uuid;

-- Sailor: Alex James De Rennes (alex-james-de-rennes-tnc26-34ccfd20)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = '34ccfd20-b960-40f5-a0af-f869921ee415'::uuid;

-- Sailor: Teejutha Thongthiem (teejutha-thongthiem-hj4s26n)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '965facf1-7eb4-4987-9a6b-ea92fc47df6b'::uuid;

-- Sailor: Kitdanuphon Thamsap (kitdanuphon-thamsap-09hfubv)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '83ea77ef-6eb5-4311-81bf-0657ec04c095'::uuid;

-- Sailor: Narad Promjit (narad-promjit-thai26-0afe2e)
UPDATE public.sailors SET dob = '2016-01-01'::date, updated_at = now() WHERE id = '0afe2eb8-d54f-5707-bccb-dcb01f56f569'::uuid;

-- Sailor: Kongkidakorn Phutphithak (kongkidakorn-phutphithak-sr26-d40150)
UPDATE public.sailors SET dob = '2016-01-01'::date, updated_at = now() WHERE id = 'd4015062-9510-5ecf-ae0e-030581922658'::uuid;

-- Sailor: Natnicha Somwongin (natnicha-somwongin-e3n0ee9)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '87eb31af-65e7-4cf0-b68b-8a7578c4b06d'::uuid;

-- Sailor: Phutthasorn Klaimuk (phutthasorn-klaimuk-jkt3b9i)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '816e7865-0b0a-433f-9964-476e127f5f12'::uuid;

-- Sailor: Sherman (sherman-mya380)
UPDATE public.sailors SET dob = '2016-01-01'::date, gender = 'M', club = 'YSC', updated_at = now() WHERE id = '4f705fec-c1a1-5341-b860-2696671f406a'::uuid;

-- Sailor: Thanadon Dethansatit (thanadon-dethansatit-tnc26-95cd4a20)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = '95cd4a20-3be1-4292-8e31-f568e4937f12'::uuid;

-- Sailor: Thawan Srisayyon (thawan-srisayyon-tnc26-e6546dfe)
UPDATE public.sailors SET dob = '2016-01-01'::date, updated_at = now() WHERE id = 'e6546dfe-c32b-4bac-bde7-a6e862a0e6dc'::uuid;

-- Sailor: Natnathee Peepanich (natnathee-peepanich-uplm49g)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'f0755dca-49d2-415e-8623-12ff3291b73f'::uuid;

-- Sailor: Thaniyada Kaewrakum (thaniyada-kaewrakum-sr26-dc0265)
UPDATE public.sailors SET dob = '2018-01-01'::date, updated_at = now() WHERE id = 'dc026565-7e56-5c2b-b0e9-dcb51c7682ed'::uuid;

-- Sailor: Natnan Aesomnuek (natnan-aesomnuek-sr26-6a4451)
UPDATE public.sailors SET dob = '2018-01-01'::date, updated_at = now() WHERE id = '6a4451dd-ff66-5008-ba1f-04c8e8e443b1'::uuid;

-- Sailor: Arissara Ratanaarporn (arissara-ratanaarporn-tnc26-dcc276c2)
UPDATE public.sailors SET dob = '2016-01-01'::date, updated_at = now() WHERE id = 'dcc276c2-0264-4461-9a77-f98cb1beac28'::uuid;

-- Sailor: Pacharapol Rumvisai (pacharapol-rumvisai-2xx8xys)
UPDATE public.sailors SET dob = '2010-01-01'::date, gender = 'M', updated_at = now() WHERE id = '8663b84c-2a24-4fc7-ab61-6598b3ff1fa3'::uuid;

-- Sailor: Sarutiya Rattanadechakorn (sarutiya-rattanadechakorn-vv7ekh4)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'a080465e-2c15-42a8-b8e4-ee24afb5fe74'::uuid;

-- Sailor: Natthapatr Poolklang (natthapatr-poolklang-thai25-9e4112)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = '9e411259-d0ba-54c8-8ad6-432256bc5770'::uuid;

-- Sailor: Hussaluk Srinakorn (hussaluk-srinakorn-2pumyyp)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = 'd73dd129-1d4d-4229-b0fc-3e7e67007681'::uuid;

-- Sailor: Napabhat Buasuang (napabhat-buasuang-kkc916t)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'e4c77476-aeef-45b2-b905-495b594b1353'::uuid;

-- Sailor: Kongphop Hupkrathoke (kongphop-hupkrathoke-tnc26-10138610)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = '10138610-378f-4b31-99c2-075944acabda'::uuid;

-- Sailor: Chattapat Somprasong (chattapat-somprasong-yhx7ypz)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '1b6eb642-a669-4bdc-8f1f-1d01d7b7e41e'::uuid;

-- Sailor: Dawika Yongchaiyut (asian-unk-dawika-yon-ca59a9)
UPDATE public.sailors SET dob = '2014-01-01'::date, club = 'RNSC', updated_at = now() WHERE id = '26c13e47-4224-43d2-b0fc-01b90b51e058'::uuid;

-- Sailor: Kittaluk Kulwattanaphan (kittaluk-kulwattanaphan-0te64nr)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '0c18ab78-d7b5-4843-bd57-89ef7738055a'::uuid;

-- Sailor: Pawnrapat Meewuttisom (asian-unk-pawnrapat--52be9b)
UPDATE public.sailors SET dob = '2016-01-01'::date, club = 'RNSC', updated_at = now() WHERE id = '324e747a-fbc3-429c-adaf-a96431a1cc73'::uuid;

-- Sailor: Thitaree Nakpasom (thitaree-nakpasom-tnc26-f0d3b033)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = 'f0d3b033-04cb-4f9c-9990-0052a25aec57'::uuid;

-- Sailor: Chayaphon Boonsang (chayaphon-boonsang-xpgf7p8)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'e4b10010-b002-4066-8025-a266795b69bb'::uuid;

-- Sailor: Weeratorn Poollarp (weeratorn-poollarp-zx70vdw)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '08cd9934-4024-4a64-ac6e-d6a8d687ab8f'::uuid;

-- Sailor: Thanchanok Thamajaruk (thanchanok-thamajaruk-9yyeov5)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'e6346805-2d51-49f8-acfb-b6bf1f1afc47'::uuid;

-- Sailor: Chiradej Leungthongkam (chiradej-leungthongkam-kro1ws3)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '214e19d2-eca3-4224-a65e-d56249b1e197'::uuid;

-- Sailor: Natkritta Boonsang (natkritta-boonsang-sbmfkm6)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '1e889e8d-dac7-4f91-a542-733afdadf74a'::uuid;

-- Sailor: Setthawit Yodmanee (setthawit-yodmanee-jdvl8az)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '8c67fc05-1caf-434c-88a5-71ad35c4fba0'::uuid;

-- Sailor: Suphasin Julpon (suphasin-julpon-thai26-2c5cda)
UPDATE public.sailors SET dob = '2017-01-01'::date, updated_at = now() WHERE id = '2c5cda5d-cbfe-5eea-9d56-121203448b4f'::uuid;

-- Sailor: Maira Hosanga (asian-unk-maira-hosa-f6b91d)
UPDATE public.sailors SET dob = '2014-01-01'::date, club = 'RNSC', updated_at = now() WHERE id = '97d9ff7c-c086-4d2b-8b8e-fd4cb32283f0'::uuid;

-- Sailor: Kritsada Bunmeang (asian-unk-kritsada-b-3b79b2)
UPDATE public.sailors SET dob = '2012-01-01'::date, club = 'RNSC', updated_at = now() WHERE id = '6a182a86-2f27-43cb-aad6-00045ae5d1a8'::uuid;

-- Sailor: Pavarisa Kaewlek (asian-unk-pavarisa-k-ab0677)
UPDATE public.sailors SET dob = '2015-01-01'::date, club = 'RNSC', updated_at = now() WHERE id = '57afc0b5-a27a-486a-84e1-ef59120d492c'::uuid;

-- Sailor: Nichawan Nithithongsakul (nichawan-nithithongsakul-sr26-846c6c)
UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now() WHERE id = '846c6c12-eed5-58e1-bd90-9fba7fe01007'::uuid;

-- Sailor: Aueangkun Jadsanam (aueangkun-jadsanam-sr26-2b2f39)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '2b2f3955-49bf-5a67-8643-70307409f211'::uuid;

-- Sailor: Piyangkun Moolprasert (piyangkun-moolprasert-f9xlv3b)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'c83f716e-c881-4c35-8c91-fb934d7b6cf4'::uuid;

-- Sailor: Anantachai Tiathongchai (anantachai-tiathongchai-onaqh0t)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '638fc9a3-1d0e-4e9d-a750-e44f46655473'::uuid;

-- Sailor: Chuhan Zhang (chuhan-zhang-oes2i91)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '4f43adc6-85a2-4017-9ccd-08a45484ffce'::uuid;

-- Sailor: Chananchai Tiathongchai (chananchai-tiathongchai-e3x85l3)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '611e949a-fdcf-4727-8dbf-1430097ac813'::uuid;

-- Sailor: Klaochanok Chatawattanasopakun (klaochanok-chatawattanasopakun-wds4018)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '04f1c65e-eeb7-4c89-9f6e-16298c33be02'::uuid;

-- Sailor: Andries Kosuge (asian-tha-andries-ko-4bbf2d)
UPDATE public.sailors SET dob = '2014-01-01'::date, club = 'YRAT', updated_at = now() WHERE id = 'dbf8b543-6a92-47ff-94c4-b103e58516de'::uuid;

-- Sailor: Suratsayapron Kaewrakum (asian-tha-suratsayap-1412cf)
UPDATE public.sailors SET dob = '2013-01-01'::date, club = 'ACDC.SC', updated_at = now() WHERE id = '6d6d7dd3-8b95-4230-af00-01321a224c3e'::uuid;

-- Sailor: Nattanan Chaiya-o-Cha (nattanan-chaiya-o-cha-xw0ncc0)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'e3d1a118-7f20-4f3d-851d-1dfa857566f2'::uuid;

-- Sailor: Papungkorn Kongprechasakul (papungkorn-kongprechasakul-tnc26-a1bb3db7)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = 'a1bb3db7-fb14-4510-b7f7-a890fd0ca31c'::uuid;

-- Sailor: Netchanok Chatawattanasopakun (netchanok-chatawattanasopakun-b63j9ly)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '8b594c37-db52-4549-a765-f51fd619238d'::uuid;

-- Sailor: Kanthee Khunmuang (asian-tha-kanthee-kh-35cbfe)
UPDATE public.sailors SET dob = '2014-01-01'::date, club = 'SSA', updated_at = now() WHERE id = '8953feed-5a7e-4fe1-978c-7ddcb9ac3fbb'::uuid;

-- Sailor: Dhan Chintanaseri Suksantinunt (dhan-chintanaseri-suksantinunt-3pq1rbq)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '768b3680-930d-4a1c-82d9-5dea9717701a'::uuid;

-- Sailor: Kanthon Khunmuang (asian-tha-kanthon-kh-e585c6)
UPDATE public.sailors SET dob = '2014-01-01'::date, club = 'SSA', updated_at = now() WHERE id = 'fe102225-248d-48a9-a92c-683cadcdbda8'::uuid;

-- Sailor: Kittitat Noondee (kittitat-noondee-2g6ggc3)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'ced44631-e8f2-4b82-86d9-abcb4ca86b41'::uuid;

-- Sailor: Thee Parinyanitikun (thee-parinyanitikun-iopp2jx)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'f49c46b2-1104-4950-ae41-4c378e94cf09'::uuid;

-- Sailor: Dhammaporn Aruno (dhammaporn-aruno-v6gx0i8)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'b6cda8c3-5a90-4a1d-88d6-b0f52996cab7'::uuid;

-- Sailor: Pumitus Mee-Iamsin (pumitus-mee-iamsin-thai25-4f1eb5)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '4f1eb555-5b44-517d-8d05-9ff0fd18f5ec'::uuid;

-- Sailor: Thanvisit Kitchanasiri (thanvisit-kitchanasiri-thai25-278c69)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '278c69d0-93d3-5d35-8deb-307457689a0d'::uuid;

-- Sailor: Noppassorn Khunboonjan (noppassorn-khunboonjan-69917e4211)
UPDATE public.sailors SET dob = '2006-01-01'::date, updated_at = now() WHERE id = 'd29da64f-723a-45e0-a4d6-57eb7a1b1e82'::uuid;

-- Sailor: Thorfun Boonnak (thorfun-boonnak-sr26-5cfe0b)
UPDATE public.sailors SET dob = '2005-01-01'::date, updated_at = now() WHERE id = '5cfe0b90-2ff3-5777-9fdd-9d29aeb5883c'::uuid;

-- Sailor: Marion Grace Montgomery (marion-grace-montgomery-sr26-0f33df)
UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now() WHERE id = '0f33df5e-ca62-502f-a771-b44846d6ac6a'::uuid;

-- Sailor: Patcharee Sringam (patcharee-sringam-sr26-7dbdb6)
UPDATE public.sailors SET dob = '2003-01-01'::date, updated_at = now() WHERE id = '7dbdb651-0954-5059-be8f-8ea0e85883dd'::uuid;

-- Sailor: Teekatat Dangpratum (teekatat-dangpratum-sr26-9b4038)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '9b40387d-1640-592d-b94f-5eb5f0cdcd5d'::uuid;

-- Sailor: Yueyan Jin (yueyan-jin-zbqbb4k)
UPDATE public.sailors SET dob = '2012-01-01'::date, gender = 'F', updated_at = now() WHERE id = '4ea7704c-a106-47d1-b424-6565e8dd9c3f'::uuid;

-- Sailor: Wichayaporn Saksriklom (wichayaporn-saksriklom-lf81guh)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '988b923b-6960-4d5e-be75-d53c32295492'::uuid;

-- Sailor: Trairat Jaroonrot (asian-tha-trairat-ja-e891d7)
UPDATE public.sailors SET dob = '2011-01-01'::date, club = 'ACDC.SC', updated_at = now() WHERE id = '60c5d690-0e0b-4f2e-b26e-d549221783b4'::uuid;

-- Sailor: Thanapha Phongkamnerd (thanapha-phongkamnerd-eq3gexa)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'b4cbc0a1-4813-41b7-beec-27beba3e6301'::uuid;

-- Sailor: Naimakron Jangkittiyarat (naimakron-jangkittiyarat-rtbu36u)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '415e383a-0bee-4a69-a00c-84efb0428508'::uuid;

-- Sailor: Suchanya Kaminthong (asian-tha-suchanya-k-3cf3c3)
UPDATE public.sailors SET dob = '2011-01-01'::date, club = 'NAC3SC', updated_at = now() WHERE id = 'fdb5520d-f181-4d5a-ad46-8157fd378a1a'::uuid;

-- Sailor: Amarin Juntajon (amarin-juntajon-6j5cgat)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'aa2952d1-ba70-464e-8666-096ff9fef554'::uuid;

-- Sailor: Punyisa Kaewlek (asian-unk-punyisa-ka-5c5bfa)
UPDATE public.sailors SET dob = '2011-01-01'::date, club = 'RNSC', updated_at = now() WHERE id = 'ca781c67-adcc-48a4-8508-325225b8b71e'::uuid;

-- Sailor: Nirada Sasiwattanaporn (asian-tha-nirada-sas-239840)
UPDATE public.sailors SET dob = '2014-01-01'::date, club = 'YRAT', updated_at = now() WHERE id = 'fd3c4362-b9e5-4fce-bac2-01232f20d014'::uuid;

-- Sailor: Nopadol Tokpo (asian-unk-nopadol-to-6defdd)
UPDATE public.sailors SET dob = '2011-01-01'::date, club = 'RNSC', updated_at = now() WHERE id = 'd5453895-83cb-4b63-b701-804ce42ce4b2'::uuid;

-- Sailor: Charlie Basnet (asian-tha-charlie-ba-750403)
UPDATE public.sailors SET dob = '2015-01-01'::date, club = 'RNSC', updated_at = now() WHERE id = '02f7450f-b247-49cf-ba12-2f33a7f0642e'::uuid;

-- Sailor: Levy Apichai Wiedmann (asian-tha-levy-apich-debd2f)
UPDATE public.sailors SET dob = '2013-01-01'::date, club = 'RVYC', updated_at = now() WHERE id = 'bb321865-4298-43a9-b473-cf5dabf1f192'::uuid;

-- Sailor: Kulpichet Phanchang (asian-unk-kulpichet--69140d)
UPDATE public.sailors SET dob = '2012-01-01'::date, club = 'RNSC', updated_at = now() WHERE id = '97050c23-371f-427e-a571-e20486cbb936'::uuid;

-- Sailor: Nattapon Touttachon (nattapon-touttachon-bvpmt73)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'cb7dd15b-b058-430c-88e5-fe0c3a31830e'::uuid;

-- Sailor: Pimpisa Devahastin Na Ayudhya (pimpisa-devahastin-na-ayudhya-7yvd7vy)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '976342b7-69ec-4200-8e46-684855939591'::uuid;

-- Sailor: Hirunsira Munkhongpornpaiboon (hirunsira-munkhongpornpaiboon-enjhoth)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22'::uuid;

-- Sailor: Kittiphat Sachato (kittiphat-sachato-thai26-433063)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = '433063e8-3178-50b1-8b3e-68470a3e8cc6'::uuid;

-- Sailor: Arunee Raksapun (arunee-raksapun-u24jkub)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '46276ce9-0d69-49d0-8ae0-b56f6a888535'::uuid;

-- Sailor: Natthakit Jongrak (asian-unk-natthakit--bc326a)
UPDATE public.sailors SET dob = '2012-01-01'::date, club = 'RNSC', updated_at = now() WHERE id = '9d7339ce-8bae-46eb-bae6-f6a2c7791e65'::uuid;

-- Sailor: Aranya Klangmueang (aranya-klangmueang-0gxqda0)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '9122c3b5-7b7d-43c1-ab7b-c5d2d2f2fb96'::uuid;

-- Sailor: Napichaya Rattanadechakorn (napichaya-rattanadechakorn-03dz6c6)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'e8ce1948-803f-4646-a2f5-88d4c7ead815'::uuid;

-- Sailor: Vajirawit Siriphak (asian-tha-vajirawit--c5815c)
UPDATE public.sailors SET dob = '2015-01-01'::date, club = 'SSA', updated_at = now() WHERE id = 'feed1618-5c28-484a-bd9c-a31f17b192a1'::uuid;

-- Sailor: Tasanatham Suthamgosal (asian-tha-tasanatham-481c84)
UPDATE public.sailors SET dob = '2015-01-01'::date, club = 'ACDC', updated_at = now() WHERE id = '7a475df7-bc47-43cf-bab3-815222279ece'::uuid;

-- Sailor: Kanyapat Pisoottiwong (kanyapat-pisoottiwong-6sr2pun)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '6b42e276-4836-4f99-bb40-0542ee7b5dde'::uuid;

-- Sailor: Proud Parintarakul (asian-tha-proud-pari-0161e8)
UPDATE public.sailors SET dob = '2014-01-01'::date, club = 'SSA', updated_at = now() WHERE id = 'de564928-6def-4b4a-96df-17358fdfc7c5'::uuid;

-- Sailor: Navatawan Jeanjit (navatawan-jeanjit-sr26-1c03e3)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = '1c03e3e7-ea29-526f-88b3-fd77ce113868'::uuid;

-- Sailor: Chayakorn Wattanakorn (asian-unk-chayakorn--bd8f22)
UPDATE public.sailors SET dob = '2012-01-01'::date, club = 'RNSC', updated_at = now() WHERE id = '206dd2e4-8f98-44d1-ac2b-3e46f5dcf272'::uuid;

-- Sailor: Santhat Suthamgosal (asian-tha-santhat-su-2e78e2)
UPDATE public.sailors SET dob = '2013-01-01'::date, club = 'ACDC', updated_at = now() WHERE id = '154feedb-6173-4142-8d3e-88f1567b22e7'::uuid;

-- Sailor: Chi Fangxi (chi-fangxi-sr26-6c4cad)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = '6c4cadb3-59d5-55ae-af65-88c069f5b374'::uuid;

-- Sailor: Chen Youcheng (asian-chn-chen-youch-5784f0)
UPDATE public.sailors SET dob = '2014-01-01'::date, club = 'SHENZHEN Linghang', updated_at = now() WHERE id = '522321a9-7d84-4285-9d1c-6287b6056576'::uuid;

-- Sailor: Alexander Ross (alexander-ross-thai25-20dfff)
UPDATE public.sailors SET dob = '2009-01-01'::date, gender = 'M', updated_at = now() WHERE id = '20dfff42-b4fa-5f34-b5ae-fbeafe975aa5'::uuid;

-- Sailor: Kim Jun Mo (kim-jun-mo-sr26-0d87c7)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '0d87c76a-54be-5d3d-acfe-8ce144c04ca1'::uuid;

-- Sailor: Lee Songha (lee-songha-thai25-1417d1)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '1417d151-f47b-5780-8ab8-efbc022a440f'::uuid;

-- Sailor: Lee Soo Min (lee-soo-min-sr26-c43c92)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = 'c43c92c7-4890-5d5d-9f9e-b938fc455ad6'::uuid;

-- Sailor: Chitipat Sainumkheaw (chitipat-sainumkheaw-thai25-c6fe76)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = 'c6fe767e-b1e5-550f-8393-3bc3d9a70fe3'::uuid;

-- Sailor: An Seoyi (an-seoyi-sr26-47cfa1)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = '47cfa169-dc99-599b-b90c-020a461aef30'::uuid;

-- Sailor: Panuwat Sriroy (panuwat-sriroy-thai26-034cb0)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '034cb0d9-7488-5e16-a97a-1b8a581a71a6'::uuid;

-- Sailor: Kim Do Hwan (kim-do-hwan-sr26-303320)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '3033206a-5327-54a1-b767-1509caf170bb'::uuid;

-- Sailor: Kim Jihoo (kim-jihoo-sr26-a1a0f3)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = 'a1a0f318-2766-5caa-b62f-13326d532d4e'::uuid;

-- Sailor: Baramee Sonnual (baramee-sonnual-thai26-6f60ba)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec'::uuid;

-- Sailor: Lee Hyun Been (lee-hyun-been-sr26-d456f9)
UPDATE public.sailors SET dob = '2016-01-01'::date, updated_at = now() WHERE id = 'd456f933-1422-5605-b2eb-d3121e7e932f'::uuid;

-- Sailor: Nattayut Jangkittiyarat (asian-tha-nattayut-j-5d6010)
UPDATE public.sailors SET dob = '2012-01-01'::date, club = 'YRAT', updated_at = now() WHERE id = '5f89e38f-4972-43dc-8323-906310cf159a'::uuid;

-- Sailor: Theetawat Manitpornsut (theetawat-manitpornsut-thai26-ba7eba)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = 'ba7eba1c-42d5-5035-839c-91d10145cf3c'::uuid;

-- Sailor: Kim Jihee (kim-jihee-sr26-f816db)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = 'f816db7a-a669-54ff-87d5-8f6c89e91439'::uuid;

-- Sailor: Min Seong Bin (min-seong-bin-sr26-641df9)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '641df9b4-7692-5a50-b293-786f33e29582'::uuid;

-- Sailor: Taratep Janlamoon (taratep-janlamoon-sr26-fb5bf7)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = 'fb5bf764-c958-5156-b06e-0fef2cf780b5'::uuid;

-- Sailor: Chanyaphas Sasirojthanakul (chanyaphas-sasirojthanakul-sr26-4ced73)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = '4ced7340-6118-5b3b-af3b-135bf1cea16c'::uuid;

-- Sailor: Alisa Singsa (alisa-singsa-sr26-63a7e1)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '63a7e1f8-1611-56a3-81fb-579c478ab51a'::uuid;

-- Sailor: Paranee Muangngam (paranee-muangngam-sr26-92b23e)
UPDATE public.sailors SET dob = '2007-01-01'::date, updated_at = now() WHERE id = '92b23e0a-9b81-518e-b23a-a46fab806ace'::uuid;

-- Sailor: Arunrat Thephakham (arunrat-thephakham-sr26-cdee1f)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = 'cdee1fd0-1af5-5f8a-a776-c640153fba66'::uuid;

-- Sailor: Kunakon Kaewluan (kunakon-kaewluan-sr26-0f5181)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = '0f51817e-5a82-5421-96ca-e7f624b5e26a'::uuid;

-- Sailor: Pittayut Wattanakiri (pittayut-wattanakiri-sr26-5bb555)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = '5bb555f5-7fc1-5f20-90fe-c532baba5351'::uuid;

-- Sailor: Yu Kai Chen (yu-kai-chen-sr26-76e668)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '76e668c0-57c9-50d2-b8d5-abd0f966d313'::uuid;

-- Sailor: Lu Zixi (historical-2024-csc-ilca4-jan-2024-18d7373c7fd0)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = 'bff8a281-7801-428a-934c-3dc80816585b'::uuid;

-- Sailor: Yinran Chen (yinran-chen-thai25-187fbb)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '187fbbb7-9c46-5752-a64a-57858dd86879'::uuid;

-- Sailor: Sanchuan Wu (sanchuan-wu-sr26-3142f4)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '3142f40a-2106-5ac4-8f52-4afeaa160cb4'::uuid;

-- Sailor: Liu Tzu Ho (liu-tzu-ho-sr26-6b17e3)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '6b17e39b-16cf-50f3-ab55-ee809710b347'::uuid;

-- Sailor: Cai Ming Zhou (cai-ming-zhou-thai25-5cee72)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '5cee7204-4a0c-538a-aabf-9f8e5c7884bf'::uuid;

-- Sailor: Chonghao Anson Huang (chonghao-anson-huang-sr26-19ec1f)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '19ec1fe1-4cdb-5ee2-85c1-61bf87a1ee6d'::uuid;

-- Sailor: Cheryl Sitong (cheryl-sitong-sr26-21b5d6)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '21b5d619-dc42-591b-87e9-0be3d2336594'::uuid;

-- Sailor: Capucine Lala Collin (capucine-lala-collin-sr26-5cb993)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '5cb993b9-4809-5192-864e-261f913b90c0'::uuid;

-- Sailor: Jung Hyewon (jung-hyewon-sr26-9a71b9)
UPDATE public.sailors SET dob = '2004-01-01'::date, updated_at = now() WHERE id = '9a71b922-1236-52ad-83b6-8810421a88ff'::uuid;

-- Sailor: Ton Rattana (ton-rattana-thai25-717ef0)
UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now() WHERE id = '717ef058-5716-5951-a848-0723f95e8f28'::uuid;

-- Sailor: Luo Yixiu (luo-yixiu-sr26-a4b376)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40'::uuid;

-- Sailor: Torn Rattana (torn-rattana-thai25-efba7d)
UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now() WHERE id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1'::uuid;

-- Sailor: Yiming Jason Wu (yiming-jason-wu-sr26-4feb0a)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'::uuid;

-- Sailor: Teng-Hsi Yeh (teng-hsi-yeh-sr26-3a8088)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '3a8088c8-5adb-5a4f-9dda-bf34404d55e7'::uuid;

-- Sailor: Kim Chaerin (kim-chaerin-sr26-589b14)
UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now() WHERE id = '589b14b6-5008-5a64-ad4c-5b893e9a92ff'::uuid;

-- Sailor: Huang Zishu (huang-zishu-sr26-06a0dc)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '06a0dcfb-42ad-557b-baab-b42f3a0ad0f8'::uuid;

-- Sailor: Yufan Tao (yufan-tao-thai25-7b944a)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '7b944a18-0371-56e6-976d-9f7df74d87bc'::uuid;

-- Sailor: Min Sol Cheon (min-sol-cheon-sr26-cbe7bb)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = 'cbe7bbbc-52f2-53ca-b5f4-ad6ae2d538a7'::uuid;

-- Sailor: Dayeon Yang (dayeon-yang-sr26-f6f97b)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd'::uuid;

-- Sailor: Nanvatorn Supaamphonwit (nanvatorn-supaamphonwit-sr26-6259e9)
UPDATE public.sailors SET dob = '2007-01-01'::date, updated_at = now() WHERE id = '6259e9da-6ed2-58be-be0d-cca5fed97989'::uuid;

-- Sailor: Wiliam Marsh (wiliam-marsh-thai25-695ca6)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '695ca6a9-5d55-50bf-ae5b-51dfb8c36d2d'::uuid;

-- Sailor: Darwin Hsu (darwin-hsu-zirotlz)
UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now() WHERE id = '735e74cd-7ea1-473f-bd4f-c181e97fa781'::uuid;

-- Sailor: Finley Dickinson (finley-dickinson-sr26-bd12b3)
UPDATE public.sailors SET dob = '2003-01-01'::date, updated_at = now() WHERE id = 'bd12b3b9-5f4c-5158-8679-d43a3cf0de01'::uuid;

-- Sailor: Nooa Laukkanen (nooa-laukkanen-sr26-e1dc8e)
UPDATE public.sailors SET dob = '2000-01-01'::date, updated_at = now() WHERE id = 'e1dc8ede-6165-5274-be6a-c1ccb427383d'::uuid;

-- Sailor: Chusitt Punjamala (chusitt-punjamala-sr26-d11db9)
UPDATE public.sailors SET dob = '1998-01-01'::date, updated_at = now() WHERE id = 'd11db91a-8fad-577e-9f7e-ac8fba71c426'::uuid;

-- Sailor: Bo Jeong (bo-jeong-sr26-5526ab)
UPDATE public.sailors SET dob = '1990-01-01'::date, updated_at = now() WHERE id = '5526abbf-1430-56af-bc56-281233e66d8e'::uuid;

-- Sailor: Bowonnan Chanram (bowonnan-chanram-sr26-fbd4f3)
UPDATE public.sailors SET dob = '2005-01-01'::date, updated_at = now() WHERE id = 'fbd4f3f7-3219-5709-b57c-8681d69adbde'::uuid;

-- Sailor: Leekwangyeon (leekwangyeon-sr26-cad979)
UPDATE public.sailors SET dob = '1992-01-01'::date, updated_at = now() WHERE id = 'cad979ce-2cfe-55aa-8175-559954cd9be9'::uuid;

-- Sailor: Lucas Lele Collin (lucas-lele-collin-sr26-a0c434)
UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now() WHERE id = 'a0c43406-eac5-5b58-9e94-684f1644e454'::uuid;

-- Sailor: Gordon Alexander Allan (gordon-alexander-allan-c32df510a0)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '97828399-4ff6-40c1-8deb-6b308b6072ad'::uuid;

-- Sailor: Yu Shin Chen (yu-shin-chen-sr26-9922c4)
UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now() WHERE id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164'::uuid;

-- Sailor: You Jin Suk (you-jin-suk-sr26-37bd1c)
UPDATE public.sailors SET dob = '2006-01-01'::date, updated_at = now() WHERE id = '37bd1c83-48d5-5e73-9ece-d85a67115d4e'::uuid;

-- Sailor: Kim Se Yun (kim-se-yun-sr26-65e15a)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '65e15ab2-5157-51ad-85d8-9f12a42cdea8'::uuid;

-- Sailor: Sam Whaley (sam-whaley-sr26-d837be)
UPDATE public.sailors SET dob = '2004-01-01'::date, updated_at = now() WHERE id = 'd837be48-a6fe-570c-b8e8-a180c02b1751'::uuid;

-- Sailor: Im Taehun (im-taehun-sr26-91555c)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '91555cde-f340-52e6-b977-c3c4aff8abaa'::uuid;

-- Sailor: Narahan (narahan-sr26-5590ae)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '5590ae28-9ad5-580b-8b62-f4cd0b6b1c93'::uuid;

-- Sailor: Jeongyeon Kim (jeongyeon-kim-sr26-7302a7)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '7302a702-2b88-5d53-a946-0bd10f257f43'::uuid;

-- Sailor: Song Hae Heo (song-hae-heo-sr26-d86ac1)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = 'd86ac1bf-fcbc-54bc-892b-63b75a5ecdcc'::uuid;

-- Sailor: Nut Butmarasri (nut-butmarasri-sr26-a261ca)
UPDATE public.sailors SET dob = '1993-01-01'::date, updated_at = now() WHERE id = 'a261ca31-6006-5ab7-8d9d-f88593215c5b'::uuid;

-- Sailor: Kim Ji An (kim-ji-an-sr26-b42c92)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = 'b42c9278-742b-5d1a-a60e-ec352f9c5f0b'::uuid;

-- Sailor: Thanakrit Phokaew (thanakrit-phokaew-sr26-d89c5e)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = 'd89c5ebf-fb9b-5861-8fa4-67a8c3e815d4'::uuid;

-- Sailor: Chanyachart Ittivorakul (chanyachart-ittivorakul-hkrw-863b5d)
UPDATE public.sailors SET dob = '2012-01-01'::date, gender = 'M', club = 'PATTAYA SAILING CLUB', updated_at = now() WHERE id = '863b5d54-6357-50d0-b16e-75e44de37e41'::uuid;

-- Sailor: Auengkun Jadsanam (auengkun-jadsanam-sr26-525c8f)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15'::uuid;

-- Sailor: Ardchawit Ittivorakul (ardchawit-ittivorakul-sr26-e71d82)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = 'e71d82de-c6c0-54c4-a952-20af252061c9'::uuid;

-- Sailor: Muhammad Hadif Nabihn Bin Rashidi (muhammad-hadif-nabihn-bin-rashidi-sr26-e4c9ae)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7'::uuid;

-- Sailor: Aina Qasrina Binti Yuslizam (aina-qasrina-binti-yuslizam-sr26-f7c2b1)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = 'f7c2b125-af12-5716-98bf-b05bfaa6666b'::uuid;

-- Sailor: Muhammad Fikri Aqil Bin Mohd Fouzi (muhammad-fikri-aqil-bin-mohd-fouzi-sr26-b953fc)
UPDATE public.sailors SET dob = '2007-01-01'::date, updated_at = now() WHERE id = 'b953fc9b-8e11-5982-bcfd-874d440c373b'::uuid;

-- Sailor: Nur Faarihah Binti Abdul Rani (nur-faarihah-binti-abdul-rani-sr26-ce278b)
UPDATE public.sailors SET dob = '2007-01-01'::date, updated_at = now() WHERE id = 'ce278b06-d698-5f58-b57b-e901c9f7b859'::uuid;

-- Sailor: Zeti Irdina Binti Zainal (zeti-irdina-binti-zainal-thai25-aa32a8)
UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now() WHERE id = 'aa32a80e-daae-5beb-81f4-47f68f292b92'::uuid;

-- Sailor: Mina Oishi Siamchai (mina-oishi-siamchai-tnc26-f1958ce5)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = 'f1958ce5-e255-4962-9d58-c7268d33220a'::uuid;

-- Sailor: Kittithach Thongthiem (kittithach-thongthiem-907fv61)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '0acc5235-e699-4c56-8840-72055623ca63'::uuid;

-- Sailor: Bhuvadit Bhutiyodhin (bhuvadit-bhutiyodhin-tnc26-d2d56ada)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = 'd2d56ada-1e3b-456e-9519-49085dd9b425'::uuid;

-- Sailor: Teerawat Samranyjai (teerawat-samranyjai-sr26-b31b79)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = 'b31b79a4-1a1e-5d10-bd1d-4c4e55ca9bbd'::uuid;

-- Sailor: Kawin Phechrak (kawin-phechrak-sr26-de6568)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = 'de656835-8553-582b-9ef0-5afbfe331df6'::uuid;

-- Sailor: Tasanatham (tasanatham-sr26-99affe)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = '99affeff-5c90-56f6-a8a9-82a74805a519'::uuid;

-- Sailor: Nutthawee Thaikamnerd (nutthawee-thaikamnerd-sr26-6f915f)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = '6f915ff9-f131-53d3-a3fa-fefd820edc52'::uuid;

-- Sailor: Austin Yeo Jia Yu (austin-yeo-jia-yu-j2xhftv)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = 'd7ce117b-5c64-40ea-86bd-79a7a73bb833'::uuid;

-- Sailor: Darius Low Xian Rui (darius-low-xian-rui-jbyo9tw)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '8ec46c01-1663-4341-9c77-40da9edfe4ce'::uuid;

-- Sailor: Darren Lai (darren-lai-jdz3rv5)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '8065d18f-d94f-4961-b18f-d126676ce052'::uuid;

-- Sailor: Preet Siwal (preet-siwal-2qkw8co)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'd41014b8-67ad-4e56-9e87-55d51612d5a8'::uuid;

-- Sailor: Ankit Singh Sisodiya (ankit-singh-sisodiya-2solj4k)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'fb2cf4bb-32bc-4e9e-a043-0487c30db99a'::uuid;

-- Sailor: Shubham Yadav (shubham-yadav-2w66ldr)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'dde1d11b-b8e9-410f-94c7-1daee5ecdd4e'::uuid;

-- Sailor: Vasu Chandrawanshi (vasu-chandrawanshi-1jm00b2)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '4dadff72-b3fe-4c5e-9b30-fbb6a47b25f5'::uuid;

-- Sailor: Ruoqi Zhang (ruoqi-zhang-336p0bz)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '50b3e0fd-0917-4cf1-b223-34ee0dcf9574'::uuid;

-- Sailor: Wanjia He (wanjia-he-33vztme)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'd62589f0-8e56-49df-9295-428a064c02ea'::uuid;

-- Sailor: Daqi He (daqi-he-34y1hta)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '35164380-d568-477e-a007-5d48b1130855'::uuid;

-- Sailor: Muhammad Harith Qaiser Bin Ahmad Mokhdas (asian-mas-muhammad-h-20c5d5)
UPDATE public.sailors SET dob = '2013-01-01'::date, club = 'Sail''a''', updated_at = now() WHERE id = 'b7e64db8-0d81-4b8b-8904-f4e6b57735e1'::uuid;

-- Sailor: Natalie Wong Qiao En (asian-mas-natalie-wo-e6b0ec)
UPDATE public.sailors SET dob = '2011-01-01'::date, club = 'Sail''a''', updated_at = now() WHERE id = 'e7fe94b9-dfe0-4237-91e2-33c793171867'::uuid;

-- Sailor: Yang Junkai (yang-junkai-thai26-b140ab)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = 'b140ab56-69d0-5ec2-ba11-b294eff28bdb'::uuid;

-- Sailor: Ziqri Luqman Bin Zainal (asian-mas-ziqri-luqm-1c66b0)
UPDATE public.sailors SET dob = '2011-01-01'::date, club = 'Sail''a''', updated_at = now() WHERE id = '2bc77167-59b7-453b-a959-b01d2d516972'::uuid;

-- Sailor: Muhammad Abqaari Irham Bin Adam (asian-mas-muhammad-a-7f2a4d)
UPDATE public.sailors SET dob = '2013-01-01'::date, club = 'Sail''a''', updated_at = now() WHERE id = 'f18d7672-ba0b-4686-9aaf-556c8a39387e'::uuid;

-- Sailor: Macy Mosom Sikayun (asian-mas-macy-mosom-902545)
UPDATE public.sailors SET dob = '2014-01-01'::date, club = 'Sail''a''', updated_at = now() WHERE id = 'ff8172b4-8dc8-41c3-83a7-4022e268071a'::uuid;

-- Sailor: Li Zhouhang (li-zhouhang-thai26-90b395)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '90b395b8-0ae1-5cbc-b7e4-df3dc28b168e'::uuid;

-- Sailor: Min Myat Ponnya (min-myat-ponnya-mya396)
UPDATE public.sailors SET dob = '2017-01-01'::date, gender = 'M', club = 'YSC', updated_at = now() WHERE id = '751b399d-fdaf-53b9-8a24-3d7984746888'::uuid;

-- Sailor: Huang Yanbo (huang-yanbo-thai26-d9625b)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = 'd9625b56-c8ce-5f12-966c-85b474958b55'::uuid;

-- Sailor: Duangdeuen Wichai (duangdeuen-wichai-thai26-dfefca)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = 'dfefca66-a570-5f96-bec6-eb566501bdbb'::uuid;

-- Sailor: Shine Khant (shine-khant-mya384)
UPDATE public.sailors SET dob = '2015-01-01'::date, gender = 'M', club = 'YSC', updated_at = now() WHERE id = '0ce682fc-3665-5510-bbf6-66271c760f7f'::uuid;

-- Sailor: Gu Haoyi (gu-haoyi-thai26-d0704e)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = 'd0704e48-f450-5d36-8428-5f01c283d86e'::uuid;

-- Sailor: Nay Min Htet (nay-min-htet-mya407)
UPDATE public.sailors SET dob = '2013-01-01'::date, gender = 'M', club = 'ISPE', updated_at = now() WHERE id = 'ed6e93cb-d195-5024-8a33-660ad4d2badb'::uuid;

-- Sailor: Chen Le (chen-le-thai26-9362d1)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = '9362d146-9d82-57c9-b5d7-29a0fc66b082'::uuid;

-- Sailor: Kaung Khant Khant Ko (kaung-khant-khant-ko-mya382)
UPDATE public.sailors SET dob = '2015-01-01'::date, gender = 'M', club = 'YSC', updated_at = now() WHERE id = '611ef739-d28b-57c3-b6fe-183b006a2a38'::uuid;

-- Sailor: Song Zhucran (song-zhucran-thai26-bf0d5c)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = 'bf0d5c86-8336-5945-927e-e9cc7999bfd8'::uuid;

-- Sailor: Thwin Min Sett (thwin-min-sett-mya405)
UPDATE public.sailors SET dob = '2011-01-01'::date, gender = 'M', club = 'YSC', updated_at = now() WHERE id = '621fc1d7-30a3-5ef6-81cb-b7c71002e05a'::uuid;

-- Sailor: Cheerawit Saiyaluxana (cheerawit-saiyaluxana-thai26-ad441d)
UPDATE public.sailors SET dob = '2016-01-01'::date, updated_at = now() WHERE id = 'ad441d27-47bd-533d-961a-346809d9ceba'::uuid;

-- Sailor: Cao Yufeng (cao-yufeng-thai26-df71e8)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = 'df71e85b-aff3-51b1-b351-9b83a52ac19a'::uuid;

-- Sailor: Liang Tailer (liang-tailer-thai26-42ebbd)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = '42ebbd48-1090-52fe-a3dd-735ab98ef6bb'::uuid;

-- Sailor: Baramee Connoi (baramee-connoi-thai26-6f14e2)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = '6f14e233-8f50-504f-9f2e-0d2b03655c85'::uuid;

-- Sailor: Phacharapol Munwong (phacharapol-munwong-thai26-816205)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '81620549-758e-5209-9f80-4ac3f7cedbbf'::uuid;

-- Sailor: JiaHe Liu (jiahe-liu-hkrw-e1a651)
UPDATE public.sailors SET dob = '2016-01-01'::date, gender = 'F', club = 'RHKYC', updated_at = now() WHERE id = 'e1a6517e-a545-5518-ab52-d34c4a13abf4'::uuid;

-- Sailor: Joshua Ananda Kurtz (joshua-ananda-kurtz-thai26-cb81b1)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = 'cb81b157-b2ea-5b9a-8e6d-201777826f50'::uuid;

-- Sailor: Coen Woo (coen-woo-hkrw-edab6c)
UPDATE public.sailors SET dob = '2013-01-01'::date, gender = 'M', club = 'ELITE SAILING ACADEMY', updated_at = now() WHERE id = 'edab6cfd-b8c3-578f-903a-4db474912436'::uuid;

-- Sailor: Mingqian Wu (mingqian-wu-thai26-644428)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = '64442880-a775-5b7a-9d13-08a9cc5e45e4'::uuid;

-- Sailor: Chae Won Kim (chae-won-kim-thai26-fdc277)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = 'fdc27789-fa73-57f3-889a-b6baf8711377'::uuid;

-- Sailor: Kim Jung Woo (kim-jung-woo-thai26-297d4a)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = '297d4ae4-e6e4-523f-bbe1-86660370ad87'::uuid;

-- Sailor: Hui Wing Au (hui-wing-au-thai26-e547b0)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = 'e547b0c9-a0c5-5a5f-9063-18de5eefbb72'::uuid;

-- Sailor: Eric Revill (eric-revill-thai26-c35d01)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = 'c35d01a0-29b3-5057-97e5-5929965b5b3b'::uuid;

-- Sailor: Yi Sum Tan (yi-sum-tan-thai26-efb5ac)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = 'efb5ac82-c70e-5254-b913-bdaaa5ff6261'::uuid;

-- Sailor: Yejun Bbang (yejun-bbang-thai26-e86233)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = 'e862331e-b4f6-55e8-9a68-bd418a09d0f8'::uuid;

-- Sailor: Wai Lok Torres Wong (wai-lok-torres-wong-thai26-fc0c8c)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = 'fc0c8ce3-6255-5780-a6f3-469c85d2f009'::uuid;

-- Sailor: Yoogaon (yoogaon-thai26-3b9f6c)
UPDATE public.sailors SET dob = '2015-01-01'::date, updated_at = now() WHERE id = '3b9f6c7a-40dd-598a-b297-eb8258252fee'::uuid;

-- Sailor: Muhammad Anas Aryan Bin Mohd Noor Ridzua (asian-mas-muhammad-a-96dfac)
UPDATE public.sailors SET dob = '2014-01-01'::date, club = 'MSNP', updated_at = now() WHERE id = '77c4d782-8203-40be-a939-7e97a69de7c6'::uuid;

-- Sailor: Nur Amni Irdina Binti Norhisam (asian-mas-nur-amni-i-b64631)
UPDATE public.sailors SET dob = '2012-01-01'::date, club = 'MSNP', updated_at = now() WHERE id = 'ffe5af29-435b-4f94-b94f-14bc71ddb87d'::uuid;

-- Sailor: Nur Damia Binti Khairul Qahhar (asian-mas-nur-damia--6d8ea8)
UPDATE public.sailors SET dob = '2012-01-01'::date, club = 'PERAK', updated_at = now() WHERE id = '8c161009-f875-411d-8935-52f9f153ffeb'::uuid;

-- Sailor: Aqil Hafiz Bin Mohd Khairulzawawi (asian-mas-aqil-hafiz-d7fef7)
UPDATE public.sailors SET dob = '2011-01-01'::date, club = 'MSNP', updated_at = now() WHERE id = 'cdf9cbf1-798c-4caa-814b-df07993d944c'::uuid;

-- Sailor: Nattapon Chailob (nattapon-chailob-thai25-2480fe)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '2480fe9f-37e7-52c3-b126-6871b7b0b492'::uuid;

-- Sailor: Panudat Polpool (panudat-polpool-hkrw-2c3a79)
UPDATE public.sailors SET dob = '2012-01-01'::date, gender = 'M', club = 'YRAT', updated_at = now() WHERE id = '2c3a793f-5bb5-531e-9290-5d976898618a'::uuid;

-- Sailor: Jiratip Mutiphan (jiratip-mutiphan-thai25-5cd22c)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '5cd22c52-558f-598e-84df-07fbb27b43fc'::uuid;

-- Sailor: Judy Wang (judy-wang-thai25-185962)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '18596206-043a-5593-9e35-40c05af8c210'::uuid;

-- Sailor: Prin Kantharak (prin-kantharak-thai25-83d3c9)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '83d3c9be-253d-5fe7-913c-f4470eda1afe'::uuid;

-- Sailor: Tatigun Homchong (tatigun-homchong-thai25-21f21e)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = '21f21ea9-1c21-5a9c-82d1-8dc0bbf3e14f'::uuid;

-- Sailor: Pakin Wongratanachot (pakin-wongratanachot-thai25-7c7d0b)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '7c7d0b90-ee1b-5cc7-96af-bfd23c2ef872'::uuid;

-- Sailor: Mohammed Ziyad Abdul Latif Mohammed Al Qasimi (mohammed-ziyad-abdul-latif-mohammed-al-qasimi-thai25-3edc52)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = '3edc523c-41e6-5e12-a15c-557ab62f1f2c'::uuid;

-- Sailor: Thyracha Homchong (thyracha-homchong-thai25-886b06)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '886b0637-300f-56d1-9e65-b266b3cce606'::uuid;

-- Sailor: Robert Nazarov (robert-nazarov-thai25-baa793)
UPDATE public.sailors SET dob = '2014-01-01'::date, updated_at = now() WHERE id = 'baa79338-4886-5ff3-b916-81cc28a4708f'::uuid;

-- Sailor: Wang Yenchen (wang-yenchen-thai25-6d053b)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '6d053bcf-7741-5ee8-8028-e14d1a4f4396'::uuid;

-- Sailor: Kim Sandeul (kim-sandeul-thai25-d0a7e3)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = 'd0a7e399-5ee4-597a-a950-029e30c7c6bc'::uuid;

-- Sailor: Minseo Go (minseo-go-thai25-6073f6)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '6073f676-f634-50e1-a48b-d4768bef9ff6'::uuid;

-- Sailor: Kunladech Bunchu (kunladech-bunchu-thai25-eb4dfc)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = 'eb4dfcde-6164-5b00-b483-98d0ea6e8172'::uuid;

-- Sailor: Leeruda Park (leeruda-park-thai25-bf7c46)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = 'bf7c461a-4dda-51b3-ba94-34a4d9ec8f73'::uuid;

-- Sailor: Shim Junbo (shim-junbo-thai25-7eef2a)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = '7eef2a3d-8228-5859-b2db-6a98fd166d5e'::uuid;

-- Sailor: An Soe (an-soe-thai25-9c0928)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = '9c09287e-3fe4-5157-bb81-7d510c95e166'::uuid;

-- Sailor: Minjoon Seo (minjoon-seo-thai25-bdd614)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = 'bdd614e3-c491-5f94-8b63-65c165359272'::uuid;

-- Sailor: Hwon Kim (hwon-kim-thai25-066aed)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = '066aedea-7cf8-504b-8410-2f5e0cc3b813'::uuid;

-- Sailor: Prin Subying (prin-subying-zi3cbf5)
UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now() WHERE id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8'::uuid;

-- Sailor: Zsolt Szalay (zsolt-szalay-thai25-9dac82)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '9dac82f1-ca4f-554d-9a13-49c59feab0d5'::uuid;

-- Sailor: Chen Yu Kai (chen-yu-kai-thai25-ad7a6b)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'::uuid;

-- Sailor: Eszter Szalay (eszter-szalay-thai25-12ef57)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '12ef5727-01d3-5d57-97b2-86b18a3f73b6'::uuid;

-- Sailor: Huanran Zheng (huanran-zheng-zntih2y)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '87cc8912-d304-407f-934f-5cadd7a4921e'::uuid;

-- Sailor: Henry Wiedmann (henry-wiedmann-thai25-bdcd04)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = 'bdcd0461-7642-50c2-9dca-65b6d4d56020'::uuid;

-- Sailor: Howan Luo (howan-luo-thai25-0d4bf2)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '0d4bf218-dbe4-5785-9f8f-0a5efe900408'::uuid;

-- Sailor: Nina Wang (nina-wang-zn551mf)
UPDATE public.sailors SET dob = '2010-01-01'::date, updated_at = now() WHERE id = '0b42963a-efa1-4010-9029-b50953b6f1fb'::uuid;

-- Sailor: Evie Mcguire (evie-mcguire-thai25-18bb22)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '18bb2200-4c5d-56d5-b978-7ed26e16c9d1'::uuid;

-- Sailor: Devan De (devan-de-thai25-04106d)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = '04106d7d-d0a4-592d-a71c-289bc7ac08ad'::uuid;

-- Sailor: Cheryl Shen (cheryl-shen-thai25-83677e)
UPDATE public.sailors SET dob = '2011-01-01'::date, updated_at = now() WHERE id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'::uuid;

-- Sailor: Yixiu Luo (yixiu-luo-thai25-850d22)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '850d22a6-c404-5711-b0ab-e99507659b38'::uuid;

-- Sailor: Lijian Zhong (lijian-zhong-thai25-94e28b)
UPDATE public.sailors SET dob = '2007-01-01'::date, updated_at = now() WHERE id = '94e28ba6-4b15-5aae-a801-777e30efd6a8'::uuid;

-- Sailor: Chen Yu Shin (chen-yu-shin-thai25-27cdb9)
UPDATE public.sailors SET dob = '2008-01-01'::date, updated_at = now() WHERE id = '27cdb9d1-3035-5a39-b85a-94533038a886'::uuid;

-- Sailor: Yiming Wu (yiming-wu-thai25-471946)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '471946e4-4cdb-5541-aa11-255fcc0f38bc'::uuid;

-- Sailor: Adam Lwan Carraz (adam-lwan-carraz-thai25-42b8ba)
UPDATE public.sailors SET dob = '2009-01-01'::date, updated_at = now() WHERE id = '42b8bae3-8035-58e9-8efd-b67e3597a437'::uuid;

-- Sailor: Toby Phillips (toby-phillips-worlds26-f8f1b2)
UPDATE public.sailors SET dob = '2011-01-01'::date, club = 'BSYC', updated_at = now() WHERE id = 'f8f1b2c8-c396-501f-a6dd-f51b6aa782d9'::uuid;

-- Sailor: Jack Mcguire (jack-mcguire-anz26-9e8f46)
UPDATE public.sailors SET dob = '2013-01-01'::date, updated_at = now() WHERE id = '9e8f469d-4386-46dc-8533-5babc753dd05'::uuid;

-- Sailor: Oliver Johnson (oliver-johnson-anz26-ca6aad)
UPDATE public.sailors SET dob = '2012-01-01'::date, updated_at = now() WHERE id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81'::uuid;

-- Sailor: Harry Creak (harry-creak-anz26-3079ac)
UPDATE public.sailors SET dob = '2011-01-01'::date, nationality = 'AUS', updated_at = now() WHERE id = '3079ace8-c905-42fb-b258-bbb7d13b299c'::uuid;

-- Sailor: Myles Phillips (myles-phillips-anz26-8a0f73)
UPDATE public.sailors SET dob = '2012-01-01'::date, nationality = 'AUS', updated_at = now() WHERE id = '8a0f7357-41e8-4de1-bf45-1353aaa660b0'::uuid;

-- Sailor: Alexander Eyles (alexander-eyles-anz26-b8a072)
UPDATE public.sailors SET dob = '2014-01-01'::date, nationality = 'AUS', updated_at = now() WHERE id = 'b8a072c9-bbbf-44e6-9154-9a3994a9cf49'::uuid;

-- Sailor: Sam Watters (sam-watters-anz26-6b018a)
UPDATE public.sailors SET dob = '2011-01-01'::date, nationality = 'AUS', updated_at = now() WHERE id = '6b018a70-4cd0-4307-beef-30c45fb40753'::uuid;

-- Sailor: Andre Baou Martin (asian-mas-andre-baou-d41bb8)
UPDATE public.sailors SET dob = '2014-01-01'::date, club = 'SABAH', updated_at = now() WHERE id = '012ca05a-4f76-4d80-8f49-afffe983966f'::uuid;

-- Sailor: Kassawee Homchong (kassawee-homchong-thai25-17dd9b)
UPDATE public.sailors SET dob = '2016-01-01'::date, updated_at = now() WHERE id = '17dd9b0f-f384-5ace-bebf-720276aa2dfe'::uuid;

-- Sailor: Yongchen Xu (yongchen-xu-hkrw-3d02f9)
UPDATE public.sailors SET club = 'SHANGHAI TRANSCEND CLUB', updated_at = now() WHERE id = '3d02f97d-0442-5d8e-af88-4962e257a0b3'::uuid;

-- Sailor: ZiHang Huang (zihang-huang-hkrw-ae80d7)
UPDATE public.sailors SET club = 'CHENJINHAO RACE TEAM', updated_at = now() WHERE id = 'ae80d7a7-dda5-52a9-afe3-66097ba27d7f'::uuid;

-- Sailor: Ruby Hana Ong (ruby-hana-ong-hkrw-b2a1db)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = 'b2a1dbe3-0338-5a56-8775-61def7008e65'::uuid;

-- Sailor: George Ciemniak (george-ciemniak-hkrw-dc7eb9)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = 'dc7eb913-9796-5fcb-a208-b03836cf0fd1'::uuid;

-- Sailor: Kean Phua (kean-phua-hkrw-2a84a2)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = '2a84a267-4e80-59c8-98f5-f6ef1c25a4f7'::uuid;

-- Sailor: Emelie Backe (emelie-backe-hkrw-2b7ff1)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '2b7ff104-e90a-5b3a-a485-a1b9ce0f4bd8'::uuid;

-- Sailor: Owen Ma (owen-ma-hkrw-83733c)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = '83733ca1-2856-5353-a945-889e72905ba0'::uuid;

-- Sailor: Lukas, Ka Yau Sun (lukas-ka-yau-sun-hkrw-f686a7)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = 'f686a790-3f9b-5015-9f74-a7eef3826746'::uuid;

-- Sailor: Ansel Lau (ansel-lau-hkrw-5f1d77)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = '5f1d771d-faa9-5148-9c51-61881859b740'::uuid;

-- Sailor: Annabel Looi (annabel-looi-hkrw-d43387)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = 'd4338726-99ce-5ad5-bee3-069cabaeab26'::uuid;

-- Sailor: Nathan, Nande Li (nathan-nande-li-f9rcn5w)
UPDATE public.sailors SET nationality = 'HKG', updated_at = now() WHERE id = '1c5900eb-e05a-4376-a668-e3cd7cf3a2db'::uuid;

-- Sailor: Konstantinos Sofronas (konstantinos-sofronas-hkrw-475eab)
UPDATE public.sailors SET club = 'Piraeus sailing club', updated_at = now() WHERE id = '475eab2a-5c6d-5c55-834a-ca1b4a48a502'::uuid;

-- Sailor: Yuxing Jiang (yuxing-jiang-hkrw-180bd8)
UPDATE public.sailors SET club = 'Blue Water', updated_at = now() WHERE id = '180bd8b1-0b27-5fd3-8fb8-6399d3f3de27'::uuid;

-- Sailor: HuanRan Lin (huanran-lin-hkrw-ed27a8)
UPDATE public.sailors SET club = 'CHENJINHAO RACE TEAM', updated_at = now() WHERE id = 'ed27a8d6-9c77-5e5f-87b2-c3914e99023b'::uuid;

-- Sailor: Jiayang Shi (jiayang-shi-hkrw-54ce23)
UPDATE public.sailors SET club = 'CHENJINHAO RACE TEAM', updated_at = now() WHERE id = '54ce23fa-22d1-55ea-9bb1-90f496d2ea54'::uuid;

-- Sailor: Xiaozhi Huang (xiaozhi-huang-hkrw-97dc41)
UPDATE public.sailors SET club = 'Guangzhou Nansha Sailing Association', updated_at = now() WHERE id = '97dc41b3-9bfa-5213-a59c-e468321e7a29'::uuid;

-- Sailor: Aixi Zhou (aixi-zhou-hkrw-f0f6d3)
UPDATE public.sailors SET club = 'Guangzhou Nansha Sailing Associatio', updated_at = now() WHERE id = 'f0f6d3b9-f41e-5707-9f17-8fed5e381174'::uuid;

-- Sailor: Kyle Chan (kyle-chan-hkrw-fb806d)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = 'fb806d83-4241-5f22-a488-d9bd0a65428f'::uuid;

-- Sailor: Alexandra Lau (alexandra-lau-hkrw-8f4042)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = '8f4042c2-649a-59cd-8908-482656567be5'::uuid;

-- Sailor: Chiu Wing Tsang (chiu-wing-tsang-hkrw-e150df)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = 'e150df37-ab4c-5fa0-9f56-d790ba9b0300'::uuid;

-- Sailor: Tsz Tung Hung (tsz-tung-hung-hkrw-2fbdfe)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '2fbdfe55-4680-5b4d-83c4-58337676baf3'::uuid;

-- Sailor: Chun Yuk Cheng (chun-yuk-cheng-hkrw-090fcf)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '090fcf6b-2ddf-5df3-b101-54d48d1afc7d'::uuid;

-- Sailor: Darryl Fok (darryl-fok-fl8z171)
UPDATE public.sailors SET nationality = 'HKG', updated_at = now() WHERE id = 'a081ac6d-9448-4270-8d93-05480f671b0f'::uuid;

-- Sailor: Hei Kiu Sophie Ng (hei-kiu-sophie-ng-hkrw-a6c0ad)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = 'a6c0ad09-d30c-556c-9b3f-5406fdfb400d'::uuid;

-- Sailor: Olive Pat (olive-pat-hkrw-b2406a)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = 'b2406ace-66f7-5758-8cbb-c2bc30683747'::uuid;

-- Sailor: Anya Lim (anya-lim-hkrw-2fcce3)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = '2fcce3d8-61f0-5947-9ca7-6ec7333ff142'::uuid;

-- Sailor: Matthias Leung (matthias-leung-hkrw-10551e)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '10551e9d-b8dc-5c75-a372-f5cdcaf7f6ba'::uuid;

-- Sailor: Eugene Chan (eugene-chan-hkrw-6d9718)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '6d97185c-839c-5836-81a7-7c973e54d9e2'::uuid;

-- Sailor: Sheldon Ling (sheldon-ling-hkrw-b0ccd6)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = 'b0ccd6ab-5541-5475-9f7a-2714c8fea4ad'::uuid;

-- Sailor: Augustine Mitchell (augustine-mitchell-hkrw-e311fe)
UPDATE public.sailors SET club = 'Aberdeen Boat Club', updated_at = now() WHERE id = 'e311fe62-14be-5c4a-b991-cbce9e4b13a9'::uuid;

-- Sailor: Caitlyn Kwong (caitlyn-kwong-hkrw-46e2cc)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '46e2cc9a-621e-508d-87ee-90ad5748d515'::uuid;

-- Sailor: Hau Yu Aurora Shek (hau-yu-aurora-shek-hkrw-535695)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '53569573-285a-55b7-96d6-bfcb221b331a'::uuid;

-- Sailor: Chang Kevin (chang-kevin-hkrw-236aa3)
UPDATE public.sailors SET club = 'VANHANG', updated_at = now() WHERE id = '236aa3ba-52da-537a-97c4-67974b080757'::uuid;

-- Sailor: Giorgos Mandilas (giorgos-mandilas-hkrw-1e9f48)
UPDATE public.sailors SET club = 'Piraeus sailing club', updated_at = now() WHERE id = '1e9f4851-0f76-5387-a69e-87d392e30335'::uuid;

-- Sailor: Loukas Silvestriadis (loukas-silvestriadis-hkrw-e78915)
UPDATE public.sailors SET club = 'Piraeus sailing club', updated_at = now() WHERE id = 'e78915f1-fe21-5ebc-8101-c255ce2dfbcf'::uuid;

-- Sailor: Xinyi Evelyn Lyu (xinyi-evelyn-lyu-hkrw-b57b8a)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = 'b57b8a25-1520-5612-936d-913d5b860db2'::uuid;

-- Sailor: Isaac Wang (isaac-wang-hkrw-4e4b62)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = '4e4b62c0-cedc-56aa-af56-4319aa348f68'::uuid;

-- Sailor: Xavier Lam (xavier-lam-hkrw-51deb9)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '51deb95b-c78a-5286-b715-0cc47634fd81'::uuid;

-- Sailor: Olivia Ellis (olivia-ellis-hkrw-163d29)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '163d2933-7169-530d-b023-7d39e365d55d'::uuid;

-- Sailor: Annabel Hazel Lam (annabel-hazel-lam-hkrw-e9ea9f)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = 'e9ea9f18-f2e9-500c-b736-79c25b545c55'::uuid;

-- Sailor: Karisse Hah (karisse-hah-hkrw-ea8115)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = 'ea811525-cc53-577b-8e59-1f1cba644792'::uuid;

-- Sailor: Elgin Chan (elgin-chan-hkrw-b0eaf9)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = 'b0eaf977-8ca6-524c-b6a4-856f4ba81ae5'::uuid;

-- Sailor: SiYu Huang (siyu-huang-hkrw-3fc0a4)
UPDATE public.sailors SET nationality = 'HKG', club = 'HHYC', updated_at = now() WHERE id = '3fc0a42c-a647-5fa0-858d-268f818f5ae2'::uuid;

-- Sailor: Xi Jie Gao (xi-jie-gao-hkrw-b12d41)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = 'b12d4159-c2fc-5c19-aaf1-e4f9eece221f'::uuid;

-- Sailor: Daniel Shan (daniel-shan-hkrw-115073)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = '115073fc-e588-5843-9cbd-99fcd5990874'::uuid;

-- Sailor: Roman Choi (roman-choi-hkrw-1a742c)
UPDATE public.sailors SET club = 'Hebe haven', updated_at = now() WHERE id = '1a742ce4-6e3a-5082-a59a-d45c0edd9396'::uuid;

-- Sailor: Alexis Landy (alexis-landy-hkrw-6a1c20)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '6a1c202e-1453-5b4a-8566-cb4a1b57fbf4'::uuid;

-- Sailor: Cheuk Yee Shen (cheuk-yee-shen-hkrw-8597ee)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '8597eef6-c8d2-5f74-825f-6f3697558d80'::uuid;

-- Sailor: Kar Lai Kelly Lam (kar-lai-kelly-lam-hkrw-3135e2)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '3135e21d-91df-583d-827a-80d284221734'::uuid;

-- Sailor: Mac Darlington (mac-darlington-hkoda26-7411c0)
UPDATE public.sailors SET nationality = 'AUS', updated_at = now() WHERE id = '7411c058-0e0a-5a5d-aa05-fb3bd9edc4aa'::uuid;

-- Sailor: Ching Jaymee Ip (ching-jaymee-ip-hkrw-7a9f67)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '7a9f67d5-fa2c-5961-ac2a-e14e377ae93a'::uuid;

-- Sailor: Keana Hah (keana-hah-hkrw-8388f8)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = '8388f8f9-1ce2-5ca7-b198-feff165118dc'::uuid;

-- Sailor: Pak Man Chan (ilca4-mac-pak-man-chan-205264)
UPDATE public.sailors SET club = 'Macau Sailing Association', updated_at = now() WHERE id = 'e9200fc3-e0d2-45f7-9e38-38c22d819b37'::uuid;

-- Sailor: Leanna Lee (leanna-lee-hkrw-bc65cc)
UPDATE public.sailors SET gender = 'F', club = 'RHKYC', updated_at = now() WHERE id = 'bc65ccb8-4c2f-5524-aa50-f350a82b9508'::uuid;

-- Sailor: Alex Hon (alex-hon-hkrw-765796)
UPDATE public.sailors SET gender = 'M', club = 'RHKYC', updated_at = now() WHERE id = '76579635-65b3-53b3-a2f6-a478f8965d49'::uuid;

-- Sailor: Jaythan Lee (jaythan-lee-hkrw-b0e69d)
UPDATE public.sailors SET gender = 'M', club = 'HKSF', updated_at = now() WHERE id = 'b0e69dac-7597-55e5-89a7-12d8d56e9d3a'::uuid;

-- Sailor: Ivy So (ilca4-hkg-ivy-so-209310)
UPDATE public.sailors SET gender = 'F', club = 'HKSI / HHYC', updated_at = now() WHERE id = '34454af4-f43d-45d4-aea1-01ff9c354cb9'::uuid;

-- Sailor: Penelope Wilde (penelope-wilde-hkrw-ba833d)
UPDATE public.sailors SET gender = 'F', club = 'RHKYC', updated_at = now() WHERE id = 'ba833ded-4802-5349-8bff-f61007f74c32'::uuid;

-- Sailor: Owen Ou (owen-ou-hkrw-4b6e6b)
UPDATE public.sailors SET gender = 'M', club = 'RHKYC', updated_at = now() WHERE id = '4b6e6b85-ad06-5f70-aba9-242c899d8c30'::uuid;

-- Sailor: Zirui Fan (ilca4-chn-zirui-fan-224401)
UPDATE public.sailors SET club = 'Nansha Sailing Association', updated_at = now() WHERE id = '0233ba1e-0ce6-465c-baf2-103c44fb198b'::uuid;

-- Sailor: CongGuo Huang (ilca4-chn-congguo-huang-225502)
UPDATE public.sailors SET club = 'CHENJINHAO RACE TEAM', updated_at = now() WHERE id = '5242c095-094d-4bbf-9823-86b1e9bce128'::uuid;

-- Sailor: Tianmu Timothy Lin (ilca4-hkg-tianmu-timothy-lin-209901)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '482571fc-5cfb-4a68-a6a7-1d6ad49d8cb5'::uuid;

-- Sailor: Rheanne Faye Buitre (ilca4-hkg-rheanne-faye-buitre-179862)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '9ea16ef7-b536-45f2-9239-c784dc637dc0'::uuid;

-- Sailor: Manchak Cheung (ilca4-hkg-manchak-cheung-190912)
UPDATE public.sailors SET gender = 'M', club = 'HHYC', updated_at = now() WHERE id = '83fc0396-575e-48e5-bb65-11d0cc4513a8'::uuid;

-- Sailor: Ela Murat (ilca4-hkg-ela-murat-205828)
UPDATE public.sailors SET gender = 'F', club = 'RHKYC', updated_at = now() WHERE id = 'ad6fa7a4-fafc-4dc8-8bd7-92fcb8e39a0d'::uuid;

-- Sailor: Ariel Li (ilca4-hkg-ariel-li-209947)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '4912218b-e98e-4161-a8b3-8e93dc501612'::uuid;

-- Sailor: Jake Wang (jake-wang-hkrw-15a31f)
UPDATE public.sailors SET gender = 'M', club = 'HHYC', updated_at = now() WHERE id = '15a31fb6-dfd1-5914-8ed5-e4249827894d'::uuid;

-- Sailor: Elaine Dong (ilca4-hkg-elaine-dong-211688)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d'::uuid;

-- Sailor: Eldrad Lee (ilca4-hkg-eldrad-lee-211691)
UPDATE public.sailors SET gender = 'M', club = 'RHKYC', updated_at = now() WHERE id = '24b12cb2-26fb-4c45-a181-ada739f0a7f7'::uuid;

-- Sailor: Thomas Ko (ilca4-hkg-thomas-ko-211709)
UPDATE public.sailors SET gender = 'M', club = 'HKSF', updated_at = now() WHERE id = 'c09d32dd-7749-4284-89a0-051aa3539ca3'::uuid;

-- Sailor: Alterf Kwong Ching Tse (alterf-kwong-ching-tse-hkrw-01a864)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '01a8647e-7ef2-5d66-bed8-50d74b224c1f'::uuid;

-- Sailor: Lap Him Cheung (ilca4-hkg-lap-him-cheung-211730)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '083feffe-17ec-4069-80cb-82d0733ffc64'::uuid;

-- Sailor: Chun Yin Yip (ilca4-hkg-chun-yin-yip-211740)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '6346e39b-3e5c-40c4-af25-95ce3a6dfd43'::uuid;

-- Sailor: Quentin Tran (ilca4-hkg-quentin-tran-213211)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = '619985df-50a1-4eb0-b68c-6dfcc8f3e9a5'::uuid;

-- Sailor: Dani Van Olphen (ilca4-hkg-dani-van-olphen-213234)
UPDATE public.sailors SET gender = 'M', club = 'RHKYC', updated_at = now() WHERE id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b'::uuid;

-- Sailor: Allan McDonald (ilca4-hkg-allan-mcdonald-213300)
UPDATE public.sailors SET gender = 'M', club = 'RHKYC', updated_at = now() WHERE id = '90be5de1-70f1-455b-8d51-b69637bb8f0c'::uuid;

-- Sailor: Ryley Man (ilca4-hkg-ryley-man-213329)
UPDATE public.sailors SET gender = 'M', club = 'RHKYC', updated_at = now() WHERE id = 'a88f1f81-4234-420e-aec3-9d530b783645'::uuid;

-- Sailor: Marcus Li (ilca4-hkg-marcus-li-213348)
UPDATE public.sailors SET gender = 'M', club = 'RHKYC', updated_at = now() WHERE id = '35ddaae9-11d3-457f-ba18-2c96e6df5aac'::uuid;

-- Sailor: Carine Leung (ilca4-hkg-carine-leung-215131)
UPDATE public.sailors SET gender = 'F', club = 'HHYC', updated_at = now() WHERE id = '8569264f-6410-4308-b9e2-222e3a1af748'::uuid;

-- Sailor: Gianna Ho (ilca4-hkg-gianna-ho-215141)
UPDATE public.sailors SET gender = 'F', club = 'HHYC', updated_at = now() WHERE id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'::uuid;

-- Sailor: Cyrus Yung (cyrus-yung-csc-history)
UPDATE public.sailors SET nationality = 'HKG', updated_at = now() WHERE id = '7e5f2a12-3deb-5004-b89f-bc0e35c98a4e'::uuid;

-- Sailor: Sophie Shao (ilca4-hkg-sophie-shao-215314)
UPDATE public.sailors SET gender = 'F', club = 'HHYC', updated_at = now() WHERE id = 'eaef4797-80e6-4c53-abc6-691cae49a19c'::uuid;

-- Sailor: Jarvis Wong (jarvis-wong-hkrw-da4dd4)
UPDATE public.sailors SET gender = 'M', club = 'RHKYC', updated_at = now() WHERE id = 'da4dd4ce-6510-59bb-9613-59f8ab461e47'::uuid;

-- Sailor: Jorge Wong (ilca4-hkg-jorge-wong-215482)
UPDATE public.sailors SET gender = 'M', club = 'RHKYC', updated_at = now() WHERE id = '38110f5a-aea4-45eb-90f8-3909e0445794'::uuid;

-- Sailor: Stephen Donahue (ilca4-hkg-stephen-donahue-215681)
UPDATE public.sailors SET gender = 'M', club = 'HHYC', updated_at = now() WHERE id = '02f7b4d9-0fc2-4a3f-b947-09027040ad0a'::uuid;

-- Sailor: Zixi Huang (ilca4-hkg-zixi-huang-221400)
UPDATE public.sailors SET gender = 'F', club = 'HKSI', updated_at = now() WHERE id = 'e3ea45d8-9cd9-4bd0-98dc-58aa3e8aaeb9'::uuid;

-- Sailor: Dorian Olivares (dorian-olivares-hkrw-308d3a)
UPDATE public.sailors SET gender = 'M', club = 'RHKYC', updated_at = now() WHERE id = '308d3a59-94d5-56f2-b955-1a04a78b9e0a'::uuid;

-- Sailor: Christian Sallons (ilca4-hkg-christian-sallons-228287)
UPDATE public.sailors SET gender = 'M', club = 'HHYC', updated_at = now() WHERE id = 'e50f37f1-f40f-475c-bba2-4956d020bbbe'::uuid;

-- Sailor: John Dwyer (ilca4-jpn-john-dwyer-184018)
UPDATE public.sailors SET club = 'N.A.', updated_at = now() WHERE id = 'bbc98c87-4365-4da5-880a-59a124e838ef'::uuid;

-- Sailor: Kai Storey (ilca4-hkg-kai-storey-187010)
UPDATE public.sailors SET gender = 'M', club = 'RHKYC', updated_at = now() WHERE id = '501d0faa-3edc-4c25-84c6-1681e7f36e48'::uuid;

-- Sailor: Charalampos Velianitis (ilca4-hkg-charalampos-velianitis-220790)
UPDATE public.sailors SET club = 'HKSI', updated_at = now() WHERE id = '1efbd4b8-343f-43e4-bcce-659e65a06e56'::uuid;

-- Sailor: Muxin Wang (muxin-wang-hkrw-f3e1fd)
UPDATE public.sailors SET club = 'Guangzhou Nansha Sailing Association', updated_at = now() WHERE id = 'f3e1fd14-b449-5bb5-9409-4328c7b16375'::uuid;

-- Sailor: Xiwen Zhang (xiwen-zhang-hkrw-4dc71b)
UPDATE public.sailors SET club = 'Guangzhou Nansha Sailing Association', updated_at = now() WHERE id = '4dc71bfe-2e70-5bc6-8ba8-d7b199d94f88'::uuid;

-- Sailor: Yunfan Tian (yunfan-tian-hkrw-8f5dca)
UPDATE public.sailors SET club = 'Guangzhou Nansha Sailing Association', updated_at = now() WHERE id = '8f5dca33-de56-51e2-bab4-82b3d1ae7841'::uuid;

-- Sailor: Anzhuo Li (anzhuo-li-hkrw-34736b)
UPDATE public.sailors SET club = 'Guangzhou Nansha Sailing Association', updated_at = now() WHERE id = '34736b3a-59c1-53b0-a814-ffd9371493df'::uuid;

-- Sailor: Jiawen Luo (jiawen-luo-hkrw-a95e0d)
UPDATE public.sailors SET club = 'Guangzhou Nansha Sailing Association', updated_at = now() WHERE id = 'a95e0db9-f885-55d2-a7fe-e768bf665d6a'::uuid;

-- Sailor: Hay Son So (hay-son-so-hkrw-486b65)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '486b65b5-c0da-50aa-8920-969b83289dbf'::uuid;

-- Sailor: Thibault Gregory (thibault-gregory-hkrw-2a66d1)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '2a66d1d6-9e31-55d8-9cd3-7e5ca7e20eed'::uuid;

-- Sailor: Dylan Wang (dylan-wang-hkrw-a2f74d)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = 'a2f74d7b-0f49-5426-80cd-557ad405695e'::uuid;

-- Sailor: Mia Disseldorp (mia-disseldorp-hkrw-bb70bd)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = 'bb70bd9d-cd61-50d8-9e30-d26028119ef7'::uuid;

-- Sailor: Wanyu Du (wanyu-du-hkrw-1c7a83)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = '1c7a837f-394f-5876-86db-6166cdd3a384'::uuid;

-- Sailor: Jared Fok (jared-fok-hkrw-142fcc)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = '142fccf6-13bf-5b90-a325-87a9fcaa0079'::uuid;

-- Sailor: Luca Chan (luca-chan-hkrw-608c0f)
UPDATE public.sailors SET club = 'Sailability', updated_at = now() WHERE id = '608c0f60-3d0f-51b4-8a87-5adf4b88254d'::uuid;

-- Sailor: Shing Pok Anton Yuen (shing-pok-anton-yuen-hkrw-f715f8)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = 'f715f88e-6e67-5667-b1ec-6c0c36762847'::uuid;

-- Sailor: Amber Lin (amber-lin-hkrw-66c852)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '66c8521e-c7f1-5709-9107-2d5929eb5bc4'::uuid;

-- Sailor: Kavi Vaid (kavi-vaid-hkrw-fa00d3)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = 'fa00d344-de50-5390-9289-015883f836f7'::uuid;

-- Sailor: Callum Finnie (callum-finnie-hkrw-833eee)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = '833eeef9-8140-5cf6-b3f2-b9618be3fb21'::uuid;

-- Sailor: Arvhela Cabusay (arvhela-cabusay-hkrw-4bf1a7)
UPDATE public.sailors SET club = 'Sailability', updated_at = now() WHERE id = '4bf1a783-2d81-5ac4-ab90-56e732693b24'::uuid;

-- Sailor: Ethan J. Lee (ethan-j-lee-hkrw-e8cc76)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = 'e8cc76e2-880f-595f-9e9a-5d982e5c5787'::uuid;

-- Sailor: Ayesha Delizo (ayesha-delizo-hkrw-1a7a24)
UPDATE public.sailors SET club = 'Sailability', updated_at = now() WHERE id = '1a7a24ba-1140-557f-944d-b379c3caddcc'::uuid;

-- Sailor: Evaristo Trevino (evaristo-trevino-hkrw-1367d6)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '1367d689-3e51-5949-a767-a64759e3422a'::uuid;

-- Sailor: Luke Prestoza (luke-prestoza-hkrw-042335)
UPDATE public.sailors SET club = 'Sailability', updated_at = now() WHERE id = '04233543-b83e-54ac-ba11-6c495c9c8968'::uuid;

-- Sailor: Lauren Lee (lauren-lee-hkrw-bf749d)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = 'bf749db6-f544-5456-9e58-1573f2777f41'::uuid;

-- Sailor: Jean Uberti (jean-uberti-hkrw-ad1a1b)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = 'ad1a1b68-0206-5e1b-8ee7-e1f0672707c9'::uuid;

-- Sailor: Charles Chiu (charles-chiu-hkrw-9ace01)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = '9ace01e7-dd29-59a6-8583-2f5b8170899d'::uuid;

-- Sailor: Yinzhe Asher Zhao (yinzhe-asher-zhao-hkrw-c5f152)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = 'c5f15236-2363-5253-b736-dbebd5240b1e'::uuid;

-- Sailor: Damiano Grillo (damiano-grillo-hkrw-22365e)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = '22365eed-c5b8-5012-a5fe-e5ad3cb3ebe1'::uuid;

-- Sailor: Vera Dwyer (vera-dwyer-hkrw-e4bf69)
UPDATE public.sailors SET club = 'N.A.', updated_at = now() WHERE id = 'e4bf690c-ad3f-5452-b4d0-d729e93885f5'::uuid;

-- Sailor: Fang Lika (fang-lika-hkrw-1505b6)
UPDATE public.sailors SET club = 'Ceylon MOTOR Yacht CLUB', updated_at = now() WHERE id = '1505b60e-5f7f-574e-919c-0ea5b466a803'::uuid;

-- Sailor: Yufan He (yufan-he-hkrw-607e49)
UPDATE public.sailors SET club = 'Ceylon Motor Yacht Club', updated_at = now() WHERE id = '607e494f-7764-5a65-9dbb-200b9077e396'::uuid;

-- Sailor: Mia Kunigk (mia-kunigk-hkrw-c83082)
UPDATE public.sailors SET club = 'Ceylon Motor Yacht Club', updated_at = now() WHERE id = 'c8308239-7af1-5c7a-9b52-3c77b38dfe07'::uuid;

-- Sailor: Noa Ratnayake (noa-ratnayake-hkrw-5271d0)
UPDATE public.sailors SET club = 'Ceylon motor yacht club', updated_at = now() WHERE id = '5271d085-dfd5-5b40-8fac-84e5011da3ce'::uuid;

-- Sailor: Saveen Samarasekera (saveen-samarasekera-hkrw-e0b9e7)
UPDATE public.sailors SET club = 'Ceylon Motor Yacht Club', updated_at = now() WHERE id = 'e0b9e7d8-5b95-5c80-93e8-8da648c9020d'::uuid;

-- Sailor: Leo Wickremasinghe (leo-wickremasinghe-hkrw-467367)
UPDATE public.sailors SET club = 'Ceylon Motor Yacht Club', updated_at = now() WHERE id = '46736725-53d4-5a66-9d06-0cadfe0b1e9b'::uuid;

-- Sailor: Bohan Zhang (bohan-zhang-hkrw-352182)
UPDATE public.sailors SET club = 'VANHANG', updated_at = now() WHERE id = '352182df-0671-5a45-a1b5-1196429bcb59'::uuid;

-- Sailor: Pengyu Luo (pengyu-luo-hkrw-d7ba85)
UPDATE public.sailors SET club = 'Blue Water', updated_at = now() WHERE id = 'd7ba85f7-d391-5e38-aec9-c7dd4dbe8998'::uuid;

-- Sailor: Law Hoi Kiu (law-hoi-kiu-hkrw-7e1fa4)
UPDATE public.sailors SET nationality = 'HKG', club = 'HKSF', updated_at = now() WHERE id = '7e1fa411-53db-5cf5-9bc0-9070aa726e88'::uuid;

-- Sailor: Hu YiYu (hu-yiyu-hkrw-5164c7)
UPDATE public.sailors SET club = 'VANHANG', updated_at = now() WHERE id = '5164c7d9-e7c7-543c-83d4-9300ee6fff0e'::uuid;

-- Sailor: Grace Guo (grace-guo-hkrw-e908a7)
UPDATE public.sailors SET club = 'CHENJINHAO RACE TEAM', updated_at = now() WHERE id = 'e908a75f-696d-506e-a09e-59943fffbda6'::uuid;

-- Sailor: Sophie Mitchell (sophie-mitchell-hkrw-e7e403)
UPDATE public.sailors SET club = 'Aberdeen Boat Club', updated_at = now() WHERE id = 'e7e403df-97d5-5e51-b64c-3133ecca19e0'::uuid;

-- Sailor: Charles Ciemniak (charles-ciemniak-hkrw-9ce77b)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = '9ce77b03-0128-572f-8357-4a7e935b2ff6'::uuid;

-- Sailor: Loan Ethan Schuhmann (loan-ethan-schuhmann-hkrw-768c2a)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '768c2aea-84f8-5675-890b-b00e66dc7d59'::uuid;

-- Sailor: Aidon Xiong (aidon-xiong-fck0fyr)
UPDATE public.sailors SET nationality = 'HKG', updated_at = now() WHERE id = '3b4f7056-4c2e-4f40-a38c-17cbae6fe682'::uuid;

-- Sailor: Jaime Rouget (jaime-rouget-hkrw-318a7f)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '318a7f01-325d-56b2-a1a0-b8153d19949c'::uuid;

-- Sailor: Cleo Badenach (cleo-badenach-fenbpez)
UPDATE public.sailors SET nationality = 'HKG', updated_at = now() WHERE id = 'ea64eb68-1514-4725-b361-d00c7c397d4d'::uuid;

-- Sailor: Sirui Huang (sirui-huang-hkrw-2d1c8b)
UPDATE public.sailors SET nationality = 'HKG', club = 'HHYC', updated_at = now() WHERE id = '2d1c8bed-36a9-5332-8cd4-89f0b6657f28'::uuid;

-- Sailor: Enoch Chau (enoch-chau-hkrw-965f4c)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '965f4c1a-c663-5ea4-a552-2d4b5c21ab3e'::uuid;

-- Sailor: Hantao Zhou (hantao-zhou-hkrw-1786db)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '1786db56-c0d4-591a-abbe-ca84f336058c'::uuid;

-- Sailor: Eva Murat (eva-murat-hkrw-b434b9)
UPDATE public.sailors SET nationality = 'HKG', club = 'RHKYC', updated_at = now() WHERE id = 'b434b981-9f3a-514a-974c-fbf63700fd1b'::uuid;

-- Sailor: Ines Mendez Larminaux (ines-mendez-larminaux-hkrw-80c3e8)
UPDATE public.sailors SET club = 'Club Nautico de San Juan', updated_at = now() WHERE id = '80c3e84a-7555-5a32-8585-33bcc74382d8'::uuid;

-- Sailor: Qiheng Zhang (qiheng-zhang-hkrw-d105a5)
UPDATE public.sailors SET club = 'CHENJINHAO RACE TEAM', updated_at = now() WHERE id = 'd105a59c-028f-5fcc-a467-214a68c67f96'::uuid;

-- Sailor: Joshua Alan Wong (joshua-alan-wong-hkrw-55e703)
UPDATE public.sailors SET club = 'CHENJINHAO RACE TEAM', updated_at = now() WHERE id = '55e7035e-be54-5bb4-afa7-6cf9eb9d425d'::uuid;

-- Sailor: Ho Yeung Chiu (ho-yeung-chiu-hkrw-f752c4)
UPDATE public.sailors SET club = 'HKSSA', updated_at = now() WHERE id = 'f752c4e2-f7de-579c-9189-7be2f28eb3c7'::uuid;

-- Sailor: Xuanxi Xiang (xuanxi-xiang-hkrw-6f2247)
UPDATE public.sailors SET club = '风之曲帆船俱乐部 whisper of the wind sailing club', updated_at = now() WHERE id = '6f224782-aa68-5b38-9054-b4b366fc466a'::uuid;

-- Sailor: Lilly Charlotte Grimm (lilly-charlotte-grimm-hkrw-c06dd4)
UPDATE public.sailors SET club = 'Aberdeen Boat Club', updated_at = now() WHERE id = 'c06dd4f6-50ce-5a17-81db-e9aff5d5c82c'::uuid;

-- Sailor: Tsing Fai Hui (tsing-fai-hui-hkrw-6a6167)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '6a6167e5-8b9e-5992-b8a3-12508a79a903'::uuid;

-- Sailor: HaoRan Lei (haoran-lei-hkrw-16606e)
UPDATE public.sailors SET club = 'CHENJINHAO RACE TEAM', updated_at = now() WHERE id = '16606e8d-81d2-59a3-8f17-4dc083f628c5'::uuid;

-- Sailor: NianNian Si (niannian-si-hkrw-def8ec)
UPDATE public.sailors SET club = 'CHENJINHAO RACE TEAM', updated_at = now() WHERE id = 'def8ecd0-3148-5767-ad54-44de05ef12c9'::uuid;

-- Sailor: YaoDe Tong (yaode-tong-hkrw-9ad447)
UPDATE public.sailors SET club = 'Mingiude Sailing', updated_at = now() WHERE id = '9ad4478a-40e3-57b7-a7ea-eb591ad90726'::uuid;

-- Sailor: Zeren Xiong (zeren-xiong-hkrw-ffaacf)
UPDATE public.sailors SET club = '风之曲帆船俱乐部 whisper of the wind sailing club', updated_at = now() WHERE id = 'ffaacf08-cae5-533c-b8d6-040e168d92d6'::uuid;

-- Sailor: Erica Paulino (erica-paulino-hkrw-db261d)
UPDATE public.sailors SET club = 'Marianas Yacht Club', updated_at = now() WHERE id = 'db261d47-29a7-51bc-b76a-82a70f2c1ec2'::uuid;

-- Sailor: Leroy Norman (leroy-norman-hkrw-edd6ca)
UPDATE public.sailors SET club = 'Marianas Yacht Club', updated_at = now() WHERE id = 'edd6ca55-456d-57d3-b968-f24a779f7a4e'::uuid;

-- Sailor: Joaquin Cassidy (joaquin-cassidy-hkrw-df13ce)
UPDATE public.sailors SET club = 'Marianas Yacht Club', updated_at = now() WHERE id = 'df13ce15-3469-532c-8f00-915483582da3'::uuid;

-- Sailor: Sofie Marlene Grimm (sofie-marlene-grimm-hkrw-2d90b7)
UPDATE public.sailors SET club = 'Aberdeen Boat Club', updated_at = now() WHERE id = '2d90b76e-cf0b-560d-bb62-dbe94ad5fcdc'::uuid;

-- Sailor: Alice Cheung (alice-cheung-hkrw-f0d720)
UPDATE public.sailors SET club = 'ABC', updated_at = now() WHERE id = 'f0d72073-97cc-57e7-81b7-79b4dafa8092'::uuid;

-- Sailor: Miu Sze Gianna Ho (miu-sze-gianna-ho-hkrw-debd86)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = 'debd8691-a8de-5454-99de-0aa7274765ae'::uuid;

-- Sailor: ChenHao Li (chenhao-li-hkrw-1607f0)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '1607f0b2-6f21-5553-b2ef-3707e71c4189'::uuid;

-- Sailor: BingJie Yan (bingjie-yan-hkrw-58fb91)
UPDATE public.sailors SET club = 'CHENJINHAO RACE TEAM', updated_at = now() WHERE id = '58fb912f-79c6-5649-8b60-27ac74b3f452'::uuid;

-- Sailor: Valentina Trevino (valentina-trevino-fdy9a7x)
UPDATE public.sailors SET nationality = 'HKG', updated_at = now() WHERE id = '2d6309fb-f9af-4777-913d-f9dda49aaf76'::uuid;

-- Sailor: Ka Wai Chloe Wan (ka-wai-chloe-wan-hkrw-564044)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = '56404476-ad63-55b6-84ab-5605f806f80f'::uuid;

-- Sailor: Jason Lin (ilca4-chn-jason-lin-210325)
UPDATE public.sailors SET club = 'Vanhang', updated_at = now() WHERE id = '79dc7d49-7373-44e4-9d0d-b3be10d33eca'::uuid;

-- Sailor: Yufei Chen (ilca4-chn-yufei-chen-210816)
UPDATE public.sailors SET club = 'Meisha Yuanhang', updated_at = now() WHERE id = 'bd3f9394-9eb2-47c0-8c60-2b5cc89359fd'::uuid;

-- Sailor: Yuxuan Liu (ilca4-chn-yuxuan-liu-211722)
UPDATE public.sailors SET club = 'BlueWater', updated_at = now() WHERE id = 'fe1f0a00-1e15-4ad0-b83d-05ec5d33dac2'::uuid;

-- Sailor: Qinghua Hu (ilca4-chn-qinghua-hu-214467)
UPDATE public.sailors SET club = 'Beijing Sailing Center', updated_at = now() WHERE id = '03beb519-c2a4-45e7-a7a1-faf0d1cc0879'::uuid;

-- Sailor: Che Liu (ilca4-chn-che-liu-216831)
UPDATE public.sailors SET club = 'Vanhang', updated_at = now() WHERE id = 'b7214229-e97e-4c39-b342-cc4e99ff0623'::uuid;

-- Sailor: Yifan Han (ilca4-chn-yifan-han-221313)
UPDATE public.sailors SET club = '风之曲帆船俱乐部 whisper of the wind sailing club', updated_at = now() WHERE id = 'd9f834ff-3f39-474c-9dec-9ece78412ae3'::uuid;

-- Sailor: Wang Nina (ilca4-chn-wang-nina-221551)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19'::uuid;

-- Sailor: Xu Xiaorong (ilca4-chn-xu-xiaorong-221877)
UPDATE public.sailors SET club = '大连芸衫 Dalian Yunshan', updated_at = now() WHERE id = 'c261ebe9-0054-4de8-ad6f-31899871703f'::uuid;

-- Sailor: Guo Chen (ilca4-chn-guo-chen-229200)
UPDATE public.sailors SET club = '风之曲帆船俱乐部 whisper of the wind sailing club', updated_at = now() WHERE id = '019f574a-b21f-4e03-9b4d-d7a1a156ee82'::uuid;

-- Sailor: Jin Song Zhang (ilca4-chn-jin-song-zhang-223600)
UPDATE public.sailors SET club = 'HaiNan Jin Zhou Sailing Club', updated_at = now() WHERE id = 'c7e11466-03d9-4c45-a8b2-81e080c543f9'::uuid;

-- Sailor: Boxuan Yu (ilca4-chn-boxuan-yu-223620)
UPDATE public.sailors SET club = 'RHKYC ww', updated_at = now() WHERE id = '3590c7e0-16bf-4193-973e-2d94d3a9e37d'::uuid;

-- Sailor: Zhuowen Sophie Shao (ilca4-hkg-zhuowen-sophie-shao-191718)
UPDATE public.sailors SET club = 'HHYC', updated_at = now() WHERE id = '51c49278-d004-470a-9cc5-4ca495ae17b7'::uuid;

-- Sailor: Yilin Elaine Dong (ilca4-hkg-yilin-elaine-dong-211688)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'::uuid;

-- Sailor: Yeuk Tung Heather Fang (ilca4-hkg-yeuk-tung-heather-fang-211727)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = 'eafea6c2-35f1-4c22-8cb4-3a2adcbf92b2'::uuid;

-- Sailor: Sai Kit Tse (ilca4-hkg-sai-kit-tse-211740)
UPDATE public.sailors SET club = 'HKSF', updated_at = now() WHERE id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'::uuid;

-- Sailor: Cyrus Chan (ilca4-hkg-cyrus-chan-213329)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = 'dcdb7b45-c237-42d9-bef9-51bca1aff5bc'::uuid;

-- Sailor: Yong Liang Chuang (ilca4-tpe-yong-liang-chuang-221094)
UPDATE public.sailors SET club = 'RVYC', updated_at = now() WHERE id = '6bb8044b-6e37-4e15-84d2-605f5fecb2b7'::uuid;

-- Sailor: Ruixi Liu (ruixi-liu-hkrw-4395f7)
UPDATE public.sailors SET club = 'Blue Water', updated_at = now() WHERE id = '4395f7bf-333b-5ca6-b22e-45ae91f70b1b'::uuid;

-- Sailor: HoYeung Choi (hoyeung-choi-hkrw-a769a4)
UPDATE public.sailors SET club = 'Blue Water', updated_at = now() WHERE id = 'a769a428-3ad9-5d27-b594-ef5d580f24f3'::uuid;

-- Sailor: Mingze Wang (mingze-wang-hkrw-9f994d)
UPDATE public.sailors SET club = 'Blue water', updated_at = now() WHERE id = '9f994dde-3f36-5148-b5ae-55640a3eebbb'::uuid;

-- Sailor: Penghao Ni (penghao-ni-hkrw-8116df)
UPDATE public.sailors SET club = 'Tsinglan School', updated_at = now() WHERE id = '8116df29-ab28-569c-a1b4-6e47371948a1'::uuid;

-- Sailor: Tim Yik Chen (tim-yik-chen-hkrw-a996ca)
UPDATE public.sailors SET club = 'Tsinglan School', updated_at = now() WHERE id = 'a996ca4b-2cff-54a5-a2d6-154e3a12ac70'::uuid;

-- Sailor: Boyuan Deng (boyuan-deng-hkrw-3f007b)
UPDATE public.sailors SET club = 'Tsinglan School', updated_at = now() WHERE id = '3f007b71-3652-5150-816f-c096f9f4be13'::uuid;

-- Sailor: YueYuan Liu (yueyuan-liu-hkrw-c34851)
UPDATE public.sailors SET club = 'CHENJINHAO RACE TEAM', updated_at = now() WHERE id = 'c3485118-e337-551b-a472-ddb347048352'::uuid;

-- Sailor: Yikang Han (yikang-han-hkrw-25139a)
UPDATE public.sailors SET club = '风之曲帆船俱乐部 whisper of the wind sailing club', updated_at = now() WHERE id = '25139a97-2ba9-580e-abb8-aeab30945265'::uuid;

-- Sailor: Yundi Changhu (yundi-changhu-hkrw-5bd73a)
UPDATE public.sailors SET club = '风之曲帆船俱乐部 Whisper of the wind sailing club', updated_at = now() WHERE id = '5bd73acf-682a-5866-8269-1573add4d1ee'::uuid;

-- Sailor: Yang Meng (yang-meng-hkrw-c7a2f7)
UPDATE public.sailors SET club = '风之曲帆船俱乐部 whisper of the wind sailing club', updated_at = now() WHERE id = 'c7a2f767-ff62-59fc-871a-7d4bea39f6e0'::uuid;

-- Sailor: Anna van Kempen (anna-van-kempen-hkrw-4d95bb)
UPDATE public.sailors SET club = 'RHKYC', updated_at = now() WHERE id = '4d95bb93-4389-5226-b340-75c59cc54aee'::uuid;

-- Sailor: Alexander G. H. Howard (alexander-g-h-howard-hkrw-028cfb)
UPDATE public.sailors SET club = 'DEA Sailing Association', updated_at = now() WHERE id = '028cfbd7-aedc-53dd-905c-b36af72487cb'::uuid;

-- Sailor: Wong Tsun Hei (wong-tsun-hei-hkrw-ea3edb)
UPDATE public.sailors SET club = 'HKSS', updated_at = now() WHERE id = 'ea3edbac-9e68-5949-9425-59ac67ee9ced'::uuid;

-- Sailor: Tai Pui Wang (tai-pui-wang-hkrw-6ee78c)
UPDATE public.sailors SET club = 'HKSS', updated_at = now() WHERE id = '6ee78cd2-6d7f-5b21-b851-dc069da302c4'::uuid;

-- Sailor: Cheung Anson (cheung-anson-hkrw-120808)
UPDATE public.sailors SET club = 'HKSS', updated_at = now() WHERE id = '120808f7-9238-55dc-be7c-aef3e516a98c'::uuid;

-- Sailor: Sum Ho (sum-ho-hkrw-a41c93)
UPDATE public.sailors SET club = 'HKSS', updated_at = now() WHERE id = 'a41c9330-fcf4-5b8d-ab62-c6fa375e4e15'::uuid;

-- Sailor: Yutian Chen (yutian-chen-hkrw-97dee4)
UPDATE public.sailors SET club = '美帆 - Miho', updated_at = now() WHERE id = '97dee4a6-a3be-5585-9cb4-eb312aaa58f1'::uuid;

-- Sailor: Minghan Wang (minghan-wang-hkrw-933ba5)
UPDATE public.sailors SET club = 'Blue Water', updated_at = now() WHERE id = '933ba515-355b-5b6c-9578-71478df0694a'::uuid;

-- Sailor: Weijin Wang (weijin-wang-hkrw-c9f08b)
UPDATE public.sailors SET club = '风之曲帆船俱乐部 Whisper of the wind sailing club', updated_at = now() WHERE id = 'c9f08b7f-d3d6-5595-9131-df1cde0ddd1c'::uuid;

-- Sailor: Jiahui Shen (jiahui-shen-hkrw-519dad)
UPDATE public.sailors SET club = '风之曲帆船俱乐部 whisper of the wind sailing club', updated_at = now() WHERE id = '519dad8a-0098-588a-9f45-1577e7251619'::uuid;

-- Sailor: Yoshi Tsang (yoshi-tsang-hkrw-fd8c48)
UPDATE public.sailors SET club = 'HKSS', updated_at = now() WHERE id = 'fd8c4847-0ad7-5798-a4cf-907f1e7a5c63'::uuid;

-- Sailor: Yip Cheng Wang (yip-cheng-wang-hkrw-130e7f)
UPDATE public.sailors SET club = 'HKSS', updated_at = now() WHERE id = '130e7f80-3859-5da5-9a8f-69fa0370b5b8'::uuid;

-- Sailor: Law Park Kiu Kazaf (law-park-kiu-kazaf-hkrw-618be3)
UPDATE public.sailors SET club = 'HKSS', updated_at = now() WHERE id = '618be375-0f62-5f76-8758-9333b9eab2a7'::uuid;

-- Sailor: Zhongling Qi (zhongling-qi-hkrw-4220cb)
UPDATE public.sailors SET club = '风之曲帆船俱乐部 whisper of the wind sailing club', updated_at = now() WHERE id = '4220cbc3-f523-5575-8abd-00610c01c3c3'::uuid;

-- Sailor: Agis Angelopoulos (agis-angelopoulos-hkrw-9b7d1b)
UPDATE public.sailors SET club = 'Piraeus sailing Club', updated_at = now() WHERE id = '9b7d1b3a-b8b5-5a6a-b831-e1a33e55f68d'::uuid;

-- Sailor: Paris Kolokotronis (paris-kolokotronis-hkrw-265bf7)
UPDATE public.sailors SET club = 'Piraeus sailing club', updated_at = now() WHERE id = '265bf7c3-bd8e-5be2-8cb3-9a21cd69488d'::uuid;

-- Sailor: Raya Mithi Samson (raya-mithi-samson-fhfns7s)
UPDATE public.sailors SET gender = 'F', nationality = 'PHI', updated_at = now() WHERE id = 'f51d67a0-2e8c-47eb-9f01-74144117e993'::uuid;

-- Sailor: Chi-Fang Huang (ilca4-tpe-chi-fang-huang-220975)
UPDATE public.sailors SET gender = 'F', club = 'KSAF', updated_at = now() WHERE id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694'::uuid;

-- Sailor: Yan-Yun Wang (ilca4-tpe-yan-yun-wang-221514)
UPDATE public.sailors SET gender = 'F', club = 'Penghu SA', updated_at = now() WHERE id = 'bc7c7145-2943-4798-8eac-f9fc3c664d84'::uuid;

-- Sailor: Ai-Mei Lien (ilca4-tpe-ai-mei-lien-224990)
UPDATE public.sailors SET gender = 'F', club = 'Yilan SA', updated_at = now() WHERE id = 'fbe35ec3-7641-4c10-a598-747e60b46a14'::uuid;

-- Sailor: Lyora Hong-yi Wallier (ilca4-hkg-lyora-hong-yi-wallier-213316)
UPDATE public.sailors SET gender = 'F', club = 'Royal Hong Kong Yacht Club', updated_at = now() WHERE id = 'c12e846f-6188-40f5-adab-89e8522999cf'::uuid;

-- Sailor: Yu-Kai Chen (ilca4-tpe-yu-kai-chen-222236)
UPDATE public.sailors SET gender = 'M', club = 'Penghu SA', updated_at = now() WHERE id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da'::uuid;

-- Sailor: Ji Un Choi (ilca4-kor-ji-un-choi-223205)
UPDATE public.sailors SET gender = 'M', club = 'Busan Sailing Federation', updated_at = now() WHERE id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953'::uuid;

-- Sailor: Songha Lee (ilca4-kor-songha-lee-223204)
UPDATE public.sailors SET gender = 'M', club = 'Busan Sailing Federation', updated_at = now() WHERE id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'::uuid;

-- Sailor: Yong-Fen Yang (ilca4-tpe-yong-fen-yang-225799)
UPDATE public.sailors SET gender = 'M', club = 'KSAF', updated_at = now() WHERE id = '6e1c5516-938f-44fa-9898-f997676aa998'::uuid;

-- Sailor: Yen-Chen Wang (ilca4-tpe-yen-chen-wang-163120)
UPDATE public.sailors SET gender = 'M', club = 'Penghu SA', updated_at = now() WHERE id = 'b393c33b-604a-44a2-a38f-8007c7c7864c'::uuid;

-- Sailor: Thomas Yong Jin Ko (ilca4-hkg-thomas-yong-jin-ko-211709)
UPDATE public.sailors SET gender = 'M', club = 'Royal Hong Kong Yacht Club', updated_at = now() WHERE id = '298e864e-f79f-4e91-9caf-4a8c980f9282'::uuid;

-- Sailor: En-Rui Hsu (ilca4-tpe-en-rui-hsu-208532)
UPDATE public.sailors SET gender = 'M', club = 'Penghu SA', updated_at = now() WHERE id = '70371bac-6222-4625-8df8-296f67f622dc'::uuid;

-- Sailor: Tzu-Ho Liu (ilca4-tpe-tzu-ho-liu-217714)
UPDATE public.sailors SET gender = 'M', club = 'Penghu SA', updated_at = now() WHERE id = 'f661a603-313b-472f-a363-9d58914e04c0'::uuid;

-- Sailor: Cyun-Yan Tai (ilca4-tpe-cyun-yan-tai-210623)
UPDATE public.sailors SET gender = 'M', club = 'Yilan SA', updated_at = now() WHERE id = '1e809bd2-f00a-4c45-84e2-94e7ffc3215b'::uuid;

-- Sailor: Chen-Yang Yeh (ilca4-tpe-chen-yang-yeh-214553)
UPDATE public.sailors SET gender = 'M', club = 'Penghu SA', updated_at = now() WHERE id = '5a75e565-4a2a-4237-b167-34acf3240927'::uuid;

-- Sailor: Yu-Hsiang Huang (ilca4-tpe-yu-hsiang-huang-225165)
UPDATE public.sailors SET gender = 'M', club = 'Penghu SA', updated_at = now() WHERE id = '935c9e05-db8b-4d9c-9a5b-960d2e7d5c53'::uuid;

-- Sailor: Chi-Hsi Lin (ilca4-tpe-chi-hsi-lin-203017)
UPDATE public.sailors SET gender = 'M', club = 'Penghu SA', updated_at = now() WHERE id = 'd9fae5c5-d3db-400e-9896-d2d00d7d8d83'::uuid;

-- Sailor: Hao-Ran Hsu (ilca4-tpe-hao-ran-hsu-211323)
UPDATE public.sailors SET gender = 'M', club = 'Penghu SA', updated_at = now() WHERE id = '6ed1c6b7-6a64-4ce5-9565-ddedf27b12a5'::uuid;

-- Sailor: Ming-Shuo Chang (ilca4-tpe-ming-shuo-chang-203012)
UPDATE public.sailors SET gender = 'M', club = 'Penghu SA', updated_at = now() WHERE id = '4938635b-ea3b-4028-a516-4c1d48a4e7a5'::uuid;

-- Sailor: Ren Jiachen Katharine (ren-jiachen-katharine-uj2d2hs)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'eb8956c1-c9cf-4a4c-999a-56cf11ffece9'::uuid;

-- Sailor: Radha Srihari (radha-srihari-6onfesd)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '000ae501-452f-48de-887a-24c340b7dac6'::uuid;

-- Sailor: Mohamed Hamzah Bin Mohamed Faisal (mohamed-hamzah-bin-mohamed-faisal-uidku0q)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'c074dc19-ca89-472d-b5f2-ca5b7cbfe4b5'::uuid;

-- Sailor: D Mohamed Noordeen Bin Jaffar Sa (d-mohamed-noordeen-bin-jaffar-sa-40o96fi)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '78875c6b-f9df-4085-80b9-90da3bb13155'::uuid;

-- Sailor: Jayson Jin Cheng Yap (jayson-jin-cheng-yap-gu7pinz)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '37d27aa0-d266-43bf-a8bb-96e1dbe6bac6'::uuid;

-- Sailor: Alexander Choynowski de Lubicz (alexander-choynowski-de-lubicz-3r0v7in)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '5ab75ea3-80f2-4efe-87ff-263d95157501'::uuid;

-- Sailor: Josef Beucke Moe (josef-beucke-moe-cehli2g)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '1aa4ff39-e865-4aae-9292-f05c6b85be15'::uuid;

-- Sailor: Conrad Loh Yong (conrad-loh-yong-g1j18u6)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'ed139811-7d1e-41c7-8b24-b069c80d0db4'::uuid;

-- Sailor: Seth Low Yu Herng (seth-low-yu-herng)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '1fffd15a-65eb-4fd7-86af-d0f99cbcf2fa'::uuid;

-- Sailor: Sven Ng (sven-ng-g0ujdrd)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'e4724ce0-227e-4f1c-8b0f-b97af43d9075'::uuid;

-- Sailor: Lau Yhi Sun (lau-yhi-sun-ohcge0f)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '7f956a1d-8b92-494d-968e-ae66577d4e9d'::uuid;

-- Sailor: Phukawin Panakul (phukawin-panakul-egtag56)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '6431e70d-71de-463a-8af3-3670d12883c4'::uuid;

-- Sailor: Chawanwit Khamkhum (chawanwit-khamkhum-9gilzbs)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '4de72f9e-c98e-4e22-a160-9224e9ffab77'::uuid;

-- Sailor: Kittaya Deejumnain (kittaya-deejumnain-g0js0ad)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '72e06e42-95e4-4057-92fd-da8d3d2fa70a'::uuid;

-- Sailor: Anuchavasunish (anuchavasunish-wujiq75)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '758c7da3-144e-4098-8158-4635d097d8dc'::uuid;

-- Sailor: Benjamin Mongkorn (benjamin-mongkorn-7mhzn09)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '7f57af6b-ca64-401d-b836-f0d02e974897'::uuid;

-- Sailor: Thararat Pangkaew (thararat-pangkaew-deyrfah)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'bc726439-eb36-43a5-8b51-370ada783051'::uuid;

-- Sailor: Chan Wye Chyn Kelly Junior (historical-2024-sg-foil-grand-prix-windfoil-2024-1ac1b101b11b)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '0505c56b-135a-4ef0-8962-0186f89e148c'::uuid;

-- Sailor: Elkan Oh (historical-2024-sg-foil-grand-prix-windfoil-2024-f3ba95afc0ba)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'dbe45d3e-6640-4242-b347-f8ce6030a26c'::uuid;

-- Sailor: Marsha Shahrin (historical-2024-sg-foil-grand-prix-windfoil-2024-c696c43ae863)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '80419c1d-1ffc-4e6b-9c75-d94a7516df6b'::uuid;

-- Sailor: Jerroll Lo (historical-2024-national-slalom-windsurfing-2024-849df11b2069)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '1ce0df8d-1011-49b5-a628-6e77fb508918'::uuid;

-- Sailor: Chris Newman (historical-2024-national-slalom-windsurfing-2024-31b283893bd5)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '7b45b76c-075f-4be8-b298-e32f98915016'::uuid;

-- Sailor: Tan Wearn Haw (historical-2024-national-slalom-windsurfing-2024-da47039cccfb)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '4657a5d7-770c-456a-a381-4fb261c5e6e8'::uuid;

-- Sailor: Joon Chyi Huey (historical-2024-national-slalom-windsurfing-2024-8f7cfe4fe353)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = 'd4fc4a34-126d-452c-8020-97af1bd81daa'::uuid;

-- Sailor: Chan Hian Gee (historical-2024-national-slalom-windsurfing-2024-3d2333615bb6)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = 'ef2c3548-58ab-453c-9f32-0cc515703bb0'::uuid;

-- Sailor: Bernard Ha (historical-2024-national-slalom-wingfoil-2024-71c76d424570)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '8d5656f1-a50a-4845-9d02-aaa1249bdf7c'::uuid;

-- Sailor: Vincent Lam (historical-2024-national-slalom-wingfoil-2024-b0f8039a4d94)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '47b04ca3-1213-45af-aef4-66f7beedad18'::uuid;

-- Sailor: Damien Erwan Edmond Gay (historical-2024-national-slalom-wingfoil-2024-60624833a5a9)
UPDATE public.sailors SET gender = 'M', updated_at = now() WHERE id = '8c7af807-d8ca-41a5-9c34-20da063edb9f'::uuid;

-- Sailor: Rachel Charis Ng (historical-2024-national-slalom-wingfoil-2024-d91046a95cb0)
UPDATE public.sailors SET gender = 'F', updated_at = now() WHERE id = '2c76466a-7860-4020-ab3d-652a156dd020'::uuid;

COMMIT;
