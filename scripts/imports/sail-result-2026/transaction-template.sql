
begin;
set local lock_timeout='8s';
set local statement_timeout='60s';
do $import$
declare
 m jsonb := $manifest$__MANIFEST__$manifest$::jsonb;
 p jsonb; r jsonb; part jsonb; race jsonb;
 e regatta_events%rowtype; s regattas%rowtype;
 replay boolean; expected_count int; race_count int; rid uuid; sid uuid;
 before_profiles text; after_profiles text;
begin
 perform pg_advisory_xact_lock(hashtextextended(m#>>'{sheet,slug}',0));
 expected_count:=jsonb_array_length(m->'results');race_count:=(m#>>'{sheet,raceCount}')::int;
 if expected_count<>(m->>'importedEntryCount')::int or expected_count>(m#>>'{sheet,totalFleetSize}')::int or
   (select count(distinct x->>'sailorId') from jsonb_array_elements(m->'results') x)<>expected_count
   then raise exception 'Manifest identity/count invalid'; end if;
 select exists(select 1 from admin_change_log where source=m->>'batch' and action='results.import_official_sailresult2026' and entity_id=(m#>>'{sheet,id}')::uuid) into replay;
 perform 1 from sailors where id in(select (x->>'id')::uuid from jsonb_array_elements(m->'profilePreflight') x) order by id for update;
 select md5(jsonb_agg(to_jsonb(a) order by a.id)::text) into before_profiles from sailors a where id in(select (x->>'id')::uuid from jsonb_array_elements(m->'profilePreflight') x);
 for p in select value from jsonb_array_elements(m->'profilePreflight') loop
  if not exists(select 1 from sailors a where a.id=(p->>'id')::uuid and jsonb_build_object('id',a.id,'name',a.name,'handle',a.handle,'sailNumber',a.sail_number,'sailNumberIlca4',a.sail_number_ilca4,'nationality',a.nationality,'gender',a.gender,'club',a.club,'birthYear',extract(year from a.dob)::int)=p)
   then raise exception 'Existing profile changed since identity review: %',p->>'name'; end if;
 end loop;
 if not replay then
  if exists(select 1 from regattas where slug=m#>>'{sheet,slug}' or id=(m#>>'{sheet,id}')::uuid or (event_id=(m#>>'{event,id}')::uuid and boat_class=m#>>'{sheet,boatClass}' and division=m#>>'{sheet,division}'))
   then raise exception 'Sheet exists without matching audit; review before overwriting'; end if;
  for p in select value from jsonb_array_elements(m->'newProfiles') loop
   if exists(select 1 from sailors where (lower(name)=lower(p->>'name') or handle=p->>'handle') and id<>(p->>'id')::uuid)
    then raise exception 'New profile already has a candidate: %',p->>'name'; end if;
   if exists(select 1 from sailors a where a.id=(p->>'id')::uuid and (a.name<>p->>'name' or a.handle<>p->>'handle' or a.nationality is distinct from p->>'nationality' or a.gender is distinct from p->>'gender'))
    then raise exception 'Conflicting profile UUID: %',p->>'name'; end if;
   insert into sailors(id,name,handle,sail_number,sail_number_ilca4,club,nationality,gender)
    values((p->>'id')::uuid,p->>'name',p->>'handle',p->>'sailNumber',p->>'sailNumberIlca4',p->>'club',p->>'nationality',p->>'gender') on conflict(id) do nothing;
  end loop;
  if exists(select 1 from regatta_events where slug=m#>>'{event,slug}' and id<>(m#>>'{event,id}')::uuid) then raise exception 'Event slug has conflicting identity'; end if;
  if exists(select 1 from regatta_events where id=(m#>>'{event,id}')::uuid and (slug<>m#>>'{event,slug}' or name<>m#>>'{event,name}' or start_date<>(m#>>'{event,startDate}')::date or end_date<>(m#>>'{event,endDate}')::date)) then raise exception 'Parent event changed since review'; end if;
  insert into regatta_events(id,name,slug,start_date,end_date,venue,organizer,classes,counts_for_ranking,schedule_summary,scoring_rules)
   values((m#>>'{event,id}')::uuid,m#>>'{event,name}',m#>>'{event,slug}',(m#>>'{event,startDate}')::date,(m#>>'{event,endDate}')::date,m#>>'{event,venue}',m#>>'{event,organizer}',m#>'{event,classes}',false,'Official class results imported. See each fleet sheet for publication status and pending identity reviews.','Low points; race counts and discards as published on each official class sheet.') on conflict(id) do nothing;
  update regatta_events set classes=(select jsonb_agg(distinct value order by value) from jsonb_array_elements(coalesce(classes,'[]'::jsonb)||(m#>'{event,classes}'))) where id=(m#>>'{event,id}')::uuid;
  insert into regattas(id,name,slug,event_id,date,end_date,total_fleet_size,division,race_count,geography,boat_class,entry_type,min_participants,max_participants,counts_for_ranking,venue,organizer,status,official_results_url,official_results_source_name,reviewed_at,schedule_notes)
   values((m#>>'{sheet,id}')::uuid,m#>>'{sheet,name}',m#>>'{sheet,slug}',(m#>>'{event,id}')::uuid,(m#>>'{event,startDate}')::date,(m#>>'{event,endDate}')::date,(m#>>'{sheet,totalFleetSize}')::int,m#>>'{sheet,division}',race_count,'THA',m#>>'{sheet,boatClass}',m#>>'{sheet,entryType}',(m#>>'{sheet,minParticipants}')::int,(m#>>'{sheet,maxParticipants}')::int,false,m#>>'{event,venue}',m#>>'{event,organizer}','published',m#>>'{officialSource,url}',m#>>'{officialSource,title}',now(),m->>'publicSummary');
  for r in select value from jsonb_array_elements(m->'results') loop
   rid:=(r->>'resultId')::uuid;sid:=(r->>'sailorId')::uuid;
   insert into regatta_results(id,sailor_id,regatta_id,entry_label,entry_sail_number,entry_type,rank,total_score,nett_score,gender,nationality,birth_year,is_dns,is_overseas_commitment,official_url,evidence_url,evidence_name,evidence_type,evidence_notes,verification_status,verified_at)
    values(rid,sid,(m#>>'{sheet,id}')::uuid,r->>'name',r->>'sailOrBoardNumber',m#>>'{sheet,entryType}',(r->>'rank')::int,(r->>'grossScore')::real,(r->>'nettScore')::real,r->>'gender',r->>'nationality',(r->>'officialBirthYear')::int,false,false,m#>>'{officialSource,url}',m#>>'{officialSource,url}',m#>>'{officialSource,title}',m#>>'{officialSource,type}',r->>'evidenceNotes','verified',now());
   for part in select value from jsonb_array_elements(r->'participants') loop
    insert into regatta_result_participants(id,regatta_result_id,sailor_id,source_name,display_order,role,match_status,ranking_credit)
     values((part->>'id')::uuid,rid,(part->>'sailorId')::uuid,part->>'sourceName',(part->>'displayOrder')::int,part->>'role','matched',false);
   end loop;
   insert into regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value)
    select rid,(x->>'raceNumber')::int,(x->>'score')::real,x->>'code',(x->>'discarded')::boolean,x->>'raw' from jsonb_array_elements(r->'races') x;
  end loop;
  insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
   values('results.import_official_sailresult2026','regatta',(m#>>'{sheet,id}')::uuid,m#>>'{sheet,name}','Imported reviewed 2026 official race scores, discards, penalties and evidence. Ambiguous identities deferred per user instruction; existing profiles unchanged.',jsonb_build_object('officialSource',m->'officialSource','expectedEntries',expected_count,'expectedRaceScores',expected_count*race_count,'officialFleetSize',m#>'{sheet,totalFleetSize}','deferredEntries',m->'pendingEntries','newProfileIds',(select jsonb_agg(x->>'id') from jsonb_array_elements(m->'newProfiles') x),'identityReview',m->'identityReview','singaporeRankingCredit',false),m->>'batch');
 end if;
 select * into e from regatta_events where id=(m#>>'{event,id}')::uuid;
 if e.id is null or e.slug<>m#>>'{event,slug}' or e.name<>m#>>'{event,name}' or e.start_date<>(m#>>'{event,startDate}')::date or e.end_date<>(m#>>'{event,endDate}')::date or not (e.classes @> (m#>'{event,classes}')) or e.counts_for_ranking
  then raise exception 'Parent event verification failed'; end if;
 select * into s from regattas where id=(m#>>'{sheet,id}')::uuid;
 if s.id is null or s.slug<>m#>>'{sheet,slug}' or s.event_id<>e.id or s.race_count<>race_count or s.total_fleet_size<>(m#>>'{sheet,totalFleetSize}')::int or s.boat_class<>m#>>'{sheet,boatClass}' or s.division<>m#>>'{sheet,division}' or s.entry_type<>m#>>'{sheet,entryType}' or s.status<>'published' or s.counts_for_ranking or s.official_results_url<>m#>>'{officialSource,url}' or s.schedule_notes<>m->>'publicSummary'
  then raise exception 'Final sheet metadata verification failed'; end if;
 if (select count(*) from regatta_results where regatta_id=s.id)<>expected_count or
    (select count(*) from regatta_race_results a join regatta_results b on b.id=a.regatta_result_id where b.regatta_id=s.id)<>expected_count*race_count
  then raise exception 'Final result/race inventory differs'; end if;
 for r in select value from jsonb_array_elements(m->'results') loop
  rid:=(r->>'resultId')::uuid;
  if not exists(select 1 from regatta_results where id=rid and regatta_id=s.id and sailor_id=(r->>'sailorId')::uuid and entry_label=r->>'name' and entry_sail_number=r->>'sailOrBoardNumber' and entry_type=m#>>'{sheet,entryType}' and rank=(r->>'rank')::int and abs(total_score-(r->>'grossScore')::real)<.001 and abs(nett_score-(r->>'nettScore')::real)<.001 and nationality is not distinct from r->>'nationality' and gender is not distinct from r->>'gender' and birth_year is not distinct from (r->>'officialBirthYear')::int and evidence_url=m#>>'{officialSource,url}' and official_url=m#>>'{officialSource,url}' and evidence_type=m#>>'{officialSource,type}' and evidence_notes=r->>'evidenceNotes' and verification_status='verified' and not is_dns and not is_overseas_commitment)
   then raise exception 'Result/evidence differs: %',r->>'name'; end if;
  if (select count(*) from regatta_result_participants where regatta_result_id=rid)<>jsonb_array_length(r->'participants')
   then raise exception 'Participant count differs'; end if;
  for part in select value from jsonb_array_elements(r->'participants') loop
   if not exists(select 1 from regatta_result_participants where id=(part->>'id')::uuid and regatta_result_id=rid and sailor_id=(part->>'sailorId')::uuid and source_name=part->>'sourceName' and display_order=(part->>'displayOrder')::int and role=part->>'role' and match_status='matched' and not ranking_credit)
    then raise exception 'Participant differs: %',part->>'sourceName'; end if;
  end loop;
  if not exists(select 1 from regatta_race_results where regatta_result_id=rid group by regatta_result_id having count(*)=race_count and abs(sum(score)-(r->>'grossScore')::real)<.001 and abs(sum(score) filter(where not discarded)-(r->>'nettScore')::real)<.001 and count(*) filter(where discarded)=(select count(*) from jsonb_array_elements(r->'races') z where (z->>'discarded')::boolean))
   then raise exception 'Row reconciliation failed: %',r->>'name'; end if;
  for race in select value from jsonb_array_elements(r->'races') loop
   if not exists(select 1 from regatta_race_results where regatta_result_id=rid and race_number=(race->>'raceNumber')::int and score=(race->>'score')::real and scoring_code is not distinct from race->>'code' and discarded=(race->>'discarded')::boolean and raw_value=race->>'raw')
    then raise exception 'Race/code/discard differs'; end if;
  end loop;
 end loop;
 select md5(jsonb_agg(to_jsonb(a) order by a.id)::text) into after_profiles from sailors a where id in(select (x->>'id')::uuid from jsonb_array_elements(m->'profilePreflight') x);
 if before_profiles is distinct from after_profiles then raise exception 'Existing profiles changed unexpectedly'; end if;
end
$import$;
commit;
