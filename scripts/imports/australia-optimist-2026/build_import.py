import os
import re
import json
import uuid

BASE_DIR = 'scripts/imports/australia-optimist-2026'
NAMESPACE = uuid.UUID('6ba7b810-9dad-11d1-80b4-00c04fd430c8')

with open('scripts/imports/asian-championships-priority1/existing-sailors.json') as f:
    existing_data = json.load(f)
existing_sailors = existing_data['rows'][0]['json_agg']

existing_handles = {s['handle'] for s in existing_sailors}
existing_ids = {s['id'] for s in existing_sailors}

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
    norm = norm_name(s['name'])
    sailor_by_norm.setdefault(norm, []).append(s)

def parse_cell(val):
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

created_profiles = {}
new_profiles_list = []

def resolve_sailor(name, club, sail_num, gender_hint, nat_hint='AUS'):
    c_name = clean_name(name)
    norm = norm_name(c_name)
    candidates = sailor_by_norm.get(norm, [])
    # Filter candidates: if multiple, check AUS or club or sail
    matched = None
    if len(candidates) == 1:
        matched = candidates[0]
    elif len(candidates) > 1:
        # try matching nationality or club
        for cand in candidates:
            if cand.get('nationality') == 'AUS' or (club and cand.get('club') and (club in cand['club'] or cand['club'] in club)):
                matched = cand
                break
        if not matched:
            matched = candidates[0]
    
    if matched:
        return matched['id'], matched['name'], False, matched['handle']

    # Check if already created in this batch
    if norm in created_profiles:
        p = created_profiles[norm]
        return p['id'], p['name'], False, p['handle']
    
    # Create new profile
    p_id = str(uuid.uuid5(NAMESPACE, f"sailor:{nat_hint}:{norm}"))
    base_handle = f"opti-{nat_hint.lower()}-{slugify(c_name)}-{sail_num or '0'}"
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
        'nationality': nat_hint,
        'gender': gender
    }
    created_profiles[norm] = new_p
    new_profiles_list.append(new_p)
    return p_id, c_name, True, handle

print('Helper functions ready.')

# Definitions of events and sheets
events_manifest = [
    {
        "id": str(uuid.uuid5(NAMESPACE, "event:2026-musto-australian-optimist-championship")),
        "slug": "2026-musto-australian-optimist-championship",
        "name": "2026 Musto Australian Optimist Championship",
        "startDate": "2026-01-08",
        "endDate": "2026-01-15",
        "venue": "Royal Yacht Club of Tasmania, Hobart, TAS, Australia",
        "organizer": "Australian International Optimist Dinghy Association (AIODA) / RYCT",
        "classes": ["Optimist"],
        "scheduleSummary": "National youth championship held 8–15 January 2026 on the River Derwent, Hobart.",
        "scoringRules": "Low Point System with 1 discard after 5 races.",
        "officialSource": {
            "url": "https://sailingresults.net/sa/results/overall.aspx?ID=82277.2",
            "title": "2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results",
            "type": "url",
            "pdfSearch": {
                "available": false,
                "searched": [
                    "https://ryct.org.au/2026-australian-optimist-dinghy-championship/",
                    "http://www.optimist.org.au/nationals",
                    "https://sailingresults.net/site/event/85/document/ (NOR and SIs found in PDF, no results PDF published)"
                ],
                "outcome": "Official results published via dynamic SailingResults.net HTML. No official final results PDF published by organiser."
            }
        },
        "sheets": [
            {
                "file": "musto-intermediate.html",
                "format": "sailingresults",
                "race_start": 6,
                "race_end": 15,
                "tot_idx": 15,
                "net_idx": 16,
                "gender_idx": 17,
                "club_idx": 5,
                "sail_idx": 3,
                "name_idx": 1,
                "rank_idx": 0,
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-musto-australian-optimist-championship-intermediate")),
                "slug": "2026-musto-australian-optimist-championship-intermediate",
                "name": "2026 Musto Australian Optimist Championship — Intermediate Fleet",
                "boatClass": "Optimist",
                "division": "Intermediate",
                "raceCount": 9,
                "totalFleetSize": 42,
                "discardCount": 1
            }
        ]
    },
    {
        "id": str(uuid.uuid5(NAMESPACE, "event:2026-tasmanian-optimist-state-championship")),
        "slug": "2026-tasmanian-optimist-state-championship",
        "name": "2026 Tasmanian Optimist State Championship",
        "startDate": "2026-02-28",
        "endDate": "2026-03-01",
        "venue": "Royal Yacht Club of Tasmania, Hobart, TAS, Australia",
        "organizer": "Tasmanian International Optimist Dinghy Association (TIODA) / RYCT",
        "classes": ["Optimist"],
        "scheduleSummary": "State championship regatta conducted 28 February – 1 March 2026 on the River Derwent.",
        "scoringRules": "Low Point System with 1 discard after 5 races.",
        "officialSource": {
            "url": "https://sailingresults.net/sa/results/overall.aspx?ID=82313",
            "title": "2026 Tasmanian Optimist State Championship Official Results",
            "type": "url",
            "pdfSearch": {
                "available": false,
                "searched": [
                    "https://www.revolutionise.com.au/tioda",
                    "https://ryct.org.au/",
                    "https://sailingresults.net/?id=82313"
                ],
                "outcome": "Official results published via dynamic SailingResults.net HTML. No official final results PDF published by organiser."
            }
        },
        "sheets": [
            {
                "file": "tasmania-open.html",
                "format": "sailingresults",
                "race_start": 5,
                "race_end": 11,
                "tot_idx": 11,
                "net_idx": 12,
                "gender_idx": None,
                "club_idx": 4,
                "sail_idx": 3,
                "name_idx": 1,
                "rank_idx": 0,
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-tasmanian-optimist-state-championship-open")),
                "slug": "2026-tasmanian-optimist-state-championship-open",
                "name": "2026 Tasmanian Optimist State Championship — Open Fleet",
                "boatClass": "Optimist",
                "division": "Open",
                "raceCount": 6,
                "totalFleetSize": 6,
                "discardCount": 1
            },
            {
                "file": "tasmania-intermediate.html",
                "format": "sailingresults",
                "race_start": 5,
                "race_end": 11,
                "tot_idx": 11,
                "net_idx": 12,
                "gender_idx": None,
                "club_idx": 4,
                "sail_idx": 3,
                "name_idx": 1,
                "rank_idx": 0,
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-tasmanian-optimist-state-championship-intermediate")),
                "slug": "2026-tasmanian-optimist-state-championship-intermediate",
                "name": "2026 Tasmanian Optimist State Championship — Intermediate Fleet",
                "boatClass": "Optimist",
                "division": "Intermediate",
                "raceCount": 6,
                "totalFleetSize": 6,
                "discardCount": 1
            }
        ]
    },
    {
        "id": str(uuid.uuid5(NAMESPACE, "event:2026-vioda-victorian-open-championship")),
        "slug": "2026-vioda-victorian-open-championship",
        "name": "2026 VIODA International Optimist Victorian & Open Championship",
        "startDate": "2026-03-07",
        "endDate": "2026-03-09",
        "venue": "Royal Brighton Yacht Club, Melbourne, VIC, Australia",
        "organizer": "Victorian International Optimist Dinghy Association (VIODA) / RBYC",
        "classes": ["Optimist"],
        "scheduleSummary": "Annual Victorian state championship held 7–9 March 2026 at Royal Brighton Yacht Club, Port Phillip.",
        "scoringRules": "Low Point System with 1 discard after 5 races.",
        "officialSource": {
            "url": "https://sailingresults.net/sa/results/overall.aspx?ID=82126",
            "title": "VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results",
            "type": "url",
            "pdfSearch": {
                "available": false,
                "searched": [
                    "https://vioda.org.au",
                    "https://rbyc.org.au",
                    "https://sailingresults.net/?id=82126"
                ],
                "outcome": "Official results published via dynamic SailingResults.net HTML. No official final results PDF published by organiser."
            }
        },
        "sheets": [
            {
                "file": "victoria-open.html",
                "format": "sailingresults",
                "race_start": 7,
                "race_end": 15,
                "tot_idx": 15,
                "net_idx": 16,
                "gender_idx": 17,
                "club_idx": 6,
                "sail_idx": 3,
                "name_idx": 1,
                "rank_idx": 0,
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-vioda-victorian-open-championship-open")),
                "slug": "2026-vioda-victorian-open-championship-open",
                "name": "2026 VIODA International Optimist Victorian & Open Championship — Open Fleet",
                "boatClass": "Optimist",
                "division": "Open",
                "raceCount": 8,
                "totalFleetSize": 38,
                "discardCount": 1
            },
            {
                "file": "victoria-intermediate.html",
                "format": "sailingresults",
                "race_start": 7,
                "race_end": 14,
                "tot_idx": 14,
                "net_idx": 15,
                "gender_idx": 16,
                "club_idx": 6,
                "sail_idx": 3,
                "name_idx": 1,
                "rank_idx": 0,
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-vioda-victorian-open-championship-intermediate")),
                "slug": "2026-vioda-victorian-open-championship-intermediate",
                "name": "2026 VIODA International Optimist Victorian & Open Championship — Intermediate Fleet",
                "boatClass": "Optimist",
                "division": "Intermediate",
                "raceCount": 7,
                "totalFleetSize": 27,
                "discardCount": 1
            }
        ]
    },
    {
        "id": str(uuid.uuid5(NAMESPACE, "event:2026-nsw-optimist-state-championship")),
        "slug": "2026-nsw-optimist-state-championship",
        "name": "2026 NSW Optimist State Championship",
        "startDate": "2026-03-21",
        "endDate": "2026-03-22",
        "venue": "Royal Prince Alfred Yacht Club, Pittwater, NSW, Australia",
        "organizer": "NSW International Optimist Dinghy Association (NSWIODA) / RPAYC",
        "classes": ["Optimist"],
        "scheduleSummary": "NSW state championship conducted 21–22 March 2026 at RPAYC, Pittwater.",
        "scoringRules": "Low Point System with no discards.",
        "officialSource": {
            "url": "https://www.sailwave.com/results/states26.htm",
            "title": "Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club",
            "type": "url",
            "pdfSearch": {
                "available": false,
                "searched": [
                    "https://optinsw.org.au",
                    "https://rpayc.com.au",
                    "https://www.sailwave.com/results/states26.htm"
                ],
                "outcome": "Official results published via Sailwave HTML table. No official final results PDF published by organiser."
            }
        },
        "sheets": [
            {
                "file": "nsw-states26.html",
                "format": "sailwave_section",
                "section_name": "Open Fleet",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-nsw-optimist-state-championship-open")),
                "slug": "2026-nsw-optimist-state-championship-open",
                "name": "2026 NSW Optimist State Championship — Open Fleet",
                "boatClass": "Optimist",
                "division": "Open",
                "raceCount": 3,
                "totalFleetSize": 42,
                "discardCount": 0
            },
            {
                "file": "nsw-states26.html",
                "format": "sailwave_section",
                "section_name": "Intermediate Fleet",
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-nsw-optimist-state-championship-intermediate")),
                "slug": "2026-nsw-optimist-state-championship-intermediate",
                "name": "2026 NSW Optimist State Championship — Intermediate Fleet",
                "boatClass": "Optimist",
                "division": "Intermediate",
                "raceCount": 2,
                "totalFleetSize": 55,
                "discardCount": 0
            }
        ]
    },
    {
        "id": str(uuid.uuid5(NAMESPACE, "event:2026-act-optimist-championship")),
        "slug": "2026-act-optimist-championship",
        "name": "2026 ACT Optimist Championship",
        "startDate": "2026-10-24",
        "endDate": "2026-10-25",
        "venue": "Canberra Yacht Club, Lake Burley Griffin, ACT, Australia",
        "organizer": "Canberra Yacht Club (CYC) / NSWIODA",
        "classes": ["Optimist"],
        "scheduleSummary": "ACT territory championship held 24–25 October 2026 at Canberra Yacht Club, Lake Burley Griffin.",
        "scoringRules": "Low Point System with 1 discard after 5 races.",
        "officialSource": {
            "url": "https://austeamsailing.com/events/ACT26.htm",
            "title": "Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club",
            "type": "url",
            "pdfSearch": {
                "available": false,
                "searched": [
                    "https://canberrayachtclub.com.au",
                    "https://optinsw.org.au",
                    "https://austeamsailing.com/events/ACT26.htm"
                ],
                "outcome": "Official results published via Sailwave HTML table. No official final results PDF published by organiser."
            }
        },
        "sheets": [
            {
                "file": "act-results.html",
                "format": "sailwave_table",
                "table_idx": 0,
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-act-optimist-championship-open")),
                "slug": "2026-act-optimist-championship-open",
                "name": "2026 ACT Optimist Championship — Open Fleet",
                "boatClass": "Optimist",
                "division": "Open",
                "raceCount": 7,
                "totalFleetSize": 27,
                "discardCount": 1
            },
            {
                "file": "act-results.html",
                "format": "sailwave_table",
                "table_idx": 1,
                "id": str(uuid.uuid5(NAMESPACE, "sheet:2026-act-optimist-championship-intermediate")),
                "slug": "2026-act-optimist-championship-intermediate",
                "name": "2026 ACT Optimist Championship — Intermediate Fleet",
                "boatClass": "Optimist",
                "division": "Intermediate",
                "raceCount": 6,
                "totalFleetSize": 17,
                "discardCount": 1
            }
        ]
    }
]

print(f'Defined {len(events_manifest)} events with total {sum(len(e["sheets"]) for e in events_manifest)} sheets.')
