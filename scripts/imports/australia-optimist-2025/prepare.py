import json,re,uuid,difflib,collections
from pathlib import Path
P=Path(__file__).resolve().parent
uid=lambda s:str(uuid.uuid5(uuid.NAMESPACE_URL,'sailorpath:aus-opti-2025:'+s))
norm=lambda s:re.sub('[^a-z0-9]','',s.lower())
profiles=json.loads((P/'profiles.json').read_text());existing={s['id']:s for s in profiles};index=collections.defaultdict(list)
for s in profiles:index[norm(s['name'])].append(s)
tables=json.loads((P/'tables.json').read_text());new={};manifests=[];pending=[];issues=[];resolutions=[]
entries=next(d for d in tables if d['file']=='victoria-entries.html')['tables'][0][1:]
events={
'nationals':dict(slug='2025-musto-australian-optimist-championship',name='2025 Musto Australian Optimist Championship',startDate='2025-01-10',endDate='2025-01-18',venue='Royal Queensland Yacht Squadron, Manly, Queensland, Australia',organizer='Royal Queensland Yacht Squadron and AIODA'),
'nsw':dict(slug='2025-nsw-optimist-championship',name='2025 NSW Optimist Championship',startDate='2025-04-05',endDate='2025-04-06',venue='Toronto Amateur Sailing Club, Lake Macquarie, NSW, Australia',organizer='Toronto Amateur Sailing Club and NSW IODA'),
'victoria':dict(slug='2025-victorian-optimist-open-championship',name='2025 Organic Garden International Optimist Victorian & Open Championship',startDate='2025-03-08',endDate='2025-03-10',venue='Sorrento Sailing Couta Boat Club, Port Phillip, Victoria, Australia',organizer='Sorrento Sailing Couta Boat Club and VIODA')}
for k,e in events.items():e.update(id=uid('event:'+k),classes=['Optimist'])
for doc in tables:
 f=doc['file']
 if f in ('victoria-entries.html','victoria-index.html'):continue
 key=f.split('-')[0].split('.')[0];event=events[key]
 for ti,t in enumerate(doc['tables']):
  if not t:continue
  division=(['Gold','Silver'][ti] if f=='nationals-open.html' else ['Open','Intermediate'][ti] if f=='nsw.html' else f.split('-')[1].split('.')[0].title())
  slug=event['slug']+'-optimist-'+division.lower();good=[];held=[];h=t[0]
  rs=next(i for i,x in enumerate(h) if x in ('1','R1'));tc=next(i for i,x in enumerate(h) if x in ('TotalPoints','Total'));racecols=h[rs:tc]
  for v in t[1:]:
   source_name=v[h.index('HelmName') if key=='nsw' else h.index('Name')];name=source_name;sail=v[h.index('SailNo') if key=='nsw' else h.index('SailNum')];club=v[h.index('Club')]
   identity_note=''
   if key=='victoria':
    ab=source_name.split();hits={x[3] for x in entries if norm(x[1])==norm(sail) and norm(x[3].split()[0])==norm(ab[0]) and norm(x[3].split()[1]).startswith(norm(ab[-1]))}
    if len(hits)==1:
     name=hits.pop();identity_note=f'Full name corroborated by official entry list: {source_name}, sail {sail} -> {name}. '
     resolutions.append(dict(sourceName=source_name,name=name,sail=sail,division=division))
    else:
     held.append(dict(name=name,sailOrBoardNumber=sail,rank=int(re.search(r'\d+',v[0])[0]),reason='Abbreviated name cannot be uniquely corroborated against official entry list.'));continue
   races=[]
   for col,raw in zip(racecols,v[rs:tc]):
    val=re.search(r'\d+(?:\.\d+)?',raw);assert val,(f,name,raw)
    code=re.search(r'[A-Z]+',raw)
    races.append(dict(raceNumber=int(re.search(r'\d+',col)[0]),raw=raw,score=float(val[0]),code=code[0] if code else None,discarded=raw.startswith('(')))
   r=dict(rank=int(re.search(r'\d+',v[0])[0]),name=name,sailOrBoardNumber=sail,club=club,grossScore=float(v[tc]),nettScore=float(v[tc+1]),races=races,gender='F' if re.search(r'\bF\b',v[-1]) else None,nationality=None,officialBirthYear=None,sourceName=source_name)
   if abs(sum(x['score'] for x in races)-r['grossScore'])>.001 or abs(sum(x['score'] for x in races if not x['discarded'])-r['nettScore'])>.001:
    issues.append(dict(event=key,division=division,**r));continue
   hits=index[norm(name)]
   aliases={
    ('Shreya LAKSHMINARAYANAN','1632'):('Shreya Krishna Lakshminarayanan','1632'),
    ('Samual DARBYSHIRE','1620'):('Samuel Darbyshire','1620'),
    ('Sam Darbyshire','1620'):('Samuel Darbyshire','1620'),
    ('Josh Bacon','978'):('Joshua BACON','978'),
   }
   if (name,sail) in aliases:
    target,expected_sail=aliases[(name,sail)]
    hits=[s for s in profiles if s['name']==target and norm(s.get('sailNumber') or '')==norm(expected_sail)]
    assert len(hits)==1,(name,'reviewed alias no longer matches')
    identity_note+=f'Reviewed source name variant matched to {target} using exact historic Optimist sail {sail}. '
   if name=='Josh Dale' and sail=='1715':
    corroborating=[r for m0 in manifests for r in m0['results'] if norm(r['name'])=='joshuadale' and r['sailOrBoardNumber']=='1715' and r['club']=='RQYS']
    assert len(corroborating)==1
    hits=[s for s in profiles if s['id']==corroborating[0]['sailorId']]
    identity_note+='Josh Dale corroborated as Joshua Dale by Nationals full name, exact sail 1715 and RQYS club. '
   if len(hits)>1:
    same=[s for s in hits if norm(s.get('sailNumber') or '')==norm(sail)]
    if len(same)==1:hits=same
   if len(hits)==1:s=hits[0];basis='Unique normalized full name, or exact-name collision disambiguated by source sail. Existing profile unchanged.'
   else:
    near=sorted([(difflib.SequenceMatcher(None,norm(name),norm(s['name'])).ratio(),s) for s in profiles],key=lambda x:x[0],reverse=True)[:3]
    if hits or (near and near[0][0]>=.84):
     held.append(dict(r,reason='Close/ambiguous existing identity; held.',candidates=[dict(id=s['id'],name=s['name'],sail=s['sailNumber'],similarity=round(v,3)) for v,s in near]));continue
    sid=uid('sailor:'+norm(name));s=dict(id=sid,name=name,handle=re.sub('[^a-z0-9]+','-',name.lower()).strip('-')+'-aus25-'+sid[:6],sailNumber=sail,sailNumberIlca4=None,club=club,gender=r['gender'],nationality=None)
    new[sid]=s;index[norm(name)].append(s);profiles.append(s);basis='Distinct full source name; no close existing-name candidate. No DOB or nationality inferred.'
   r.update(sailorId=s['id'],resultId=uid('result:'+slug+':'+str(r['rank'])),identityBasis=identity_note+basis)
   r['participants']=[dict(id=uid('participant:'+r['resultId']),sailorId=s['id'],sourceName=source_name,displayOrder=1,role='solo')]
   source_note='Official organiser-hosted PDF rendered and visible columns compared; Open and Green PDFs clip right-hand columns, completed from official HTML.' if key=='nationals' else 'Official results HTML used; no official results PDF located after organiser/class noticeboard and web search.'
   r['evidenceNotes']=f'{source_note} Source: {doc["url"]}. Optimist {division}; source name {source_name}; historic sail {sail}; club {club}. {identity_note}{basis} Source race labels retained: {", ".join(racecols)}. No birth year inferred.'
   good.append(r)
  m=dict(batch='australia-optimist-2025-2026-10-30',event=event,sheet=dict(id=uid('sheet:'+slug),slug=slug,name=event['name']+' — Optimist '+division,boatClass='Optimist',division=division,raceCount=len(racecols),totalFleetSize=len(t)-1,entryType='individual',minParticipants=1,maxParticipants=1,status='draft'),officialSource=dict(url=doc['url'],title=event['name']+' — Optimist '+division,type='url',provisional=False,publicationStatus='published overall standings',visuallyReviewed=key=='nationals',pdfUrl=('https://results.rqys.com.au/ResultsArchive/2025/2025%20Musto%20Australian%20Optimist%20Championship/Overall%20Results%20-%20'+('Open' if division in ('Gold','Silver') else division)+'%20Fleet.pdf') if key=='nationals' else None,pdfLimitation='Open and Green PDF right-hand columns clipped; complete values from official HTML.' if key=='nationals' else 'Official results PDF not located.'),results=good,importedEntryCount=len(good),deferredEntryCount=len(held),pendingEntries=held,publicSummary=f'Partial import: {len(good)} of {len(t)-1} entries; {len(held)} entries awaiting identity review. Published overall standings; source race labels {", ".join(racecols)} retained. Excluded from Singapore rankings.',identityReview=dict(method='Full names; exact source sails disambiguate collisions; close names held. Victorian initials corroborated with official entry list.'))
  ids={r['sailorId'] for r in good};assert len(ids)==len(good),(slug,'duplicate identity')
  m['profilePreflight']=[s for sid,s in existing.items() if sid in ids];m['newProfiles']=[s for sid,s in new.items() if sid in ids]
  (P/(slug+'.json')).write_text(json.dumps(m,indent=2));manifests.append(m);pending.extend(dict(event=key,division=division,**r) for r in held)
template=(P.parent/'sail-result-2026/transaction-template.sql').read_text().replace('results.import_official_sailresult2026','results.import_official_aus_opti2025').replace("'published'","'draft'").replace("'THA'","'AUS'").replace('Imported reviewed 2026 official race scores','Imported reviewed 2025 Australian Optimist race scores')
for m in manifests:
 (P/(m['sheet']['slug']+'.sql')).write_text(template.replace('__MANIFEST__',json.dumps(m,separators=(',',':'))))
(P/'pending.json').write_text(json.dumps(pending,indent=2));(P/'score-issues.json').write_text(json.dumps(issues,indent=2));(P/'name-resolutions.json').write_text(json.dumps(resolutions,indent=2))
(P/'inventory.json').write_text(json.dumps([dict(file=m['sheet']['slug']+'.sql',entries=len(m['results']),held=m['deferredEntryCount'],total=m['sheet']['totalFleetSize'],raceScores=sum(len(r['races']) for r in m['results'])) for m in manifests],indent=2))
(P/'import-batch.sql').write_text('begin;\n'+'\n'.join((P/(m['sheet']['slug']+'.sql')).read_text().strip().removeprefix('begin;').removesuffix('commit;') for m in manifests)+'\ncommit;\n')
print((P/'inventory.json').read_text());print('Score issues',len(issues),'identity holds',len(pending),'new profiles',len(new))
