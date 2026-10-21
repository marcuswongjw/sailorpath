import json,re,uuid
from pathlib import Path
BASE=Path('.work/thai-optimist-2026');OUT=Path('scripts/imports/thai-optimist-2026')
pre=json.loads((BASE/'preflight.json').read_text());sailors=pre['sailors'];byid={s['id']:s for s in sailors}
norm=lambda x:re.sub('[^a-z0-9]','',x.lower())
ns=uuid.UUID('660b6bd8-7212-4916-9c25-35c26c64e3ac')
uid=lambda x:str(uuid.uuid5(ns,x))
# Individually reviewed name variants; no general fuzzy matching is used for assignment.
variants={
 'SURAPHA MAUNGNGAM':('Surapha Muangngam','Minor given-name transliteration; same THA 1941, gender and 2011 year.'),
 'NETCHANOK CHATAWATTANASOPAKUL':('Netchanok Chatawattanasopakun','Surname final-letter variant; same THA 1644, gender and 2015 year.'),
 'LEVY WIEDMANN':('Levy Apichai Wiedmann','Shortened name; same THA 996 (RED boat label), male and RVYC; distinct from female Kanyapat using 996.'),
 'APICHAI LEVY WIEDMANN':('Levy Apichai Wiedmann','Full name token-order variant; same THA 996, male and RVYC.'),
 'KYAN TAN':('Kyan Tan Chun Hong','Short name; exact SGP 4712, male and 2015 year. Other SGP 4712 profile Reyes Tan has a different name and 2011 year.'),
 'CHANNANCHAI TIATHONGCHAI':('Chananchai Tiathongchai','One extra N in given name; unique matching full surname/given-name variant, THA male born 2015. Official entry separate from Anantachai at rank 4; preserve THA 194 historic boat number.'),
 'NAIMAKORN JANGKITTIYARAT':('Naimakron Jangkittiyarat','Given-name letter-order variant; same THA 7211 and male born 2013 in official Thailand International result.'),
 'KUNPHICHET PHANCHANG':('Kulpichet Phanchang','Given-name transliteration variant with identical surname, THA male and RNSC result context; retain historic 1248 separately from earlier 69.'),
 'NOPPADOL TOHPO':('Nopadol Tokpo','Transliteration variant; same THA 125, male, RNSC and official Thailand International name.'),
 'NOPPADOL TOKPO':('Nopadol Tokpo','Extra D spelling variant; same THA 125, male and RNSC.'),
 'KAUNG KHANT KO':('Kaung Khant Khant Ko','Shortened repeated middle name; same MYA 382, distinct from Kaung Khant Khant Thu (MYA 373) and Thuta Naing.'),
 'DHAN C. SUKSANTINUNT':('Dhan Chintanaseri Suksantinunt','Expanded C. initial; exact historical result label and 1464 already linked to this profile; male born 2016.'),
 'THWIN MIN SATT@DANIEL':('Thwin Min Sett','Alternate spelling with Daniel nickname; same MYA405, Myanmar male; unique Thwin Min profile.'),
 'AN SIYEON':('Siyeon An','Family/given-name order reversed; same KOR 589, female born 2012.'),
 'NATTAKIT JONGRAK':('Natthakit Jongrak','One H spelling variant; unique matching full name, THA male and RNSC; retain official historical 722 rather than earlier 5911.'),
 'NAPAPHAT BUASUANG':('Napabhat Buasuang','User confirmed same sailor on 20 October 2026; historic THA 544 retained separately.'),
 'KUNTHON KHUNMUANG':('Kanthon Khunmuang','Given-name vowel variant; same THA1593, male and SSA; distinct from Kanthee Khunmuang (54) and Dhan Suksantinunt (born 2016).'),
 'SAETTHAWIT YODMANEE':('Setthawit Yodmanee','Given-name vowel variant; same THA181, male and 2017 year in official Thailand International result.'),
}
variants={norm(k):v for k,v in variants.items()}
new={};review=[]
keys=['acdc-sailing-cup','acdc-international','admirals-cup','thailand-international']
for key in keys:
 m=json.loads((OUT/(key+'.json')).read_text())
 m['event']['id']='9e1dff93-655a-41f4-97c9-e52dbfc02c7b' if key=='thailand-international' else uid('event:'+m['event']['slug'])
 m['sheet']['id']='f3d03df4-dc68-45b8-bd72-44f80b2ce186' if key=='thailand-international' else uid('sheet:'+m['sheet']['slug'])
 m['sheet']['existing']=key=='thailand-international'
 if key=='admirals-cup':
  m['officialSource']['pdfSearch']='Searched Royal Varuna 2026 event page, official notice board 13369 and web results. No official results PDF found; notice board links to this organiser-hosted Sailwave HTML, provisional 27 February 2026.'
  m['officialSource']['noticeBoard']='https://www.racingrulesofsailing.org/documents/13369/event'
 else:m['officialSource']['pdfFile']='.work/thai-optimist-2026/pdfs/'+key+'.pdf'
 m['officialSource']['publicationStatus']='provisional' if m['officialSource']['provisional'] else 'final'
 m['officialSource']['comparisonFile']='scripts/imports/thai-optimist-2026/source-comparison.json'
 m['dateBasis']={'acdc-sailing-cup':'Official notice board first-day result 191242 dated 30 May and final-day PDF 191515 dated 31 May; site heading 7–8 May conflicts with its own result date 31 May. Use official 30–31 May.', 'acdc-international':'Official English Notice of Race document 193957 and Sailing Instructions 200190 specify 29 July–1 August; site starts 28 July.', 'admirals-cup':'Official NoR with Amendment 2 document 175894 and organiser result heading specify 20–24 February; club calendar says 21–24 February.', 'thailand-international':'Preserve existing Optimist class dates 15–18 April; official event includes registration and long-distance race through 19 April. Audit only, no mutation.'}[key]
 for r in m['results']:
  n=norm(r['name'])
  if n in variants:
   target,basis=variants[n];matches=[s for s in sailors if s['name']==target];assert len(matches)==1,target
   r['sailorId']=matches[0]['id'];r['identityBasis']=basis
  if 'sailorId' not in r:
   # Confirmed cross-event spelling pair; otherwise preserve distinct official names.
   canonical='Duangdeuen Wichai' if n in [norm('Duangdeuen Wichai'),norm('DUANGDUEAN WICHAT')] else r['name'].title()
   signature=r['nationality']+':'+norm(canonical)
   if signature not in new:
    sid=uid('sailor:'+signature);handle=re.sub('[^a-z0-9]+','-',canonical.lower()).strip('-')+'-thai26-'+sid[:6]
    new[signature]=dict(id=sid,name=canonical,handle=handle,sail_number=r['sailOrBoardNumber'],club=r['club'] or 'Official regatta result',nationality=r['nationality'],gender=r['gender'])
   r['sailorId']=new[signature]['id'];r['identityBasis']='User confirmed Duangdeuen Wichai / Duangduean Wichat are the same sailor on 20 October 2026.' if canonical=='Duangdeuen Wichai' else 'No existing exact name/alias or compatible reviewed variant found; distinct new profile from official result. No DOB invented.'
  r['resultId']=uid('result:'+m['sheet']['id']+':'+r['sailorId']);r['participantId']=uid('participant:'+r['resultId'])
  sourceStatus=m['officialSource']['publicationStatus']
  r['evidenceNotes']=f"Official {sourceStatus} result: {r['name']}; historic sail {r['sailOrBoardNumber']}; official club {r['club']}; official nationality {r['nationality']}; official YOB {r['officialBirthYear'] or 'not stated'}. Every race, score code and discard retained; gross/net reconciled. {r['identityBasis']}"
  if m['officialSource']['provisional']:r['evidenceNotes']+=' Source remains explicitly provisional; verified means checked against this source, not a finality claim.'
  review.append(dict(sheet=key,rank=r['rank'],officialName=r['name'],sailorId=r['sailorId'],profileName=byid.get(r['sailorId'],{}).get('name',next((p['name'] for p in new.values() if p['id']==r['sailorId']),None)),basis=r['identityBasis']))
 assert len({r['sailorId'] for r in m['results']})==len(m['results']),key
 m['newProfiles']=[p for p in new.values() if p['id'] in {r['sailorId'] for r in m['results']}]
 m['profilePreflight']=[s for s in sailors if s['id'] in {r['sailorId'] for r in m['results']}]
 (OUT/(key+'.json')).write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
(OUT/'identity-review.json').write_text(json.dumps(review,ensure_ascii=False,indent=2)+'\n')
(OUT/'new-profiles.json').write_text(json.dumps(list(new.values()),ensure_ascii=False,indent=2)+'\n')
print('New profiles:',len(new))
for p in new.values():print(p['name'],p['sail_number'],p['nationality'])
