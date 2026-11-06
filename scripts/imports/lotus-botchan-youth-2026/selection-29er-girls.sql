-- Reviewed official result sheet. Full source fields remain in the manifest and evidence.
begin;
set local lock_timeout='8s';
set local statement_timeout='90s';
do $import$
declare
 m jsonb := $manifest${"officialSource":{"url":"https://www.racingrulesofsailing.org/documents/214827","title":"2026ユースワールド代表選考 最終成績 29er Girls","type":"pdf","publicationStatus":"Final","visuallyReviewed":true,"sha256":"1614b1bec730657e6da3987c5ab90befc2e3a110c07b7c8762f434f9c17d5dd2"},"event":{"slug":"japan-youth-worlds-selection-2026","name":"Japan Youth Worlds Selection Regatta 2026","startDate":"2026-10-31","endDate":"2026-11-03","venue":"Sakaiminato Public Marina, Tottori, Japan","organizer":"Japan Sailing Federation and Tottori Sailing Federation","norUrl":"https://www.racingrulesofsailing.org/documents/213070","noticeBoardUrl":"https://www.racingrulesofsailing.org/documents/16264/event","classes":["29er","420","ILCA 6","iQFOiL"],"geography":"JPN","isSelectionTrial":true},"sheet":{"slug":"japan-youth-worlds-selection-2026-29er-girls","name":"Japan Youth Worlds Selection Regatta 2026 — 29er Girls","boatClass":"29er","division":"Girls","raceCount":12,"totalFleetSize":1,"countsForRanking":false,"status":"published","entryType":"crew"},"results":[{"rank":1,"name":"舩澤 夏美 / 舩澤 夏子","club":"鳥取県セーリング連盟","sailOrBoardNumber":"3525","gender":"F","nationality":null,"grossScore":12.0,"nettScore":11.0,"sourcePage":2,"races":[{"raceNumber":1,"score":1.0,"code":null,"discarded":true,"raw":"(1)","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":2,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":3,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":4,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":5,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":6,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":7,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":8,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":9,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":10,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":11,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"},{"raceNumber":12,"score":1.0,"code":null,"discarded":false,"raw":"1","sourceRaceDetail":"1 / 1 / 1"}],"participants":[{"name":"舩澤 夏美","role":"unknown","sailorId":"08ea54bb-85c7-57ec-852e-b4e43ec045ec","newProfile":{"id":"08ea54bb-85c7-57ec-852e-b4e43ec045ec","name":"舩澤 夏美","handle":"jpn-rrs26-99fdb91be559","sailNumber":"3525","sailNumberIlca4":null,"boardNumber":null,"club":"鳥取県セーリング連盟","nationality":null,"gender":"F"},"matchReason":"new profile; no exact official-name or registered-alias match; sail number alone not used as identity"},{"name":"舩澤 夏子","role":"unknown","sailorId":"96dac3a2-4d7f-53b0-af17-808c44056f3d","newProfile":{"id":"96dac3a2-4d7f-53b0-af17-808c44056f3d","name":"舩澤 夏子","handle":"jpn-rrs26-8c0865ebd7fd","sailNumber":"3525","sailNumberIlca4":null,"boardNumber":null,"club":"鳥取県セーリング連盟","nationality":null,"gender":"F"},"matchReason":"new profile; no exact official-name or registered-alias match; sail number alone not used as identity"}],"sailorId":"08ea54bb-85c7-57ec-852e-b4e43ec045ec","matchReason":"new profile; no exact official-name or registered-alias match; sail number alone not used as identity","newProfile":{"id":"08ea54bb-85c7-57ec-852e-b4e43ec045ec","name":"舩澤 夏美","handle":"jpn-rrs26-99fdb91be559","sailNumber":"3525","sailNumberIlca4":null,"boardNumber":null,"club":"鳥取県セーリング連盟","nationality":null,"gender":"F"},"officialNationality":null}]}$manifest$::jsonb;
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
