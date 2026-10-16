-- Reconcile final 2023 official sheets. Keep legacy entries intact as archived audit evidence.
-- Only lifecycle/verification metadata and non-score references change; every scored row/race/evidence survives.
begin;
set local lock_timeout = '5s';
do $repair$
declare item record; c regattas%rowtype; l regattas%rowtype;
score_hash text; race_hash text; legacy_hash text;
begin
for item in select * from (values
('snsc-optimist-silver-2023','snsc-silver-sep-23-2023-09-02',102,9,918),
('nsc-cup-optimist-silver-2023','nsc-cup-silver-jul-23-2023-07-22',91,7,637),
('nsc-cup-optimist-gold-2023','nsc-cup-gold-jul-23-2023-07-22',81,7,567)
) as approved(canonical_slug,legacy_slug,expected_entries,race_count,expected_races) loop
select * into strict c from regattas where slug=item.canonical_slug for update;
select * into strict l from regattas where slug=item.legacy_slug for update;
if c.date<>l.date or c.boat_class<>l.boat_class or c.division<>l.division or c.boat_class<>'Optimist' or c.geography<>'SGP' then raise exception 'Sheet identity mismatch: %',item.canonical_slug; end if;
if c.race_count<>item.race_count or c.total_fleet_size<>item.expected_entries or c.official_results_url is null or c.event_id is null then raise exception 'Incomplete canonical metadata'; end if;
if (select count(*) from regatta_results where regatta_id=c.id) <> item.expected_entries then raise exception 'Unexpected canonical entry count'; end if;
if (select count(*) from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=c.id) <> item.expected_races then raise exception 'Unexpected race count'; end if;
if exists(
 select 1 from regatta_results r left join regatta_race_results rr on rr.regatta_result_id=r.id where r.regatta_id=c.id
 group by r.id having count(rr.id)<>item.race_count or abs(sum(rr.score)-r.total_score)>0.0001
 or abs(sum(rr.score) filter(where not rr.discarded)-r.nett_score)>0.0001 or count(*) filter(where rr.discarded)<>1
) then raise exception 'Official score reconciliation failed: %',item.canonical_slug; end if;
if exists(select 1 from regatta_results r where r.regatta_id=c.id and (r.official_url is distinct from c.official_results_url or r.total_score is null or r.nett_score is null)) then raise exception 'Missing canonical totals/evidence'; end if;
-- Every source entry has its unmodified official name and stable participant row.
if exists(select 1 from regatta_results r where r.regatta_id=c.id and not exists(select 1 from regatta_result_participants p where p.regatta_result_id=r.id and length(trim(p.source_name))>0)) then raise exception 'Missing source participant'; end if;
select md5(jsonb_agg(to_jsonb(r)-'updated_at'-'verification_status'-'verified_at'-'verified_by' order by r.id)::text) into score_hash from regatta_results r where regatta_id=c.id;
select md5(jsonb_agg(to_jsonb(rr) order by rr.id)::text) into race_hash from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=c.id;
select md5(jsonb_agg(to_jsonb(r) order by r.id)::text) into legacy_hash from regatta_results r where regatta_id=l.id;

-- Correct source-backed official verification. Jade's existing alternate-name link
-- remains explicitly pending identity review; no unproven identity consolidation.
update regatta_results r set verification_status=case
 when r.id='3605d654-c588-41ff-a541-860e8c7b5cfd' then 'pending_review' else 'verified' end,
 verified_at=case when r.id='3605d654-c588-41ff-a541-860e8c7b5cfd' then null else coalesce(r.verified_at,now()) end,
 updated_at=now() where r.regatta_id=c.id;
update regatta_result_participants p set match_status='needs_review',updated_at=now()
where p.regatta_result_id='3605d654-c588-41ff-a541-860e8c7b5cfd' and c.slug='nsc-cup-optimist-gold-2023';

-- Preserve event references, avoiding a duplicate observation key rather than dropping a note.
if exists(select 1 from race_observations a join race_observations b on a.sailor_id=b.sailor_id and a.race_number=b.race_number where a.regatta_id=l.id and b.regatta_id=c.id) then raise exception 'Observation collision requires review'; end if;
update race_observations set regatta_id=c.id where regatta_id=l.id;
update equipment_logs set regatta_id=c.id where regatta_id=l.id;
update equipment_usages set regatta_id=c.id where regatta_id=l.id;
update news_articles set related_regatta_id=c.id where related_regatta_id=l.id;
update regattas set status='archived',counts_for_ranking=false,reviewed_at=coalesce(reviewed_at,now()),updated_at=now(),
schedule_notes=case when coalesce(schedule_notes,'') like '%Replaced by canonical %' then schedule_notes else concat_ws(E'\n',schedule_notes,'Replaced by canonical '||item.canonical_slug||' after official-source reconciliation, 2026-10-16. Original summary rows retained for audit.') end where id=l.id;
update regattas set status='published',counts_for_ranking=true,reviewed_at=coalesce(reviewed_at,now()),updated_at=now(),
schedule_notes=case when coalesce(schedule_notes,'') like '%Legacy reconciliation completed%' then schedule_notes else replace(coalesce(schedule_notes,''),'Import held for profile/discard review.','')||' Legacy reconciliation completed against the final official PDF, 2026-10-16; retained canonical sheet.' end where id=c.id;

if score_hash is distinct from (select md5(jsonb_agg(to_jsonb(r)-'updated_at'-'verification_status'-'verified_at'-'verified_by' order by r.id)::text) from regatta_results r where regatta_id=c.id) then raise exception 'Canonical scored entry/evidence changed'; end if;
if race_hash is distinct from (select md5(jsonb_agg(to_jsonb(rr) order by rr.id)::text) from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=c.id) then raise exception 'Official race/discard data changed'; end if;
if legacy_hash is distinct from (select md5(jsonb_agg(to_jsonb(r) order by r.id)::text) from regatta_results r where regatta_id=l.id) then raise exception 'Legacy entries changed'; end if;
if (select count(*) from regattas where date=c.date and boat_class=c.boat_class and division=c.division and status='published' and counts_for_ranking)<>1 then raise exception 'Expected exactly one published ranking sheet'; end if;

insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
select 'regattas.reconcile_legacy','regatta',c.id,c.name,'Published complete official sheet and archived its summary-only legacy copy without deleting entries or scores.',
jsonb_build_object('legacyBefore',to_jsonb(l),'canonicalBefore',to_jsonb(c),'legacySlug',l.slug,'entries',item.expected_entries,'raceRows',item.expected_races,'canonicalScoreHash',score_hash,'raceHash',race_hash,'legacyResultHash',legacy_hash,'authorization','User instruction 2026-10-16, item 4'),
'sailor-identity-repair-2026-10-16'
where not exists(select 1 from admin_change_log where action='regattas.reconcile_legacy' and entity_id=c.id and source='sailor-identity-repair-2026-10-16');
end loop;
end $repair$;
commit;

