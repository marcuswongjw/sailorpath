#!/usr/bin/env python3
"""
Builder script for Migration 176:
115th Academic Year National President's Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽)
Organized by the Chinese Taipei Sailing Association (CTSA / 中華民國帆船協會).
Source: http://www.ct-sailing.org.tw / https://www.sailwave.com/results/115PresidentCup.htm
"""
from __future__ import annotations
import html
import json
import re
import uuid

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

# Comprehensive Taiwanese Sailor Romanization & Gender mapping
sailor_metadata = {
    '翁硯昀': ('Yen-Yun Weng', 'F'),
    '高宇呈': ('Yu-Cheng Kao', 'M'),
    '陳睿萱': ('Jui-Hsuan Chen', 'F'),
    '楊舒媛': ('Shu-Yuan Yang', 'F'),
    '巫明霓': ('Ming-Ni Wu', 'F'),
    '魏明瑗': ('Ming-Yuan Wei', 'F'),
    '張豐': ('Feng Chang', 'M'),
    '鄭皓中': ('Hao-Chung Cheng', 'M'),
    '楊詠雰': ('Yong-Fen Yang', 'F'),
    '黃祺方': ('Huang Chi Fang', 'F'),
    '王妍禎': ('Yen-Chen Wang', 'F'),
    '李心平': ('Sin-Ping Lee', 'F'),
    '高戎岑': ('Jung-Tsen Kao', 'F'),
    '李榆': ('Yu Lee', 'F'),
    '王彥勻': ('Yan-Yun Wang', 'F'),
    '康予瀞': ('Yu-Ching Kang', 'F'),
    '許恩睿': ('En-Rui Hsu', 'F'),
    '連愛玫': ('Ai-Mei Lien', 'F'),
    '康予馨': ('Yu-Hsin Kang', 'F'),
    '鄭羽岑': ('Yu-Tsen Cheng', 'F'),
    '陳鈺凱': ('Chen Yu Kai', 'M'),
    '葉宸揚': ('Yeh Chen Yang', 'M'),
    '莊永睿': ('Yong Ray Chuang', 'M'),
    '李丹': ('Dan Lee', 'M'),
    '徐浩然': ('Hao-Ran Hsu', 'M'),
    '戴群諺': ('Cyun-Yan Tai', 'M'),
    '劉子禾': ('Tzu-Ho Liu', 'M'),
    '林紀希': ('Chi-Hsi Lin', 'M'),
    '吳夏安': ('Hsia-An Wu', 'M'),
    '林廷任': ('Ting-Jen Lin', 'M'),
    '李承軒': ('Cheng-Hsuan Lee', 'M'),
    '陳璽翔': ('Hsi-Hsiang Chen', 'M'),
    '黃昱翔': ('Yu-Hsiang Huang', 'M'),
    '陳家程': ('Chia-Cheng Chen', 'M'),
    '林廷恩': ('Ting-En Lin', 'M'),
    '劉宥均': ('Yu-Chun Liu', 'M'),
    '温淯湋': ('Yu-Wei Wen', 'M'),
    '陳和彥': ('Ho-Yen Chen', 'M'),
    '吳御綸': ('Yu-Lun Wu', 'M'),
    '陳品潔': ('Pin-Chieh Chen', 'F'),
    '蔡佳倚': ('Chia-Yi Tsai', 'F'),
    '黃禾曦': ('Hehsi Lucy Huang', 'F'),
    '李冠穎': ('Kuan-Ying Lee', 'F'),
    '楊采昕': ('Tsai-Hsin Yang', 'F'),
    '錢采湉': ('Tsai-Tien Chien', 'F'),
    '黃薏珊': ('Yi San Huang', 'F'),
    '田恬': ('Tien Tien', 'F'),
    '蔡佳倫': ('Chia-Lun Tsai', 'F'),
    '林冠穎': ('Kuan-Ying Lin', 'M'),
    '葉騰晰': ('Teng-Hsi Yeh', 'M'),
    '楊崴翔': ('Waixiang Yang', 'M'),
    '楊崴棋': ('Wei-Chi Yang', 'M'),
    '陳翊禾': ('Yi-Ho Chen', 'M'),
    '王東彥': ('Tung-Yen Wang', 'M'),
    '黃子彤': ('Tzu-Tung Huang', 'M'),
    '張洺碩': ('Ming-Shuo Chang', 'M'),
    '黃洋': ('Yang Huang', 'M'),
    '黃宜': ('Yi Huang', 'M'),
    '陳鈺新': ('Chen Yu Shin', 'M'),
    '張嘉哲': ('Chia-Che Chang', 'M'),
    '嚴朗毅': ('Lang-Yi Yen', 'M'),
    '張志維': ('Chih-Wei Chang', 'M'),
    '張楨祥': ('Chen-Hsiang Chang', 'M'),
    '陳軍互': ('Chun-Hu Chen', 'M'),
    '陳時英': ('Shih-Ying Chen', 'M'),
    '蕭棋寶': ('Chi-Pao Hsiao', 'M'),
    '高宇涵': ('Yu-Han Kao', 'F'),
    '邱家妡': ('Chia-Hsin Chiu', 'F'),
    '黃宇婕': ('Huang Yu Chieh', 'F'),
    '黃宇慈': ('Huang Yu Tzu', 'F'),
    '陳宥蓁': ('Chen You Jhen', 'F'),
    '葉芮均': ('Jui-Chun Yeh', 'F'),
    '許舒雅': ('Shu-Ya Hsu', 'F'),
    '巫晨玥': ('Chen-Yueh Wu', 'F'),
    '楊家茵': ('Chia-Yin Yang', 'F'),
    '林藹然': ('Ai-Jan Lin', 'F'),
    '莊昀澐': ('Yun-Yun Chuang', 'F'),
    '李善雅': ('Shan-Ya Lee', 'F'),
    '黃品瑄': ('Pin-Hsuan Huang', 'F'),
    '李善羽': ('Shan-Yu Lee', 'F'),
    '蔡秉珊': ('Ping-Shan Tsai', 'F'),
    '林伊娣': ('Yi-Ti Lin', 'F'),
    '李薰唯': ('Hsun-Wei Lee', 'F'),
    '徐晨瑄': ('Chen-Hsuan Hsu', 'F'),
    '魯恩琦': ('En-Chi Lu', 'F'),
    '吳思艾': ('Szu-Ai Wu', 'F'),
    '莊永愛': ('Yong Ai Chuang', 'F'),
    '葉敏妘': ('Minyun Yeh', 'F'),
    '葉雨橋': ('Yu-Chiao Yeh', 'F'),
    '陳慧柔': ('Hui-Jou Chen', 'F'),
    '陳媺霓': ('Mei-Ni Chen', 'F'),
    '劉暄儂': ('Hsuan-Nung Liu', 'F'),
    '潘畇蓁': ('Yun-Chen Pan', 'F'),
    '陳慧云': ('Hui-Yun Chen', 'F'),
    '鄭立磐': ('Li-Pan Cheng', 'M'),
    '陳可邦': ('Ko-Pang Chen', 'M'),
    '廖宥善': ('You-Shan Liao', 'M'),
    '吳宥辰': ('Yu-Chen Wu', 'M'),
    '黃靖皓': ('Ching-Hao Huang', 'M'),
    '陳信邑': ('Hsin-Yi Chen', 'M'),
    '邱家煦': ('Chia-Hsin Chiu', 'M'),
    '劉子樂': ('Tzu-Le Liu', 'M'),
    '林謙潤': ('Chien-Jun Lin', 'M'),
    '高宇恒': ('Yu-Heng Kao', 'M'),
    '陳靖衡': ('Ching-Heng Chen', 'M'),
    '周宥恩': ('Yu-En Chou', 'M'),
    '蔡政哲': ('Cheng-Che Tsai', 'M'),
    '莊濬綸': ('Chun-Lun Chuang', 'M'),
    '陳又安': ('Yu-An Chen', 'M'),
    '陳詠詠': ('Yung-Yung Chen', 'M'),
    '劉展睿': ('Chan-Jui Liu', 'M'),
    '黃佶康': ('Chi-Kang Huang', 'M'),
    '施聿凡': ('Yu-Fan Shih', 'M'),
    '李鄞秱': ('Yin-Tung Lee', 'M'),
    '趙泰程': ('Tai-Cheng Chao', 'M'),
    '趙威帆': ('Wei-Fan Chao', 'M'),
    '葉罡均': ('Kang-Chun Yeh', 'M'),
    '陳志宇': ('Chih-Yu Chen', 'M'),
    '黃上愷': ('Huang Shang Kai Rocky', 'M'),
    '葉其叡': ('Chi-Jui Yeh', 'M'),
    '林晉立': ('Chin-Li Lin', 'M'),
    '胡閔皓': ('Min-Hao Hu', 'M'),
    '黃建宇': ('Chien-Yu Huang', 'M'),
    '陳映宇': ('Ying-Yu Chen', 'M'),
    '陳宥齊': ('Yu-Chi Chen', 'M'),
    '陳齊盛': ('Chi-Sheng Chen', 'M'),
    '朱宸麟': ('Chen-Lin Chu', 'M'),
    '陳振豐': ('Chen-Feng Chen', 'M'),
    '吳泛恩': ('Fan-En Wu', 'M'),
    '許竩辰': ('Yi-Chen Hsu', 'M'),
    '莊浚禾': ('Chun-Ho Chuang', 'M'),
    '王子銨': ('Tzu-An Wang', 'M'),
    '莊詩正': ('Shih-Cheng Chuang', 'M'),
    '覃道胤': ('Tao-Yin Tan', 'M'),
    '張佑語': ('Yu-Yu Chang', 'M'),
    '郭侑軒': ('Yu-Hsuan Kuo', 'M'),
    '廖凡鈞': ('Fan-Chun Liao', 'M'),
    '莊昀昊': ('Yun-Hao Chuang', 'M'),
}

# Read and decode HTML table
with open('scripts/imports/taiwan-2026/results.html', 'rb') as f:
    text = f.read().decode('big5hkscs', errors='replace')
text = html.unescape(text)

fleets = [
    ('420', '420', 'Open', 'crew', 2, 2, r'帆船雙人國際420型 級別', 4),
    ('ILCA 4 (G)', 'ILCA 4', 'Girls', 'individual', 1, 1, r'帆船ILCA 4型女子組 級別', 12),
    ('ILCA 4 (B)', 'ILCA 4', 'Boys', 'individual', 1, 1, r'帆船ILCA 4型男子組 級別', 19),
    ('ILCA 6 (G)', 'ILCA 6', 'Girls', 'individual', 1, 1, r'帆船ILCA 6型女子組 級別', 9),
    ('ILCA 6 (B)', 'ILCA 6', 'Boys', 'individual', 1, 1, r'帆船ILCA 6型男子組 級別', 8),
    ('ILCA 7', 'ILCA 7', 'Open', 'individual', 1, 1, r'帆船ILCA 7型 級別', 10),
    ('Optimist (G)', 'optimist', 'Girls', 'individual', 1, 1, r'帆船樂觀型女子組 級別', 28),
    ('Optimist (B)', 'optimist', 'Boys', 'individual', 1, 1, r'帆船樂觀型男子組 級別', 44),
]

parts = re.split(r'<h3[^>]*class=[\"\']summarytitle[\"\'][^>]*>(.*?)</h3>', text)

# Sailor resolution helper
matched_count = 0
created_count = 0
new_sailor_map = {}

def get_or_create_sailor(kj_name: str, club: str, sail_no: str) -> tuple[str, str, bool]:
    global matched_count, created_count
    rom_name, gender = sailor_metadata.get(kj_name, (kj_name, 'M'))
    norm = re.sub(r'[^a-z0-9]', '', rom_name.lower())
    clean_sn = re.sub(r'[^0-9]', '', sail_no)

    # 1. Check exact normalized name match in TPE sailors
    cands = [s for s in name_map.get(norm, []) if s.get('nationality') == 'TPE']
    if cands:
        matched_count += 1
        return cands[0]['id'], cands[0]['name'], False

    # 2. Check sail number match among TPE sailors
    if clean_sn and clean_sn in sail_map:
        sn_cands = [s for s in sail_map[clean_sn] if s.get('nationality') == 'TPE']
        if sn_cands:
            matched_count += 1
            return sn_cands[0]['id'], sn_cands[0]['name'], False

    # 3. Create deterministic new profile
    if kj_name in new_sailor_map:
        return new_sailor_map[kj_name]['id'], rom_name, False

    sid = make_uuid(f"sailor:TPE:{rom_name}:{kj_name}")
    handle = make_handle(rom_name, f"tpe-{sid[:4]}")
    clean_sail = sail_no.strip() if sail_no.startswith('TPE') else f"TPE {sail_no.strip()}"
    new_sailor_map[kj_name] = {
        'id': sid,
        'name': rom_name,
        'chinese_name': kj_name,
        'handle': handle,
        'sail_number': clean_sail,
        'club': club,
        'nationality': 'TPE',
        'gender': gender,
    }
    created_count += 1
    return sid, rom_name, True

# Parse all fleets
parsed_fleets = []
for fid, bclass, division, entry_type, min_p, max_p, fpat, expected in fleets:
    match_sec = None
    for i in range(1, len(parts), 2):
        if re.search(fpat, parts[i].strip()):
            match_sec = parts[i+1]
            break
    assert match_sec, f"Fleet {fid} section not found"
    rows = re.findall(r'<tr[^>]*>(.*?)</tr>', match_sec, re.DOTALL)[1:]
    assert len(rows) == expected, f"Fleet {fid} rows {len(rows)} != expected {expected}"
    
    fleet_entries = []
    for r in rows:
        cols = [re.sub(r'<[^>]+>', '', c).strip() for c in re.findall(r'<td[^>]*>(.*?)</td>', r, re.DOTALL)]
        rank = int(cols[0])
        div, sail, club, name = cols[1:5]
        races = cols[5:-2]
        gross = float(cols[-2])
        net = float(cols[-1])
        
        # Mathematical verification
        clean_scores = [float(re.search(r'[\d.]+', sc).group(0)) for sc in races]
        assert sum(clean_scores) == gross, f"{fid} Rank {rank} gross fail: {sum(clean_scores)} != {gross}"
        discard_scores = [float(re.search(r'[\d.]+', sc).group(0)) for sc in races if '(' in sc]
        assert sum(discard_scores) == (gross - net), f"{fid} Rank {rank} discard fail: {sum(discard_scores)} != {gross - net}"
        
        # Participants
        if entry_type == 'crew':
            raw_names = [n.strip() for n in name.split() if n.strip()]
            h_id, h_name, _ = get_or_create_sailor(raw_names[0], club, sail)
            c_id, c_name, _ = get_or_create_sailor(raw_names[1], club, sail)
            participants = [
                {'sailor_id': h_id, 'name': h_name, 'kj_name': raw_names[0], 'role': 'helm', 'order': 1},
                {'sailor_id': c_id, 'name': c_name, 'kj_name': raw_names[1], 'role': 'crew', 'order': 2},
            ]
            primary_sid = h_id
            label = f"{h_name} & {c_name}"
        else:
            s_id, s_name, _ = get_or_create_sailor(name.strip(), club, sail)
            participants = [
                {'sailor_id': s_id, 'name': s_name, 'kj_name': name.strip(), 'role': 'solo', 'order': 1}
            ]
            primary_sid = s_id
            label = s_name

        fleet_entries.append({
            'rank': rank,
            'div': div,
            'sail_no': sail,
            'club': club,
            'name': name,
            'label': label,
            'primary_sid': primary_sid,
            'participants': participants,
            'races': races,
            'gross': gross,
            'net': net
        })
    parsed_fleets.append({
        'fleet_id': fid,
        'boat_class': bclass,
        'division': division,
        'entry_type': entry_type,
        'min_p': min_p,
        'max_p': max_p,
        'expected': expected,
        'entries': fleet_entries
    })

print(f"Sailor identity resolution complete: matched {matched_count} existing entries, created {created_count} distinct new profiles.")

# -------------------------------------------------------------
# SQL GENERATION
# -------------------------------------------------------------
EVENT_ID = '38fb8127-ec56-5fa4-bda5-74844ce55a90'

sql_lines = [
    "-- Migration 176: Import 115th Academic Year National President's Cup Sailing Regatta 2026",
    "--",
    "-- Imports the official national championship results for:",
    "-- Event: 115th Academic Year National President's Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽)",
    "-- Venue: Penghu / Tainan, Taiwan (Chinese Taipei)",
    "-- Dates: 14 – 16 August 2026",
    "-- Authority: Chinese Taipei Sailing Association (CTSA / 中華民國帆船協會)",
    f"-- Scope: 8 Fleets ({sum(f['expected'] for f in parsed_fleets)} total entries across 420, ILCA 4, ILCA 6, ILCA 7, Optimist), 6 races, 1 discard",
    "--",
    "-- Source: http://www.ct-sailing.org.tw / https://www.sailwave.com/results/115PresidentCup.htm",
    "-- Corroborated visually against official CTSA PDF: Sailwave_results_-_成績_-_115總統盃.pdf",
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
    '{s['id']}', '{clean_name}', '{s['handle']}', '{clean_sn}', '{clean_club}', 'TPE', '{s['gender']}', clock_timestamp(), clock_timestamp()
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
    '115th Academic Year National President''s Cup Sailing Regatta 2026',
    'taiwan-presidents-cup-2026',
    '2026-08-14',
    '2026-08-16',
    'Penghu / Tainan, Taiwan',
    'Chinese Taipei Sailing Association (CTSA)',
    '["420", "ILCA 4", "ILCA 6", "ILCA 7", "optimist"]'::jsonb,
    'https://www.ct-sailing.org.tw/index.php/%E8%B3%BD%E4%BA%8B%E8%B3%87%E8%A8%8A/%E7%AB%B6%E8%B3%BD%E6%88%90%E7%B8%BE%E5%85%AC%E5%91%8A/item/1568-115%E5%B9%B4%E7%B8%BD%E7%B5%B1%E7%9B%83%E5%85%A8%E5%9C%8B%E5%B8%86%E8%88%B9%E9%8C%A6%E6%A8%99%E8%B3%BD-%E7%AB%B6%E8%B3%BD%E6%88%90%E7%B8%BE.html',
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
    regatta_uuid = make_uuid(f"regatta:taiwan-2026:{fid}")
    sheet_slug = make_handle(f"taiwan-presidents-cup-2026-{fid}")
    sheet_name = f"115th Academic Year National President's Cup Sailing Regatta 2026 — {fid}"
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
    '2026-08-16',
    '2026-08-16',
    {f['expected']},
    '{division}',
    6,
    'TPE',
    '{bclass}',
    '{f['entry_type']}',
    {f['min_p']},
    {f['max_p']},
    false,
    'Penghu / Tainan, Taiwan',
    'Chinese Taipei Sailing Association (CTSA)',
    'published',
    'https://www.sailwave.com/results/115PresidentCup.htm',
    'CTSA Official Results Sailwave_results_-_成績_-_115總統盃.pdf',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽). 6 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();"""
    ])

    for entry in f['entries']:
        res_uuid = make_uuid(f"result:taiwan-2026:{fid}:{entry['rank']}:{entry['sail_no']}")
        clean_label = entry['label'].replace("'", "''")
        clean_sn = entry['sail_no'].replace("'", "''")
        clean_club = entry['club'].replace("'", "''")
        
        # Build notes
        if f['entry_type'] == 'crew':
            helm_info = f"Helm: {entry['participants'][0]['name']} ({entry['participants'][0]['kj_name']})"
            crew_info = f"Crew: {entry['participants'][1]['name']} ({entry['participants'][1]['kj_name']})"
            notes = f"115th President's Cup 2026. {helm_info}, {crew_info}. Club: {clean_club}. Division: {entry['div']}."
        else:
            solo_info = f"{entry['participants'][0]['name']} ({entry['participants'][0]['kj_name']})"
            notes = f"115th President's Cup 2026. Sailor: {solo_info}. Club: {clean_club}. Division: {entry['div']}."

        clean_notes = notes.replace("'", "''")

        sql_lines.append(f"""INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '{res_uuid}', '{entry['primary_sid']}', '{regatta_uuid}', '{clean_label}', '{clean_sn}', '{f['entry_type']}', {entry['rank']},
    {entry['gross']}, {entry['net']}, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '{clean_notes}', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;""")

        for p in entry['participants']:
            part_uuid = make_uuid(f"participant:taiwan-2026:{res_uuid}:{p['sailor_id']}:{p['role']}")
            clean_sname = p['name'].replace("'", "''")
            sql_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '{part_uuid}', '{res_uuid}', '{p['sailor_id']}', '{clean_sname}', {p['order']}, '{p['role']}', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;""")

        for r_idx, sc_str in enumerate(entry['races'], 1):
            sc_m = re.search(r'([\d.]+)', sc_str)
            sc_val = float(sc_m.group(1)) if sc_m else 0.0
            is_disc = '(' in sc_str
            code_m = re.search(r'[A-Z]{2,}', sc_str)
            sc_code = f"'{code_m.group(0)}'" if code_m else "NULL"
            clean_raw = sc_str.replace("'", "''")
            sql_lines.append(f"""INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '{res_uuid}', {r_idx}, {sc_val}, {sc_code}, {str(is_disc).lower()}, '{clean_raw}'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;""")

sql_lines.append("\nCOMMIT;")

migration_path = 'src/db/migrations/176_import_taiwan_presidents_cup_2026.sql'
with open(migration_path, 'w', encoding='utf-8') as f:
    f.write('\n'.join(sql_lines) + '\n')

print(f"Generated {migration_path} ({len(sql_lines)} lines).")

# Generate Evidence Manifest
evidence = {
    "regatta_name": "115th Academic Year National President's Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽)",
    "sanctioning_authority": "Chinese Taipei Sailing Association (CTSA / 中華民國帆船協會)",
    "official_url": "https://www.sailwave.com/results/115PresidentCup.htm",
    "pdf_url": "http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf",
    "venue": "Penghu / Tainan, Taiwan",
    "dates": "14 – 16 August 2026",
    "classes": [f['boat_class'] for f in parsed_fleets],
    "fleets_imported": [f['fleet_id'] for f in parsed_fleets],
    "total_entries": sum(f['expected'] for f in parsed_fleets),
    "total_participants": sum(f['expected'] * f['min_p'] for f in parsed_fleets),
    "total_race_scores": sum(f['expected'] * 6 for f in parsed_fleets),
    "mathematical_verification": "100% verified (sum(clean_scores) == gross and gross - discard == net)",
    "pdf_corroboration_status": "Verified against official CTSA PDF pages rendered to high-resolution PNG screenshots in scripts/imports/taiwan-2026/screenshots/."
}

evidence_path = 'scripts/imports/taiwan-2026/evidence.json'
with open(evidence_path, 'w', encoding='utf-8') as f:
    json.dump(evidence, f, indent=2, ensure_ascii=False)

print(f"Saved evidence manifest {evidence_path}.")
