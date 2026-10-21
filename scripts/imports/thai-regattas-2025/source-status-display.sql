begin;
do $status$
declare changed_count int;
begin
 if (select count(*) from regattas where (slug like 'admirals-cup-2025-%' or slug like 'eastern-seaboard-regatta-2025-%') and schedule_notes in('Official provisional results, checked against the organiser-published source. Every race, discard and scoring code retained. Does not count for Singapore national rankings.','Official source status: provisional. Checked against the organiser-published source. Every race, discard and scoring code retained. Does not count for Singapore national rankings.'))<>6 then raise exception 'Unexpected status text; review'; end if;
 update regattas set schedule_notes='Official source status: provisional. Checked against the organiser-published source. Every race, discard and scoring code retained. Does not count for Singapore national rankings.' where slug like 'admirals-cup-2025-%' or slug like 'eastern-seaboard-regatta-2025-%';
 update regatta_events set schedule_summary='Official source status: provisional. Checked against the organiser-published source. Every race, discard and scoring code retained. Does not count for Singapore national rankings.' where slug in('admirals-cup-2025','eastern-seaboard-regatta-2025') and schedule_summary in('Official provisional results, checked against the organiser-published source. Every race, discard and scoring code retained. Does not count for Singapore national rankings.','Official source status: provisional. Checked against the organiser-published source. Every race, discard and scoring code retained. Does not count for Singapore national rankings.');
 get diagnostics changed_count=row_count;
 if changed_count<>2 then raise exception 'Parent source status differs'; end if;
 insert into admin_change_log(action,entity_type,summary,details,source)
 select 'results.source_status_display_thai2025','regatta','Use canonical provisional metadata wording so every fleet badge matches the organiser source.',jsonb_build_object('before','Official provisional results, checked against the organiser-published source. Every race, discard and scoring code retained. Does not count for Singapore national rankings.','after','Official source status: provisional. Checked against the organiser-published source. Every race, discard and scoring code retained. Does not count for Singapore national rankings.','sheets',6,'scoreRowsChanged',0),'thai-regattas-2025-2026-10-21'
 where not exists(select 1 from admin_change_log where action='results.source_status_display_thai2025');
end $status$;
commit;
