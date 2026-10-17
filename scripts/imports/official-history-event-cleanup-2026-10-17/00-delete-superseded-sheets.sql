-- User explicitly requested deleting the old events after their official replacements were verified.
-- Only the three archived summary sheets are deleted. Canonical official entries/races stay unchanged.
begin;
set local lock_timeout='5s';
do $cleanup$
declare item record; old regattas%rowtype; canonical regattas%rowtype;
result_hash text; race_hash text; participant_hash text;
begin
for item in select * from (values
('snsc-silver-sep-23-2023-09-02','snsc-optimist-silver-2023',99,102,9,918),
('nsc-cup-gold-jul-23-2023-07-22','nsc-cup-optimist-gold-2023',80,81,7,567),
('nsc-cup-silver-jul-23-2023-07-22','nsc-cup-optimist-silver-2023',90,91,7,637)
) x(old_slug,canonical_slug,old_count,new_count,races,new_race_rows) loop
select * into strict canonical from regattas where slug=item.canonical_slug for update;
select * into old from regattas where slug=item.old_slug for update;
if old.id is null then
 if exists(select 1 from admin_change_log where source='official-history-event-cleanup-2026-10-17' and action='regattas.delete_superseded' and entity_id=canonical.id and details->>'deletedSlug'=item.old_slug) then continue; end if;
 raise exception 'Missing old sheet without completed deletion audit: %',item.old_slug;
end if;
if old.status<>'archived' or old.counts_for_ranking is distinct from false or canonical.status<>'published' or canonical.counts_for_ranking is distinct from true then raise exception 'Unexpected lifecycle state'; end if;
if old.date<>canonical.date or old.boat_class<>canonical.boat_class or old.division<>canonical.division then raise exception 'Replacement identity differs'; end if;
if canonical.race_count<>item.races or canonical.official_results_url is null then raise exception 'Incomplete canonical sheet'; end if;
if (select count(*) from regatta_results where regatta_id=old.id)<>item.old_count or (select count(*) from regatta_results where regatta_id=canonical.id)<>item.new_count then raise exception 'Entry inventory changed'; end if;
if exists(select 1 from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=old.id) then raise exception 'Old sheet now owns race data; reconcile it before deletion'; end if;
if (select count(*) from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=canonical.id)<>item.new_race_rows then raise exception 'Canonical race inventory changed'; end if;
if exists(select 1 from equipment_logs where regatta_id=old.id) or exists(select 1 from equipment_usages where regatta_id=old.id) or exists(select 1 from news_articles where related_regatta_id=old.id) or exists(select 1 from race_observations where regatta_id=old.id) then raise exception 'Old sheet still has non-result references; reconcile before deleting'; end if;
if old.event_id is not null then raise exception 'Review the old parent-event relationship before deletion'; end if;
select md5(jsonb_agg(to_jsonb(r) order by r.id)::text) into result_hash from regatta_results r where regatta_id=canonical.id;
select md5(jsonb_agg(to_jsonb(rr) order by rr.id)::text) into race_hash from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=canonical.id;
select md5(jsonb_agg(to_jsonb(p) order by p.id)::text) into participant_hash from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where r.regatta_id=canonical.id;
insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
values('regattas.delete_superseded','regatta',canonical.id,canonical.name,'Deleted the user-identified archived legacy summary after verifying its published official replacement.',
jsonb_build_object('deletedSlug',old.slug,'deletedSheet',to_jsonb(old),'oldResults',(select jsonb_agg(to_jsonb(r)) from regatta_results r where regatta_id=old.id),'oldParticipants',(select jsonb_agg(to_jsonb(p)) from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where r.regatta_id=old.id),'replacementId',canonical.id,'replacementSlug',canonical.slug,'canonicalResultHash',result_hash,'canonicalRaceHash',race_hash,'authorization','User requested old events be deleted when official replacements exist, 17 October 2026'),
'official-history-event-cleanup-2026-10-17');
delete from regatta_result_participants where regatta_result_id in(select id from regatta_results where regatta_id=old.id);
delete from regatta_results where regatta_id=old.id;
delete from regattas where id=old.id;
if result_hash is distinct from (select md5(jsonb_agg(to_jsonb(r) order by r.id)::text) from regatta_results r where regatta_id=canonical.id) then raise exception 'Canonical results changed'; end if;
if race_hash is distinct from (select md5(jsonb_agg(to_jsonb(rr) order by rr.id)::text) from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=canonical.id) then raise exception 'Canonical race scores/evidence changed'; end if;
if participant_hash is distinct from (select md5(jsonb_agg(to_jsonb(p) order by p.id)::text) from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where r.regatta_id=canonical.id) then raise exception 'Canonical participant links changed'; end if;
end loop;
end $cleanup$;
commit;
