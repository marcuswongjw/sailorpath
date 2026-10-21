begin;
insert into sailor_aliases(sailor_id,alias_name)
 values('9e411259-d0ba-54c8-8ad6-432256bc5770','NATTHAPATR POOLKLANG'),
 ('9e411259-d0ba-54c8-8ad6-432256bc5770','NATTHAPHATR POOLKLANG')
 on conflict(alias_name) do nothing;
do $verify$
begin
 if (select count(*) from sailor_aliases where sailor_id='9e411259-d0ba-54c8-8ad6-432256bc5770' and alias_name in('NATTHAPATR POOLKLANG','NATTHAPHATR POOLKLANG'))<>2 then raise exception 'Alias conflict'; end if;
 if (select count(*) from regatta_results where sailor_id='9e411259-d0ba-54c8-8ad6-432256bc5770' and regatta_id in(select id from regattas where slug in('admirals-cup-2025-optimist-silver','eastern-seaboard-regatta-2025-optimist')))<>2 then raise exception 'Confirmed source entries not linked'; end if;
end $verify$;
insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
 select 'sailor.identity_user_confirmed_thai2025','sailor','9e411259-d0ba-54c8-8ad6-432256bc5770','Natthapatr Poolklang','User confirmed Natthapatr/Natthaphatr are one sailor. Both 2025 entry spellings and historic sail numbers retained.',jsonb_build_object('userConfirmation','Treat each pair as one sailor','historicEntries',jsonb_build_array('THA1695 Admiral Cup2025 Silver','THA1434 Eastern Seaboard2025 Optimist')),'thai-regattas-2025-2026-10-21'
 where not exists(select 1 from admin_change_log where action='sailor.identity_user_confirmed_thai2025' and entity_id='9e411259-d0ba-54c8-8ad6-432256bc5770');
commit;
