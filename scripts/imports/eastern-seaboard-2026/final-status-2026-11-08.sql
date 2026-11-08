-- Final-status correction explicitly requested by the SailorPath owner.
-- Current official notice board labels documents 214659 and 214660 Final.
-- Retained PDF wording and per-result evidence remain the original import record.
begin;
set local lock_timeout='8s';
set local statement_timeout='30s';
do $final_status$
declare
 eid uuid;
 affected integer;
 results_before text;
 races_before text;
 results_after text;
 races_after text;
begin
 perform pg_advisory_xact_lock(hashtext('eastern-seaboard-regatta-2026'));
 select id into eid from regatta_events where slug='eastern-seaboard-regatta-2026' for update;
 if eid is null then raise exception 'Eastern Seaboard parent event is missing'; end if;
 if (select count(*) from regattas where event_id=eid)<>4 then raise exception 'Expected four result sheets'; end if;
 if (select count(*) from regatta_results r join regattas g on g.id=r.regatta_id where g.event_id=eid)<>209 then raise exception 'Expected 209 results'; end if;
 if (select count(*) from regatta_race_results x join regatta_results r on r.id=x.regatta_result_id join regattas g on g.id=r.regatta_id where g.event_id=eid)<>1672 then raise exception 'Expected 1672 race scores'; end if;
 select md5(jsonb_agg(to_jsonb(r) order by r.id)::text) into results_before from regatta_results r join regattas g on g.id=r.regatta_id where g.event_id=eid;
 select md5(jsonb_agg(to_jsonb(x) order by x.id)::text) into races_before from regatta_race_results x join regatta_results r on r.id=x.regatta_result_id join regattas g on g.id=r.regatta_id where g.event_id=eid;

 update regattas set schedule_notes='Final results. Status confirmed by SailorPath on 8 November 2026. The official notice board labels the result documents Final. All race scores, scoring codes and printed discards checked against the retained official PDFs. Outside Singapore national ranking.',updated_at=now()
 where event_id=eid and slug in ('eastern-seaboard-regatta-2026-ilca4','eastern-seaboard-regatta-2026-ilca6','eastern-seaboard-regatta-2026-optimist-gold','eastern-seaboard-regatta-2026-optimist-silver');
 get diagnostics affected=row_count;
 if affected<>4 then raise exception 'Expected four named sheets, updated %',affected; end if;
 update regatta_events set schedule_summary='Official NoR: registration 28 October; racing 29 October–1 November 2026. Final results are published for ILCA 4, ILCA 6, Optimist Gold and Optimist Silver.',updated_at=now() where id=eid;

 select md5(jsonb_agg(to_jsonb(r) order by r.id)::text) into results_after from regatta_results r join regattas g on g.id=r.regatta_id where g.event_id=eid;
 select md5(jsonb_agg(to_jsonb(x) order by x.id)::text) into races_after from regatta_race_results x join regatta_results r on r.id=x.regatta_result_id join regattas g on g.id=r.regatta_id where g.event_id=eid;
 if results_before is distinct from results_after or races_before is distinct from races_after then raise exception 'Result or race data changed during status correction'; end if;
end $final_status$;
commit;
