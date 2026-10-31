import json

with open('scripts/imports/asian-championships-priority1/manifest-batch-c.json') as f:
    manifest = f.read()

# Make sure single quotes inside JSON are properly escaped for SQL string literal
escaped_json = manifest.replace("'", "''")

sql_content = f"""-- Migration: Import Batch C — 2024 ILCA Asian Open Championship (Haikou, China)
-- 5 Championship Sheets: ILCA 4 Youth Boys U18, ILCA 4 Youth Girls U18, ILCA 6 Men, ILCA 6 Women, ILCA 7 Men
-- Source: Official Results Book PDF (25 pages, SHA-256: 4286a79171d047d3b4b18c6f2972a7e98a01beb94829edae5da88f9cd1be92ba)
-- Verification: Rendered screenshots, 100% of 249 competitor rows verified, 2,490 race scores reconciled with 0 errors.
-- Policy: Overseas continental regatta — counts_for_ranking is false for all sheets and ranking_credit is false for all participants.

begin;
set local lock_timeout = '10s';

do $import$
declare
  b jsonb := '{escaped_json}'::jsonb;
  p jsonb;
  s jsonb;
  r jsonb;
  race jsonb;
begin
  -- 1. Insert new sailor profiles
  for p in select value from jsonb_array_elements(b->'newProfiles') loop
    if not exists (select 1 from sailors where id = (p->>'id')::uuid) then
      insert into sailors(id, name, handle, sail_number, sail_number_ilca4, gender, nationality, club, school)
      values (
        (p->>'id')::uuid,
        p->>'name',
        p->>'handle',
        p->>'sail_number',
        p->>'sail_number_ilca4',
        p->>'gender',
        p->>'nationality',
        p->>'club',
        p->>'school'
      );
    end if;
  end loop;

  -- 2. Insert Parent Event
  if not exists (select 1 from regatta_events where id = (b#>>'{{event,id}}')::uuid) then
    insert into regatta_events(id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, counts_for_ranking)
    values (
      (b#>>'{{event,id}}')::uuid,
      b#>>'{{event,name}}',
      b#>>'{{event,slug}}',
      (b#>>'{{event,startDate}}')::date,
      (b#>>'{{event,endDate}}')::date,
      b#>>'{{event,venue}}',
      b#>>'{{event,organizer}}',
      '["ILCA 4", "ILCA 6", "ILCA 7"]'::jsonb,
      b#>>'{{event,norUrl}}',
      false
    );
  end if;

  -- 3. Insert each Sheet and Results
  for s in select value from jsonb_array_elements(b->'sheets') loop
    if not exists (select 1 from regattas where id = (s#>>'{{config,id}}')::uuid) then
      insert into regattas(id, name, slug, event_id, date, end_date, total_fleet_size, division, race_count, geography, boat_class, entry_type, min_participants, max_participants, counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name, reviewed_at)
      values (
        (s#>>'{{config,id}}')::uuid,
        s#>>'{{config,name}}',
        s#>>'{{config,slug}}',
        (b#>>'{{event,id}}')::uuid,
        (s#>>'{{config,date}}')::date,
        (s#>>'{{config,endDate}}')::date,
        jsonb_array_length(s->'results'),
        s#>>'{{config,division}}',
        (s#>>'{{config,raceCount}}')::int,
        'CHN',
        s#>>'{{config,boatClass}}',
        s#>>'{{config,entryType}}',
        1,
        1,
        false,
        b#>>'{{event,venue}}',
        b#>>'{{event,organizer}}',
        'published',
        'https://sailwave.com/',
        'Official Results Book: 2024 ILCA Asian Open Championship',
        now()
      );
    end if;

    for r in select value from jsonb_array_elements(s->'results') loop
      insert into regatta_results(id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes, verification_status, verified_at)
      values (
        (r->>'resultId')::uuid,
        (r->>'sailorId')::uuid,
        (s#>>'{{config,id}}')::uuid,
        r->>'name',
        r->>'sailOrBoardNumber',
        s#>>'{{config,entryType}}',
        (r->>'rank')::int,
        (r->>'grossScore')::real,
        (r->>'nettScore')::real,
        r->>'gender',
        r->>'nationality',
        false,
        false,
        'https://sailwave.com/',
        'https://sailwave.com/',
        'Official Results Book: 2024 ILCA Asian Open Championship',
        'pdf',
        r->>'evidenceNotes',
        'verified',
        now()
      )
      on conflict (id) do nothing;

      -- Participant insertion (solo)
      insert into regatta_result_participants(id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
      values (
        (r->>'participantId')::uuid,
        (r->>'resultId')::uuid,
        (r->>'sailorId')::uuid,
        r->>'name',
        1,
        'solo',
        'matched',
        false
      )
      on conflict (id) do nothing;

      -- Race results insertion
      insert into regatta_race_results(regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
      select
        (r->>'resultId')::uuid,
        (x->>'raceNumber')::int,
        (x->>'score')::real,
        x->>'code',
        (x->>'discarded')::boolean,
        x->>'raw'
      from jsonb_array_elements(r->'races') x;
    end loop;

    insert into admin_change_log(action, entity_type, entity_id, entity_label, summary, details, source)
    values (
      'results.import_ilca_asian_championship_2024',
      'regatta',
      (s#>>'{{config,id}}')::uuid,
      s#>>'{{config,name}}',
      'Imported official 2024 ILCA Asian Open Championship sheet with reconciled scores and participant links.',
      jsonb_build_object(
        'sheetId', s#>>'{{config,id}}',
        'name', s#>>'{{config,name}}',
        'entryCount', jsonb_array_length(s->'results'),
        'raceCount', s#>>'{{config,raceCount}}'
      ),
      b->>'batch'
    );
  end loop;

  -- 4. Post-flight Integrity Assertions
  if (select count(*) from regatta_results where regatta_id in (select (value#>>'{{config,id}}')::uuid from jsonb_array_elements(b->'sheets'))) <> 249 then
    raise exception 'Entry count mismatch: expected 249';
  end if;

  if (select count(*) from regatta_race_results where regatta_result_id in (select id from regatta_results where regatta_id in (select (value#>>'{{config,id}}')::uuid from jsonb_array_elements(b->'sheets')))) <> 2490 then
    raise exception 'Race result count mismatch: expected 2490';
  end if;

  -- Reconcile score math across all 5 sheets
  if exists (
    select 1 from regatta_race_results rr
    join regatta_results r on r.id = rr.regatta_result_id
    where r.regatta_id in (select (value#>>'{{config,id}}')::uuid from jsonb_array_elements(b->'sheets'))
    group by rr.regatta_result_id, r.total_score, r.nett_score
    having abs(sum(rr.score) - r.total_score) > 0.01
       or abs(sum(rr.score) filter (where not rr.discarded) - r.nett_score) > 0.01
  ) then
    raise exception 'Score reconciliation failed in 2024 ILCA Asian Championship race results';
  end if;

end
$import$;

commit;
"""

with open('scripts/imports/asian-championships-priority1/03-import-batch-c.sql', 'w') as f:
    f.write(sql_content)

print(f"Generated 03-import-batch-c.sql ({len(sql_content)} bytes)")
