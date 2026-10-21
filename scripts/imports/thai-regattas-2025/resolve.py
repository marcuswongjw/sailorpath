"""Individually reviewed identity resolutions; never assign by fuzzy similarity alone."""
import json,re,uuid
from pathlib import Path
B=Path('.work/thai-regattas-2025');O=Path('scripts/imports/thai-regattas-2025')
pre=json.loads((B/'preflight.json').read_text());byid={s['id']:s for s in pre['sailors']}
ns=uuid.UUID('8d3e7276-63a0-48c6-a321-a31988490d21');uid=lambda s:str(uuid.uuid5(ns,s));norm=lambda s:re.sub('[^a-z0-9]','',s.lower())
# Each variant was reviewed against the official row and independent profile/history metadata.
variants={
 'JEON HYUNWOO':('Hyunwoo Jeon','Reversed Korean family/given-name order; same unique full name, KOR male born2011. Historic578 retained separately from590.'),
 'NIGEL TAN XU YUAN':('Nigel Tan Xu Yuan','Exact full name, SGP male and exact ILCA 4 sail 225176. Existing 1905 DOB is invalid for this youth entry; retain profile untouched and preserve official 2010 year only on this result.'),
 'GEMMA CHEN HUAN HENG':('Gemma Chen Huang Heng','Existing official entry alias Gemma Chen Huan Heng and exact SGP 4729, female. Profile DOB 1905 not used for assignment or overwritten; official 2012 year retained on result.'),
 'KITCHAKHUN SOMKHANNGOEN':('Kiitchakhun Somkhanngoen','Unique full given/family-name spelling differing by one repeated I, THA male born 2011, YRAT. Historical 228917 retained without overwriting current 225917.'),
 'ISAIAH YAP':('Isaiah Yap Chor Hong','Shortened name with exact SGP ILCA sail 227463, male born 2012.'),
 'PARIYAPORN CHANTRAWONG':('Pariyaporn Chantarawong','One-letter surname spelling omission; exact THA 1223, female born 2011 and YRAT.'),
 'YI KAI KAYDEN TAN':('Tan Yi Kai Kayden','Full-name token order; exact SGP 3104, male born 2010.'),
 'CHANYACHART ITTTIVORAKUL':('Chanyachart Ittivorakul','Extra T spelling; exact THA 1887 and ACDC.'),
 'LEVY WIEDMANN':('Levy Apichai Wiedmann','Existing official historical alias LEVY WIEDMANN; Eastern source THA 996 male born 2013 and RVYC. Admiral historical 1464 preserved separately; distinct from female Kanyapat.'),
 'RACHEL LIM':('Rachel Lim Qian Hui','Shortened name with exact SGP 3197, female born 2014 and SAFYC.'),
 'OLLIE JOHNSON':('Oliver Johnson','Ollie/Oliver familiar-name variant; exact AUS 1854, male and Australian BSYC entry.'),
 'ALEX EYLES':('Alexander Eyles','Alex/Alexander familiar-name variant; exact 287, male and Australian ESPBC entry.'),
 'JIRATIWAT PUENGCHURN':('Jiratiwat Peungchurn','Surname vowel-order variant; exact historic THA 936 in previously verified official result, male born 2012.'),
 'JOSHUA ANNANDA KURTZ':('Joshua Ananda Kurtz','Repeated N in middle name; same unique full given/family name, THA male born 2015 and RVYC in existing official evidence.'),
 'NETCHANOK CHTAWATANASOPAKUL':('Netchanok Chatawattanasopakun','Missing A in surname plus previously documented L/N transliteration; unique Netchanok given/family name, THA female born 2015 and ACDC.SC. Distinct from Klaochanok born 2013; historic THA 33 retained.'),
 'HOOD SAAD LAHAQ AL ABD ALNOFLI':('Hood Al Nofli','Expanded patronymic; exact OMA 320, male born 2010.'),
 'KHAMIS NASSER SALEH SALIM AL MASHAIKHI':('Khamis Al Meshaikhi','Expanded patronymic and Mashaikhi/Meshaikhi transliteration. Unique OMA Khamis Al Meshaikhi profile; independent official GCC result identifies Khamis Nasser Al Mashaikhi with OMA310. Historic 310 preserved; existing official Asian Championship 321 retained.'),
 'HADEEL YOUSUF JAMIL THUNAI AL MUSHAIFRI':('Hadeel Al Mushaifri','Expanded patronymic with identical Hadeel/Al Mushaifri, OMA female, unique existing official Asian Championship identity. Historic 313 retained without overwriting 322.'),
 'TARTEEL ZAID AL-ABD AEDULLAH AL-HASANI':('Tarteel Al Hasani','Expanded patronymic with identical Tarteel/Al Hasani, OMA female born 2010. Independent 2025 African results identify Tarteel Al Hasani with OMA311; existing Asian result uses323. Preserve both historic numbers.'),
 'JING CHEN NICOLE':('Nicole Wong Jing Chen','Existing official alias Wong Jing Chen Nicole; exact SGP3006, female born2014 and SAFYC.'),
 'JEREMIRAH ONG':('Jeremiah Ong Rui Feng','One inserted R plus shortened name; exact SGP3373, male born2014 and SAFYC.'),
 'AN SI YEON':('Siyeon An','Existing official historical alias AN SIYEON after whitespace normalization; KOR female born2012. Historic579 preserved separately from589.'),
 'ANANTACHAI TIA':('Anantachai Tiathongchai','Abbreviated family name Tia expanded by the other requested official source: Eastern rank35 Anantachai Tiathongchai, THA1549, male born2015, matching Admiral entry. Existing profile same unique full name, THA male born2015.'),
 'KYLE SOH':('Kyle Jeremy Soh Zhi Jun','Shortened given/family name; exact SGP3183, male born2015 and SAFYC.'),
 'MINA OSSHI SIAMCHAI':('Mina oishi siamchai','Minor Oishi/Osshi spelling variant; exact THA1553, female and RVYC; Eastern official row uses Mina Oishi Siamchai.'),
 'DANYAL MARCZQUI RAHMAT HARON MUZAFFAR':('Danyal Marczqui Rahmatbin Haron','Expanded Malaysian full name; unique Danyal Marczqui Rahmat Haron identity. Independent Merdeka2025 official INT420 result uses full Muzaffar name and same first/family names. Historical Opti32 retained separately from420boat55957; crew Nur Aina kept a separate participant.'),
}
new={};review=[];allman=[]
for p in sorted(B.glob('*-matched.json')):
 m=json.loads(p.read_text());s=m['sheet'];nnew=set()
 for r in m['results']:
  people=r.get('crewNames',[r['name']]);resolved=[]
  for name in people:
   found=next((x for x in r['participants'] if x['name']==name),None)
   if name in variants:
    target,basis=variants[name];hits=[x for x in pre['sailors'] if x['name']==target];assert len(hits)==1,(name,target)
    sid=hits[0]['id'];basis=basis
   elif found:sid=found['sailorId'];basis=found['basis']
   else:
    signature=r['nationality']+':'+norm(name)
    if signature not in new:
     sid=uid('sailor:'+signature);new[signature]=dict(id=sid,name=name.title(),handle=re.sub('[^a-z0-9]+','-',name.lower()).strip('-')+'-thai25-'+sid[:6],sailNumber=r['sailOrBoardNumber'] if s['boatClass']!='ILCA 4' else '',sailNumberIlca4=r['sailOrBoardNumber'] if s['boatClass']=='ILCA 4' else None,club=r['club'] or 'Official regatta result',nationality=r['nationality'],gender=r['gender'],birthYear=None)
    sid=new[signature]['id'];basis='No existing exact name/accepted alias or independently corroborated variant. Preserve distinct official identity; no birth date invented.';nnew.add(sid)
   resolved.append(dict(sailorId=sid,sourceName=name,basis=basis,role='member' if s['entryType']=='crew' else 'solo',displayOrder=len(resolved)+1,id=uid('participant:'+s['id']+':'+str(r['rank'])+':'+name)))
   review.append(dict(sheet=s['slug'],rank=r['rank'],sourceName=name,sailorId=sid,profileName=byid[sid]['name'] if sid in byid else new[r['nationality']+':'+norm(name)]['name'],basis=basis))
  r['participants']=resolved;r['sailorId']=resolved[0]['sailorId'];r['resultId']=uid('result:'+s['id']+':'+str(r['rank']))
  r['evidenceNotes']=f"Official provisional source: {r['name']}; historic sail/boat {r['sailOrBoardNumber']}; source club {r['club']}; source nationality {r['nationality']}; source YOB {r['officialBirthYear'] or 'not separately specified for crew'}. All 11 races, scoring codes and one discard preserved; gross/net reconciled. Verified means checked against this source, not a finality claim. "+' '.join(x['basis'] for x in resolved)
  if s['entryType']=='crew':r['evidenceNotes']+=f" Source team gender field {r.get('officialGender')}, source shared age-year field {r.get('officialCrewAgeYearField')}; not used to infer individual crew genders or birthdays. Source names remain in published order; helm/crew roles not inferred."
  if 'admirals' in s['slug']:r['evidenceNotes']+=' R1–R5 = Q1–Q5; R6–R11 = F1–F6; retain fleet rank within Gold/Silver, not fabricated overall rank.'
 assert len({r['sailorId'] for r in m['results']})==len(m['results']),s['slug']
 ids={a['sailorId'] for r in m['results'] for a in r['participants']}
 m['newProfiles']=[x for x in new.values() if x['id'] in ids]
 m['profilePreflight']=[x for x in pre['sailors'] if x['id'] in ids]
 m['publicSummary']='Official source status: provisional. Checked against the organiser-published source. Every race, discard and scoring code retained. Does not count for Singapore national rankings.'
 (O/(s['slug']+'.json')).write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n');allman.append(m)
(O/'identity-review.json').write_text(json.dumps(review,ensure_ascii=False,indent=2)+'\n')
(O/'new-profiles.json').write_text(json.dumps(list(new.values()),ensure_ascii=False,indent=2)+'\n')
print('Results',sum(len(m['results']) for m in allman),'New profiles',len(new),'linked existing',len(set(x['sailorId'] for x in review if x['sailorId'] in byid)))
print('New identities:',', '.join(p['name'] for p in new.values()))
