-- Migration 147: Demographic Enrichment — Nationalities (231 Sailors) and Genders (17 Sailors)
--
-- 1. Updates nationality for 231 sailors based on verified sail number country prefixes (SGP, HKG, CHN, ESP, GBR, FRA)
--    and confirmed national sailing clubs across Singapore (SAFYC, CSC, CWSS, NSC, RSYC) and Australia (RQYS, RYCT, RSYS, FSC, SSCBC).
-- 2. Updates gender for 17 sailors with 100% confidence based on single-gender divisions (Aarhus Boys Worlds, ILCA 7 Men's class, and Malaysian Bin patronymics).
--
-- All operations executed in a single atomic transaction.

BEGIN;

-- ----------------------------------------------------------------------
-- Section 1: Update Nationalities (231 Sailors)
-- ----------------------------------------------------------------------
-- Acklin Stent (acklin-stent-anz26-659897) -> AUS (Australian club: MMYC/MYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '65989797-50da-4aef-88b6-47ff0e2df976' AND nationality IS NULL;

-- Adelle Neo En Qi (adelle-neo-en-qi-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '40e2da62-89da-517e-9f4a-b3a211c43029' AND nationality IS NULL;

-- Aiden Ray Toh (aiden-ray-toh-safyc23) -> SGP (Singapore club: MOESSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '7c70eebc-64d5-4eef-9fc1-6757fc2a7333' AND nationality IS NULL;

-- Alex Petton (alex-petton-hkoda26-0d0de4) -> HKG (Sail prefix: HKG 254)
UPDATE public.sailors
SET nationality = 'HKG', updated_at = clock_timestamp()
WHERE id = '0d0de462-e929-5cf8-a3d2-d597baa3de60' AND nationality IS NULL;

-- Alexander Walker (alexander-walker-anz26-c20196) -> AUS (Australian club: RQYS)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6' AND nationality IS NULL;

-- Alexandro Montanari (alexandro-montanari-safyc-history) -> SGP (Singapore club: Constant Wind)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd78deb1d-0965-5b5d-96a1-de1e0317d8e2' AND nationality IS NULL;

-- Alexey Filimonov (alexey-filimonov-csc-history) -> SGP (Singapore club: CWSS)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '0c596c64-1470-53c9-a265-83dd3789a380' AND nationality IS NULL;

-- Ali Kernaghan (ali-kernaghan-anz26-a0c7c1) -> AUS (Australian club: RSYS)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4' AND nationality IS NULL;

-- Andrew Lees (andrew-lees-8a3b2f) -> SGP (Singapore club: Aloha Sea Sports Centre)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'c55e208a-7782-416a-82db-82145c0113fe' AND nationality IS NULL;

-- Ang Zhi Shan Jewel (ang-zhi-shan-jewel-safyc24) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'aec8aceb-bcec-4e63-a653-e9d2ea620edf' AND nationality IS NULL;

-- Angus Johnston (angus-johnston-anz26-104a8f) -> AUS (Australian club: RYCT)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '104a8fa8-d159-48c4-b4a2-d70dd7eec5d1' AND nationality IS NULL;

-- Annabelle Rae Petracco (annabelle-rae-petracco-rm23) -> SGP (Sail prefix: SGP 3663)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd728d8fe-70cb-57dc-a4a9-8becbfe269d1' AND nationality IS NULL;

-- Annika Chui (annika-chui-safyc24) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'a6478204-66b5-4e50-ac84-b3a6fe942909' AND nationality IS NULL;

-- Archie Mcquillen (archie-mcquillen-anz26-1df827) -> AUS (Australian club: SBSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '1df827c0-2382-44b6-a361-ce6becf2bdcd' AND nationality IS NULL;

-- Ariel Chang (ariel-chang-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd1d47c55-894e-5e0d-afc3-363e3deadb0a' AND nationality IS NULL;

-- Arshad Shaheed Ali (arshad-shaheed-ali-y2pxhli) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'c5d0e5d8-8fa5-43fb-9bb9-5714e8f442fa' AND nationality IS NULL;

-- Arthur Phan (arthur-phan-4927b1) -> SGP (Singapore club: Kitesurfing Association of Singapore)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '85235bf8-e0e0-4b79-a033-6ab50c307b6d' AND nationality IS NULL;

-- Asher Williams (asher-williams-anz26-535962) -> AUS (Australian club: SoPYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '5359625c-bf84-49d1-b983-b908bd5b7f2e' AND nationality IS NULL;

-- Aurelia Wilson (aurelia-wilson-anz26-325b40) -> AUS (Australian club: RSYS)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '325b400d-1092-4711-b769-29b16989ea35' AND nationality IS NULL;

-- Axel Ryves (axel-ryves-anz26-9ee1f9) -> AUS (Australian club: HHSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '9ee1f9f1-aa37-4a62-8f85-67ab090c6d64' AND nationality IS NULL;

-- Azza Putrayuka Bin Yusmaini (azza-putrayuka-bin-yusmaini-safyc-history) -> SGP (Singapore club: NSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd589a37f-409a-5240-ac3e-e7ce68306df2' AND nationality IS NULL;

-- Bay Roche (bay-roche-anz26-465baf) -> AUS (Australian club: WSC/SSCBC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '465baf88-e20e-44a3-9883-5b9813a90230' AND nationality IS NULL;

-- Bill Hickling (bill-hickling-03cb39) -> SGP (Singapore club: Aloha Sea Sports Centre)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'eb753efb-4c2a-4678-ab73-61ebf8aa1a3b' AND nationality IS NULL;

-- Bridget Ang Yi Xuan (bridget-ang-yi-xuan-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '10fbef55-3817-55ad-91a2-cf7a1eb50748' AND nationality IS NULL;

-- Caden Tan (caden-tan-safyc23) -> SGP (Singapore club: Water Venture)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '4d9b4474-8f3f-4f0a-8b5b-36e626c116a9' AND nationality IS NULL;

-- Caleb Aaron Quek (caleb-aaron-quek-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'b22f69f0-2da0-539b-b720-1eb2c1316008' AND nationality IS NULL;

-- Caleb Lim Xinquan (caleb-lim-xinquan-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '87aee68c-038c-53d5-8294-6daf8fb1167a' AND nationality IS NULL;

-- Callum Grant (callum-grant-anz26-a92094) -> AUS (Australian club: FSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'a920942d-e921-4639-8fe8-bc183c330619' AND nationality IS NULL;

-- Cameron Underwood (cameron-underwood-fb5judp) -> AUS (Australian club: RYCT)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'cf486686-53b0-4c99-8231-1619dbbcb0f6' AND nationality IS NULL;

-- Chak Yun San (chak-yun-san-safyc23) -> SGP (Singapore club: Constant Wind)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '18650fb9-81d9-41e2-b84f-77930ae7415a' AND nationality IS NULL;

-- Chan Wye Chyn Kelly Junior (historical-2024-sg-foil-grand-prix-windfoil-2024-1ac1b101b11b) -> SGP (Sail prefix: SGP 6)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '0505c56b-135a-4ef0-8962-0186f89e148c' AND nationality IS NULL;

-- Charles Ball (charles-ball-anz26-c76874) -> SGP (Singapore club: WSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'c7687431-746d-4be4-a906-fd73e317674b' AND nationality IS NULL;

-- Charlie Mckenzie (charlie-mckenzie-safyc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'e56fa615-cb5a-5875-9b57-948e12ae4000' AND nationality IS NULL;

-- Charlie Purt (charlie-purt-fbul6vn) -> AUS (Australian club: SoPYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'a1fc7031-7912-4b9f-929a-ad8d13c1c8d9' AND nationality IS NULL;

-- Chloe Lin (chloe-lin-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'eca599ed-07e0-59cf-869d-212b955cae6a' AND nationality IS NULL;

-- Chloe Poh (chloe-poh-safyc23) -> SGP (Singapore club: PA PASSION WAVE)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '984320fa-537c-403c-ae72-e01cb0ea6e54' AND nationality IS NULL;

-- Chloe Quek (chloe-quek-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '257500e8-61f7-55bc-9c6d-c6be30cb232c' AND nationality IS NULL;

-- Chow Yi Jun, Ian (chow-yi-jun-ian-safyc24) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '5f93827a-355d-4512-b132-acd84d578fe6' AND nationality IS NULL;

-- Chris Newman (historical-2024-national-slalom-windsurfing-2024-31b283893bd5) -> GBR (Sail prefix: GBR88)
UPDATE public.sailors
SET nationality = 'GBR', updated_at = clock_timestamp()
WHERE id = '7b45b76c-075f-4be8-b298-e32f98915016' AND nationality IS NULL;

-- Christine Anne Tan Jie Ming (christine-anne-tan-jie-ming-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '0ec8ee20-3954-5f11-91f3-b4c575952236' AND nationality IS NULL;

-- Christopher Cheng (christopher-cheng-safyc-history) -> SGP (Singapore club: Changi Sailing Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'b9bfa3f9-0098-5843-add7-a039c017b448' AND nationality IS NULL;

-- Christopher Paul Newman (historical-2024-northeast-monsoon-windfoil-2024-1f1be40496a9) -> GBR (Sail prefix: GBR88)
UPDATE public.sailors
SET nationality = 'GBR', updated_at = clock_timestamp()
WHERE id = '3847f852-c68e-43f5-98ef-d4f1d688b879' AND nationality IS NULL;

-- Chung Pei Ming (chung-pei-ming-csc-history) -> SGP (Singapore club: PAAC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '58ab45d8-2889-5c74-801e-ddc68616037b' AND nationality IS NULL;

-- Cleo Mclay (cleo-mclay-anz26-343707) -> AUS (Australian club: HHSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '34370769-ffef-436d-8e90-9d7f9627748c' AND nationality IS NULL;

-- Cleo Paterson (cleo-paterson-anz26-e453e8) -> AUS (Australian club: BSYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'e453e892-d4e8-4d97-b6dd-f0cddcdd9b93' AND nationality IS NULL;

-- Colin Cheng Xinru (colin-cheng-xinru-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'e92c8a88-4f8a-5432-9e0d-42ad1e707486' AND nationality IS NULL;

-- Connor Grant (connor-grant-anz26-ad46f6) -> AUS (Australian club: FSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'ad46f601-d513-4b82-803f-46a12a4ff2eb' AND nationality IS NULL;

-- Dani Sherif Ahmed Khalil (dani-sherif-ahmed-khalil-opwouuw) -> SGP (Sail prefix: SGP 4457)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '74501028-cfd4-4679-9884-184fac8e44e6' AND nationality IS NULL;

-- Daniele Caminiti (daniele-caminiti-csc-history) -> SGP (Singapore club: CWSS)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'b537cac5-777d-54bb-b582-c224eea2da8b' AND nationality IS NULL;

-- Dylan Epari (dylan-epari-anz26-db0098) -> AUS (Australian club: RFBYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'db009883-9497-4b94-aebb-faefa490f260' AND nationality IS NULL;

-- Eddie Tan (eddie-tan) -> SGP (Singapore club: PA Water Venture)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'c40d2c19-a81b-411c-a00e-8805518050e3' AND nationality IS NULL;

-- Eden Ong (eden-ong-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '0cc63a55-112a-5c1d-9229-ff9e0b4aff28' AND nationality IS NULL;

-- Edward Brown (edward-brown-anz26-e461ce) -> AUS (Australian club: MYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'e461cef9-b775-4d3d-9836-2c78f7b8815c' AND nationality IS NULL;

-- Edward Seow Zhe (edward-seow-zhe-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '763f598b-5bd9-51a1-a6c0-05bc326832d2' AND nationality IS NULL;

-- Egan (egan-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '2206b79d-1206-5c67-8d12-01e206e3dcad' AND nationality IS NULL;

-- Eleanor Lemon (eleanor-lemon-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '63a44feb-8b32-5ade-a950-e0ff7ebf4927' AND nationality IS NULL;

-- Elkan Oh (historical-2024-sg-foil-grand-prix-windfoil-2024-f3ba95afc0ba) -> SGP (Sail prefix: SGP 52)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'dbe45d3e-6640-4242-b347-f8ce6030a26c' AND nationality IS NULL;

-- Ella Ong (ella-ong-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '28777f1e-6d1d-5b40-a262-49cc31c145dc' AND nationality IS NULL;

-- Elliot Chang (elliot-chang-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd2949095-ad61-5e03-9dbd-0875adef58c0' AND nationality IS NULL;

-- Elliot Drake (elliot-drake-csc-history) -> SGP (Singapore club: CWSS)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '3d188063-45a8-58a0-9ad5-d0f5377ac5ea' AND nationality IS NULL;

-- Emma Lew Yixuan (emma-lew-yixuan-safyc23) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'bed533f1-0427-4480-b797-8b3ed4d8de45' AND nationality IS NULL;

-- Enyu John Yin (enyu-john-yin-anz26-22c34a) -> SGP (Singapore club: WSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '22c34a50-8ab3-465e-afcc-31d5a8ad5b57' AND nationality IS NULL;

-- Enzo (enzo-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '7ab60e44-4ac3-532a-bf2d-7774aca0ccf7' AND nationality IS NULL;

-- Erik Rydin (erik-rydin-anz26-35f3c2) -> AUS (Australian club: SYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '35f3c2cb-2ced-494d-aa27-c5f0cf3193dd' AND nationality IS NULL;

-- Estelle Leong Yu En (estelle-leong-yu-en-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '1957f1fd-b5ee-5fd2-8104-53b44b2499db' AND nationality IS NULL;

-- Ethan Cornelius (ethan-cornelius-safyc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'df0efb6d-d3f4-593e-8e03-12ac28aba465' AND nationality IS NULL;

-- Ethan Loh Jiajie (ethan-loh-jiajie-safyc-history) -> SGP (Singapore club: NSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '2fb929c0-a0a4-5ada-8729-d88860f74a1b' AND nationality IS NULL;

-- Ethan Quek Heok Hwee (ethan-quek-heok-hwee-safyc23) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '581088f8-3692-427e-b6ab-1cee2e37e8da' AND nationality IS NULL;

-- Ethan Teo Yuan Xin (ethan-teo-yuan-xin-safyc23) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'caa6da8d-c618-4d8d-a46d-a7cb86ed5587' AND nationality IS NULL;

-- Ethan Wong Yi Chen (ethan-wong-yi-chen-safyc23) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '375c8fff-866a-4160-b102-487dd5880491' AND nationality IS NULL;

-- Ezann Sephira Tan (ezann-sephira-tan-safyc23) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'af3b51f0-60c2-4690-83fb-5e40af186579' AND nationality IS NULL;

-- Faith Ng (faith-ng-safyc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'cb0c73d9-e8fd-5145-9696-1621ed0a3435' AND nationality IS NULL;

-- Faustina Anine Tan Jie Ying (faustina-anine-tan-jie-ying-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'a8a62723-0a9e-5512-b8cc-d21b62598567' AND nationality IS NULL;

-- Favaro Thomas (favaro-thomas-safyc-history) -> SGP (Singapore club: Constant Wind)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd4811aca-aad3-54ba-bf9d-fd09e3bc7d41' AND nationality IS NULL;

-- Felix Knick (felix-knick-495c96) -> SGP (Singapore club: Constant Wind SeaSports)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '096cc0cc-04f0-47c5-a1fb-11fad06d84cc' AND nationality IS NULL;

-- Felix Koo Yi Xiong (felix-koo-yi-xiong-safyc23) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'a0d484f4-fac4-4b36-990b-56de929dc9fb' AND nationality IS NULL;

-- Finn Walker (finn-walker-anz26-37790a) -> AUS (Australian club: RQYS)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '37790a47-efee-47f0-a6d3-fe96f8dd67ac' AND nationality IS NULL;

-- Flynn Hammel (flynn-hammel-anz26-81932d) -> AUS (Australian club: SYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '81932d82-4827-4e4a-ad53-c84e046914ee' AND nationality IS NULL;

-- Fong Jun Ray (fong-jun-ray-safyc23) -> SGP (Singapore club: Constant Wind)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'b589c6d1-bce7-41e6-b515-422dc4d97491' AND nationality IS NULL;

-- Franciso Gancalves (franciso-gancalves-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '88f064a9-46a3-5463-b306-67c1ee52e0bd' AND nationality IS NULL;

-- Fred Cantwell (fred-cantwell-anz26-0ea521) -> AUS (Australian club: SSCBC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '0ea521ac-cf94-4f05-bd88-32e0d04c1579' AND nationality IS NULL;

-- Gary Zhu (gary-zhu-anz26-888228) -> AUS (Australian club: RPAYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '88822835-4596-4a37-880c-ffe6e9b41169' AND nationality IS NULL;

-- Gavin Chui (gavin-chui-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '997b0e8c-01b0-5ef1-aa9f-cc32b86b4200' AND nationality IS NULL;

-- Gerald Xie (gerald-xie-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '022bc523-2bdf-578f-8c30-51a17bcba469' AND nationality IS NULL;

-- Gerard Tan (gerard-tan-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '070e7354-871c-58ed-872a-872a84c5e7f1' AND nationality IS NULL;

-- Giselle Ong Ai (giselle-ong-ai-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '652c088d-7cad-5b35-96e4-46125b784d33' AND nationality IS NULL;

-- Greg McEntyre (greg-mcentyre-a9f3d2) -> SGP (Singapore club: Aloha Sea Sports Centre)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '150e1888-fafe-48e5-9c99-7f8baf9ee9e6' AND nationality IS NULL;

-- Guillaume Pichoir (guillaume-pichoir-e497b8) -> SGP (Singapore club: ONE°15 Marina Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '4558d756-7612-45a0-ad6b-6fb25e25bb8e' AND nationality IS NULL;

-- Hajolt Laming (hajolt-laming-csc-history) -> SGP (Singapore club: CWSS)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '7e13ea62-635f-5305-9686-129532b5161a' AND nationality IS NULL;

-- Hamilton Zhao (hamilton-zhao-anz26-298175) -> SGP (Singapore club: WSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '298175a4-db74-4a70-a55c-fdd65f4d3004' AND nationality IS NULL;

-- Hannes Moeller (hannes-moeller-anz26-df7126) -> AUS (Australian club: FSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'df7126ea-d7b8-40a9-bf0c-0df8ee83cf77' AND nationality IS NULL;

-- Harley Paterson (harley-paterson-anz26-0bff44) -> AUS (Australian club: BSYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '0bff44c8-1a1a-4950-94c6-e74c9bfa371a' AND nationality IS NULL;

-- Harriet Behrens (harriet-behrens-anz26-3e8649) -> AUS (Australian club: RQYS)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '3e8649b1-935e-436e-b72a-510dba915078' AND nationality IS NULL;

-- Harry Cooper (harry-cooper-anz26-b8cbcc) -> AUS (Australian club: RFBYC/FSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b8cbccdc-a8ce-47cf-8728-5011daab6617' AND nationality IS NULL;

-- Hayley Fang (hayley-fang-safyc24) -> SGP (Singapore club: Republic of Singapore Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '61cd2cae-f8ba-48bc-9b3f-ace4c5d4878a' AND nationality IS NULL;

-- Heidi Sinclair-Hill (heidi-sinclair-hill-anz26-8ffb1e) -> SGP (Singapore club: WSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '8ffb1e6b-203c-4bab-ac2f-18de1db064b7' AND nationality IS NULL;

-- Henry Zub (henry-zub-fgqkifx) -> AUS (Australian club: BSYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '721c5d6e-3856-460c-a862-304afaeb099d' AND nationality IS NULL;

-- Huang Xuchen (huang-xuchen-wgucmwo) -> CHN (Chinese club: Chinese Yachting Association)
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = '3631e260-02ea-4901-8f39-77f3edff72bf' AND nationality IS NULL;

-- Hugh Yu (hugh-yu-hkoda26-1062e2) -> HKG (Sail prefix: HKG 101)
UPDATE public.sailors
SET nationality = 'HKG', updated_at = clock_timestamp()
WHERE id = '1062e2a3-445b-5c75-9982-43b418c01fad' AND nationality IS NULL;

-- Ilyhsa Wong Manjie (ilyhsa-wong-manjie-0kig9fa) -> SGP (Singapore club: Constant Wind)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '9209f0f0-7b7a-4fc7-8cd7-d2164fa98551' AND nationality IS NULL;

-- Iman (iman-safyc-history) -> SGP (Singapore club: NSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '0734265d-4f61-5c1e-ae03-6f39847bbd1c' AND nationality IS NULL;

-- Isaac, Chow Yi Jie (isaac-chow-yi-jie-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '7b20f8b7-9c55-5891-a732-6098551d6c3a' AND nationality IS NULL;

-- Jack Keable (jack-keable-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '0b522907-6183-5f03-b3c2-7386790abf3d' AND nationality IS NULL;

-- Jackson Ho (jackson-ho-ec0e92) -> SGP (Singapore club: Aloha Sea Sports Centre)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'cd1dbf6b-5afe-4719-9cc3-2f27841b602e' AND nationality IS NULL;

-- Jade Low (jade-low-safyc23) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '9969c817-96a8-42da-9a69-a228d0338206' AND nationality IS NULL;

-- Jagger Kee Youxi (jagger-kee-youxi-jo6m0wd) -> SGP (Singapore club: Constant Wind SeaSports)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '482012c0-81e8-4f47-a37f-ab2d0774bdf5' AND nationality IS NULL;

-- Jake Whitton (jake-whitton-anz26-b1a01b) -> AUS (Australian club: LBSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b1a01b0c-d454-4c29-9953-53b6644bdde2' AND nationality IS NULL;

-- James Edwards (james-edwards-anz26-54b6d2) -> AUS (Australian club: MYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '54b6d292-7c1e-4da4-990b-802e674c06e5' AND nationality IS NULL;

-- James Feathers (james-feathers-cf7b0a) -> SGP (Singapore club: Constant Wind SeaSports)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'b320b985-4a91-4999-a6ab-8c38949dda6d' AND nationality IS NULL;

-- James Sullivan (james-sullivan-safyc24) -> SGP (Singapore club: Changi Sailing Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '5bda2468-4e6b-407f-81ce-d293659c0a26' AND nationality IS NULL;

-- Jarrel Khoo Yu Feng (jarrel-khoo-yu-feng-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'ef75b8dc-7b66-5fcb-876b-907f980076b6' AND nationality IS NULL;

-- Jasper Fifield (jasper-fifield-anz26-e2e50e) -> AUS (Australian club: Rsys)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'e2e50ed2-0886-476c-a373-2893d7480f35' AND nationality IS NULL;

-- Javier Ong (javier-ong-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'a206c1c4-9118-5927-8793-f846e3573bdf' AND nationality IS NULL;

-- Jayden Epari (jayden-epari-anz26-bf23fd) -> AUS (Australian club: RFBYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'bf23fd36-3596-4b3c-b92d-9123a1a84c14' AND nationality IS NULL;

-- Jayden Seow Hong Run (jayden-seow-hong-run-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '9064955d-1afa-508d-9332-9c9215379bf5' AND nationality IS NULL;

-- Jayden Tay (jayden-tay-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'f8c81708-a707-5c84-9189-dce97a528161' AND nationality IS NULL;

-- Jayden Wang (jayden-wang-anz26-b64cc6) -> AUS (Australian club: RPAYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b64cc6ae-a6e8-47a4-b702-b067d02e1f19' AND nationality IS NULL;

-- Jean Yves Broussy (jean-yves-broussy-csc-history) -> SGP (Singapore club: CWSS)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'afe0027e-3d74-5cb3-8112-9525c29aa13d' AND nationality IS NULL;

-- Jean-Marc Provost (historical-2024-northeast-monsoon-windfoil-2024-aa74c3261eb3) -> FRA (Sail prefix: FRA 23)
UPDATE public.sailors
SET nationality = 'FRA', updated_at = clock_timestamp()
WHERE id = '2d0b3032-c433-47be-99f6-dbe4b6413382' AND nationality IS NULL;

-- Jerroll Lo (historical-2024-national-slalom-windsurfing-2024-849df11b2069) -> SGP (Sail prefix: SGP2)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '1ce0df8d-1011-49b5-a628-6e77fb508918' AND nationality IS NULL;

-- Jessica Higgins (jessica-higgins-anz26-afb1db) -> AUS (Australian club: BSYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94' AND nationality IS NULL;

-- Jessica Hope Ewies (jessica-hope-ewies-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '75ab666e-5327-507f-870b-8e8bcafae031' AND nationality IS NULL;

-- Johan Tang (johan-tang-safyc-history) -> SGP (Singapore club: NSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '8f2fe1e4-4956-5342-9d45-707b2b76e00a' AND nationality IS NULL;

-- Jonas Ng (jonas-ng-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'e8b1ba82-0879-58c4-bc4d-5aa0300dcee6' AND nationality IS NULL;

-- Joshua Cheong (joshua-cheong-safyc23) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '54cbdac5-4227-4d3e-ba8e-892965952223' AND nationality IS NULL;

-- Josiah Tan Xuan Yi (josiah-tan-xuan-yi-safyc23) -> SGP (Singapore club: Constant Wind)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '9e312cb4-2164-4f4f-8d08-464c126cab21' AND nationality IS NULL;

-- Joy Chen (joy-chen-safyc23) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd9865e26-0538-4286-b89e-e55a1accd250' AND nationality IS NULL;

-- Joy Shen (joy-shen-anz26-1e8456) -> AUS (Australian club: SYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '1e8456ec-bb72-41f1-80e0-99536c65ab4d' AND nationality IS NULL;

-- Julian Ong (julian-ong-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '19f9e7e5-765d-5544-a056-076161e001b1' AND nationality IS NULL;

-- Julyet Lew (julyet-lew-safyc-history) -> SGP (Singapore club: Raffles Marina)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'a01b175f-a7f0-5715-bab4-c70d81ab4e03' AND nationality IS NULL;

-- Jun Hao Lo (jun-hao-lo-ee545a) -> SGP (Singapore club: Aloha Sea Sports Centre)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '39e46472-e3e9-4935-b25f-7a7bddf5af8d' AND nationality IS NULL;

-- Justin (justin-safyc-history) -> SGP (Singapore club: Constant Wind)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '8ffa116a-c240-50cf-9829-612d51554520' AND nationality IS NULL;

-- Kabir Manoj Daryanani (kabir-manoj-daryanani-y0n7p3o) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'a7ed7eef-6234-410a-8e41-90033c42db44' AND nationality IS NULL;

-- Kalle Gravare (kalle-gravare-anz26-7b929e) -> SGP (Singapore club: WSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '7b929e9d-7925-4705-94ab-d175a82bb610' AND nationality IS NULL;

-- Kam Hao Re (kam-hao-re-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '54445946-61e5-525d-aabe-db41f3b5a248' AND nationality IS NULL;

-- Khoo Boo Ming Manfred (khoo-boo-ming-manfred-ohe1kb1) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '969b6bef-7aec-4cae-8178-603c54fb83d8' AND nationality IS NULL;

-- Kuah Yong Chuan Ezekiel (kuah-yong-chuan-ezekiel-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '45c080af-bf23-5a63-8e00-a6f9b151bffb' AND nationality IS NULL;

-- Lachlan Whitton (lachlan-whitton-anz26-94e4e5) -> AUS (Australian club: LBSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '94e4e509-0d0c-4d25-92ef-9ba48416f040' AND nationality IS NULL;

-- Lai Yanjie (lai-yanjie-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '1fc99d65-7656-56e6-89e8-f17289c0b398' AND nationality IS NULL;

-- Lai Yankai (lai-yankai-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'edd3af95-dae5-579b-bb71-cb5ec2c8ca81' AND nationality IS NULL;

-- Lee Kieran (lee-kieran-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'ec520ea2-bdb8-525f-add6-9b9ebdeaa7bb' AND nationality IS NULL;

-- Leo Sun (leo-sun-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '802534eb-39e1-57a4-a221-0aa10bc79ade' AND nationality IS NULL;

-- Leyla Sherif Ahmed Khalil (leyla-sherif-ahmed-khalil) -> SGP (Sail prefix: SGP 177)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '05df1a95-109f-446d-87bb-5ca598b3a595' AND nationality IS NULL;

-- Lie Huan Cheng (lie-huan-cheng-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '83015dcb-6cd8-5b4e-9040-55d10d913849' AND nationality IS NULL;

-- Lie Huan Teng (lie-huan-teng-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '50619e4a-b629-50b1-9c1b-44a4fd12dc5c' AND nationality IS NULL;

-- Liew Kien Lok Elliott (liew-kien-lok-elliott-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '2ea3e07d-eba4-58ca-a0e2-bc868c989533' AND nationality IS NULL;

-- Lila Donnellan (lila-donnellan-anz26-c65ce1) -> AUS (Australian club: MYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'c65ce173-0cc5-442a-bf14-66cb500ded2a' AND nationality IS NULL;

-- Lily Zahab (lily-zahab-anz26-79d6d1) -> AUS (Australian club: RSYS)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '79d6d1fe-2427-4b45-ab45-6cd4658e5571' AND nationality IS NULL;

-- Lily-May Weller (lily-may-weller-anz26-a30824) -> AUS (Australian club: FSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'a3082455-4079-441d-8436-478f4c9024b7' AND nationality IS NULL;

-- Lim Kiat Ye Raylen (lim-kiat-ye-raylen-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'fd9c2af9-e0b1-5b66-b9e6-1909dbb9b145' AND nationality IS NULL;

-- Lin Tze Jay Gregory (lin-tze-jay-gregory-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd1943a53-36e6-5608-82f5-356043d99301' AND nationality IS NULL;

-- Lincoln Davey (lincoln-davey-anz26-942313) -> AUS (Australian club: RYCT)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '942313d9-c56c-4ac5-80c7-0e32fa34ec27' AND nationality IS NULL;

-- Liu Li'An (liu-li-an-nsc24) -> CHN (Chinese club: Chinese Yachting Association)
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = 'b7e4c1a2-6d58-4f0a-9c33-1a6e8f0d4b21' AND nationality IS NULL;

-- Lo Jin Keith (lo-jin-keith-safyc24) -> SGP (Singapore club: Constant Wind)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd80da417-a89f-4cfb-8be0-be4fc5abc8c1' AND nationality IS NULL;

-- Luca Von Bibra (luca-von-bibra-anz26-10ebfe) -> AUS (Australian club: RQYS)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '10ebfe56-5763-4270-bb43-ad01e524c0ca' AND nationality IS NULL;

-- Lucas Seah (lucas-seah-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'b4f02fe9-4794-5c75-9eb4-9089e7eb6353' AND nationality IS NULL;

-- Lucy Lin (lucy-lin-anz26-1b22f9) -> SGP (Singapore club: WSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '1b22f933-9817-4f8b-a366-11315c5bc283' AND nationality IS NULL;

-- Malawa Heale (malawa-heale-anz26-39fb5e) -> AUS (Australian club: MYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '39fb5e0a-c7a4-4aea-8adc-e65325e66843' AND nationality IS NULL;

-- Mark Hayden Theseira (mark-hayden-theseira-safyc-history) -> SGP (Singapore club: RSYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '39124a7e-e1de-5268-a4fc-153ce05b706b' AND nationality IS NULL;

-- Marsha Shahrin (historical-2024-sg-foil-grand-prix-windfoil-2024-c696c43ae863) -> SGP (Sail prefix: SGP73)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '80419c1d-1ffc-4e6b-9c75-d94a7516df6b' AND nationality IS NULL;

-- Matt Lim (matt-lim-b7o3d7p) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '9e30138b-6c26-476b-ae74-e1ecc5d536e1' AND nationality IS NULL;

-- Maxwell Boulton (maxwell-boulton-anz26-39a4c7) -> AUS (Australian club: RQYS)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '39a4c7ef-6f5f-4988-abda-887a645cf3ff' AND nationality IS NULL;

-- Meii You (meii-you-anz26-cdd611) -> SGP (Singapore club: WSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'cdd61132-5975-4264-8804-cf78cd45258e' AND nationality IS NULL;

-- Mikhail McEntyre (mikhail-mcentyre-81d387) -> SGP (Singapore club: Aloha Sea Sports Centre)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '8d9778ad-636a-4925-8f8b-a4b8913fd70b' AND nationality IS NULL;

-- Milton Li (milton-li-anz26-51a80a) -> AUS (Australian club: HHSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '51a80a27-8665-4db2-afb4-0940cbc20376' AND nationality IS NULL;

-- Nadia Xi-En Chan (nadia-xi-en-chan-safyc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'dda11af0-5910-599d-bd47-aa21204be739' AND nationality IS NULL;

-- Nashwaa Herra (nashwaa-herra-csc-history) -> SGP (Singapore club: NSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'af72d8cf-828f-57dd-b63e-267c8b29deda' AND nationality IS NULL;

-- Ned Conrad Tyson (ned-conrad-tyson-csc-history) -> HKG (Sail prefix: HKG303)
UPDATE public.sailors
SET nationality = 'HKG', updated_at = clock_timestamp()
WHERE id = '632b2a41-4a6e-558c-b791-4acb6a460442' AND nationality IS NULL;

-- Ng Kaile Caleb (ng-kaile-caleb-csc-history) -> SGP (Singapore club: MOESSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'e8b1186b-e9f5-556b-9a70-1d0754db9732' AND nationality IS NULL;

-- Ng Kyle Jin (ng-kyle-jin-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '358c9008-3947-5cc1-b7a8-fde322576f55' AND nationality IS NULL;

-- Nicole Lim Xinyi (nicole-lim-xinyi-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'a2d8418d-a34d-5dc8-9f21-629cf7efe30b' AND nationality IS NULL;

-- Nicole Ng Hui Hong (nicole-ng-hui-hong) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '0701bebf-cbd2-4bb7-9d1b-34f48fad4f86' AND nationality IS NULL;

-- Nurul Natasha Binte Mohamed Jailani (nurul-natasha-binte-mohamed-jailani-csc-history) -> SGP (Singapore club: MOESSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '4fabfc44-1185-5022-97d9-313c6c2e97c9' AND nationality IS NULL;

-- Ollie Morris (ollie-morris-anz26-24df12) -> AUS (Australian club: BSYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '24df120c-c122-40ca-94e8-b4752e6f4b95' AND nationality IS NULL;

-- Orlando Watts (orlando-watts-anz26-15b30f) -> AUS (Australian club: RSYS)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '15b30f88-d7b3-45f1-b9c2-a59c9972101b' AND nationality IS NULL;

-- Ou Xin Ying (ou-xin-ying-safyc24) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '1e7ec0fd-1ec7-4e83-bbcd-0ada192b7e1f' AND nationality IS NULL;

-- Pedro Goncalves (pedro-goncalves-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '4fc4b65d-4b5d-5926-af4a-c3879d02181a' AND nationality IS NULL;

-- Radiance Koh (radiance-koh-csc-history) -> SGP (Singapore club: MOESSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '6c583ec1-4273-509a-8769-bbc3fa8fabf1' AND nationality IS NULL;

-- Raphael Lucas Chan (raphael-lucas-chan-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'fe81e936-2a3f-5a20-b21f-ceb72130a2fb' AND nationality IS NULL;

-- Reid Martin (reid-martin-anz26-fe5575) -> AUS (Australian club: PDSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'fe55751a-320e-48f8-92fd-fd40bca74292' AND nationality IS NULL;

-- Russell Lim (russell-lim-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'ab1187f5-9a3a-50a5-9407-60769dd0a492' AND nationality IS NULL;

-- Ruth Pek (ruth-pek-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'b4836b46-2564-5f87-b597-ba7c52dba81a' AND nationality IS NULL;

-- Ryan Goh Si Han (ryan-goh-si-han-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '970514e8-668f-59d5-a23a-d2b2813065a5' AND nationality IS NULL;

-- Ryan Sei (ryan-sei-safyc-history) -> SGP (Singapore club: Changi Sailing Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '1454b040-3834-589e-8fc0-0a8e80a9f3d3' AND nationality IS NULL;

-- Ryan Wong Zhen Hao (ryan-wong-zhen-hao-safyc-history) -> SGP (Singapore club: NSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '1b65053b-459c-5db8-bcb7-a5641b50f99f' AND nationality IS NULL;

-- Ryusai Hatano (ryusai-hatano-f7f7bc) -> SGP (Singapore club: Constant Wind SeaSports)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '553e08e7-624e-4184-97ef-191156167a1a' AND nationality IS NULL;

-- Safraz Khan (historical-2024-47th-singapore-ilca-open-ilca7-2024-fb473f832067) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '6d0913b2-5c34-4715-8179-fb48d88865c6' AND nationality IS NULL;

-- Samantha Archer (samantha-archer-anz26-35c9ca) -> AUS (Australian club: SBSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '35c9ca94-001c-49f5-9c63-e939cbfa82b3' AND nationality IS NULL;

-- Samantha Goh Wei Li (samantha-goh-wei-li-csc-history) -> SGP (Singapore club: MOESSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '38d60f05-e884-5516-ace9-3ce06236521a' AND nationality IS NULL;

-- Samuel Darbyshire (samuel-darbyshire-figml1e) -> AUS (Australian club: RQYS)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '078bc565-17ae-461c-a08d-1330f11517a8' AND nationality IS NULL;

-- Samuel Smith (samuel-smith-anz26-afc46d) -> AUS (Australian club: SYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa' AND nationality IS NULL;

-- Seah En Qi Chloe (seah-en-qi-chloe-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '14ea56a3-14b0-5517-a202-5e37fe1445ed' AND nationality IS NULL;

-- Shravan (shravan-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '8d208efd-1d30-5e7a-81fa-25a4b8fc0c69' AND nationality IS NULL;

-- Simone Ng (simone-ng-safyc23) -> SGP (Singapore club: Republic of Singapore Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '7d1839b5-23a8-4efc-ad91-3597eac4d0d9' AND nationality IS NULL;

-- Sky Neo Chok Jun (sky-neo-chok-jun-sysc24) -> SGP (Sail prefix: SGP 214254)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'ef605a1e-75d1-42a6-a2ed-32ce46488dd3' AND nationality IS NULL;

-- Skye Ng Hong Wei (skye-ng-hong-wei-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '31cb9b08-bcdb-5ccc-85e3-8e0612f7fe91' AND nationality IS NULL;

-- Summer Newman (summer-newman-anz26-223b5e) -> AUS (Australian club: BSYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '223b5e00-fa91-4eb9-9fa9-83273b0760b8' AND nationality IS NULL;

-- Sven Welak (sven-welak-a87216) -> SGP (Singapore club: Aloha Sea Sports Centre)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '84a4bbc8-434a-4f01-8c8a-2ebb89822b9b' AND nationality IS NULL;

-- Sybelle Marie Antoinette (sybelle-marie-antoinette-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '305e9236-241b-54c0-af8c-a52b1984ac63' AND nationality IS NULL;

-- Tan Wearn Haw (historical-2024-national-slalom-windsurfing-2024-da47039cccfb) -> SGP (Sail prefix: SGP1)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '4657a5d7-770c-456a-a381-4fb261c5e6e8' AND nationality IS NULL;

-- Tang Chi Cheong Elliot (tang-chi-cheong-elliot-wkbggem) -> SGP (Singapore club: Constant Wind SeaSports)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'ed7d371c-d7c1-41e4-af68-226a9eb323fc' AND nationality IS NULL;

-- Tate Cantwell (tate-cantwell-anz26-d710b7) -> AUS (Australian club: SSCBC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'd710b7c6-5d97-462d-8a9b-ae37b0379f46' AND nationality IS NULL;

-- Teo Polizzi Spaudo (teo-polizzi-spaudo-hkoda26-1392c6) -> ESP (Sail prefix: ESP 3666)
UPDATE public.sailors
SET nationality = 'ESP', updated_at = clock_timestamp()
WHERE id = '1392c663-9f2b-535a-8b9a-6ab7bf4c251f' AND nationality IS NULL;

-- Theo Altson (theo-altson-anz26-16b59f) -> AUS (Australian club: SSCBC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '16b59fff-e224-4eb6-b839-ea5ff1482211' AND nationality IS NULL;

-- Theodore Perrier (theodore-perrier-safyc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'e24b719b-cfc2-5ace-878e-f0c6f6f42fb0' AND nationality IS NULL;

-- Thomas Pitt (thomas-pitt-anz26-2ce7f3) -> AUS (Australian club: RYCT)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '2ce7f341-53ee-4434-a35f-106f45110f47' AND nationality IS NULL;

-- Timotheus Yeo Jun Rui (timotheus-yeo-jun-rui-csc-history) -> SGP (Singapore club: MOESSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '6136569d-3148-55a5-98d4-7024209f3eb4' AND nationality IS NULL;

-- Tom Griffiths (tom-griffiths-fd96wyi) -> AUS (Australian club: HHSC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '30880421-1dc4-4a14-9c6b-8c00de39e4d8' AND nationality IS NULL;

-- Tomas Carbonnell (tomas-carbonnell-hkoda26-eacd5f) -> ESP (Sail prefix: ESP 3651)
UPDATE public.sailors
SET nationality = 'ESP', updated_at = clock_timestamp()
WHERE id = 'eacd5ff6-0d47-5ab6-94bd-56fcf198a233' AND nationality IS NULL;

-- Tong Xuan Yu (tong-xuan-yu-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '9a5b0de5-c0cb-5add-a0cb-01ee97240113' AND nationality IS NULL;

-- Trevis Ang (trevis-ang-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '384fcf63-95ae-5da6-ac98-8f15fdf556a3' AND nationality IS NULL;

-- Tytus Seth Goh (tytus-seth-goh-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'a026e4bc-87de-5861-8b61-d03a9fe69b0d' AND nationality IS NULL;

-- Victoria Chan (victoria-chan-csc-history) -> SGP (Singapore club: WVPR)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '97cbde3f-9b92-5b2b-abbd-416a43ad32c9' AND nationality IS NULL;

-- Violet Zehra Ames (violet-zehra-ames-safyc-history) -> SGP (Singapore club: NSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'eb3b654a-d0ea-5d11-af64-b8d4eacbfa3d' AND nationality IS NULL;

-- Walter Lock Ming Yeung (walter-lock-ming-yeung-csc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd61bc580-e6a5-5f91-84f1-06c4224dae56' AND nationality IS NULL;

-- Wang Tianyou (wang-tianyou-wg5es7g) -> CHN (Chinese club: Chinese Yachting Association)
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = '60b1447d-5e8f-4592-ac93-21d3363b4b48' AND nationality IS NULL;

-- Wang Yebin (wang-yebin-whjcf91) -> CHN (Chinese club: Chinese Yachting Association)
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = '63ce85aa-6f09-4391-bf5a-b00f2fdbe6f8' AND nationality IS NULL;

-- Wang Yian (wang-yian-wikhdmr) -> CHN (Chinese club: Chinese Yachting Association)
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = 'bd2d3672-c1d6-4ba5-9d90-63cd3094edb6' AND nationality IS NULL;

-- Wang Yiming (historical-2024-csc-ilca4-jan-2024-e02d2fefe7f7) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '551e6784-5d53-4ea7-a2b9-aa907b7d6f61' AND nationality IS NULL;

-- Wanzhi Elva Li (wanzhi-elva-li-sysc24) -> HKG (Sail prefix: HKG 220859)
UPDATE public.sailors
SET nationality = 'HKG', updated_at = clock_timestamp()
WHERE id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b' AND nationality IS NULL;

-- Willett Liam Michael (willett-liam-michael-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'd8c3102f-cd4f-56ce-9b87-c2794140b10b' AND nationality IS NULL;

-- William Rogers (william-rogers-anz26-73a082) -> SGP (Singapore club: WSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '73a082e4-e3f8-48d7-a5fd-ef0f587867ea' AND nationality IS NULL;

-- Wyatt Enle Yang Huffines (wyatt-enle-yang-huffines-csc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '3d330236-c6c9-5318-8ada-7eb9da765b11' AND nationality IS NULL;

-- Xavier Goh (xavier-goh-safyc-history) -> SGP (Singapore club: SAFYC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'b2ab1fb3-b2df-55d6-9669-520f3ce56348' AND nationality IS NULL;

-- Xavier James (xavier-james-anz26-8f29ff) -> AUS (Australian club: RYCT)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '8f29ffb3-a556-46c9-82c5-4b20f6d75356' AND nationality IS NULL;

-- Yang Ruiyang (yang-ruiyang-sysc24) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'a395fed6-cd42-4923-8678-f88a1e49d724' AND nationality IS NULL;

-- Yohan Tupili (yohan-tupili-safyc-history) -> SGP (Singapore club: CSC)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = 'db062576-0723-5050-b0fa-07cb3a75556d' AND nationality IS NULL;

-- Yufu Wang (yufu-wang-anz26-f5f68b) -> AUS (Australian club: RPAYC)
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f5f68b83-bb5b-4523-963f-3f367d5b4771' AND nationality IS NULL;

-- Yunzhe Tao (yunzhe-tao-hkoda26-f7b699) -> CHN (Sail prefix: CHN 7001)
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = 'f7b6991a-030c-5479-96e8-32f8073470ca' AND nationality IS NULL;

-- Zack Vaikath (zack-vaikath-safyc24) -> SGP (Singapore club: SAF Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '3f94c0a6-68b4-4174-be0e-6ea460c2aeab' AND nationality IS NULL;

-- Zeldyr Tan Xun (zeldyr-tan-xun-cf6c6qt) -> SGP (Singapore club: Republic of Singapore Yacht Club)
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '5dfe09e8-4963-4999-965b-3bddb10e6a42' AND nationality IS NULL;


-- ----------------------------------------------------------------------
-- Section 2: Update Genders (17 Sailors)
-- ----------------------------------------------------------------------
-- Che Liu -> M (2026 ILCA 4 Youth World Championships (Boys fleet))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'b7214229-e97e-4c39-b342-cc4e99ff0623' AND gender IS NULL;

-- Jason Lin -> M (2026 ILCA 4 Youth World Championships (Boys fleet))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '79dc7d49-7373-44e4-9d0d-b3be10d33eca' AND gender IS NULL;

-- Hadif Muayyad Bin Mohd Husni -> M (Bin (son of) in Malaysian national entry)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '8012fc54-f672-5e6f-8693-25415c616fc3' AND gender IS NULL;

-- Muaz Mujahid Bin Khamarul Azwan -> M (Bin (son of) in Malaysian national entry)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '2bda4fc0-b72c-4b0b-b21f-597107dc5ca8' AND gender IS NULL;

-- Muhammad Hamka Naufal Bin Mohd Hasrizan -> M (Bin (son of) in Malaysian national entry)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'bb5845d9-f2eb-5d75-b421-130522197ff6' AND gender IS NULL;

-- Muhammad Zahir Naiman Bin Ismail -> M (Bin (son of) in Malaysian national entry)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' AND gender IS NULL;

-- Banpoat Netkrachang -> M (ILCA 7 Men's single-handed class)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '1b851f6a-eb86-5f45-9182-d8a232c66638' AND gender IS NULL;

-- Benoit Cosserat -> M (ILCA 7 Men's single-handed class)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '2afb8b24-9601-51a3-bcba-952ca58aeeaa' AND gender IS NULL;

-- James Sullivan -> M (ILCA 7 Men's single-handed class)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '5bda2468-4e6b-407f-81ce-d293659c0a26' AND gender IS NULL;

-- Jeanson Lumapas -> M (ILCA 7 Men's single-handed class)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '0f1602d0-82c1-4be9-8e5a-0921bae516c3' AND gender IS NULL;

-- Justin -> M (ILCA 7 Men's single-handed class)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '8ffa116a-c240-50cf-9829-612d51554520' AND gender IS NULL;

-- Kazuya Declan Yoshikawa -> M (ILCA 7 Men's single-handed class)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'e3892131-5f25-5e3b-a3f2-ff01ec597df0' AND gender IS NULL;

-- Morris Lann Madlos -> M (ILCA 7 Men's single-handed class)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'c846c0e6-8776-4e2b-9845-8dbe5b2547ca' AND gender IS NULL;

-- Safraz Khan -> M (ILCA 7 Men's single-handed class)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '6d0913b2-5c34-4715-8179-fb48d88865c6' AND gender IS NULL;

-- Santhiti Hirunsart -> M (ILCA 7 Men's single-handed class)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'c4761016-854b-5fb5-8eb2-5466f722a3cc' AND gender IS NULL;

-- Wachirawit Boonpunya -> M (ILCA 7 Men's single-handed class)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '4f29a44d-ac8e-5f4a-8a5b-87326515a168' AND gender IS NULL;

-- Whok Dimapilis -> M (ILCA 7 Men's single-handed class)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '115e5bdf-9079-4a63-b63d-5fadd39eb1c7' AND gender IS NULL;

-- ----------------------------------------------------------------------
-- Section 3: Update Missing DOBs from Verified Class Index Records
-- ----------------------------------------------------------------------
-- Amy Luo -> 2013-01-01 (Asian Optimist Index birth year 2013)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'f22f457e-e489-46e7-a8b4-7549aaed3781' AND dob IS NULL;

COMMIT;
