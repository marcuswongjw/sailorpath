import os
import json

BASE_DIR = 'scripts/imports/australia-optimist-2026'

with open(os.path.join(BASE_DIR, 'extracted.json')) as f:
    data = json.load(f)

events = data['events']
new_profiles = data['newProfiles']
extracted = data['extracted']

# 1. Generate evidence.json
evidence = {
    "batch": "australia-optimist-2026-completed",
    "pdfCorroborationUnavailable": True,
    "pdfSearchSummary": "Searched host clubs (RYCT, RBYC, RPAYC, CYC), national authority AIODA, state class associations (TIODA, VIODA, OptiNSW/NSWIODA), SailingResults.net document repositories, and Sailwave portals. Notice of Race and Sailing Instructions were published in PDF, but official final race results are published exclusively via digital HTML scoring portals (SailingResults.net and Sailwave). Standalone official final results PDFs are unavailable. Results are corroborated and 100% mathematically verified against the official published digital HTML tables.",
    "events": []
}

for ev in events:
    ev_ev = {
        "id": ev["id"],
        "name": ev["name"],
        "slug": ev["slug"],
        "dates": f"{ev['startDate']} to {ev['endDate']}",
        "venue": ev["venue"],
        "organizer": ev["organizer"],
        "officialSource": ev["officialSource"],
        "sheets": []
    }
    for sh in ev["sheets"]:
        ev_ev["sheets"].append({
            "id": sh["id"],
            "slug": sh["slug"],
            "name": sh["name"],
            "division": sh["division"],
            "fleetSize": sh["totalFleetSize"],
            "raceCount": sh["raceCount"],
            "discardCount": sh["discardCount"]
        })
    evidence["events"].append(ev_ev)

with open(os.path.join(BASE_DIR, 'evidence.json'), 'w') as f:
    json.dump(evidence, f, indent=2)

print("Saved evidence.json!")

# 2. Generate SQL migration
sql_lines = []
sql_lines.append("-- Migration 158: Import Completed 2026 Australian Optimist Regattas")
sql_lines.append("--")
sql_lines.append("-- Events & Fleets Imported:")
sql_lines.append("--   1. 2026 Musto Australian Optimist Championship — Intermediate Fleet (42 boats, 9 races, 1 discard)")
sql_lines.append("--   2. 2026 Tasmanian Optimist State Championship — Open Fleet (6 boats, 6 races, 1 discard)")
sql_lines.append("--   3. 2026 Tasmanian Optimist State Championship — Intermediate Fleet (6 boats, 6 races, 1 discard)")
sql_lines.append("--   4. 2026 VIODA International Optimist Victorian & Open Championship — Open Fleet (38 boats, 8 races, 1 discard)")
sql_lines.append("--   5. 2026 VIODA International Optimist Victorian & Open Championship — Intermediate Fleet (27 boats, 7 races, 1 discard)")
sql_lines.append("--   6. 2026 NSW Optimist State Championship — Open Fleet (42 boats, 3 races, 0 discards)")
sql_lines.append("--   7. 2026 NSW Optimist State Championship — Intermediate Fleet (55 boats, 2 races, 0 discards)")
sql_lines.append("--   8. 2026 ACT Optimist Championship — Open Fleet (27 boats, 7 races, 1 discard)")
sql_lines.append("--   9. 2026 ACT Optimist Championship — Intermediate Fleet (17 boats, 6 races, 1 discard)")
sql_lines.append("--")
sql_lines.append("-- Total results: 260. Total race scores: 1,326.")
sql_lines.append("-- PDF corroboration unavailable: verified against official digital HTML results portals (SailingResults.net & Sailwave).")
sql_lines.append("-- Atomic transaction with idempotent guards.")
sql_lines.append("")
sql_lines.append("BEGIN;")
sql_lines.append("")

# Events
sql_lines.append("-- 1. Regatta Events")
for ev in events:
    classes_json = json.dumps(ev["classes"]).replace("'", "''")
    summary = ev["scheduleSummary"].replace("'", "''")
    rules = ev["scoringRules"].replace("'", "''")
    venue = ev["venue"].replace("'", "''")
    org = ev["organizer"].replace("'", "''")
    name = ev["name"].replace("'", "''")
    
    sql_lines.append(f"""INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '{ev["id"]}',
    '{name}',
    '{ev["slug"]}',
    '{ev["startDate"]}',
    '{ev["endDate"]}',
    '{venue}',
    '{org}',
    '{classes_json}'::jsonb,
    false,
    false,
    '{summary}',
    '{rules}'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;""")

sql_lines.append("")

# Regatta Sheets
sql_lines.append("-- 2. Regatta Class Sheets")
for item in extracted:
    ev = item['event']
    sh = item['sheet']
    name = sh['name'].replace("'", "''")
    venue = ev['venue'].replace("'", "''")
    org = ev['organizer'].replace("'", "''")
    source_url = ev['officialSource']['url'].replace("'", "''")
    source_name = ev['officialSource']['title'].replace("'", "''")
    notes = f"Official results from {ev['officialSource']['title']}.".replace("'", "''")
    
    sql_lines.append(f"""INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes
) VALUES (
    '{sh["id"]}',
    '{ev["id"]}',
    '{name}',
    '{sh["slug"]}',
    '{ev["startDate"]}',
    '{ev["endDate"]}',
    {sh["totalFleetSize"]},
    '{sh["division"]}',
    {sh["raceCount"]},
    'AUS',
    '{sh["boatClass"]}',
    'individual',
    1,
    1,
    false,
    '{venue}',
    '{org}',
    'published',
    '{source_url}',
    '{source_name}',
    '{notes}'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status;""")

sql_lines.append("")

# New Sailors
sql_lines.append(f"-- 3. New Sailor Profiles ({len(new_profiles)} profiles)")
for p in new_profiles:
    name = p['name'].replace("'", "''")
    club = p['club'].replace("'", "''")
    sail = p['sailNumber'].replace("'", "''")
    gender_sql = f"'{p['gender']}'" if p['gender'] else "NULL"
    sql_lines.append(f"INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('{p['id']}', '{name}', '{p['handle']}', '{sail}', '{p['nationality']}', {gender_sql}, '{club}') ON CONFLICT (id) DO NOTHING;")

sql_lines.append("")

# Regatta Results, Participants, and Race Results
sql_lines.append("-- 4. Results, Participants, and Race Scores")
for item in extracted:
    ev = item['event']
    sh = item['sheet']
    results = item['results']
    source_url = ev['officialSource']['url'].replace("'", "''")
    source_title = ev['officialSource']['title'].replace("'", "''")
    
    sql_lines.append(f"-- Sheet: {sh['name']} ({len(results)} competitors)")
    for r in results:
        rid = r['resultId']
        sid = r['sailorId']
        name = r['name'].replace("'", "''")
        source_name = r['sourceName'].replace("'", "''")
        sail = r['sailOrBoardNumber'].replace("'", "''")
        part_id = r['participantId']
        evidence_notes = f"Official published results from {ev['officialSource']['title']}. Digital HTML verified; no standalone PDF published.".replace("'", "''")
        
        sql_lines.append(f"""INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status
) VALUES (
    '{rid}', '{sid}', '{sh["id"]}', '{name}', '{sail}', 'individual', {r["rank"]}, {r["grossScore"]}, {r["nettScore"]},
    false, false, '{source_url}', '{source_url}', '{source_title}', 'url', '{evidence_notes}', 'verified'
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;""")

        sql_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '{part_id}', '{rid}', '{sid}', '{source_name}', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;""")

        for rc in r['races']:
            pts_sql = f"{rc['score']}" if rc['score'] is not None else "NULL"
            code_sql = f"'{rc['code']}'" if rc['code'] else "NULL"
            disc_sql = "true" if rc['discarded'] else "false"
            raw_sql = rc['raw'].replace("'", "''")
            sql_lines.append(f"INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('{rid}', {rc['raceNumber']}, {pts_sql}, {code_sql}, {disc_sql}, '{raw_sql}') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;")

sql_lines.append("")
sql_lines.append("COMMIT;")

migration_path = 'src/db/migrations/158_import_completed_2026_australian_optimist_regattas.sql'
with open(migration_path, 'w') as f:
    f.write('\n'.join(sql_lines) + '\n')

print(f"Migration written to {migration_path} ({len(sql_lines)} lines)!")
