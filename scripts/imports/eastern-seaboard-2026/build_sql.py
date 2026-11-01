import json,pathlib
b=pathlib.Path('scripts/imports/eastern-seaboard-2026')
for key in ['ilca4','ilca6','optimist-gold','optimist-silver']:
 m=json.load(open(b/(key+'.json')))
 payload=json.dumps(m,separators=(',',':'))
 sql="""-- 18th Eastern Seaboard Regatta 2026: reviewed official PDF import.
-- Final-labelled notice-board document, provisional wording within PDF retained.
begin;
set local lock_timeout='8s';
set local statement_timeout='90s';
do $import$
declare
 m jsonb := $manifest$"""+payload+"""$manifest$::jsonb;
 e jsonb := m->'event'; sh jsonb := m->'sheet';
 row jsonb; race jsonb; np jsonb;
 eid uuid; rid uuid; sid uuid; rrid uuid;
 n integer; gross double precision; net double precision; disc integer;
begin
 perform pg_advisory_xact_lock(hashtext('eastern-seaboard-regatta-2026'));
 select id into eid from regatta_events where slug=e->>'slug' for update;
 if eid is null then raise exception 'Expected existing 2026 event missing'; end if;
 if not exists (select 1 from regatta_events where id=eid and name ilike '%Eastern%Seaboard%2026%'
    and start_date in ('2026-10-29'::date,'2026-10-28'::date)
    and end_date in ('2026-10-31'::date,'2026-11-01'::date)) then
   raise exception 'Event identity/date preflight changed';
 end if;
 update regatta_events set name=e->>'name',start_date=(e->>'startDate')::date,
   end_date=(e->>'endDate')::date,classes='["Optimist","ILCA 4","ILCA 6"]'::jsonb,
   venue=e->>'venue',organizer=e->>'organizer',nor_url=e->>'norUrl',
   counts_for_ranking=false,
   schedule_summary='Official NoR: registration 28 October; racing 29 October–1 November 2026. Four official result fleets imported from final-labelled notice-board PDFs; PDF bodies retain provisional wording.',
   scoring_rules='Appendix A; 8 races per fleet. ILCA: one discard. Optimist: 5 qualifying races + 3 final races, two printed discards.',
   updated_at=now() where id=eid;
 insert into regattas(name,slug,event_id,date,end_date,total_fleet_size,division,race_count,
  geography,boat_class,counts_for_ranking,reviewed_at,venue,organizer,nor_url,
  official_results_url,official_results_source_name,schedule_notes,status)
 values(sh->>'name',sh->>'slug',eid,(e->>'startDate')::date,(e->>'endDate')::date,
  (sh->>'totalFleetSize')::integer,sh->>'division',(sh->>'raceCount')::integer,
  'THA',sh->>'boatClass',false,now(),e->>'venue',e->>'organizer',e->>'norUrl',
  m->'officialSource'->>'url',m->'officialSource'->>'title',
  'Official notice board labels source Final; PDF body says provisional as of '||(m->'officialSource'->>'statusAsOf')||'. All pages visually checked; race scores, codes and printed discards retained. Outside Singapore national ranking.', 'published')
 on conflict(slug) do update set event_id=excluded.event_id,date=excluded.date,end_date=excluded.end_date,
   total_fleet_size=excluded.total_fleet_size,division=excluded.division,race_count=excluded.race_count,
   boat_class=excluded.boat_class,counts_for_ranking=false,reviewed_at=now(),
   official_results_url=excluded.official_results_url,official_results_source_name=excluded.official_results_source_name,
   schedule_notes=excluded.schedule_notes,status='published',updated_at=now()
 returning id into rid;
 for row in select value from jsonb_array_elements(m->'results') loop
  sid=(row->>'sailorId')::uuid; np=row->'newProfile';
  if np is not null then
   insert into sailors(id,name,handle,sail_number,sail_number_ilca4,club,nationality,gender)
   values(sid,np->>'name',np->>'handle',np->>'sailNumber',np->>'sailNumberIlca4',np->>'club',np->>'nationality',np->>'gender')
   on conflict(id) do nothing;
   if not exists(select 1 from sailors where id=sid and handle=np->>'handle') then
    raise exception 'New profile identity conflict %',sid;
   end if;
  end if;
  if not exists(select 1 from sailors where id=sid) then raise exception 'Missing matched sailor %',sid; end if;
  insert into regatta_results(sailor_id,regatta_id,rank,total_score,nett_score,gender,birth_year,nationality,
    entry_label,entry_sail_number,entry_type,evidence_url,evidence_name,evidence_type,official_url,
    evidence_notes,verification_status,verified_at)
  values(sid,rid,(row->>'rank')::integer,(row->>'grossScore')::real,(row->>'nettScore')::real,
    row->>'gender',(row->>'birthYear')::integer,row->>'nationality',
    row->>'name',row->>'sailOrBoardNumber','individual',
    m->'officialSource'->>'url',m->'officialSource'->>'title','pdf',m->'officialSource'->>'url',
    'Official source name: '||(row->>'name')||'; historic sail: '||(row->>'sailOrBoardNumber')||
    '; source club: '||(row->>'club')||'; source nationality: '||(row->>'sourceNationality')||
    '; source YOB: '||(row->>'sourceYob')||'; source page: '||(row->>'sourcePage')||
    '. Source SHA256: '||(m->'officialSource'->>'sha256')||
    '. Official notice board labels document Final; PDF body explicitly provisional as of '||(m->'officialSource'->>'statusAsOf')||
    '. All source pages rendered and visually compared; every score, code, discard, gross/net and fleet rank reconciled. Races: '||
    (select string_agg(value->>'sourceColumn',', ' order by (value->>'raceNumber')::int) from jsonb_array_elements(row->'races'))||
    '. Identity: '||(row->>'matchReason')||' '||coalesce(row->>'metadataNotes','')||
    ' Existing profile metadata retained. Verified means checked against this official source, not an independent finality claim.',
    'verified',now())
  on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,total_score=excluded.total_score,
    nett_score=excluded.nett_score,gender=excluded.gender,birth_year=excluded.birth_year,nationality=excluded.nationality,
    entry_label=excluded.entry_label,entry_sail_number=excluded.entry_sail_number,
    evidence_url=excluded.evidence_url,evidence_name=excluded.evidence_name,evidence_type=excluded.evidence_type,
    official_url=excluded.official_url,evidence_notes=excluded.evidence_notes,
    verification_status='verified',verified_at=now(),updated_at=now()
  returning id into rrid;
  insert into regatta_result_participants(regatta_result_id,sailor_id,source_name,display_order,role,match_status,ranking_credit)
  values(rrid,sid,row->>'name',1,'solo','matched',false)
  on conflict(regatta_result_id,display_order) do update set sailor_id=excluded.sailor_id,source_name=excluded.source_name,
    role='solo',match_status='matched',ranking_credit=false,updated_at=now();
  for race in select value from jsonb_array_elements(row->'races') loop
   insert into regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value)
   values(rrid,(race->>'raceNumber')::integer,(race->>'score')::real,race->>'code',(race->>'discarded')::boolean,race->>'raw')
   on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,
    discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();
  end loop;
  select count(*),sum(score::double precision),sum(score::double precision) filter(where not discarded),count(*) filter(where discarded)
   into n,gross,net,disc from regatta_race_results where regatta_result_id=rrid;
  if n<>8 or abs(gross-(row->>'grossScore')::double precision)>0.0001
     or abs(net-(row->>'nettScore')::double precision)>0.0001
     or disc<>(case when sh->>'boatClass'='Optimist' then 2 else 1 end) then
    raise exception 'Row reconciliation failed: % rank % (% / % / %)',sh->>'slug',row->>'rank',n,gross,net;
  end if;
 end loop;
 select count(*) into n from regatta_results where regatta_id=rid;
 if n<>jsonb_array_length(m->'results') then raise exception 'Result count %',n; end if;
 select count(*) into n from regatta_race_results x join regatta_results y on y.id=x.regatta_result_id where y.regatta_id=rid;
 if n<>8*jsonb_array_length(m->'results') then raise exception 'Race count %',n; end if;
 select count(*) into n from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where r.regatta_id=rid;
 if n<>jsonb_array_length(m->'results') then raise exception 'Participant count %',n; end if;
end $import$;
commit;
"""
 (b/(key+'.sql')).write_text(sql)
 print(key,len(sql))
