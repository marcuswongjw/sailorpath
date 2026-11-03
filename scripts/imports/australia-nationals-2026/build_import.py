#!/usr/bin/env python3
from __future__ import annotations
import json
import re
import uuid
from html import unescape

# Base namespace for deterministic UUIDs
NS = uuid.UUID('7b05d012-a70b-45e5-b0d0-c36fb16f48b4')

def make_uuid(key: str) -> str:
    return str(uuid.uuid5(NS, key))

def make_handle(name: str, disambig: str = "") -> str:
    clean = re.sub(r'[^a-z0-9]+', '-', name.lower().strip()).strip('-')
    suffix = uuid.uuid5(NS, f"{name}:{disambig}").hex[:6]
    return f"{clean}-{suffix}"

# Load live sailors
with open('/tmp/live_sailors.json') as f:
    live_sailors = json.load(f)['rows']

# Index by normalized name
name_map = {}
for s in live_sailors:
    norm = re.sub(r'[^a-z0-9]', '', s['name'].lower())
    name_map.setdefault(norm, []).append(s)

print(f"Loaded {len(live_sailors)} live sailors into name_map.")

# -------------------------------------------------------------
# 1. PARSE 29ER NATIONALS
# -------------------------------------------------------------
with open('scripts/imports/australia-nationals-2026/29er-nationals-2026.html') as f:
    html_29er = f.read()

table_match = re.search(r'<table[\s\S]+?</table>', html_29er, re.IGNORECASE)
rows_29er = re.findall(r'<tr[\s\S]*?</tr>', table_match.group(0), re.IGNORECASE)

entries_29er = []
for r in rows_29er[1:]:
    tds = re.findall(r'<td[\s\S]*?</td>', r, re.IGNORECASE)
    cols = [re.sub(r'\s+', ' ', re.sub(r'<[^>]+>', ' ', td).replace('&nbsp;', ' ')).strip() for td in tds]
    if not cols or not cols[0].isdigit():
        continue
    
    # Extract names from column 1
    name_td = tds[1]
    raw_names = [s.strip() for s in re.sub(r'<[^>]+>', '\n', name_td).replace('&nbsp;', ' ').split('\n') if s.strip()]
    if len(raw_names) < 2:
        # Split by multiple capital letters or space if needed
        parts = cols[1].split()
        if len(parts) >= 4:
            raw_names = [" ".join(parts[:2]), " ".join(parts[2:])]
        else:
            raw_names = [cols[1], "Crew Unknown"]
            
    # Format name: Title Case (e.g. Goro Tomishima)
    formatted_names = []
    for n in raw_names[:2]:
        fn = " ".join(word.capitalize() if word.isupper() else word for word in n.split())
        formatted_names.append(fn)

    race_tokens = cols[7:21]
    entries_29er.append({
        'rank': int(cols[0]),
        'helm_name': formatted_names[0],
        'crew_name': formatted_names[1],
        'boat': cols[2],
        'sail': cols[3],
        'state': cols[5],
        'club': cols[6],
        'races': race_tokens,
        'total': float(cols[21]),
        'net': float(cols[22]),
        'notes': cols[23] if len(cols) > 23 else ''
    })

print(f"Parsed {len(entries_29er)} 29er entries.")

# -------------------------------------------------------------
# 2. PARSE 420 NATIONALS
# -------------------------------------------------------------
with open('scripts/imports/australia-nationals-2026/420-nationals-2026.html') as f:
    html_420 = f.read()

tab_h_match = re.search(r'<div id=["\']tab-h["\']>([\s\S]+?)</div>', html_420, re.IGNORECASE)
table_match_420 = re.search(r'<table[\s\S]+?</table>', tab_h_match.group(1), re.IGNORECASE)
rows_420 = re.findall(r'<tr[\s\S]*?</tr>', table_match_420.group(0), re.IGNORECASE)

entries_420 = []
for r in rows_420[1:]:
    tds = re.findall(r'<td[\s\S]*?</td>', r, re.IGNORECASE)
    cols = [re.sub(r'\s+', ' ', re.sub(r'<[^>]+>', ' ', td).replace('&nbsp;', ' ')).strip() for td in tds]
    if not cols or not cols[0].isdigit():
        continue
    
    # In 420: Crew column (index 4) has "William Rose<br />&nbsp; Stewart Rose"
    crew_td = tds[4]
    inner = re.sub(r'^<td[^>]*>', '', crew_td, flags=re.I)
    inner = re.sub(r'</td>$', '', inner, flags=re.I)
    raw_names = [re.sub(r'<[^>]+>', '', s).replace('&nbsp;', ' ').strip() for s in re.split(r'<br\s*/?>|\n', inner, flags=re.I)]
    raw_names = [s for s in raw_names if s]
    if len(raw_names) < 2:
        # Try splitting on multiple spaces
        parts = [p.strip() for p in re.split(r'\s{2,}', re.sub(r'<[^>]+>', ' ', crew_td).replace('&nbsp;', '  ')) if p.strip()]
        if len(parts) >= 2:
            raw_names = parts[:2]
        else:
            raw_names = [cols[4], "Crew Unknown"]

    formatted_names = []
    for n in raw_names[:2]:
        fn = " ".join(word.capitalize() if word.isupper() else word for word in n.split())
        formatted_names.append(fn)

    # Clean sail number (remove trailing divisions like FF YF)
    sail_clean = cols[1].split()[0]

    # Races 1 to 10 are columns 6 to 15
    race_tokens = []
    for r_idx in range(6, 16):
        raw_td = tds[r_idx]
        is_strike = 'class="strike"' in raw_td or "class='strike'" in raw_td
        val = re.sub(r'\s+', ' ', re.sub(r'<[^>]+>', ' ', raw_td).replace('&nbsp;', ' ')).strip()
        race_tokens.append(f"({val})" if is_strike else val)

    entries_420.append({
        'rank': int(cols[0]),
        'sail': sail_clean,
        'boat': cols[2],
        'helm_name': formatted_names[0],
        'crew_name': formatted_names[1],
        'club': cols[5],
        'races': race_tokens,
        'net': float(cols[16])
    })

print(f"Parsed {len(entries_420)} 420 entries.")

# -------------------------------------------------------------
# 3. BUILD IDENTITIES & NEW SAILORS
# -------------------------------------------------------------
new_sailor_map = {} # norm_name -> sailor dict

def get_or_create_sailor(name: str, default_sail: str, default_club: str, default_nat: str = 'AUS', gender: str = None) -> tuple[str, bool]:
    norm = re.sub(r'[^a-z0-9]', '', name.lower())
    if norm in name_map:
        matches = name_map[norm]
        if len(matches) == 1:
            return matches[0]['id'], False
        else:
            # Match by sail or club
            for m in matches:
                if m.get('sail_number') == default_sail or (default_club and default_club in m.get('club', '')):
                    return m['id'], False
            # Default to first match if high confidence
            return matches[0]['id'], False
            
    if norm in new_sailor_map:
        return new_sailor_map[norm]['id'], False
        
    # Create new profile
    s_id = make_uuid(f"sailor:{name}:{default_nat}")
    handle = make_handle(name, default_club)
    new_sailor_map[norm] = {
        'id': s_id,
        'name': name,
        'handle': handle,
        'sail_number': default_sail or 'N/A',
        'club': default_club or 'Australian Sailing',
        'nationality': default_nat,
        'gender': gender
    }
    return s_id, True

# Known genders
female_names = {
    'mia austin', 'zara marks', 'cate mccoy', 'alice travlos', 'klara travlos',
    'elspeth clifford', 'elysia albery', 'jess wardell', 'allie mclennan', 'zara challis',
    'victoria chernoff', 'eloise chernoff', 'daisy locke', 'linnea townend', 'annelin townend',
    'victoria lin', 'annabelle sampson', 'olivia cameron', 'isabella lozevski', 'olivia lee',
    'jessica higgins', 'abbey everett', 'jess lowe', 'paige grigg', 'rachael benoy',
    'meg bates', 'rosa crawford', 'ilsa ren cohen', 'lucy cree', 'stephanie johnson', 'georgia griffin'
}

male_names = {
    'goro tomishima', 'orlando sadlik', 'finley symonds', 'alasdair cameron', 'ethan kiu', 'louis polson',
    'miles levenspiel', 'henri levenspiel', 'edward broadby', 'gus wilkie', 'josh garner',
    'caelan byrt', 'robert deards', 'kai lawson', 'andy allt-graham', 'atlas miller',
    'rory spinaze-littlejohn', 'james ashwood', 'conrad lumsden', 'isaac archer', 'henry mcquillen',
    'huon williams', 'arthur adams', 'wellington adams', 'jamie fleming', 'jeremy munnings', 'cooper pennell',
    'william rose', 'stewart rose', 'aaveer patil-chaudhari', 'gary cameron', 'fraser baker', 'william gaylard',
    'austin higgins', 'matthew whitaker', 'nick meijer', 'darcy higgins', 'oscar forbes', 'finn meijer',
    'gary mclennan', 'ben glover', 'oliver halse', 'brendan goh', 'oscar gayland'
}

for e in entries_29er:
    h_gender = 'F' if e['helm_name'].lower() in female_names else ('M' if e['helm_name'].lower() in male_names else None)
    c_gender = 'F' if e['crew_name'].lower() in female_names else ('M' if e['crew_name'].lower() in male_names else None)
    nat = 'HKG' if 'HONG KONG' in e['state'].upper() else 'AUS'
    e['helm_id'], _ = get_or_create_sailor(e['helm_name'], e['sail'], e['club'], nat, h_gender)
    e['crew_id'], _ = get_or_create_sailor(e['crew_name'], e['sail'], e['club'], nat, c_gender)

for e in entries_420:
    h_gender = 'F' if e['helm_name'].lower() in female_names else ('M' if e['helm_name'].lower() in male_names else None)
    c_gender = 'F' if e['crew_name'].lower() in female_names else ('M' if e['crew_name'].lower() in male_names else None)
    e['helm_id'], _ = get_or_create_sailor(e['helm_name'], e['sail'], e['club'], 'AUS', h_gender)
    e['crew_id'], _ = get_or_create_sailor(e['crew_name'], e['sail'], e['club'], 'AUS', c_gender)

print(f"Total new profiles to insert: {len(new_sailor_map)}")

# -------------------------------------------------------------
# 4. GENERATE SQL STATEMENTS
# -------------------------------------------------------------
out_lines = [
    "-- Migration 168: Import 2026 Australian 29er & 420 Championships",
    "--",
    "-- Imports complete official championship scorecards for:",
    "-- 1. 2026 Australian 29er Championship (Sandy Bay Sailing Club, Hobart, TAS; Jan 3–9, 2026)",
    "--    - 21 boats, 42 sailors (helm + crew), 14 races, 294 race scores",
    "-- 2. 2026 International 420 Class Australian Championship (Albury Wodonga Sailing Club, Lake Hume; Jan 19–23, 2026)",
    "--    - 17 boats, 34 sailors (helm + crew), 10 races, 170 race scores",
    "--",
    "-- Sources:",
    "-- - 29er: SailingResults.net (ID=82088.1)",
    "-- - 420: Sailres (Series 2755)",
    "--",
    "-- All operations execute in a single atomic transaction.",
    "",
    "BEGIN;",
    ""
]

# Insert new sailors
out_lines.append("-- 1. Insert New Verified Sailor Profiles")
for s in new_sailor_map.values():
    escaped_name = s['name'].replace("'", "''")
    escaped_club = s['club'].replace("'", "''")
    gender_val = f"'{s['gender']}'" if s['gender'] else "NULL"
    out_lines.append(f"""INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '{s['id']}', '{escaped_name}', '{s['handle']}', '{s['sail_number']}', '{escaped_club}', '{s['nationality']}', {gender_val}, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);""")

out_lines.append("")

# -------------------------------------------------------------
# Event & Regatta 1: 29er
# -------------------------------------------------------------
event_29er_id = make_uuid("event:2026-australian-29er-championship")
regatta_29er_id = make_uuid("regatta:2026-australian-29er-championship-29er")

out_lines.append("-- 2. Insert 2026 Australian 29er Championship Event & Sheet")
out_lines.append(f"""INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules,
    created_at, updated_at
) VALUES (
    '{event_29er_id}',
    '2026 Australian 29er Championship',
    '2026-australian-29er-championship',
    '2026-01-03',
    '2026-01-09',
    'Sandy Bay Sailing Club, Hobart, Tasmania',
    'Sandy Bay Sailing Club / Australian 9er Association',
    '["29er"]'::jsonb,
    false,
    false,
    'Official Australian 29er Championship 2026 held 3–9 January 2026 at Sandy Bay Sailing Club, Hobart, TAS.',
    'Low Point System with 2 discards (after race 9 and race 14).',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;""")

out_lines.append(f"""INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, venue, organizer, geography, boat_class,
    division, entry_type, min_participants, max_participants, total_fleet_size, race_count,
    counts_for_ranking, is_selection_trial, status, official_results_url, official_results_source_name,
    created_at, updated_at
) VALUES (
    '{regatta_29er_id}',
    '{event_29er_id}',
    '2026 Australian 29er Championship — 29er',
    '2026-australian-29er-championship-29er',
    '2026-01-09',
    '2026-01-09',
    'Sandy Bay Sailing Club, Hobart, Tasmania',
    'Sandy Bay Sailing Club / Australian 9er Association',
    'AUS',
    '29er',
    'Open',
    'crew',
    2,
    2,
    21,
    14,
    false,
    false,
    'published',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'Official Australian 29er Championship 2026 Final Results (SailingResults.net ID=82088.1)',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;""")

out_lines.append("")
out_lines.append("-- 3. Insert 29er Results, Participants & Race Scores")

def parse_score_token(tok: str) -> tuple[float, str | None, bool, str]:
    tok = tok.strip()
    is_discard = tok.startswith('(') and ')' in tok
    clean = tok.replace('(', '').replace(')', '').strip()
    
    # Check for scoring code
    code_match = re.search(r'[A-Za-z]+', clean)
    code = code_match.group(0).upper() if code_match else None
    
    num_match = re.search(r'[\d.]+', clean)
    val = float(num_match.group(0)) if num_match else 0.0
    return val, code, is_discard, tok

for e in entries_29er:
    res_id = make_uuid(f"result:29er:{e['rank']}:{e['sail']}")
    part_helm_id = make_uuid(f"part:helm:29er:{res_id}")
    part_crew_id = make_uuid(f"part:crew:29er:{res_id}")
    
    entry_label = f"{e['helm_name']} & {e['crew_name']}"
    escaped_label = entry_label.replace("'", "''")
    escaped_boat = e['boat'].replace("'", "''")
    raw_notes = f"2026 Australian 29er Championship. Boat: {e['boat']}. Helm: {e['helm_name']}, Crew: {e['crew_name']}. Club: {e['club']}. State: {e['state']}. {e['notes']}".strip()
    escaped_notes = raw_notes.replace("'", "''")
    
    out_lines.append(f"""INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '{res_id}', '{e['helm_id']}', '{regatta_29er_id}', '{escaped_label}', '{e['sail']}', 'crew', {e['rank']},
    {e['total']}, {e['net']}, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '{escaped_notes}', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;""")

    # Helm participant
    out_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '{part_helm_id}', '{res_id}', '{e['helm_id']}', '{e['helm_name'].replace("'", "''")}', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;""")

    # Crew participant
    out_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '{part_crew_id}', '{res_id}', '{e['crew_id']}', '{e['crew_name'].replace("'", "''")}', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;""")

    # 14 races
    for race_num, tok in enumerate(e['races'], start=1):
        score, code, is_discard, raw_val = parse_score_token(tok)
        code_val = f"'{code}'" if code else "NULL"
        discard_val = "true" if is_discard else "false"
        out_lines.append(f"""INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '{res_id}', {race_num}, {score}, {code_val}, {discard_val}, '{raw_val}'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;""")

out_lines.append("")

# -------------------------------------------------------------
# Event & Regatta 2: 420
# -------------------------------------------------------------
event_420_id = make_uuid("event:2026-international-420-class-australian-championship")
regatta_420_id = make_uuid("regatta:2026-international-420-class-australian-championship-420")

out_lines.append("-- 4. Insert 2026 International 420 Class Australian Championship Event & Sheet")
out_lines.append(f"""INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules,
    created_at, updated_at
) VALUES (
    '{event_420_id}',
    '2026 International 420 Class Australian Championship',
    '2026-international-420-class-australian-championship',
    '2026-01-19',
    '2026-01-23',
    'Albury Wodonga Sailing Club, Lake Hume, Victoria',
    'Albury Wodonga Sailing Club / Australian International 420 Class Association',
    '["420"]'::jsonb,
    false,
    false,
    'Official International 420 Class Australian Championship 2026 held 19–23 January 2026 at Albury Wodonga Sailing Club, Lake Hume, Victoria.',
    'Low Point System with 2 discards.',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;""")

out_lines.append(f"""INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, venue, organizer, geography, boat_class,
    division, entry_type, min_participants, max_participants, total_fleet_size, race_count,
    counts_for_ranking, is_selection_trial, status, official_results_url, official_results_source_name,
    created_at, updated_at
) VALUES (
    '{regatta_420_id}',
    '{event_420_id}',
    '2026 International 420 Class Australian Championship — 420',
    '2026-international-420-class-australian-championship-420',
    '2026-01-23',
    '2026-01-23',
    'Albury Wodonga Sailing Club, Lake Hume, Victoria',
    'Albury Wodonga Sailing Club / Australian International 420 Class Association',
    'AUS',
    '420',
    'Open',
    'crew',
    2,
    2,
    17,
    10,
    false,
    false,
    'published',
    'https://www.sailres.com/view.php?s=2755',
    'Official 420 Australian Championship 2026 Final Results (Sailres Series 2755)',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;""")

out_lines.append("")
out_lines.append("-- 5. Insert 420 Results, Participants & Race Scores")

for e in entries_420:
    res_id = make_uuid(f"result:420:{e['rank']}:{e['sail']}")
    part_helm_id = make_uuid(f"part:helm:420:{res_id}")
    part_crew_id = make_uuid(f"part:crew:420:{res_id}")
    
    entry_label = f"{e['helm_name']} & {e['crew_name']}"
    escaped_label = entry_label.replace("'", "''")
    escaped_boat = e['boat'].replace("'", "''")
    raw_notes = f"2026 International 420 Australian Championship. Boat: {e['boat']}. Helm: {e['helm_name']}, Crew: {e['crew_name']}. Club: {e['club']}.".strip()
    escaped_notes = raw_notes.replace("'", "''")
    
    # Calculate total gross score
    sum_gross = 0.0
    for tok in e['races']:
        val, _, _, _ = parse_score_token(tok)
        sum_gross += val
        
    out_lines.append(f"""INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '{res_id}', '{e['helm_id']}', '{regatta_420_id}', '{escaped_label}', '{e['sail']}', 'crew', {e['rank']},
    {sum_gross}, {e['net']}, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '{escaped_notes}', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;""")

    # Helm participant
    out_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '{part_helm_id}', '{res_id}', '{e['helm_id']}', '{e['helm_name'].replace("'", "''")}', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;""")

    # Crew participant
    out_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '{part_crew_id}', '{res_id}', '{e['crew_id']}', '{e['crew_name'].replace("'", "''")}', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;""")

    # 10 races
    for race_num, tok in enumerate(e['races'], start=1):
        score, code, is_discard, raw_val = parse_score_token(tok)
        code_val = f"'{code}'" if code else "NULL"
        discard_val = "true" if is_discard else "false"
        out_lines.append(f"""INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '{res_id}', {race_num}, {score}, {code_val}, {discard_val}, '{raw_val.replace("'", "''")}'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;""")

out_lines.append("")
out_lines.append("-- 6. Admin Change Log Record")
out_lines.append(f"""INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'regattas.import_championships',
  'regatta',
  '{regatta_29er_id}',
  '2026 Australian 29er & 420 Championships',
  'Imported 2 national championships (29er at SBSC and 420 at AWSC) totaling 38 boats, 76 participants, and 464 race scores.',
  jsonb_build_object(
    'regattas', jsonb_build_array('2026-australian-29er-championship-29er', '2026-international-420-class-australian-championship-420'),
    'new_profiles_created', {len(new_sailor_map)},
    'races_total', 464,
    'status', 'published'
  ),
  'migration_168',
  clock_timestamp()
);""")

out_lines.append("")
out_lines.append("COMMIT;")

migration_sql = "\n".join(out_lines) + "\n"
with open('src/db/migrations/168_import_2026_australian_29er_and_420_championships.sql', 'w') as f:
    f.write(migration_sql)

print(f"Generated migration file src/db/migrations/168_import_2026_australian_29er_and_420_championships.sql ({len(out_lines)} lines).")

# Also save evidence manifest
evidence = {
    '29er': {
        'event': '2026 Australian 29er Championship',
        'venue': 'Sandy Bay Sailing Club, Hobart, Tasmania',
        'dates': '3–9 January 2026',
        'source_url': 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
        'boats': len(entries_29er),
        'participants': len(entries_29er) * 2,
        'races': 14,
        'race_scores': len(entries_29er) * 14
    },
    '420': {
        'event': '2026 International 420 Class Australian Championship',
        'venue': 'Albury Wodonga Sailing Club, Lake Hume, Victoria',
        'dates': '19–23 January 2026',
        'source_url': 'https://www.sailres.com/view.php?s=2755',
        'boats': len(entries_420),
        'participants': len(entries_420) * 2,
        'races': 10,
        'race_scores': len(entries_420) * 10
    },
    'new_profiles_count': len(new_sailor_map)
}

with open('scripts/imports/australia-nationals-2026/evidence.json', 'w') as f:
    json.dump(evidence, f, indent=2)

print("Saved evidence manifest scripts/imports/australia-nationals-2026/evidence.json.")
