import copy, json, re, uuid
from pathlib import Path

ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[2]
profiles = json.loads((ROOT / 'profiles-reviewed.json').read_text())
fleets = json.loads((ROOT / 'normalized.json').read_text())
uid = lambda key: str(uuid.uuid5(uuid.NAMESPACE_URL, 'sailorpath:yangon2026:' + key))
norm = lambda name: re.sub('[^a-z0-9]', '', name.lower())
by_name = {norm(p['name']): p for p in profiles}
# Reviewed spelling variants supported by the paired source tables and/or same sail.
aliases = {
    'Eaint Chue Zay Yar': ('Eaint Chue Zayar', 'Minor transliteration/spacing variant; unique full-name candidate.'),
    'Kaung Khant Ko': ('Kaung Khant Khant Ko', 'Shortened repeated name; MYA382 agrees with existing profile.'),
    'Shoon Lae Khin': ('Shoom Lai Khin', 'Minor transliteration variant; MYA412 agrees.'),
    'Sharman Aye': ('Sherman', 'Paired source Sherman Aye, same MYA380; existing Sherman MYA380.'),
    'Aarman Aye': ('Arman Aye', 'Minor spelling variant; MYA399 agrees.'),
    'Gone Yee Zaw': ('Gon Yee Zaw', 'Paired requested source Gon Yee Zaw with same MYA383.'),
    'Hnin Zar Li': ('Hnin Zar Lei', 'Paired requested source Hnin Zar Lei with same MYA331.'),
    'Lin Thant Naung': ('Lin Thet Naung', 'Paired requested source Lin Thet Naung with same MYA27.'),
    'Sherman Aye': ('Sherman', 'Same MYA380; paired requested source Sharman Aye corroborates source name.'),
    'May Moe Sett': ('May Moe Set', 'Minor spelling variant; MYA392 agrees.'),
}
held_names = {
    'Thurain Lin': 'Possible Thurein Lin; current number differs and transliteration is unconfirmed.',
    'Thuyein Lin': 'Possible Thurein Lin; current number differs and transliteration is unconfirmed.',
    'Thein Thuyein Myint': 'Possible Thein Thurain Myint; source has no sail number and existing nationality conflicts.',
    'Suu Labb Lin Tun': 'Possible Su Latt Lin Tun; no source sail number to corroborate variant.',
    'Lucas': 'Source nickname only; several existing Lucas profiles; no corroborated identity.',
    'Myat Toe Khant': 'Existing Khant Khant also uses MYA400; name relationship unconfirmed.',
}
configs = [
    ('yangon-sailing-club-combined-fleet-championships-2026', 'Yangon Sailing Club Combined Fleet Championships 2026', '2026-09-19', '2026-09-20', ['Optimist']),
    ('olympic-day-movement-regatta-2026', 'Olympic Day Movement Regatta 2026', '2026-06-20', '2026-06-21', ['ILCA 4', 'Optimist']),
]
new_profiles = {}
manifests = []
all_pending = []
for fleet in fleets:
    config = configs[0 if fleet['event'] == 'YSC CFC 2026' else 1]
    key, name, start, end, classes = config
    boat = fleet['boatClass']
    slug = key + '-' + boat.lower().replace(' ', '')
    good, pending = [], []
    for original in fleet['rows']:
        row = copy.deepcopy(original)
        row['sourceDiscrepancyAccepted'] = not all(row['validation'].values())
        if row['name'] in held_names:
            pending.append(dict(row, reason=held_names[row['name']]))
            continue
        target, basis = {norm(k): v for k, v in aliases.items()}.get(norm(row['name']), (row['name'], 'Unique exact normalized source name; existing profile unchanged.'))
        profile = by_name.get(norm(target))
        # Nicknames without an existing plausible candidate retain their source name,
        # historic sail and an event-specific handle; no full name or demographics invented.
        new_name = 'Kenzo Phyo' if row['name'] == 'Kanzo' else target
        if profile is None:
            n = norm(new_name)
            if n not in new_profiles:
                sid = uid('sailor:' + n)
                new_profiles[n] = dict(id=sid, name=new_name, handle=re.sub('[^a-z0-9]+', '-', new_name.lower()).strip('-') + '-ysc26-' + sid[:6], sailNumber=row['sailOrBoardNumber'] or '', sailNumberIlca4=None, club=row['club'] or 'Official regatta entry', nationality=None, gender=None)
            profile = new_profiles[n]
            basis = 'No existing exact or plausible name candidate in reviewed inventory; source identity retained, no demographics inferred.'
            if row['name'] == 'Kanzo':
                basis = 'Requested Olympic Day source Kenzo Phyo and CFC Kanzo share MYA417; paired-source alias, no existing profile candidate.'
        row.update(sailorId=profile['id'], identityBasis=basis, resultId=uid('result:' + slug + ':' + str(row['rank']) + ':' + norm(row['name'])), gender=None, nationality=None, officialBirthYear=None)
        row['participants'] = [dict(id=uid('participant:' + row['resultId']), sailorId=profile['id'], sourceName=row['name'], displayOrder=1, role='solo')]
        row['evidenceNotes'] = f"Source explicitly provisional: {fleet['revision']}. Event dates {start}–{end} assumed at user's instruction on 2026-10-30, not independently verified. No official final PDF found; HTML-only review. Club: {row['club'] or 'not supplied'}. Historic sail: {row['sailOrBoardNumber'] or 'not supplied'}. {basis} Code-only penalty points use Appendix A fleet size + 1, corroborated by gross/net reconciliation; original raw cells retained."
        if row['sourceDiscrepancyAccepted']:
            row['evidenceNotes'] = row['evidenceNotes'].replace('corroborated by gross/net reconciliation', 'tentative; source does not give numeric penalty points and totals do not fully reconcile')
            row['evidenceNotes'] += f" User explicitly instructed on 2026-10-30 to follow the results sheet despite discrepancies. Published total/net {row['grossScore']}/{row['nettScore']} retained unchanged; calculated race sum/net {sum(r['score'] for r in row['races'])}/{sum(r['score'] for r in row['races'] if not r['discarded'])}. No correction inferred; remains pending_review."
        good.append(row)
    summary = f"PROVISIONAL DRAFT. Dates {start}–{end} assumed at user's instruction; not independently verified. No official final-results PDF located. {len(good)} of {fleet['entries']} entries imported; {len(pending)} held for identity review. Published scores and totals retained at user's instruction, including {sum(r['sourceDiscrepancyAccepted'] for r in good)} unreconciled rows. 11 races; 2 discards; no Singapore ranking credit."
    m = dict(batch='yangon-2026-2026-10-30', event=dict(id=uid('event:' + key), slug=key, name=name, startDate=start, endDate=end, venue='Yangon Sailing Club, Yangon, Myanmar', organizer='Yangon Sailing Club', classes=classes), sheet=dict(id=uid('sheet:' + slug), slug=slug, name=name + ' — ' + boat, boatClass=boat, division='Open', raceCount=11, totalFleetSize=fleet['entries'], entryType='individual', minParticipants=1, maxParticipants=1, status='draft'), officialSource=dict(url=fleet['url'], title=fleet['event'] + ' — ' + boat + ' provisional results', type='url', provisional=True, publicationStatus='provisional', visuallyReviewed=False, pdfSearch=json.loads((ROOT / 'evidence.json').read_text())['pdfCorroboration'], datesAssumedByUser=True, sourceRevision=fleet['revision']), results=good, importedEntryCount=len(good), deferredEntryCount=len(pending), publicSummary=summary, pendingEntries=pending)
    ids = {r['sailorId'] for r in good}
    m['profilePreflight'] = [p for p in profiles if p['id'] in ids]
    m['newProfiles'] = [p for p in new_profiles.values() if p['id'] in ids]
    m['identityReview'] = dict(method='Exact normalized names and explicitly reviewed paired-source spelling variants. Unconfirmed candidates deferred; existing profiles unchanged.')
    for row in good:
        assert len(row['races']) == 11 and row['validation']['discards']
        assert row['sourceDiscrepancyAccepted'] or all(row['validation'].values())
    assert len(ids) == len(good)
    (ROOT / (slug + '.json')).write_text(json.dumps(m, indent=2))
    template = (REPO / 'scripts/imports/sail-result-2026/transaction-template.sql').read_text()
    template = template.replace('results.import_official_sailresult2026', 'results.import_provisional_yangon2026').replace("'published'", "'draft'").replace("'THA'", "'MYA'")
    template = template.replace("'verified'", "'pending_review'").replace("m#>>'{officialSource,title}',now(),m->>'publicSummary'", "m#>>'{officialSource,title}',null,m->>'publicSummary'")
    template = template.replace("r->>'evidenceNotes','pending_review',now()", "r->>'evidenceNotes','pending_review',null")
    template = template.replace("'Official class results imported. See each fleet sheet for publication status and pending identity reviews.'", "m->>'publicSummary'")
    template = template.replace('Imported reviewed 2026 official race scores, discards, penalties and evidence. Ambiguous identities deferred per user instruction; existing profiles unchanged.', 'Imported provisional Yangon results as drafts. Dates assumed at user instruction; no final PDF found. Inconsistent scores and uncertain identities held; existing profiles unchanged.')
    # Missing ILCA sail numbers remain NULL; compare NULL-safely during verification.
    template = template.replace("entry_sail_number=r->>'sailOrBoardNumber'", "entry_sail_number is not distinct from r->>'sailOrBoardNumber'")
    template = template.replace("if not exists(select 1 from regatta_race_results where regatta_result_id=rid group by", "if not coalesce((r->>'sourceDiscrepancyAccepted')::boolean,false) and not exists(select 1 from regatta_race_results where regatta_result_id=rid group by")
    template = template.replace('Inconsistent scores and uncertain identities held', 'Published discrepancies preserved at user instruction; uncertain identities held')
    (ROOT / (slug + '.sql')).write_text(template.replace('__MANIFEST__', json.dumps(m, separators=(',', ':'))))
    manifests.append(dict(file=slug + '.sql', id=m['sheet']['id'], event=name, boatClass=boat, imported=len(good), held=len(pending), scores=len(good)*11))
    all_pending.extend(dict(event=name, boatClass=boat, **r) for r in pending)
(ROOT / 'inventory.json').write_text(json.dumps(manifests, indent=2))
(ROOT / 'pending-entries.json').write_text(json.dumps(all_pending, indent=2))
(ROOT / 'import-batch.sql').write_text('begin;\n' + '\n'.join((ROOT / m['file']).read_text().strip().removeprefix('begin;').removesuffix('commit;') for m in manifests) + '\ncommit;\n')
print(json.dumps(manifests, indent=2))
