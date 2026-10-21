import json, re, uuid, pypdf, pykakasi

kks = pykakasi.kakasi()

with open('scratch/db_sailors.json') as f:
    db_sailors = json.load(f)
with open('scratch/db_aliases.json') as f:
    db_aliases = json.load(f)

# Also include new sailors from Migration 136
try:
    with open('scripts/imports/japan-2026/riviera_cup_2026/parsed.json') as f:
        m136_data = json.load(f)
        for r in m136_data['class_a'] + m136_data['class_b']:
            clean = r['name_kanji'].replace(' ', '')
            db_aliases.append({'sailor_id': r['sailor_id'], 'alias_name': r['name_kanji']})
            db_aliases.append({'sailor_id': r['sailor_id'], 'alias_name': clean})
            db_sailors.append({'id': r['sailor_id'], 'name': r['name_romaji'], 'nationality': r['nationality']})
except Exception as e:
    print('Note: m136 load:', e)

def normalize_kanji(s):
    s = s.replace(' ', '').replace('\u3000', '')
    s = s.replace('﨑', '崎').replace('髙', '高').replace('嶋', '島')
    s = s.replace('德', '徳').replace('廣', '広').replace('邊', '辺').replace('邉', '辺')
    s = s.replace('齋', '斎').replace('齊', '斎')
    return s

alias_to_sid = {a['alias_name']: a['sailor_id'] for a in db_aliases}
norm_alias_to_sid = {normalize_kanji(a['alias_name']): a['sailor_id'] for a in db_aliases}
sid_to_sailor = {s['id']: s for s in db_sailors}

def to_hepburn(furi_family, furi_given):
    def convert_part(s):
        conv = kks.convert(s)
        rom = ''.join(c['hepburn'] for c in conv).capitalize()
        rom = rom.replace('Jou', 'Jo').replace('Shou', 'Sho').replace('Ryou', 'Ryo')
        rom = rom.replace('Kou', 'Ko').replace('Sou', 'So').replace('Tou', 'To')
        rom = rom.replace('Yuu', 'Yu').replace('Fuu', 'Fu')
        return rom
    return f"{convert_part(furi_given)} {convert_part(furi_family)}".strip()

def parse_west_fleet(pdf_path, expected_count, fleet_code):
    r = pypdf.PdfReader(pdf_path)
    lines = [l.strip() for l in r.pages[0].extract_text().split('\n') if l.strip()]
    rows = lines[2:2+expected_count]
    assert len(rows) == expected_count, f'Expected {expected_count}, got {len(rows)}'
    
    parsed = []
    for idx, l in enumerate(rows, start=1):
        m = re.search(r'(\d)\s*([男女])', l)
        assert m, f'Row {idx} missing grade/gender in {l}'
        grade = int(m.group(1))
        gender = 'M' if m.group(2) == '男' else 'F'
        
        left = l[:m.start()].strip()
        right = l[m.end():].strip()
        
        left_toks = left.split()
        rank = int(left_toks[0])
        ent = int(left_toks[1])
        sail = left_toks[2]
        club = left_toks[3]
        furi_given = left_toks[-1]
        furi_family = left_toks[-2]
        name_kanji = ' '.join(left_toks[4:-2])
        clean = name_kanji.replace(' ', '')
        norm = normalize_kanji(clean)
        
        right_toks = right.split()
        assert len(right_toks) == 25
        final_rank = int(right_toks[-1])
        net = float(right_toks[-2])
        exclude = float(right_toks[-3])
        gross = float(right_toks[-4])
        
        assert rank == idx
        assert final_rank == idx
        
        # 7 races
        races = []
        scores = []
        for r_num in range(1, 8):
            fin = right_toks[(r_num-1)*3]
            code = right_toks[(r_num-1)*3 + 1]
            sc = float(right_toks[(r_num-1)*3 + 2])
            scoring_code = code if not code.isdigit() else (fin if not fin.isdigit() else None)
            scores.append(sc)
            races.append({
                'raceNumber': r_num,
                'score': sc,
                'scoringCode': scoring_code,
                'discarded': False
            })
            
        tot_calc = round(sum(scores), 1)
        disc_calc = round(max(scores), 1)
        net_calc = round(tot_calc - disc_calc, 1)
        
        assert tot_calc == gross, f'Row {idx} gross {gross} != {tot_calc}'
        assert disc_calc == exclude, f'Row {idx} exclude {exclude} != {disc_calc}'
        assert net_calc == net, f'Row {idx} net {net} != {net_calc}'
        
        # Mark discard
        disc_marked = False
        for race in sorted(races, key=lambda x: -x['score']):
            if not disc_marked and abs(race['score'] - exclude) < 0.01:
                race['discarded'] = True
                disc_marked = True
                
        # Sailor matching with normalization
        sid = alias_to_sid.get(name_kanji) or alias_to_sid.get(clean) or norm_alias_to_sid.get(norm)
        romaji_name = to_hepburn(furi_family, furi_given)
        if not sid:
            sid = str(uuid.uuid5(uuid.NAMESPACE_DNS, f'sailorpath.sailor.japan.opti.{norm}'))
            
        parsed.append({
            'rank': idx,
            'ent': ent,
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
        
    return parsed

parsed_a = parse_west_fleet('scratch/2026_west_japan_opti_a.pdf', 64, 'a')
parsed_b = parse_west_fleet('scratch/2026_west_japan_opti_b.pdf', 30, 'b')
print(f'West Japan Class A: {len(parsed_a)} sailors')
print(f'West Japan Class B: {len(parsed_b)} sailors')

EVENT_ID = str(uuid.uuid5(uuid.NAMESPACE_DNS, '49th-west-japan-optimist-championship-2026'))
REGATTA_A_ID = str(uuid.uuid5(uuid.NAMESPACE_DNS, '49th-west-japan-optimist-championship-2026-class-a'))
REGATTA_B_ID = str(uuid.uuid5(uuid.NAMESPACE_DNS, '49th-west-japan-optimist-championship-2026-class-b'))

sql = []
sql.append('-- Migration 137: Import 49th West Japan Optimist Championship 2026')
sql.append('-- Event: 第49回西日本オプティミスト級セーリング選手権大会')
sql.append('-- Dates: 2026-07-31 to 2026-08-02, Fukuoka City Yacht Harbor (Odo), Fukuoka, Japan')
sql.append('-- Class A: 64 boats, 7 races (1 discard). Class B: 30 boats, 7 races (1 discard).')
sql.append('')
sql.append('BEGIN;')
sql.append('')
sql.append('-- 1. Regatta Event')
sql.append(f'''INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '{EVENT_ID}',
    '49th West Japan Optimist Championship 2026',
    '49th-west-japan-optimist-championship-2026',
    '2026-07-31',
    '2026-08-02',
    'Fukuoka City Yacht Harbor (Odo), Fukuoka, Japan',
    'West Japan JODA & Fukuoka Sailing Club',
    '["Optimist"]'::jsonb,
    false,
    false,
    '7 completed races over 3 racing days (July 31 - August 2, 2026).',
    'Low Point System with 1 discard after 7 races.'
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
    '49th West Japan Optimist Championship 2026 (Class A)',
    '49th-west-japan-optimist-championship-2026-class-a',
    '2026-07-31',
    '2026-08-02',
    64,
    'Class A',
    7,
    'JPN',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Fukuoka City Yacht Harbor (Odo), Fukuoka, Japan',
    'West Japan JODA & Fukuoka Sailing Club',
    'published',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績'
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
    '49th West Japan Optimist Championship 2026 (Class B)',
    '49th-west-japan-optimist-championship-2026-class-b',
    '2026-07-31',
    '2026-08-02',
    30,
    'Class B',
    7,
    'JPN',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Fukuoka City Yacht Harbor (Odo), Fukuoka, Japan',
    'West Japan JODA & Fukuoka Sailing Club',
    'published',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績'
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
    clean = kanji.replace(' ', '')
    sql.append(f'''INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('{sid}', '{kanji}')
ON CONFLICT (alias_name) DO NOTHING;''')
    if clean != kanji:
        sql.append(f'''INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('{sid}', '{clean}')
ON CONFLICT (alias_name) DO NOTHING;''')

# 5. Regatta Results: Class A
sql.append('')
sql.append('-- 5. Regatta Results: Class A (64 competitors)')
for r in parsed_a:
    res_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f"west-japan-2026-a-res-{r['rank']}-{r['sailor_id']}"))
    part_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f"west-japan-2026-a-part-{r['rank']}-{r['sailor_id']}"))
    sql.append(f'''INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '{res_id}',
    '{r["sailor_id"]}',
    '{REGATTA_A_ID}',
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
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
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
sql.append('-- 6. Regatta Results: Class B (30 competitors)')
for r in parsed_b:
    res_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f"west-japan-2026-b-res-{r['rank']}-{r['sailor_id']}"))
    part_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f"west-japan-2026-b-part-{r['rank']}-{r['sailor_id']}"))
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
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
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
    'results.import_official_west_japan_opti_2026',
    'regattas',
    '{REGATTA_A_ID}',
    '49th West Japan Optimist Championship 2026',
    'Imported official final results from 49th West Japan Championship (Class A: 64 boats, Class B: 30 boats)',
    '{{"fleetSizeA": 64, "racesA": 7, "fleetSizeB": 30, "racesB": 7, "newProfiles": {len(new_sailors)}, "officialSourceA": "https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link", "officialSourceB": "https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link"}}'::jsonb,
    'official-joda-west-import'
);''')

sql.append('')
sql.append('COMMIT;')

with open('src/db/migrations/137_import_2026_west_japan_optimist_championship.sql', 'w', encoding='utf-8') as f:
    f.write('\n'.join(sql) + '\n')

with open('scripts/imports/japan-2026/west_japan_2026/parsed.json', 'w', encoding='utf-8') as f:
    json.dump({'class_a': parsed_a, 'class_b': parsed_b}, f, indent=2, ensure_ascii=False)

print(f"Successfully generated Migration 137 with {len(new_sailors)} new sailor profiles!")
