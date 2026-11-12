const fs = require('fs');
const m = require('./ilca-7.json');
const payload = JSON.stringify(m.results);
const sql = `-- Oman Sail online results; no final PDF located. Day 4 updated 21 October 2026.
BEGIN;
DO $import$
DECLARE
  payload jsonb := $data$${payload}$data$;
  event_id_v uuid; sheet_id_v uuid; sailor_id_v uuid; result_id_v uuid;
  item jsonb; race jsonb; handle_v text; candidate_count integer;
BEGIN
  PERFORM pg_advisory_xact_lock(hashtext('mussanah-race-week-2026-ilca-7'));
  INSERT INTO public.regatta_events(name,slug,start_date,end_date,venue,organizer,classes,counts_for_ranking,is_selection_trial,schedule_summary)
  VALUES ('Mussanah Race Week 2026','mussanah-race-week-2026','2026-10-15','2026-10-22','Barceló Mussanah Resort, Oman','Oman Sail','["Optimist","ILCA 4","ILCA 6","ILCA 7"]'::jsonb,false,false,'Racing 18–21 October 2026; official departure 22 October.')
  ON CONFLICT(slug) DO NOTHING;
  SELECT id INTO STRICT event_id_v FROM public.regatta_events WHERE slug='mussanah-race-week-2026' AND start_date='2026-10-15' AND end_date='2026-10-22';
  INSERT INTO public.regattas(name,slug,event_id,date,end_date,total_fleet_size,division,race_count,geography,boat_class,counts_for_ranking,venue,organizer,status,official_results_url,official_results_source_name,reviewed_at)
  VALUES('Mussanah Race Week 2026 (ILCA 7)','mussanah-race-week-2026-ilca-7',event_id_v,'2026-10-15','2026-10-22',9,'Open',12,'OMA','ILCA 7',false,'Barceló Mussanah Resort, Oman','Oman Sail','published','https://www.omansail.om/events/mussanah-race-week-2026#results','Oman Sail ILCA 7 Day 4 results, updated 21 October 2026',now())
  ON CONFLICT(slug) DO NOTHING;
  SELECT id INTO STRICT sheet_id_v FROM public.regattas WHERE slug='mussanah-race-week-2026-ilca-7' AND event_id=event_id_v AND boat_class='ILCA 7' AND total_fleet_size=9 AND race_count=12 AND status='published';
  FOR item IN SELECT * FROM jsonb_array_elements(payload) LOOP
    handle_v := 'mussanah-2026-ilca7-' || substr(md5(lower(item->>'name') || '|' || (item->>'nationality') || '|' || (item->>'sailOrBoardNumber')),1,16);
    SELECT count(DISTINCT s.id) INTO candidate_count FROM public.sailors s LEFT JOIN public.sailor_aliases a ON a.sailor_id=s.id WHERE (lower(s.name)=lower(item->>'name') OR lower(a.alias_name)=lower(item->>'name')) AND s.handle<>handle_v;
    IF candidate_count>0 THEN RAISE EXCEPTION 'Unexpected matching sailor for %, investigate before import',item->>'name'; END IF;
    INSERT INTO public.sailors(name,handle,sail_number,club,nationality,gender)
    VALUES(item->>'name',handle_v,item->>'sailOrBoardNumber','N/A',item->>'nationality',NULL)
    ON CONFLICT(handle) DO NOTHING;
    SELECT id INTO STRICT sailor_id_v FROM public.sailors WHERE handle=handle_v AND name=item->>'name' AND nationality=item->>'nationality';
    INSERT INTO public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,nationality,entry_sail_number,verification_status,verified_at,evidence_type,evidence_url,evidence_name,official_url,evidence_notes)
    VALUES(sailor_id_v,sheet_id_v,(item->>'rank')::int,(item->>'nettScore')::real,(item->>'grossScore')::real,item->>'nationality',item->>'sailOrBoardNumber','verified',now(),'link','https://www.omansail.om/events/mussanah-race-week-2026#results','Oman Sail ILCA 7 Day 4 results, 21 October 2026','https://www.omansail.om/events/mussanah-race-week-2026#results','Official online table; name: '||(item->>'name')||'; historical sail: '||(item->>'sailOrBoardNumber')||'. All 12 race scores and displayed discard retained; PDF corroboration unavailable.')
    ON CONFLICT(sailor_id,regatta_id) DO NOTHING RETURNING id INTO result_id_v;
    IF result_id_v IS NULL THEN SELECT id INTO STRICT result_id_v FROM public.regatta_results WHERE sailor_id=sailor_id_v AND regatta_id=sheet_id_v; END IF;
    FOR race IN SELECT * FROM jsonb_array_elements(item->'races') LOOP
      INSERT INTO public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value)
      VALUES(result_id_v,(race->>'raceNumber')::int,(race->>'score')::real,race->>'code',(race->>'discarded')::boolean,race->>'raw')
      ON CONFLICT(regatta_result_id,race_number) DO NOTHING;
    END LOOP;
    INSERT INTO public.regatta_result_participants(regatta_result_id,sailor_id,source_name,display_order,role,match_status,ranking_credit)
    VALUES(result_id_v,sailor_id_v,item->>'name',1,'solo','matched',false)
    ON CONFLICT(regatta_result_id,display_order) DO NOTHING;
    IF NOT EXISTS(SELECT 1 FROM public.regatta_results WHERE id=result_id_v AND rank=(item->>'rank')::int AND total_score=(item->>'grossScore')::real AND nett_score=(item->>'nettScore')::real AND verification_status='verified') OR
       (SELECT count(*) FROM public.regatta_race_results WHERE regatta_result_id=result_id_v)<>12 OR
       (SELECT sum(score) FROM public.regatta_race_results WHERE regatta_result_id=result_id_v)<>(item->>'grossScore')::real OR
       (SELECT sum(score) FROM public.regatta_race_results WHERE regatta_result_id=result_id_v AND NOT discarded)<>(item->>'nettScore')::real
       THEN RAISE EXCEPTION 'Race reconciliation failed for %',item->>'name'; END IF;
  END LOOP;
  IF (SELECT count(*) FROM public.regatta_results WHERE regatta_id=sheet_id_v)<>9 OR
     (SELECT count(*) FROM public.regatta_race_results q JOIN public.regatta_results r ON r.id=q.regatta_result_id WHERE r.regatta_id=sheet_id_v)<>108
     THEN RAISE EXCEPTION 'Unexpected final sheet counts'; END IF;
END $import$;
COMMIT;`;
fs.writeFileSync('scripts/imports/mussanah-2026/ilca-7.sql',sql+'\n');
