-- 118_import_5th_lysc_2026_optimist_results.sql
--
-- Source: THE 5TH LYSC 2026 _ Optimist.pdf supplied to SailorPath.
-- The supplied three-page final result was rendered and visually reconciled:
-- 50 Gold results, 49 Silver results, 10 races per entry, one discard each.
-- The public evidence copy is byte-identical to the supplied file (SHA-256
-- 87b7affc4d6696dcbf7d0035a824073f8758d7a9cdbaf5d0944805d562f82f47).

BEGIN;

CREATE TEMP TABLE _lysc_2026_payload (
  fleet text NOT NULL,
  source_rank integer NOT NULL,
  club text NOT NULL,
  source_sail_number text NOT NULL,
  source_name text NOT NULL,
  source_gender text NOT NULL,
  source_nationality text,
  total_score real NOT NULL,
  nett_score real NOT NULL,
  race_scores jsonb NOT NULL,
  source_page integer NOT NULL,
  index_identity_key text NOT NULL,
  sailor_id uuid
) ON COMMIT DROP;

INSERT INTO _lysc_2026_payload (
  fleet, source_rank, club, source_sail_number, source_name, source_gender,
  source_nationality, total_score, nett_score, race_scores, source_page,
  index_identity_key
) VALUES
  ('Gold', 1, 'MSA/MSN', 'MAS 115', 'MUHAMMAD YAASIN BIN SYAHRIZAN', 'M', 'MAS', 22.0, 16.0, '["2","1","1","1","2","1","4","1","(6)","3"]'::jsonb, 1, 'mas:yaasinsyahrizan'),
  ('Gold', 2, 'MSA/MSN', 'MAS 121', 'MUHAMMAD ANAS ARYAN BIN MOHD NOOR RIZDUAN', 'M', 'MAS', 87.0, 37.0, '["1","12","3","8","1","2","(50 BFD)","2","4","4"]'::jsonb, 1, 'mas:muhammadanasaryanbinmohdnoorrizduan'),
  ('Gold', 3, 'KSA-MSNK', 'MAS 906', 'IRFAN YUSRAN BIN MD SAID', 'M', 'MAS', 85.0, 58.0, '["3","16","5","5","3","2","2","(27)","20","2"]'::jsonb, 1, 'mas:irfanyusranbinmdsaid'),
  ('Gold', 4, 'MYF', 'MYA 2', 'SITT MAY CHIT PO', 'F', 'MYA', 93.0, 61.0, '["8","10","10","6","9","7","1","7","3","(32)"]'::jsonb, 1, 'mya:sittmaychitpo'),
  ('Gold', 5, 'MSA/MSN', 'MAS 118', 'NUR ARIANA SOFEA BINTI ADZARUL FADZLIE', 'F', 'MAS', 89.0, 65.0, '["2","8","4","8","11","6","6","10","(24)","10"]'::jsonb, 1, 'mas:nurarianasofeabintiadzarulfadzlie'),
  ('Gold', 6, 'TSA-MSNT', 'MAS 219', 'NUFAEL HAKIMI IZHAR', 'M', 'MAS', 117.0, 67.0, '["13","17","8","4","(50 BFD)","1","13","9","1","1"]'::jsonb, 1, 'mas:nufaelhakimiizhar'),
  ('Gold', 7, 'MYF', 'MYA 1', 'THUN PYAE ZAN', 'M', 'MYA', 120.0, 70.0, '["14","4","7","1","5","3","(50 BFD)","15","5","16"]'::jsonb, 1, 'mya:thunpyaezan'),
  ('Gold', 8, 'X-45', 'CHN 656', 'LONGZHITAO', 'M', 'CHN', 103.0, 83.0, '["(20)","2","16","3","10","10","5","13","18","6"]'::jsonb, 1, 'chn:longzhitao'),
  ('Gold', 9, 'MSA/MSN', 'MAS 119', 'KHAIRUL ILZANI MOHD AFENDY', 'M', 'MAS', 116.0, 91.0, '["7","4","20","13","4","14","9","6","14","(25)"]'::jsonb, 1, 'mas:khairulilzaniafendy'),
  ('Gold', 10, 'MSA/MSN', 'MAS 114', 'MIA AZRANIA BT MOHD AZRALD', 'F', 'MAS', 130.0, 93.0, '["5","6","2","17","13","16","12","(37)","7","15"]'::jsonb, 1, 'mas:miaazrania'),
  ('Gold', 11, 'KSA-MSNK', 'MAS 904', 'MUHAMMAD IZZ IZDIHAR BIN MOHD HUSNEY', 'M', 'MAS', 152.0, 102.0, '["5","(50 RET)","1","5","2","5","10","50 DSQ","17","7"]'::jsonb, 1, 'mas:muhammadizzizdiharbinmohdhusney'),
  ('Gold', 12, 'KSA-MSNK', 'MAS 902', 'MUHAMMAD ZULFAN AKIF BIN MOHD ZULKIFLY', 'M', 'MAS', 149.0, 108.0, '["11","5","19","15","5","3","26","12","12","(41)"]'::jsonb, 1, 'mas:muhammadzulfanakifbinmohdzulkifly'),
  ('Gold', 13, 'MSN PERAK', 'MAS 381', 'MUHAMMAD HIKMY QHALIF BIN MOHD HAFIZ', 'M', 'MAS', 154.0, 113.0, '["6","3","14","25","7","6","15","19","(41)","18"]'::jsonb, 1, 'mas:muhammadhikmyqhalifbinmohdhafiz'),
  ('Gold', 14, 'YRAT', 'THA 1900', 'PORNYAMOL SAWAENGKHUN', 'F', 'THA', 165.0, 115.0, '["4","26","7","12","1","11","(50 BFD)","5","19","30"]'::jsonb, 1, 'tha:pornyamolsawaengkhun'),
  ('Gold', 15, 'TSA-MSNT', 'MAS 247', 'MUHAMMAD AMSHA DANISH BIN RUZAKI', 'M', 'MAS', 155.0, 117.0, '["7","3","2","6","28","7","16","16","32","(38)"]'::jsonb, 1, 'mas:muhammadamshadanishbinruzaki'),
  ('Gold', 16, 'MSN PERAK', 'MAS 373', 'NUR DAMIA BINTI KHAIRUL QAHHER', 'F', 'MAS', 169.0, 119.0, '["3","5","19","20","(50 BFD)","4","31","20","8","9"]'::jsonb, 1, 'mas:nurdamiabintikhairulqahher'),
  ('Gold', 17, 'MSA/MSN', 'MAS 111', 'MUHAMMAD RAYYAN BIN MOHD YUSOF', 'M', 'MAS', 173.0, 123.0, '["13","10","4","3","31","20","21","(50 RET)","2","19"]'::jsonb, 1, 'mas:muhammadrayyanbinmohdyusof'),
  ('Gold', 18, 'SAFYC', 'SGP 3002', 'OLIVIA CHEONG', 'F', 'SGP', 175.0, 125.0, '["(50 BFD)","6","3","28","8","19","11","4","22","24"]'::jsonb, 1, 'sgp:oliviacheong'),
  ('Gold', 19, 'NESSA', 'MAS 616', 'PUTRA HASIEF HAIQAL BIN ERWANZEE', 'M', 'MAS', 177.0, 131.0, '["10","2","11","14","25","9","27","28","(46)","5"]'::jsonb, 1, 'mas:putrahasiefhaiqalbinerwanzee'),
  ('Gold', 20, 'JSA', 'MAS 722', 'RUQAYYAH BINTI MUHAMMAD NULHAKIM', 'F', 'MAS', 174.0, 133.0, '["4","11","10","7","18","16","32","(41)","15","20"]'::jsonb, 1, 'mas:ruqayyahbintimuhammadnulhakim'),
  ('Gold', 21, 'MSN PERAK', 'MAS 375', 'AMZAR SYAABAN BIN MOHD NOOR AZMAN', 'M', 'MAS', 169.0, 137.0, '["9","23","17","2","15","12","22","(32)","26","11"]'::jsonb, 1, 'mas:amzarsyaabanbinmohdnoorazman'),
  ('Gold', 22, 'MSA/MSN', 'MAS 113', 'IMANINA RAISYA BINTI IZHAR', 'F', 'MAS', 180.0, 142.0, '["18","7","6","4","14","21","19","(38)","27","26"]'::jsonb, 1, 'mas:imaninaraisyabintiizhar'),
  ('Gold', 23, 'MSA/MSN', 'MAS 261', 'LYDIA HANNAH JAMSINE BINTI LUKMAN', 'F', 'MAS', 196.0, 146.0, '["1","12","11","2","(50 BFD)","4","3","50 RET","50 BFD","13"]'::jsonb, 1, 'mas:lydiahannahjamsinebintilukman'),
  ('Gold', 24, 'TSA-MSNT', 'MAS 217', 'MUHAMMAD IMRAN DANIAL BIN SHAHRIZ', 'M', 'MAS', 172.0, 148.0, '["15","14","(24)","23","23","9","24","18","10","12"]'::jsonb, 1, 'mas:muhammadimrandanialbinshahriz'),
  ('Gold', 25, 'PERLIS', 'MAS 281', 'MUHAMMAD NAWFAL BIN NORHISAM', 'M', 'MAS', 196.0, 154.0, '["17","22","8","13","19","25","8","14","28","(42)"]'::jsonb, 1, 'mas:muhammadnawfalbinnorhisam'),
  ('Gold', 26, 'KSA-MSNK', 'MAS 948', 'NUR IMAN SOFIA BINTI MOHD SHAZWAN', 'F', 'MAS', 199.0, 158.0, '["10","28","9","19","13","15","(41)","8","23","33"]'::jsonb, 1, 'mas:nurimansofiabintimohdshazwan'),
  ('Gold', 27, 'INDIA', 'IND 1819', 'VIRAT', 'M', 'IND', 209.0, 159.0, '["8","15","30","15","(50 DSQ)","50 DNC","17","3","13","8"]'::jsonb, 1, 'ind:virat'),
  ('Gold', 28, 'KSA-MSNK', 'MAS 931', 'MUHAMMAD AIMAN BIN MANGSOR', 'M', 'MAS', 193.0, 159.0, '["23","9","27","24","4","8","28","22","(34)","14"]'::jsonb, 1, 'mas:muhammadaimanbinmangsor'),
  ('Gold', 29, 'MYF', 'MYA 120', 'KAUNG KHANT KHANT THU', 'M', 'MYA', 209.0, 159.0, '["19","13","6","14","8","10","(50 BFD)","17","36","36"]'::jsonb, 1, 'mya:kaungkhantkhantthu'),
  ('Gold', 30, 'MSN PERAK', 'MAS 355', 'MUHAMMAD HIZMY QHALIF BIN MOHD HAFIZ', 'M', 'MAS', 205.0, 162.0, '["12","1","13","22","7","13","20","35","(43)","39"]'::jsonb, 1, 'mas:muhammadhizmyqhalifbinmohdhafiz'),
  ('Gold', 31, 'SAFYC', 'SGP 3128', 'CHIANG ZHIYI AARON', 'M', 'SGP', 221.0, 171.0, '["6","18","22","9","6","18","18","43","(50 BFD)","31"]'::jsonb, 1, 'sgp:chiangzhiyiaaron'),
  ('Gold', 32, 'MSN PERAK', 'MAS 351', 'NUR ASMA ATHIRAH BINTI MOHD SHAH', 'F', 'MAS', 228.0, 179.0, '["12","16","5","19","17","28","25","36","21","(49)"]'::jsonb, 1, 'mas:nurasmaathirahbintimohdshah'),
  ('Gold', 33, 'KSA-MSNK', 'MAS 934', 'SOFIYYAH HUSSEIN', 'F', 'MAS', 220.0, 182.0, '["16","9","15","30","14","26","23","21","(38)","28"]'::jsonb, 1, 'mas:sofiyyahhussein'),
  ('Gold', 34, 'MYF', 'MYA 383', 'GON YEE ZAW', 'F', 'MYA', 243.0, 193.0, '["36","19","20","30","9","17","(50 BFD)","11","11","40"]'::jsonb, 2, 'mya:gonyeezaw'),
  ('Gold', 35, 'SAFYC', 'SGP 3006', 'NICOLE WONG', 'F', 'SGP', 248.0, 198.0, '["20","11","22","16","18","12","(50 BFD)","40","16","43"]'::jsonb, 2, 'sgp:nicolewong'),
  ('Gold', 36, 'MYF', 'MYA 391', 'EAINT CHUE ZAY YAR', 'F', 'MYA', 237.0, 200.0, '["16","34","12","29","10","(37)","30","25","9","35"]'::jsonb, 2, 'mya:eaintchuezayyar'),
  ('Gold', 37, 'X-45', 'CHN 655', 'CHENYONGQI', 'M', 'CHN', 251.0, 201.0, '["(50 BFD)","14","29","10","12","11","14","50 DNE","40","21"]'::jsonb, 2, 'chn:chenyongqi'),
  ('Gold', 38, 'YRAT', 'THA 198', 'THIRAWAT HANKHAM', 'M', 'THA', 255.0, 208.0, '["33","8","21","7","11","35","36","24","33","(47)"]'::jsonb, 2, 'tha:thirawathankham'),
  ('Gold', 39, 'JSA', 'MAS 721', 'MOHAMAD IKHLAS REDZKI NAJIB BIN BOHANI', 'M', 'MAS', 261.0, 211.0, '["(50 BFD)","23","15","17","12","14","7","44","29","50 RET"]'::jsonb, 2, 'mas:mohamadikhlasredzkinajibbinbohani'),
  ('Gold', 40, 'SAFYC', 'SGP 3026', 'QI TAN', 'F', 'SGP', 261.0, 211.0, '["14","24","36","9","(50 BFD)","17","35","29","25","22"]'::jsonb, 2, 'sgp:qitan'),
  ('Gold', 41, 'MSP', 'MAS 787', 'AQIL RAYYAN RAMADHAN BIN MOHAMAD HASHIM', 'M', 'MAS', 261.0, 211.0, '["15","17","9","11","(50 BFD)","36","33","26","35","29"]'::jsonb, 2, 'mas:aqilrayyanramadhanbinmohamadhashim'),
  ('Gold', 42, 'JSA', 'MAS 724', 'RADZI RUZAIN BIN MOHD AZRUL', 'M', 'MAS', 258.0, 218.0, '["9","25","25","11","17","26","(40)","39","39","27"]'::jsonb, 2, 'mas:radziruzainbinmohdazrul'),
  ('Gold', 43, 'JSA', 'MAS 723', 'NUR QISYA QAISARAH BINTI MOHD RUZAINI', 'F', 'MAS', 257.0, 219.0, '["25","27","14","10","20","(38)","38","31","37","17"]'::jsonb, 2, 'mas:nurqisyaqaisarahbintimohdruzaini'),
  ('Gold', 44, 'MSN PENANG', 'MAS 555', 'MUHAMMAD NAFIS BIN AHMAD NAJMI', 'M', 'MAS', 284.0, 234.0, '["30","(50 DNF)","17","23","19","27","42","23","30","23"]'::jsonb, 2, 'mas:muhammadnafisbinahmadnajmi'),
  ('Gold', 45, 'JSA', 'MAS 725', 'ZAINAB BINTI MUHAMMAD NULHAKIM', 'F', 'MAS', 284.0, 234.0, '["11","(50 DNF)","31","16","16","25","29","30","42","34"]'::jsonb, 2, 'mas:zainabbintimuhammadnulhakim'),
  ('Gold', 46, 'TSA-MSNT', 'MAS 248', 'HAWA MAHIRAH MOHD HUSNI', 'F', 'MAS', 307.0, 257.0, '["24","(50 DNF)","12","21","27","15","34","45","31","48"]'::jsonb, 2, 'mas:hawamahirahmohdhusni'),
  ('Gold', 47, 'KSA-MSNK', 'MAS 947', 'MUHAMMAD HARRAZ FARHAN BIN AMZI', 'M', 'MAS', 312.0, 262.0, '["(50 BFD)","26","32","22","20","8","37","33","47","37"]'::jsonb, 2, 'mas:muhammadharrazfarhanbinamzi'),
  ('Gold', 48, 'KSA-MSNK', 'MAS 9022', 'MUHAMMAD ISKANDAR ZULQARNAIN', 'M', 'MAS', 315.0, 265.0, '["19","22","43","26","6","23","(50 BFD)","34","48","44"]'::jsonb, 2, 'mas:muhammadiskandarzulqarnain'),
  ('Gold', 49, 'MSN PENANG', 'MAS 554', 'NURFARHANA ATHIRAH BINTI KHAIRUL NIZAM', 'F', 'MAS', 312.0, 267.0, '["27","7","23","18","29","37","39","42","(45)","45"]'::jsonb, 2, 'mas:nurfarhanaathirahbintikhairulnizam'),
  ('Gold', 50, 'JSA', 'MAS 729', 'MUHAMMAD QHALIFF IMAN BIN MOHD ADILFITRI', 'M', 'MAS', 314.0, 268.0, '["21","20","18","20","21","31","43","50 DNE","44","(46)"]'::jsonb, 2, 'mas:muhammadqhaliffimanbinmohdadilfitri'),
  ('Silver', 1, 'X-45', 'CHN 669', 'YEJINYAN', 'F', 'CHN', 198.0, 148.0, '["29","15","33","25","(50 DNF)","23","15","3","3","2"]'::jsonb, 2, 'chn:yejinyan'),
  ('Silver', 2, 'MSN PERAK', 'MAS 345', 'ZAID BIN SHAIFUL FADZLI', 'M', 'MAS', 199.0, 153.0, '["26","19","45","(46)","26","5","11","14","4","3"]'::jsonb, 2, 'mas:zaidbinshaifulfadzli'),
  ('Silver', 3, 'X-45', 'CHN 645', 'WANGZHIYAO', 'M', 'CHN', 198.0, 156.0, '["31","21","(42)","37","22","13","19","2","2","9"]'::jsonb, 2, 'chn:wangzhiyao'),
  ('Silver', 4, 'SAFYC', 'SGP 3811', 'DAN TOH GUAN YOU', 'M', 'SGP', 222.0, 172.0, '["18","(50 DNF)","18","12","50 BFD","24","9","8","17","16"]'::jsonb, 2, 'sgp:dantohguanyou'),
  ('Silver', 5, 'WIPERS', '501', 'MOHAMMAD NUR ISKANDAR BIN MARWAN', 'M', NULL, 224.0, 174.0, '["(50 BFD)","50 DNF","24","18","33","20","1","7","6","15"]'::jsonb, 2, 'unk:mohammadnuriskandarbinmarwan'),
  ('Silver', 6, 'SABAH', 'MAS 1127', 'ANDRE BAOU MARTIN', 'M', 'MAS', 206.0, 174.0, '["23","27","30","(32)","22","31","3","23","7","8"]'::jsonb, 2, 'mas:andrebaoumartin'),
  ('Silver', 7, 'CTSA', '8601', 'HSU SHU-YA', 'F', NULL, 216.0, 179.0, '["24","13","(37)","35","25","28","14","4","25","11"]'::jsonb, 2, 'unk:hsushuya'),
  ('Silver', 8, 'TSA-MSNT', 'MAS 227', 'AHMAD IRFAN DANIAL BIN AHMAD ZULMA', 'M', 'MAS', 249.0, 199.0, '["(50 BFD)","20","13","21","50 BFD","22","2","16","49 UFD","6"]'::jsonb, 2, 'mas:ahmadirfandanialbinahmadzulma'),
  ('Silver', 9, 'MSN PERAK', 'MAS 354', 'AHMAD AKIL HAIKAL BIN MOHD SHAH', 'M', 'MAS', 255.0, 205.0, '["33","(50 DNF)","33","27","21","50 DNF","8","9","10","14"]'::jsonb, 2, 'mas:ahmadakilhaikalbinmohdshah'),
  ('Silver', 10, 'SAFYC', 'SGP 788', 'ASHLEIGH TEH LI YING', 'F', 'SGP', 242.0, 207.0, '["22","(35)","31","32","23","18","23","32","14","12"]'::jsonb, 2, 'sgp:ashleightehliying'),
  ('Silver', 11, 'SABAH', 'MAS 1038', 'AHMAD WAFIY AXZAM BIN MOHD RESAL', 'M', 'MAS', 258.0, 208.0, '["17","(50 DNF)","28","27","31","29","4","22","49 UFD","1"]'::jsonb, 2, 'mas:ahmadwafiyaxzambinmohdresal'),
  ('Silver', 12, 'KSA-MSNK', 'MAS 9023', 'MUHAMMAD ADAM FARINA BIN GUIDO FARINA', 'M', 'MAS', 265.0, 215.0, '["22","(50 DNF)","34","42","29","39","6","19","1","23"]'::jsonb, 2, 'mas:muhammadadamfarinabinguidofarina'),
  ('Silver', 13, 'MSN PENANG', 'MAS 559', 'MASRY BIN ABDULLAH', 'M', 'MAS', 269.0, 219.0, '["(50 BFD)","50 DNF","40","24","34","22","25","6","8","10"]'::jsonb, 2, 'mas:masrybinabdullah'),
  ('Silver', 14, 'MSP', 'MAS 757', 'ATIF RAYYAN ALAUDDIN BIN MOHAMAD HASHIM', 'M', 'MAS', 277.0, 227.0, '["30","(50 DNF)","38","34","36","35","12","5","20","17"]'::jsonb, 2, 'mas:atifrayyanalauddinbinmohamadhashim'),
  ('Silver', 15, 'SABAH', 'MAS 1139', 'MUHAMMAD FAIRUZ BIN MUHAMAD', 'M', 'MAS', 278.0, 229.0, '["42","30","39","28","15","27","10","31","(49 UFD)","7"]'::jsonb, 2, 'mas:muhammadfairuzbinmuhamad'),
  ('Silver', 16, 'WIPERS', 'MAS 111', 'NUR FARISYA SYAFIAH BINTI RODIE', 'F', 'MAS', 272.0, 233.0, '["(39)","32","29","39","32","30","20","12","12","27"]'::jsonb, 2, 'mas:nurfarisyasyafiahbintirodie'),
  ('Silver', 17, 'SABAH', 'MAS 1023', 'JAZEL QALISH BIN IZWANI HASDANIZAM', 'M', 'MAS', 290.0, 240.0, '["43","(50 DNF)","44","40","16","34","13","18","19","13"]'::jsonb, 2, 'mas:jazelqalishbinizwanihasdanizam'),
  ('Silver', 18, 'SAFYC', 'SGP 3575', 'YASIN YUSUF BIN YUSFIANSHAH', 'M', 'SGP', 289.0, 240.0, '["26","18","41","33","27","33","17","24","21","(49 DNF)"]'::jsonb, 2, 'sgp:yasinyusufbinyusfianshah'),
  ('Silver', 19, 'KSA-MSNK', 'MAS 920', 'MUHAMAD ADAM MUQRIS BIN SAMSADEN140125', 'M', 'MAS', 293.0, 243.0, '["36","(50 DNF)","16","50 BFD","3","21","18","1","49 UFD","49 BFD"]'::jsonb, 2, 'mas:muhamadadammuqrisbinsamsaden140125'),
  ('Silver', 20, 'PERLIS', 'MAS 201', 'AIDYL EUSOFF BIN LUKMAN', 'M', 'MAS', 299.0, 249.0, '["21","(50 BFD)","40","26","50 DNF","36","21","25","26","4"]'::jsonb, 3, 'mas:aidyleusoffbinlukman'),
  ('Silver', 21, 'MSN PERAK', 'MAS 376', 'HADQINA QASHYARA BINTI MUHAMAD ARIEF', 'F', 'MAS', 312.0, 262.0, '["35","(50 DNF)","37","38","34","40","5","13","11","49 BFD"]'::jsonb, 3, 'mas:hadqinaqashyarabintimuhamadarief'),
  ('Silver', 22, 'WIPERS', '502', 'AYSFA ZAHIRA BINTI NORASHIDDIN', 'F', NULL, 311.0, 262.0, '["28","28","28","39","38","34","24","20","23","(49 BFD)"]'::jsonb, 3, 'unk:aysfazahirabintinorashiddin'),
  ('Silver', 23, 'SAFYC', 'SGP 4712', 'KYAN TAN CHUN HONG', 'M', 'SGP', 313.0, 264.0, '["40","21","32","41","33","30","22","21","24","(49 DNF)"]'::jsonb, 3, 'sgp:kyantanchunhong'),
  ('Silver', 24, 'KELANTAN SAILING', 'MAS 865', 'MUHAMAD AL HAAQID B SHERI', 'M', 'MAS', 319.0, 269.0, '["27","31","26","31","(50 BFD)","33","32","15","49 UFD","25"]'::jsonb, 3, 'mas:muhamadalhaaqidbsheri'),
  ('Silver', 25, 'TSA-MSNT', 'MAS 245', 'MUHAMMAD AZIF NAQIB B. MUHAMMAD AZIZI', 'M', 'MAS', 319.0, 269.0, '["40","(50 DNF)","23","45","28","32","16","33","28","24"]'::jsonb, 3, 'mas:muhammadazifnaqibbmuhammadazizi'),
  ('Silver', 26, 'SABAH', 'MAS 1024', 'MARYAM BINTI RIYATUDIN', 'F', 'MAS', 321.0, 271.0, '["39","(50 DNF)","47","43","24","24","29","36","9","20"]'::jsonb, 3, 'mas:maryambintiriyatudin'),
  ('Silver', 27, 'TSA-MSNT', 'SGP 4648', 'WAN MUHAMMAD IMAN AL HAKIM BIN WAN KAMRO', 'M', 'SGP', 321.0, 271.0, '["28","(50 DNF)","34","34","50 DNF","44","33","11","18","19"]'::jsonb, 3, 'sgp:wanmuhammadimanalhakimbinwankamro'),
  ('Silver', 28, 'SAFYC', 'SGP 3739', 'CLARA NG SIEW NING', 'F', 'SGP', 321.0, 271.0, '["32","(50 DNF)","36","36","30","38","34","17","30","18"]'::jsonb, 3, 'sgp:clarangsiewning'),
  ('Silver', 29, 'SABAH', 'MAS 1138', 'MALIQUE ANAQI BIN MOHD NORHAIFIY', 'M', 'MAS', 328.0, 278.0, '["25","(50 DNF)","27","44","35","29","45","42","5","26"]'::jsonb, 3, 'mas:maliqueanaqibinmohdnorhaifiy'),
  ('Silver', 30, 'PERLIS', 'MAS 282', 'ADAM HAIDAR BIN MOHAMAD AQMAL HAKAM', 'M', 'MAS', 334.0, 284.0, '["41","(50 DNF)","25","43","24","32","38","28","31","22"]'::jsonb, 3, 'mas:adamhaidarbinmohamadaqmalhakam'),
  ('Silver', 31, 'KELANTAN SAILING', 'MAS 866', 'NUR ZAHRA BT MUHAMAD', 'F', 'MAS', 340.0, 290.0, '["32","25","41","29","37","(50 DNF)","31","30","16","49 DNF"]'::jsonb, 3, 'mas:nurzahrabtmuhamad'),
  ('Silver', 32, 'KSA-MSNK', 'MAS 932', 'MOHAMMAD AZRI BIN AMZI', 'M', 'MAS', 342.0, 292.0, '["29","(50 DNF)","42","42","26","19","7","29","49 RET","49 BFD"]'::jsonb, 3, 'mas:mohammadazribinamzi'),
  ('Silver', 33, 'SAFYC', 'SGP 3120', 'CHIANG ZIYI ADELE', 'F', 'SGP', 351.0, 301.0, '["37","(50 DNF)","21","31","50 DNF","50 DNC","37","41","13","21"]'::jsonb, 3, 'sgp:chiangziyiadele'),
  ('Silver', 34, 'MSN PENANG', 'MAS 557', 'MUHAMMAD ANIQ BIN MOHD ZAINURIHISAM', 'M', 'MAS', 352.0, 302.0, '["37","29","26","40","35","(50 DNF)","27","10","49 RET","49 BFD"]'::jsonb, 3, 'mas:muhammadaniqbinmohdzainurihisam'),
  ('Silver', 35, 'MSP', '767', 'NUR AQEELA BINTI MUHAMMAD ALBAR', 'F', NULL, 367.0, 317.0, '["31","(50 DNF)","35","33","50 DNF","47","30","27","15","49 DNF"]'::jsonb, 3, 'unk:nuraqeelabintimuhammadalbar'),
  ('Silver', 36, 'KSA-MSNK', 'MAS 9021', 'NUR ALISYA SOFIA BINTI MOHD NASROL', 'F', 'MAS', 384.0, 334.0, '["34","(50 DNF)","46","36","30","40","36","34","29","49 DNF"]'::jsonb, 3, 'mas:nuralisyasofiabintimohdnasrol'),
  ('Silver', 37, 'KSA-MSNK', '9024', 'AFFAN MIKHAIEL BIN AMIR WADY', 'M', NULL, 387.0, 337.0, '["34","(50 DNF)","38","35","50 DNF","42","28","39","22","49 DNF"]'::jsonb, 3, 'unk:affanmikhaielbinamirwady'),
  ('Silver', 38, 'SAFYC', 'SGP 3311', 'JAE TOH GUAN YU', 'M', 'SGP', 396.0, 346.0, '["42","(50 DNF)","45","46","50 DNF","45","42","35","36","5"]'::jsonb, 3, 'sgp:jaetohguanyu'),
  ('Silver', 39, 'MSP', '700', 'ISYQ DARYA KHALYSA BINTI MOHAMAD BASRI', 'F', NULL, 397.0, 347.0, '["43","(50 DNF)","35","38","32","50 DNF","41","26","33","49 DNF"]'::jsonb, 3, 'unk:isyqdaryakhalysabintimohamadbasri'),
  ('Silver', 40, 'SAFYC', 'SGP 3131', 'JADE TAN', 'F', 'SGP', 401.0, 351.0, '["38","33","46","37","(50 DNF)","50 DNF","26","37","35","49 DNF"]'::jsonb, 3, 'sgp:jadetan'),
  ('Silver', 41, 'KSA-MSNK', 'MAS 908', 'NUR HANI QHAISYARAH BINTI ABDUL SAID', 'F', 'MAS', 404.0, 354.0, '["38","24","48","41","(50 DNF)","43","39","40","32","49 DNF"]'::jsonb, 3, 'mas:nurhaniqhaisyarahbintiabdulsaid'),
  ('Silver', 42, 'TSA-MSNT', 'MAS 226', 'NUR ALISHA MARDHIYAH BINTI KHAIRUL ANUAR', 'F', 'MAS', 420.0, 370.0, '["35","(50 DNF)","47","48","37","41","40","46","27","49 DNF"]'::jsonb, 3, 'mas:nuralishamardhiyahbintikhairulanuar'),
  ('Silver', 43, 'TSA-MSNT', '04', 'MUHAMMAD AQEEF AMZAR BIN MOHD AZLAN', 'M', NULL, 431.0, 381.0, '["45","(50 DNF)","43","44","36","39","44","44","37","49 DNF"]'::jsonb, 3, 'unk:muhammadaqeefamzarbinmohdazlan'),
  ('Silver', 44, 'TSA-MSNT', 'MAS 11', 'WAN FISHA QISMINA BINTI WAN FADLI AZIZI', 'F', 'MAS', 438.0, 388.0, '["44","(50 DNF)","39","45","50 DNF","50 DNF","35","38","38","49 DNF"]'::jsonb, 3, 'mas:wanfishaqisminabintiwanfadliazizi'),
  ('Silver', 45, 'KSA-MSNK', '02', 'FARIS DANISH BIN ZULFADLI', 'M', NULL, 452.0, 402.0, '["41","(50 DNF)","44","47","50 DNF","46","43","43","39","49 DNF"]'::jsonb, 3, 'unk:farisdanishbinzulfadli'),
  ('Silver', 46, 'TSA-MSNT', 'MAS 246', 'DHIA RAIIHANAH BINTI ABDUL RAHIM', 'F', 'MAS', 466.0, 416.0, '["46","(50 DNF)","49","47","50 DNF","50 DNF","46","45","34","49 BFD"]'::jsonb, 3, 'mas:dhiaraiihanahbintiabdulrahim'),
  ('Silver', 47, 'PERLIS', 'MAS 68', 'AIDYL EIBRAHIM BIN LUKMAN', 'M', 'MAS', 496.0, 446.0, '["(50 DNF)","50 DNF","50 DNC","50 DNC","50 DNC","50 DNC","49 DNC","49 DNC","49 DNC","49 DNC"]'::jsonb, 3, 'mas:aidyleibrahimbinlukman'),
  ('Silver', 47, 'KELANTAN SAILING', 'MAS 6000', 'MUHD ISMA RIFQIE B MOHD RIDHWAN', 'M', 'MAS', 496.0, 446.0, '["(50 DNF)","50 DNF","50 DNC","50 DNC","50 DNC","50 DNC","49 DNC","49 DNC","49 DNC","49 DNC"]'::jsonb, 3, 'mas:muhdismarifqiebmohdridhwan'),
  ('Silver', 47, 'MSN SARAWAK', '1146', 'IZZ QAIREEN BINTI CHAIRULLAH', 'F', NULL, 496.0, 446.0, '["(50 DNF)","50 DNF","50 DNC","50 DNC","50 DNC","50 DNC","49 DNC","49 DNC","49 DNC","49 DNC"]'::jsonb, 3, 'unk:izzqaireenbintichairullah');

-- Retain the exact organiser result provenance in the Index ledger. Gold is
-- the published championship fleet that can contribute to the provisional
-- Index; Silver remains published in the main SailorPath result catalogue.
INSERT INTO public.asian_optimist_index_events (
  id, name, index_role, source_kind, host_country, host_noc, start_date,
  end_date, venue, official_results_url, official_results_source_name,
  sailorpath_regatta_slug, result_status, fleet_size, race_count,
  discard_count, is_eligible, created_at, updated_at
) VALUES (
  'lysc-2026-optimist-gold',
  '5th Langkawi International Youth Sailing Championship 2026 — Optimist Gold',
  'regional_qualifier', 'official_result', 'Malaysia', 'MAS',
  DATE '2026-06-24', DATE '2026-06-28', 'Langkawi, Kedah, Malaysia',
  'https://sailorpath.com/results/the-5th-lysc-2026-optimist-final.pdf', 'THE 5TH LYSC 2026 _ Optimist.pdf — final results issued 28 June 2026', 'langkawi-international-youth-sailing-championship-2026-optimist-gold', 'verified', 50, 10, 1,
  true, now(), now()
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  host_country = EXCLUDED.host_country,
  host_noc = EXCLUDED.host_noc,
  start_date = EXCLUDED.start_date,
  end_date = EXCLUDED.end_date,
  venue = EXCLUDED.venue,
  official_results_url = EXCLUDED.official_results_url,
  official_results_source_name = EXCLUDED.official_results_source_name,
  sailorpath_regatta_slug = EXCLUDED.sailorpath_regatta_slug,
  result_status = EXCLUDED.result_status,
  fleet_size = EXCLUDED.fleet_size,
  race_count = EXCLUDED.race_count,
  discard_count = EXCLUDED.discard_count,
  is_eligible = EXCLUDED.is_eligible,
  updated_at = now();

-- Add only Gold entrants to the Index identity ledger. Existing Index identity
-- aliases for Yaasin, Khairulilzani and Mia are preserved by the extractor.
INSERT INTO public.asian_optimist_index_sailors (
  id, identity_key, canonical_name, nationality, latest_sail_number, gender,
  match_status, created_at, updated_at
)
SELECT
  gen_random_uuid(), p.index_identity_key, p.source_name, p.source_nationality,
  p.source_sail_number,
  CASE upper(p.source_gender) WHEN 'FEMALE' THEN 'F' WHEN 'MALE' THEN 'M' ELSE p.source_gender END,
  'unmatched', now(), now()
FROM _lysc_2026_payload p
WHERE p.fleet = 'Gold'
ON CONFLICT (identity_key) DO UPDATE SET
  latest_sail_number = EXCLUDED.latest_sail_number,
  gender = COALESCE(public.asian_optimist_index_sailors.gender, EXCLUDED.gender),
  updated_at = now();

-- Prefer an existing verified Index profile for any Gold entrant. This catches
-- the conservative aliases described above before any name-only matching.
UPDATE _lysc_2026_payload p
SET sailor_id = a.sailor_id
FROM public.asian_optimist_index_sailors a
WHERE p.fleet = 'Gold'
  AND a.identity_key = p.index_identity_key
  AND a.sailor_id IS NOT NULL;

-- Exact normalized name + NOC remains the only automatic match for every other
-- result. Sail numbers are not used as an identity key.
WITH profile_candidates AS (
  SELECT
    s.id,
    regexp_replace(lower(s.name), '[^a-z0-9]', '', 'g') AS name_key,
    upper(trim(coalesce(s.nationality, ''))) AS nationality,
    count(*) OVER (
      PARTITION BY regexp_replace(lower(s.name), '[^a-z0-9]', '', 'g'),
      upper(trim(coalesce(s.nationality, '')))
    ) AS match_count
  FROM public.sailors s
)
UPDATE _lysc_2026_payload p
SET sailor_id = candidate.id
FROM profile_candidates candidate
WHERE p.sailor_id IS NULL
  AND p.source_nationality IS NOT NULL
  AND candidate.match_count = 1
  AND candidate.nationality = p.source_nationality
  AND candidate.name_key = regexp_replace(lower(p.source_name), '[^a-z0-9]', '', 'g');

-- Each remaining official entry receives a minimal, claimable public profile.
-- The deterministic import handle makes this safe to re-run and never changes
-- existing profiles or their supplied fields.
INSERT INTO public.sailors (
  id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  p.source_name,
  'lysc-' || lower(coalesce(nullif(p.source_nationality, ''), 'unk')) || '-' ||
    coalesce(
      nullif(left(trim(both '-' from regexp_replace(lower(p.source_name), '[^a-z0-9]+', '-', 'g')), 10), ''),
      'sailor'
    ) || '-' || substr(md5(p.index_identity_key), 1, 6),
  coalesce(nullif(regexp_replace(p.source_sail_number, '^[A-Z]{3}[[:space:]]*', ''), ''), 'N/A'),
  p.club,
  p.source_nationality,
  CASE upper(p.source_gender) WHEN 'FEMALE' THEN 'F' WHEN 'MALE' THEN 'M' ELSE NULL END,
  now(), now()
FROM _lysc_2026_payload p
WHERE p.sailor_id IS NULL
ON CONFLICT (handle) DO NOTHING;

UPDATE _lysc_2026_payload p
SET sailor_id = s.id
FROM public.sailors s
WHERE p.sailor_id IS NULL
  AND s.handle = (
    'lysc-' || lower(coalesce(nullif(p.source_nationality, ''), 'unk')) || '-' ||
      coalesce(
        nullif(left(trim(both '-' from regexp_replace(lower(p.source_name), '[^a-z0-9]+', '-', 'g')), 10), ''),
        'sailor'
      ) || '-' || substr(md5(p.index_identity_key), 1, 6)
  );

DO $verify_lysc_profiles$
DECLARE
  unresolved_profiles integer;
BEGIN
  SELECT count(*) INTO unresolved_profiles FROM _lysc_2026_payload WHERE sailor_id IS NULL;
  IF unresolved_profiles <> 0 THEN
    RAISE EXCEPTION 'LYSC import left % sailor profiles unresolved', unresolved_profiles;
  END IF;
END
$verify_lysc_profiles$;

UPDATE public.asian_optimist_index_sailors a
SET sailor_id = p.sailor_id,
    match_status = 'matched',
    updated_at = now()
FROM _lysc_2026_payload p
WHERE p.fleet = 'Gold'
  AND a.identity_key = p.index_identity_key
  AND a.sailor_id IS DISTINCT FROM p.sailor_id;

INSERT INTO public.regatta_events (
  id, name, slug, start_date, end_date, venue, organizer, classes, nor_url,
  registration_url, counts_for_ranking, is_selection_trial, schedule_summary,
  scoring_rules, created_at, updated_at
) VALUES (
  gen_random_uuid(),
  '5th Langkawi International Youth Sailing Championship 2026',
  'langkawi-international-youth-sailing-championship-2026', DATE '2026-06-24', DATE '2026-06-28',
  'Langkawi, Kedah, Malaysia',
  '5th Langkawi International Youth Sailing Championship Organising Authority',
  '["Optimist"]'::jsonb, NULL, NULL, false, false,
  'Official Optimist Gold and Silver final results are published on SailorPath from the supplied final result sheet.',
  'Appendix A low-point system; 10 races sailed and 1 discard applied in both fleets.',
  now(), now()
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, start_date = EXCLUDED.start_date, end_date = EXCLUDED.end_date,
  venue = EXCLUDED.venue, organizer = EXCLUDED.organizer, classes = EXCLUDED.classes,
  counts_for_ranking = false, is_selection_trial = false,
  schedule_summary = EXCLUDED.schedule_summary, scoring_rules = EXCLUDED.scoring_rules,
  updated_at = now();

WITH source_regattas (slug, name, division, fleet_size) AS (
  VALUES
    ('langkawi-international-youth-sailing-championship-2026-optimist-gold', '5th Langkawi International Youth Sailing Championship 2026 — Optimist Gold', 'Gold', 50),
    ('langkawi-international-youth-sailing-championship-2026-optimist-silver', '5th Langkawi International Youth Sailing Championship 2026 — Optimist Silver', 'Silver', 49)
)
INSERT INTO public.regattas (
  id, event_id, name, slug, date, end_date, total_fleet_size, division, race_count,
  geography, boat_class, counts_for_ranking, is_selection_trial, venue, organizer,
  official_results_url, official_results_source_name, schedule_notes, status,
  created_at, updated_at
)
SELECT
  gen_random_uuid(), e.id, source.name, source.slug, DATE '2026-06-24', DATE '2026-06-28',
  source.fleet_size, source.division, 10, 'MAS', 'Optimist', false, false,
  'Langkawi, Kedah, Malaysia',
  '5th Langkawi International Youth Sailing Championship Organising Authority',
  'https://sailorpath.com/results/the-5th-lysc-2026-optimist-final.pdf', 'THE 5TH LYSC 2026 _ Optimist.pdf — final results issued 28 June 2026',
  source.fleet_size::text || ' entries · 10 races · 1 discard · final organiser result supplied to SailorPath.',
  'published', now(), now()
FROM source_regattas source
JOIN public.regatta_events e ON e.slug = 'langkawi-international-youth-sailing-championship-2026'
ON CONFLICT (slug) DO UPDATE SET
  event_id = EXCLUDED.event_id, name = EXCLUDED.name, date = EXCLUDED.date,
  end_date = EXCLUDED.end_date, total_fleet_size = EXCLUDED.total_fleet_size,
  division = EXCLUDED.division, race_count = EXCLUDED.race_count, geography = EXCLUDED.geography,
  boat_class = EXCLUDED.boat_class, counts_for_ranking = false, is_selection_trial = false,
  venue = EXCLUDED.venue, organizer = EXCLUDED.organizer,
  official_results_url = EXCLUDED.official_results_url,
  official_results_source_name = EXCLUDED.official_results_source_name,
  schedule_notes = EXCLUDED.schedule_notes, status = 'published', updated_at = now();

DELETE FROM public.regatta_results
WHERE regatta_id IN (
  SELECT id FROM public.regattas WHERE slug IN ('langkawi-international-youth-sailing-championship-2026-optimist-gold', 'langkawi-international-youth-sailing-championship-2026-optimist-silver')
);

INSERT INTO public.regatta_results (
  id, sailor_id, entry_label, entry_sail_number, entry_type, regatta_id, rank,
  nett_score, total_score, is_dns, is_overseas_commitment, gender, birth_year,
  nationality, evidence_url, evidence_name, evidence_type, official_url,
  evidence_notes, verification_status, verified_at, created_at, updated_at
)
SELECT
  gen_random_uuid(), p.sailor_id, p.source_name, p.source_sail_number, 'individual',
  r.id, p.source_rank, p.nett_score, p.total_score, false, false,
  CASE upper(p.source_gender) WHEN 'FEMALE' THEN 'F' WHEN 'MALE' THEN 'M' ELSE NULL END,
  NULL, p.source_nationality, 'https://sailorpath.com/results/the-5th-lysc-2026-optimist-final.pdf', 'THE 5TH LYSC 2026 _ Optimist.pdf — final results issued 28 June 2026', 'pdf', 'https://sailorpath.com/results/the-5th-lysc-2026-optimist-final.pdf',
  'Imported from the visually reviewed final 5th Langkawi International Youth Sailing Championship 2026 Optimist result sheet.',
  'verified', now(), now(), now()
FROM _lysc_2026_payload p
JOIN public.regattas r
  ON r.slug = CASE p.fleet WHEN 'Gold' THEN 'langkawi-international-youth-sailing-championship-2026-optimist-gold' ELSE 'langkawi-international-youth-sailing-championship-2026-optimist-silver' END;

INSERT INTO public.regatta_result_participants (
  id, regatta_result_id, sailor_id, source_name, display_order, role, match_status,
  ranking_credit, created_at, updated_at
)
SELECT
  gen_random_uuid(), result.id, p.sailor_id, p.source_name, 0, 'solo', 'matched',
  false, now(), now()
FROM _lysc_2026_payload p
JOIN public.regattas r
  ON r.slug = CASE p.fleet WHEN 'Gold' THEN 'langkawi-international-youth-sailing-championship-2026-optimist-gold' ELSE 'langkawi-international-youth-sailing-championship-2026-optimist-silver' END
JOIN public.regatta_results result
  ON result.regatta_id = r.id
  AND result.sailor_id = p.sailor_id
  AND result.rank = p.source_rank
  AND result.entry_sail_number = p.source_sail_number;

INSERT INTO public.regatta_race_results (
  id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value,
  created_at, updated_at
)
SELECT
  gen_random_uuid(), result.id, token.ordinality::integer,
  nullif(regexp_replace(token.raw_value, '[^0-9.]', '', 'g'), '')::real,
  nullif((regexp_match(upper(regexp_replace(token.raw_value, '[()]', '', 'g')), '[0-9.]+[[:space:]]+([A-Z]+)'))[1], ''),
  token.raw_value LIKE '(%', token.raw_value, now(), now()
FROM _lysc_2026_payload p
JOIN public.regattas r
  ON r.slug = CASE p.fleet WHEN 'Gold' THEN 'langkawi-international-youth-sailing-championship-2026-optimist-gold' ELSE 'langkawi-international-youth-sailing-championship-2026-optimist-silver' END
JOIN public.regatta_results result
  ON result.regatta_id = r.id
  AND result.sailor_id = p.sailor_id
  AND result.rank = p.source_rank
  AND result.entry_sail_number = p.source_sail_number
CROSS JOIN LATERAL jsonb_array_elements_text(p.race_scores)
  WITH ORDINALITY AS token(raw_value, ordinality);

INSERT INTO public.asian_optimist_index_results (
  id, event_id, index_sailor_id, source_rank, source_sail_number, source_name,
  source_nationality, source_gender, source_birth_year, total_score, nett_score,
  race_scores, source_page, verification_status, created_at, updated_at
)
SELECT
  gen_random_uuid(), 'lysc-2026-optimist-gold', a.id, p.source_rank, p.source_sail_number,
  p.source_name, p.source_nationality,
  CASE upper(p.source_gender) WHEN 'FEMALE' THEN 'F' WHEN 'MALE' THEN 'M' ELSE p.source_gender END,
  NULL, p.total_score, p.nett_score, p.race_scores, p.source_page, 'verified', now(), now()
FROM _lysc_2026_payload p
JOIN public.asian_optimist_index_sailors a ON a.identity_key = p.index_identity_key
WHERE p.fleet = 'Gold'
ON CONFLICT (event_id, index_sailor_id) DO UPDATE SET
  source_rank = EXCLUDED.source_rank,
  source_sail_number = EXCLUDED.source_sail_number,
  source_name = EXCLUDED.source_name,
  source_nationality = EXCLUDED.source_nationality,
  source_gender = EXCLUDED.source_gender,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  race_scores = EXCLUDED.race_scores,
  source_page = EXCLUDED.source_page,
  verification_status = 'verified',
  updated_at = now();

DO $verify_lysc_import$
DECLARE
  gold_results integer;
  silver_results integer;
  participant_links integer;
  race_rows integer;
  index_rows integer;
BEGIN
  SELECT count(*) INTO gold_results
  FROM public.regatta_results result JOIN public.regattas r ON r.id = result.regatta_id
  WHERE r.slug = 'langkawi-international-youth-sailing-championship-2026-optimist-gold';
  SELECT count(*) INTO silver_results
  FROM public.regatta_results result JOIN public.regattas r ON r.id = result.regatta_id
  WHERE r.slug = 'langkawi-international-youth-sailing-championship-2026-optimist-silver';
  SELECT count(*) INTO participant_links
  FROM public.regatta_result_participants p
  JOIN public.regatta_results result ON result.id = p.regatta_result_id
  JOIN public.regattas r ON r.id = result.regatta_id
  WHERE r.slug IN ('langkawi-international-youth-sailing-championship-2026-optimist-gold', 'langkawi-international-youth-sailing-championship-2026-optimist-silver');
  SELECT count(*) INTO race_rows
  FROM public.regatta_race_results race
  JOIN public.regatta_results result ON result.id = race.regatta_result_id
  JOIN public.regattas r ON r.id = result.regatta_id
  WHERE r.slug IN ('langkawi-international-youth-sailing-championship-2026-optimist-gold', 'langkawi-international-youth-sailing-championship-2026-optimist-silver');
  SELECT count(*) INTO index_rows
  FROM public.asian_optimist_index_results WHERE event_id = 'lysc-2026-optimist-gold';

  IF gold_results <> 50 OR silver_results <> 49 OR participant_links <> 99
     OR race_rows <> 990 OR index_rows <> 50 THEN
    RAISE EXCEPTION 'LYSC import count mismatch: Gold %, Silver %, participants %, races %, Index %',
      gold_results, silver_results, participant_links, race_rows, index_rows;
  END IF;
END
$verify_lysc_import$;

COMMIT;
