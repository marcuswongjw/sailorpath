"""Generate the explicitly requested Markus identity resolution and Newborn removal.

The original manifests remain historical import evidence. Do not replay removed
Newborn sheets; see user-cleanup-20261022.json. No unrelated files are changed.
"""
import hashlib
import json
import uuid
from pathlib import Path

root = Path('scripts/imports/sail-result-2026')
out = Path('outputs/newborn-removal-20261022')
b = json.loads((out / 'recovery-snapshot.json').read_text())
original = json.loads((root / 'acdc-cup-international-sailing-championship-2026-ilca4.json').read_text())
raw = json.loads(Path('.work/sail-result-2026/acdc-cup-international-sailing-championship-2026-ilca4-normalized.json').read_text())
r = next(x for x in raw['results'] if x['name'] == 'DOH VINNA')
sid = b['markus'][0]['id']
rid = str(uuid.uuid5(uuid.NAMESPACE_URL, 'sailorpath:user-confirmed:2026-acdc-ilca4:doh-vinna'))
m = dict(sailorIds=[s['id'] for s in b['sailors']], sheetIds=[s['id'] for s in b['regattas']],
         result=r, sailorId=sid, resultId=rid, sheetId=original['sheet']['id'],
         officialSource=original['officialSource'],
         backupSha256=hashlib.sha256((out / 'recovery-snapshot.json').read_bytes()).hexdigest())
payload = json.dumps(m, ensure_ascii=False, separators=(',', ':'))
sql = r'''begin;
do $cleanup$
declare
 m jsonb := $manifest$__MANIFEST__$manifest$::jsonb;
 ids uuid[]; gids uuid[]; sid uuid; rid uuid; gid uuid; n int; x jsonb; t text;
 before_sailors text; before_results text; before_races text; before_participants text;
begin
 perform pg_advisory_xact_lock(hashtext('sail-result-2026-user-cleanup-20261022'));
 if exists(select 1 from admin_change_log where source='sail-result-2026-user-cleanup-20261022' and action='results.remove_newborn') then
   raise notice 'Already applied'; return;
 end if;
 select array_agg(value::uuid) into ids from jsonb_array_elements_text(m->'sailorIds');
 select array_agg(value::uuid) into gids from jsonb_array_elements_text(m->'sheetIds');
 sid := (m->>'sailorId')::uuid; rid := (m->>'resultId')::uuid; gid := (m->>'sheetId')::uuid;
 lock table sailors,regattas,regatta_results,regatta_race_results,regatta_result_participants,sailor_aliases in share row exclusive mode;
 if (select count(*) from regattas where id=any(gids) and boat_class='Optimist' and division='Newborn')<>5
 or (select count(*) from regatta_results where regatta_id=any(gids))<>129
 or (select count(*) from regatta_race_results where regatta_result_id in(select id from regatta_results where regatta_id=any(gids)))<>816
 or (select count(*) from sailors where id=any(ids))<>36 then raise exception 'Removal inventory changed'; end if;
 if exists(select 1 from sailors where id=any(ids) and parent_id is not null)
 or exists(select 1 from regatta_results where sailor_id=any(ids) and not(regatta_id=any(gids)))
 or exists(select 1 from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where p.sailor_id=any(ids) and not(r.regatta_id=any(gids)))
 then raise exception 'A target sailor has another result or account connection'; end if;
 foreach t in array array['sailor_claims','sailor_aliases','race_observations','equipment_logs','equipment_items','equipment_usages','parent_notes','coach_action_reviews','coach_squad_members','coach_sailor_notes','coach_followed_sailors','coach_development_records','followed_sailors','asian_optimist_index_sailors'] loop
  execute format('select count(*) from %I where sailor_id=any($1)',t) into n using ids;
  if n<>0 then raise exception 'Unexpected sailor dependency: %',t; end if;
 end loop;
 if exists(select 1 from asian_optimist_index_duplicate_reviews where candidate_sailor_id=any(ids))
 or exists(select 1 from news_articles where related_sailor_id=any(ids))
 or exists(select 1 from race_observations where regatta_id=any(gids))
 or exists(select 1 from equipment_logs where regatta_id=any(gids))
 or exists(select 1 from equipment_usages where regatta_id=any(gids))
 or exists(select 1 from news_articles where related_regatta_id=any(gids))
 then raise exception 'Unexpected sheet/profile dependency'; end if;
 if not exists(select 1 from sailors where id=sid and name='Markus Doh Vinna')
 or exists(select 1 from regatta_results where regatta_id=gid and (sailor_id=sid or rank=4))
 or exists(select 1 from sailor_aliases where lower(alias_name)='doh vinna' and sailor_id<>sid)
 then raise exception 'Markus identity preflight changed'; end if;

 select md5(coalesce(jsonb_agg(to_jsonb(s) order by id),'[]'::jsonb)::text) into before_sailors from sailors s where not(id=any(ids));
 select md5(coalesce(jsonb_agg(to_jsonb(r) order by id),'[]'::jsonb)::text) into before_results from regatta_results r where not(regatta_id=any(gids));
 select md5(coalesce(jsonb_agg(to_jsonb(r) order by id),'[]'::jsonb)::text) into before_races from regatta_race_results r where regatta_result_id not in(select id from regatta_results where regatta_id=any(gids));
 select md5(coalesce(jsonb_agg(to_jsonb(p) order by id),'[]'::jsonb)::text) into before_participants from regatta_result_participants p where regatta_result_id not in(select id from regatta_results where regatta_id=any(gids));

 insert into admin_change_log(action,entity_type,entity_label,summary,details,source)
 values('results.remove_newborn','regatta','Optimist Newborn','User requested removal of all Newborn sheets and profiles with exclusively Newborn results.',jsonb_build_object(
 'recoverySnapshotSha256',m->>'backupSha256','sheetIds',m->'sheetIds','deletedSailors',(select jsonb_agg(jsonb_build_object('id',id,'name',name,'handle',handle)) from sailors where id=any(ids)),
 'sheetCount',5,'resultCount',129,'raceCount',816,'sailorCount',36,'retainedMixedFleetSailors',41),'sail-result-2026-user-cleanup-20261022');
 delete from regattas where id=any(gids);
 delete from sailors where id=any(ids);
 if exists(select 1 from regattas where concat_ws(' ',name,boat_class,division,slug) ~* 'new.?born')
 or exists(select 1 from sailors where id=any(ids)) then raise exception 'Removal incomplete'; end if;

 x:=m->'result';
 insert into regatta_results(id,sailor_id,regatta_id,entry_label,entry_sail_number,entry_type,rank,total_score,nett_score,gender,nationality,birth_year,is_dns,is_overseas_commitment,official_url,evidence_url,evidence_name,evidence_type,evidence_notes,verification_status,verified_at)
 values(rid,sid,gid,x->>'name',x->>'sailOrBoardNumber','individual',(x->>'rank')::int,(x->>'grossScore')::real,(x->>'nettScore')::real,x->>'gender',x->>'nationality',(x->>'officialBirthYear')::int,false,false,m#>>'{officialSource,url}',m#>>'{officialSource,url}',m#>>'{officialSource,title}','pdf','Official source name DOH VINNA; sail 209947. User confirmed on 22 October 2026 that this result belongs to Markus Doh Vinna. Twelve race scores, two discards and UFD preserved.','verified',now());
 insert into regatta_result_participants(regatta_result_id,sailor_id,source_name,display_order,role,match_status,ranking_credit)
 values(rid,sid,'DOH VINNA',1,'solo','matched',false);
 insert into regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value)
 select rid,(a->>'raceNumber')::int,(a->>'score')::real,a->>'code',(a->>'discarded')::boolean,a->>'raw' from jsonb_array_elements(x->'races') a;
 insert into sailor_aliases(sailor_id,alias_name) select sid,'DOH VINNA' where not exists(select 1 from sailor_aliases where sailor_id=sid and lower(alias_name)='doh vinna');
 update regattas set schedule_notes=replace(schedule_notes,'23 of 25 entries imported; 2 awaiting identity review','24 of 25 entries imported; 1 awaiting identity review'),updated_at=now() where id=gid;
 if not exists(select 1 from regatta_race_results where regatta_result_id=rid group by regatta_result_id having count(*)=12 and abs(sum(score)-102)<.001 and abs(sum(score) filter(where not discarded)-62)<.001 and count(*) filter(where discarded)=2 and count(*) filter(where scoring_code='UFD' and discarded)=1)
 or (select count(*) from regatta_results where regatta_id=gid)<>24 then raise exception 'Markus result reconciliation failed'; end if;
 insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
 values('results.resolve_sailor_identity','sailor',sid,'Markus Doh Vinna','Attached previously held DOH VINNA result after explicit user identity confirmation.',jsonb_build_object('resultId',rid,'regattaId',gid,'officialSource',m->'officialSource','rank',4,'raceCount',12,'gross',102,'nett',62,'sourceSailNumber','209947','profileUnchanged',true),'sail-result-2026-user-cleanup-20261022');

 if before_sailors is distinct from (select md5(coalesce(jsonb_agg(to_jsonb(s) order by id),'[]'::jsonb)::text) from sailors s)
 or before_results is distinct from (select md5(coalesce(jsonb_agg(to_jsonb(r) order by id),'[]'::jsonb)::text) from regatta_results r where id<>rid)
 or before_races is distinct from (select md5(coalesce(jsonb_agg(to_jsonb(r) order by id),'[]'::jsonb)::text) from regatta_race_results r where regatta_result_id<>rid)
 or before_participants is distinct from (select md5(coalesce(jsonb_agg(to_jsonb(p) order by id),'[]'::jsonb)::text) from regatta_result_participants p where regatta_result_id<>rid)
 then raise exception 'Unrelated profile/results changed'; end if;
end $cleanup$;
commit;
select action,summary,details from admin_change_log where source='sail-result-2026-user-cleanup-20261022' order by created_at;
'''.replace('__MANIFEST__', payload)
(root / 'user-cleanup-20261022.sql').write_text(sql)
(root / 'user-cleanup-20261022.json').write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
print('Generated guarded cleanup: 5 sheets, 129 entries, 816 scores, 36 profiles removed; Markus result +12 scores.')
