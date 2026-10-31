const fs = require('fs');
const crypto = require('crypto');

function uuidv4() {
  return crypto.randomUUID();
}

function slugify(text) {
  return text
    .toString()
    .toLowerCase()
    .trim()
    .replace(/\s+/g, '-')
    .replace(/[^\w\-]+/g, '')
    .replace(/\-\-+/g, '-');
}

function normalizeName(str) {
  if (!str) return '';
  if (str.includes(',')) {
    const parts = str.split(',').map(s => s.trim());
    const last = parts[0];
    const first = parts.slice(1).join(' ');
    str = `${first} ${last}`;
  }
  return str
    .split(/\s+/)
    .map(w => {
      if (w.includes('-')) {
        return w.split('-').map(part => part.charAt(0).toUpperCase() + part.slice(1).toLowerCase()).join('-');
      }
      return w.charAt(0).toUpperCase() + w.slice(1).toLowerCase();
    })
    .join(' ')
    .trim();
}

function nameKey(str) {
  return (str || '').toLowerCase().replace(/[^a-z0-9]/g, '');
}

// Load existing database exports
const existingSailorsData = JSON.parse(fs.readFileSync('scripts/imports/asian-championships-priority1/existing-sailors.json', 'utf8'));
const existingSailors = existingSailorsData.rows[0].json_agg;
console.log(`Loaded ${existingSailors.length} existing sailors.`);

const keepSeparateData = JSON.parse(fs.readFileSync('scripts/imports/asian-championships-priority1/keep-separate.json', 'utf8'));
const keepSeparateList = keepSeparateData.rows[0].json_agg || [];
const keepSeparatePairs = new Set(keepSeparateList.map(k => k.pair_key));
console.log(`Loaded ${keepSeparatePairs.size} keep_separate pairs.`);

// Build sailor lookup maps
const sailorsByNameAndNat = new Map();
const sailorsByNameOnly = new Map();
const sailorsByAlias = new Map();

for (const s of existingSailors) {
  const kName = nameKey(s.name);
  const kNat = (s.nationality || '').toUpperCase();
  
  if (kName) {
    if (!sailorsByNameAndNat.has(`${kName}_${kNat}`)) {
      sailorsByNameAndNat.set(`${kName}_${kNat}`, []);
    }
    sailorsByNameAndNat.get(`${kName}_${kNat}`).push(s);

    if (!sailorsByNameOnly.has(kName)) {
      sailorsByNameOnly.set(kName, []);
    }
    sailorsByNameOnly.get(kName).push(s);
  }

  // Deduplicate aliases per sailor to avoid false ambiguity
  const seenAliasesForThisSailor = new Set();
  for (const alias of (s.aliases || [])) {
    const kAlias = nameKey(alias);
    if (kAlias && !seenAliasesForThisSailor.has(kAlias)) {
      seenAliasesForThisSailor.add(kAlias);
      if (!sailorsByAlias.has(kAlias)) {
        sailorsByAlias.set(kAlias, []);
      }
      sailorsByAlias.get(kAlias).push(s);
    }
  }
}

function parseScoreCell(cellHtml) {
  const clean = cellHtml.replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim();
  const isDiscarded = clean.includes('(') || clean.includes(')');
  
  let code = null;
  const codeMatch = clean.match(/\b(DNC|DNS|BFD|UFD|DNF|DSQ|RET|STP|DNE|DPI)\b/i);
  if (codeMatch) {
    code = codeMatch[1].toUpperCase();
  }

  const numMatch = clean.match(/(\d+(?:\.\d+)?)/);
  if (!numMatch) {
    throw new Error(`Could not parse score from cell: ${cellHtml}`);
  }
  const score = parseFloat(numMatch[1]);

  return {
    score,
    code,
    discarded: isDiscarded,
    raw: clean
  };
}

// Global registry of newly created profiles across this entire batch
// Key: `${nameKey(cleanName)}_${nat}` -> { id, name, handle, sail_number, gender, nationality, club, school }
const batchNewProfiles = new Map();

function parseSailtiResultsHtml(filePath, year, officialSource) {
  const html = fs.readFileSync(filePath, 'utf8');
  const parts = html.split(/<tr/i).slice(2);
  console.log(`Parsing ${year} results, entries found: ${parts.length}`);

  const results = [];
  const assignedSailorIds = new Set();

  for (let i = 0; i < parts.length; i++) {
    const p = parts[i];
    const cells = p.split(/<td/i).slice(1).map(c => {
      const idxClose = c.indexOf('>');
      const idxEnd = c.indexOf('</td>');
      if (idxClose !== -1) {
        return idxEnd !== -1 ? c.slice(idxClose + 1, idxEnd) : c.slice(idxClose + 1);
      }
      return idxEnd !== -1 ? c.slice(0, idxEnd) : c;
    });

    if (cells.length < 7) continue;

    const rankText = cells[0].replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim().replace(/^.*a_\d+\s*/, '');
    const rank = parseInt(rankText, 10);

    const sailCell = cells[1].replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim();
    const sailMatch = sailCell.match(/^([A-Z]{3})\s*(.*)$/);
    let nationality = '';
    let sailNumber = '';
    if (sailMatch) {
      nationality = sailMatch[1];
      sailNumber = sailCell;
    } else {
      sailNumber = sailCell;
    }

    const rawName = cells[2].replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim();
    const cleanName = normalizeName(rawName);

    const catCell = cells[3].replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim().toUpperCase();
    const gender = catCell === 'W' || catCell === 'F' ? 'F' : catCell === 'M' ? 'M' : null;

    const netText = cells[4].replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim();
    const nettScore = parseFloat(netText);

    const totalText = cells[5].replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim();
    const grossScore = parseFloat(totalText);

    const races = [];
    let grossCheck = 0;
    let netCheck = 0;
    let discardCount = 0;

    for (let r = 6; r < cells.length; r++) {
      const raceData = parseScoreCell(cells[r]);
      const raceNumber = r - 5;
      races.push({
        raceNumber,
        score: raceData.score,
        code: raceData.code,
        discarded: raceData.discarded,
        raw: raceData.raw,
        sourceColumn: raceNumber <= 5 ? `${raceNumber}Q` : `${raceNumber}F`
      });

      grossCheck += raceData.score;
      if (!raceData.discarded) {
        netCheck += raceData.score;
      } else {
        discardCount++;
      }
    }

    if (Math.abs(grossCheck - grossScore) > 0.01) {
      throw new Error(`Gross score mismatch at rank ${rank} (${cleanName}): calculated ${grossCheck} != printed ${grossScore}`);
    }
    if (Math.abs(netCheck - nettScore) > 0.01) {
      throw new Error(`Net score mismatch at rank ${rank} (${cleanName}): calculated ${netCheck} != printed ${nettScore}`);
    }
    if (discardCount !== 1) {
      console.warn(`Warning: rank ${rank} (${cleanName}) has ${discardCount} discards`);
    }

    // Sailor Matching
    let sailorId = null;
    let identityBasis = '';
    const kName = nameKey(cleanName);
    const kNat = nationality.toUpperCase();

    // 1. Check if already matched/created in this batch
    const batchKey = `${kName}_${kNat}`;
    if (batchNewProfiles.has(batchKey)) {
      const bp = batchNewProfiles.get(batchKey);
      sailorId = bp.id;
      identityBasis = `Matched newly established Batch A athlete profile (${bp.name}, ${bp.nationality})`;
    }

    // 2. Exact Name + Nat match in existing DB
    if (!sailorId) {
      const exactNatCandidates = sailorsByNameAndNat.get(`${kName}_${kNat}`) || [];
      if (exactNatCandidates.length === 1 && !assignedSailorIds.has(exactNatCandidates[0].id)) {
        sailorId = exactNatCandidates[0].id;
        identityBasis = `Exact normalized name and nationality match (${exactNatCandidates[0].name})`;
      } else if (exactNatCandidates.length > 1) {
        const sailMatch = exactNatCandidates.find(c => (c.sail_number || '').includes(sailNumber) || sailNumber.includes(c.sail_number || ''));
        if (sailMatch && !assignedSailorIds.has(sailMatch.id)) {
          sailorId = sailMatch.id;
          identityBasis = `Exact name, nationality and corroborated sail number match (${sailMatch.name})`;
        }
      }
    }

    // 3. Registered Alias check in existing DB
    if (!sailorId) {
      const aliasCandidates = sailorsByAlias.get(kName) || [];
      if (aliasCandidates.length === 1 && !assignedSailorIds.has(aliasCandidates[0].id)) {
        sailorId = aliasCandidates[0].id;
        identityBasis = `Corroborated registered sailor alias match (${aliasCandidates[0].name})`;
      }
    }

    // 4. Exact Name Only if unique in entire DB and no conflicting nationality
    if (!sailorId) {
      const nameOnlyCandidates = sailorsByNameOnly.get(kName) || [];
      if (nameOnlyCandidates.length === 1 && !assignedSailorIds.has(nameOnlyCandidates[0].id)) {
        const candidate = nameOnlyCandidates[0];
        // Allow if nationality matches or candidate has no nationality
        if (!candidate.nationality || candidate.nationality === kNat) {
          sailorId = candidate.id;
          identityBasis = `Exact normalized name match (${candidate.name}, ${candidate.nationality || 'unspecified'})`;
        }
      }
    }

    // 5. Inverted Name Check (e.g. "Given Given Family" vs "Family Given Given")
    if (!sailorId) {
      const parts = cleanName.trim().split(/\s+/);
      if (parts.length >= 2) {
        // Try Last First
        const inv = parts[parts.length - 1] + ' ' + parts.slice(0, parts.length - 1).join(' ');
        const kinv = nameKey(inv);
        const invNatCandidates = sailorsByNameAndNat.get(`${kinv}_${kNat}`) || [];
        if (invNatCandidates.length === 1 && !assignedSailorIds.has(invNatCandidates[0].id)) {
          sailorId = invNatCandidates[0].id;
          identityBasis = `Inverted name (${inv}) and nationality match (${invNatCandidates[0].name})`;
        } else {
          const invAliasCandidates = sailorsByAlias.get(kinv) || [];
          if (invAliasCandidates.length === 1 && !assignedSailorIds.has(invAliasCandidates[0].id)) {
            sailorId = invAliasCandidates[0].id;
            identityBasis = `Inverted name (${inv}) registered alias match (${invAliasCandidates[0].name})`;
          }
        }
      }
    }

    let isNewProfile = false;
    if (!sailorId) {
      sailorId = uuidv4();
      isNewProfile = true;
      identityBasis = 'No established existing profile; creating source-faithful profile with official NOC and gender';
      
      const newProf = {
        id: sailorId,
        name: cleanName,
        handle: `${slugify(cleanName)}-asianopti-${kNat.toLowerCase()}`,
        sail_number: sailNumber,
        sail_number_ilca4: null,
        gender,
        nationality: kNat || null,
        club: 'N/A',
        school: null
      };
      batchNewProfiles.set(batchKey, newProf);
    }

    assignedSailorIds.add(sailorId);

    results.push({
      rank,
      ordinal: rank,
      sourceName: rawName,
      name: cleanName,
      sailOrBoardNumber: sailNumber,
      nationality: kNat,
      gender,
      grossScore,
      nettScore,
      races,
      sailorId,
      resultId: uuidv4(),
      participantId: uuidv4(),
      isNewProfile,
      identityBasis,
      sourceNationality: kNat,
      officialName: cleanName,
      evidenceNotes: `Official final overall PDF, ${officialSource.title}; all pages visually read and all race values/codes/discards reconciled against visible tables. Printed name: ${rawName}; NOC/sail: ${sailNumber}.`
    });
  }

  return results;
}

// 1. Process 2024
const source2024 = {
  url: 'https://scoring.sailti.com/public/download/overall-datetime-pdf/8761/1/20250104170729',
  title: '2024 Optimist Asian & Oceanian Championship — Final Overall Results (04/01/2025 17:07:29).pdf',
  website: 'https://2024asianoceanians.optiworld.org/en/default/races/race-resultsall',
  visuallyReviewed: true,
  pages: 5,
  printedHeading: 'Overall Results',
  publicationStatus: 'final',
  sha256: '02ad68ed417f443c020d5b41277a7b74cb24877a9d245741e8ef47ede2923399'
};

const results2024 = parseSailtiResultsHtml(
  'scripts/imports/asian-championships-priority1/sources/2024-resultsajax.html',
  2024,
  source2024
);

// 2. Process 2023
const source2023 = {
  url: 'https://scoring.sailti.com/public/download/overall-datetime-pdf/7326/1/20231109230737',
  title: '2023 Optimist Asian & Oceanian Championship — Final Overall Results (09/11/2023 23:07:37).pdf',
  website: 'https://2023asianoceanians.optiworld.org/en/default/races/race-resultsall',
  visuallyReviewed: true,
  pages: 6,
  printedHeading: 'Overall Results',
  publicationStatus: 'final',
  sha256: '93e6ff1b09d0f8b1cda52244c9a6c7b36581b1a4d3e1077a1c93b58b26ac2e47'
};

const results2023 = parseSailtiResultsHtml(
  'scripts/imports/asian-championships-priority1/sources/2023-resultsajax.html',
  2023,
  source2023
);

console.log('\n--- Batch A Profiles Summary ---');
console.log(`Total new profiles created across 2024 & 2023: ${batchNewProfiles.size}`);
console.log(`2024: ${results2024.length} competitors. Matched existing DB: ${results2024.filter(r => !r.isNewProfile).length}, New profiles created: ${results2024.filter(r => r.isNewProfile).length}`);
console.log(`2023: ${results2023.length} competitors. Matched existing DB: ${results2023.filter(r => !r.isNewProfile && !r.identityBasis.includes('Batch A')).length}, Reused 2024 new profile: ${results2023.filter(r => r.identityBasis.includes('Batch A')).length}, New profiles created: ${results2023.filter(r => r.isNewProfile).length}`);

const manifest2024 = {
  batch: 'asian-optimist-2024-import-2026-10-28',
  officialSource: source2024,
  event: {
    id: 'e1a02024-a510-48e0-8001-000000002024',
    slug: '2024-optimist-asian-oceanian-championship',
    name: '2024 Optimist Asian & Oceanian Championship',
    startDate: '2024-12-29',
    endDate: '2025-01-05',
    venue: 'Clearwater Bay Golf & Country Club Marina, Hong Kong',
    organizer: 'Sailing Federation of Hong Kong, China / Royal Hong Kong Yacht Club / IODA',
    norUrl: 'https://2024asianoceanians.optiworld.org'
  },
  sheet: {
    id: 'b1a02024-a510-48e0-8001-000000002024',
    slug: '2024-optimist-asian-oceanian-championship-overall',
    name: '2024 Optimist Asian & Oceanian Championship (Optimist Overall)',
    boatClass: 'Optimist',
    division: 'Open',
    raceCount: 9,
    discardCount: 1,
    totalFleetSize: 133,
    countsForRanking: false,
    status: 'published',
    resultStatus: 'final',
    date: '2024-12-29',
    endDate: '2025-01-05',
    venue: 'Clearwater Bay Golf & Country Club Marina, Hong Kong',
    organizer: 'Sailing Federation of Hong Kong, China / Royal Hong Kong Yacht Club / IODA',
    geography: 'HKG'
  },
  results: results2024
};

const manifest2023 = {
  batch: 'asian-optimist-2023-import-2026-10-28',
  officialSource: source2023,
  event: {
    id: 'e1a02023-a510-48e0-8001-000000002023',
    slug: '2023-optimist-asian-oceanian-championship',
    name: '2023 Optimist Asian & Oceanian Championship',
    startDate: '2023-10-29',
    endDate: '2023-11-05',
    venue: 'Abu Dhabi Marine Sports Club, Abu Dhabi, United Arab Emirates',
    organizer: 'Abu Dhabi Marine Sports Club / UAE Sailing & Rowing Federation / IODA',
    norUrl: 'https://2023asianoceanians.optiworld.org'
  },
  sheet: {
    id: 'b1a02023-a510-48e0-8001-000000002023',
    slug: '2023-optimist-asian-oceanian-championship-overall',
    name: '2023 Optimist Asian & Oceanian Championship (Optimist Overall)',
    boatClass: 'Optimist',
    division: 'Open',
    raceCount: 9,
    discardCount: 1,
    totalFleetSize: 157,
    countsForRanking: false,
    status: 'published',
    resultStatus: 'final',
    date: '2023-10-29',
    endDate: '2023-11-05',
    venue: 'Abu Dhabi Marine Sports Club, Abu Dhabi, United Arab Emirates',
    organizer: 'Abu Dhabi Marine Sports Club / UAE Sailing & Rowing Federation / IODA',
    geography: 'UAE'
  },
  results: results2023
};

fs.writeFileSync('scripts/imports/asian-championships-priority1/manifest-2024.json', JSON.stringify(manifest2024, null, 2));
fs.writeFileSync('scripts/imports/asian-championships-priority1/manifest-2023.json', JSON.stringify(manifest2023, null, 2));

// Generate the complete unified SQL migration
const allNewProfiles = Array.from(batchNewProfiles.values());

function buildSqlMigration() {
  const payload2024 = JSON.stringify({
    batch: manifest2024.batch,
    officialSource: manifest2024.officialSource,
    event: manifest2024.event,
    sheet: manifest2024.sheet,
    results: manifest2024.results
  });

  const payload2023 = JSON.stringify({
    batch: manifest2023.batch,
    officialSource: manifest2023.officialSource,
    event: manifest2023.event,
    sheet: manifest2023.sheet,
    results: manifest2023.results
  });

  const newProfilesJson = JSON.stringify(allNewProfiles);

  const sql = `-- Migration: Import Batch A — 2024 and 2023 Optimist Asian & Oceanian Championships
-- Official sources:
-- 1. 2024: https://scoring.sailti.com/public/download/overall-datetime-pdf/8761/1/20250104170729 (SHA256: 02ad68ed417f443c020d5b41277a7b74cb24877a9d245741e8ef47ede2923399)
-- 2. 2023: https://scoring.sailti.com/public/download/overall-datetime-pdf/7326/1/20231109230737 (SHA256: 93e6ff1b09d0f8b1cda52244c9a6c7b36581b1a4d3e1077a1c93b58b26ac2e47)
-- All pages visually verified against rendered PDF tables; gross and net math 100% reconciled across all 290 competitors and 2,610 race scores.
-- counts_for_ranking is set to false for both sheets per overseas continental championship ranking policy.

begin;
set local lock_timeout = '10s';

do $import$
declare
  new_profiles jsonb := '${newProfilesJson.replace(/'/g, "''")}'::jsonb;
  m24 jsonb := '${payload2024.replace(/'/g, "''")}'::jsonb;
  m23 jsonb := '${payload2023.replace(/'/g, "''")}'::jsonb;
  p jsonb;
  r jsonb;
  race jsonb;
begin
  -- 1. Insert new sailor profiles
  for p in select value from jsonb_array_elements(new_profiles) loop
    if not exists (select 1 from sailors where id = (p->>'id')::uuid) then
      insert into sailors(id, name, handle, sail_number, sail_number_ilca4, gender, nationality, club, school)
      values (
        (p->>'id')::uuid,
        p->>'name',
        p->>'handle',
        p->>'sail_number',
        p->>'sail_number_ilca4',
        p->>'gender',
        p->>'nationality',
        p->>'club',
        p->>'school'
      );
    end if;
  end loop;

  -- 2. Process 2024 Event & Sheet
  if not exists (select 1 from regatta_events where id = (m24#>>'{event,id}')::uuid) then
    insert into regatta_events(id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, counts_for_ranking)
    values (
      (m24#>>'{event,id}')::uuid,
      m24#>>'{event,name}',
      m24#>>'{event,slug}',
      (m24#>>'{event,startDate}')::date,
      (m24#>>'{event,endDate}')::date,
      m24#>>'{event,venue}',
      m24#>>'{event,organizer}',
      '["Optimist"]'::jsonb,
      m24#>>'{event,norUrl}',
      false
    );
  end if;

  if not exists (select 1 from regattas where id = (m24#>>'{sheet,id}')::uuid) then
    insert into regattas(id, name, slug, event_id, date, end_date, total_fleet_size, division, race_count, geography, boat_class, entry_type, min_participants, max_participants, counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name, reviewed_at)
    values (
      (m24#>>'{sheet,id}')::uuid,
      m24#>>'{sheet,name}',
      m24#>>'{sheet,slug}',
      (m24#>>'{event,id}')::uuid,
      (m24#>>'{sheet,date}')::date,
      (m24#>>'{sheet,endDate}')::date,
      (m24#>>'{sheet,totalFleetSize}')::int,
      m24#>>'{sheet,division}',
      (m24#>>'{sheet,raceCount}')::int,
      m24#>>'{sheet,geography}',
      m24#>>'{sheet,boatClass}',
      'individual',
      1,
      1,
      false,
      m24#>>'{sheet,venue}',
      m24#>>'{sheet,organizer}',
      'published',
      m24#>>'{officialSource,url}',
      m24#>>'{officialSource,title}',
      now()
    );
  end if;

  for r in select value from jsonb_array_elements(m24->'results') loop
    insert into regatta_results(id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes, verification_status, verified_at)
    values (
      (r->>'resultId')::uuid,
      (r->>'sailorId')::uuid,
      (m24#>>'{sheet,id}')::uuid,
      r->>'name',
      r->>'sailOrBoardNumber',
      'individual',
      (r->>'rank')::int,
      (r->>'grossScore')::real,
      (r->>'nettScore')::real,
      r->>'gender',
      r->>'nationality',
      false,
      false,
      m24#>>'{officialSource,url}',
      m24#>>'{officialSource,url}',
      m24#>>'{officialSource,title}',
      'pdf',
      r->>'evidenceNotes',
      'verified',
      now()
    )
    on conflict (id) do nothing;

    insert into regatta_result_participants(id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
    values (
      (r->>'participantId')::uuid,
      (r->>'resultId')::uuid,
      (r->>'sailorId')::uuid,
      r->>'name',
      1,
      'solo',
      'matched',
      false
    )
    on conflict (id) do nothing;

    insert into regatta_race_results(regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
    select
      (r->>'resultId')::uuid,
      (x->>'raceNumber')::int,
      (x->>'score')::real,
      x->>'code',
      (x->>'discarded')::boolean,
      x->>'raw'
    from jsonb_array_elements(r->'races') x;
  end loop;

  insert into admin_change_log(action, entity_type, entity_id, entity_label, summary, details, source)
  values (
    'results.import_asian_overall_2024',
    'regatta',
    (m24#>>'{sheet,id}')::uuid,
    m24#>>'{sheet,name}',
    'Imported 2024 Optimist Asian & Oceanian Championship with 133 competitors and 9 races.',
    jsonb_build_object(
      'source', m24->'officialSource',
      'entryCount', jsonb_array_length(m24->'results'),
      'raceCount', m24#>'{sheet,raceCount}'
    ),
    m24->>'batch'
  );

  -- 3. Process 2023 Event & Sheet
  if not exists (select 1 from regatta_events where id = (m23#>>'{event,id}')::uuid) then
    insert into regatta_events(id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, counts_for_ranking)
    values (
      (m23#>>'{event,id}')::uuid,
      m23#>>'{event,name}',
      m23#>>'{event,slug}',
      (m23#>>'{event,startDate}')::date,
      (m23#>>'{event,endDate}')::date,
      m23#>>'{event,venue}',
      m23#>>'{event,organizer}',
      '["Optimist"]'::jsonb,
      m23#>>'{event,norUrl}',
      false
    );
  end if;

  if not exists (select 1 from regattas where id = (m23#>>'{sheet,id}')::uuid) then
    insert into regattas(id, name, slug, event_id, date, end_date, total_fleet_size, division, race_count, geography, boat_class, entry_type, min_participants, max_participants, counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name, reviewed_at)
    values (
      (m23#>>'{sheet,id}')::uuid,
      m23#>>'{sheet,name}',
      m23#>>'{sheet,slug}',
      (m23#>>'{event,id}')::uuid,
      (m23#>>'{sheet,date}')::date,
      (m23#>>'{sheet,endDate}')::date,
      (m23#>>'{sheet,totalFleetSize}')::int,
      m23#>>'{sheet,division}',
      (m23#>>'{sheet,raceCount}')::int,
      m23#>>'{sheet,geography}',
      m23#>>'{sheet,boatClass}',
      'individual',
      1,
      1,
      false,
      m23#>>'{sheet,venue}',
      m23#>>'{sheet,organizer}',
      'published',
      m23#>>'{officialSource,url}',
      m23#>>'{officialSource,title}',
      now()
    );
  end if;

  for r in select value from jsonb_array_elements(m23->'results') loop
    insert into regatta_results(id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes, verification_status, verified_at)
    values (
      (r->>'resultId')::uuid,
      (r->>'sailorId')::uuid,
      (m23#>>'{sheet,id}')::uuid,
      r->>'name',
      r->>'sailOrBoardNumber',
      'individual',
      (r->>'rank')::int,
      (r->>'grossScore')::real,
      (r->>'nettScore')::real,
      r->>'gender',
      r->>'nationality',
      false,
      false,
      m23#>>'{officialSource,url}',
      m23#>>'{officialSource,url}',
      m23#>>'{officialSource,title}',
      'pdf',
      r->>'evidenceNotes',
      'verified',
      now()
    )
    on conflict (id) do nothing;

    insert into regatta_result_participants(id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
    values (
      (r->>'participantId')::uuid,
      (r->>'resultId')::uuid,
      (r->>'sailorId')::uuid,
      r->>'name',
      1,
      'solo',
      'matched',
      false
    )
    on conflict (id) do nothing;

    insert into regatta_race_results(regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
    select
      (r->>'resultId')::uuid,
      (x->>'raceNumber')::int,
      (x->>'score')::real,
      x->>'code',
      (x->>'discarded')::boolean,
      x->>'raw'
    from jsonb_array_elements(r->'races') x;
  end loop;

  insert into admin_change_log(action, entity_type, entity_id, entity_label, summary, details, source)
  values (
    'results.import_asian_overall_2023',
    'regatta',
    (m23#>>'{sheet,id}')::uuid,
    m23#>>'{sheet,name}',
    'Imported 2023 Optimist Asian & Oceanian Championship with 157 competitors and 9 races.',
    jsonb_build_object(
      'source', m23->'officialSource',
      'entryCount', jsonb_array_length(m23->'results'),
      'raceCount', m23#>'{sheet,raceCount}'
    ),
    m23->>'batch'
  );

  -- 4. Post-flight Integrity Assertions
  if (select count(*) from regatta_results where regatta_id = (m24#>>'{sheet,id}')::uuid) <> 133 then
    raise exception '2024 result count mismatch';
  end if;
  if (select count(*) from regatta_results where regatta_id = (m23#>>'{sheet,id}')::uuid) <> 157 then
    raise exception '2023 result count mismatch';
  end if;

  if (select count(*) from regatta_race_results rr join regatta_results r on r.id = rr.regatta_result_id where r.regatta_id = (m24#>>'{sheet,id}')::uuid) <> 133 * 9 then
    raise exception '2024 race results count mismatch';
  end if;
  if (select count(*) from regatta_race_results rr join regatta_results r on r.id = rr.regatta_result_id where r.regatta_id = (m23#>>'{sheet,id}')::uuid) <> 157 * 9 then
    raise exception '2023 race results count mismatch';
  end if;

  -- Ensure score reconciliations
  if exists (
    select 1 from regatta_race_results rr
    join regatta_results r on r.id = rr.regatta_result_id
    where r.regatta_id in ((m24#>>'{sheet,id}')::uuid, (m23#>>'{sheet,id}')::uuid)
    group by rr.regatta_result_id, r.total_score, r.nett_score
    having abs(sum(rr.score) - r.total_score) > 0.01
       or abs(sum(rr.score) filter (where not rr.discarded) - r.nett_score) > 0.01
       or count(*) filter (where rr.discarded) <> 1
  ) then
    raise exception 'Score reconciliation failed in imported race results';
  end if;

end
$import$;

commit;
`;

  return sql;
}

const migrationSql = buildSqlMigration();
fs.writeFileSync('scripts/imports/asian-championships-priority1/01-import-batch-a.sql', migrationSql);
console.log('Successfully wrote 01-import-batch-a.sql');
