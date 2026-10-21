-- Identity-only repair, authorised by administrator on 2026-10-21.
-- Official final PDF: https://www.racingrulesofsailing.org/documents/158594
-- Page 2 visually checked: Ange Chew, male, sail 123, Wingfoil rank 4,
-- 14 races: (4),3,3,3,3,(4),3,4,3,3,4,1,3,4; total 45, nett 37.
DO $$
DECLARE
  ange uuid := '9ee77695-4c61-407a-a395-bd60e8b98204';
  angel uuid := 'd8f05612-be68-4e4d-af1d-e1cadbfb7669';
  moved uuid := 'e90a346e-d1f2-4ef5-859c-53ba282223e3';
  before_races jsonb;
  before_scores jsonb;
  before_data jsonb;
  after_data jsonb;
BEGIN
  PERFORM id FROM sailors WHERE id IN (ange,angel) ORDER BY id FOR UPDATE;
  IF NOT EXISTS (SELECT 1 FROM sailors WHERE id=ange AND name='Ange Chew')
    OR NOT EXISTS (SELECT 1 FROM sailors WHERE id=angel AND name='Angel Chew')
    OR NOT EXISTS (SELECT 1 FROM regatta_results WHERE id=moved AND sailor_id=angel AND rank=4 AND total_score=45 AND nett_score=37)
  THEN RAISE EXCEPTION 'Identity preconditions changed'; END IF;
  SELECT jsonb_agg(to_jsonb(rr) ORDER BY rr.id) INTO before_races
    FROM regatta_race_results rr JOIN regatta_results r ON r.id=rr.regatta_result_id
    WHERE r.sailor_id IN (ange,angel);
  SELECT jsonb_agg(jsonb_build_array(id,rank,total_score,nett_score) ORDER BY id) INTO before_scores
    FROM regatta_results WHERE sailor_id IN (ange,angel);
  SELECT jsonb_build_object(
    'profiles',(SELECT jsonb_agg(jsonb_build_object('id',id,'name',name,'gender',gender)) FROM sailors WHERE id IN (ange,angel)),
    'moved_result',(SELECT to_jsonb(r) FROM regatta_results r WHERE id=moved),
    'moved_participants',(SELECT jsonb_agg(to_jsonb(p)) FROM regatta_result_participants p WHERE regatta_result_id=moved),
    'wingfoil_genders',(SELECT jsonb_agg(jsonb_build_object('event',w.id,'name',e.value->>'name','gender',e.value->>'gender'))
      FROM wingfoil_regattas w CROSS JOIN LATERAL jsonb_array_elements(coalesce(w.data->'results','[]')) e
      WHERE e.value->>'name'='Ange Chew')
  ) INTO before_data;
  UPDATE sailors SET gender='M' WHERE id=ange;
  UPDATE regatta_results SET gender='M',updated_at=now() WHERE sailor_id=ange AND gender IS DISTINCT FROM 'M';
  UPDATE regatta_results SET sailor_id=ange,entry_label='Ange Chew',entry_sail_number='123',
    gender='M',official_url='https://www.racingrulesofsailing.org/documents/158594',
    evidence_url='https://www.racingrulesofsailing.org/documents/158594',
    evidence_type='pdf',evidence_name='Singapore National Sailing Championships 2025 — final Techno293, Wingfoil and iQFOiL results (12 September 2025)',
    evidence_notes=concat_ws(E'\n',nullif(evidence_notes,''),'2026-10-21 identity correction: official final PDF page 2 visually corroborates Ange Chew (not Angel Chew), male, sail 123, ASSC, Wingfoil rank 4 of 5. All 14 race values, two discards (R1 and R6), total 45 and nett 37 match the stored scores. User confirms these are separate sailors. No scores changed.'),
    updated_at=now() WHERE id=moved;
  UPDATE regatta_result_participants SET sailor_id=ange,source_name='Ange Chew',updated_at=now()
    WHERE regatta_result_id=moved AND sailor_id=angel;
  UPDATE wingfoil_regattas w SET data=jsonb_set(w.data,'{results}',
    (SELECT jsonb_agg(CASE WHEN e.value->>'name'='Ange Chew' THEN jsonb_set(e.value,'{gender}','"M"') ELSE e.value END ORDER BY e.ordinality)
      FROM jsonb_array_elements(w.data->'results') WITH ORDINALITY e(value,ordinality))),updated_at=now()
    WHERE EXISTS (SELECT 1 FROM jsonb_array_elements(coalesce(w.data->'results','[]')) e
      WHERE e->>'name'='Ange Chew' AND e->>'gender'='F');
  INSERT INTO admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
    VALUES ('sailors.duplicates.keep_separate','sailor',ange,'Ange Chew / Angel Chew','Confirmed these are different sailors.',
      jsonb_build_object('pairKey',ange::text||'|'||angel::text,'aId',ange,'bId',angel,'aName','Ange Chew','bName','Angel Chew',
        'reason','Administrator explicitly confirmed on 2026-10-21 that young male wingfoiler Ange Chew is not Angel Chew. Prior SAFYC 2023 review agrees. Official SNSC 2025 final PDF page 2 names Ange Chew, male, Wingfoil rank 4; keep profiles and results separate.'),
      'administrator-request-identity-correction');
  SELECT jsonb_agg(to_jsonb(rr) ORDER BY rr.id) INTO after_data
    FROM regatta_race_results rr JOIN regatta_results r ON r.id=rr.regatta_result_id WHERE r.sailor_id IN (ange,angel);
  IF before_races IS DISTINCT FROM after_data THEN RAISE EXCEPTION 'Race preservation check failed'; END IF;
  SELECT jsonb_agg(jsonb_build_array(id,rank,total_score,nett_score) ORDER BY id) INTO after_data
    FROM regatta_results WHERE sailor_id IN (ange,angel);
  IF before_scores IS DISTINCT FROM after_data THEN RAISE EXCEPTION 'Score preservation check failed'; END IF;
  INSERT INTO admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
    VALUES ('result_identity_corrected','sailor',ange,'Ange Chew','Separated Ange Chew from Angel Chew in historical results; corrected male gender labels.',
      jsonb_build_object('before',before_data,'movedResultId',moved,'officialPdf','https://www.racingrulesofsailing.org/documents/158594',
        'pdfPage',2,'pdfVisualComparison','All 14 scores and discards, male gender, name, sail 123, rank 4, total 45 and nett 37 match.',
        'allRaceRowsUnchanged',true,'allRanksAndTotalsUnchanged',true,'angelOtherResultsUnchanged',true),
      'administrator-request-identity-correction');
END $$;
