import json
import subprocess
import uuid
from pathlib import Path

out = Path(__file__).parent
pre = json.loads((out / 'preflight.json').read_text())
source_rows = json.loads((out / 'source-rows.json').read_text())
nat_id = str(uuid.uuid5(uuid.NAMESPACE_URL, 'sailorpath:confirmed-distinct:natidej-termtakulwattana-20261022'))
targets = {'HENRY ATICHAT WIEDMANN': 'bdcd0461-7642-50c2-9dca-65b6d4d56020',
           'JIAHE LIU': 'e1a6517e-a545-5518-ab52-d34c4a13abf4',
           'NATIDEJ TERMTAKULWATTANA': nat_id}
template = r'''begin;
do $resolve$
declare
 m jsonb := $manifest$__MANIFEST__$manifest$::jsonb;
 r jsonb; a jsonb; sid uuid; rid uuid; gid uuid; old_count int; before_rows text; profile_before text; other_nat_before text; new_count int; notes text;
begin
 perform pg_advisory_xact_lock(hashtext('sail-result-2026-identities-20261022'));
 sid:=(m->>'sailorId')::uuid; rid:=(m->>'resultId')::uuid; gid:=(m#>>'{sheet,id}')::uuid; r:=m#>'{results,0}';
 perform 1 from regattas where id=gid for update;
 if exists(select 1 from admin_change_log where source='sail-result-2026-identities-20261022' and entity_id=rid) then
  if not exists(select 1 from regatta_results where id=rid and sailor_id=sid) then raise exception 'Previously imported result missing'; end if;
  return;
 end if;
 select count(*),md5(coalesce(jsonb_agg(to_jsonb(q) order by id),'[]'::jsonb)::text) into old_count,before_rows from regatta_results q where regatta_id=gid;
 if old_count<>(m->>'expectedBefore')::int or not exists(select 1 from regattas where id=gid and status='published' and boat_class=m#>>'{sheet,boatClass}' and race_count=(m#>>'{sheet,raceCount}')::int and not counts_for_ranking)
 or exists(select 1 from regatta_results where regatta_id=gid and (sailor_id=sid or rank=(r->>'rank')::int)) then raise exception 'Sheet inventory or identity changed'; end if;
 select md5(to_jsonb(s)::text) into other_nat_before from sailors s where id='8f2e850e-bd71-53f9-b24b-f34fe4148bd7';
 if (m->>'createProfile')::boolean then
  if exists(select 1 from sailors where lower(name)='natidej termtakulwattana' or id=sid) then raise exception 'Distinct Natidej profile already exists'; end if;
  insert into sailors(id,name,handle,sail_number,sail_number_ilca4,club,nationality,gender)
  values(sid,'Natidej Termtakulwattana',m->>'newHandle','','2','YRAT','THA','M');
 else
  perform 1 from sailors where id=sid for update;
  if not exists(select 1 from sailors where id=sid and name=m->>'expectedProfileName') then raise exception 'Canonical profile changed'; end if;
 end if;
 select md5(to_jsonb(s)::text) into profile_before from sailors s where id=sid;
 if exists(select 1 from sailor_aliases where lower(alias_name)=lower(r->>'name') and sailor_id<>sid) then raise exception 'Alias belongs to another profile'; end if;
 insert into regatta_results(id,sailor_id,regatta_id,entry_label,entry_sail_number,entry_type,rank,total_score,nett_score,gender,nationality,birth_year,is_dns,is_overseas_commitment,official_url,evidence_url,evidence_name,evidence_type,evidence_notes,verification_status,verified_at)
 values(rid,sid,gid,r->>'name',r->>'sailOrBoardNumber','individual',(r->>'rank')::int,(r->>'grossScore')::real,(r->>'nettScore')::real,r->>'gender',r->>'nationality',(r->>'officialBirthYear')::int,false,false,m#>>'{officialSource,url}',m#>>'{officialSource,url}',m#>>'{officialSource,title}',m#>>'{officialSource,type}',m->>'identityDecision','verified',now());
 insert into regatta_result_participants(regatta_result_id,sailor_id,source_name,display_order,role,match_status,ranking_credit)
 values(rid,sid,r->>'name',1,'solo','matched',false);
 insert into regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value)
 select rid,(x->>'raceNumber')::int,(x->>'score')::real,x->>'code',(x->>'discarded')::boolean,x->>'raw' from jsonb_array_elements(r->'races') x;
 insert into sailor_aliases(sailor_id,alias_name) select sid,r->>'name' where not exists(select 1 from sailor_aliases where sailor_id=sid and lower(alias_name)=lower(r->>'name'));
 new_count:=old_count+1;
 select regexp_replace(schedule_notes,' Partial import:.*$','') into notes from regattas where id=gid;
 if new_count<(m#>>'{sheet,totalFleetSize}')::int then notes:=notes||format(' Partial import: %s of %s entries imported; %s awaiting identity review.',new_count,m#>>'{sheet,totalFleetSize}',(m#>>'{sheet,totalFleetSize}')::int-new_count); end if;
 update regattas set schedule_notes=notes,updated_at=now() where id=gid;
 if (select count(*) from regatta_results where regatta_id=gid)<>new_count
 or not exists(select 1 from regatta_race_results where regatta_result_id=rid group by regatta_result_id having count(*)=(m#>>'{sheet,raceCount}')::int and abs(sum(score)-(r->>'grossScore')::real)<.001 and abs(sum(score) filter(where not discarded)-(r->>'nettScore')::real)<.001 and count(*) filter(where discarded)=(select count(*) from jsonb_array_elements(r->'races') x where (x->>'discarded')::boolean))
 or (select count(*) from regatta_result_participants where regatta_result_id=rid and sailor_id=sid and not ranking_credit)<>1 then raise exception 'Result reconciliation failed'; end if;
 for a in select value from jsonb_array_elements(r->'races') loop
  if not exists(select 1 from regatta_race_results where regatta_result_id=rid and race_number=(a->>'raceNumber')::int and score=(a->>'score')::real and scoring_code is not distinct from a->>'code' and discarded=(a->>'discarded')::boolean and raw_value=a->>'raw') then raise exception 'Race mismatch'; end if;
 end loop;
 if profile_before is distinct from (select md5(to_jsonb(s)::text) from sailors s where id=sid)
 or other_nat_before is distinct from (select md5(to_jsonb(s)::text) from sailors s where id='8f2e850e-bd71-53f9-b24b-f34fe4148bd7')
 or before_rows is distinct from (select md5(coalesce(jsonb_agg(to_jsonb(q) order by id),'[]'::jsonb)::text) from regatta_results q where regatta_id=gid and id<>rid)
 then raise exception 'Existing profile or results changed'; end if;
 insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
 values('results.resolve_sailor_identity','regatta_result',rid,r->>'name',m->>'identityDecision',jsonb_build_object('sailorId',sid,'sheetId',gid,'officialSource',m->'officialSource','rank',r->'rank','raceCount',m#>'{sheet,raceCount}','gross',r->'grossScore','nett',r->'nettScore','newProfile',m->'createProfile','existingProfilesUnchanged',true),'sail-result-2026-identities-20261022');
end $resolve$;
commit;
select entity_label,details from admin_change_log where source='sail-result-2026-identities-20261022' and entity_id='__RID__'::uuid;
'''
for m in source_rows:
    r=m.pop('result'); sid=targets[r['name']]
    m['sheet']['entryType']='individual'
    m['results']=[r]; m['sailorId']=sid
    m['resultId']=str(uuid.uuid5(uuid.NAMESPACE_URL,'sailorpath:confirmed-20261022:'+m['sheet']['slug']+':'+sid))
    m['createProfile']=sid==nat_id
    m['newHandle']='natidej-termtakulwattana-sr26-'+nat_id[:6]
    target=next((s for s in pre['sailors'] if s['id']==sid),None)
    m['expectedProfileName']=target['name'] if target else 'Natidej Termtakulwattana'
    m['expectedBefore']=next(s['count'] for s in pre['sheets'] if s['sheet']['id']==m['sheet']['id'])
    m['identityDecision']=('User confirmed on 22 October 2026: Natidej Termtakulwattana is a different sailor from Natidej Termwattanapakdee. Separate profile; official year 2012 retained on result only; profile DOB unknown.' if m['createProfile'] else f"User confirmed on 22 October 2026: official name {r['name']} is the same sailor as {target['name']}. Existing profile fields preserved; historic sail and nationality retained on this result.")
    slug=m['sheet']['slug']; path=out/(slug+'.json')
    path.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
    v=subprocess.run(['node','/Users/marcus/.agents/skills/sailorpath-official-results-import/scripts/validate_import_manifest.mjs',str(path)],capture_output=True,text=True)
    assert v.returncode==0,v.stdout+v.stderr
    print(v.stdout.strip())
    (out/(slug+'.sql')).write_text(template.replace('__MANIFEST__',json.dumps(m,ensure_ascii=False,separators=(',',':'))).replace('__RID__',m['resultId']))
print('4 entries, 34 race scores; one new separate profile',nat_id)
