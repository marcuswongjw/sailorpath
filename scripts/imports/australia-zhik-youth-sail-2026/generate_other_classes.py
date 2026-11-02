import os
import re
import json
import uuid

BASE_DIR = 'scripts/imports/australia-zhik-youth-sail-2026'
NAMESPACE = uuid.UUID('6ba7b810-9dad-11d1-80b4-00c04fd430c8')

with open('scripts/imports/australia-optimist-2026/live-sailors.json') as f:
    existing_data = json.load(f)
existing_sailors = list(existing_data['rows'][0]['json_agg'])

# Include profiles created in Migration 158 and Migration 159
for prev_path in [
    'scripts/imports/australia-optimist-2026/extracted.json',
    'scripts/imports/australia-zhik-youth-sail-2026/extracted.json'
]:
    with open(prev_path) as f:
        prev_data = json.load(f)
    for np in prev_data.get('newProfiles', []):
        if np['id'] not in {s['id'] for s in existing_sailors}:
            existing_sailors.append({
                'id': np['id'],
                'name': np['name'],
                'handle': np['handle'],
                'sail_number': np.get('sailNumber') or '',
                'club': np.get('club') or 'Australia',
                'nationality': np.get('nationality') or 'AUS',
                'gender': np.get('gender'),
                'aliases': [np['name']]
            })

existing_handles = {s['handle'] for s in existing_sailors}
existing_ids = {s['id'] for s in existing_sailors}
existing_by_id = {s['id']: s for s in existing_sailors}

def norm_name(n):
    return re.sub(r'[^a-z0-9]', '', n.lower())

def clean_name(n):
    n = n.strip().replace('&nbsp;', ' ')
    n = re.sub(r'\s+', ' ', n)
    parts = n.split()
    cleaned = []
    for p in parts:
        if p.isupper() and len(p) > 1:
            cleaned.append(p.capitalize())
        else:
            cleaned.append(p)
    return ' '.join(cleaned)

def slugify(s):
    s = s.lower().strip()
    s = re.sub(r'[^a-z0-9]+', '-', s)
    return s.strip('-')

sailor_by_norm = {}
for s in existing_sailors:
    seen_norms = set()
    for candidate_name in [s['name']] + (s.get('aliases') or []):
        if candidate_name:
            norm = norm_name(candidate_name)
            if norm and norm not in seen_norms:
                seen_norms.add(norm)
                sailor_by_norm.setdefault(norm, []).append(s)

def parse_sailingresults_cell(val):
    val = val.strip().replace('&nbsp;', ' ')
    discarded = False
    code = None
    pts = None
    m_disc = re.search(r'\(([^)]+)\)', val)
    if m_disc:
        discarded = True
        inner = m_disc.group(1).strip()
        remainder = val.replace(f'({m_disc.group(1)})', '').strip()
        m_num = re.search(r'([0-9.]+)', inner)
        if m_num:
            pts = float(m_num.group(1))
        code_str = remainder + re.sub(r'[0-9.\s]', '', inner)
        if code_str:
            code = code_str.strip()
    else:
        m_num = re.match(r'^([0-9.]+)\s*([A-Z]*)$', val)
        if m_num:
            pts = float(m_num.group(1))
            code = m_num.group(2) if m_num.group(2) else None
        else:
            code = val
    return pts, code, discarded

TOPYACHT_CODE_MAP = {
    'F': 'DNF',
    'S': 'DNS',
    'C': 'DNC',
    'O': 'OCS',
    'U': 'UFD',
    'B': 'BFD',
    'Q': 'DSQ',
    'R': 'RET',
    'G': 'RDG',
    'Z': 'ZFP',
    'T': 'TLE',
    'N': 'DNE',
}

def parse_topyacht_cell(val):
    val = str(val).strip()
    discarded = False
    code = None
    pts = None
    if '[' in val and ']' in val:
        discarded = True
    clean_val = val.replace('[', '').replace(']', '').strip()
    m = re.match(r'^([0-9.]+)\s*([A-Za-z]*)$', clean_val)
    if m:
        pts = float(m.group(1))
        raw_code = m.group(2).upper() if m.group(2) else None
        if raw_code:
            code = TOPYACHT_CODE_MAP.get(raw_code, raw_code)
    else:
        code = clean_val
    raw_formatted = f"({pts:g}{(' ' + code) if code else ''})" if discarded and pts is not None else (f"{pts:g}{(' ' + code) if code else ''}" if pts is not None else val)
    return pts, code, discarded, raw_formatted

def parse_sportspage_cell(val):
    val = val.strip().replace('&nbsp;', ' ')
    discarded = False
    code = None
    pts = None
    m = re.match(r'^\[\s*([0-9.]+)\s*\]\s*\(\s*([^)]+)\s*\)$', val)
    if m:
        discarded = True
        pts = float(m.group(1))
        inner = m.group(2).strip()
        if not re.match(r'^[0-9.]+$', inner):
            code = inner
    else:
        m2 = re.match(r'^([0-9.]+)\s*\(\s*([^)]+)\s*\)$', val)
        if m2:
            pts = float(m2.group(1))
            inner = m2.group(2).strip()
            if not re.match(r'^[0-9.]+$', inner):
                code = inner
        else:
            m3 = re.search(r'([0-9.]+)', val)
            if m3:
                pts = float(m3.group(1))
    raw_formatted = f"({pts:g}{(' ' + code) if code else ''})" if discarded and pts is not None else (f"{pts:g}{(' ' + code) if code else ''}" if pts is not None else val)
    return pts, code, discarded, raw_formatted

created_profiles = {}
new_profiles_list = []

def resolve_sailor(name, club, sail_num, gender_hint, nat_hint='AUS', class_prefix='aus'):
    c_name = clean_name(name)
    norm = norm_name(c_name)
    candidates = sailor_by_norm.get(norm, [])
    matched = None
    if len(candidates) == 1:
        matched = candidates[0]
    elif len(candidates) > 1:
        for cand in candidates:
            if cand.get('nationality') == (nat_hint or 'AUS') or (club and cand.get('club') and (club in cand['club'] or cand['club'] in club)):
                matched = cand
                break
        if not matched:
            matched = candidates[0]

    if matched:
        return matched['id'], matched['name'], False, matched['handle']

    if norm in created_profiles:
        p = created_profiles[norm]
        return p['id'], p['name'], False, p['handle']

    actual_nat = nat_hint if nat_hint else 'AUS'
    if club and ('SAF' in club.upper() or 'CSC' in club.upper() or 'SGP' in club.upper()):
        actual_nat = 'SGP'

    p_id = str(uuid.uuid5(NAMESPACE, f"sailor:{actual_nat}:{norm}"))
    base_handle = f"{class_prefix}-{actual_nat.lower()}-{slugify(c_name)}-{slugify(sail_num or '0')[:12]}"
    handle = base_handle
    counter = 1
    while handle in existing_handles or handle in [p['handle'] for p in new_profiles_list]:
        handle = f"{base_handle}-{counter}"
        counter += 1

    gender = None
    if gender_hint:
        g_clean = gender_hint.upper().strip()
        if any(w in g_clean for w in ['GIRL', 'FEMALE', 'WOMEN']):
            gender = 'F'
        elif any(w in g_clean for w in ['BOY', 'MALE', 'MEN']):
            gender = 'M'
        elif g_clean in ('M', 'B'):
            gender = 'M'
        elif g_clean in ('F', 'G', 'W'):
            gender = 'F'

    new_p = {
        'id': p_id,
        'name': c_name,
        'handle': handle,
        'sailNumber': sail_num or '',
        'club': club or 'Australia',
        'nationality': actual_nat,
        'gender': gender
    }
    created_profiles[norm] = new_p
    new_profiles_list.append(new_p)
    return p_id, c_name, True, handle

# Official SA 420 Entry List mapping for crew & club where TopYacht omitted crew1/note
SA_420_ENTRY_MAP = {
    '55167': {'crew': 'William Gaylard', 'club': 'LBSC'},
    '56191': {'crew': 'Darcy Higgins', 'club': 'BSYC'},
    '55168': {'crew': 'Sam Smith', 'club': 'SYC'},
    '55159': {'crew': 'Sophie Prior', 'club': 'BSYC'},
    '56194': {'crew': 'Henry Zub', 'club': 'BSYC'},
    '51578': {'crew': 'Georgia Griffin', 'club': 'BSYC'},
    '51978': {'crew': 'Adele Prior', 'club': 'BSYC'},
    '55158': {'crew': 'Jake Whitton', 'club': 'BSYC'},
    '54203': {'crew': 'Harvey Gill', 'club': 'BSYC'},
}

events_manifest = [
    {
        "id": str(uuid.uuid5(NAMESPACE, "event:2026-zhik-youth-sail-tas")),
        "slug": "2026-zhik-youth-sail-tas",
        "name": "2026 Zhik Youth Sail Tasmania (Tasmanian Youth Championships)",
        "startDate": "2026-03-07",
        "endDate": "2026-03-09",
        "venue": "Royal Yacht Club of Tasmania, Hobart, TAS, Australia",
        "organizer": "Australian Sailing / Royal Yacht Club of Tasmania (RYCT)",
        "classes": ["Optimist", "ILCA 4", "ILCA 6", "ILCA 7", "29er"],
        "scheduleSummary": "Zhik Youth Sail TAS coaching clinic and Tasmanian Youth Championship regatta held 7–9 March 2026 at Royal Yacht Club of Tasmania.",
        "scoringRules": "Low Point System with 1 discard.",
        "officialSource": {
            "url": "https://sailingresults.net/?ID=82311",
            "title": "2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)"
        },
        "sheets": [
            {
                "file": "tas-ilca4.html",
                "format": "sailingresults",
                "is_crew": False,
                "race_start": 5, "race_end": 11, "tot_idx": 11, "net_idx": 12, "gender_idx": 13,
                "nat_idx": None, "club_idx": 4, "sail_idx": 2, "name_idx": 1, "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82311.3",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-tas-ilca-4")),
                "slug": "2026-zhik-youth-sail-tas-ilca-4",
                "name": "2026 Zhik Youth Sail Tasmania — ILCA 4",
                "boatClass": "ILCA 4",
                "division": "Open",
                "raceCount": 6, "totalFleetSize": 14, "discardCount": 1
            },
            {
                "file": "tas-ilca6.html",
                "format": "sailingresults",
                "is_crew": False,
                "race_start": 5, "race_end": 11, "tot_idx": 11, "net_idx": 12, "gender_idx": 13,
                "nat_idx": None, "club_idx": 4, "sail_idx": 2, "name_idx": 1, "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82311.4",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-tas-ilca-6")),
                "slug": "2026-zhik-youth-sail-tas-ilca-6",
                "name": "2026 Zhik Youth Sail Tasmania — ILCA 6",
                "boatClass": "ILCA 6",
                "division": "Open",
                "raceCount": 6, "totalFleetSize": 10, "discardCount": 1
            },
            {
                "file": "tas-ilca7.html",
                "format": "sailingresults",
                "is_crew": False,
                "race_start": 5, "race_end": 11, "tot_idx": 11, "net_idx": 12, "gender_idx": 13,
                "nat_idx": None, "club_idx": 4, "sail_idx": 2, "name_idx": 1, "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82311.12",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-tas-ilca-7")),
                "slug": "2026-zhik-youth-sail-tas-ilca-7",
                "name": "2026 Zhik Youth Sail Tasmania — ILCA 7",
                "boatClass": "ILCA 7",
                "division": "Open",
                "raceCount": 6, "totalFleetSize": 3, "discardCount": 1
            },
            {
                "file": "tas-29er.html",
                "format": "sailingresults",
                "is_crew": True,
                "race_start": 5, "race_end": 11, "tot_idx": 11, "net_idx": 12, "gender_idx": 13,
                "nat_idx": None, "club_idx": 4, "sail_idx": 2, "name_idx": 1, "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82311.5",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-tas-29er")),
                "slug": "2026-zhik-youth-sail-tas-29er",
                "name": "2026 Zhik Youth Sail Tasmania — 29er",
                "boatClass": "29er",
                "division": "Open",
                "raceCount": 6, "totalFleetSize": 6, "discardCount": 1
            }
        ]
    },
    {
        "id": str(uuid.uuid5(NAMESPACE, "event:2026-zhik-youth-sail-nt")),
        "slug": "2026-zhik-youth-sail-nt",
        "name": "2026 Zhik Youth Sail Northern Territory (NT Youth Championships)",
        "startDate": "2026-07-06",
        "endDate": "2026-07-10",
        "venue": "Darwin Sailing Club, Fannie Bay, Darwin, NT, Australia",
        "organizer": "Australian Sailing / Darwin Sailing Club (DSC)",
        "classes": ["ILCA 4", "ILCA 6"],
        "scheduleSummary": "Zhik Youth Sail NT coaching clinic and NT Youth Championship regatta held 6–10 July 2026 at Darwin Sailing Club.",
        "scoringRules": "Low Point System with 1 discard across 6 completed races.",
        "officialSource": {
            "url": "https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s",
            "title": "2026 Youth Sail NT Official Results (SailSys Series 5537)"
        },
        "sheets": [
            {
                "file": "nt-sailsys-5537.json",
                "format": "sailsys",
                "div_name": "ILCA 4",
                "is_crew": False,
                "sourceUrl": "https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-nt-ilca-4")),
                "slug": "2026-zhik-youth-sail-nt-ilca-4",
                "name": "2026 Zhik Youth Sail Northern Territory — ILCA 4",
                "boatClass": "ILCA 4",
                "division": "Open",
                "raceCount": 6, "totalFleetSize": 3, "discardCount": 1
            },
            {
                "file": "nt-sailsys-5537.json",
                "format": "sailsys",
                "div_name": "ILCA 6",
                "is_crew": False,
                "sourceUrl": "https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-nt-ilca-6")),
                "slug": "2026-zhik-youth-sail-nt-ilca-6",
                "name": "2026 Zhik Youth Sail Northern Territory — ILCA 6",
                "boatClass": "ILCA 6",
                "division": "Open",
                "raceCount": 6, "totalFleetSize": 8, "discardCount": 1
            }
        ]
    },
    {
        "id": str(uuid.uuid5(NAMESPACE, "event:2026-zhik-youth-sail-qld")),
        "slug": "2026-zhik-youth-sail-qld",
        "name": "2026 Zhik Youth Sail Queensland (Queensland Youth Championships)",
        "startDate": "2026-09-21",
        "endDate": "2026-09-26",
        "venue": "Keppel Bay Sailing Club, Yeppoon, QLD, Australia",
        "organizer": "Australian Sailing / Keppel Bay Sailing Club (KBSC)",
        "classes": ["Optimist", "ILCA 4", "ILCA 6", "29er", "Techno 293", "iQFOiL"],
        "scheduleSummary": "Zhik Youth Sail QLD coaching clinic (21–23 Sept) and Queensland Youth Championships (24–26 Sept 2026) at Keppel Bay Sailing Club.",
        "scoringRules": "Low Point System.",
        "officialSource": {
            "url": "https://topyacht.net/publicresults/IndexResults?clubId=1352&eventId=407",
            "title": "2026 Zhik Youth Sail QLD Official Results (TopYacht)"
        },
        "sheets": [
            {
                "file": "qld-ilca4.json",
                "format": "topyacht",
                "is_crew": False,
                "race_keys": ["R1", "R2", "R3", "R4", "R5", "R6", "R7"],
                "sourceUrl": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1225",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-qld-ilca-4")),
                "slug": "2026-zhik-youth-sail-qld-ilca-4",
                "name": "2026 Zhik Youth Sail Queensland — ILCA 4",
                "boatClass": "ILCA 4",
                "division": "Open",
                "raceCount": 7, "totalFleetSize": 36, "discardCount": 1
            },
            {
                "file": "qld-ilca6.json",
                "format": "topyacht",
                "is_crew": False,
                "race_keys": ["R1", "R2"],
                "sourceUrl": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1225",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-qld-ilca-6")),
                "slug": "2026-zhik-youth-sail-qld-ilca-6",
                "name": "2026 Zhik Youth Sail Queensland — ILCA 6",
                "boatClass": "ILCA 6",
                "division": "Open",
                "raceCount": 2, "totalFleetSize": 18, "discardCount": 0
            },
            {
                "file": "qld-techno293.json",
                "format": "topyacht",
                "is_crew": False,
                "race_keys": ["R1", "R2", "R3", "R4"],
                "sourceUrl": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1245",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-qld-techno-293")),
                "slug": "2026-zhik-youth-sail-qld-techno-293",
                "name": "2026 Zhik Youth Sail Queensland — Techno 293",
                "boatClass": "Techno 293",
                "division": "Open",
                "raceCount": 4, "totalFleetSize": 2, "discardCount": 1
            },
            {
                "file": "qld-iqfoil.json",
                "format": "topyacht",
                "is_crew": False,
                "race_keys": ["R1", "R2", "R3", "R4", "R5", "R6", "R7", "R8", "R9", "R10", "R11", "R12"],
                "sourceUrl": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1226",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-qld-iqfoil")),
                "slug": "2026-zhik-youth-sail-qld-iqfoil",
                "name": "2026 Zhik Youth Sail Queensland — iQFOiL",
                "boatClass": "iQFOiL",
                "division": "Open",
                "raceCount": 12, "totalFleetSize": 3, "discardCount": 3
            },
            {
                "file": "qld-29er.json",
                "format": "topyacht",
                "is_crew": True,
                "race_keys": ["R1", "R2", "R3", "R4", "R5", "R6", "R7"],
                "sourceUrl": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1227",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-qld-29er")),
                "slug": "2026-zhik-youth-sail-qld-29er",
                "name": "2026 Zhik Youth Sail Queensland — 29er",
                "boatClass": "29er",
                "division": "Open",
                "raceCount": 7, "totalFleetSize": 9, "discardCount": 1
            }
        ]
    },
    {
        "id": str(uuid.uuid5(NAMESPACE, "event:2026-zhik-youth-sail-sa")),
        "slug": "2026-zhik-youth-sail-sa",
        "name": "2026 Zhik Youth Sail South Australia (SA Youth Championships)",
        "startDate": "2026-09-26",
        "endDate": "2026-09-29",
        "venue": "Brighton & Seacliff Yacht Club, Adelaide, SA, Australia",
        "organizer": "Australian Sailing / Brighton & Seacliff Yacht Club (BSYC)",
        "classes": ["Optimist", "ILCA 4", "ILCA 6", "420"],
        "scheduleSummary": "Zhik Youth Sail SA coaching clinic and South Australian Youth Championships held 26–29 September 2026 at Brighton & Seacliff Yacht Club.",
        "scoringRules": "Low Point System with 1 discard.",
        "officialSource": {
            "url": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1175",
            "title": "2026 SA Youth Championships Official Results (TopYacht)"
        },
        "sheets": [
            {
                "file": "sa-ilca4.json",
                "format": "topyacht",
                "is_crew": False,
                "race_keys": ["R1", "R2", "R3", "R4", "R5", "R6"],
                "sourceUrl": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1175",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-sa-ilca-4")),
                "slug": "2026-zhik-youth-sail-sa-ilca-4",
                "name": "2026 Zhik Youth Sail South Australia — ILCA 4",
                "boatClass": "ILCA 4",
                "division": "Open",
                "raceCount": 6, "totalFleetSize": 3, "discardCount": 1
            },
            {
                "file": "sa-ilca6.json",
                "format": "topyacht",
                "is_crew": False,
                "race_keys": ["R1", "R2", "R3", "R4", "R5", "R6"],
                "sourceUrl": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1175",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-sa-ilca-6")),
                "slug": "2026-zhik-youth-sail-sa-ilca-6",
                "name": "2026 Zhik Youth Sail South Australia — ILCA 6",
                "boatClass": "ILCA 6",
                "division": "Open",
                "raceCount": 6, "totalFleetSize": 10, "discardCount": 1
            },
            {
                "file": "sa-420.json",
                "format": "topyacht",
                "is_crew": True,
                "race_keys": ["R1", "R2", "R3", "R4", "R5", "R6"],
                "sourceUrl": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1175",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-sa-420")),
                "slug": "2026-zhik-youth-sail-sa-420",
                "name": "2026 Zhik Youth Sail South Australia — 420",
                "boatClass": "420",
                "division": "Open",
                "raceCount": 6, "totalFleetSize": 9, "discardCount": 1
            }
        ]
    },
    {
        "id": str(uuid.uuid5(NAMESPACE, "event:2026-zhik-youth-sail-wa")),
        "slug": "2026-zhik-youth-sail-wa",
        "name": "2026 Zhik Youth Sail Western Australia (WA Youth Championships)",
        "startDate": "2026-09-26",
        "endDate": "2026-10-01",
        "venue": "Royal Freshwater Bay Yacht Club / Nedlands Yacht Club, Perth, WA, Australia",
        "organizer": "Australian Sailing / Royal Freshwater Bay Yacht Club (RFBYC) & Nedlands Yacht Club",
        "classes": ["Optimist", "ILCA 4", "ILCA 6", "ILCA 7", "29er", "420", "iQFOiL"],
        "scheduleSummary": "Zhik Youth Sail WA coaching clinic and 2026 Zhik WA Youth Championships held 26 September – 1 October 2026 on the Swan River, Perth.",
        "scoringRules": "Low Point System with 1 discard across 9 races.",
        "officialSource": {
            "url": "https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/progresultspage.htm",
            "title": "2026 Zhik WA Youth Championships Official Results (Sportspage)"
        },
        "sheets": [
            {
                "file": "wa-ilca4_championship.htm",
                "format": "sportspage",
                "is_crew": False,
                "sourceUrl": "https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-wa-ilca-4")),
                "slug": "2026-zhik-youth-sail-wa-ilca-4",
                "name": "2026 Zhik Youth Sail Western Australia — ILCA 4",
                "boatClass": "ILCA 4",
                "division": "Open",
                "raceCount": 9, "totalFleetSize": 23, "discardCount": 1
            },
            {
                "file": "wa-ilca6_championship.htm",
                "format": "sportspage",
                "is_crew": False,
                "sourceUrl": "https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-wa-ilca-6")),
                "slug": "2026-zhik-youth-sail-wa-ilca-6",
                "name": "2026 Zhik Youth Sail Western Australia — ILCA 6",
                "boatClass": "ILCA 6",
                "division": "Open",
                "raceCount": 9, "totalFleetSize": 8, "discardCount": 1
            },
            {
                "file": "wa-ilca7_championship.htm",
                "format": "sportspage",
                "is_crew": False,
                "sourceUrl": "https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA7_Championship.htm",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-wa-ilca-7")),
                "slug": "2026-zhik-youth-sail-wa-ilca-7",
                "name": "2026 Zhik Youth Sail Western Australia — ILCA 7",
                "boatClass": "ILCA 7",
                "division": "Open",
                "raceCount": 9, "totalFleetSize": 3, "discardCount": 1
            },
            {
                "file": "wa-iq_foil_combined_fleet_championship.htm",
                "format": "sportspage",
                "is_crew": False,
                "reorder_indices": [0, 1, 2, 3, 7, 8, 4, 5, 6],
                "sourceUrl": "https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-wa-iqfoil")),
                "slug": "2026-zhik-youth-sail-wa-iqfoil",
                "name": "2026 Zhik Youth Sail Western Australia — iQFOiL",
                "boatClass": "iQFOiL",
                "division": "Open",
                "raceCount": 9, "totalFleetSize": 6, "discardCount": 1
            },
            {
                "file": "wa-29er_championship.htm",
                "format": "sportspage",
                "is_crew": True,
                "sourceUrl": "https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-wa-29er")),
                "slug": "2026-zhik-youth-sail-wa-29er",
                "name": "2026 Zhik Youth Sail Western Australia — 29er",
                "boatClass": "29er",
                "division": "Open",
                "raceCount": 9, "totalFleetSize": 6, "discardCount": 1
            },
            {
                "file": "wa-420_championship.htm",
                "format": "sportspage",
                "is_crew": True,
                "sourceUrl": "https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/420_Championship.htm",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-wa-420")),
                "slug": "2026-zhik-youth-sail-wa-420",
                "name": "2026 Zhik Youth Sail Western Australia — 420",
                "boatClass": "420",
                "division": "Open",
                "raceCount": 9, "totalFleetSize": 1, "discardCount": 1
            }
        ]
    },
    {
        "id": str(uuid.uuid5(NAMESPACE, "event:2026-zhik-youth-sail-nsw")),
        "slug": "2026-zhik-youth-sail-nsw",
        "name": "2026 Zhik Youth Sail New South Wales (NSW Youth Championships)",
        "startDate": "2026-09-30",
        "endDate": "2026-10-05",
        "venue": "Toronto Amateur Sailing Club, Lake Macquarie, NSW, Australia",
        "organizer": "Australian Sailing / Toronto Amateur Sailing Club (TASC)",
        "classes": ["Optimist", "ILCA 4", "ILCA 6", "29er", "420"],
        "scheduleSummary": "Zhik Youth Sail NSW coaching clinic (30 Sept – 2 Oct) and NSW Youth Championships (3–5 Oct 2026) at Toronto Amateur Sailing Club, Lake Macquarie.",
        "scoringRules": "Low Point System with 1 discard.",
        "officialSource": {
            "url": "https://sailingresults.net/?ID=82460",
            "title": "2026 Zhik NSW Youth Championships Official Results (SailingResults.net)"
        },
        "sheets": [
            {
                "file": "nsw-ilca4.html",
                "format": "sailingresults",
                "is_crew": False,
                "race_start": 6, "race_end": 15, "tot_idx": 15, "net_idx": 16, "gender_idx": 17,
                "nat_idx": 3, "club_idx": 5, "sail_idx": 2, "name_idx": 1, "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82460.4",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-nsw-ilca-4")),
                "slug": "2026-zhik-youth-sail-nsw-ilca-4",
                "name": "2026 Zhik Youth Sail New South Wales — ILCA 4",
                "boatClass": "ILCA 4",
                "division": "Open",
                "raceCount": 9, "totalFleetSize": 37, "discardCount": 1
            },
            {
                "file": "nsw-ilca6.html",
                "format": "sailingresults",
                "is_crew": False,
                "race_start": 6, "race_end": 15, "tot_idx": 15, "net_idx": 16, "gender_idx": 17,
                "nat_idx": 3, "club_idx": 5, "sail_idx": 2, "name_idx": 1, "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82460.5",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-nsw-ilca-6")),
                "slug": "2026-zhik-youth-sail-nsw-ilca-6",
                "name": "2026 Zhik Youth Sail New South Wales — ILCA 6",
                "boatClass": "ILCA 6",
                "division": "Open",
                "raceCount": 9, "totalFleetSize": 12, "discardCount": 1
            },
            {
                "file": "nsw-29er.html",
                "format": "sailingresults",
                "is_crew": True,
                "race_start": 6, "race_end": 15, "tot_idx": 15, "net_idx": 16, "gender_idx": 17,
                "nat_idx": 3, "club_idx": 5, "sail_idx": 2, "name_idx": 1, "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82460.6",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-nsw-29er")),
                "slug": "2026-zhik-youth-sail-nsw-29er",
                "name": "2026 Zhik Youth Sail New South Wales — 29er",
                "boatClass": "29er",
                "division": "Open",
                "raceCount": 9, "totalFleetSize": 15, "discardCount": 1
            },
            {
                "file": "nsw-420.html",
                "format": "sailingresults",
                "is_crew": True,
                "race_start": 6, "race_end": 15, "tot_idx": 15, "net_idx": 16, "gender_idx": 17,
                "nat_idx": 3, "club_idx": 5, "sail_idx": 2, "name_idx": 1, "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82460.7",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-nsw-420")),
                "slug": "2026-zhik-youth-sail-nsw-420",
                "name": "2026 Zhik Youth Sail New South Wales — 420",
                "boatClass": "420",
                "division": "Open",
                "raceCount": 9, "totalFleetSize": 4, "discardCount": 1
            }
        ]
    },
    {
        "id": "75b647f0-1339-5bf4-9d42-9ba9a5257cb7",
        "slug": "2026-act-optimist-championship",
        "name": "2026 Zhik Youth Sail ACT (ACT Youth Championships)",
        "startDate": "2026-10-24",
        "endDate": "2026-10-25",
        "venue": "Canberra Yacht Club, Lake Burley Griffin, ACT, Australia",
        "organizer": "Australian Sailing / Canberra Yacht Club (CYC)",
        "classes": ["Optimist", "ILCA 4", "ILCA 6"],
        "scheduleSummary": "Zhik Youth Sail ACT coaching clinic and ACT Youth Championships held 24–25 October 2026 at Canberra Yacht Club.",
        "scoringRules": "Low Point System with 1 discard across 8 races.",
        "officialSource": {
            "url": "https://sailingresults.net/?ID=82464",
            "title": "2026 Zhik ACT Youth Championships Official Results (SailingResults.net)"
        },
        "sheets": [
            {
                "file": "act-ilca4.html",
                "format": "sailingresults",
                "is_crew": False,
                "race_start": 6, "race_end": 14, "tot_idx": 14, "net_idx": 15, "gender_idx": 16,
                "nat_idx": 3, "club_idx": 5, "sail_idx": 2, "name_idx": 1, "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82464.3",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-act-ilca-4")),
                "slug": "2026-zhik-youth-sail-act-ilca-4",
                "name": "2026 Zhik Youth Sail ACT — ILCA 4",
                "boatClass": "ILCA 4",
                "division": "Open",
                "raceCount": 8, "totalFleetSize": 14, "discardCount": 1
            },
            {
                "file": "act-ilca6.html",
                "format": "sailingresults",
                "is_crew": False,
                "race_start": 6, "race_end": 14, "tot_idx": 14, "net_idx": 15, "gender_idx": 16,
                "nat_idx": 3, "club_idx": 5, "sail_idx": 2, "name_idx": 1, "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82464.4",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-act-ilca-6")),
                "slug": "2026-zhik-youth-sail-act-ilca-6",
                "name": "2026 Zhik Youth Sail ACT — ILCA 6",
                "boatClass": "ILCA 6",
                "division": "Open",
                "raceCount": 8, "totalFleetSize": 2, "discardCount": 1
            }
        ]
    }
]

extracted_all = []
discrepancies = []

for ev in events_manifest:
    for sh in ev['sheets']:
        filepath = os.path.join(BASE_DIR, sh['file'])
        sheet_results = []
        class_prefix = slugify(sh['boatClass'])

        if sh['format'] == 'sailingresults':
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                html = f.read()
            rows = re.findall(r'<tr[^>]*>(.*?)</tr>', html, re.S)
            for idx, r in enumerate(rows[1:], 1):
                raw_cells = re.findall(r'<t[dh][^>]*>(.*?)</t[dh]>', r, re.S)
                cols = [re.sub(r'<[^>]+>', '', c).strip().replace('&nbsp;', ' ') for c in raw_cells]
                if cols and cols[sh['rank_idx']].isdigit():
                    rank = int(cols[sh['rank_idx']])
                    sail_num = cols[sh['sail_idx']]
                    club = cols[sh['club_idx']] if sh['club_idx'] is not None else 'Australia'
                    nat_hint = cols[sh['nat_idx']].strip() if sh.get('nat_idx') is not None and cols[sh['nat_idx']].strip() else 'AUS'
                    gender_hint = cols[sh['gender_idx']] if sh['gender_idx'] is not None and sh['gender_idx'] < len(cols) else None
                    tot = float(cols[sh['tot_idx']])
                    net = float(cols[sh['net_idx']])
                    races_raw = cols[sh['race_start']:sh['race_end']]

                    races = []
                    calc_tot = 0.0
                    calc_net = 0.0
                    for r_num, val in enumerate(races_raw, 1):
                        pts, code, discarded = parse_sailingresults_cell(val)
                        if pts is not None:
                            calc_tot += pts
                            if not discarded:
                                calc_net += pts
                        races.append({
                            'raceNumber': r_num,
                            'score': pts,
                            'code': code,
                            'discarded': discarded,
                            'raw': val
                        })

                    if abs(calc_tot - tot) > 0.01 or abs(calc_net - net) > 0.01:
                        discrepancies.append((sh['name'], rank, cols[sh['name_idx']], tot, calc_tot, net, calc_net))

                    if sh['is_crew']:
                        name_parts = [clean_name(re.sub(r'<[^>]+>', '', p)) for p in re.split(r'<br\s*/?>', raw_cells[sh['name_idx']], flags=re.I) if clean_name(re.sub(r'<[^>]+>', '', p))]
                        participants = []
                        for p_order, p_name in enumerate(name_parts, 1):
                            sid, prof_name, is_new, hdl = resolve_sailor(p_name, club, sail_num, gender_hint, nat_hint, class_prefix)
                            participants.append({
                                'sailorId': sid,
                                'profileName': prof_name,
                                'sourceName': p_name,
                                'displayOrder': p_order,
                                'role': 'helm' if p_order == 1 else 'crew'
                            })
                        entry_label = ' / '.join(p['profileName'] for p in participants)
                        primary_sid = participants[0]['sailorId']
                    else:
                        name = clean_name(cols[sh['name_idx']])
                        sid, prof_name, is_new, hdl = resolve_sailor(name, club, sail_num, gender_hint, nat_hint, class_prefix)
                        participants = [{
                            'sailorId': sid,
                            'profileName': prof_name,
                            'sourceName': name,
                            'displayOrder': 1,
                            'role': 'solo'
                        }]
                        entry_label = prof_name
                        primary_sid = sid

                    res_id = str(uuid.uuid5(NAMESPACE, f"result:{sh['id']}:{idx}:{norm_name(entry_label)}"))
                    for p in participants:
                        p['participantId'] = str(uuid.uuid5(NAMESPACE, f"participant:{res_id}:{p['displayOrder']}:{p['sailorId']}"))

                    sheet_results.append({
                        'rank': rank,
                        'entryLabel': entry_label,
                        'entryType': 'crew' if sh['is_crew'] else 'individual',
                        'sailOrBoardNumber': sail_num,
                        'club': club,
                        'grossScore': tot,
                        'nettScore': net,
                        'races': races,
                        'sailorId': primary_sid,
                        'resultId': res_id,
                        'participants': participants
                    })

        elif sh['format'] == 'topyacht':
            with open(filepath, 'r', encoding='utf-8') as f:
                ty_data = json.load(f)['data']['resultGroupeds'][0]['results']
            for idx, r in enumerate(ty_data, 1):
                rank = int(r['place'])
                sail_num = str(r.get('sailnum') or '').strip()
                club = str(r.get('note') or '').strip()
                if sh['slug'] == '2026-zhik-youth-sail-sa-420' and sail_num in SA_420_ENTRY_MAP:
                    if not club:
                        club = SA_420_ENTRY_MAP[sail_num]['club']
                if not club:
                    club = 'Australia'
                net = float(r['score'])
                races = []
                calc_tot = 0.0
                calc_net = 0.0
                for r_num, rk in enumerate(sh['race_keys'], 1):
                    val = r.get(rk, '')
                    pts, code, discarded, raw_fmt = parse_topyacht_cell(val)
                    if pts is not None:
                        calc_tot += pts
                        if not discarded:
                            calc_net += pts
                    races.append({
                        'raceNumber': r_num,
                        'score': pts,
                        'code': code,
                        'discarded': discarded,
                        'raw': raw_fmt
                    })
                tot = round(calc_tot, 2)
                if abs(calc_net - net) > 0.01:
                    discrepancies.append((sh['name'], rank, r['skipper'], tot, calc_tot, net, calc_net))

                if sh['is_crew']:
                    helm_name = clean_name(r['skipper'])
                    crew_raw = (str(r.get('crew1') or '').strip() + ' ' + str(r.get('crew2') or '').strip()).strip()
                    if not crew_raw and sh['slug'] == '2026-zhik-youth-sail-sa-420' and sail_num in SA_420_ENTRY_MAP:
                        crew_raw = SA_420_ENTRY_MAP[sail_num]['crew']
                    name_parts = [helm_name] + ([clean_name(crew_raw)] if crew_raw else [])
                    participants = []
                    for p_order, p_name in enumerate(name_parts, 1):
                        sid, prof_name, is_new, hdl = resolve_sailor(p_name, club, sail_num, None, 'AUS', class_prefix)
                        participants.append({
                            'sailorId': sid,
                            'profileName': prof_name,
                            'sourceName': p_name,
                            'displayOrder': p_order,
                            'role': 'helm' if p_order == 1 else 'crew'
                        })
                    entry_label = ' / '.join(p['profileName'] for p in participants)
                    primary_sid = participants[0]['sailorId']
                else:
                    name = clean_name(r['skipper'])
                    sid, prof_name, is_new, hdl = resolve_sailor(name, club, sail_num, None, 'AUS', class_prefix)
                    participants = [{
                        'sailorId': sid,
                        'profileName': prof_name,
                        'sourceName': name,
                        'displayOrder': 1,
                        'role': 'solo'
                    }]
                    entry_label = prof_name
                    primary_sid = sid

                res_id = str(uuid.uuid5(NAMESPACE, f"result:{sh['id']}:{idx}:{norm_name(entry_label)}"))
                for p in participants:
                    p['participantId'] = str(uuid.uuid5(NAMESPACE, f"participant:{res_id}:{p['displayOrder']}:{p['sailorId']}"))

                sheet_results.append({
                    'rank': rank,
                    'entryLabel': entry_label,
                    'entryType': 'crew' if sh['is_crew'] else 'individual',
                    'sailOrBoardNumber': sail_num,
                    'club': club,
                    'grossScore': tot,
                    'nettScore': net,
                    'races': races,
                    'sailorId': primary_sid,
                    'resultId': res_id,
                    'participants': participants
                })

        elif sh['format'] == 'sportspage':
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                html = f.read()
            rows = re.findall(r'<TR[^>]*>(.*?)</TR>', html, re.S | re.I)
            idx = 0
            for r in rows:
                cols = [re.sub(r'<[^>]+>', '', c).strip().replace('&nbsp;', ' ') for c in re.findall(r'<T[DH][^>]*>(.*?)</T[DH]>', r, re.S | re.I)]
                if len(cols) >= 7 and cols[0].isdigit():
                    idx += 1
                    rank = int(cols[0])
                    sail_num = cols[1].strip()
                    skipper_club = cols[3].strip()
                    m_sc = re.match(r'^(.*?)\(([^)]+)\)$', skipper_club)
                    if m_sc:
                        names_str = m_sc.group(1).strip()
                        club = m_sc.group(2).strip()
                    else:
                        names_str = skipper_club
                        club = 'WA'
                    tot = float(cols[4])
                    net = float(cols[5])
                    races_raw = cols[6:]
                    if sh.get('reorder_indices'):
                        races_raw = [races_raw[i] for i in sh['reorder_indices']]

                    races = []
                    calc_tot = 0.0
                    calc_net = 0.0
                    for r_num, val in enumerate(races_raw, 1):
                        pts, code, discarded, raw_fmt = parse_sportspage_cell(val)
                        if pts is not None:
                            calc_tot += pts
                            if not discarded:
                                calc_net += pts
                        races.append({
                            'raceNumber': r_num,
                            'score': pts,
                            'code': code,
                            'discarded': discarded,
                            'raw': raw_fmt
                        })

                    if abs(calc_tot - tot) > 0.01 or abs(calc_net - net) > 0.01:
                        discrepancies.append((sh['name'], rank, names_str, tot, calc_tot, net, calc_net))

                    if sh['is_crew']:
                        parts = [clean_name(x) for x in names_str.split('-') if clean_name(x) and clean_name(x).upper() != 'TBA']
                        participants = []
                        for p_order, p_name in enumerate(parts, 1):
                            sid, prof_name, is_new, hdl = resolve_sailor(p_name, club, sail_num, None, 'AUS', class_prefix)
                            participants.append({
                                'sailorId': sid,
                                'profileName': prof_name,
                                'sourceName': p_name,
                                'displayOrder': p_order,
                                'role': 'helm' if p_order == 1 else 'crew'
                            })
                        entry_label = ' / '.join(p['profileName'] for p in participants)
                        primary_sid = participants[0]['sailorId']
                    else:
                        name = clean_name(names_str)
                        sid, prof_name, is_new, hdl = resolve_sailor(name, club, sail_num, None, 'AUS', class_prefix)
                        participants = [{
                            'sailorId': sid,
                            'profileName': prof_name,
                            'sourceName': name,
                            'displayOrder': 1,
                            'role': 'solo'
                        }]
                        entry_label = prof_name
                        primary_sid = sid

                    res_id = str(uuid.uuid5(NAMESPACE, f"result:{sh['id']}:{idx}:{norm_name(entry_label)}"))
                    for p in participants:
                        p['participantId'] = str(uuid.uuid5(NAMESPACE, f"participant:{res_id}:{p['displayOrder']}:{p['sailorId']}"))

                    sheet_results.append({
                        'rank': rank,
                        'entryLabel': entry_label,
                        'entryType': 'crew' if sh['is_crew'] else 'individual',
                        'sailOrBoardNumber': sail_num,
                        'club': club,
                        'grossScore': tot,
                        'nettScore': net,
                        'races': races,
                        'sailorId': primary_sid,
                        'resultId': res_id,
                        'participants': participants
                    })

        elif sh['format'] == 'sailsys':
            with open(filepath, 'r', encoding='utf-8') as f:
                nt_data = json.load(f)['data']
            target_div = None
            for div in nt_data['pointscore']['individualPointscores']:
                if div['parent']['name'] == sh['div_name']:
                    target_div = div
                    break
            items = sorted(target_div['items'], key=lambda x: x['pointscores'][0]['place'])
            fleet_size = len(items)
            for idx, item in enumerate(items, 1):
                ps = item['pointscores'][0]
                rank = int(ps['place'])
                sail_num = str(item['boat'].get('sailNumber') or '').strip()
                club = str(item['boat'].get('club') or 'DSC').strip()
                sk = ps['skipper']
                disp = clean_name(sk.get('displayName') or sk.get('name') or '')
                if disp == 'Jakov' and sk.get('surname'):
                    disp = f"Jakov {clean_name(sk['surname'])}"
                net = float(ps['total'])

                races = []
                calc_tot = 0.0
                calc_net = 0.0
                r_num = 0
                for ri in ps['pointscoreItems']:
                    if ri.get('abandoned'):
                        continue
                    r_num += 1
                    pts = float(ri['points'])
                    discarded = bool(ri.get('dropped'))
                    code = 'DNC' if pts > fleet_size else None
                    calc_tot += pts
                    if not discarded:
                        calc_net += pts
                    raw_fmt = f"({pts:g}{(' ' + code) if code else ''})" if discarded else f"{pts:g}{(' ' + code) if code else ''}"
                    races.append({
                        'raceNumber': r_num,
                        'score': pts,
                        'code': code,
                        'discarded': discarded,
                        'raw': raw_fmt
                    })
                tot = round(calc_tot, 2)
                if abs(calc_net - net) > 0.01:
                    discrepancies.append((sh['name'], rank, disp, tot, calc_tot, net, calc_net))

                sid, prof_name, is_new, hdl = resolve_sailor(disp, club, sail_num, None, 'AUS', class_prefix)
                res_id = str(uuid.uuid5(NAMESPACE, f"result:{sh['id']}:{idx}:{norm_name(prof_name)}"))
                part_id = str(uuid.uuid5(NAMESPACE, f"participant:{res_id}:1:{sid}"))

                sheet_results.append({
                    'rank': rank,
                    'entryLabel': prof_name,
                    'entryType': 'individual',
                    'sailOrBoardNumber': sail_num,
                    'club': club,
                    'grossScore': tot,
                    'nettScore': net,
                    'races': races,
                    'sailorId': sid,
                    'resultId': res_id,
                    'participants': [{
                        'sailorId': sid,
                        'profileName': prof_name,
                        'sourceName': disp,
                        'displayOrder': 1,
                        'role': 'solo',
                        'participantId': part_id
                    }]
                })

        print(f"Sheet {sh['name']}: {len(sheet_results)} entries extracted (expected {sh['totalFleetSize']})")
        extracted_all.append({
            'event': ev,
            'sheet': sh,
            'results': sheet_results
        })

print(f"Discrepancies found: {len(discrepancies)}")
for d in discrepancies:
    print("  DISCREPANCY:", d)

print(f"Extraction complete! Total new profiles to create: {len(new_profiles_list)}")
with open(os.path.join(BASE_DIR, 'extracted_other_classes.json'), 'w') as f:
    json.dump({
        'events': events_manifest,
        'newProfiles': new_profiles_list,
        'extracted': extracted_all
    }, f, indent=2)
