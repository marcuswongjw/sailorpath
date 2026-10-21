"""Apply the user's explicit 21 October confirmation to the reviewed manifests."""
import json
from pathlib import Path
O=Path('scripts/imports/thai-regattas-2025')
profiles=json.loads((O/'new-profiles.json').read_text());byname={p['name']:p for p in profiles}
pairs=[('Jirathip Mutiphan','Jiratip Mutiphan'),('Natthaphatr Poolklang','Natthapatr Poolklang')]
remap={byname[old]['id']:byname[new]['id'] for old,new in pairs}
byname['Jiratip Mutiphan']['sailNumberIlca4']='9'
kept=[p for p in profiles if p['id'] not in remap];byid={p['id']:p for p in kept}
review=json.loads((O/'identity-review.json').read_text())
for x in review:
 if x['sailorId'] in remap:
  x['sailorId']=remap[x['sailorId']];x['profileName']=byid[x['sailorId']]['name'];x['basis']='User explicitly confirmed each spelling pair is one sailor on21 October2026; historic source name and number retained.'
for path in O.glob('*.json'):
 m=json.loads(path.read_text())
 if not isinstance(m,dict) or 'results' not in m:continue
 for r in m['results']:
  changed=False
  for part in r['participants']:
   if part['sailorId'] in remap:
    part['sailorId']=remap[part['sailorId']];part['basis']='User explicitly confirmed each spelling pair is one sailor on21 October2026; historic source name and number retained.';changed=True
  r['sailorId']=r['participants'][0]['sailorId']
  if changed:r['evidenceNotes']+=' User explicitly confirmed Jiratip/Jirathip Mutiphan and Natthapatr/Natthaphatr Poolklang are respectively the same sailor on21 October2026.'
 ids={a['sailorId'] for r in m['results'] for a in r['participants']}
 m['newProfiles']=[p for p in kept if p['id'] in ids]
 m['identityReview']=[x for x in review if x['sheet']==m['sheet']['slug']]
 path.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
(O/'identity-review.json').write_text(json.dumps(review,ensure_ascii=False,indent=2)+'\n')
(O/'new-profiles.json').write_text(json.dumps(kept,ensure_ascii=False,indent=2)+'\n')
(O/'user-identity-confirmation.json').write_text(json.dumps({'date':'2026-10-21','userAnswer':'Treat each pair as one sailor','pairs':[{'sourceNames':[old,new],'canonicalProfile':byname[new]} for old,new in pairs]},ensure_ascii=False,indent=2)+'\n')
# Only Jirathip had already been created by the first class-sheet transaction.
old=byname['Jirathip Mutiphan'];target=byname['Jiratip Mutiphan']
m=json.loads((O/'eastern-seaboard-regatta-2025-ilca4.json').read_text());r=next(x for x in m['results'] if x['name']=='JIRATHIP MUTIPHAN')
q=lambda s:"'"+s.replace("'","''")+"'"
sql='''begin;
set local lock_timeout='8s';
do $merge$
declare
 old_id uuid := '__OLD__'; keep_id uuid := '__KEEP__'; rid uuid := '__RESULT__';
 old_profile jsonb; keep_profile jsonb; prior_result jsonb; prior_participants jsonb;
 fk record; related_count bigint; before_scores text; after_scores text;
begin
 perform 1 from sailors where id in(old_id,keep_id) order by id for update;
 select to_jsonb(s) into old_profile from sailors s where id=old_id;
 select to_jsonb(s) into keep_profile from sailors s where id=keep_id;
 if old_profile is null then
  if exists(select 1 from admin_change_log where action='sailor.merge_user_confirmed_thai2025' and entity_id=keep_id) then return; end if;
  raise exception 'Source profile missing without merge audit';
 end if;
 if old_profile->>'handle'<>'jirathip-mutiphan-thai25-78bad8' or keep_profile->>'handle'<>'jiratip-mutiphan-thai25-5cd22c' or old_profile->>'nationality'<>'THA' or keep_profile->>'nationality'<>'THA' or old_profile->>'gender'<>'M' or keep_profile->>'gender'<>'M' or old_profile->>'parent_id' is not null then raise exception 'Confirmed-pair profile preflight differs'; end if;
 if (select count(*) from regatta_results where sailor_id=old_id)<>1 or not exists(select 1 from regatta_results where id=rid and sailor_id=old_id) or (select count(*) from regatta_result_participants where sailor_id=old_id)<>1 then raise exception 'Unexpected source relationships'; end if;
 for fk in
  select tc.table_schema,tc.table_name,kcu.column_name from information_schema.table_constraints tc join information_schema.key_column_usage kcu on kcu.constraint_name=tc.constraint_name and kcu.constraint_schema=tc.constraint_schema join information_schema.constraint_column_usage ccu on ccu.constraint_name=tc.constraint_name and ccu.constraint_schema=tc.constraint_schema where tc.constraint_type='FOREIGN KEY' and ccu.table_name='sailors' and tc.table_schema='public' and tc.table_name not in('regatta_results','regatta_result_participants')
 loop
  execute format('select count(*) from %I.%I where %I=$1',fk.table_schema,fk.table_name,fk.column_name) into related_count using old_id;
  if related_count<>0 then raise exception 'Unexpected source references in %',fk.table_name; end if;
 end loop;
 select to_jsonb(z) into prior_result from regatta_results z where id=rid;
 select jsonb_agg(to_jsonb(z)) into prior_participants from regatta_result_participants z where regatta_result_id=rid;
 select md5(jsonb_agg(to_jsonb(z) order by z.race_number)::text) into before_scores from regatta_race_results z where regatta_result_id=rid;
 update regatta_result_participants set sailor_id=keep_id where sailor_id=old_id and regatta_result_id=rid;
 update regatta_results set sailor_id=keep_id,evidence_notes=__NOTES__ where id=rid;
 update sailors set sail_number_ilca4='9' where id=keep_id;
 delete from sailors where id=old_id;
 insert into sailor_aliases(sailor_id,alias_name) values(keep_id,'JIRATIP MUTIPHAN'),(keep_id,'JIRATHIP MUTIPHAN') on conflict(alias_name) do nothing;
 if (select count(*) from sailor_aliases where sailor_id=keep_id and alias_name in('JIRATIP MUTIPHAN','JIRATHIP MUTIPHAN'))<>2 then raise exception 'Alias conflicts'; end if;
 select md5(jsonb_agg(to_jsonb(z) order by z.race_number)::text) into after_scores from regatta_race_results z where regatta_result_id=rid;
 if before_scores is distinct from after_scores then raise exception 'Scores changed during identity consolidation'; end if;
 insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source) values('sailor.merge_user_confirmed_thai2025','sailor',keep_id,'Jiratip Mutiphan','User confirmed Jiratip/Jirathip are one sailor. Retained historic entry labels and race scores.',jsonb_build_object('userConfirmation','Treat each pair as one sailor','sourceProfileSnapshot',old_profile,'keptProfileSnapshot',keep_profile,'priorResult',prior_result,'priorParticipants',prior_participants,'movedResultId',rid,'scoreDigest',after_scores),'thai-regattas-2025-2026-10-21');
end $merge$;
commit;
'''.replace('__OLD__',old['id']).replace('__KEEP__',target['id']).replace('__RESULT__',r['resultId']).replace('__NOTES__',q(r['evidenceNotes']))
(O/'confirm-jiratip-identity.sql').write_text(sql)
print('Confirmed profiles:',[(old,new) for old,new in pairs],'new profiles',len(kept))
