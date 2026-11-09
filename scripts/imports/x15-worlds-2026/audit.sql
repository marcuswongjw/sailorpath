WITH sheets AS (
  SELECT g.* FROM regattas g JOIN regatta_events e ON e.id=g.event_id
  WHERE e.slug='x15-world-championships-2026'
), reconciled AS (
  SELECT r.id,g.slug,g.race_count,r.total_score,r.nett_score,r.verification_status,r.evidence_type,
    count(x.id) AS score_count,sum(x.score::double precision) AS gross,
    sum(x.score::double precision) FILTER (WHERE NOT x.discarded) AS nett,
    count(x.id) FILTER (WHERE x.discarded) AS discards
  FROM sheets g JOIN regatta_results r ON r.regatta_id=g.id
  LEFT JOIN regatta_race_results x ON x.regatta_result_id=r.id
  GROUP BY r.id,g.slug,g.race_count
), inventory AS (
  SELECT g.slug,g.boat_class,g.division,g.status,g.race_count,g.total_fleet_size,g.counts_for_ranking,
    count(DISTINCT r.id) AS entries,count(x.id) AS race_scores,
    count(x.id) FILTER (WHERE x.discarded) AS discards
  FROM sheets g LEFT JOIN regatta_results r ON r.regatta_id=g.id
  LEFT JOIN regatta_race_results x ON x.regatta_result_id=r.id
  GROUP BY g.id,g.slug,g.boat_class,g.division,g.status,g.race_count,g.total_fleet_size,g.counts_for_ranking
)
SELECT jsonb_build_object(
  'parent_events',(SELECT count(*) FROM regatta_events WHERE slug='x15-world-championships-2026'),
  'sheets',(SELECT jsonb_agg(to_jsonb(i) ORDER BY slug) FROM inventory i),
  'result_rows',(SELECT count(*) FROM reconciled),
  'race_scores',(SELECT sum(score_count) FROM reconciled),
  'discards',(SELECT sum(discards) FROM reconciled),
  'participant_links',(SELECT count(*) FROM regatta_result_participants p JOIN regatta_results r ON r.id=p.regatta_result_id JOIN sheets g ON g.id=r.regatta_id),
  'profiles',(SELECT count(DISTINCT r.sailor_id) FROM regatta_results r JOIN sheets g ON g.id=r.regatta_id),
  'verified_digital_rows',(SELECT count(*) FROM reconciled WHERE verification_status='verified' AND evidence_type='link'),
  'reconciliation_exceptions',(SELECT count(*) FROM reconciled WHERE score_count<>race_count OR abs(gross-total_score)>0.0001 OR abs(nett-nett_score)>0.0001),
  'rows_with_nationality',(SELECT count(*) FROM regatta_results r JOIN sheets g ON g.id=r.regatta_id JOIN sailors s ON s.id=r.sailor_id WHERE r.nationality ~ '^[A-Z]{3}$' AND s.nationality=r.nationality),
  'ranking_eligible_sheets',(SELECT count(*) FROM sheets WHERE counts_for_ranking),
  'u19_men_top_four',(SELECT jsonb_agg(jsonb_build_object('name',r.entry_label,'rank',r.rank,'nett',r.nett_score) ORDER BY r.rank) FROM regatta_results r JOIN sheets g ON g.id=r.regatta_id WHERE g.division='U19 and U17 Men' AND r.rank<=4)
) AS audit;
