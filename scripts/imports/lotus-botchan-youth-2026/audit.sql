-- All counts must agree with the reviewed per-sheet manifests.
select e.slug as event_slug,g.slug,g.boat_class,g.division,g.status,g.race_count,g.total_fleet_size,
 count(distinct r.id) as result_rows,count(x.id) as race_rows,
 count(x.id) filter(where x.discarded) as discard_markers,
 count(distinct r.id) filter(where r.verification_status='verified') as verified_rows
from regatta_events e join regattas g on g.event_id=e.id
left join regatta_results r on r.regatta_id=g.id
left join regatta_race_results x on x.regatta_result_id=r.id
where e.slug in ('botchan-cup-2026','japan-youth-worlds-selection-2026','kaohsiung-lotus-pond-optimist-regatta-2026')
group by e.slug,g.id order by e.slug,g.boat_class,g.division;

-- Must return zero rows.
select g.slug,r.entry_label,r.rank,r.total_score,r.nett_score,count(x.id) as score_count,
 sum(x.score::double precision) as gross_sum,
 sum(x.score::double precision) filter(where not x.discarded) as nett_sum
from regatta_events e join regattas g on g.event_id=e.id
join regatta_results r on r.regatta_id=g.id
left join regatta_race_results x on x.regatta_result_id=r.id
where e.slug in ('botchan-cup-2026','japan-youth-worlds-selection-2026','kaohsiung-lotus-pond-optimist-regatta-2026')
group by g.slug,g.race_count,r.id
having count(x.id)<>g.race_count or abs(sum(x.score::double precision)-r.total_score)>0.0001
 or abs(sum(x.score::double precision) filter(where not x.discarded)-r.nett_score)>0.0001;

-- Must return zero rows. Crewed boats have two people sharing a single score set.
select g.slug,r.entry_label,count(p.id) as participant_count
from regatta_events e join regattas g on g.event_id=e.id
join regatta_results r on r.regatta_id=g.id
left join regatta_result_participants p on p.regatta_result_id=r.id
where e.slug in ('botchan-cup-2026','japan-youth-worlds-selection-2026','kaohsiung-lotus-pond-optimist-regatta-2026')
group by g.slug,g.entry_type,r.id
having count(p.id)<>case when g.entry_type='crew' then 2 else 1 end;
