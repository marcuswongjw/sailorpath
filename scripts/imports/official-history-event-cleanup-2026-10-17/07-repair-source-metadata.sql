-- These six already-imported overseas sheets have unanimous official links on their entries.
-- Copy that existing provenance to class-sheet fields; retain lifecycle, ranking policy, and every score.
begin;
set local lock_timeout='5s';
do $metadata$
declare item record; g regattas%rowtype; result_hash text; race_hash text; participant_hash text;
begin
for item in select * from(values
('02df5e9f-88d6-4b8c-88a7-69eaf327ffad'::uuid,'published','THA',10,30,'https://sailingtech.in.th/preview/results/youth-thailand-2026/ilca4-overall.html','RRS ONB 15865 + Sailwave'),
('9d3ffb60-c006-4320-8f7a-72309da9d7db','published','THA',58,174,'https://sailingtech.in.th/preview/results/youth-thailand-2026/optimist-overall.html','RRS ONB 15865 + Sailwave'),
('5118d319-7f76-46ad-b270-9eda0afec1a7','draft','PHI',13,52,'https://www.racingrulesofsailing.org/documents/201813','RRS ONB 15290 + Phase 1 official results PDF'),
('9d2afea9-391c-4823-b6f4-23ef352b43d1','draft','PHI',8,56,'https://www.racingrulesofsailing.org/documents/200717','RRS ONB 15290 + Phase 1 official results PDF'),
('c86a8bf7-7d2b-45fe-bc21-80a928aac419','draft','PHI',7,63,'https://www.racingrulesofsailing.org/documents/200649','RRS ONB 15290 + Phase 1 official results PDF'),
('313e8a76-8d85-4e5a-8ee7-95213ee45f6d','draft','PHI',3,27,'https://www.racingrulesofsailing.org/documents/200311','RRS ONB 15290 + Phase 1 official results PDF')
) x(id,status,geography,entries,race_rows,url,title) loop
 select * into strict g from regattas where id=item.id for update;
 if g.status<>item.status or g.geography<>item.geography or g.counts_for_ranking is distinct from false then raise exception 'Overseas lifecycle or ranking policy changed'; end if;
 if (select count(*) from regatta_results where regatta_id=g.id)<>item.entries or exists(select 1 from regatta_results where regatta_id=g.id and (official_url is distinct from item.url or evidence_name is distinct from item.title)) then raise exception 'Source evidence is no longer unanimous'; end if;
 if (select count(*) from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=g.id)<>item.race_rows then raise exception 'Race inventory changed'; end if;
 if g.official_results_url=item.url and g.official_results_source_name=item.title then
  if not exists(select 1 from admin_change_log where source='official-history-event-cleanup-2026-10-17' and action='regattas.restore_source_metadata' and entity_id=g.id) then raise exception 'Metadata changed outside this reviewed repair'; end if;
  continue;
 end if;
 if g.official_results_url is not null or g.official_results_source_name is not null then raise exception 'Review conflicting class-sheet provenance'; end if;
 select md5(jsonb_agg(to_jsonb(r) order by r.id)::text) into result_hash from regatta_results r where regatta_id=g.id;
 select md5(jsonb_agg(to_jsonb(rr) order by rr.id)::text) into race_hash from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=g.id;
 select md5(jsonb_agg(to_jsonb(p) order by p.id)::text) into participant_hash from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where r.regatta_id=g.id;
 insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source) values('regattas.restore_source_metadata','regatta',g.id,g.name,'Restored the existing unanimous official result source on the class sheet; retained all results, races, participants and publication state.',jsonb_build_object('beforeSheet',to_jsonb(g),'officialUrl',item.url,'sourceName',item.title,'resultHash',result_hash,'raceHash',race_hash,'participantHash',participant_hash),'official-history-event-cleanup-2026-10-17');
 update regattas set official_results_url=item.url,official_results_source_name=item.title,updated_at=now() where id=g.id;
 if result_hash is distinct from (select md5(jsonb_agg(to_jsonb(r) order by r.id)::text) from regatta_results r where regatta_id=g.id) or race_hash is distinct from (select md5(jsonb_agg(to_jsonb(rr) order by rr.id)::text) from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=g.id) or participant_hash is distinct from (select md5(jsonb_agg(to_jsonb(p) order by p.id)::text) from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where r.regatta_id=g.id) then raise exception 'Source metadata repair changed result content'; end if;
end loop;
end $metadata$;
commit;
