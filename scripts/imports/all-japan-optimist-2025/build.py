import json, re, uuid, hashlib, pypdf

# 1. Load PDF and parse
reader = pypdf.PdfReader('scratch/doc169417_final.pdf')
lines = [l.strip() for l in reader.pages[0].extract_text().split('\n') if l.strip()]

# Mapping of names
names_map = {
    1: ('藤田 翔伊', 'Shoi Fujita'),
    2: ('堀野 葵', 'Aoi Horino'),
    3: ('角森 帆朱', 'Hansu Tsunomori'), # Hoju Tsunomori in DB as Hansu
    4: ('三浦 太輝', 'Taiki Miura'),
    5: ('中田 琴海', 'Kotami Nakada'),
    6: ('須永 言葉', 'Kotoha Sunaga'),
    7: ('上條 正弘', 'Masahiro Kamijo'),
    8: ('樋口 颯希', 'Soki Higuchi'),
    9: ('中村 海翔', 'Kaito Nakamura'),
    10: ('川上 渚', 'Nagisa Kawakami'),
    11: ('松永 虎汰郎', 'Kotaro Matsunaga'),
    12: ('檜垣 俊忠', 'Toshitada Higaki'),
    13: ('源関 新', 'Shin Genseki'),
    14: ('亀田 留衣', 'Rui Kameda'),
    15: ('樋口 耀紀', 'Yoshiki Higuchi'),
    16: ('村中 菜々', 'Nana Muranaka'),
    17: ('清水 優太', 'Yuta Shimizu'),
    18: ('石川 凛乃', 'Rino Ishikawa'),
    19: ('吉岡 祐月', 'Yuzuki Yoshioka'),
    20: ('平野 陽也', 'Haruya Hirano'),
    21: ('山本 健瑚', 'Kengo Yamamoto'),
    22: ('村中 莉子', 'Riko Muranaka'),
    23: ('阪間 俊仁', 'Shunto Sakama'),
    24: ('登田 直', 'Nao Toda'),
    25: ('山田 晟', 'Jo Yamada'),
    26: ('久保田 夏実', 'Natsumi Kubota'),
    27: ('岩﨑 楓太', 'Futa Iwasaki'),
    28: ('坂口 美結', 'Miyu Sakaguchi'),
    29: ('牧野 紗奈', 'Sana Makino'),
    30: ('井上 はる', 'Haru Inoue'),
    31: ('直井 舷太', 'Genta Naoi'),
    32: ('今村 颯人', 'Hayato Imamura'),
    33: ('竹内 海聖', 'Kaisei Takeuchi'),
    34: ('笠木 蓮斗', 'Rento Kasagi'),
    35: ('根岸 渚沙', 'Nagisa Negishi'),
    36: ('木﨑 翔嶋', 'Shoma Kizaki'),
    37: ('兼久 宗之', 'Muneyuki Kanehisa'),
    38: ('水谷 智子', 'Tomoko Mizutani'),
    39: ('氏家 琉星', 'Ryusei Ujiie'),
    40: ('池田 晟', 'Jo Ikeda'),
    41: ('今井 堅朱朗', 'Kenjuro Imai'),
    42: ('安藤 果帆', 'Kaho Ando'),
    43: ('井上 豊海', 'Toyomi Inoue'),
    44: ('今井 創也', 'Soya Imai'),
    45: ('宮武 大我', 'Taiga Miyatake'),
    46: ('辰野 志奈乃', 'Shinano Tatsuno'),
    47: ('宮﨑 心桜', 'Koharu Miyazaki'),
    48: ('栗本 悠里', 'Yuri Kurimoto'),
    49: ('今井 晴也', 'Haruya Imai'),
    50: ('堀 冬馬', 'Toma Hori'),
    51: ('城石 朋春', 'Tomoharu Shiroishi'),
    52: ('川本 拓実', 'Takumi Kawamoto'),
    53: ('平澤 海翔', 'Kaito Hirasawa'),
    54: ('椎名 悠貴', 'Yuki Shiina'),
    55: ('内田 海音', 'Kaito Uchida'),
    56: ('伊藤 照真', 'Shoma Ito'),
    57: ('西村 泰洋', 'Yasuhiro Nishimura'),
    58: ('富岡 英恵', 'Hanae Tomioka'),
    59: ('仲山 結夏', 'Yuika Nakayama'),
    60: ('佐々木 椋平', 'Ryohei Sasaki'),
    61: ('枝 大耀', 'Taiyo Eda'),
    62: ('森田 晴翔', 'Haruto Morita'),
    63: ('廣田 穣', 'Jo Hirota'),
    64: ('平野 萌生', 'Moe Hirano'),
    65: ('中村 太晴', 'Taisei Nakamura'),
    66: ('檜垣 菜々子', 'Nanako Higaki'),
    67: ('長堀 奨', 'Sho Nagahori'),
    68: ('岩波 由夏', 'Yuka Iwanami'),
    69: ('丹波 翔叡', 'Shoei Tanba'),
    70: ('上敷領 美海', 'Minami Kamishikiryo'),
    71: ('永見 波奈', 'Hana Nagami'),
    72: ('田淵 勇帆', 'Yuho Tabuchi'),
    73: ('内田 有希', 'Yuki Uchida'),
    74: ('守屋 由慧', 'Yue Moriya'),
    75: ('今村 海晴', 'Kaisei Imamura'),
    76: ('高橋 武尊', 'Takeru Takahashi'),
    77: ('中山 うた', 'Uta Nakayama'),
    78: ('大森 康太', 'Kota Omori'),
    79: ('秋村 柚月', 'Yuzuki Akimura'),
    80: ('江口 瑠海', 'Ruka Eguchi'),
    81: ('宇多 泰誠', 'Taisei Uda'),
}

# DB Existing Sailors
db_existing = {
    '3355': ('6471b3cc-1310-54f1-945c-c06115d54996', 'Hansu Tsunomori', 'hansu-tsunomori-euro26-6471b3'),
    '3447': ('1b5e6155-88c2-4e32-b173-24e6bfa54c1c', 'Taiki Miura', 'taiki-miura-26cufxv'),
    '3440': ('28032f7a-8535-431c-a220-cc5a529ebd38', 'Masahiro Kamijo', 'asian-jpn-masahiro-k-b3b588'),
    '3443': ('eba0deb0-10e4-4d3e-a5e5-5e3fa6287288', 'Soki Higuchi', 'asian-jpn-soki-higuc-fb3822'),
    '3389': ('89eed0ba-4c8d-49dc-a03e-6624a364f93c', 'Kaito Nakamura', 'asian-jpn-kaito-naka-a602cf'),
    '3462': ('5890ff0d-ad50-4352-84a0-29135867289a', 'Nagisa Kawakami', 'asian-jpn-nagisa-kaw-f1a02d'),
    '3351': ('2780f0eb-ea28-44e6-ba67-22a35fb9913d', 'Kotaro Matsunaga', 'asian-jpn-kotaro-mat-4fa65f'),
    '3178': ('5f6d71a5-1dc3-599c-b9be-377150d4dd3a', 'Nana Muranaka', 'nana-muranaka-worlds26'),
    '3337': ('b8f8b747-639d-5920-adfe-ec84e34cc40b', 'Haruya Hirano', 'haruya-hirano-euro26-b8f8b7'),
    '3356': ('3d7d17df-71ad-4195-b41d-abdebbed13bc', 'Riko Muranaka', 'asian-jpn-riko-muran-26f981'),
    '3423': ('18e73ee3-3792-59f9-aa32-649ca6ca325d', 'Nao Toda', 'nao-toda-euro26-18e73e'),
    '3394': ('1ac9dc89-783e-56c9-8c8d-785a5e10cccc', 'Jo Yamada', 'jo-yamada-worlds26'),
    '3375': ('0c3ea04a-905c-45f1-abb7-a4a917e7da14', 'Natsumi Kubota', 'asian-jpn-natsumi-ku-112120'),
    '3253': ('3d6c3a59-ea5b-5d31-a9eb-c4db5a510958', 'Genta Naoi', 'genta-naoi-euro26-3d6c3a'),
    '3411': ('8e182f64-ea94-4254-9ae3-b4611981dc3b', 'Kaito Hirasawa', 'asian-jpn-kaito-hira-c15fa2')
}

parsed_rows = []

for l in lines:
    parts = l.split()
    if not (len(parts) >= 15 and parts[0].isdigit() and parts[1].isdigit()):
        continue
    rank = int(parts[0])
    sail = parts[1]
    gender_idx = -1
    for i in range(3, min(8, len(parts))):
        if parts[i] in ['M', 'F']:
            gender_idx = i
            break
            
    tokens = parts[2:gender_idx]
    surname = tokens[-2]
    given = tokens[-1]
    club = ' '.join(tokens[:-2])
    gender = parts[gender_idx]
    grade = parts[gender_idx+1]
    
    score_tokens = parts[gender_idx+2:]
    rank_idx = -1
    for idx in range(len(score_tokens)-1, -1, -1):
        if score_tokens[idx] == str(rank):
            rank_idx = idx
            break
            
    gross = float(score_tokens[rank_idx - 3])
    discard = float(score_tokens[rank_idx - 2])
    net = float(score_tokens[rank_idx - 1])
    race_tokens = score_tokens[:rank_idx - 3]
    
    # 7 races
    races = []
    discard_applied = False
    
    # We find the worst race index to mark discarded
    race_scores = [float(race_tokens[r*3 + 2]) for r in range(7)]
    worst_score = max(race_scores)
    
    for r in range(7):
        pos = race_tokens[r*3]
        status = race_tokens[r*3 + 1]
        pts = float(race_tokens[r*3 + 2])
        is_disc = False
        if pts == worst_score and not discard_applied:
            is_disc = True
            discard_applied = True
        
        # Determine scoring code
        scoring_code = None
        if status in ['DNC', 'DNF', 'DNS', 'DSQ', 'UFD', 'BFD', 'RET', 'STP', 'RDG', 'DNE', 'DPI']:
            scoring_code = status
        elif not status.isdigit():
            scoring_code = status
            
        races.append({
            'raceNumber': r + 1,
            'finish': pos,
            'status': status,
            'scoringCode': scoring_code,
            'score': pts,
            'discarded': is_disc,
            'raw': f'({pts})' if is_disc else str(pts)
        })
        
    kanji_name, romaji_name = names_map[rank]
    
    # Sailor ID & Handle
    if sail in db_existing:
        sailor_id, profile_name, handle = db_existing[sail]
        is_new = False
    else:
        # Deterministic UUID for idempotent migration
        sailor_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f'sailorpath.sailor.japan.opti.{sail}.{romaji_name}'))
        # Handle
        slug_base = re.sub(r'[^a-z0-9]+', '-', romaji_name.lower()).strip('-')
        handle = f'opti-jpn-{slug_base}-{sail}'
        profile_name = romaji_name
        is_new = True
        
    result_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f'sailorpath.result.alljapan2025.{sailor_id}'))
    participant_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f'sailorpath.participant.alljapan2025.{sailor_id}'))
    
    parsed_rows.append({
        'rank': rank,
        'sail': sail,
        'club': club,
        'name_kanji': kanji_name,
        'name_romaji': romaji_name,
        'gender': gender,
        'grade': grade,
        'gross': gross,
        'discard': discard,
        'net': net,
        'races': races,
        'sailor_id': sailor_id,
        'handle': handle,
        'profile_name': profile_name,
        'is_new': is_new,
        'result_id': result_id,
        'participant_id': participant_id
    })

print(f'Processed {len(parsed_rows)} rows.')
new_count = sum(1 for r in parsed_rows if r['is_new'])
print(f'New profiles: {new_count}, Existing profiles: {len(parsed_rows) - new_count}')

# Write out JSON
with open('scripts/imports/all-japan-optimist-2025/parsed_results.json', 'w', encoding='utf-8') as f:
    json.dump(parsed_rows, f, ensure_ascii=False, indent=2)

# Now build SQL migration
EVENT_ID = '3a7c6f81-9b14-5d42-8712-4015cbb81925'
REGATTA_ID = 'b72d1f40-7e39-56c8-9a21-82d3e4071592'

sql_lines = []
sql_lines.append('-- Migration 134: Import 57th All Japan Optimist Sailing Championship 2025')
sql_lines.append('-- Event: 第57回全日本オプティミスト級セーリング選手権大会（兼 2026年JODAナショナルチーム第1次選考会）')
sql_lines.append('-- Official Final PDF: https://www.racingrulesofsailing.org/documents/169417')
sql_lines.append('-- Date: 2025-11-20 to 2025-11-24, Nishinomiya, Japan. Fleet: 81 boats, 7 races.')
sql_lines.append('')
sql_lines.append('BEGIN;')
sql_lines.append('')

# 1. Regatta Event
sql_lines.append('-- 1. Regatta Event')
sql_lines.append(f'''INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, nor_url, schedule_summary, scoring_rules
) VALUES (
    '{EVENT_ID}',
    '57th All Japan Optimist Sailing Championship 2025',
    '57th-all-japan-optimist-sailing-championship-2025',
    '2025-11-20',
    '2025-11-24',
    'Shin-Nishinomiya Yacht Harbor, Hyogo, Japan',
    'Japan Optimist Dinghy Association (JODA)',
    '["Optimist"]'::jsonb,
    false,
    true,
    'https://www.racingrulesofsailing.org/documents/167338',
    '7 completed races over 4 scheduled days. Final day abandoned due to light winds; standings through Day 3 confirmed as final.',
    'Low Point System with 1 discard after 7 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
''')

# 2. Regatta Class Sheet
sql_lines.append('-- 2. Regatta Class Sheet')
sql_lines.append(f'''INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    '{REGATTA_ID}',
    '{EVENT_ID}',
    '57th All Japan Optimist Sailing Championship 2025',
    '57th-all-japan-optimist-sailing-championship-2025',
    '2025-11-20',
    '2025-11-24',
    81,
    'Open',
    7,
    'JPN',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Shin-Nishinomiya Yacht Harbor, Hyogo, Japan',
    'Japan Optimist Dinghy Association (JODA)',
    'published',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;
''')

# 3. Insert New Sailors
sql_lines.append('-- 3. New Sailor Profiles (66 sailors)')
for r in parsed_rows:
    if r['is_new']:
        sql_lines.append(f'''INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('{r["sailor_id"]}', '{r["profile_name"].replace("'", "''")}', '{r["handle"]}', 'JPN {r["sail"]}', 'JPN', '{r["gender"]}', '{r["club"].replace("'", "''")}')
ON CONFLICT (id) DO NOTHING;''')

# 4. Insert Aliases for All 81 Sailors
sql_lines.append('')
sql_lines.append('-- 4. Sailor Aliases (Original Kanji names and variants)')
for r in parsed_rows:
    sid = r['sailor_id']
    kanji_space = r['name_kanji'] # e.g. '藤田 翔伊'
    kanji_nospace = kanji_space.replace(' ', '') # e.g. '藤田翔伊'
    
    # insert alias with space
    sql_lines.append(f'''INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('{sid}', '{kanji_space.replace("'", "''")}')
ON CONFLICT (alias_name) DO NOTHING;''')
    
    if kanji_nospace != kanji_space:
        sql_lines.append(f'''INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('{sid}', '{kanji_nospace.replace("'", "''")}')
ON CONFLICT (alias_name) DO NOTHING;''')

# 5. Insert Regatta Results
sql_lines.append('')
sql_lines.append('-- 5. Regatta Results (81 individual rows)')
for r in parsed_rows:
    sql_lines.append(f'''INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '{r["result_id"]}',
    '{r["sailor_id"]}',
    '{REGATTA_ID}',
    '{r["name_kanji"].replace("'", "''")}',
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
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;''')

# 6. Insert Participants
sql_lines.append('')
sql_lines.append('-- 6. Regatta Result Participants')
for r in parsed_rows:
    sql_lines.append(f'''INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '{r["participant_id"]}',
    '{r["result_id"]}',
    '{r["sailor_id"]}',
    '{r["name_kanji"].replace("'", "''")}',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;''')

# 7. Insert Race Results (567 individual race scores)
sql_lines.append('')
sql_lines.append('-- 7. Individual Race Scores (567 race results)')
for r in parsed_rows:
    for race in r['races']:
        code_val = f"'{race['scoringCode']}'" if race['scoringCode'] else "NULL"
        discard_val = "true" if race['discarded'] else "false"
        sql_lines.append(f'''INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '{r["result_id"]}',
    {race["raceNumber"]},
    {race["score"]},
    {code_val},
    {discard_val},
    '{race["raw"]}'
);''')

# 8. Record in Admin Change Log
sql_lines.append('')
sql_lines.append('-- 8. Record in Admin Change Log')
sql_lines.append(f'''INSERT INTO public.admin_change_log (
    actor_email, action, entity_type, entity_id, entity_label, summary, details, source
) VALUES (
    'admin@sailorpath.com',
    'results.import_official_all_japan_optimist_2025',
    'regattas',
    '{REGATTA_ID}',
    '57th All Japan Optimist Sailing Championship 2025',
    'Imported official final results from 57th All Japan Optimist Championship (81 boats, 7 races)',
    '{{"fleetSize": 81, "races": 7, "newProfiles": {new_count}, "existingProfiles": {len(parsed_rows) - new_count}, "officialSource": "https://www.racingrulesofsailing.org/documents/169417"}}'::jsonb,
    'official-joda-rrs-import'
);''')

sql_lines.append('')
sql_lines.append('COMMIT;')

with open('scripts/imports/all-japan-optimist-2025/import.sql', 'w', encoding='utf-8') as f:
    f.write('\n'.join(sql_lines) + '\n')

print('Wrote scripts/imports/all-japan-optimist-2025/import.sql successfully.')
