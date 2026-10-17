begin;
set local lock_timeout='5s';
do $repair$
declare a asian_optimist_index_sailors%rowtype; s sailors%rowtype; before_hash text;
begin
select * into s from sailors where id='ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' for update;
select * into a from asian_optimist_index_sailors where id='16078d0b-6d3e-4ac6-9aa7-6f3b5e059214' for update;
if s.id is null or s.name<>'Khairul Ilzani bin Mohd Afendy' or s.nationality<>'MAS' or s.sail_number<>'MAS 119' then raise exception 'Ilzani target identity changed'; end if;
if a.id is null or a.canonical_name<>'Khairulilzani Afendy' or a.nationality<>'MAS' or a.latest_sail_number<>'MAS 119' then raise exception 'Index identity changed'; end if;
if a.sailor_id=s.id then return; end if;
if a.sailor_id is not null then raise exception 'Index already linked to another sailor'; end if;
select md5(jsonb_agg(to_jsonb(r) order by id)::text) into before_hash from asian_optimist_index_results r;
insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
values('sailors.repair_asian_index_link','sailor',s.id,s.name,'Linked the confirmed compact-name Asian Index identity to Ilzani’s existing profile.',jsonb_build_object('indexBefore',to_jsonb(a),'keepId',s.id,'identityEvidence','Explicit user confirmation, MAS 119; AFENDY, Khairulilzani in 2025 Asian & Oceanian results and full name in Langkawi 2026. Source results retained unchanged.'),'verified-sailor-merges-2026-10-17');
update asian_optimist_index_sailors set sailor_id=s.id,match_status='matched',updated_at=now() where id=a.id;
if before_hash is distinct from (select md5(jsonb_agg(to_jsonb(r) order by id)::text) from asian_optimist_index_results r) then raise exception 'Index source scores or evidence changed'; end if;
end $repair$;
commit;
