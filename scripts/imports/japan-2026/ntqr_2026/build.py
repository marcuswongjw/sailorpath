import json, re, uuid, hashlib

with open('scratch/db_sailors.json') as f:
    db_sailors = json.load(f)
with open('scratch/db_aliases.json') as f:
    db_aliases = json.load(f)

alias_to_sid = {a['alias_name']: a['sailor_id'] for a in db_aliases}
sid_to_name = {s['id']: s['name'] for s in db_sailors}

# Visually verified rows from scratch/ntqr_results.png
# Rank, Ent#, Sail#, Club, Name Kanji, Grade, Gender, Net, Total, [R1..R9]
verified_table = [
    (1, 30, '3351', '中央区ヨット連盟ジュニアヨットクラブ', '松永 虎汰郎', 8, 'M', 19.0, 24.0, [('(5)', 5.0, None, True), ('2', 2.0, None, False), ('1', 1.0, None, False), ('5', 5.0, None, False), ('4', 4.0, None, False), ('3', 3.0, None, False), ('1', 1.0, None, False), ('1', 1.0, None, False), ('2', 2.0, None, False)]),
    (2, 35, '3443', '湘南ジュニアヨットクラブ', '樋口 颯希', 8, 'M', 51.0, 73.0, [('10', 10.0, None, False), ('1', 1.0, None, False), ('9', 9.0, None, False), ('4', 4.0, None, False), ('(22)', 22.0, None, True), ('4', 4.0, None, False), ('3', 3.0, None, False), ('4', 4.0, None, False), ('16', 16.0, None, False)]),
    (3, 10, '3375', 'B&G兵庫ジュニア海洋クラブ', '久保田 夏実', 8, 'F', 63.0, 84.0, [('4', 4.0, None, False), ('11', 11.0, None, False), ('2', 2.0, None, False), ('(21)', 21.0, None, True), ('18', 18.0, None, False), ('5', 5.0, None, False), ('13', 13.0, None, False), ('3', 3.0, None, False), ('7', 7.0, None, False)]),
    (4, 12, '3356', 'B&G兵庫ジュニア海洋クラブ', '村中 菜々', 6, 'F', 67.0, 98.0, [('11', 11.0, None, False), ('6', 6.0, None, False), ('4', 4.0, None, False), ('19', 19.0, None, False), ('3', 3.0, None, False), ('7', 7.0, None, False), ('2', 2.0, None, False), ('(31)', 31.0, None, True), ('15', 15.0, None, False)]),
    (5, 8, '3394', '海陽海洋クラブ', '山田 晟', 5, 'M', 74.0, 95.0, [('7', 7.0, None, False), ('4', 4.0, None, False), ('(21)', 21.0, None, True), ('8', 8.0, None, False), ('11', 11.0, None, False), ('2', 2.0, None, False), ('9', 9.0, None, False), ('21', 21.0, None, False), ('12', 12.0, None, False)]),
    (6, 19, '3444', '夢の島ヨットクラブ', '中村 海翔', 7, 'M', 82.0, 112.0, [('2', 2.0, None, False), ('28', 28.0, None, False), ('10', 10.0, None, False), ('9', 9.0, None, False), ('1', 1.0, None, False), ('29', 29.0, None, False), ('(30)', 30.0, None, True), ('2', 2.0, None, False), ('1', 1.0, None, False)]),
    (7, 23, '3489', '広島セーリングスクール', '井上 はる', 8, 'F', 94.0, 128.0, [('19', 19.0, None, False), ('7', 7.0, None, False), ('13', 13.0, None, False), ('2', 2.0, None, False), ('24', 24.0, None, False), ('16', 16.0, None, False), ('(34)', 34.0, None, True), ('5', 5.0, None, False), ('8', 8.0, None, False)]),
    (8, 7, '3355', '海陽海洋クラブ', '角森 帆朱', 8, 'M', 99.0, 140.0, [('3', 3.0, None, False), ('3', 3.0, None, False), ('6', 6.0, None, False), ('(DNF 41)', 41.0, 'DNF', True), ('6', 6.0, None, False), ('32', 32.0, None, False), ('38', 38.0, None, False), ('8', 8.0, None, False), ('3', 3.0, None, False)]),
    (9, 11, '3337', 'B&G兵庫ジュニア海洋クラブ', '平野 陽也', 8, 'M', 106.0, 134.0, [('27', 27.0, None, False), ('13', 13.0, None, False), ('7', 7.0, None, False), ('3', 3.0, None, False), ('19', 19.0, None, False), ('18', 18.0, None, False), ('(28)', 28.0, None, True), ('13', 13.0, None, False), ('6', 6.0, None, False)]),
    (10, 24, '3344', '広島セーリングスクール', '竹内 海聖', 8, 'M', 107.0, 148.0, [('16', 16.0, None, False), ('18', 18.0, None, False), ('3', 3.0, None, False), ('15', 15.0, None, False), ('2', 2.0, None, False), ('9', 9.0, None, False), ('20', 20.0, None, False), ('24', 24.0, None, False), ('(DNF 41)', 41.0, 'DNF', True)]),
    (11, 2, '3446', '江の島ヨットクラブジュニア', '中田 琴海', 7, 'F', 107.1, 140.1, [('STP 5.1', 5.1, 'STP', False), ('17', 17.0, None, False), ('28', 28.0, None, False), ('13', 13.0, None, False), ('7', 7.0, None, False), ('6', 6.0, None, False), ('(33)', 33.0, None, True), ('18', 18.0, None, False), ('13', 13.0, None, False)]),
    (12, 22, '3422', '広島セーリングスクール', '宮武 大我', 8, 'M', 109.0, 144.0, [('6', 6.0, None, False), ('(35)', 35.0, None, True), ('5', 5.0, None, False), ('12', 12.0, None, False), ('15', 15.0, None, False), ('17', 17.0, None, False), ('10', 10.0, None, False), ('22', 22.0, None, False), ('22', 22.0, None, False)]),
    (13, 36, '3442', '湘南ジュニアヨットクラブ', '樋口 耀紀', 5, 'M', 113.0, 154.0, [('22', 22.0, None, False), ('12', 12.0, None, False), ('11', 11.0, None, False), ('1', 1.0, None, False), ('(RET 41)', 41.0, 'RET', True), ('10', 10.0, None, False), ('8', 8.0, None, False), ('25', 25.0, None, False), ('24', 24.0, None, False)]),
    (14, 32, '3430', 'B&G別府海洋クラブ', '笠木 蓮斗', 7, 'M', 120.0, 146.0, [('15', 15.0, None, False), ('10', 10.0, None, False), ('14', 14.0, None, False), ('11', 11.0, None, False), ('23', 23.0, None, False), ('(26)', 26.0, None, True), ('6', 6.0, None, False), ('20', 20.0, None, False), ('21', 21.0, None, False)]),
    (15, 37, '3474', '湘南ジュニアヨットクラブ', '亀田 留衣', 7, 'F', 122.0, 146.0, [('(24)', 24.0, None, True), ('14', 14.0, None, False), ('8', 8.0, None, False), ('16', 16.0, None, False), ('20', 20.0, None, False), ('14', 14.0, None, False), ('17', 17.0, None, False), ('15', 15.0, None, False), ('18', 18.0, None, False)]),
    (16, 31, '3440', 'チーム江東', '伊藤 照真', 8, 'M', 136.0, 166.0, [('18', 18.0, None, False), ('26', 26.0, None, False), ('20', 20.0, None, False), ('7', 7.0, None, False), ('29', 29.0, None, False), ('(30)', 30.0, None, True), ('12', 12.0, None, False), ('7', 7.0, None, False), ('17', 17.0, None, False)]),
    (17, 38, '3441', '博多ハイクアウツヨットクラブ', '山本 健瑚', 7, 'M', 137.0, 178.0, [('12', 12.0, None, False), ('25', 25.0, None, False), ('23', 23.0, None, False), ('(DNF 41)', 41.0, 'DNF', True), ('30', 30.0, None, False), ('8', 8.0, None, False), ('11', 11.0, None, False), ('14', 14.0, None, False), ('14', 14.0, None, False)]),
    (18, 21, '3423', '広島セーリングスクール', '登田 直', 8, 'F', 138.0, 174.0, [('13', 13.0, None, False), ('(36)', 36.0, None, True), ('12', 12.0, None, False), ('17', 17.0, None, False), ('27', 27.0, None, False), ('34', 34.0, None, False), ('7', 7.0, None, False), ('19', 19.0, None, False), ('9', 9.0, None, False)]),
    (19, 26, '3253', 'B&G高松海洋クラブ', '直井 舷太', 8, 'M', 147.0, 183.0, [('26', 26.0, None, False), ('24', 24.0, None, False), ('15', 15.0, None, False), ('24', 24.0, None, False), ('12', 12.0, None, False), ('35', 35.0, None, False), ('(36)', 36.0, None, True), ('6', 6.0, None, False), ('5', 5.0, None, False)]),
    (20, 16, '3467', '葉山町セーリング協会', '今井 晴也', 7, 'M', 149.0, 190.0, [('25', 25.0, None, False), ('29', 29.0, None, False), ('19', 19.0, None, False), ('18', 18.0, None, False), ('(UFD 41)', 41.0, 'UFD', True), ('21', 21.0, None, False), ('16', 16.0, None, False), ('17', 17.0, None, False), ('4', 4.0, None, False)]),
    (21, 3, '3288', '江の島ヨットクラブジュニア', '内田 海音', 6, 'M', 152.0, 193.0, [('28', 28.0, None, False), ('9', 9.0, None, False), ('22', 22.0, None, False), ('22', 22.0, None, False), ('9', 9.0, None, False), ('11', 11.0, None, False), ('18', 18.0, None, False), ('33', 33.0, None, False), ('(RET 41)', 41.0, 'RET', True)]),
    (22, 4, '3154', '江の島ヨットクラブジュニア', '阪間 俊仁', 5, 'M', 155.0, 196.0, [('9', 9.0, None, False), ('23', 23.0, None, False), ('16', 16.0, None, False), ('6', 6.0, None, False), ('(UFD 41)', 41.0, 'UFD', True), ('1', 1.0, None, False), ('25', 25.0, None, False), ('34', 34.0, None, False), ('DNF 41', 41.0, 'DNF', False)]),
    (23, 9, '3315', '真野浜セーリング', '吉岡 祐月', 7, 'M', 171.0, 212.0, [('14', 14.0, None, False), ('30', 30.0, None, False), ('32', 32.0, None, False), ('10', 10.0, None, False), ('28', 28.0, None, False), ('(UFD 41)', 41.0, 'UFD', True), ('5', 5.0, None, False), ('11', 11.0, None, False), ('UFD 41', 41.0, 'UFD', False)]),
    (24, 40, '3455', 'B＆G福岡ジュニアヨットクラブ', '安藤 果帆', 8, 'F', 172.0, 213.0, [('31', 31.0, None, False), ('15', 15.0, None, False), ('26', 26.0, None, False), ('(DNF 41)', 41.0, 'DNF', True), ('35', 35.0, None, False), ('15', 15.0, None, False), ('21', 21.0, None, False), ('10', 10.0, None, False), ('19', 19.0, None, False)]),
    (25, 18, '3168', '葉山町セーリング協会', '今井 創也', 5, 'M', 183.0, 224.0, [('32', 32.0, None, False), ('33', 33.0, None, False), ('34', 34.0, None, False), ('23', 23.0, None, False), ('17', 17.0, None, False), ('12', 12.0, None, False), ('4', 4.0, None, False), ('28', 28.0, None, False), ('(RET 41)', 41.0, 'RET', True)]),
    (26, 28, '3232', 'B&G高松海洋クラブ', '岩﨑 楓太', 8, 'M', 183.0, 224.0, [('29', 29.0, None, False), ('38', 38.0, None, False), ('29', 29.0, None, False), ('(DNF 41)', 41.0, 'DNF', True), ('31', 31.0, None, False), ('13', 13.0, None, False), ('23', 23.0, None, False), ('9', 9.0, None, False), ('11', 11.0, None, False)]),
    (27, 39, '3476', '博多ハイクアウツヨットクラブ', '宮﨑 心桜', 8, 'F', 188.0, 229.0, [('34', 34.0, None, False), ('21', 21.0, None, False), ('31', 31.0, None, False), ('27', 27.0, None, False), ('5', 5.0, None, False), ('36', 36.0, None, False), ('22', 22.0, None, False), ('12', 12.0, None, False), ('(DNF 41)', 41.0, 'DNF', True)]),
    (28, 29, '3488', '横浜ジュニアヨットクラブ', '石川 凛乃', 7, 'F', 192.0, 233.0, [('17', 17.0, None, False), ('32', 32.0, None, False), ('18', 18.0, None, False), ('25', 25.0, None, False), ('37', 37.0, None, False), ('20', 20.0, None, False), ('27', 27.0, None, False), ('16', 16.0, None, False), ('(DNF 41)', 41.0, 'DNF', True)]),
    (29, 6, '3211', '江の島ヨットクラブジュニア', '富岡 英恵', 6, 'F', 194.0, 235.0, [('33', 33.0, None, False), ('5', 5.0, None, False), ('24', 24.0, None, False), ('14', 14.0, None, False), ('32', 32.0, None, False), ('25', 25.0, None, False), ('(DNC 41)', 41.0, 'DNC', True), ('RET 41', 41.0, 'RET', False), ('20', 20.0, None, False)]),
    (30, 33, '3415', '福岡セーリングクラブ', '坂口 美結', 8, 'F', 200.0, 241.0, [('21', 21.0, None, False), ('40', 40.0, None, False), ('25', 25.0, None, False), ('(DNF 41)', 41.0, 'DNF', True), ('33', 33.0, None, False), ('24', 24.0, None, False), ('24', 24.0, None, False), ('23', 23.0, None, False), ('10', 10.0, None, False)]),
    (31, 1, '3425', '江の島ヨットクラブジュニア', '辰野 志奈乃', 8, 'F', 200.0, 241.0, [('23', 23.0, None, False), ('16', 16.0, None, False), ('27', 27.0, None, False), ('28', 28.0, None, False), ('13', 13.0, None, False), ('39', 39.0, None, False), ('19', 19.0, None, False), ('35', 35.0, None, False), ('(DNF 41)', 41.0, 'DNF', True)]),
    (32, 20, '3041', '夢の島ヨットクラブ', '水谷 智子', 6, 'F', 202.0, 243.0, [('38', 38.0, None, False), ('22', 22.0, None, False), ('17', 17.0, None, False), ('30', 30.0, None, False), ('8', 8.0, None, False), ('23', 23.0, None, False), ('32', 32.0, None, False), ('32', 32.0, None, False), ('(RET 41)', 41.0, 'RET', True)]),
    (33, 25, '3470', '広島セーリングスクール', '井上 豊海', 5, 'M', 207.0, 248.0, [('20', 20.0, None, False), ('39', 39.0, None, False), ('35', 35.0, None, False), ('20', 20.0, None, False), ('10', 10.0, None, False), ('27', 27.0, None, False), ('15', 15.0, None, False), ('(DNF 41)', 41.0, 'DNF', True), ('RET 41', 41.0, 'RET', False)]),
    (34, 5, '3448', '江の島ヨットクラブジュニア', '椎名 悠貴', 5, 'M', 219.0, 260.0, [('35', 35.0, None, False), ('20', 20.0, None, False), ('36', 36.0, None, False), ('(DNF 41)', 41.0, 'DNF', True), ('16', 16.0, None, False), ('31', 31.0, None, False), ('29', 29.0, None, False), ('29', 29.0, None, False), ('23', 23.0, None, False)]),
    (35, 27, '3250', 'B&G高松海洋クラブ', '城石 朋春', 8, 'M', 224.0, 265.0, [('8', 8.0, None, False), ('27', 27.0, None, False), ('38', 38.0, None, False), ('(DNF 41)', 41.0, 'DNF', True), ('26', 26.0, None, False), ('22', 22.0, None, False), ('35', 35.0, None, False), ('27', 27.0, None, False), ('DNF 41', 41.0, 'DNF', False)]),
    (36, 34, '3404', '福岡セーリングクラブ', '今村 颯人', 6, 'M', 228.0, 269.0, [('30', 30.0, None, False), ('19', 19.0, None, False), ('DNE 41', 41.0, 'DNE', False), ('26', 26.0, None, False), ('36', 36.0, None, False), ('19', 19.0, None, False), ('31', 31.0, None, False), ('26', 26.0, None, False), ('(DNF 41)', 41.0, 'DNF', True)]),
    (37, 13, '3458', '和歌山ジュニアヨットクラブ', '栗本 悠里', 7, 'M', 251.0, 292.0, [('37', 37.0, None, False), ('37', 37.0, None, False), ('33', 33.0, None, False), ('(DNF 41)', 41.0, 'DNF', True), ('25', 25.0, None, False), ('28', 28.0, None, False), ('14', 14.0, None, False), ('36', 36.0, None, False), ('DNF 41', 41.0, 'DNF', False)]),
    (38, 17, '3169', '葉山町セーリング協会', '根岸 渚沙', 6, 'F', 254.0, 295.0, [('40', 40.0, None, False), ('8', 8.0, None, False), ('30', 30.0, None, False), ('(DNF 41)', 41.0, 'DNF', True), ('34', 34.0, None, False), ('38', 38.0, None, False), ('26', 26.0, None, False), ('37', 37.0, None, False), ('DNF 41', 41.0, 'DNF', False)]),
    (39, 15, '3202', '葉山町セーリング協会', '牧野 紗奈', 7, 'F', 254.0, 295.0, [('39', 39.0, None, False), ('31', 31.0, None, False), ('39', 39.0, None, False), ('29', 29.0, None, False), ('14', 14.0, None, False), ('33', 33.0, None, False), ('39', 39.0, None, False), ('30', 30.0, None, False), ('(DNF 41)', 41.0, 'DNF', True)]),
    (40, 14, '3457', '和歌山ジュニアヨットクラブ', '堀 冬馬', 8, 'M', 281.0, 322.0, [('36', 36.0, None, False), ('34', 34.0, None, False), ('37', 37.0, None, False), ('(DNF 41)', 41.0, 'DNF', True), ('21', 21.0, None, False), ('37', 37.0, None, False), ('37', 37.0, None, False), ('38', 38.0, None, False), ('DNF 41', 41.0, 'DNF', False)])
]

parsed_rows = []
for row in verified_table:
    rank, ent, sail, club, name_kanji, grade, gender, net, gross, races = row
    
    # Verify math
    tot_calc = round(sum(r[1] for r in races), 1)
    disc_calc = round(sum(r[1] for r in races if r[3]), 1)
    net_calc = round(tot_calc - disc_calc, 1)
    
    assert tot_calc == gross, f'Rank {rank} {name_kanji}: gross {gross} != calc {tot_calc}'
    assert net_calc == net, f'Rank {rank} {name_kanji}: net {net} != calc {net_calc}'
    assert len(races) == 9, f'Rank {rank} {name_kanji}: races != 9'
    
    sid = alias_to_sid.get(name_kanji) or alias_to_sid.get(name_kanji.replace(' ', ''))
    assert sid is not None, f'Missing sailor id for {name_kanji}'
    
    # Deterministic IDs
    res_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f'ntqr-2026-res-{rank}-{sid}'))
    part_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f'ntqr-2026-part-{rank}-{sid}'))
    
    parsed_rows.append({
        'rank': rank,
        'ent': ent,
        'sail': sail,
        'club': club,
        'name_kanji': name_kanji,
        'grade': grade,
        'gender': gender,
        'gross': gross,
        'net': net,
        'sailor_id': sid,
        'sailor_name_en': sid_to_name[sid],
        'result_id': res_id,
        'participant_id': part_id,
        'races': [{'raceNumber': idx+1, 'raw': r[0], 'score': r[1], 'scoringCode': r[2], 'discarded': r[3]} for idx, r in enumerate(races)]
    })

print(f'Verified all {len(parsed_rows)} rows of NTQR 2026 successfully!')

# Generate SQL
EVENT_ID = str(uuid.uuid5(uuid.NAMESPACE_DNS, '2026-joda-national-team-final-selection-trials-hayama'))
REGATTA_ID = str(uuid.uuid5(uuid.NAMESPACE_DNS, '2026-joda-national-team-final-selection-trials-hayama-open'))

sql = []
sql.append('-- Migration 135: Import 2026 JODA National Team Final Selection Trials (Hayama)')
sql.append('-- Event: 2026年JODAナショナルチーム最終選考会')
sql.append('-- Dates: 2026-02-20 to 2026-02-23, Hayama Port, Kanagawa, Japan')
sql.append('-- Official Final PDF: https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link')
sql.append('-- Fleet: 40 boats, 9 races, 1 discard. All 40 sailors already verified in SailorPath.')
sql.append('')
sql.append('BEGIN;')
sql.append('')
sql.append('-- 1. Regatta Event')
sql.append(f'''INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '{EVENT_ID}',
    '2026 JODA National Team Final Selection Trials',
    '2026-joda-national-team-final-selection-trials-hayama',
    '2026-02-20',
    '2026-02-23',
    'Hayama Port, Kanagawa, Japan',
    'Japan Optimist Dinghy Association (JODA) & Chuo JYC',
    '["Optimist"]'::jsonb,
    false,
    true,
    '9 completed races over 3 racing days (Feb 20-22). Feb 23 reserved/concluded.',
    'Low Point System with 1 discard after 9 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;''')

sql.append('')
sql.append('-- 2. Regatta Sheet')
sql.append(f'''INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    '{REGATTA_ID}',
    '{EVENT_ID}',
    '2026 JODA National Team Final Selection Trials',
    '2026-joda-national-team-final-selection-trials-hayama',
    '2026-02-20',
    '2026-02-23',
    40,
    'Open',
    9,
    'JPN',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Hayama Port, Kanagawa, Japan',
    'Japan Optimist Dinghy Association (JODA) & Chuo JYC',
    'published',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;''')

sql.append('')
sql.append('-- 3. Regatta Results (40 competitors)')
for r in parsed_rows:
    sql.append(f'''INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '{r["result_id"]}',
    '{r["sailor_id"]}',
    '{REGATTA_ID}',
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
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;''')

sql.append('')
sql.append('-- 4. Regatta Result Participants (40 participants)')
for r in parsed_rows:
    sql.append(f'''INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '{r["participant_id"]}',
    '{r["result_id"]}',
    '{r["sailor_id"]}',
    '{r["name_kanji"]}',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;''')

sql.append('')
sql.append('-- 5. Race Results (360 individual race scores)')
for r in parsed_rows:
    for race in r['races']:
        code_str = f"'{race['scoringCode']}'" if race['scoringCode'] else "NULL"
        disc_str = "true" if race['discarded'] else "false"
        sql.append(f'''INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '{r["result_id"]}',
    {race["raceNumber"]},
    {race["score"]},
    {code_str},
    {disc_str},
    '{race["raw"]}'
);''')

sql.append('')
sql.append('-- 6. Admin Change Log')
sql.append(f'''INSERT INTO public.admin_change_log (
    actor_email, action, entity_type, entity_id, entity_label, summary, details, source
) VALUES (
    'admin@sailorpath.com',
    'results.import_official_joda_ntqr_2026',
    'regattas',
    '{REGATTA_ID}',
    '2026 JODA National Team Final Selection Trials',
    'Imported official final results from 2026 JODA National Team Final Selection Trials in Hayama (40 boats, 9 races)',
    '{{"fleetSize": 40, "races": 9, "newProfiles": 0, "existingProfiles": 40, "officialSource": "https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link"}}'::jsonb,
    'official-joda-import'
);''')

sql.append('')
sql.append('COMMIT;')

with open('src/db/migrations/135_import_2026_joda_national_team_final_selection_trials.sql', 'w', encoding='utf-8') as f:
    f.write('\n'.join(sql) + '\n')

with open('scripts/imports/japan-2026/ntqr_2026/parsed.json', 'w', encoding='utf-8') as f:
    json.dump(parsed_rows, f, indent=2, ensure_ascii=False)

print('Wrote src/db/migrations/135_import_2026_joda_national_team_final_selection_trials.sql successfully!')
