import json
from pathlib import Path
O=Path('scripts/imports/sail-result-2026');out=Path('outputs/sail-result-2026');pre=json.load(open('.work/sail-result-2026/preflight.json'));pending=json.load(open(O/'pending-identities.json'))
groups=[
(['DOH VINNA'],'Markus Doh Vinna','Shortened name; official ILCA sail 209947 differs from the existing Optimist sail 171.'),
(['PHACHARAP0L MUNWORG','PHACHARAPOL','PHACHARAPOL MUNWONG'],'Phacharapol Munwong','Children’s Day lists both Phacharapol (1255) and Phacharapol Munwong (0) in the same fleet. Another ILCA sheet spells the name Phacharap0l Munworg and shows a questionable birth year. Keep the entries distinct pending confirmation.'),
(['NUR HAFIZAHANANI BINTI ZAILAN','NUR HAFIZAHANANI'],'Nur Hafizanah Binti Zailan','Similar names but different source years (2008 and 2007) and sail numbers. Confirm which results belong to the existing profile.'),
(['SAOBOON THAVEEBUNRUNGRUENG','SOMBUN THAWEEBUNRUNGRUEANG','Somboon TaweeBoonrungrueng'],None,'Three spellings in different events, same recorded year (2012) and club, different sail numbers. Confirm whether to create one new profile or separate profiles.'),
(['PIYANGKUN NIYOM','PIYUNGKUL NIYOM'],None,'Two given-name spellings, born 2016, YRAT; sails 88 and 1R. Confirm whether these are one sailor.'),
(['PARKPOOM SAE-UY','Phakphum Sae-uy'],None,'Different given-name transliterations, born 2015, RNSC; sails 522 and 115. Confirm whether these are one sailor.'),
(['TIWMEK JUNKASEAN'],'Tewmek Chulagasyena','Same source age and training number 10, but substantially different surname spelling.'),
(['KITTITRAT TONGTIEM'],'Kittithach Thongthiem','Given/family-name spelling differs; source 1G versus existing historical 1R. Both recorded as born 2014.'),
(['KRITDANUPON TUMSUB'],'Kitdanuphon Thamsap','Name transliteration differs; both born 2018, source sail 33 versus historic 544.'),
(['NATIDEJ TERMTAKULWATTANA'],'Natidej Termwattanapakdee','Similar given name but substantially different family name; EGAT training number 2 versus recorded ILCA 220051.'),
(['NOPPHADON TOPHO','Noppadol To-pho'],'Nopadol Tokpo','Several transliterations and different sails. Confirm whether these are the same sailor as the existing profile.'),
(['HENRY ZOU'],'Henry Zub','Similar name but different sail and incomplete age/nationality corroboration.'),
(['HENRY ATICHAT WIEDMANN'],'Henry Wiedmann','Expanded name, source ILCA 220235 versus existing 214987. Confirm before linking.'),
(['JIAHE LIU'],'JiaHe Liu','Source HKG, female, born 2016, sail 246; existing profile CHN, sail 7012. Confirm identity before linking.'),
]
lines=['# Sailor identities awaiting review','', '**24 result entries are held back. All other reviewed entries are imported.** No decision is needed to retain the completed import.','', 'For each group, confirm whether to attach the results to the linked profile, create a separate profile, or combine the new spelling variants into one new profile.','', '| Official name(s) | Existing candidate | What needs confirmation | Held entries |','|---|---|---|---|']
for names,target,reason in groups:
 hits=[s for s in pre['sailors'] if s['name']==target];candidate=f"[{target}](https://sailorpath.com/sailors/{hits[0]['handle']})" if hits else 'No confirmed existing profile'
 rows=[p for p in pending if p['name'] in names];assert rows,(names,'missing');details='; '.join(f"{p['sheet'].replace('-2026','')} · rank {p['rank']} · sail {p['sail'] or 'blank'}" for p in rows)
 lines.append(f"| {' / '.join(names)} | {candidate} | {reason} | {details} |")
assert sum(sum(p['name'] in names for p in pending) for names,_,_ in groups)==len(pending)
(out/'pending-review.md').write_text('\n'.join(lines)+'\n')
p=out/'report.md';s=p.read_text().replace('## Deferred identities','## Deferred identities\n\n[Open the grouped review list with candidate profiles](pending-review.md).');s=s.replace('- Newborn fleets have separate public tabs;', '- 53 relevant automated checks and a production build passed.\n- Newborn fleets have separate public tabs;');p.write_text(s)
