import os
import json

BASE_DIR = 'scripts/imports/australia-zhik-youth-sail-2026'

with open(os.path.join(BASE_DIR, 'extracted_other_classes.json')) as f:
    data = json.load(f)

with open('scripts/imports/australia-optimist-2026/live-sailors.json') as f:
    existing_data = json.load(f)
existing_sailors = {s['id']: s for s in existing_data['rows'][0]['json_agg']}

for prev_path in [
    'scripts/imports/australia-optimist-2026/extracted.json',
    'scripts/imports/australia-zhik-youth-sail-2026/extracted.json'
]:
    with open(prev_path) as f:
        prev_data = json.load(f)
    for np in prev_data.get('newProfiles', []):
        existing_sailors[np['id']] = {
            'id': np['id'],
            'name': np['name'],
            'handle': np['handle'],
            'sail_number': np.get('sailNumber') or '',
            'club': np.get('club') or 'Australia',
            'nationality': np.get('nationality') or 'AUS',
            'gender': np.get('gender')
        }

events = data['events']
new_profiles = data['newProfiles']
extracted = data['extracted']

all_sailor_ids = set()
total_results = 0
total_participants = 0
total_race_scores = 0

for item in extracted:
    total_results += len(item['results'])
    for r in item['results']:
        total_race_scores += len(r['races'])
        for p in r['participants']:
            total_participants += 1
            all_sailor_ids.add(p['sailorId'])

profiles_to_ensure = []
for sid in sorted(all_sailor_ids):
    if sid in existing_sailors:
        s = existing_sailors[sid]
        profiles_to_ensure.append({
            'id': sid,
            'name': s['name'],
            'handle': s['handle'],
            'sailNumber': s.get('sail_number') or '',
            'club': s.get('club') or 'Australia',
            'nationality': s.get('nationality') or 'AUS',
            'gender': s.get('gender')
        })

for p in new_profiles:
    profiles_to_ensure.append(p)

print(f"Total results: {total_results}, total participants: {total_participants}, total race scores: {total_race_scores}")
print(f"Total profiles to ensure: {len(profiles_to_ensure)} (existing: {len(profiles_to_ensure) - len(new_profiles)}, new: {len(new_profiles)})")

sql_lines = []
sql_lines.append("-- Migration 160: Import 2026 Zhik Youth Sail Australian State Championships (ILCA 4, ILCA 6, ILCA 7, Techno 293, iQFOiL, 29er, 420)")
sql_lines.append("--")
sql_lines.append("-- Source Index: https://www.sailing.org.au/news/zhik-youth-sail-2026-save-the-dates")
sql_lines.append("-- Events & Fleets Imported (7 Events, 26 Class Sheets):")
for idx, item in enumerate(extracted, 1):
    sh = item['sheet']
    sql_lines.append(f"--  {idx:2d}. {sh['name']} ({sh['totalFleetSize']} boats, {sh['raceCount']} races, {sh['discardCount']} discards)")
sql_lines.append("--")
sql_lines.append(f"-- Total results: {total_results}. Total participants: {total_participants}. Total race scores: {total_race_scores}.")
sql_lines.append("-- PDF corroboration unavailable: verified against official digital scoring portals (SailingResults.net, TopYacht, Sportspage, SailSys).")
sql_lines.append("-- Atomic transaction with idempotent guards.")
sql_lines.append("")
sql_lines.append("BEGIN;")
sql_lines.append("")

# 1. Regatta Events
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

# 2. Regatta Class Sheets
sql_lines.append("-- 2. Regatta Class Sheets")
for item in extracted:
    ev = item['event']
    sh = item['sheet']
    name = sh['name'].replace("'", "''")
    venue = ev['venue'].replace("'", "''")
    org = ev['organizer'].replace("'", "''")
    source_url = sh['sourceUrl'].replace("'", "''")
    source_name = ev['officialSource']['title'].replace("'", "''")
    notes = f"Official results from {ev['officialSource']['title']}.".replace("'", "''")
    entry_type = 'crew' if sh['is_crew'] else 'individual'
    min_p = 1 if (not sh['is_crew'] or sh['slug'] == '2026-zhik-youth-sail-wa-420') else 2
    max_p = 2 if sh['is_crew'] else 1

    sql_lines.append(f"""INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
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
    '{entry_type}',
    {min_p},
    {max_p},
    false,
    '{venue}',
    '{org}',
    'published',
    '{source_url}',
    '{source_name}',
    '{notes}',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);""")

sql_lines.append("")

# 3. Sailor Profiles
sql_lines.append(f"-- 3. Sailor Profiles ({len(profiles_to_ensure)} profiles guaranteed)")
for p in profiles_to_ensure:
    name = p['name'].replace("'", "''")
    club = p['club'].replace("'", "''")
    sail = p['sailNumber'].replace("'", "''")
    gender_sql = f"'{p['gender']}'" if p['gender'] else "NULL"
    sql_lines.append(f"INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('{p['id']}', '{name}', '{p['handle']}', '{sail}', '{p['nationality']}', {gender_sql}, '{club}') ON CONFLICT (id) DO NOTHING;")

sql_lines.append("")

# 4. Results, Participants, and Race Scores
sql_lines.append("-- 4. Results, Participants, and Race Scores")
for item in extracted:
    ev = item['event']
    sh = item['sheet']
    results = item['results']
    source_url = sh['sourceUrl'].replace("'", "''")
    source_title = ev['officialSource']['title'].replace("'", "''")

    sql_lines.append(f"-- Sheet: {sh['name']} ({len(results)} entries)")
    for r in results:
        rid = r['resultId']
        sid = r['sailorId']
        entry_label = r['entryLabel'].replace("'", "''")
        entry_type = r['entryType']
        sail = r['sailOrBoardNumber'].replace("'", "''")
        evidence_notes = f"Official published results from {ev['officialSource']['title']}. Digital portal verified; no standalone PDF published.".replace("'", "''")

        sql_lines.append(f"""INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '{rid}', '{sid}', '{sh["id"]}', '{entry_label}', '{sail}', '{entry_type}', {r["rank"]}, {r["grossScore"]}, {r["nettScore"]},
    false, false, '{source_url}', '{source_url}', '{source_title}', 'url', '{evidence_notes}', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;""")

        for p in r['participants']:
            part_id = p['participantId']
            p_sid = p['sailorId']
            p_sname = p['sourceName'].replace("'", "''")
            p_order = p['displayOrder']
            p_role = p['role']
            sql_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '{part_id}', '{rid}', '{p_sid}', '{p_sname}', {p_order}, '{p_role}', 'matched', false
) ON CONFLICT (id) DO NOTHING;""")

        for rc in r['races']:
            pts_sql = f"{rc['score']}" if rc['score'] is not None else "NULL"
            code_sql = f"'{rc['code']}'" if rc['code'] else "NULL"
            disc_sql = "true" if rc['discarded'] else "false"
            raw_sql = rc['raw'].replace("'", "''")
            sql_lines.append(f"INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('{rid}', {rc['raceNumber']}, {pts_sql}, {code_sql}, {disc_sql}, '{raw_sql}') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;")

sql_lines.append("")
sql_lines.append("COMMIT;")

migration_path = 'src/db/migrations/160_import_2026_zhik_youth_sail_other_classes.sql'
with open(migration_path, 'w') as f:
    f.write('\n'.join(sql_lines) + '\n')

print(f"Migration written to {migration_path} ({len(sql_lines)} lines)!")
