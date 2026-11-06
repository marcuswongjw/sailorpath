-- Reviewed official result sheet. Full source fields remain in the manifest and evidence.
begin;
set local lock_timeout='8s';
set local statement_timeout='90s';
do $import$
declare
 m jsonb := $manifest${"officialSource":{"url":"https://www.racingrulesofsailing.org/documents/214831","title":"2026ユースワールド代表選考 最終成績 420 Girls","type":"pdf","publicationStatus":"Final","visuallyReviewed":true,"sha256":"d9638547b01eb5423984ffffd99d5ed900e2354355dbdb1a2146dda2d876ecf0"},"event":{"slug":"japan-youth-worlds-selection-2026","name":"Japan Youth Worlds Selection Regatta 2026","startDate":"2026-10-31","endDate":"2026-11-03","venue":"Sakaiminato Public Marina, Tottori, Japan","organizer":"Japan Sailing Federation and Tottori Sailing Federation","norUrl":"https://www.racingrulesofsailing.org/documents/213070","noticeBoardUrl":"https://www.racingrulesofsailing.org/documents/16264/event","classes":["29er","420","ILCA 6","iQFOiL"],"geography":"JPN","isSelectionTrial":true},"sheet":{"slug":"japan-youth-worlds-selection-2026-420-girls","name":"Japan Youth Worlds Selection Regatta 2026 — 420 Girls","boatClass":"420","division":"Girls","raceCount":10,"totalFleetSize":3,"countsForRanking":false,"status":"published","entryType":"crew"},"results":[{"rank":1,"name":"村中 莉子 / 井口 梨沙","club":"鳥取県セーリング連盟","sailOrBoardNumber":"56085","gender":"F","nationality":null,"grossScore":15.0,"nettScore":12.0,"sourcePage":1,"races":[{"raceNumber":1,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":2,"score":2.0,"code":null,"discarded":false,"raw":"2","sourceRaceDetail":"2 / 2 / 2"},{"raceNumber":3,"score":2.0,"code":null,"discarded":false,"raw":"2","sourceRaceDetail":"2 / 2 / 2"},{"raceNumber":4,"score":2.0,"code":null,"discarded":false,"raw":"2","sourceRaceDetail":"2 / 2 / 2"},{"raceNumber":5,"score":3.0,"code":null,"discarded":true,"raw":"(3)","sourceRaceDetail":"3 / 3 / 3"},{"raceNumber":6,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":7,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":8,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":9,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"2 / 1 / 1"},{"raceNumber":10,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"2 / 1 / 1"}],"participants":[{"name":"村中 莉子","role":"unknown","sailorId":"3d7d17df-71ad-4195-b41d-abdebbed13bc","matchReason":"unique exact NFKC-normalized published name or registered alias"},{"name":"井口 梨沙","role":"unknown","sailorId":"8ee0b341-b6ba-5089-aa24-d2846276d9cb","newProfile":{"id":"8ee0b341-b6ba-5089-aa24-d2846276d9cb","name":"井口 梨沙","handle":"jpn-rrs26-41555bae0010","sailNumber":"56085","sailNumberIlca4":null,"boardNumber":null,"club":"鳥取県セーリング連盟","nationality":null,"gender":"F"},"matchReason":"new profile; no exact official-name or registered-alias match; sail number alone not used as identity"}],"sailorId":"3d7d17df-71ad-4195-b41d-abdebbed13bc","matchReason":"unique exact NFKC-normalized published name or registered alias","officialNationality":null},{"rank":2,"name":"福島 笑莉 / 實松 莉歩","club":"三重県立津工業高等学校/霞ヶ浦高等学校","sailOrBoardNumber":"55053","gender":"F","nationality":null,"grossScore":23.0,"nettScore":19.0,"sourcePage":1,"races":[{"raceNumber":1,"score":4.0,"code":"NSC","discarded":true,"raw":"(4 NSC)","sourceRaceDetail":"NSC / NSC / 4"},{"raceNumber":2,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":3,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":4,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":5,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":6,"score":2.0,"code":null,"discarded":false,"raw":"2","sourceRaceDetail":"2 / 2 / 2"},{"raceNumber":7,"score":2.0,"code":null,"discarded":false,"raw":"2","sourceRaceDetail":"2 / 2 / 2"},{"raceNumber":8,"score":3.0,"code":null,"discarded":false,"raw":"3","sourceRaceDetail":"3 / 3 / 3"},{"raceNumber":9,"score":4.0,"code":"RET","discarded":false,"raw":"4 RET","sourceRaceDetail":"1 / RET / 4"},{"raceNumber":10,"score":4.0,"code":"DNE","discarded":false,"raw":"4 DNE","sourceRaceDetail":"1 / DNE / 4"}],"participants":[{"name":"福島 笑莉","role":"unknown","sailorId":"96a88fad-d8a1-51f0-a5ef-c002146ebb42","newProfile":{"id":"96a88fad-d8a1-51f0-a5ef-c002146ebb42","name":"福島 笑莉","handle":"jpn-rrs26-0065e52dbc6f","sailNumber":"55053","sailNumberIlca4":null,"boardNumber":null,"club":"三重県立津工業高等学校/霞ヶ浦高等学校","nationality":null,"gender":"F"},"matchReason":"new profile; no exact official-name or registered-alias match; sail number alone not used as identity"},{"name":"實松 莉歩","role":"unknown","sailorId":"17a5a5e2-0bf9-5e83-a0fe-17149b449d46","newProfile":{"id":"17a5a5e2-0bf9-5e83-a0fe-17149b449d46","name":"實松 莉歩","handle":"jpn-rrs26-1548f3bc0f6d","sailNumber":"55053","sailNumberIlca4":null,"boardNumber":null,"club":"三重県立津工業高等学校/霞ヶ浦高等学校","nationality":null,"gender":"F"},"matchReason":"new profile; no exact official-name or registered-alias match; sail number alone not used as identity"}],"sailorId":"96a88fad-d8a1-51f0-a5ef-c002146ebb42","matchReason":"new profile; no exact official-name or registered-alias match; sail number alone not used as identity","newProfile":{"id":"96a88fad-d8a1-51f0-a5ef-c002146ebb42","name":"福島 笑莉","handle":"jpn-rrs26-0065e52dbc6f","sailNumber":"55053","sailNumberIlca4":null,"boardNumber":null,"club":"三重県立津工業高等学校/霞ヶ浦高等学校","nationality":null,"gender":"F"},"officialNationality":null},{"rank":3,"name":"中村 和愛 / 米澤 ジア","club":"山口県セーリング連盟/HOPE/江ノ島ヨットクラブジュニア","sailOrBoardNumber":"57109","gender":"F","nationality":null,"grossScore":25.0,"nettScore":22.0,"sourcePage":1,"races":[{"raceNumber":1,"score":2.0,"code":null,"discarded":false,"raw":"2","sourceRaceDetail":"2 / 2 / 2"},{"raceNumber":2,"score":3.0,"code":null,"discarded":true,"raw":"(3)","sourceRaceDetail":"3 / 3 / 3"},{"raceNumber":3,"score":3.0,"code":null,"discarded":false,"raw":"3","sourceRaceDetail":"3 / 3 / 3"},{"raceNumber":4,"score":3.0,"code":null,"discarded":false,"raw":"3","sourceRaceDetail":"3 / 3 / 3"},{"raceNumber":5,"score":2.0,"code":null,"discarded":false,"raw":"2","sourceRaceDetail":"2 / 2 / 2"},{"raceNumber":6,"score":3.0,"code":null,"discarded":false,"raw":"3","sourceRaceDetail":"3 / 3 / 3"},{"raceNumber":7,"score":3.0,"code":null,"discarded":false,"raw":"3","sourceRaceDetail":"3 / 3 / 3"},{"raceNumber":8,"score":2.0,"code":null,"discarded":false,"raw":"2","sourceRaceDetail":"2 / 2 / 2"},{"raceNumber":9,"score":2.0,"code":null,"discarded":false,"raw":"2","sourceRaceDetail":"3 / 2 / 2"},{"raceNumber":10,"score":2.0,"code":null,"discarded":false,"raw":"2","sourceRaceDetail":"3 / 2 / 2"}],"participants":[{"name":"中村 和愛","role":"unknown","sailorId":"cc3fe966-6f54-5130-8969-d98a253c6281","newProfile":{"id":"cc3fe966-6f54-5130-8969-d98a253c6281","name":"中村 和愛","handle":"jpn-rrs26-ebfdf793f204","sailNumber":"57109","sailNumberIlca4":null,"boardNumber":null,"club":"山口県セーリング連盟/HOPE/江ノ島ヨットクラブジュニア","nationality":null,"gender":"F"},"matchReason":"new profile; no exact official-name or registered-alias match; sail number alone not used as identity"},{"name":"米澤 ジア","role":"unknown","sailorId":"f9f6c811-d2c7-52a9-8461-4d104039d28b","newProfile":{"id":"f9f6c811-d2c7-52a9-8461-4d104039d28b","name":"米澤 ジア","handle":"jpn-rrs26-95ec6d1e07d3","sailNumber":"57109","sailNumberIlca4":null,"boardNumber":null,"club":"山口県セーリング連盟/HOPE/江ノ島ヨットクラブジュニア","nationality":null,"gender":"F"},"matchReason":"new profile; no exact official-name or registered-alias match; sail number alone not used as identity"}],"sailorId":"cc3fe966-6f54-5130-8969-d98a253c6281","matchReason":"new profile; no exact official-name or registered-alias match; sail number alone not used as identity","newProfile":{"id":"cc3fe966-6f54-5130-8969-d98a253c6281","name":"中村 和愛","handle":"jpn-rrs26-ebfdf793f204","sailNumber":"57109","sailNumberIlca4":null,"boardNumber":null,"club":"山口県セーリング連盟/HOPE/江ノ島ヨットクラブジュニア","nationality":null,"gender":"F"},"officialNationality":null}]}$manifest$::jsonb;
 e jsonb := m->'event'; sh jsonb := m->'sheet';
 item jsonb; member jsonb; race jsonb; np jsonb;
 eid uuid; rid uuid; sid uuid; rrid uuid;
 n integer; expected integer; gross double precision; net double precision; disc integer;
 crew boolean := coalesce(sh->>'entryType','individual')='crew';
 board boolean := sh->>'boatClass'='iQFOiL';
begin
 perform pg_advisory_xact_lock(hashtext(e->>'slug'));
 insert into regatta_events(name,slug,start_date,end_date,classes,venue,organizer,nor_url,counts_for_ranking,is_selection_trial,schedule_summary,scoring_rules)
 values(e->>'name',e->>'slug',(e->>'startDate')::date,(e->>'endDate')::date,e->'classes',e->>'venue',e->>'organizer',e->>'norUrl',false,coalesce((e->>'isSelectionTrial')::boolean,false),
 'Official notice board: '||(e->>'noticeBoardUrl')||'. '||
 case when e->>'geography'='TPE' then 'Published fleet source remains provisional as of 31 October 2026, 20:30. Team racing uses a separate double-elimination bracket: https://www.racingrulesofsailing.org/documents/214510'
 else 'Final official result sheets visually checked and imported with individual race scores.' end,
 'Official Appendix A race scores and printed exclusions retained. Outside Singapore national rankings.')
 on conflict(slug) do nothing;
 select id into eid from regatta_events where slug=e->>'slug' for update;
 if not exists(select 1 from regatta_events where id=eid and start_date=(e->>'startDate')::date and end_date=(e->>'endDate')::date and venue=e->>'venue') then
  raise exception 'Parent event identity/date conflict: %',e->>'slug';
 end if;
 insert into regattas(name,slug,event_id,date,end_date,total_fleet_size,division,race_count,geography,boat_class,entry_type,min_participants,max_participants,counts_for_ranking,reviewed_at,venue,organizer,nor_url,official_results_url,official_results_source_name,schedule_notes,is_selection_trial,status)
 values(sh->>'name',sh->>'slug',eid,(e->>'startDate')::date,(e->>'endDate')::date,(sh->>'totalFleetSize')::int,sh->>'division',(sh->>'raceCount')::int,e->>'geography',sh->>'boatClass',
 case when crew then 'crew' else 'individual' end,case when crew then 2 else 1 end,case when crew then 2 else 1 end,false,now(),e->>'venue',e->>'organizer',e->>'norUrl',m->'officialSource'->>'url',m->'officialSource'->>'title',
 coalesce(sh->>'scheduleNotes','Final results. Every race score, penalty and printed discard checked against the official PDF. One printed exclusion per sailor. Outside Singapore national rankings.'),coalesce((e->>'isSelectionTrial')::boolean,false),'published')
 on conflict(slug) do update set name=excluded.name,event_id=excluded.event_id,date=excluded.date,end_date=excluded.end_date,
 total_fleet_size=excluded.total_fleet_size,division=excluded.division,race_count=excluded.race_count,geography=excluded.geography,
 boat_class=excluded.boat_class,entry_type=excluded.entry_type,min_participants=excluded.min_participants,max_participants=excluded.max_participants,
 counts_for_ranking=false,reviewed_at=now(),venue=excluded.venue,organizer=excluded.organizer,nor_url=excluded.nor_url,
 official_results_url=excluded.official_results_url,official_results_source_name=excluded.official_results_source_name,
 schedule_notes=excluded.schedule_notes,is_selection_trial=excluded.is_selection_trial,status='published',updated_at=now()
 returning id into rid;
 for item in select value from jsonb_array_elements(m->'results') loop
  for member in select value from jsonb_array_elements(item->'participants') loop
   sid=(member->>'sailorId')::uuid;np=member->'newProfile';
   if np is not null then
    insert into sailors(id,name,handle,sail_number,sail_number_ilca4,board_number,club,nationality,gender)
    values(sid,np->>'name',np->>'handle',coalesce(np->>'sailNumber',''),np->>'sailNumberIlca4',np->>'boardNumber',np->>'club',np->>'nationality',np->>'gender')
    on conflict(id) do nothing;
    if not exists(select 1 from sailors where id=sid and name=np->>'name' and handle=np->>'handle') then raise exception 'New profile identity conflict %',sid;end if;
   end if;
   if not exists(select 1 from sailors where id=sid) then raise exception 'Missing matched sailor %',sid;end if;
  end loop;
  sid=(item->>'sailorId')::uuid;
  insert into regatta_results(sailor_id,regatta_id,rank,total_score,nett_score,gender,nationality,entry_label,entry_sail_number,entry_board_number,entry_type,evidence_url,evidence_name,evidence_type,official_url,evidence_notes,verification_status,verified_at)
  values(sid,rid,(item->>'rank')::int,(item->>'grossScore')::real,(item->>'nettScore')::real,item->>'gender',item->>'nationality',
  item->>'name',case when not board then item->>'sailOrBoardNumber' end,case when board then item->>'sailOrBoardNumber' end,case when crew then 'crew' else 'individual' end,
  m->'officialSource'->>'url',m->'officialSource'->>'title','pdf',m->'officialSource'->>'url',
  jsonb_build_object('officialSource',m->'officialSource','noticeBoard',e->>'noticeBoardUrl','review','All result pages rendered and visually inspected. Every race score, scoring code, printed discard, rank and total checked. Verification refers to this official source; source finality remains explicit. Crew column order retained with unknown roles because the sheet does not label helm/crew.',
   'sourceRow',(item-'newProfile'-'participants'),'sourceParticipants',(select jsonb_agg(value-'newProfile') from jsonb_array_elements(item->'participants')))::text,
  'verified',now())
  on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,total_score=excluded.total_score,nett_score=excluded.nett_score,
  gender=excluded.gender,nationality=excluded.nationality,entry_label=excluded.entry_label,entry_sail_number=excluded.entry_sail_number,
  entry_board_number=excluded.entry_board_number,entry_type=excluded.entry_type,evidence_url=excluded.evidence_url,evidence_name=excluded.evidence_name,
  evidence_type=excluded.evidence_type,official_url=excluded.official_url,evidence_notes=excluded.evidence_notes,verification_status='verified',verified_at=now(),updated_at=now()
  returning id into rrid;
  n=0;
  for member in select value from jsonb_array_elements(item->'participants') loop
   n=n+1;
   insert into regatta_result_participants(regatta_result_id,sailor_id,source_name,display_order,role,match_status,ranking_credit)
   values(rrid,(member->>'sailorId')::uuid,member->>'name',n,member->>'role','matched',false)
   on conflict(regatta_result_id,display_order) do update set sailor_id=excluded.sailor_id,source_name=excluded.source_name,role=excluded.role,match_status='matched',ranking_credit=false,updated_at=now();
  end loop;
  if n<>(case when crew then 2 else 1 end) then raise exception 'Participant count mismatch';end if;
  for race in select value from jsonb_array_elements(item->'races') loop
   insert into regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value)
   values(rrid,(race->>'raceNumber')::int,(race->>'score')::real,race->>'code',(race->>'discarded')::boolean,race->>'raw')
   on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();
  end loop;
  select count(*),sum(score::double precision),sum(score::double precision) filter(where not discarded),count(*) filter(where discarded) into n,gross,net,disc from regatta_race_results where regatta_result_id=rrid;
  if n<>(sh->>'raceCount')::int or abs(gross-(item->>'grossScore')::double precision)>0.0001 or abs(net-(item->>'nettScore')::double precision)>0.0001
   or disc<>(select count(*) from jsonb_array_elements(item->'races') where (value->>'discarded')::boolean) then raise exception 'Score reconciliation failed: % %',sh->>'slug',item->>'name';end if;
 end loop;
 expected=jsonb_array_length(m->'results');
 select count(*) into n from regatta_results where regatta_id=rid;
 if n<>expected then raise exception 'Result count mismatch % / %',n,expected;end if;
 select count(*) into n from regatta_race_results x join regatta_results r on r.id=x.regatta_result_id where r.regatta_id=rid;
 if n<>expected*(sh->>'raceCount')::int then raise exception 'Race count mismatch %',n;end if;
 select count(*) into n from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where r.regatta_id=rid;
 if n<>expected*(case when crew then 2 else 1 end) then raise exception 'Participant count mismatch %',n;end if;
end $import$;
commit;
