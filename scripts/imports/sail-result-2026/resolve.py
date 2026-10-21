"""Explicit identity decisions; ambiguous user-deferred cases are excluded before SQL generation."""
import json,re,uuid,collections
from pathlib import Path
norm=lambda s:re.sub('[^a-z0-9]','',s.lower())
def nname(s):return norm(re.sub(r'^(?:MR\.?|MISS|MASTER|SUB\.?LT\.?|CDR\.?|CFR\.?|VADM\.?)\s*','',s,flags=re.I))
W=Path('.work/sail-result-2026');O=Path('scripts/imports/sail-result-2026');pre=json.load(open(W/'preflight.json'));byid={s['id']:s for s in pre['sailors']};ns=uuid.UUID('5aa15910-cc1b-49e4-aadf-23f14c7c33ae');uid=lambda s:str(uuid.uuid5(ns,s))
# These were reviewed individually against visible official spellings, recorded demographics,
# exact historical sails and/or another full-name entry in the same official source batch.
explicit={
'CHEN YANG YEH':'Yeh Chen Yang','CHI FANG HUANG':'Huang Chi Fang',
'AKTANON JONGJUGKAPHAN':'Aktanon Jongjukaphan','AKTANON JONGJAKAPHAN':'Aktanon Jongjukaphan',
'PITIPHAT PAPHAWANNASRI':'Pitipat Paphawannasri','PITIPAT PRAPAWANNASRI':'Pitipat Paphawannasri','Pitipat Paprawannasri':'Pitipat Paphawannasri',
'SHERMAN AYE':'Sherman',
'NATNATEE PHIPANICH':'Natnathee Peepanich','NATNATEE PEEPANICH':'Natnathee Peepanich','Natnatee Peepanich':'Natnathee Peepanich','NUTTATEE PEEPANIJ':'Natnathee Peepanich',
'THITIWORADA JOHNJAITONG':'Thitiworada Johnjaitrong','THITIWORADA JONJAITONG':'Thitiworada Johnjaitrong','THITIWORADA JHONJAITONG':'Thitiworada Johnjaitrong',
'NAPATR LARDSAWHEA':'Napat Ladsowhae','NUTNICHA SOMWONGIN':'Natnicha Somwongin',
'TEEJUTHA TONGTEAM':'Teejutha Thongthiem','TIRAWAT HANKHAM':'Thirawat Hankham',
'DHAN C SUKSANTINUNT':'Dhan Chintanaseri Suksantinunt','DHAN C. SUKSANTINUNT':'Dhan Chintanaseri Suksantinunt',
'Surapha maungngam':'Surapha Muangngam','RACHATA SADTAKOOLWATTANA':'Rachata Sadtrakulwatanna','RACHATA SATTAKULWATTHANA':'Rachata Sadtrakulwatanna',
'PORNYAMON SAWAENGKHUN':'Pornyamol Sawaengkhun','Thanchanok Thammajaruk':'Thanchanok Thamajaruk',
'TANAPA PONGKAMNEUD':'Thanapha Phongkamnerd','THANAPHA PHONGKAMNOET':'Thanapha Phongkamnerd','THANAPORN':'Thanaporn Phokaew',
'BALLAMEE SORNNUAN':'Baramee Sonnual','WICHAYAPHON SAKSRIKLOM':'Wichayaporn Saksriklom','TRAIRAT CHARUNROT':'Trairat Jaroonrot',
'NAIMAKORN JANGKITTIYARAT':'Naimakron Jangkittiyarat','NATTAKIT JONGRAK':'Natthakit Jongrak','ARANYA KHLANGMUEANG':'Aranya Klangmueang',
'KUNPHICHET PHANCHANG':'Kulpichet Phanchang','Kulpichet Panchang':'Kulpichet Phanchang',
'PAWNRAPAT MEEWUTTHISOM':'Pawnrapat Meewuttisom','KRITSADA BUNMUEANG':'Kritsada Bunmeang','Kritsada Bunmueang':'Kritsada Bunmeang',
'CHAYAKON WATTHANAKHON':'Chayakorn Wattanakorn','Chayakorn Watnakhon':'Chayakorn Wattanakorn',
'YINRAN CHAN':'Yinran Chen','WILLIAM MARSH':'Wiliam Marsh','SUTHNAN NAKPASOM':'Suthinan Nakpasom','NATTAPONG NEELASAVEE':'Natthapong Neelasavee',
'CHANYACHARD ITTIVORAKUL':'Chanyachart Ittivorakul','Netchanok Chatawattanasopakul':'Netchanok Chatawattanasopakun',
'ROONG CHANTATAWINIJ':'Roong Chantarawinij','HASSALUK SRINAKORN':'Hussaluk Srinakorn','Hussaluk':'Hussaluk Srinakorn','Skye':'Skye Hsu',
'CANANCHAI TIATHONGCHAI':'Chananchai Tiathongchai','NAPICHAYA RATTANADECAKORN':'Napichaya Rattanadechakorn',
'SANTHAT SUTAMKOSOL':'Santhat Suthamgosal','NATTAPHAT POOLKLANG':'Natthapatr Poolklang',
'ANANTTACHAI TIATHONGCHAI':'Anantachai Tiathongchai','KAOCHANOK CHATAWATTANASOPAKUN':'Klaochanok Chatawattanasopakun',
'PAPUNGKORN KONGPRECHASAKIL':'Papungkorn Kongprechasakul','CHATTPAT SOMPRASONG':'Chattapat Somprasong',
'JIN YUEYAN':'Yueyan Jin','Apichai Levy Wiedmann':'Levy Apichai Wiedmann',
# Unique existing full name plus matching official event history; profile defaults/source typos are preserved.
'KARIT PHRAMMANEE':'Karit Phrammanee','Karit Phrammanee':'Karit Phrammanee','JOLIN ZHENG':'Jolin Zheng','PINCHANOK KLAYSOMBOON':'Pinchanok Klaysomboon','DARWIN HSU':'Darwin Hsu','CARLA CANTURRI':'Carla Canturri',
'CHUHAN ZHANG':'Chuhan Zhang','ASHIRA PHANGRAK':'Ashira Phangrak','Thawaree raksapun':'Thawaree Raksapun','PORNYAMOL SAWAENGKHUN':'Pornyamol Sawaengkhun','KITTALUK KULWATTANAPHAN':'Kittaluk Kulwattanaphan','JEON HYUN WOO':'Hyunwoo Jeon',
}
# Ambiguous abbreviated/transliterated identities without sufficient equipment/demographic corroboration
# are also held for review instead of creating likely duplicate profiles.
defer={'HENRY ZOU','NUR HAFIZAHANANI BINTI ZAILAN','NUR HAFIZAHANANI','JIAHE LIU','PHACHARAPOL','PHACHARAPOL MUNWONG','PHACHARAP0L MUNWORG',
 'DOH VINNA','HENRY ATICHAT WIEDMANN','KITTITRAT TONGTIEM','TIWMEK JUNKASEAN','KRITDANUPON TUMSUB','NOPPHADON TOPHO','Noppadol To-pho','NATIDEJ TERMTAKULWATTANA','SAOBOON THAVEEBUNRUNGRUENG','SOMBUN THAWEEBUNRUNGRUEANG','Somboon TaweeBoonrungrueng','PIYANGKUN NIYOM','PIYUNGKUL NIYOM','PARKPOOM SAE-UY','Phakphum Sae-uy'}
# New full-name variants proven across official sheets by shared sail, gender and year.
newvariants={
 'MARION GRACE MOUTGOUERY':'MARION GRACE MONTGOMERY',
 'LALA COLLIN':'CAPUCINE LALA COLLIN',
 'LEE SOO MIN':'LEE SU MIN',
 'PEERAPAT YAPOLHA':'PEERAPAT YAPONHA',
 'SARUNYA SUTIKLANG-VIHARN':'SARUNYA SUTIKLANGVIHARN',
 'CFR.NITHASAN RODHNUN':'NITHATSANA RODHNUN','CDR.NITHASN RODHNUN':'NITHATSANA RODHNUN','NITHATSANA RODNHUN':'NITHATSANA RODHNUN',
 'NATTHANAN AESOMNUEK':'NATTANAN AESOMNUEK','NATNAN AESOMNUEK':'NATTANAN AESOMNUEK',
 'SOMBUN THAWEEBUNRUNGRUEANG':'SOMBOON TAWEEBOONRUNGRUENG',
 'PRATCHAYA BUNPASIT':'PRATCHAYA BUNPRASIT',
 'TRAIKHUN TONGLUNG':'TRAIKHUN TONGLUANG',
}
explicit={nname(k):v for k,v in explicit.items()};defer={nname(x) for x in defer};newvariants={nname(k):nname(v) for k,v in newvariants.items()}
new={};decisions=[];pending=[];manifests=[]
for p in sorted(W.glob('*-matched.json')):
 m=json.load(open(p));s=m['sheet'];good=[]
 for index,r in enumerate(m['results']):
  nn=nname(r['name'])
  if nn in defer:
   pending.append({'sheet':s['slug'],'rank':r['rank'],'name':r['name'],'sail':r['sailOrBoardNumber'],'reason':'Deferred identity review; excluded per user instruction to import unaffected results first.'});continue
  if nn in explicit:
   hits=[a for a in pre['sailors'] if a['name']==explicit[nn]];assert len(hits)==1,(r['name'],explicit[nn]);sid=hits[0]['id'];basis='Individually reviewed official full-name spelling/alias, nationality, age/gender and historic equipment evidence across this batch and existing result history. Existing profile metadata retained unchanged.'
  elif r.get('sailorId'):sid=r['sailorId'];basis=r['identityBasis']
  else:
   nn=newvariants.get(nn,nn);sig=nn
   if sig not in new:
    sid=uid('sailor:'+sig);name=next((newvariants.get(nname(a['name']),nname(a['name'])) for a in [r]),nn)
    new[sig]=dict(id=sid,name=re.sub(r'^(?:MR\.?|MISS|MASTER|SUB\.?LT\.?|CDR\.?|CFR\.?|VADM\.?)\s*','',r['name'],flags=re.I).title(),handle=re.sub('[^a-z0-9]+','-',r['name'].lower()).strip('-')+'-sr26-'+sid[:6],sailNumber=r['sailOrBoardNumber'] if s['boatClass']=='Optimist' else '',sailNumberIlca4=r['sailOrBoardNumber'] if s['boatClass']=='ILCA 4' else None,nationality=r['nationality'],gender=r['gender'],club=r['club'] or 'Official regatta entry',birthYear=None)
   sid=new[sig]['id'];basis='Distinct official identity with no confirmed existing profile match; no date of birth invented. Exact normalized full names reused across this batch; independently corroborated spelling variants recorded separately.'
  r['sailorId']=sid;r['resultId']=uid('result:'+s['slug']+':'+str(index)+':'+r['name']);r['participants']=[dict(id=uid('participant:'+r['resultId']),sailorId=sid,sourceName=r['name'],displayOrder=1,role='solo')]
  r['evidenceNotes']=f"Official source name: {r['name']}; historic sail/boat number: {r['sailOrBoardNumber'] or 'blank in source'}; club: {r['club']}; nationality: {r['nationality'] or 'not stated'}; source year/age field: {r['sourceBirthYear'] or 'blank'}. Source race labels: "+', '.join(x['sourceRaceLabel'] for x in r['races'])+f". Every score, code and discard preserved; gross {r['grossScore']} and net {r['nettScore']} reconciled. "+basis
  decisions.append({'sheet':s['slug'],'rank':r['rank'],'sourceName':r['name'],'sailorId':sid,'basis':basis});good.append(r)
 m['results']=good;m['importedEntryCount']=len(good);m['deferredEntryCount']=s['totalFleetSize']-len(good)
 assert len({r['sailorId'] for r in good})==len(good),(s['slug'],'same sailor appears twice')
 ids={r['sailorId'] for r in good};m['profilePreflight']=[a for a in pre['sailors'] if a['id'] in ids];m['newProfiles']=[a for a in new.values() if a['id'] in ids]
 m['identityReview']={'method':'Exact existing names/accepted aliases and individually reviewed identity variants; ambiguous cases deferred.','decisions':[x for x in decisions if x['sheet']==s['slug']]}
 if m['deferredEntryCount']:m['publicSummary']+=f" Partial import: {len(good)} of {s['totalFleetSize']} entries imported; {m['deferredEntryCount']} awaiting identity review."
 if good:manifests.append(m)
# New profiles first encountered in a later variant still have one stable UUID. Include them in every sheet using them.
for m in manifests:
 ids={r['sailorId'] for r in m['results']};m['newProfiles']=[a for a in new.values() if a['id'] in ids]
 (O/(m['sheet']['slug']+'.json')).write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
(O/'pending-identities.json').write_text(json.dumps(pending,ensure_ascii=False,indent=2)+'\n');(O/'identity-decisions.json').write_text(json.dumps(decisions,ensure_ascii=False,indent=2)+'\n');(O/'new-profiles.json').write_text(json.dumps(list(new.values()),ensure_ascii=False,indent=2)+'\n')
print('SHEETS',len(manifests),'IMPORTED ENTRIES',sum(len(m['results']) for m in manifests),'DEFERRED',len(pending),'NEW PROFILES',len(new),'SCORES',sum(len(m['results'])*m['sheet']['raceCount'] for m in manifests))
for r in pending:print('PENDING',r['name'],r['sheet'])
