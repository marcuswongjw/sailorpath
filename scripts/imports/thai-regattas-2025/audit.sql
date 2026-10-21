-- Expected: 2 events, 6 published sheets,245 entries,250 participants,2695 race scores,245 discards,230 coded scores.
with selected as(select * from regattas where slug like 'admirals-cup-2025-%' or slug like 'eastern-seaboard-regatta-2025-%')
select r.slug,r.boat_class,r.division,r.race_count,r.status,r.counts_for_ranking,
 (select count(*) from regatta_results where regatta_id=r.id) as entries,
 (select count(*) from regatta_race_results s join regatta_results rr on rr.id=s.regatta_result_id where rr.regatta_id=r.id) as race_scores,
 (select count(*) from regatta_result_participants p join regatta_results rr on rr.id=p.regatta_result_id where rr.regatta_id=r.id) as participants
from selected r order by r.slug;
-- Must return zero exceptions.
select r.slug,rr.entry_label from regattas r join regatta_results rr on rr.regatta_id=r.id
left join regatta_race_results s on s.regatta_result_id=rr.id
where r.slug like 'admirals-cup-2025-%' or r.slug like 'eastern-seaboard-regatta-2025-%'
group by r.id,rr.id having count(s.id)<>r.race_count or abs(rr.total_score-sum(s.score::double precision))>.001 or abs(rr.nett_score-sum(s.score::double precision) filter(where not s.discarded))>.001 or count(*) filter(where s.discarded)<>1 or rr.verification_status<>'verified' or rr.evidence_url is null;
-- Confirmed pairs: one profile each,2 result entries each, original labels and boat numbers retained.
select s.id,s.name,rr.entry_label,rr.entry_sail_number,r.slug from sailors s join regatta_results rr on rr.sailor_id=s.id join regattas r on r.id=rr.regatta_id where s.id in('5cd22c52-558f-598e-84df-07fbb27b43fc','9e411259-d0ba-54c8-8ad6-432256bc5770') order by s.name,r.date;
