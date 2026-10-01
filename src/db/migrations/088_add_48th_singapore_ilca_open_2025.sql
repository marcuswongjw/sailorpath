-- Screenshot-verified transcription of the 48th Singapore ILCA Open Championship 2025 results.
-- The two supplied Sailwave results sheets are marked provisional.
BEGIN;

INSERT INTO public.regatta_events (name,slug,start_date,end_date,venue,organizer,classes,nor_url,counts_for_ranking,is_selection_trial,created_at,updated_at)
VALUES ('48th Singapore ILCA Open Championship 2025','48th-singapore-ilca-open-2025','2025-12-06','2025-12-07','NSRCC Seasports Centre, 11 Changi Coast Walk, Singapore 499740','SAF Yacht Club','["ILCA 4","ILCA 6"]'::jsonb,'https://www.racingrulesofsailing.org/documents/12864/event?name=48th%2520Singapore%2520ILCA%2520Open',true,false,now(),now())
ON CONFLICT (slug) DO UPDATE SET name=excluded.name,start_date=excluded.start_date,end_date=excluded.end_date,venue=excluded.venue,organizer=excluded.organizer,classes=excluded.classes,nor_url=excluded.nor_url,updated_at=now();

INSERT INTO public.regattas (name,slug,date,end_date,boat_class,division,total_fleet_size,race_count,geography,counts_for_ranking,venue,organizer,nor_url,schedule_notes,status,event_id,created_at,updated_at)
SELECT '48th Singapore ILCA Open Championship 2025 (ILCA 6)','safyc-48th-singapore-ilca-open-ilca6-2025-12-06','2025-12-06','2025-12-07','ILCA 6','Open',19,7,'SG',true,'NSRCC Seasports Centre, 11 Changi Coast Walk, Singapore 499740','SAF Yacht Club','https://www.racingrulesofsailing.org/documents/12864/event?name=48th%2520Singapore%2520ILCA%2520Open','Seven races sailed; one discard. Supplied result sheet is marked provisional.','published',id,now(),now() FROM public.regatta_events WHERE slug='48th-singapore-ilca-open-2025'
ON CONFLICT (slug) DO UPDATE SET name=excluded.name,date=excluded.date,end_date=excluded.end_date,boat_class=excluded.boat_class,division=excluded.division,total_fleet_size=excluded.total_fleet_size,race_count=excluded.race_count,geography=excluded.geography,counts_for_ranking=excluded.counts_for_ranking,venue=excluded.venue,organizer=excluded.organizer,nor_url=excluded.nor_url,schedule_notes=excluded.schedule_notes,status=excluded.status,event_id=excluded.event_id,updated_at=now();

INSERT INTO public.regattas (name,slug,date,end_date,boat_class,division,total_fleet_size,race_count,geography,counts_for_ranking,venue,organizer,nor_url,schedule_notes,status,event_id,created_at,updated_at)
SELECT '48th Singapore ILCA Open Championship 2025 (ILCA 4)','safyc-48th-singapore-ilca-open-ilca4-2025-12-06','2025-12-06','2025-12-07','ILCA 4','Open',50,7,'SG',true,'NSRCC Seasports Centre, 11 Changi Coast Walk, Singapore 499740','SAF Yacht Club','https://www.racingrulesofsailing.org/documents/12864/event?name=48th%2520Singapore%2520ILCA%2520Open','Seven races sailed; one discard. Supplied result sheet is marked provisional.','published',id,now(),now() FROM public.regatta_events WHERE slug='48th-singapore-ilca-open-2025'
ON CONFLICT (slug) DO UPDATE SET name=excluded.name,date=excluded.date,end_date=excluded.end_date,boat_class=excluded.boat_class,division=excluded.division,total_fleet_size=excluded.total_fleet_size,race_count=excluded.race_count,geography=excluded.geography,counts_for_ranking=excluded.counts_for_ranking,venue=excluded.venue,organizer=excluded.organizer,nor_url=excluded.nor_url,schedule_notes=excluded.schedule_notes,status=excluded.status,event_id=excluded.event_id,updated_at=now();

CREATE TEMP TABLE _import48 (
  final_rank integer, sailor_name text, club_name text, sail_label text,
  race_scores jsonb, total_score real, nett_score real
 ) ON COMMIT DROP;
INSERT INTO _import48 VALUES
(1,'Leow You Shun Aurick','SAF Yacht Club','67','["(4.0)", "1.0", "1.0", "2.0", "1.0", "4.0", "1.0"]'::jsonb,14,10),
(2,'Eitan Oh','SAF Yacht Club','222743','["1.0", "2.0", "2.0", "1.0", "2.0", "3.0", "(5.0)"]'::jsonb,16,11),
(3,'Maia Lim Laurie','Changi Sailing Club','223201','["7.0", "3.0", "5.0", "4.0", "3.0", "2.0", "(20.0 DSQ)"]'::jsonb,44,24),
(4,'Gordon Alexander Allan','Others','221058','["3.0", "5.0", "(12.0)", "6.0", "8.0", "1.0", "2.0"]'::jsonb,37,25),
(5,'Gabi Oh','SAF Yacht Club','224717','["5.0", "4.0", "(6.0)", "3.0", "5.0", "5.0", "6.0"]'::jsonb,34,28),
(6,'Sarah Yong','Others','221689','["9.0", "9.0", "4.0", "5.0", "4.0", "(11.0)", "4.0"]'::jsonb,46,35),
(7,'Danielle Lai','Others','SGP 222257','["6.0", "(16.0)", "3.0", "8.0", "11.0", "6.0", "3.0"]'::jsonb,53,37),
(8,'Asher James Nair','Others','185201','["2.0", "6.0", "10.0", "(20.0 UFD)", "9.0", "7.0", "8.0"]'::jsonb,62,42),
(9,'Wong Kai Lun','Changi Sailing Club','227462','["8.0", "8.0", "8.0", "(11.0)", "6.0", "8.0", "10.0"]'::jsonb,59,48),
(10,'Seah Wei Jun Clive','SAF Yacht Club','SGP 214240','["12.0", "7.0", "13.0", "(20.0 UFD)", "7.0", "13.0", "12.0"]'::jsonb,84,64),
(11,'Jayden Teo','Others','214813','["10.0", "10.0", "(16.0)", "12.0", "15.0", "10.0", "7.0"]'::jsonb,80,64),
(12,'Rohit Behl','Changi Sailing Club','221931','["(16.0)", "14.0", "11.0", "7.0", "16.0", "9.0", "11.0"]'::jsonb,84,68),
(13,'Elizabeth Victoria Say','Others','SGP 214873','["(15.0)", "13.0", "9.0", "13.0", "13.0", "14.0", "9.0"]'::jsonb,86,71),
(14,'Josiah Tan Zhi En','One Degree 15','SGP 1978','["13.0", "(20.0 DNF)", "7.0", "10.0", "12.0", "16.0", "14.0"]'::jsonb,92,72),
(15,'Darren Lai','Others','SGP 222256','["(20.0 RET)", "15.0", "18.0", "15.0", "10.0", "12.0", "13.0"]'::jsonb,103,83),
(16,'Seah En Rui Cleo','SAF Yacht Club','SGP 224379','["14.0", "(17.0)", "14.0", "9.0", "14.0", "17.0", "17.0"]'::jsonb,102,85),
(17,'Sarfraz Ahmad Khan','SAF Yacht Club','AND 193871','["(17.0)", "11.0", "17.0", "14.0", "17.0", "15.0", "16.0"]'::jsonb,107,90),
(18,'Samuel Tan','Others','223134','["11.0", "12.0", "15.0", "(20.0 DNC)", "20.0 DNC", "20.0 DNC", "20.0 DNC"]'::jsonb,118,98),
(19,'Tan En Xi Arabelle','Others','SGP 221690','["18.0", "18.0", "(19.0)", "16.0", "18.0", "18.0", "15.0"]'::jsonb,122,103);
DO $$
DECLARE missing_count integer; bad_count integer;
BEGIN
  SELECT count(*) INTO missing_count FROM _import48 WHERE jsonb_array_length(race_scores)<>7;
  SELECT count(*) INTO bad_count FROM _import48 row WHERE
    (SELECT sum((regexp_match(score, '^\(?([0-9]+(?:\.[0-9]+)?)'))[1]::real) FROM jsonb_array_elements_text(row.race_scores) score) <> row.total_score
    OR (SELECT sum((regexp_match(score, '^\(?([0-9]+(?:\.[0-9]+)?)'))[1]::real) FROM jsonb_array_elements_text(row.race_scores) score WHERE score !~ '^\(') <> row.nett_score
    OR (SELECT count(*) FROM jsonb_array_elements_text(row.race_scores) score WHERE score ~ '^\(') <> 1;
  IF (SELECT count(*) FROM _import48) <> 19 OR missing_count<>0 OR bad_count<>0 THEN RAISE EXCEPTION 'Screenshot transcription validation failed: fleet %, bad %, expected competitors %', (SELECT count(*) FROM _import48), bad_count, 19; END IF;
END $$;

DELETE FROM public.regatta_results rr USING public.regattas r WHERE rr.regatta_id=r.id AND r.slug='safyc-48th-singapore-ilca-open-ilca6-2025-12-06';

DO $$
DECLARE row record; sailor_id uuid; result_id uuid; sail_no text; noc text; race text; score numeric; scode text; disc boolean; race_raw text; raw text;
BEGIN
  FOR row IN SELECT * FROM _import48 ORDER BY final_rank LOOP
    noc := CASE WHEN row.sail_label ~* '^(SGP|GER|FRA|AND) ' THEN upper(split_part(row.sail_label,' ',1)) ELSE NULL END;
    sail_no := CASE WHEN row.sail_label ~* '^(SGP|GER|FRA|AND) ' THEN substring(row.sail_label from position(' ' in row.sail_label)+1) ELSE row.sail_label END;
    SELECT id INTO sailor_id FROM public.sailors WHERE lower(trim(name))=lower(trim(row.sailor_name)) ORDER BY id LIMIT 1;
    IF sailor_id IS NULL THEN
      sailor_id:=gen_random_uuid();
      INSERT INTO public.sailors(id,name,handle,sail_number,club,nationality,created_at,updated_at) VALUES (sailor_id,row.sailor_name, left(regexp_replace(lower(row.sailor_name),'[^a-z0-9]+','-','g'),40)||'-'||substr(md5(lower(row.sailor_name)),1,6),sail_no,row.club_name,noc,now(),now());
    ELSE
      UPDATE public.sailors SET sail_number=COALESCE(NULLIF(sail_number,''),sail_no), club=COALESCE(NULLIF(club,''),row.club_name), nationality=COALESCE(nationality,noc), updated_at=now() WHERE id=sailor_id;
    END IF;
    SELECT id INTO result_id FROM public.regattas WHERE slug='safyc-48th-singapore-ilca-open-ilca6-2025-12-06';
    INSERT INTO public.regatta_results(id,sailor_id,regatta_id,rank,total_score,nett_score,is_dns,is_overseas_commitment,nationality,verification_status,evidence_name,evidence_type,evidence_notes,created_at,updated_at)
      VALUES(gen_random_uuid(),sailor_id,result_id,row.final_rank,row.total_score,row.nett_score,false,false,noc,'pending_review','ILCA 6 Final Results.pdf','pdf','Sailwave sheet marked provisional; transcribed from screenshot and arithmetic cross-checked.',now(),now()) RETURNING id INTO result_id;
    FOR race,score,scode,disc,race_raw IN
      SELECT ord::text, (regexp_match(value,'^\(?([0-9]+(?:\.[0-9]+)?)'))[1]::numeric, nullif((regexp_match(value,'\b(DSQ|UFD|DNF|DNC|RET|BFD)\b'))[1],''), value ~ '^\(', value
      FROM jsonb_array_elements_text(row.race_scores) WITH ORDINALITY item(value,ord)
    LOOP
      INSERT INTO public.regatta_race_results(id,regatta_result_id,race_number,score,raw_value,discarded,scoring_code,created_at,updated_at)
      VALUES(gen_random_uuid(),result_id,race::integer,score,race_raw,disc,scode,now(),now());
    END LOOP;
  END LOOP;
END $$;

DROP TABLE _import48;
CREATE TEMP TABLE _import48 (
  final_rank integer, sailor_name text, club_name text, sail_label text,
  race_scores jsonb, total_score real, nett_score real
 ) ON COMMIT DROP;
INSERT INTO _import48 VALUES
(1,'Ian Goh','Constant Wind','222713','["1.0", "1.0", "2.0", "(3.0)", "1.0", "1.0", "2.0"]'::jsonb,11,8),
(2,'Misa Lim Laurie','Changi Sailing Club','223202','["(13.0)", "2.0", "7.0", "8.0", "4.0", "2.0", "10.0"]'::jsonb,46,33),
(3,'Zeph Wan','SAF Yacht Club','SGP 226650','["(51.0 UFD)", "4.0", "4.0", "7.0", "3.0", "16.0", "1.0"]'::jsonb,86,35),
(4,'Wong Weikai Zachary','Others','SGP 221061','["5.0", "(18.0)", "3.0", "10.0", "13.0", "3.0", "3.0"]'::jsonb,55,37),
(5,'Nicholette Lee','Others','SGP 224620','["7.0", "3.0", "9.0", "5.0", "9.0", "(21.0)", "7.0"]'::jsonb,61,40),
(6,'Mika Tew','Others','SGP 219762','["2.0", "6.0", "8.0", "(26.0)", "8.0", "25.0", "5.0"]'::jsonb,80,54),
(7,'Mildred Wong Li Xuan','Others','SGP 223200','["15.0", "9.0", "6.0", "17.0", "(24.0)", "4.0", "6.0"]'::jsonb,81,57),
(8,'Caleb Peck','Others','SGP 225221','["3.0", "7.0", "13.0", "15.0", "7.0", "(20.0)", "17.0"]'::jsonb,82,62),
(9,'Wai Zhi Tong','SAF Yacht Club','SGP 225226','["8.0", "21.0", "(51.0 DNF)", "1.0", "22.0", "7.0", "4.0"]'::jsonb,114,63),
(10,'Jemima Chang','Others','214636','["10.0", "17.0", "17.0", "11.0", "2.0", "(18.0)", "8.0"]'::jsonb,83,65),
(11,'Yong Heng Yi','Changi Sailing Club','SGP 225259','["(35.0)", "5.0", "5.0", "21.0", "14.0", "9.0", "14.0"]'::jsonb,103,68),
(12,'Desiree Lee','Others','SGP 226897','["4.0", "22.0", "10.0", "4.0", "10.0", "(38.0)", "19.0"]'::jsonb,107,69),
(13,'Lim Yuk Jun','SAF Yacht Club','SGP 225182','["12.0", "10.0", "(51.0 UFD)", "12.0", "12.0", "8.0", "18.0"]'::jsonb,123,72),
(14,'Cao Zhihong Lucas','SAF Yacht Club','99','["6.0", "19.0", "(51.0 DNF)", "2.0", "19.0", "12.0", "15.0"]'::jsonb,124,73),
(15,'Lukas Kiesselbach','Changi Sailing Club','GER 221597','["(51.0 DNC)", "12.0", "1.0", "6.0", "31.0", "34.0", "12.0"]'::jsonb,147,96),
(16,'Wong Qi Ke Febe','SAF Yacht Club','SGP 225224','["(33.0)", "13.0", "15.0", "29.0", "5.0", "28.0", "9.0"]'::jsonb,132,99),
(17,'Julien Petracco','SAF Yacht Club','SGP 185201','["22.0", "32.0", "(51.0 UFD)", "13.0", "6.0", "15.0", "25.0"]'::jsonb,164,113),
(18,'Reyes Tan Jit Eng','SAF Yacht Club','SGP 214251','["(40.0)", "15.0", "11.0", "20.0", "32.0", "31.0", "13.0"]'::jsonb,162,122),
(19,'Travis Yeo','SAF Yacht Club','SGP 223728','["29.0", "11.0", "19.0", "(51.0 UFD)", "17.0", "26.0", "20.0"]'::jsonb,173,122),
(20,'Damien Huang','Others','97','["(42.0)", "29.0", "20.0", "14.0", "29.0", "10.0", "21.0"]'::jsonb,165,123),
(21,'Amandine Zoe Pitsilis','Changi Sailing Club','FRA 219725','["(30.0)", "8.0", "22.0", "25.0", "20.0", "19.0", "30.0"]'::jsonb,154,124),
(22,'Bu Ruiqiao','SAF Yacht Club','98','["38.0", "14.0", "(51.0 DNF)", "24.0", "11.0", "24.0", "29.0"]'::jsonb,191,140),
(23,'Jayden Bai','','225261','["21.0", "20.0", "14.0", "27.0", "(35.0)", "30.0", "31.0"]'::jsonb,178,143),
(24,'Joash Tan Jing En','One Degree 15','SGP 209051','["37.0", "31.0", "18.0", "36.0", "16.0", "6.0", "(51.0 DNC)"]'::jsonb,195,144),
(25,'Cecilia Kong','Changi Sailing Club','SGP 227678','["14.0", "(51.0 BFD)", "27.0", "23.0", "28.0", "13.0", "39.0"]'::jsonb,195,144),
(26,'Cory Loh Zhi Hang','SAF Yacht Club','226899','["17.0", "30.0", "(51.0 UFD)", "16.0", "26.0", "40.0", "22.0"]'::jsonb,202,151),
(27,'Nicholas Ng Jiang En','SAF Yacht Club','209042','["32.0", "23.0", "16.0", "22.0", "(40.0)", "23.0", "38.0"]'::jsonb,194,154),
(28,'Isaiah Yap Chor Hong','Changi Sailing Club','SGP 227463','["39.0", "(51.0 BFD)", "21.0", "9.0", "37.0", "11.0", "41.0"]'::jsonb,209,158),
(29,'James Kong','Others','212216','["31.0", "26.0", "29.0", "19.0", "34.0", "(39.0)", "23.0"]'::jsonb,201,162),
(30,'Charles Kong','Changi Sailing Club','SGP 227676','["20.0", "33.0", "(51.0 RET)", "28.0", "39.0", "32.0", "11.0"]'::jsonb,214,163),
(31,'Tang Kye','SAF Yacht Club','SGP 226900','["(51.0 UFD)", "16.0", "30.0", "33.0", "15.0", "42.0", "28.0"]'::jsonb,215,164),
(32,'Cao Zhixuan Caleb','SAF Yacht Club','225207','["25.0", "24.0", "(51.0 DNF)", "44.0", "27.0", "14.0", "33.0"]'::jsonb,218,167),
(33,'Jade Yeh','Changi Sailing Club','SGP 227609','["(34.0)", "27.0", "31.0", "32.0", "25.0", "22.0", "32.0"]'::jsonb,203,169),
(34,'Lee Rayson Yin Yi','SAF Yacht Club','SGP 217060','["26.0", "34.0", "25.0", "(43.0)", "33.0", "27.0", "27.0"]'::jsonb,215,172),
(35,'Ong Yong Jun Josh','SAF Yacht Club','SGP 217034','["23.0", "(51.0 BFD)", "51.0 UFD", "31.0", "30.0", "5.0", "34.0"]'::jsonb,225,174),
(36,'Callum Wong','Constant Wind','214748','["41.0", "(51.0 BFD)", "23.0", "37.0", "23.0", "17.0", "35.0"]'::jsonb,227,176),
(37,'Isla Lee','SAF Yacht Club','8','["9.0", "(51.0 DNF)", "51.0 RET", "30.0", "38.0", "36.0", "16.0"]'::jsonb,231,180),
(38,'Liao Zhiting','SAF Yacht Club','214760','["11.0", "28.0", "(51.0 DNF)", "38.0", "41.0", "29.0", "36.0"]'::jsonb,234,183),
(39,'Sim Gerome','SAF Yacht Club','SGP 4','["19.0", "(51.0 DNF)", "28.0", "41.0", "36.0", "37.0", "24.0"]'::jsonb,236,185),
(40,'Jonathan Kwok','','SGP 214808','["36.0", "(51.0 DNF)", "24.0", "39.0", "21.0", "44.0", "26.0"]'::jsonb,241,190),
(41,'Joshua Khoo','SAF Yacht Club','SGP 227677','["24.0", "25.0", "(51.0 DNF)", "18.0", "43.0", "41.0", "43.0"]'::jsonb,245,194),
(42,'Lucas Lim','SAF Yacht Club','SGP 185202','["27.0", "(51.0 RET)", "26.0", "40.0", "42.0", "33.0", "44.0"]'::jsonb,263,212),
(43,'Tan Yi Kai Kayden','SAF Yacht Club','SGP 197424','["16.0", "(51.0 DNF)", "12.0", "34.0", "51.0 DNC", "51.0 DNC", "51.0 DNC"]'::jsonb,266,215),
(44,'Yunosuke Ogawa','Constant Wind','SGP 214779','["28.0", "(51.0 DNF)", "51.0 UFD", "42.0", "44.0", "35.0", "37.0"]'::jsonb,288,237),
(45,'Cheow Mathias','SAF Yacht Club','SGP 225167','["43.0", "(51.0 RET)", "51.0 DNF", "35.0", "18.0", "51.0 UFD", "40.0"]'::jsonb,289,238),
(46,'Kate Yeh','Changi Sailing Club','SGP 222437','["18.0", "(51.0 BFD)", "51.0 UFD", "51.0 DNC", "51.0 DNC", "51.0 DNC", "51.0 DNC"]'::jsonb,324,273),
(47,'Jiayan Xu','SAF Yacht Club','SGP 224656','["(51.0 UFD)", "51.0 DNF", "51.0 DNF", "45.0", "45.0", "43.0", "45.0"]'::jsonb,331,280),
(48,'Alexander Choynowski de Lubicz','Constant Wind','CW 24','["(51.0 DNF)", "51.0 BFD", "51.0 DNF", "46.0", "46.0", "45.0", "42.0"]'::jsonb,332,281),
(49,'Tomas Agea Maxin','Others','73','["(51.0 DNC)", "51.0 DNC", "51.0 DNF", "51.0 DNC", "47.0", "51.0 DNC", "51.0 DNC"]'::jsonb,353,302),
(50,'Angela Huang Fei''Er','SAF Yacht Club','SGP 213191','["(51.0 DNC)", "51.0 DNC", "51.0 DNF", "51.0 DNC", "51.0 DNC", "51.0 DNC", "51.0 DNC"]'::jsonb,357,306);
DO $$
DECLARE missing_count integer; bad_count integer;
BEGIN
  SELECT count(*) INTO missing_count FROM _import48 WHERE jsonb_array_length(race_scores)<>7;
  SELECT count(*) INTO bad_count FROM _import48 row WHERE
    (SELECT sum((regexp_match(score, '^\(?([0-9]+(?:\.[0-9]+)?)'))[1]::real) FROM jsonb_array_elements_text(row.race_scores) score) <> row.total_score
    OR (SELECT sum((regexp_match(score, '^\(?([0-9]+(?:\.[0-9]+)?)'))[1]::real) FROM jsonb_array_elements_text(row.race_scores) score WHERE score !~ '^\(') <> row.nett_score
    OR (SELECT count(*) FROM jsonb_array_elements_text(row.race_scores) score WHERE score ~ '^\(') <> 1;
  IF (SELECT count(*) FROM _import48) <> 50 OR missing_count<>0 OR bad_count<>0 THEN RAISE EXCEPTION 'Screenshot transcription validation failed: fleet %, bad %, expected competitors %', (SELECT count(*) FROM _import48), bad_count, 50; END IF;
END $$;

DELETE FROM public.regatta_results rr USING public.regattas r WHERE rr.regatta_id=r.id AND r.slug='safyc-48th-singapore-ilca-open-ilca4-2025-12-06';

DO $$
DECLARE row record; sailor_id uuid; result_id uuid; sail_no text; noc text; race text; score numeric; scode text; disc boolean; race_raw text;
BEGIN
  FOR row IN SELECT * FROM _import48 ORDER BY final_rank LOOP
    noc := CASE WHEN row.sail_label ~* '^(SGP|GER|FRA|AND) ' THEN upper(split_part(row.sail_label,' ',1)) ELSE NULL END;
    sail_no := CASE WHEN row.sail_label ~* '^(SGP|GER|FRA|AND) ' THEN substring(row.sail_label from position(' ' in row.sail_label)+1) ELSE row.sail_label END;
    SELECT id INTO sailor_id FROM public.sailors WHERE lower(trim(name))=lower(trim(row.sailor_name)) ORDER BY id LIMIT 1;
    IF sailor_id IS NULL THEN
      sailor_id:=gen_random_uuid();
      INSERT INTO public.sailors(id,name,handle,sail_number,club,nationality,created_at,updated_at) VALUES (sailor_id,row.sailor_name, left(regexp_replace(lower(row.sailor_name),'[^a-z0-9]+','-','g'),40)||'-'||substr(md5(lower(row.sailor_name)),1,6),sail_no,row.club_name,noc,now(),now());
    ELSE
      UPDATE public.sailors SET sail_number=COALESCE(NULLIF(sail_number,''),sail_no), club=COALESCE(NULLIF(club,''),row.club_name), nationality=COALESCE(nationality,noc), updated_at=now() WHERE id=sailor_id;
    END IF;
    SELECT id INTO result_id FROM public.regattas WHERE slug='safyc-48th-singapore-ilca-open-ilca4-2025-12-06';
    INSERT INTO public.regatta_results(id,sailor_id,regatta_id,rank,total_score,nett_score,is_dns,is_overseas_commitment,nationality,verification_status,evidence_name,evidence_type,evidence_notes,created_at,updated_at)
      VALUES(gen_random_uuid(),sailor_id,result_id,row.final_rank,row.total_score,row.nett_score,false,false,noc,'pending_review','ILCA4 Final Results.pdf','pdf','Sailwave sheet marked provisional; transcribed from screenshot and arithmetic cross-checked.',now(),now()) RETURNING id INTO result_id;
    FOR race,score,scode,disc,race_raw IN
      SELECT ord::text, (regexp_match(value,'^\(?([0-9]+(?:\.[0-9]+)?)'))[1]::numeric, nullif((regexp_match(value,'\b(DSQ|UFD|DNF|DNC|RET|BFD)\b'))[1],''), value ~ '^\(', value
      FROM jsonb_array_elements_text(row.race_scores) WITH ORDINALITY item(value,ord)
    LOOP
      INSERT INTO public.regatta_race_results(id,regatta_result_id,race_number,score,raw_value,discarded,scoring_code,created_at,updated_at)
      VALUES(gen_random_uuid(),result_id,race::integer,score,race_raw,disc,scode,now(),now());
    END LOOP;
  END LOOP;
END $$;

DROP TABLE _import48;
COMMIT;
