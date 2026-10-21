begin;
set local lock_timeout='5s';
set local statement_timeout='30s';
create temporary table csc_monthly_target_events on commit drop as select id from regatta_events where slug like 'csc-monthly-dinghy-race-%';
create temporary table csc_monthly_target_sheets on commit drop as select id from regattas where slug like 'csc-monthly-dinghy-race-%';
do $remove$
begin
 if (select count(*) from csc_monthly_target_events)<>4 or (select count(*) from csc_monthly_target_sheets)<>18
 or (select count(*) from regatta_results where regatta_id in (select id from csc_monthly_target_sheets))<>101
 or (select count(*) from regatta_race_results where regatta_result_id in (select id from regatta_results where regatta_id in (select id from csc_monthly_target_sheets)))<>205
 or exists(select 1 from regattas where event_id in (select id from csc_monthly_target_events) and id not in (select id from csc_monthly_target_sheets))
 then raise exception 'Removal inventory changed; abort';end if;
 if exists(select 1 from race_observations where regatta_id in (select id from csc_monthly_target_sheets))
 or exists(select 1 from equipment_logs where regatta_id in (select id from csc_monthly_target_sheets))
 or exists(select 1 from equipment_usages where regatta_id in (select id from csc_monthly_target_sheets))
 or exists(select 1 from news_articles where related_regatta_id in (select id from csc_monthly_target_sheets) or related_event_id in (select id from csc_monthly_target_events))
 then raise exception 'Non-results links require review';end if;
end $remove$;
delete from regattas where id in (select id from csc_monthly_target_sheets);
delete from regatta_events where id in (select id from csc_monthly_target_events);
insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
values('delete','regatta_events',null,'CSC Monthly Dinghy Races','User-authorized removal: 4 monthly events, 18 sheets, 101 entries and 205 race scores.',
jsonb_build_object('authorization','User: Remove all the CSC monthly dinghy races on Sailorpath','eventIds',(select jsonb_agg(id) from csc_monthly_target_events),'sheetIds',(select jsonb_agg(id) from csc_monthly_target_sheets),'backup','outputs/csc-monthly-removal-2026-10-20/production-backup.json'),'csc-monthly-removal-2026-10-20');
commit;
