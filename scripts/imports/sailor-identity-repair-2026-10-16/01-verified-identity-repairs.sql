-- Authorized identity repair: verified Jeanette entries and incorrect Iman alias.
-- No result, race score, total, discard, source name or evidence is deleted.
begin;
set local lock_timeout = '5s';
do $repair$
declare item record; target_id uuid := '1b2d7976-00d6-4492-ad83-41c94eeec5e7';
old_id uuid := 'f953f351-0155-458f-b712-37349e8dba07'; before_row jsonb; before_races text; after_races text;
begin
perform 1 from sailors where id in (target_id,old_id) order by id for update;
if not exists(select 1 from sailors where id=target_id and name='Jeanette Tan Wan Wen' and sail_number='2017') then raise exception 'Jeanette identity changed'; end if;
for item in select * from (values
('916ecc43-2406-4ed1-886f-7912416629ad'::uuid,'nsc-cup-optimist-silver-2023',44,'Tan Wan Wen Jeanette'),
('14d72da2-59e5-48a9-8120-3ad6dfa76998'::uuid,'snsc-optimist-silver-2023',58,'TAN Wan Wen Jeanette')
) as approved(result_id,slug,place,source_name) loop
select to_jsonb(r) into before_row from regatta_results r join regattas g on g.id=r.regatta_id
where r.id=item.result_id and g.slug=item.slug and r.rank=item.place and r.entry_sail_number='SGP 2017'
and r.sailor_id in (old_id,target_id) and r.official_url is not null for update of r;
if before_row is null then raise exception 'Verified Jeanette entry changed: %',item.slug; end if;
if not exists(select 1 from regatta_result_participants where regatta_result_id=item.result_id and source_name=item.source_name and sailor_id in(old_id,target_id)) then raise exception 'Participant source mismatch'; end if;
select md5(jsonb_agg(to_jsonb(rr) order by rr.id)::text) into before_races from regatta_race_results rr where rr.regatta_result_id=item.result_id;
update regatta_results set sailor_id=target_id,updated_at=now() where id=item.result_id and sailor_id=old_id;
update regatta_result_participants set sailor_id=target_id,updated_at=now() where regatta_result_id=item.result_id and sailor_id=old_id and source_name=item.source_name;
if (select to_jsonb(r)-'sailor_id'-'updated_at' from regatta_results r where id=item.result_id) <> before_row-'sailor_id'-'updated_at' then raise exception 'Scored entry or evidence changed'; end if;
select md5(jsonb_agg(to_jsonb(rr) order by rr.id)::text) into after_races from regatta_race_results rr where rr.regatta_result_id=item.result_id;
if before_races is distinct from after_races then raise exception 'Race data changed'; end if;
insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
select 'results.identity_repair','result',item.result_id,'Jeanette Tan Wan Wen','Reassigned visually verified 2023 official entry from Zephyr to Jeanette.',
jsonb_build_object('before',before_row,'targetSailorId',target_id,'officialSourceName',item.source_name,'raceHash',before_races,'authorization','User instruction 2026-10-16, item 3'), 'sailor-identity-repair-2026-10-16'
where not exists(select 1 from admin_change_log where action='results.identity_repair' and entity_id=item.result_id and source='sailor-identity-repair-2026-10-16');
end loop;

if exists(select 1 from sailor_aliases where alias_name in ('Tan Wan Wen Jeanette','TAN Wan Wen Jeanette') and sailor_id not in(old_id,target_id)) then raise exception 'Jeanette alias has an unexpected owner'; end if;
update sailor_aliases set sailor_id=target_id where alias_name in ('Tan Wan Wen Jeanette','TAN Wan Wen Jeanette') and sailor_id=old_id;
insert into sailor_aliases(sailor_id,alias_name) values(target_id,'Tan Wan Wen Jeanette'),(target_id,'TAN Wan Wen Jeanette'),(target_id,'Jeanette Tan Wan Wen') on conflict(alias_name) do nothing;

if not exists(select 1 from sailors where id='e8d57d7a-4bfb-451e-a661-11c8ecaf805d' and name='KHAIRUL IMAN BIN MOHD AFENDY') then raise exception 'Iman identity changed'; end if;
if exists(select 1 from sailor_aliases where alias_name='Khairul Iman bin Mohd Afendy' and sailor_id not in('ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7','e8d57d7a-4bfb-451e-a661-11c8ecaf805d')) then raise exception 'Iman alias has unexpected owner'; end if;
update sailor_aliases set sailor_id='e8d57d7a-4bfb-451e-a661-11c8ecaf805d' where alias_name='Khairul Iman bin Mohd Afendy' and sailor_id='ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7';
insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
select 'sailors.alias_repair','sailor','e8d57d7a-4bfb-451e-a661-11c8ecaf805d','KHAIRUL IMAN BIN MOHD AFENDY',
'Reassigned Iman alias away from distinct Langkawi competitor Ilzani.', jsonb_build_object('alias','Khairul Iman bin Mohd Afendy','oldSailorId','ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7','evidence','Langkawi Gold 2026: Ilzani MAS119 rank4; Iman MAS1850 rank37'),
'sailor-identity-repair-2026-10-16'
where not exists(select 1 from admin_change_log where action='sailors.alias_repair' and entity_id='e8d57d7a-4bfb-451e-a661-11c8ecaf805d' and source='sailor-identity-repair-2026-10-16');
end $repair$;
commit;

