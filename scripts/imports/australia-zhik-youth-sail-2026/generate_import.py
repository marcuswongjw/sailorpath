import os
import re
import json
import uuid

BASE_DIR = 'scripts/imports/australia-zhik-youth-sail-2026'
NAMESPACE = uuid.UUID('6ba7b810-9dad-11d1-80b4-00c04fd430c8')

with open('scripts/imports/australia-optimist-2026/live-sailors.json') as f:
    existing_data = json.load(f)
existing_sailors = list(existing_data['rows'][0]['json_agg'])

# Also include the 146 profiles created in Migration 158
with open('scripts/imports/australia-optimist-2026/extracted.json') as f:
    m158_data = json.load(f)
for np in m158_data.get('newProfiles', []):
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
    # Examples: "[5.0]", "[28.0] C", "28.0 S", "4.5", "[3.0] F"
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
    # Format raw_value with parentheses if discarded so it matches SailorPath conventions
    raw_formatted = f"({pts:g}{(' ' + code) if code else ''})" if discarded and pts is not None else (f"{pts:g}{(' ' + code) if code else ''}" if pts is not None else val)
    return pts, code, discarded, raw_formatted

def parse_sportspage_cell(val):
    # Examples: "1( 1)", "[ 10]( 10)", "[ 26](OCS)", "9(SPI)", "[ 26](DNC)"
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

def resolve_sailor(name, club, sail_num, gender_hint, nat_hint='AUS'):
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
    base_handle = f"opti-{actual_nat.lower()}-{slugify(c_name)}-{sail_num or '0'}"
    handle = base_handle
    counter = 1
    while handle in existing_handles or handle in [p['handle'] for p in new_profiles_list]:
        handle = f"{base_handle}-{counter}"
        counter += 1

    gender = None
    if gender_hint:
        g_clean = gender_hint.upper().strip()
        if 'M' in g_clean or 'B' in g_clean:
            gender = 'M'
        elif 'F' in g_clean or 'G' in g_clean or 'W' in g_clean:
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

events_manifest = [
    {
        "id": str(uuid.uuid5(NAMESPACE, "event:2026-zhik-youth-sail-tas")),
        "slug": "2026-zhik-youth-sail-tas",
        "name": "2026 Zhik Youth Sail Tasmania (Tasmanian Youth Championships)",
        "startDate": "2026-03-07",
        "endDate": "2026-03-09",
        "venue": "Royal Yacht Club of Tasmania, Hobart, TAS, Australia",
        "organizer": "Australian Sailing / Royal Yacht Club of Tasmania (RYCT)",
        "classes": ["Optimist"],
        "scheduleSummary": "Zhik Youth Sail TAS coaching clinic and Tasmanian Youth Championship regatta held 7–9 March 2026 at Royal Yacht Club of Tasmania.",
        "scoringRules": "Low Point System with 1 discard.",
        "officialSource": {
            "url": "https://sailingresults.net/?ID=82311",
            "title": "2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)",
            "type": "url",
            "pdfSearch": {
                "available": False,
                "searched": [
                    "https://www.sailingyouth.org.au/youth-sail-tas",
                    "https://sailingresults.net/sa/notice/default.aspx?ID=82311",
                    "https://ryct.org.au/"
                ],
                "outcome": "Notice of Race, Sailing Instructions, and Notices to Competitors published in PDF on official noticeboard; final race results published exclusively via SailingResults.net HTML."
            }
        },
        "sheets": [
            {
                "file": "tas-optimist-open.html",
                "format": "sailingresults",
                "race_start": 5,
                "race_end": 11,
                "tot_idx": 11,
                "net_idx": 12,
                "gender_idx": 13,
                "nat_idx": None,
                "club_idx": 4,
                "sail_idx": 2,
                "name_idx": 1,
                "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82311.9",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-tas-optimist-open")),
                "slug": "2026-zhik-youth-sail-tas-optimist-open",
                "name": "2026 Zhik Youth Sail Tasmania — Optimist Open",
                "boatClass": "Optimist",
                "division": "Open",
                "raceCount": 6,
                "totalFleetSize": 4,
                "discardCount": 1
            },
            {
                "file": "tas-optimist-intermediate.html",
                "format": "sailingresults",
                "race_start": 5,
                "race_end": 11,
                "tot_idx": 11,
                "net_idx": 12,
                "gender_idx": 13,
                "nat_idx": None,
                "club_idx": 4,
                "sail_idx": 2,
                "name_idx": 1,
                "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82311.8",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-tas-optimist-intermediate")),
                "slug": "2026-zhik-youth-sail-tas-optimist-intermediate",
                "name": "2026 Zhik Youth Sail Tasmania — Optimist Intermediate",
                "boatClass": "Optimist",
                "division": "Intermediate",
                "raceCount": 6,
                "totalFleetSize": 7,
                "discardCount": 1
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
        "classes": ["Optimist"],
        "scheduleSummary": "Zhik Youth Sail QLD coaching clinic (21–23 Sept) and Queensland Youth Championships (24–26 Sept 2026) at Keppel Bay Sailing Club.",
        "scoringRules": "Low Point System with 1 discard.",
        "officialSource": {
            "url": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1228",
            "title": "2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)",
            "type": "url",
            "pdfSearch": {
                "available": False,
                "searched": [
                    "https://www.sailingyouth.org.au/youth-sail-qld/",
                    "https://sailingresults.net/sa/notice/default.aspx?ID=82426",
                    "https://topyacht.net/publicresults/IndexResults?clubId=1352&eventId=407"
                ],
                "outcome": "NOR, SIs, and protest notices published in PDF on SailingResults.net noticeboard (ID=82426); final race results published exclusively via TopYacht Public Results portal (seriesId=1228)."
            }
        },
        "sheets": [
            {
                "file": "qld-optimist-open.json",
                "format": "topyacht",
                "race_keys": ["R1", "R3", "R4", "R5"],
                "sourceUrl": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1228",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-qld-optimist-open")),
                "slug": "2026-zhik-youth-sail-qld-optimist-open",
                "name": "2026 Zhik Youth Sail Queensland — Optimist Open",
                "boatClass": "Optimist",
                "division": "Open",
                "raceCount": 4,
                "totalFleetSize": 14,
                "discardCount": 1
            },
            {
                "file": "qld-optimist-intermediate.json",
                "format": "topyacht",
                "race_keys": ["R1", "R2", "R3", "R4"],
                "sourceUrl": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1228",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-qld-optimist-intermediate")),
                "slug": "2026-zhik-youth-sail-qld-optimist-intermediate",
                "name": "2026 Zhik Youth Sail Queensland — Optimist Intermediate",
                "boatClass": "Optimist",
                "division": "Intermediate",
                "raceCount": 4,
                "totalFleetSize": 27,
                "discardCount": 1
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
        "classes": ["Optimist"],
        "scheduleSummary": "Zhik Youth Sail SA coaching clinic and South Australian Youth Championships held 26–29 September 2026 at Brighton & Seacliff Yacht Club.",
        "scoringRules": "Low Point System with 1 discard.",
        "officialSource": {
            "url": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1175",
            "title": "2026 SA Youth Championships Official Results (TopYacht)",
            "type": "url",
            "pdfSearch": {
                "available": False,
                "searched": [
                    "https://www.sailingyouth.org.au/youth-sail-sa/sa-results",
                    "https://topyacht.com.au/db/otb/event_toolbox.php?des=102.694.2688",
                    "https://www.topyacht.com.au/notice_brd/notice_brd_otb.php?ev=102.102.102.2.694"
                ],
                "outcome": "NOR, SIs, and protest time limits published in PDF on TopYacht noticeboard; final race results published exclusively via TopYacht Public Results portal (seriesId=1175)."
            }
        },
        "sheets": [
            {
                "file": "sa-optimist-open.json",
                "format": "topyacht",
                "race_keys": ["R1", "R2", "R3", "R4", "R5", "R6"],
                "sourceUrl": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1175",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-sa-optimist-open")),
                "slug": "2026-zhik-youth-sail-sa-optimist-open",
                "name": "2026 Zhik Youth Sail South Australia — Optimist Open",
                "boatClass": "Optimist",
                "division": "Open",
                "raceCount": 6,
                "totalFleetSize": 4,
                "discardCount": 1
            },
            {
                "file": "sa-optimist-intermediate.json",
                "format": "topyacht",
                "race_keys": ["R1", "R3", "R4", "R5"],
                "sourceUrl": "https://topyacht.net/publicresults/SeriesIndex?seriesId=1175",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-sa-optimist-intermediate")),
                "slug": "2026-zhik-youth-sail-sa-optimist-intermediate",
                "name": "2026 Zhik Youth Sail South Australia — Optimist Intermediate",
                "boatClass": "Optimist",
                "division": "Intermediate",
                "raceCount": 4,
                "totalFleetSize": 7,
                "discardCount": 1
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
        "classes": ["Optimist"],
        "scheduleSummary": "Zhik Youth Sail WA coaching clinic and 2026 Zhik WA Youth Championships held 26 September – 1 October 2026 on the Swan River, Perth.",
        "scoringRules": "Low Point System with 1 discard across 9 races.",
        "officialSource": {
            "url": "https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/progresultspage.htm",
            "title": "2026 Zhik WA Youth Championships Official Results (Sportspage)",
            "type": "url",
            "pdfSearch": {
                "available": False,
                "searched": [
                    "https://www.sailingyouth.org.au/youth-sail-wa/wa-results-/",
                    "https://www.sailingyouth.org.au/youth-sail-wa/wa-notice-board",
                    "https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/progresultspage.htm"
                ],
                "outcome": "NOR and SI amendments 1–5 published in PDF on WA noticeboard; final race results published exclusively via Sportspage HTML."
            }
        },
        "sheets": [
            {
                "file": "wa-optimist-open.html",
                "format": "sportspage",
                "sourceUrl": "https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-wa-optimist-open")),
                "slug": "2026-zhik-youth-sail-wa-optimist-open",
                "name": "2026 Zhik Youth Sail Western Australia — Optimist Open",
                "boatClass": "Optimist",
                "division": "Open",
                "raceCount": 9,
                "totalFleetSize": 25,
                "discardCount": 1
            },
            {
                "file": "wa-optimist-intermediate.html",
                "format": "sportspage",
                "sourceUrl": "https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-wa-optimist-intermediate")),
                "slug": "2026-zhik-youth-sail-wa-optimist-intermediate",
                "name": "2026 Zhik Youth Sail Western Australia — Optimist Intermediate",
                "boatClass": "Optimist",
                "division": "Intermediate",
                "raceCount": 9,
                "totalFleetSize": 19,
                "discardCount": 1
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
        "classes": ["Optimist"],
        "scheduleSummary": "Zhik Youth Sail NSW coaching clinic (30 Sept – 2 Oct) and NSW Youth Championships (3–5 Oct 2026) at Toronto Amateur Sailing Club, Lake Macquarie.",
        "scoringRules": "Low Point System with 1 discard (up to 2 discards if 9 races completed; 1 discard in NSW series).",
        "officialSource": {
            "url": "https://sailingresults.net/?ID=82460",
            "title": "2026 Zhik NSW Youth Championships Official Results (SailingResults.net)",
            "type": "url",
            "pdfSearch": {
                "available": False,
                "searched": [
                    "https://www.sailingyouth.org.au/youth-sail-nsw/nsw-results",
                    "https://sailingresults.net/sa/notice/default.aspx?ID=82460",
                    "https://www.tasc.org.au/"
                ],
                "outcome": "NOR and SIs published in PDF on SailingResults.net noticeboard (ID=82460); final race results published exclusively via SailingResults.net HTML."
            }
        },
        "sheets": [
            {
                "file": "nsw-optimist-open.html",
                "format": "sailingresults",
                "race_start": 6,
                "race_end": 15,
                "tot_idx": 15,
                "net_idx": 16,
                "gender_idx": 17,
                "nat_idx": 3,
                "club_idx": 5,
                "sail_idx": 2,
                "name_idx": 1,
                "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82460.12",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-nsw-optimist-open")),
                "slug": "2026-zhik-youth-sail-nsw-optimist-open",
                "name": "2026 Zhik Youth Sail New South Wales — Optimist Open",
                "boatClass": "Optimist",
                "division": "Open",
                "raceCount": 9,
                "totalFleetSize": 74,
                "discardCount": 1
            },
            {
                "file": "nsw-optimist-intermediate.html",
                "format": "sailingresults",
                "race_start": 6,
                "race_end": 14,
                "tot_idx": 14,
                "net_idx": 15,
                "gender_idx": 16,
                "nat_idx": 3,
                "club_idx": 5,
                "sail_idx": 2,
                "name_idx": 1,
                "rank_idx": 0,
                "sourceUrl": "https://sailingresults.net/sa/results/overall.aspx?ID=82460.11",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-zhik-youth-sail-nsw-optimist-intermediate")),
                "slug": "2026-zhik-youth-sail-nsw-optimist-intermediate",
                "name": "2026 Zhik Youth Sail New South Wales — Optimist Intermediate",
                "boatClass": "Optimist",
                "division": "Intermediate",
                "raceCount": 8,
                "totalFleetSize": 32,
                "discardCount": 1
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

        if sh['format'] == 'sailingresults':
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                html = f.read()
            rows = re.findall(r'<tr[^>]*>(.*?)</tr>', html, re.S)
            for r in rows[1:]:
                cols = [re.sub(r'<[^>]+>', '', c).strip().replace('&nbsp;', ' ') for c in re.findall(r'<t[dh][^>]*>(.*?)</t[dh]>', r, re.S)]
                if cols and cols[sh['rank_idx']].isdigit():
                    rank = int(cols[sh['rank_idx']])
                    name = clean_name(cols[sh['name_idx']])
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
                        discrepancies.append((sh['name'], rank, name, tot, calc_tot, net, calc_net))

                    sailor_id, profile_name, is_new, handle = resolve_sailor(name, club, sail_num, gender_hint, nat_hint)
                    res_id = str(uuid.uuid5(NAMESPACE, f"result:{sh['id']}:{rank}:{norm_name(name)}"))
                    part_id = str(uuid.uuid5(NAMESPACE, f"participant:{res_id}:{sailor_id}"))

                    sheet_results.append({
                        'rank': rank,
                        'name': profile_name,
                        'sourceName': name,
                        'sailOrBoardNumber': sail_num,
                        'club': club,
                        'grossScore': tot,
                        'nettScore': net,
                        'races': races,
                        'sailorId': sailor_id,
                        'resultId': res_id,
                        'isNewProfile': is_new,
                        'handle': handle,
                        'participantId': part_id
                    })

        elif sh['format'] == 'topyacht':
            with open(filepath, 'r', encoding='utf-8') as f:
                ty_data = json.load(f)['data']['resultGroupeds'][0]['results']
            for idx, r in enumerate(ty_data, 1):
                rank = int(r['place'])
                name = clean_name(r['skipper'])
                sail_num = str(r.get('sailnum') or '').strip()
                club = str(r.get('note') or 'Australia').strip()
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
                    discrepancies.append((sh['name'], rank, name, tot, calc_tot, net, calc_net))

                sailor_id, profile_name, is_new, handle = resolve_sailor(name, club, sail_num, None, 'AUS')
                res_id = str(uuid.uuid5(NAMESPACE, f"result:{sh['id']}:{idx}:{norm_name(name)}"))
                part_id = str(uuid.uuid5(NAMESPACE, f"participant:{res_id}:{sailor_id}"))

                sheet_results.append({
                    'rank': rank,
                    'name': profile_name,
                    'sourceName': name,
                    'sailOrBoardNumber': sail_num,
                    'club': club,
                    'grossScore': tot,
                    'nettScore': net,
                    'races': races,
                    'sailorId': sailor_id,
                    'resultId': res_id,
                    'isNewProfile': is_new,
                    'handle': handle,
                    'participantId': part_id
                })

        elif sh['format'] == 'sportspage':
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                html = f.read()
            rows = re.findall(r'<TR[^>]*>(.*?)</TR>', html, re.S | re.I)
            for r in rows:
                cols = [re.sub(r'<[^>]+>', '', c).strip().replace('&nbsp;', ' ') for c in re.findall(r'<T[DH][^>]*>(.*?)</T[DH]>', r, re.S | re.I)]
                if len(cols) >= 7 and cols[0].isdigit():
                    rank = int(cols[0])
                    sail_num = cols[1].strip()
                    skipper_club = cols[3].strip()
                    m_sc = re.match(r'^(.*?)\(([^)]+)\)$', skipper_club)
                    if m_sc:
                        name = clean_name(m_sc.group(1))
                        club = m_sc.group(2).strip()
                    else:
                        name = clean_name(skipper_club)
                        club = 'WA'
                    tot = float(cols[4])
                    net = float(cols[5])
                    races_raw = cols[6:]

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
                        discrepancies.append((sh['name'], rank, name, tot, calc_tot, net, calc_net))

                    sailor_id, profile_name, is_new, handle = resolve_sailor(name, club, sail_num, None, 'AUS')
                    res_id = str(uuid.uuid5(NAMESPACE, f"result:{sh['id']}:{rank}:{norm_name(name)}"))
                    part_id = str(uuid.uuid5(NAMESPACE, f"participant:{res_id}:{sailor_id}"))

                    sheet_results.append({
                        'rank': rank,
                        'name': profile_name,
                        'sourceName': name,
                        'sailOrBoardNumber': sail_num,
                        'club': club,
                        'grossScore': tot,
                        'nettScore': net,
                        'races': races,
                        'sailorId': sailor_id,
                        'resultId': res_id,
                        'isNewProfile': is_new,
                        'handle': handle,
                        'participantId': part_id
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
with open(os.path.join(BASE_DIR, 'extracted.json'), 'w') as f:
    json.dump({
        'events': events_manifest,
        'newProfiles': new_profiles_list,
        'extracted': extracted_all
    }, f, indent=2)
