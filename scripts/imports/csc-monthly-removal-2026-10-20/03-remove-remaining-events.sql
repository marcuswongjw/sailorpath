begin;
set local lock_timeout='5s';
delete from regattas where slug like 'csc-monthly-dinghy-race-%' and event_id in ('2c14e61b-c026-569c-babe-20a1ab7fa01e','e8f191ad-6d09-5802-85e7-baa1a12baae2','ef68fa43-8da5-5953-a457-10a4d929cb1c');
delete from regatta_events where id in ('2c14e61b-c026-569c-babe-20a1ab7fa01e','e8f191ad-6d09-5802-85e7-baa1a12baae2','ef68fa43-8da5-5953-a457-10a4d929cb1c') and slug like 'csc-monthly-dinghy-race-%';
insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
values('regatta_event_delete','regatta_events',null,'CSC Monthly Dinghy Races','Removed all three remaining CSC monthly dinghy regattas: 13 sheets, 73 entries and 177 race scores.',jsonb_build_object('authorization','User explicitly reiterated: Remove all CSC monthly dinghy regattas','backup','outputs/csc-monthly-removal-2026-10-20/production-backup.json'),'csc-monthly-removal-2026-10-20');
commit;
