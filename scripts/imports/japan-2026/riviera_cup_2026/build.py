import json, re, uuid, pypdf, pykakasi

kks = pykakasi.kakasi()

with open('scratch/db_sailors.json') as f:
    db_sailors = json.load(f)
with open('scratch/db_aliases.json') as f:
    db_aliases = json.load(f)

alias_to_sid = {a['alias_name']: a['sailor_id'] for a in db_aliases}
sid_to_sailor = {s['id']: s for s in db_sailors}

# Custom manual overrides for foreign / special katakana names
special_names = {
    'チャリコワ エミリア': 'Emilia Chalikova',
    'オセプコヴァ ミロ': 'Miro Osepkova',
    'ウィンバーリー 康算': 'Yasukazu Wimberley',
    'ウィンバーリー 貫一': 'Kanichi Wimberley',
    '川端ダンカン あいらエリザベス': 'Aira Elizabeth Kawabata Duncan',
}

def to_hepburn(furi_family, furi_given):
    def convert_part(s):
        conv = kks.convert(s)
        rom = ''.join(c['hepburn'] for c in conv).capitalize()
        rom = rom.replace('Jou', 'Jo').replace('Shou', 'Sho').replace('Ryou', 'Ryo')
        rom = rom.replace('Kou', 'Ko').replace('Sou', 'So').replace('Tou', 'To')
        rom = rom.replace('Yuu', 'Yu').replace('Fuu', 'Fu')
        return rom
    return f"{convert_part(furi_given)} {convert_part(furi_family)}".strip()

def normalize_race_tokens(tokens):
    norm = []
    for t in tokens:
        if t == 'DNFDSQ':
            norm.extend(['DNF', 'DSQ'])
        elif len(t) == 4 and t.isdigit():
            norm.extend([t[:2], t[2:]])
        else:
            norm.append(t)
    return norm

# Load Entry list for Class A
re_a = pypdf.PdfReader('scratch/east_entry_1.pdf')
entry_a = {}
for page in re_a.pages:
    for line in page.extract_text().split('\n'):
        line = line.strip()
        m = re.match(r'^(\d+)\s+(.*?)\s+([^\d]+?)\s+([ァ-ヶー・\s]+?)\s+(\d+)\s+([男女])\s+(\d+)$', line)
        if m:
            entry_a[int(m.group(1))] = {
                'club': m.group(2).strip(),
                'name_kanji': re.sub(r'\s+', ' ', m.group(3).strip()),
                'furi': re.sub(r'\s+', ' ', m.group(4).strip()),
                'sail': m.group(5),
                'gender': 'M' if m.group(6) == '男' else 'F',
                'grade': int(m.group(7))
            }
        else:
            m_en = re.match(r'^(\d+)\s+(.*?)\s+([A-Za-z\s]+?)\s+(\d+)\s+([男女])\s+(\d+)$', line)
            if m_en:
                entry_a[int(m_en.group(1))] = {
                    'club': m_en.group(2).strip(),
                    'name_kanji': m_en.group(3).strip(),
                    'furi': m_en.group(3).strip(),
                    'sail': m_en.group(4),
                    'gender': 'M' if m_en.group(5) == '男' else 'F',
                    'grade': int(m_en.group(6))
                }

# Late entries for Class A
entry_a[86] = {'club': '三重JYYC', 'name_kanji': '松浦 瑛士', 'furi': 'マツウラ エイト', 'sail': '3322', 'gender': 'M', 'grade': 5}
entry_a[85] = {'club': '三重JYYC', 'name_kanji': '松浦 悠真', 'furi': 'マツウラ ハルマ', 'sail': '3473', 'gender': 'M', 'grade': 7}

# Load Entry list for Class B
re_b = pypdf.PdfReader('scratch/east_entry_2.pdf')
entry_b = {}
for line in re_b.pages[0].extract_text().split('\n'):
    line = line.strip()
    m = re.match(r'^(\d+)\s+(.*?)\s+([^\d]+?)\s+([ァ-ヶー・\s]+?)\s+(\d+)\s+([男女])\s+(\d+)$', line)
    if m:
        entry_b[m.group(5)] = { # keyed by sail number
            'club': m.group(2).strip(),
            'name_kanji': re.sub(r'\s+', ' ', m.group(3).strip()),
            'furi': re.sub(r'\s+', ' ', m.group(4).strip()),
            'gender': 'M' if m.group(6) == '男' else 'F',
            'grade': int(m.group(7))
        }

# 1. Parse Class A
ra = pypdf.PdfReader('scratch/2026_east_japan_opti_a.pdf')
lines_a = [l.strip() for l in ra.pages[0].extract_text().split('\n') if l.strip()]
rows_a = lines_a[2:89]
assert len(rows_a) == 87

parsed_a = []
for idx, l in enumerate(rows_a, start=1):
    m_gend = re.search(r'(\d)\s*([男女])', l)
    assert m_gend, f"Class A row {idx} missing grade/gender"
    grade = int(m_gend.group(1))
    gender = 'M' if m_gend.group(2) == '男' else 'F'
    
    left = l[:m_gend.start()].strip()
    right = l[m_gend.end():].strip()
    
    left_toks = left.split()
    ent = int(left_toks[1])
    sail = left_toks[2]
    info = entry_a[ent]
    club = info['club']
    name_kanji = info['name_kanji']
    clean = name_kanji.replace(' ', '')
    
    if idx == 1: # Rohan Maliah
        romaji_name = 'Rohan Maliah'
        sid = '21fee251-d07b-4f4b-be01-efead0178e57'
        nationality = 'HKG'
    else:
        nationality = 'JPN'
        sid = alias_to_sid.get(name_kanji) or alias_to_sid.get(clean)
        if name_kanji in special_names:
            romaji_name = special_names[name_kanji]
        else:
            furi_parts = info['furi'].split()
            if len(furi_parts) >= 2:
                romaji_name = to_hepburn(furi_parts[0], ' '.join(furi_parts[1:]))
            elif len(furi_parts) == 1:
                romaji_name = to_hepburn('', furi_parts[0])
            else:
                romaji_name = to_hepburn('', clean)
                
        if not sid:
            sid = str(uuid.uuid5(uuid.NAMESPACE_DNS, f'sailorpath.sailor.japan.opti.{clean}'))
            
    # Right tokens
    toks = right.split()
    assert int(toks[-1]) == idx
    
    resolved = False
    try:
        g = float(toks[-4])
        e = float(toks[-3])
        n = float(toks[-2])
        if abs((g - e) - n) < 0.01:
            gross, exclude, net = g, e, n
            r_toks = toks[:-4]
            resolved = True
    except:
        pass
        
    if not resolved:
        g = float(toks[-3])
        raw_combined = toks[-2]
        for split_pos in [1, 2, 3]:
            try:
                e = float(raw_combined[:split_pos])
                n = float(raw_combined[split_pos:])
                if abs((g - e) - n) < 0.01:
                    gross, exclude, net = g, e, n
                    r_toks = toks[:-3]
                    resolved = True
                    break
            except:
                pass
                
    assert resolved, f"Class A row {idx} math not resolved"
    
    r_matches = re.findall(r'([A-Z]+|\d+)', ' '.join(r_toks))
    norm = normalize_race_tokens(r_matches)
    assert len(norm) == 21, f"Row {idx} has {len(norm)} tokens"
    
    races = []
    for r_num in range(1, 8):
        fin = norm[(r_num-1)*3]
        code = norm[(r_num-1)*3 + 1]
        sc = float(norm[(r_num-1)*3 + 2])
        scoring_code = code if not code.isdigit() else (fin if not fin.isdigit() else None)
        races.append({
            'raceNumber': r_num,
            'score': sc,
            'scoringCode': scoring_code,
            'discarded': False
        })
        
    tot_calc = round(sum(r['score'] for r in races), 1)
    disc_marked = False
    for r in sorted(races, key=lambda x: -x['score']):
        if not disc_marked and abs(r['score'] - exclude) < 0.01:
            r['discarded'] = True
            disc_marked = True
            
    assert tot_calc == gross, f"Class A row {idx} gross {gross} != calc {tot_calc}"
    
    parsed_a.append({
        'rank': idx,
        'sail': sail,
        'club': club,
        'name_kanji': name_kanji,
        'name_romaji': romaji_name,
        'grade': grade,
        'gender': gender,
        'nationality': nationality,
        'gross': gross,
        'exclude': exclude,
        'net': net,
        'sailor_id': sid,
        'races': races
    })

print(f"Class A parsed and verified: {len(parsed_a)} sailors")

# 2. Parse Class B
rb = pypdf.PdfReader('scratch/2026_east_japan_opti_b.pdf')
lines_b = [l.strip() for l in rb.pages[0].extract_text().split('\n') if l.strip()]
rows_b = lines_b[3:25]
assert len(rows_b) == 22

parsed_b = []
for idx, l in enumerate(rows_b, start=1):
    toks = l.split()
    sail = toks[1]
    g_idx = -1
    for i in range(2, len(toks)):
        if toks[i] in ['男', '女']:
            g_idx = i
            break
    grade = int(toks[g_idx - 1])
    club = toks[g_idx - 2]
    name_kanji = ' '.join(toks[2:g_idx - 2])
    clean = name_kanji.replace(' ', '')
    gender = 'M' if toks[g_idx] == '男' else 'F'
    
    furi_info = entry_b.get(sail)
    if furi_info:
        furi_parts = furi_info['furi'].split()
        if len(furi_parts) >= 2:
            romaji_name = to_hepburn(furi_parts[0], ' '.join(furi_parts[1:]))
        else:
            romaji_name = to_hepburn('', furi_parts[0])
    else:
        romaji_name = to_hepburn('', clean)
        
    sid = alias_to_sid.get(name_kanji) or alias_to_sid.get(clean)
    if not sid:
        sid = str(uuid.uuid5(uuid.NAMESPACE_DNS, f'sailorpath.sailor.japan.opti.{clean}'))
        
    gross = float(toks[-4])
    net = float(toks[-2])
    exclude = round(gross - net, 1)
    
    r_toks = toks[g_idx+1:-4]
    assert len(r_toks) == 39 # 13 races * 3
    
    races = []
    for r_num in range(1, 14):
        fin = r_toks[(r_num-1)*3]
        code = r_toks[(r_num-1)*3 + 1]
        sc = float(r_toks[(r_num-1)*3 + 2])
        scoring_code = code if not code.isdigit() else (fin if not fin.isdigit() else None)
        races.append({
            'raceNumber': r_num,
            'score': sc,
            'scoringCode': scoring_code,
            'discarded': False
        })
        
    sorted_races = sorted(races, key=lambda x: -x['score'])
    for r in sorted_races[:3]:
        r['discarded'] = True
        
    disc_calc = round(sum(r['score'] for r in races if r['discarded']), 1)
    tot_calc = round(sum(r['score'] for r in races), 1)
    net_calc = round(tot_calc - disc_calc, 1)
    
    assert tot_calc == gross, f"Class B row {idx} gross {gross} != calc {tot_calc}"
    assert net_calc == net, f"Class B row {idx} net {net} != calc {net_calc}"
    
    parsed_b.append({
        'rank': idx,
        'sail': sail,
        'club': club,
        'name_kanji': name_kanji,
        'name_romaji': romaji_name,
        'grade': grade,
        'gender': gender,
        'nationality': 'JPN',
        'gross': gross,
        'exclude': exclude,
        'net': net,
        'sailor_id': sid,
        'races': races
    })

print(f"Class B parsed and verified: {len(parsed_b)} sailors")

# 3. Generate Migration 136 SQL
EVENT_ID = str(uuid.uuid5(uuid.NAMESPACE_DNS, '44th-riviera-cup-east-japan-optimist-championship-2026'))
REGATTA_A_ID = str(uuid.uuid5(uuid.NAMESPACE_DNS, '44th-riviera-cup-east-japan-optimist-championship-2026-class-a'))
REGATTA_B_ID = str(uuid.uuid5(uuid.NAMESPACE_DNS, '44th-riviera-cup-east-japan-optimist-championship-2026-class-b'))

sql = []
sql.append('-- Migration 136: Import 44th Riviera Cup East Japan Optimist Championship 2026')
sql.append('-- Event: 第44回リビエラカップ東日本オプティミスト級セーリング選手権大会')
sql.append('-- Dates: 2026-08-21 to 2026-08-23, Enoshima Yacht Harbor, Kanagawa, Japan')
sql.append('-- Class A: 87 boats, 7 races (1 discard). Class B: 22 boats, 13 races (3 discards).')
sql.append('')
sql.append('BEGIN;')
sql.append('')
sql.append('-- 1. Regatta Event')
sql.append(f'''INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '{EVENT_ID}',
    '44th Riviera Cup East Japan Optimist Championship 2026',
    '44th-riviera-cup-east-japan-optimist-championship-2026',
    '2026-08-21',
    '2026-08-23',
    'Enoshima Yacht Harbor, Kanagawa, Japan',
    'Enoshima Yacht Club Junior (EYCJ) & Kanto JODA',
    '["Optimist"]'::jsonb,
    false,
    false,
    'Class A sailed 7 races (Aug 21-23); Class B sailed 13 races (Aug 22-23).',
    'Low Point System: Class A with 1 discard after 7 races; Class B with 3 discards after 13 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;''')

sql.append('')
sql.append('-- 2. Regatta Class Sheets (Class A and Class B)')
sql.append(f'''INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    '{REGATTA_A_ID}',
    '{EVENT_ID}',
    '44th Riviera Cup East Japan Optimist Championship 2026 (Class A)',
    '44th-riviera-cup-east-japan-optimist-championship-2026-class-a',
    '2026-08-21',
    '2026-08-23',
    87,
    'Class A',
    7,
    'JPN',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Enoshima Yacht Harbor, Kanagawa, Japan',
    'Enoshima Yacht Club Junior (EYCJ) & Kanto JODA',
    'published',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;''')

sql.append(f'''INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    '{REGATTA_B_ID}',
    '{EVENT_ID}',
    '44th Riviera Cup East Japan Optimist Championship 2026 (Class B)',
    '44th-riviera-cup-east-japan-optimist-championship-2026-class-b',
    '2026-08-21',
    '2026-08-23',
    22,
    'Class B',
    13,
    'JPN',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Enoshima Yacht Harbor, Kanagawa, Japan',
    'Enoshima Yacht Club Junior (EYCJ) & Kanto JODA',
    'published',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;''')

# New sailors across A and B
all_entries = parsed_a + parsed_b
new_sailors = {}
for r in all_entries:
    sid = r['sailor_id']
    if sid not in sid_to_sailor and sid not in new_sailors:
        new_sailors[sid] = r

sql.append('')
sql.append(f'-- 3. New Sailor Profiles ({len(new_sailors)} new profiles)')
for sid, r in new_sailors.items():
    slug_name = re.sub(r'[^a-z0-9]+', '-', r['name_romaji'].lower()).strip('-')
    handle = f"opti-jpn-{slug_name}-{r['sail']}"
    sql.append(f'''INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('{sid}', '{r["name_romaji"]}', '{handle}', 'JPN {r["sail"]}', '{r["nationality"]}', '{r["gender"]}', '{r["club"]}')
ON CONFLICT (id) DO NOTHING;''')

sql.append('')
sql.append('-- 4. Sailor Aliases (Kanji names)')
for r in all_entries:
    sid = r['sailor_id']
    kanji = r['name_kanji']
    if kanji and kanji != 'Rohan Maliah':
        clean = kanji.replace(' ', '')
        sql.append(f'''INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('{sid}', '{kanji}')
ON CONFLICT (alias_name) DO NOTHING;''')
        if clean != kanji:
            sql.append(f'''INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('{sid}', '{clean}')
ON CONFLICT (alias_name) DO NOTHING;''')

# 5. Regatta Results & Participants & Race Results for Class A
sql.append('')
sql.append('-- 5. Regatta Results: Class A (87 competitors)')
for r in parsed_a:
    res_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f"east-japan-2026-a-res-{r['rank']}-{r['sailor_id']}"))
    part_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f"east-japan-2026-a-part-{r['rank']}-{r['sailor_id']}"))
    sql.append(f'''INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '{res_id}',
    '{r["sailor_id"]}',
    '{REGATTA_A_ID}',
    '{r["name_kanji"]}',
    '{r["nationality"]} {r["sail"]}',
    'individual',
    {r["rank"]},
    {r["gross"]},
    {r["net"]},
    '{r["gender"]}',
    '{r["nationality"]}',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;''')

    sql.append(f'''INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '{part_id}',
    '{res_id}',
    '{r["sailor_id"]}',
    '{r["name_kanji"]}',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;''')

    for race in r['races']:
        code_str = f"'{race['scoringCode']}'" if race['scoringCode'] else "NULL"
        disc_str = "true" if race['discarded'] else "false"
        raw_val = f"({race['score']})" if race['discarded'] else str(race['score'])
        sql.append(f'''INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '{res_id}',
    {race["raceNumber"]},
    {race["score"]},
    {code_str},
    {disc_str},
    '{raw_val}'
);''')

# 6. Regatta Results: Class B
sql.append('')
sql.append('-- 6. Regatta Results: Class B (22 competitors)')
for r in parsed_b:
    res_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f"east-japan-2026-b-res-{r['rank']}-{r['sailor_id']}"))
    part_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f"east-japan-2026-b-part-{r['rank']}-{r['sailor_id']}"))
    sql.append(f'''INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '{res_id}',
    '{r["sailor_id"]}',
    '{REGATTA_B_ID}',
    '{r["name_kanji"]}',
    'JPN {r["sail"]}',
    'individual',
    {r["rank"]},
    {r["gross"]},
    {r["net"]},
    '{r["gender"]}',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;''')

    sql.append(f'''INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '{part_id}',
    '{res_id}',
    '{r["sailor_id"]}',
    '{r["name_kanji"]}',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;''')

    for race in r['races']:
        code_str = f"'{race['scoringCode']}'" if race['scoringCode'] else "NULL"
        disc_str = "true" if race['discarded'] else "false"
        raw_val = f"({race['score']})" if race['discarded'] else str(race['score'])
        sql.append(f'''INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '{res_id}',
    {race["raceNumber"]},
    {race["score"]},
    {code_str},
    {disc_str},
    '{raw_val}'
);''')

sql.append('')
sql.append('-- 7. Admin Change Log')
sql.append(f'''INSERT INTO public.admin_change_log (
    actor_email, action, entity_type, entity_id, entity_label, summary, details, source
) VALUES (
    'admin@sailorpath.com',
    'results.import_official_east_japan_opti_2026',
    'regattas',
    '{REGATTA_A_ID}',
    '44th Riviera Cup East Japan Optimist Championship 2026',
    'Imported official final results from 44th Riviera Cup East Japan Championship (Class A: 87 boats, Class B: 22 boats)',
    '{{"fleetSizeA": 87, "racesA": 7, "fleetSizeB": 22, "racesB": 13, "newProfiles": {len(new_sailors)}, "officialSourceA": "https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link", "officialSourceB": "https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link"}}'::jsonb,
    'official-joda-east-import'
);''')

sql.append('')
sql.append('COMMIT;')

with open('src/db/migrations/136_import_2026_riviera_cup_east_japan_optimist_championship.sql', 'w', encoding='utf-8') as f:
    f.write('\n'.join(sql) + '\n')

with open('scripts/imports/japan-2026/riviera_cup_2026/parsed.json', 'w', encoding='utf-8') as f:
    json.dump({'class_a': parsed_a, 'class_b': parsed_b}, f, indent=2, ensure_ascii=False)

print(f"Successfully generated Migration 136 with {len(new_sailors)} new sailor profiles!")
