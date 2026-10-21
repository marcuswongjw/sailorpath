begin;
set local lock_timeout='8s';
do $merge$
declare
 old_id uuid := '78bad810-b7a7-56de-a596-b27f28bb9c2f'; keep_id uuid := '5cd22c52-558f-598e-84df-07fbb27b43fc'; rid uuid := '0a4a9f07-1f4e-5b23-a671-c85e44eb4b0c';
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
 update regatta_results set sailor_id=keep_id,evidence_notes='Official provisional source: JIRATHIP MUTIPHAN; historic sail/boat 9; source club YRAT; source nationality THA; source YOB 2010. All 11 races, scoring codes and one discard preserved; gross/net reconciled. Verified means checked against this source, not a finality claim. No existing exact name/accepted alias or independently corroborated variant. Preserve distinct official identity; no birth date invented. User explicitly confirmed Jiratip/Jirathip Mutiphan and Natthapatr/Natthaphatr Poolklang are respectively the same sailor on21 October2026.' where id=rid;
 update sailors set sail_number_ilca4='9' where id=keep_id;
 delete from sailors where id=old_id;
 insert into sailor_aliases(sailor_id,alias_name) values(keep_id,'JIRATIP MUTIPHAN'),(keep_id,'JIRATHIP MUTIPHAN') on conflict(alias_name) do nothing;
 if (select count(*) from sailor_aliases where sailor_id=keep_id and alias_name in('JIRATIP MUTIPHAN','JIRATHIP MUTIPHAN'))<>2 then raise exception 'Alias conflicts'; end if;
 select md5(jsonb_agg(to_jsonb(z) order by z.race_number)::text) into after_scores from regatta_race_results z where regatta_result_id=rid;
 if before_scores is distinct from after_scores then raise exception 'Scores changed during identity consolidation'; end if;
 insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source) values('sailor.merge_user_confirmed_thai2025','sailor',keep_id,'Jiratip Mutiphan','User confirmed Jiratip/Jirathip are one sailor. Retained historic entry labels and race scores.',jsonb_build_object('userConfirmation','Treat each pair as one sailor','sourceProfileSnapshot',old_profile,'keptProfileSnapshot',keep_profile,'priorResult',prior_result,'priorParticipants',prior_participants,'movedResultId',rid,'scoreDigest',after_scores),'thai-regattas-2025-2026-10-21');
end $merge$;
commit;
