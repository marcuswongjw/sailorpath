-- Must return zero rows after import.
select g.slug,r.rank,count(x.id) score_count,
 r.total_score,sum(x.score::double precision) calculated_gross,
 r.nett_score,sum(x.score::double precision) filter(where not x.discarded) calculated_net
from regattas g
join regatta_results r on r.regatta_id=g.id
left join regatta_race_results x on x.regatta_result_id=r.id
where g.slug in ('eastern-seaboard-regatta-2026-ilca4','eastern-seaboard-regatta-2026-ilca6',
 'eastern-seaboard-regatta-2026-optimist-gold','eastern-seaboard-regatta-2026-optimist-silver')
group by g.id,r.id
having count(x.id)<>8
 or abs(r.total_score-sum(x.score::double precision))>0.0001
 or abs(r.nett_score-sum(x.score::double precision) filter(where not x.discarded))>0.0001;
