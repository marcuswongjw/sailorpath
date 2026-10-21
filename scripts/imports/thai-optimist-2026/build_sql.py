import json
from pathlib import Path
OUT=Path('scripts/imports/thai-optimist-2026')
BODY=r'''
begin;
set local lock_timeout = '8s';
set local statement_timeout = '45s';
do $import$
declare
 m jsonb := $manifest$__MANIFEST__$manifest$::jsonb;
 p jsonb; r jsonb; race jsonb; s regattas%rowtype; replay boolean; before_profiles text; after_profiles text; expected_count int; expected_races int; sid uuid; rid uuid;
begin
 perform pg_advisory_xact_lock(hashtextextended(m#>>'{sheet,slug}',0));
 expected_count:=jsonb_array_length(m->'results');
 expected_races:=(m#>>'{sheet,raceCount}')::int;
 if expected_count<>(m#>>'{sheet,totalFleetSize}')::int or (select count(distinct x->>'sailorId') from jsonb_array_elements(m->'results') x)<>expected_count then raise exception 'Manifest entry identity/count invalid'; end if;
 select exists(select 1 from admin_change_log where source=m->>'batch' and action='results.import_official_thai2026' and entity_id=(m#>>'{sheet,id}')::uuid) into replay;
 perform 1 from sailors where id in (select (x->>'id')::uuid from jsonb_array_elements(m->'profilePreflight') x) order by id for update;
 select md5(jsonb_agg(to_jsonb(a) order by a.id)::text) into before_profiles from sailors a where id in(select (x->>'id')::uuid from jsonb_array_elements(m->'profilePreflight') x);
 for p in select value from jsonb_array_elements(m->'profilePreflight') loop
  if not exists(select 1 from sailors a where a.id=(p->>'id')::uuid and jsonb_build_object('id',a.id,'name',a.name,'handle',a.handle,'sailNumber',a.sail_number,'nationality',a.nationality,'gender',a.gender,'club',a.club,'birthYear',extract(year from a.dob)::int)=p) then raise exception 'Profile identity changed since preflight: %',p->>'name'; end if;
 end loop;
 if not replay then
  if exists(select 1 from regattas where slug=m#>>'{sheet,slug}' or id=(m#>>'{sheet,id}')::uuid or (event_id=(m#>>'{event,id}')::uuid and boat_class='Optimist')) then raise exception 'Sheet now exists; audit instead of overwriting'; end if;
  if exists(select 1 from regatta_events where (slug=m#>>'{event,slug}' or id=(m#>>'{event,id}')::uuid) and (id<>(m#>>'{event,id}')::uuid or slug<>m#>>'{event,slug}' or name<>m#>>'{event,name}' or start_date<>(m#>>'{event,startDate}')::date or end_date is distinct from (m#>>'{event,endDate}')::date)) then raise exception 'Conflicting parent event'; end if;
  for p in select value from jsonb_array_elements(m->'newProfiles') loop
   if exists(select 1 from sailors where (lower(name)=lower(p->>'name') or handle=p->>'handle') and id<>(p->>'id')::uuid) then raise exception 'New profile candidate now exists: %',p->>'name'; end if;
   if exists(select 1 from sailors a where a.id=(p->>'id')::uuid and (a.name<>p->>'name' or a.handle<>p->>'handle' or a.nationality is distinct from p->>'nationality' or a.gender is distinct from p->>'gender')) then raise exception 'New profile identity conflict'; end if;
   insert into sailors(id,name,handle,sail_number,club,nationality,gender)
    values((p->>'id')::uuid,p->>'name',p->>'handle',p->>'sail_number',p->>'club',p->>'nationality',p->>'gender') on conflict(id) do nothing;
  end loop;
  insert into regatta_events(id,name,slug,start_date,end_date,venue,organizer,classes,counts_for_ranking,schedule_summary,scoring_rules)
   values((m#>>'{event,id}')::uuid,m#>>'{event,name}',m#>>'{event,slug}',(m#>>'{event,startDate}')::date,(m#>>'{event,endDate}')::date,m#>>'{event,venue}',m#>>'{event,organizer}','["Optimist"]'::jsonb,false,m->>'publicSummary',format('Low-point scoring; %s races and %s discards, as published by the organiser.',expected_races,m#>>'{sheet,discardCount}')) on conflict(id) do nothing;
  insert into regattas(id,name,slug,event_id,date,end_date,total_fleet_size,division,race_count,geography,boat_class,entry_type,min_participants,max_participants,counts_for_ranking,venue,organizer,status,official_results_url,official_results_source_name,reviewed_at,schedule_notes)
   values((m#>>'{sheet,id}')::uuid,m#>>'{sheet,name}',m#>>'{sheet,slug}',(m#>>'{event,id}')::uuid,(m#>>'{event,startDate}')::date,(m#>>'{event,endDate}')::date,expected_count,m#>>'{sheet,division}',expected_races,'THA','Optimist','individual',1,1,false,m#>>'{event,venue}',m#>>'{event,organizer}','published',m#>>'{officialSource,url}',m#>>'{officialSource,title}',now(),m->>'publicSummary');
  for r in select value from jsonb_array_elements(m->'results') loop
   sid:=(r->>'sailorId')::uuid;
   insert into regatta_results(id,sailor_id,regatta_id,entry_label,entry_sail_number,entry_type,rank,total_score,nett_score,gender,nationality,birth_year,is_dns,is_overseas_commitment,official_url,evidence_url,evidence_name,evidence_type,evidence_notes,verification_status,verified_at)
    values((r->>'resultId')::uuid,sid,(m#>>'{sheet,id}')::uuid,r->>'name',r->>'sailOrBoardNumber','individual',(r->>'rank')::int,(r->>'grossScore')::real,(r->>'nettScore')::real,r->>'gender',r->>'nationality',(select extract(year from dob)::int from sailors where id=sid),false,false,m#>>'{officialSource,url}',m#>>'{officialSource,url}',m#>>'{officialSource,title}',m#>>'{officialSource,type}',r->>'evidenceNotes','verified',now())
    on conflict(sailor_id,regatta_id) do nothing returning id into rid;
   if rid is null or rid<>(r->>'resultId')::uuid then raise exception 'Conflicting result identity'; end if;
   insert into regatta_result_participants(id,regatta_result_id,sailor_id,source_name,display_order,role,match_status,ranking_credit)
    values((r->>'participantId')::uuid,rid,sid,r->>'name',1,'solo','matched',false);
   insert into regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value)
    select rid,(x->>'raceNumber')::int,(x->>'score')::real,x->>'code',(x->>'discarded')::boolean,x->>'raw' from jsonb_array_elements(r->'races') x;
  end loop;
  insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
   values('results.import_official_thai2026','regatta',(m#>>'{sheet,id}')::uuid,m#>>'{sheet,name}','Imported all official Optimist race scores, discards, scoring codes and source evidence; validated totals and identities.',jsonb_build_object('officialSource',m->'officialSource','dateBasis',m->>'dateBasis','expectedEntries',expected_count,'expectedRaceScores',expected_count*expected_races,'newProfileIds',(select jsonb_agg(x->>'id') from jsonb_array_elements(m->'newProfiles') x),'userIdentityConfirmation','Duangdeuen Wichai = Duangduean Wichat; Napaphat Buasuang = existing Napabhat Buasuang, confirmed by user 20 October 2026.','singaporeRankingCredit',false,'asianIndexGradeChanges',false),m->>'batch');
 end if;
 select * into s from regattas where id=(m#>>'{sheet,id}')::uuid;
 if s.id is null or s.slug<>m#>>'{sheet,slug}' or s.event_id<>(m#>>'{event,id}')::uuid or s.race_count<>expected_races or s.total_fleet_size<>expected_count or s.boat_class<>'Optimist' or s.division<>m#>>'{sheet,division}' or s.status<>'published' or s.counts_for_ranking or s.official_results_url<>m#>>'{officialSource,url}' then raise exception 'Final sheet metadata verification failed'; end if;
 if (select count(*) from regatta_results where regatta_id=s.id)<>expected_count or (select count(*) from regatta_race_results a join regatta_results b on b.id=a.regatta_result_id where b.regatta_id=s.id)<>expected_count*expected_races then raise exception 'Final result/race inventory differs'; end if;
 for r in select value from jsonb_array_elements(m->'results') loop
  rid:=(r->>'resultId')::uuid;
  if not exists(select 1 from regatta_results where id=rid and regatta_id=s.id and sailor_id=(r->>'sailorId')::uuid and entry_label=r->>'name' and entry_sail_number=r->>'sailOrBoardNumber' and rank=(r->>'rank')::int and abs(total_score-(r->>'grossScore')::real)<.001 and abs(nett_score-(r->>'nettScore')::real)<.001 and nationality=r->>'nationality' and gender=r->>'gender' and evidence_url=m#>>'{officialSource,url}' and official_url=m#>>'{officialSource,url}' and evidence_type=m#>>'{officialSource,type}' and evidence_notes=r->>'evidenceNotes' and verification_status='verified' and not is_dns and not is_overseas_commitment) then raise exception 'Result/evidence differs: %',r->>'name'; end if;
  if (select count(*) from regatta_result_participants where regatta_result_id=rid)<>1 or not exists(select 1 from regatta_result_participants where id=(r->>'participantId')::uuid and regatta_result_id=rid and sailor_id=(r->>'sailorId')::uuid and source_name=r->>'name' and display_order=1 and role='solo' and match_status='matched' and not ranking_credit) then raise exception 'Participant verification failed'; end if;
  if not exists(select 1 from regatta_race_results where regatta_result_id=rid group by regatta_result_id having count(*)=expected_races and abs(sum(score)-(r->>'grossScore')::real)<.001 and abs(sum(score) filter(where not discarded)-(r->>'nettScore')::real)<.001 and count(*) filter(where discarded)=(m#>>'{sheet,discardCount}')::int) then raise exception 'Row reconciliation failed: %',r->>'name'; end if;
  for race in select value from jsonb_array_elements(r->'races') loop
   if not exists(select 1 from regatta_race_results where regatta_result_id=rid and race_number=(race->>'raceNumber')::int and score=(race->>'score')::real and scoring_code is not distinct from race->>'code' and discarded=(race->>'discarded')::boolean and raw_value=race->>'raw') then raise exception 'Race/code/discard mismatch'; end if;
  end loop;
 end loop;
 select md5(jsonb_agg(to_jsonb(a) order by a.id)::text) into after_profiles from sailors a where id in(select (x->>'id')::uuid from jsonb_array_elements(m->'profilePreflight') x);
 if before_profiles is distinct from after_profiles then raise exception 'Existing profiles changed unexpectedly'; end if;
end
$import$;
commit;
'''
for key in ['acdc-sailing-cup','acdc-international','admirals-cup']:
 p=OUT/(key+'.json');m=json.loads(p.read_text());m['event']['name']=m['officialSource']['title']
 m['publicSummary']=('Official Optimist overall results. '+('The organiser labels this final-day source provisional; that status is retained.' if m['officialSource']['provisional'] else 'The organiser labels these results final.'))
 p.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
 (OUT/(key+'.sql')).write_text('-- '+m['sheet']['name']+'; official-source import, main fleet only.\n'+BODY.replace('__MANIFEST__',json.dumps(m,ensure_ascii=False,separators=(',',':'))))
 print(key,len((OUT/(key+'.sql')).read_bytes()))
