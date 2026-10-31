begin;
set local lock_timeout='8s';
set local statement_timeout='60s';
do $publish$
declare
 ids uuid[] := array['7c9c1cb9-a3c7-505e-a3c9-801dac28a926','a9eafd0b-6c55-502c-be33-511f68187ef8','491f5d6c-8cc7-5675-b704-4b20c72a4830']::uuid[];
 sheet regattas%rowtype;
 result_digest text; race_digest text; participant_digest text;
 n int; held int; mismatches int; notice text;
begin
 perform pg_advisory_xact_lock(hashtextextended('yangon-2026-publication',0));
 perform 1 from regattas where id=any(ids) order by id for update;
 if (select count(*) from regattas where id=any(ids))<>3 then raise exception 'Missing sheets'; end if;
 if exists(select 1 from regattas where id=any(ids) and (status not in ('draft','published') or counts_for_ranking or race_count<>11 or geography<>'MYA' or coalesce(official_results_url,'')='' or coalesce(official_results_source_name,'')='' or date is null or boat_class not in ('Optimist','ILCA 4') or division<>'Open')) then raise exception 'Publication readiness failed'; end if;
 if (select count(*) from regatta_results where regatta_id=any(ids))<>62 or (select count(*) from regatta_race_results a join regatta_results r on r.id=a.regatta_result_id where r.regatta_id=any(ids))<>682 then raise exception 'Review inventory changed'; end if;
 if exists(select 1 from regatta_results r where r.regatta_id=any(ids) and (r.verification_status<>'pending_review' or not exists(select 1 from regatta_result_participants p where p.regatta_result_id=r.id and p.sailor_id=r.sailor_id and p.match_status='matched' and not p.ranking_credit))) then raise exception 'Result review/link status changed'; end if;
 select md5(jsonb_agg(to_jsonb(r) order by r.id)::text) into result_digest from regatta_results r where r.regatta_id=any(ids);
 select md5(jsonb_agg(to_jsonb(a) order by a.regatta_result_id,a.race_number)::text) into race_digest from regatta_race_results a join regatta_results r on r.id=a.regatta_result_id where r.regatta_id=any(ids);
 select md5(jsonb_agg(to_jsonb(p) order by p.id)::text) into participant_digest from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where r.regatta_id=any(ids);
 for sheet in select * from regattas where id=any(ids) loop
  select count(*) into n from regatta_results where regatta_id=sheet.id;
  held:=sheet.total_fleet_size-n;
  select count(*) into mismatches from regatta_results where regatta_id=sheet.id and evidence_notes like '%User explicitly instructed on 2026-10-30 to follow the results sheet despite discrepancies.%';
  notice:=format('Official source status: provisional. Partial import: %s of %s entries; %s entries awaiting identity review. Event dates %s to %s are assumed at user instruction and not independently verified. No official final-results PDF located; HTML source only. Published ranks, race values, discards, totals and net scores retained as supplied. %s imported rows have source arithmetic discrepancies, preserved at user instruction. Code-only penalty points use fleet size + 1 internally; original source codes remain displayed. Excluded from Singapore rankings.',n,sheet.total_fleet_size,held,sheet.date,sheet.end_date,mismatches);
  update regattas set status='published',reviewed_at=now(),updated_at=now(),schedule_notes=notice where id=sheet.id;
  insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
   select 'publish_regatta','regatta',sheet.id,sheet.name,'Reviewed and published provisional Yangon results; date assumptions, partial coverage and source discrepancies disclosed.',jsonb_build_object('beforeStatus',sheet.status,'afterStatus','published','results',n,'heldIdentities',held,'sourceDiscrepancies',mismatches,'datesAssumedByUser',true,'pdfVerified',false,'sourceUnchangedAtReview',true,'resultVerificationStatus','pending_review','singaporeRankingCredit',false,'sourceValuesUnchanged',true),'yangon-2026-publication-2026-10-30'
   where not exists(select 1 from admin_change_log where entity_id=sheet.id and source='yangon-2026-publication-2026-10-30');
 end loop;
 update regatta_events e set schedule_summary=format('Provisional results. %s imported entries across %s fleets; %s entries awaiting identity review. Dates %s to %s assumed at user instruction. No official final-results PDF located. Source scores and totals retained, including documented discrepancies. Excluded from Singapore rankings.',(select count(*) from regatta_results r join regattas s on s.id=r.regatta_id where s.event_id=e.id),(select count(*) from regattas s where s.event_id=e.id),(select sum(s.total_fleet_size) from regattas s where s.event_id=e.id)-(select count(*) from regatta_results r join regattas s on s.id=r.regatta_id where s.event_id=e.id),e.start_date,e.end_date),updated_at=now()
 where e.id in (select event_id from regattas where id=any(ids));
 if result_digest is distinct from (select md5(jsonb_agg(to_jsonb(r) order by r.id)::text) from regatta_results r where r.regatta_id=any(ids)) or race_digest is distinct from (select md5(jsonb_agg(to_jsonb(a) order by a.regatta_result_id,a.race_number)::text) from regatta_race_results a join regatta_results r on r.id=a.regatta_result_id where r.regatta_id=any(ids)) or participant_digest is distinct from (select md5(jsonb_agg(to_jsonb(p) order by p.id)::text) from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where r.regatta_id=any(ids)) then raise exception 'Publication changed result data'; end if;
 if (select count(*) from regattas where id=any(ids) and status='published' and schedule_notes like 'Official source status: provisional. Partial import:%')<>3 then raise exception 'Publication verification failed'; end if;
end
$publish$;
commit;
