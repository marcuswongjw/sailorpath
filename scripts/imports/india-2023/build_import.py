#!/usr/bin/env python3
"""
Builder script for Migration 177:
YAI Junior National Sailing Championship 2023 (06 TO 12 OCT at Colaba, Mumbai).
Organized by the Yachting Association of India (YAI).
Source: https://www.yai.org.in / Official PDF: youth_nationals_2023.pdf
"""
from __future__ import annotations
import json
import re
import uuid
import pypdf

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

# Index by sail number and by normalized name
name_map = {}
sail_map = {}
for s in live_sailors:
    norm = re.sub(r'[^a-z0-9]', '', s['name'].lower())
    name_map.setdefault(norm, []).append(s)
    sn = s.get('sail_number')
    if sn:
        clean_sn = re.sub(r'[^0-9]', '', sn)
        if clean_sn:
            sail_map.setdefault(clean_sn, []).append(s)

print(f"Loaded {len(live_sailors)} live sailors.")

# Known aliases / name matches for Indian sailors
alias_map = {
    'alia sabreen faisal': 'alia sabren faisal',
    'md riziwan': 'rizwan mohammed',
}

matched_count = 0
created_count = 0
new_sailor_map = {}

def get_or_create_sailor(raw_name: str, club: str, sail_no: str, gender: str = 'M') -> tuple[str, str, bool]:
    global matched_count, created_count
    # Clean name
    clean_name = re.sub(r'([a-z])([A-Z])', r'\1 \2', raw_name).strip()
    norm = re.sub(r'[^a-z0-9]', '', clean_name.lower())
    clean_sn = re.sub(r'[^0-9]', '', sail_no)

    # 1. Alias lookup
    if norm in alias_map:
        norm = re.sub(r'[^a-z0-9]', '', alias_map[norm])

    # 2. Name match among IND sailors
    cands = [s for s in name_map.get(norm, []) if s.get('nationality') == 'IND']
    if cands:
        matched_count += 1
        return cands[0]['id'], cands[0]['name'], False

    # 3. Sail number match among IND sailors
    if clean_sn and clean_sn in sail_map:
        sn_cands = [s for s in sail_map[clean_sn] if s.get('nationality') == 'IND']
        if sn_cands:
            matched_count += 1
            return sn_cands[0]['id'], sn_cands[0]['name'], False

    # 4. Create new profile
    if norm in new_sailor_map:
        return new_sailor_map[norm]['id'], clean_name, False

    sid = make_uuid(f"sailor:IND:{clean_name}:{clean_sn}")
    handle = make_handle(clean_name, f"ind-{sid[:4]}")
    clean_sail = sail_no.strip() if sail_no.startswith('IND') else f"IND {sail_no.strip()}"
    new_sailor_map[norm] = {
        'id': sid,
        'name': clean_name,
        'handle': handle,
        'sail_number': clean_sail,
        'club': club,
        'nationality': 'IND',
        'gender': gender,
    }
    created_count += 1
    return sid, clean_name, True

# -------------------------------------------------------------
# 1. RAW VERIFIED DATA FOR 29er & 420 (Pages 1 & 2)
# -------------------------------------------------------------
data_29er = [
    (1, '88', 'NBSC', 'Sunil Mudavath', 'M', 'Satyam Jha', 'M', ['1.0', '1.0', '1.0', '1.0', '1.0', '1.0', '1.0', '1.0', '1.0', '(4.0 DNC)'], 13.0, 9.0),
    (2, '38', 'NBSC', 'Nikhil Dilip Mandavkar', 'M', 'Karrolla Karthik', 'M', ['2.0', '2.0', '2.0', '2.0', '2.0', '2.0', '2.0', '(4.0 DNS)', '4.0 DNC', '4.0 DNC'], 26.0, 22.0),
    (3, 'IND 2501', 'NBSC', 'Vikram Singh Bhati', 'M', 'Shivam Waimiki', 'M', ['3.0', '3.0', '(4.0 RET)', '4.0 DNS', '4.0 DNF', '3.0', '4.0 RET', '4.0 DNS', '4.0 DNC', '4.0 DNC'], 37.0, 33.0),
]

data_420 = [
    (1, 'IND 55426', 'YCH', 'Laveti Dharani', 'M', 'Vadla Mallesh', 'M', ['(2.0)', '2.0', '2.0', '1.0', '1.0', '1.0', '1.0', '1.0', '1.0', '1.0'], 13.0, 11.0),
    (2, 'IND 54657', 'YCH', 'Kameshwar Thanuja', 'M', 'Akhil Pilli', 'M', ['1.0', '1.0', '1.0', '(2.0)', '2.0', '2.0', '2.0', '2.0', '2.0', '2.0'], 17.0, 15.0),
    (3, 'IND 54658', 'YCH', 'V Vaishnavi', 'F', 'Ittamalla Pranay', 'M', ['(4.0 DNC)', '4.0 DNC', '4.0 DNC', '4.0 DNC', '4.0 DNC', '4.0 DNC', '4.0 DNC', '4.0 DNC', '4.0 DNC', '4.0 DNC'], 40.0, 36.0),
]

# -------------------------------------------------------------
# 2. RAW VERIFIED DATA FOR ILCA 4 (Boys & Girls) & ILCA 6 (Pages 3, 4, 6)
# -------------------------------------------------------------
data_ilca4_boys = [
    (1, '210444', 'NSS', 'Akshat Kumar Dohare', 'M', ['1.0', '1.0', '1.0', '1.0', '3.0', '(5.0)', '4.0', '3.0', '3.0', '3.0'], 25.0, 20.0),
    (2, '222622', 'NBSC', 'Padidala Vishwanath', 'M', ['2.0', '2.0', '2.0', '3.0', '1.0', '2.0', '2.0', '4.0', '(5.0)', '2.0'], 25.0, 20.0),
    (3, 'IND 210439', 'NSS', 'Shashank Batham', 'M', ['(4.0)', '3.0', '3.0', '2.0', '2.0', '1.0', '3.0', '1.0', '4.0', '4.0'], 27.0, 23.0),
    (4, '210440', 'NSS', 'Ajay Yadav', 'M', ['3.0', '4.0', '(7.0)', '6.0', '6.0', '3.0', '1.0', '2.0', '1.0', '1.0'], 34.0, 27.0),
    (5, '209822', 'YCH', 'Sravan Katravath', 'M', ['5.0', '5.0', '6.0', '5.0', '5.0', '6.0', '6.0', '5.0', '2.0', '(7.0)'], 52.0, 45.0),
    (6, '222649', 'NBSC', 'Ramakant', 'M', ['6.0', '(12.0 DSQ)', '5.0', '4.0', '4.0', '4.0', '5.0', '9.0 SCP', '7.0', '5.0'], 61.0, 49.0),
    (7, 'IND 163225', 'YCH', 'M S Daniel', 'M', ['(8.0)', '6.0', '4.0', '7.0', '7.0', '7.0', '7.0', '7.0', '6.0', '8.0'], 67.0, 59.0),
    (8, 'IND 147865', 'YCH', 'I Pranay', 'M', ['9.0', '7.0', '9.0', '8.0', '8.0', '(10.0)', '8.0', '9.0', '8.0', '10.0'], 86.0, 76.0),
    (9, 'IND 197841', 'YCH', 'Peerkatla Ganesh', 'M', ['7.0', '8.0', '(10.0)', '10.0', '9.0', '9.0', '9.0', '8.0', '9.0', '9.0'], 88.0, 78.0),
    (10, 'IND 152064', 'TNSA', 'M Deepak Kumar', 'M', ['10.0', '9.0', '8.0', '9.0', '10.0', '8.0', '10.0', '(11.0)', '10.0', '6.0'], 91.0, 80.0),
    (11, 'IND 185629', 'TNSA', 'Krishna Govinda Ashyanth', 'M', ['(12.0 DNF)', '10.0', '12.0 NSC', '11.0', '12.0 DNF', '11.0', '11.0', '10.0', '12.0 DNF', '11.0'], 112.0, 100.0),
]

data_ilca4_girls = [
    (1, 'IND 197847', 'YCH', 'Veera Vamasham Vaishnavi', 'F', ['3.0', '2.0', '1.0', '2.0', '1.0', '2.0', '2.0', '3.0', '1.0', '(4.0)'], 21.0, 17.0),
    (2, 'IND 214786', 'TNSA', 'Alia Sabreen Faisal', 'F', ['1.0', '1.0', '2.0', '1.0', '2.0', '(3.0)', '1.0', '7.0 DNE', '2.0', '3.0'], 23.0, 20.0),
    (3, 'IND 210438', 'NSS', 'Divyanshi Mishra', 'F', ['2.0', '4.0', '3.0', '3.0', '3.0', '1.0', '3.0', '2.0', '(5.0)', '1.0'], 27.0, 22.0),
    (4, 'IND 210431', 'NSS', 'Somya Singh Patel', 'F', ['4.0', '5.0', '4.0', '4.0', '4.0', '4.0', '4.0', '5.0', '(6.0)', '2.0'], 42.0, 36.0),
    (5, '209906', 'SSC', 'Maanya Reddy', 'F', ['5.0', '3.0', '5.0', '(6.0)', '5.0', '5.0', '5.0', '1.0', '3.0', '5.0'], 43.0, 37.0),
    (6, 'IND 197403', 'RBYC', 'Aarya Roate', 'F', ['(6.0)', '6.0', '6.0', '5.0', '6.0', '6.0', '6.0', '4.0', '4.0', '6.0'], 55.0, 49.0),
]

data_ilca6 = [
    (1, '212153', 'TSC', 'Sikhansu Singh', 'M', ['1.0', '1.0', '2.0', '1.0', '1.0', '1.0', '1.0', '1.0', '4.0', '(11.0 DNC)'], 24.0, 13.0),
    (2, 'IND 210441', 'NSS', 'Rammilan Yadav', 'M', ['2.0', '3.0', '1.0', '2.0', '2.0', '2.0', '2.0', '2.0', '1.0', '(11.0 DNC)'], 28.0, 17.0),
    (3, 'IND 222622', 'NBSC', 'Sachin', 'M', ['4.0', '(5.0)', '3.0', '4.0', '3.0', '3.0', '4.0', '5.0', '2.0', '1.0'], 34.0, 29.0),
    (4, '207336', 'CESC/TSC', 'Aryan Harshayana', 'M', ['(5.0)', '4.0', '4.0', '3.0', '4.0', '4.0', '3.0', '3.0', '3.0', '2.0'], 35.0, 30.0),
    (5, '212674', 'INWTC(M)', 'Kalaimuthu C', 'M', ['(6.0)', '6.0', '6.0', '5.0', '5.0', '5.0', '5.0', '4.0', '5.0', '4.0'], 51.0, 45.0),
    (6, 'IND 138437', 'TNSA', 'Sumant Arunachalam', 'M', ['(7.0)', '7.0', '5.0', '6.0', '6.0', '6.0', '6.0', '7.0', '6.0', '3.0'], 59.0, 52.0),
    (7, '210448', 'YAM', 'Mandeep', 'M', ['8.0', '8.0', '(9.0)', '9.0', '8.0', '7.0', '7.0', '6.0', '7.0', '5.0'], 74.0, 65.0),
    (8, '200430', 'RBYC', 'Luv Sakpal', 'M', ['9.0', '9.0', '7.0', '7.0', '7.0', '9.0', '9.0', '(11.0 RET)', '9.0', '6.0'], 83.0, 72.0),
    (9, '202013', 'CESC', 'Pareekshit Nair', 'M', ['(10.0)', '10.0', '8.0', '8.0', '9.0', '8.0', '8.0', '8.0', '8.0', '7.0'], 84.0, 74.0),
    (10, 'IND 210442', 'NSS', 'Ritika Dangi', 'F', ['3.0', '2.0', '(11.0 DNC)', '11.0 DNC', '11.0 DNC', '11.0 DNC', '11.0 DNC', '11.0 DNC', '11.0 DNC', '11.0 DNC'], 93.0, 82.0),
]

# -------------------------------------------------------------
# 3. PARSE OPTIMIST FLEET (Pages 7 & 8)
# -------------------------------------------------------------
reader = pypdf.PdfReader('scripts/imports/india-2023/results.pdf')
txt_opti = reader.pages[6].extract_text() + '\n' + reader.pages[7].extract_text()
lines_opti = [l.strip() for l in txt_opti.split('\n') if l.strip()]

def normalize_opti_line(l):
    l = re.sub(r'^(\d+(?:st|nd|rd|th))([A-Za-z])', r'\1 \2', l)
    l = re.sub(r'([A-Za-z])(Boy|Girl)', r'\1 \2', l)
    l = re.sub(r'([A-Za-z/()]+)Optimist', r'\1 Optimist', l)
    l = re.sub(r'Optimist(?:IND)?(\d+)', r'Optimist IND \1', l)
    l = re.sub(r'(\d+\.\d)(\d+\.\d)$', r'\1 \2', l)
    return l

data_optimist = []
for l in lines_opti:
    if re.match(r'^\d+(?:st|nd|rd|th)', l):
        norm_l = normalize_opti_line(l)
        m = re.match(r'^(\d+(?:st|nd|rd|th))\s+(.*?)\s+(Boy|Girl)\s+([A-Za-z/()]+)\s+Optimist\s+IND\s+(\d+)\s+(.*?)\s+(\d+\.\d+)\s+(\d+\.\d+)$', norm_l)
        assert m, f"Failed to match line: {norm_l}"
        rank_str, name, gender_str, club, sail_no, scores_str, gross_str, net_str = m.groups()
        rank = int(re.search(r'\d+', rank_str).group(0))
        gross = float(gross_str)
        net = float(net_str)
        tokens = re.findall(r'\(?\d+\.?\d*(?:\s*[A-Z]+)?\)?', scores_str)
        gender = 'M' if gender_str == 'Boy' else 'F'
        data_optimist.append((rank, f"IND {sail_no}", club, name.strip(), gender, tokens, gross, net))

assert len(data_optimist) == 49, f"Expected 49 Optimist entries, got {len(data_optimist)}"

# -------------------------------------------------------------
# 4. MATHEMATICAL VERIFICATION LOOP
# -------------------------------------------------------------
all_fleets_raw = [
    ('29er', '29er', 'Open', 'crew', 2, 2, data_29er),
    ('420', '420', 'Open', 'crew', 2, 2, data_420),
    ('ILCA 4 (Boys)', 'ILCA 4', 'Boys', 'individual', 1, 1, [(b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7]) for b in data_ilca4_boys]),
    ('ILCA 4 (Girls)', 'ILCA 4', 'Girls', 'individual', 1, 1, [(b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7]) for b in data_ilca4_girls]),
    ('ILCA 6', 'ILCA 6', 'Open', 'individual', 1, 1, [(b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7]) for b in data_ilca6]),
    ('Optimist', 'optimist', 'Open', 'individual', 1, 1, data_optimist),
]

total_entries = 0
for fn, bclass, div, etype, min_p, max_p, fleet_data in all_fleets_raw:
    for b in fleet_data:
        total_entries += 1
        rank = b[0]
        if etype == 'crew':
            races, gross, net = b[7], b[8], b[9]
        else:
            races, gross, net = b[5], b[6], b[7]
        clean_scores = [float(re.search(r'[\d.]+', str(r)).group(0)) for r in races]
        assert sum(clean_scores) == gross, f"{fn} Rank {rank} gross fail: {sum(clean_scores)} != {gross}"
        discard_scores = [float(re.search(r'[\d.]+', str(r)).group(0)) for r in races if '(' in str(r)]
        assert sum(discard_scores) == (gross - net), f"{fn} Rank {rank} discard fail: {sum(discard_scores)} != {gross - net}"

print(f"100% of all {total_entries} entries across all 6 India fleets mathematically verified!")

# -------------------------------------------------------------
# 5. RESOLVE PARTICIPANTS
# -------------------------------------------------------------
parsed_fleets = []
for fn, bclass, div, etype, min_p, max_p, fleet_data in all_fleets_raw:
    entries = []
    for b in fleet_data:
        rank = b[0]
        sail_no = b[1]
        club = b[2]
        if etype == 'crew':
            h_name, h_g = b[3], b[4]
            c_name, c_g = b[5], b[6]
            races, gross, net = b[7], b[8], b[9]
            h_id, h_disp, _ = get_or_create_sailor(h_name, club, sail_no, h_g)
            c_id, c_disp, _ = get_or_create_sailor(c_name, club, sail_no, c_g)
            participants = [
                {'sailor_id': h_id, 'name': h_disp, 'role': 'helm', 'order': 1},
                {'sailor_id': c_id, 'name': c_disp, 'role': 'crew', 'order': 2},
            ]
            primary_sid = h_id
            label = f"{h_disp} & {c_disp}"
        else:
            name, g = b[3], b[4]
            races, gross, net = b[5], b[6], b[7]
            s_id, s_disp, _ = get_or_create_sailor(name, club, sail_no, g)
            participants = [
                {'sailor_id': s_id, 'name': s_disp, 'role': 'solo', 'order': 1}
            ]
            primary_sid = s_id
            label = s_disp

        entries.append({
            'rank': rank,
            'sail_no': sail_no,
            'club': club,
            'label': label,
            'primary_sid': primary_sid,
            'participants': participants,
            'races': races,
            'gross': gross,
            'net': net
        })
    parsed_fleets.append({
        'fleet_id': fn,
        'boat_class': bclass,
        'division': div,
        'entry_type': etype,
        'min_p': min_p,
        'max_p': max_p,
        'expected': len(fleet_data),
        'entries': entries
    })

print(f"Sailor identity resolution complete: matched {matched_count} existing entries, created {created_count} distinct new profiles.")

# -------------------------------------------------------------
# 6. SQL GENERATION
# -------------------------------------------------------------
EVENT_ID = '93e96191-c247-5264-9b88-1d21dc4b61ef'

sql_lines = [
    "-- Migration 177: Import YAI Junior National Sailing Championship 2023",
    "--",
    "-- Imports the official national championship results for:",
    "-- Event: YAI Junior National Sailing Championship 2023",
    "-- Venue: Colaba, Mumbai, India",
    "-- Dates: 06 – 12 October 2023",
    "-- Authority: Yachting Association of India (YAI)",
    f"-- Scope: 6 Fleets ({total_entries} total entries across 29er, 420, ILCA 4, ILCA 6, Optimist), 10 races, 1 discard",
    "--",
    "-- Source: https://www.yai.org.in / Official PDF: youth_nationals_2023.pdf",
    "-- Corroborated visually against official YAI PDF pages rendered to high-resolution PNG screenshots in scripts/imports/india-2023/screenshots/",
    "--",
    "-- All operations execute in a single atomic transaction.",
    "",
    "BEGIN;",
    "",
    "-- 1. Insert New Verified Sailor Profiles"
]

for s in new_sailor_map.values():
    clean_name = s['name'].replace("'", "''")
    clean_club = s['club'].replace("'", "''")
    clean_sn = s['sail_number'].replace("'", "''")
    sql_lines.append(f"""INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '{s['id']}', '{clean_name}', '{s['handle']}', '{clean_sn}', '{clean_club}', 'IND', '{s['gender']}', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);""")

sql_lines.extend([
    "",
    "-- 2. Create Parent Regatta Event",
    f"""INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer,
    classes, nor_url, created_at, updated_at
) VALUES (
    '{EVENT_ID}',
    'YAI Junior National Sailing Championship 2023',
    'yai-junior-national-championship-2023',
    '2023-10-06',
    '2023-10-12',
    'Colaba, Mumbai, India',
    'Yachting Association of India (YAI)',
    '["29er", "420", "ILCA 4", "ILCA 6", "optimist"]'::jsonb,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    updated_at = clock_timestamp();""",
    ""
])

# 3. Create Fleets & Results
for f in parsed_fleets:
    fid = f['fleet_id']
    bclass = f['boat_class']
    division = f['division']
    regatta_uuid = make_uuid(f"regatta:india-2023:{fid}")
    sheet_slug = make_handle(f"yai-junior-national-championship-2023-{fid}")
    sheet_name = f"YAI Junior National Sailing Championship 2023 — {fid}"
    clean_sheet_name = sheet_name.replace("'", "''")

    sql_lines.extend([
        f"-- Sheet: {sheet_name}",
        f"""INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '{regatta_uuid}',
    '{EVENT_ID}',
    '{clean_sheet_name}',
    '{sheet_slug}',
    '2023-10-12',
    '2023-10-12',
    {f['expected']},
    '{division}',
    10,
    'IND',
    '{bclass}',
    '{f['entry_type']}',
    {f['min_p']},
    {f['max_p']},
    false,
    'Colaba, Mumbai, India',
    'Yachting Association of India (YAI)',
    'published',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Official Results youth_nationals_2023.pdf',
    'YAI Junior National Sailing Championship 2023 at Colaba, Mumbai. 10 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();"""
    ])

    for entry in f['entries']:
        res_uuid = make_uuid(f"result:india-2023:{fid}:{entry['rank']}:{entry['sail_no']}")
        clean_label = entry['label'].replace("'", "''")
        clean_sn = entry['sail_no'].replace("'", "''")
        clean_club = entry['club'].replace("'", "''")

        if f['entry_type'] == 'crew':
            helm_info = f"Helm: {entry['participants'][0]['name']}"
            crew_info = f"Crew: {entry['participants'][1]['name']}"
            notes = f"YAI Junior Nationals 2023. {helm_info}, {crew_info}. Club: {clean_club}."
        else:
            solo_info = f"{entry['participants'][0]['name']}"
            notes = f"YAI Junior Nationals 2023. Sailor: {solo_info}. Club: {clean_club}."

        clean_notes = notes.replace("'", "''")

        sql_lines.append(f"""INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '{res_uuid}', '{entry['primary_sid']}', '{regatta_uuid}', '{clean_label}', '{clean_sn}', '{f['entry_type']}', {entry['rank']},
    {entry['gross']}, {entry['net']}, false, false,
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html',
    'YAI Junior Nationals 2023 Official Results PDF', 'document',
    '{clean_notes}', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;""")

        for p in entry['participants']:
            part_uuid = make_uuid(f"participant:india-2023:{res_uuid}:{p['sailor_id']}:{p['role']}")
            clean_sname = p['name'].replace("'", "''")
            sql_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '{part_uuid}', '{res_uuid}', '{p['sailor_id']}', '{clean_sname}', {p['order']}, '{p['role']}', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;""")

        for r_idx, sc_str in enumerate(entry['races'], 1):
            sc_m = re.search(r'([\d.]+)', str(sc_str))
            sc_val = float(sc_m.group(1)) if sc_m else 0.0
            is_disc = '(' in str(sc_str)
            code_m = re.search(r'[A-Z]{2,}', str(sc_str))
            sc_code = f"'{code_m.group(0)}'" if code_m else "NULL"
            clean_raw = str(sc_str).replace("'", "''")
            sql_lines.append(f"""INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '{res_uuid}', {r_idx}, {sc_val}, {sc_code}, {str(is_disc).lower()}, '{clean_raw}'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;""")

sql_lines.append("\nCOMMIT;")

migration_path = 'src/db/migrations/177_import_india_junior_nationals_2023.sql'
with open(migration_path, 'w', encoding='utf-8') as f:
    f.write('\n'.join(sql_lines) + '\n')

print(f"Generated {migration_path} ({len(sql_lines)} lines).")

# Evidence Manifest
evidence = {
    "regatta_name": "YAI Junior National Sailing Championship 2023",
    "sanctioning_authority": "Yachting Association of India (YAI)",
    "official_url": "https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html",
    "pdf_url": "https://www.yai.org.in/documents-and-rules/results-of-events/261-yai-youth-nationals-2023-results/file.html",
    "venue": "Colaba, Mumbai, India",
    "dates": "06 – 12 October 2023",
    "classes": [f['boat_class'] for f in parsed_fleets],
    "fleets_imported": [f['fleet_id'] for f in parsed_fleets],
    "total_entries": total_entries,
    "total_participants": sum(len(e['participants']) for f in parsed_fleets for e in f['entries']),
    "total_race_scores": sum(len(e['races']) for f in parsed_fleets for e in f['entries']),
    "mathematical_verification": "100% verified (sum(clean_scores) == gross and gross - discard == net)",
    "pdf_corroboration_status": "Verified against official YAI PDF pages rendered to high-resolution PNG screenshots in scripts/imports/india-2023/screenshots/."
}

evidence_path = 'scripts/imports/india-2023/evidence.json'
with open(evidence_path, 'w', encoding='utf-8') as f:
    json.dump(evidence, f, indent=2)

print(f"Saved evidence manifest {evidence_path}.")
