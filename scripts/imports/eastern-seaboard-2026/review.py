import pathlib,json,re,uuid
base=pathlib.Path('scripts/imports/eastern-seaboard-2026')
sailors=json.load(open('.work/eastern-seaboard-2026/live-sailors.json'))
byname={s['name']:s for s in sailors}
# Nationality transcribed from rendered tables. PDF text omits many flags/country cells.
nats={
'optimist-gold': 'THA SGP THA THA MYA THA MYA THA THA HKG THA THA THA THA MAS MAS MAS AUS CHN MAS THA THA HKG SGP AIN THA THA AUS MAS AUS THA MAS SGP HKG THA INA AIN THA AIN MAS MAS THA MYA SGP THA THA THA THA TPE THA THA AUS HKG MAS SGP SGP AIN THA THA THA AUS THA AIN MYA SGP TPE AUS THA'.split(),
'optimist-silver': 'MYA AIN MAS THA MYA MYA MYA THA SGP THA MAS HKG SGP THA THA AIN THA SGP THA THA SGP THA SGP MAS THA THA THA THA THA SGP THA THA THA TPE MYA THA THA THA THA THA THA AIN SGP THA THA THA MYA THA TPE THA THA THA THA SGP THA THA THA THA FRA SGP TPE MYA THA TPE MYA THA MYA'.split()}
matches={
('ilca4',18):('Huang Chi Fang','Nickname Megan appended; same 220975, TPE, female, 2010 and RVYC as earlier official results.'),
('ilca4',20):('Kiitchakhun Somkhanngoen','Same official full-name spelling and 225917, YRAT, THA, 2011 in ACDC Cup 2026.'),
('ilca4',47):('Muhammad Zulfan Akif Bin Mohd Zulkifly','Unique long full-name variant omitting Mohd; same MAS male identity.'),
('ilca4',53):('Aktanon Jongjukaphan','Same official spelling and 222687, THA, male, YRAT, 2012 in ACDC Cup 2026.'),
('ilca6',5):('Teng-Hsi Yeh','Reordered full name; same 225163, TPE, male, 2010, RVYC as ILCA Thailand 2026.'),
('optimist-gold',16):('Khairul Ilzani Bin Mohd Afendy','Spelling variant; same MAS119, MAS male as Langkawi and 2025 Asian official results.'),
('optimist-gold',20):('Muhammad Anas Aryan Bin Mohd Noor Ridzua','Unique long full name, final n absent in stored profile; same MAS male.'),
('optimist-gold',29):('Imanina Raisya bt Izhar','Binti expansion of bt in unique full name; MAS female.'),
('optimist-gold',41):('Mia Azrania bt Mohd Azrald','Binti expansion of bt in unique full name; MAS female.'),
('optimist-gold',43):('Eaint Chue Zayar','Spacing variant Zay Yar; same MYA391 as official ODAM 2025.'),
('optimist-gold',58):('Pimpisa Devahastin Na Ayudhya','Reordered full name; same THA1539, female 2016 as ACDC Cup official source.'),
('optimist-gold',68):('Naimakron Jangkittiyarat','Previously reviewed official spelling NAIMAKORN JANGKITTIYARAT, male 2013. Distinct from Nattayut (2012); sail number alone not used.'),
('optimist-silver',3):('Nur Iman Sofia Binti Mohd Shazwan','Mohamad expansion of Mohd in unique full name; MAS female.'),
('optimist-silver',7):('Kaung Khant Khant Ko','Same official shortened name, MYA382, male 2015 as ACDC Cup 2026.'),
('optimist-silver',8):('Teejutha Thongthiem','Unique given name, one-letter transliteration variant, THA male 2015 YRAT; differs from Kittithach male 2014, both listed separately.'),
('optimist-silver',27):('Kittithach Thongthiem','Unique given name, one-letter transliteration variant, THA male 2014 YRAT; differs from Teejutha male 2015, both listed separately.'),
('optimist-silver',31):('Natkritta Boonsang','Minor transliteration variant; same 1478, THA female 2017 YRAT.'),
('optimist-silver',48):('Thee Parinyanitikun','Honorific Master; same THA199, SSA, male 2017 as official 2026 results.'),
('optimist-silver',62):('Sherman','Fuller source name; same MYA380, Yangon male as official ODAM 2025 and Yangon 2026.'),
('optimist-silver',65):('Phyu Cin Thadar','Minor transliteration variant; same MYA421 as Olympic Day 2026.'),
}
audit=[]
new=[]
for f in base.glob('*.json'):
 if f.stem not in ['ilca4','ilca6','optimist-gold','optimist-silver']:continue
 m=json.load(open(f));key=f.stem
 if key in nats: assert len(nats[key])==len(m['results'])
 for r in m['results']:
  if key in nats:r['nationality']=r['sourceNationality']=nats[key][r['rank']-1]
  elif 'Taiwan' in r['nationality']:r['nationality']='TPE';r['sourceNationality']='Taiwan'
  if (key,r['rank']) in matches:
   name,reason=matches[key,r['rank']]
   r['sailorId']=byname[name]['id'];r['matchReason']=reason
  if not r.get('sailorId'):
   # Distinct official identity; no fuzzy match accepted without corroboration.
   display=r['name'].title().replace('- ','-')
   sid=str(uuid.uuid5(uuid.NAMESPACE_URL,'sailorpath:eastern-2026:'+r['nationality']+':'+re.sub('[^a-z0-9]','',display.lower())))
   handle=re.sub('[^a-z0-9]+','-',display.lower()).strip('-')+'-esr26-'+r['nationality'].lower()
   assert handle not in {s['handle'] for s in sailors}
   r.update(sailorId=sid,matchReason='New distinct official identity; no confirmed existing name or reviewed alias match.',newProfile=dict(id=sid,name=display,handle=handle,sailNumber=r['sailOrBoardNumber'] if key.startswith('optimist') else '',sailNumberIlca4=r['sailOrBoardNumber'] if key.startswith('ilca') else None,club=r['club'] or 'N/A',nationality=r['nationality'],gender=r['gender']))
   new.append(r['newProfile'])
  # Keep invalid/two-digit/Buddhist source years in evidence only.
  r['metadataNotes']=''
  if r['birthYear'] is None:r['metadataNotes']='Non-Gregorian or incomplete source YOB retained verbatim; no birth date inferred.'
  audit.append(dict(sheet=key,rank=r['rank'],sourceName=r['name'],sail=r['sailOrBoardNumber'],sailorId=r['sailorId'],reason=r['matchReason']))
 assert len(set(r['sailorId'] for r in m['results']))==len(m['results'])
 f.write_text(json.dumps(m,indent=2)+'\n')
(base/'identity-audit.json').write_text(json.dumps(audit,indent=2)+'\n')
print('new profiles',len(new),'existing',len(audit)-len(new))
print('new names:',[x['name'] for x in new])
