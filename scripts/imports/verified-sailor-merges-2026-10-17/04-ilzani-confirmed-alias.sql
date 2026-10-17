begin;
do $repair$
declare s sailors%rowtype;
begin
select * into s from sailors where id='ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' for update;
if s.id is null or s.name<>'Khairul Ilzani bin Mohd Afendy' or s.nationality<>'MAS' or s.sail_number<>'MAS 119' then raise exception 'Ilzani identity changed'; end if;
if exists(select 1 from sailor_aliases where alias_name='Khairulilzani Afendy' and sailor_id<>s.id) then raise exception 'Compact alias belongs to another sailor'; end if;
if exists(select 1 from sailor_aliases where alias_name='Khairulilzani Afendy' and sailor_id=s.id) then return; end if;
insert into sailor_aliases(sailor_id,alias_name) values(s.id,'Khairulilzani Afendy');
insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
values('sailors.add_confirmed_alias','sailor',s.id,s.name,'Saved the confirmed Asian Index source-name alias for future imports.',jsonb_build_object('alias','Khairulilzani Afendy','identityEvidence','User confirmed the Asian Index identity belongs to Khairul Ilzani bin Mohd Afendy, MAS 119. Official 2025 source: AFENDY, Khairulilzani.'),'verified-sailor-merges-2026-10-17');
end $repair$;
commit;
