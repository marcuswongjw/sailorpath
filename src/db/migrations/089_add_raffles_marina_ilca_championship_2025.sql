-- Screenshot-first transcription of Raffles Marina ILCA Championship 2025 overall results.
-- Screenshots visually checked; race totals, nett scores, and discards reconciled.
BEGIN;

INSERT INTO public.regatta_events (name,slug,start_date,end_date,venue,organizer,classes,nor_url,registration_url,counts_for_ranking,is_selection_trial,created_at,updated_at)
VALUES ('Raffles Marina ILCA Championship 2025','raffles-marina-ilca-championship-2025','2025-11-08','2025-11-09','Raffles Marina, 10 Tuas West Drive, Singapore 638404','Raffles Marina','["ILCA 7","ILCA 6","ILCA 4"]'::jsonb,'https://www.racingrulesofsailing.org/documents/11648/event','https://forms.gle/UnEEirfQvhnMowaR8',true,false,now(),now())
ON CONFLICT (slug) DO UPDATE SET name=excluded.name,start_date=excluded.start_date,end_date=excluded.end_date,venue=excluded.venue,organizer=excluded.organizer,classes=excluded.classes,nor_url=excluded.nor_url,registration_url=excluded.registration_url,updated_at=now();

INSERT INTO public.regattas (name,slug,date,end_date,boat_class,division,total_fleet_size,race_count,geography,counts_for_ranking,is_selection_trial,venue,organizer,nor_url,registration_url,schedule_notes,status,event_id,created_at,updated_at)
SELECT 'Raffles Marina ILCA Championship 2025 (ILCA 4)','raffles-marina-ilca-nov-25-4-2025-11-08','2025-11-08','2025-11-09','ILCA 4','Open',43,8,'SG',true,false,'Raffles Marina, 10 Tuas West Drive, Singapore 638404','Raffles Marina','https://www.racingrulesofsailing.org/documents/11648/event','https://forms.gle/UnEEirfQvhnMowaR8','Eight races sailed; one discard. Official overall result sheet.', 'published',id,now(),now() FROM public.regatta_events WHERE slug='raffles-marina-ilca-championship-2025'
ON CONFLICT (slug) DO UPDATE SET name=excluded.name,date=excluded.date,end_date=excluded.end_date,boat_class=excluded.boat_class,division=excluded.division,total_fleet_size=excluded.total_fleet_size,race_count=excluded.race_count,geography=excluded.geography,counts_for_ranking=excluded.counts_for_ranking,is_selection_trial=excluded.is_selection_trial,venue=excluded.venue,organizer=excluded.organizer,nor_url=excluded.nor_url,registration_url=excluded.registration_url,schedule_notes=excluded.schedule_notes,status=excluded.status,event_id=excluded.event_id,updated_at=now();

INSERT INTO public.regattas (name,slug,date,end_date,boat_class,division,total_fleet_size,race_count,geography,counts_for_ranking,is_selection_trial,venue,organizer,nor_url,registration_url,schedule_notes,status,event_id,created_at,updated_at)
SELECT 'Raffles Marina ILCA Championship 2025 (ILCA 6)','raffles-marina-ilca-nov-25-6-2025-11-08','2025-11-08','2025-11-09','ILCA 6','Open',16,8,'SG',true,false,'Raffles Marina, 10 Tuas West Drive, Singapore 638404','Raffles Marina','https://www.racingrulesofsailing.org/documents/11648/event','https://forms.gle/UnEEirfQvhnMowaR8','Eight races sailed; one discard. Official overall result sheet.', 'published',id,now(),now() FROM public.regatta_events WHERE slug='raffles-marina-ilca-championship-2025'
ON CONFLICT (slug) DO UPDATE SET name=excluded.name,date=excluded.date,end_date=excluded.end_date,boat_class=excluded.boat_class,division=excluded.division,total_fleet_size=excluded.total_fleet_size,race_count=excluded.race_count,geography=excluded.geography,counts_for_ranking=excluded.counts_for_ranking,is_selection_trial=excluded.is_selection_trial,venue=excluded.venue,organizer=excluded.organizer,nor_url=excluded.nor_url,registration_url=excluded.registration_url,schedule_notes=excluded.schedule_notes,status=excluded.status,event_id=excluded.event_id,updated_at=now();

CREATE TEMP TABLE _raffles_import (boat_class text, final_rank integer, sailor_name text, identity_name text, sail_label text, gender text, race_scores jsonb, total_score real, nett_score real) ON COMMIT DROP;
INSERT INTO _raffles_import VALUES
('ILCA 4',1,'Ian Goh','Ian Goh','222713','M','["3.0", "8.0", "1.0", "2.0", "2.0", "(17.0)", "9.0", "2.0"]'::jsonb,44,27),
('ILCA 4',2,'Nigel Tan Xu Yuan','Nigel Tan Xu Yuan','225176','M','["5.0", "9.0", "(16.0)", "1.0", "11.0", "1.0", "1.0", "1.0"]'::jsonb,45,29),
('ILCA 4',3,'Austin Yeo Jia Le','Austin Yeo Jia Le','221062','M','["8.0", "1.0", "3.0", "3.0", "3.0", "12.0", "(13.0)", "5.0"]'::jsonb,48,35),
('ILCA 4',4,'Nia Zahedi','Nia Zahedi','224245','F','["7.0", "4.0", "7.0", "9.0", "6.0", "(11.0)", "5.0", "3.0"]'::jsonb,52,41),
('ILCA 4',5,'Zeph Wan','Zeph Wan','226650','M','["4.0", "2.0", "6.0", "6.0", "12.0", "2.0", "11.0", "(18.0)"]'::jsonb,61,43),
('ILCA 4',6,'Wong Weikai Zachary','Wong Weikai Zachary','221061','M','["2.0", "3.0", "2.0", "5.0", "15.0", "9.0", "(16.0)", "15.0"]'::jsonb,67,51),
('ILCA 4',7,'Mika Tew','Mika Tew','219762','F','["11.0", "14.0", "(20.0)", "4.0", "10.0", "3.0", "4.0", "19.0"]'::jsonb,85,65),
('ILCA 4',8,'Lukas Kiesselbach','Lukas Kiesselbach','GER 221597','M','["16.0", "(20.0)", "18.0", "7.0", "5.0", "10.0", "3.0", "12.0"]'::jsonb,91,71),
('ILCA 4',9,'Misa Lim Laurie','Misa Lim Laurie','223202','F','["19.0", "7.0", "4.0", "12.0", "(26.0)", "15.0", "10.0", "6.0"]'::jsonb,99,73),
('ILCA 4',10,'Caleb Peck','Caleb Peck','225221','M','["13.0", "12.0", "10.0", "17.0", "(24.0)", "7.0", "17.0", "4.0"]'::jsonb,104,80),
('ILCA 4',11,'Wong Kai Lun','Wong Kai Lun','214779','M','["10.0", "5.0", "5.0", "8.0", "(29.0)", "22.0", "23.0", "10.0"]'::jsonb,112,83),
('ILCA 4',12,'Amandine Zoe Pitsilis','Amandine Zoe Pitsilis','FRA 219725','F','["20.0", "13.0", "(22.0)", "13.0", "13.0", "4.0", "7.0", "14.0"]'::jsonb,106,84),
('ILCA 4',13,'Jemima Chang','Jemima Chang','214636','F','["6.0", "18.0", "17.0", "10.0", "19.0", "(32.0)", "8.0", "8.0"]'::jsonb,118,86),
('ILCA 4',14,'Isla Lee','Isla Lee','8','F','["15.0", "17.0", "14.0", "16.0", "(22.0)", "5.0", "6.0", "21.0"]'::jsonb,116,94),
('ILCA 4',15,'Wai Zhi Tong','Wai Zhi Tong','225226','F','["9.0", "6.0", "23.0", "24.0", "1.0", "20.0", "12.0", "(33.0)"]'::jsonb,128,95),
('ILCA 4',16,'Febe Wong Qi Ke','Febe Wong Qi Ke','225224','F','["36.0", "10.0", "(38.0)", "20.0", "7.0", "13.0", "15.0", "9.0"]'::jsonb,148,110),
('ILCA 4',17,'Desiree Lee','Desiree Lee','226897','F','["1.0", "25.0", "(27.0)", "23.0", "25.0", "8.0", "14.0", "22.0"]'::jsonb,145,118),
('ILCA 4',18,'Cory Loh Zhi Hang','Cory Loh Zhi Hang','87','M','["24.0", "(28.0)", "8.0", "22.0", "17.0", "24.0", "2.0", "24.0"]'::jsonb,149,121),
('ILCA 4',19,'Lim Yuk Jun','Lim Yuk Jun','225182','M','["17.0", "22.0", "13.0", "(26.0)", "18.0", "18.0", "18.0", "16.0"]'::jsonb,148,122),
('ILCA 4',20,'Wong Li Xuan Mildred','Mildred Wong Li Xuan','223200','F','["31.0", "15.0", "(33.0)", "21.0", "4.0", "25.0", "19.0", "13.0"]'::jsonb,161,128),
('ILCA 4',21,'Ong Yong Jun Josh','Ong Yong Jun Josh','217034','M','["23.0", "27.0", "12.0", "25.0", "21.0", "(37.0)", "20.0", "11.0"]'::jsonb,176,139),
('ILCA 4',22,'Yeh Zi Ning Kate','Kate Yeh','222437','F','["25.0", "34.0", "15.0", "30.0", "8.0", "27.0", "(38.0)", "7.0"]'::jsonb,184,146),
('ILCA 4',23,'Joash Tan','Joash Tan','209051','M','["14.0", "11.0", "11.0", "19.0", "32.0", "28.0", "(44.0 RET)", "36.0"]'::jsonb,195,151),
('ILCA 4',24,'Nicholas Ng Jiang En','Nicholas Ng Jiang En','209042','M','["12.0", "21.0", "(35.0)", "27.0", "23.0", "16.0", "29.0", "35.0"]'::jsonb,198,163),
('ILCA 4',25,'Reyes Tan Jit Eng','Reyes Tan Jit Eng','214251','M','["21.0", "30.0", "(32.0)", "15.0", "20.0", "26.0", "25.0", "30.0"]'::jsonb,199,167),
('ILCA 4',26,'Charles Kong','Charles Kong','227676','M','["27.0", "26.0", "29.0", "(44.0 RET)", "14.0", "33.0", "26.0", "17.0"]'::jsonb,216,172),
('ILCA 4',27,'Jayden Zi Xi Bai','Jayden Zi Xi Bai','225261','M','["18.0", "19.0", "9.0", "(44.0 RET)", "40.0", "36.0", "24.0", "27.0"]'::jsonb,217,173),
('ILCA 4',28,'Jade Yeh','Jade Yeh','227609','F','["29.0", "35.0", "24.0", "28.0", "(37.0)", "6.0", "31.0", "23.0"]'::jsonb,213,176),
('ILCA 4',29,'Germaine Sim','Germaine Sim','SGP 4','F','["22.0", "16.0", "25.0", "36.0", "36.0", "14.0", "27.0", "(41.0)"]'::jsonb,217,176),
('ILCA 4',30,'Isaiah Yap Chor Hong','Isaiah Yap Chor Hong','227463','M','["26.0", "31.0", "26.0", "18.0", "28.0", "23.0", "(37.0)", "26.0"]'::jsonb,215,178),
('ILCA 4',31,'James Kong','James Kong','212216','M','["(40.0)", "32.0", "21.0", "14.0", "39.0", "30.0", "28.0", "28.0"]'::jsonb,232,192),
('ILCA 4',32,'Rayson Lee Yin Yi','Rayson Lee Yin Yi','217060','M','["32.0", "23.0", "31.0", "11.0", "(38.0)", "35.0", "32.0", "38.0"]'::jsonb,240,202),
('ILCA 4',33,'Caleb Cao Zhixuan','Caleb Zhixuan Cao','225207','M','["30.0", "33.0", "30.0", "29.0", "33.0", "19.0", "(36.0)", "29.0"]'::jsonb,239,203),
('ILCA 4',34,'Liao ZhiTing','Liao ZhiTing','214760','M','["35.0", "29.0", "(37.0)", "31.0", "27.0", "29.0", "21.0", "34.0"]'::jsonb,243,206),
('ILCA 4',35,'Cecilia Kong','Cecilia Kong','227678','F','["28.0", "24.0", "36.0", "35.0", "35.0", "(38.0)", "22.0", "31.0"]'::jsonb,249,211),
('ILCA 4',36,'Mathias Cheow','Mathias Cheow','225167','M','["37.0", "(40.0)", "40.0", "38.0", "9.0", "21.0", "33.0", "39.0"]'::jsonb,257,217),
('ILCA 4',37,'Travis Yeo Jia Le','Travis Yeo','223728','M','["(39.0)", "36.0", "19.0", "33.0", "34.0", "34.0", "30.0", "32.0"]'::jsonb,257,218),
('ILCA 4',38,'Callum Wong Joon Thang','Callum Wong','214748','M','["34.0", "(37.0)", "34.0", "34.0", "16.0", "31.0", "34.0", "37.0"]'::jsonb,257,220),
('ILCA 4',39,'Kye Tang','Kye Tang','226900','M','["33.0", "39.0", "28.0", "32.0", "30.0", "39.0", "(44.0 RET)", "20.0"]'::jsonb,265,221),
('ILCA 4',40,'Jiayan Xu','Jiayan Xu','224656','M','["(41.0)", "41.0", "41.0", "39.0", "31.0", "41.0", "35.0", "25.0"]'::jsonb,294,253),
('ILCA 4',41,'Gerome Sim','Gerome Sim','77','M','["38.0", "38.0", "39.0", "37.0", "(44.0 DNC)", "40.0", "39.0", "40.0"]'::jsonb,315,271),
('ILCA 4',42,'Yong Heng Yi','Yong Heng Yi','225259','M','["(44.0 DNC)", "44.0 DNC", "44.0 DNC", "44.0 DNC", "44.0 DNC", "44.0 DNC", "44.0 DNC", "44.0 DNC"]'::jsonb,352,308),
('ILCA 4',42,'Alaric Naidu','Alaric Naidu','170299','M','["(44.0 DNC)", "44.0 DNC", "44.0 DNC", "44.0 DNC", "44.0 DNC", "44.0 DNC", "44.0 DNC", "44.0 DNC"]'::jsonb,352,308),
('ILCA 6',1,'Aurick Leow You Shun','Aurick Leow You Shun','67','M','["1.0", "1.0", "1.0", "1.0", "1.0", "1.0", "(4.0)", "1.0"]'::jsonb,11,7),
('ILCA 6',2,'Gabi Oh','Gabi Oh','224717','F','["3.0", "4.0", "5.0", "3.0", "4.0", "2.0", "3.0", "(8.0)"]'::jsonb,32,24),
('ILCA 6',3,'Eitan Oh','Eitan Oh','222743','M','["2.0", "5.0", "7.0", "(8.0)", "2.0", "3.0", "1.0", "7.0"]'::jsonb,35,27),
('ILCA 6',4,'Sarah Yong','Sarah Yong','18','F','["8.0", "7.0", "6.0", "(13.0)", "3.0", "8.0", "2.0", "2.0"]'::jsonb,49,36),
('ILCA 6',5,'Gordon Alexander Allan','Gordon Alexander Allan','221058','M','["7.0", "(12.0)", "3.0", "7.0", "5.0", "4.0", "6.0", "6.0"]'::jsonb,50,38),
('ILCA 6',6,'Danielle Lai','Danielle Lai','222257','F','["6.0", "2.0", "9.0", "(10.0)", "8.0", "5.0", "8.0", "4.0"]'::jsonb,52,42),
('ILCA 6',7,'Foo Yue Ji','Yuei Jit Foo','221686','M','["5.0", "6.0", "2.0", "5.0", "(11.0)", "10.0", "10.0", "11.0"]'::jsonb,60,49),
('ILCA 6',8,'Josiah Tan','Josiah Tan','1978','M','["(13.0)", "3.0", "13.0", "4.0", "10.0", "6.0", "7.0", "10.0"]'::jsonb,66,53),
('ILCA 6',9,'Darren Lai','Darren Lai','222256','M','["9.0", "10.0", "11.0", "2.0", "(12.0)", "11.0", "9.0", "3.0"]'::jsonb,67,55),
('ILCA 6',10,'Jayden Teo','Jayden Teo','214813','M','["11.0", "8.0", "8.0", "6.0", "7.0", "9.0", "(13.0)", "9.0"]'::jsonb,71,58),
('ILCA 6',11,'Ho Jian Yi, Jonathan','Ho Jian Yi, Jonathan','214848','M','["12.0", "(13.0)", "12.0", "9.0", "9.0", "7.0", "5.0", "5.0"]'::jsonb,72,59),
('ILCA 6',12,'Samuel Tan','Samuel Tan','223134','M','["4.0", "(17.0 RET)", "4.0", "11.0", "17.0 RET", "17.0 DNS", "12.0", "12.0"]'::jsonb,94,77),
('ILCA 6',13,'Elizabeth Victoria Say','Elizabeth Victoria Say','214873','F','["10.0", "11.0", "(14.0)", "12.0", "6.0", "13.0", "11.0", "14.0"]'::jsonb,91,77),
('ILCA 6',14,'Wong Yu Da Mathias','Mathias Yu Da Wong','222255','M','["(14.0)", "9.0", "10.0", "14.0", "13.0", "12.0", "14.0", "13.0"]'::jsonb,99,85),
('ILCA 6',15,'Abigail Ling','Abigail Jia En Ling','204636','F','["(17.0 DNC)", "17.0 DNC", "17.0 DNC", "17.0 DNC", "17.0 DNC", "17.0 DNC", "17.0 DNC", "17.0 DNC"]'::jsonb,136,119),
('ILCA 6',15,'Maia Lim Laurie','Maia Lim Laurie','223201','F','["(17.0 DNC)", "17.0 DNC", "17.0 DNC", "17.0 DNC", "17.0 DNC", "17.0 DNC", "17.0 DNC", "17.0 DNC"]'::jsonb,136,119);
DO $$
DECLARE bad_count integer;
BEGIN
  SELECT count(*) INTO bad_count FROM _raffles_import row WHERE jsonb_array_length(race_scores)<>8
    OR (SELECT sum((regexp_match(score, '^\(?([0-9]+(?:\.[0-9]+)?)'))[1]::real) FROM jsonb_array_elements_text(row.race_scores) score)<>row.total_score
    OR (SELECT sum((regexp_match(score, '^\(?([0-9]+(?:\.[0-9]+)?)'))[1]::real) FROM jsonb_array_elements_text(row.race_scores) score WHERE score !~ '^\(')<>row.nett_score
    OR (SELECT count(*) FROM jsonb_array_elements_text(row.race_scores) score WHERE score ~ '^\(')<>1;
  IF (SELECT count(*) FROM _raffles_import WHERE boat_class='ILCA 4')<>43 OR (SELECT count(*) FROM _raffles_import WHERE boat_class='ILCA 6')<>16 OR bad_count<>0 THEN RAISE EXCEPTION 'Raffles ILCA screenshot import validation failed: bad rows %, ILCA4 %, ILCA6 %', bad_count,(SELECT count(*) FROM _raffles_import WHERE boat_class='ILCA 4'),(SELECT count(*) FROM _raffles_import WHERE boat_class='ILCA 6'); END IF;
END $$;

DELETE FROM public.regatta_results rr USING public.regattas r WHERE rr.regatta_id=r.id AND r.slug='raffles-marina-ilca-nov-25-4-2025-11-08';

DELETE FROM public.regatta_results rr USING public.regattas r WHERE rr.regatta_id=r.id AND r.slug='raffles-marina-ilca-nov-25-6-2025-11-08';

DO $$
DECLARE row record; sailor_id uuid; result_id uuid; regatta_id uuid; sail_no text; noc text; sailor_noc text; race_number integer; score numeric; code text; discarded boolean; raw text;
BEGIN
  FOR row IN SELECT * FROM _raffles_import ORDER BY boat_class,final_rank,sailor_name LOOP
    noc := CASE WHEN row.sail_label ~* '^(SGP|GER|FRA|AND|CW) ' THEN upper(split_part(row.sail_label,' ',1)) ELSE NULL END;
    sail_no := CASE WHEN noc IS NOT NULL THEN substring(row.sail_label from position(' ' in row.sail_label)+1) ELSE row.sail_label END;
    SELECT s.id INTO sailor_id FROM public.sailors s WHERE regexp_replace(lower(s.name),'[^a-z0-9]','','g') IN (regexp_replace(lower(row.identity_name),'[^a-z0-9]','','g'),regexp_replace(lower(row.sailor_name),'[^a-z0-9]','','g')) ORDER BY CASE WHEN regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower(row.identity_name),'[^a-z0-9]','','g') THEN 0 ELSE 1 END LIMIT 1;
    IF sailor_id IS NULL THEN
      sailor_id:=gen_random_uuid();
      INSERT INTO public.sailors(id,name,handle,sail_number,club,gender,nationality,created_at,updated_at) VALUES(sailor_id,row.sailor_name,left(regexp_replace(lower(row.sailor_name),'[^a-z0-9]+','-','g'),40)||'-'||substr(md5(lower(row.sailor_name)),1,6),sail_no,'Raffles Marina',row.gender,noc,now(),now());
    ELSE
      UPDATE public.sailors SET gender=COALESCE(gender,row.gender), nationality=COALESCE(nationality,noc), updated_at=now() WHERE id=sailor_id;
    END IF;
    SELECT id INTO regatta_id FROM public.regattas WHERE slug=CASE row.boat_class WHEN 'ILCA 4' THEN 'raffles-marina-ilca-nov-25-4-2025-11-08' ELSE 'raffles-marina-ilca-nov-25-6-2025-11-08' END;
    SELECT nationality INTO sailor_noc FROM public.sailors WHERE id=sailor_id;
    INSERT INTO public.regatta_results(id,sailor_id,regatta_id,rank,total_score,nett_score,is_dns,is_overseas_commitment,gender,nationality,verification_status,verified_at,evidence_name,evidence_type,official_url,evidence_notes,created_at,updated_at)
      VALUES(gen_random_uuid(),sailor_id,regatta_id,row.final_rank,row.total_score,row.nett_score,false,false,row.gender,COALESCE(noc,sailor_noc),'verified',now(),CASE row.boat_class WHEN 'ILCA 4' THEN 'ILCA 4.pdf' ELSE 'ILCA 6.pdf' END,'pdf','https://www.racingrulesofsailing.org/documents/11648/event','Official Sailwave overall result sheet; eight races, one discard.',now(),now()) RETURNING id INTO result_id;
    FOR race_number,score,code,discarded,raw IN
      SELECT ordinal::integer,(regexp_match(value,'^\(?([0-9]+(?:\.[0-9]+)?)'))[1]::numeric,nullif((regexp_match(value,'\b(DSQ|UFD|DNF|DNC|RET|BFD|DNS)\b'))[1],''),value ~ '^\(',value
      FROM jsonb_array_elements_text(row.race_scores) WITH ORDINALITY item(value,ordinal)
    LOOP
      INSERT INTO public.regatta_race_results(regatta_result_id,race_number,score,raw_value,discarded,scoring_code,created_at,updated_at) VALUES(result_id,race_number,score,raw,discarded,code,now(),now());
    END LOOP;
  END LOOP;
END $$;
DROP TABLE _raffles_import;
COMMIT;
