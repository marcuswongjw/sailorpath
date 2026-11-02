begin;
set local lock_timeout='8s';
do $exclude$
begin
 if not exists(select 1 from regattas where id='06645ac7-6a03-5dcf-b0cf-dda3359e380e' and slug='yrat-cup-series-5-2025-ilca7-master' and division='Master') then
 raise exception 'Expected Masters sheet not found'; end if;
 if exists(select 1 from regattas where id='06645ac7-6a03-5dcf-b0cf-dda3359e380e' and status='published') then
 update regattas set status='draft',updated_at=now() where id='06645ac7-6a03-5dcf-b0cf-dda3359e380e';
 insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
 values('results.exclude_masters','regatta','06645ac7-6a03-5dcf-b0cf-dda3359e380e','2025 YRAT Cup Series 5 — ILCA 7 Master','Unpublished Masters sheet under user instruction: load 2025 Optimist and ILCA 4/6/7; do not import Master.',jsonb_build_object('previousStatus','published','status','draft','resultsRetained',5),'sail-result-2025-exclude-masters-2026-10-30');
 end if;
end $exclude$;
commit;
