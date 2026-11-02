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

// Special corroborated mappings for established Singapore squad members
const explicitMappings = new Map([
  // Ryan Lo
  ['lojunhanryan_SGP', { id: 'df7c6bd6-12f7-412b-994a-f116e820e30d', name: 'Ryan Lo Jun Han', basis: 'Corroborated Singapore national squad Olympian identity' }],
  ['ryanlojunhan_SGP', { id: 'df7c6bd6-12f7-412b-994a-f116e820e30d', name: 'Ryan Lo Jun Han', basis: 'Corroborated Singapore national squad Olympian identity' }],
  // Isaac Goh
  ['isaacgoh_SGP', { id: '93fc1c81-1ec7-4600-b9a1-bc613d11449c', name: 'Isaac Goh', basis: 'Corroborated Singapore national squad athlete identity' }],
  ['gohisaac_SGP', { id: '93fc1c81-1ec7-4600-b9a1-bc613d11449c', name: 'Isaac Goh', basis: 'Corroborated Singapore national squad athlete identity' }],
  // Keira Marie Carlyle
  ['keiramariecarlyle_SGP', { id: 'be779040-d45c-4052-b458-9c9e88803505', name: 'Keira Carlyle', basis: 'Corroborated Singapore national squad athlete identity' }],
  ['carlylekeiramarie_SGP', { id: 'be779040-d45c-4052-b458-9c9e88803505', name: 'Keira Carlyle', basis: 'Corroborated Singapore national squad athlete identity' }],
  // Victoria Chan
  ['chanjinghuavictoria_SGP', { id: '97cbde3f-9b92-5b2b-abbd-416a43ad32c9', name: 'Victoria Chan', basis: 'Corroborated Singapore national squad Asian Games medalist identity' }],
  ['victoriachanjinghua_SGP', { id: '97cbde3f-9b92-5b2b-abbd-416a43ad32c9', name: 'Victoria Chan', basis: 'Corroborated Singapore national squad Asian Games medalist identity' }],
  ['victoriachan_SGP', { id: '97cbde3f-9b92-5b2b-abbd-416a43ad32c9', name: 'Victoria Chan', basis: 'Corroborated Singapore national squad Asian Games medalist identity' }],
  // Koh Yi Nian
  ['kohyinian_SGP', { id: 'd2c42f1a-b69c-4006-a762-60f9cbc0bfad', name: 'Koh Yi Nian', basis: 'Corroborated Singapore national squad 49er sailor identity' }],
  ['yiniankoh_SGP', { id: 'd2c42f1a-b69c-4006-a762-60f9cbc0bfad', name: 'Koh Yi Nian', basis: 'Corroborated Singapore national squad 49er sailor identity' }],
  // Tan Jen-E
  ['tanjen-e_SGP', { id: '60428513-1239-4efc-9201-2ff975e5349a', name: 'Tan Jen-E', basis: 'Corroborated Singapore national squad 49er sailor identity', create: true, gender: 'M' }],
  ['tanjen_SGP', { id: '60428513-1239-4efc-9201-2ff975e5349a', name: 'Tan Jen-E', basis: 'Corroborated Singapore national squad 49er sailor identity', create: true, gender: 'M' }],
  // Kimberly Lim & Cecilia Low
  ['limkimberlymin_SGP', { id: 'fde81842-e9a6-4520-b233-1e48a3e7db2a', name: 'Kimberly Min Lim', basis: 'Corroborated Singapore national squad 49erFX Olympian identity', create: true, gender: 'F' }],
  ['kimberlyminlim_SGP', { id: 'fde81842-e9a6-4520-b233-1e48a3e7db2a', name: 'Kimberly Min Lim', basis: 'Corroborated Singapore national squad 49erFX Olympian identity', create: true, gender: 'F' }],
  ['lowruiqicecilia_SGP', { id: '62779f65-6235-407b-a5a4-4cbb203d8888', name: 'Cecilia Rui Qi Low', basis: 'Corroborated Singapore national squad 49erFX Olympian identity', create: true, gender: 'F' }],
  ['ceciliaruiqilow_SGP', { id: '62779f65-6235-407b-a5a4-4cbb203d8888', name: 'Cecilia Rui Qi Low', basis: 'Corroborated Singapore national squad 49erFX Olympian identity', create: true, gender: 'F' }],
  // Elkan Reshawn Oh
  ['elkanreshawnoh_SGP', { id: 'dbe45d3e-6640-4242-b347-f8ce6030a26c', name: 'Elkan Oh', basis: 'Corroborated Singapore national squad iQFoil athlete identity' }],
  ['ohelkanreshawn_SGP', { id: 'dbe45d3e-6640-4242-b347-f8ce6030a26c', name: 'Elkan Oh', basis: 'Corroborated Singapore national squad iQFoil athlete identity' }],
  // Marsha Binte Shahrin
  ['marshabinteshahrin_SGP', { id: '80419c1d-1ffc-4e6b-9c75-d94a7516df6b', name: 'Marsha Shahrin', basis: 'Corroborated Singapore national squad iQFoil athlete identity' }],
  ['shahrinmarshabinte_SGP', { id: '80419c1d-1ffc-4e6b-9c75-d94a7516df6b', name: 'Marsha Shahrin', basis: 'Corroborated Singapore national squad iQFoil athlete identity' }]
]);

function cleanCell(c) {
  if (!c) return '';
  const closeIdx = c.indexOf('>');
  const inner = closeIdx !== -1 ? c.slice(closeIdx + 1) : c;
  return inner.replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim();
}

function parseScoreCell(tdHtml) {
  if (!tdHtml) return null;
  const closeIdx = tdHtml.indexOf('>');
  const inner = closeIdx !== -1 ? tdHtml.slice(closeIdx + 1) : tdHtml;
  const isDiscarded = inner.includes('text-danger') || inner.includes('sr-only') || inner.includes('<del') || inner.includes('Discarded');
  const clean = inner.replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim();
  if (!clean) return null;

  let code = null;
  const codeMatch = clean.match(/\b(DNC|DNS|BFD|UFD|DNF|DSQ|RET|STP|DNE|DPI|OCS|RDG)\b/i);
  if (codeMatch) code = codeMatch[1].toUpperCase();

  const numMatch = clean.match(/(\d+(?:\.\d+)?)/);
  if (!numMatch) return null;
  return { score: parseFloat(numMatch[1]), code, discarded: isDiscarded, raw: clean };
}

// Global registry of newly created profiles across Batch B
const batchBNewProfiles = new Map();

function matchOrCreateSailor(cleanName, kNat, gender) {
  const kName = nameKey(cleanName);
  const lookupKey = `${kName}_${kNat}`;

  // 1. Explicit Singapore squad mapping
  if (explicitMappings.has(lookupKey)) {
    const exp = explicitMappings.get(lookupKey);
    if (exp.create && !batchBNewProfiles.has(lookupKey)) {
      const newProf = {
        id: exp.id,
        name: exp.name,
        handle: `${slugify(exp.name)}-ag22-${kNat.toLowerCase()}`,
        sail_number: '',
        sail_number_ilca4: null,
        gender: exp.gender || gender,
        nationality: kNat,
        club: 'N/A',
        school: null
      };
      batchBNewProfiles.set(lookupKey, newProf);
      return { sailorId: exp.id, isNewProfile: true, identityBasis: exp.basis, officialName: exp.name };
    }
    return { sailorId: exp.id, isNewProfile: false, identityBasis: exp.basis, officialName: exp.name };
  }

  // 2. Batch B already registered
  if (batchBNewProfiles.has(lookupKey)) {
    const bp = batchBNewProfiles.get(lookupKey);
    return { sailorId: bp.id, isNewProfile: false, identityBasis: `Matched newly established Batch B athlete profile (${bp.name}, ${bp.nationality})`, officialName: bp.name };
  }

  // 3. Exact Name + Nat match in DB
  const exactNat = sailorsByNameAndNat.get(`${kName}_${kNat}`) || [];
  if (exactNat.length === 1) {
    return { sailorId: exactNat[0].id, isNewProfile: false, identityBasis: `Exact normalized name and nationality match (${exactNat[0].name})`, officialName: exactNat[0].name };
  }

  // 4. Inverted name + Nat
  const parts = cleanName.trim().split(/\s+/);
  if (parts.length >= 2) {
    const inv = parts[parts.length - 1] + ' ' + parts.slice(0, parts.length - 1).join(' ');
    const kinv = nameKey(inv);
    const invNat = sailorsByNameAndNat.get(`${kinv}_${kNat}`) || [];
    if (invNat.length === 1) {
      return { sailorId: invNat[0].id, isNewProfile: false, identityBasis: `Inverted name and nationality match (${invNat[0].name})`, officialName: invNat[0].name };
    }
    const invAlias = sailorsByAlias.get(kinv) || [];
    if (invAlias.length === 1) {
      return { sailorId: invAlias[0].id, isNewProfile: false, identityBasis: `Inverted name registered alias match (${invAlias[0].name})`, officialName: invAlias[0].name };
    }
  }

  // 5. Corroborated alias match
  const aliasCandidates = sailorsByAlias.get(kName) || [];
  if (aliasCandidates.length === 1) {
    return { sailorId: aliasCandidates[0].id, isNewProfile: false, identityBasis: `Corroborated registered sailor alias match (${aliasCandidates[0].name})`, officialName: aliasCandidates[0].name };
  }

  // 6. Name only if unique and no nationality conflict
  const nameOnly = sailorsByNameOnly.get(kName) || [];
  if (nameOnly.length === 1 && (!nameOnly[0].nationality || nameOnly[0].nationality === kNat)) {
    return { sailorId: nameOnly[0].id, isNewProfile: false, identityBasis: `Exact normalized name match (${nameOnly[0].name}, ${nameOnly[0].nationality || 'unspecified'})`, officialName: nameOnly[0].name };
  }

  // 7. Create new profile
  const sailorId = uuidv4();
  const newProf = {
    id: sailorId,
    name: cleanName,
    handle: `${slugify(cleanName)}-ag22-${kNat.toLowerCase()}`,
    sail_number: '',
    sail_number_ilca4: null,
    gender,
    nationality: kNat || null,
    club: 'N/A',
    school: null
  };
  batchBNewProfiles.set(lookupKey, newProf);

  return {
    sailorId,
    isNewProfile: true,
    identityBasis: 'No established existing profile; creating source-faithful profile with official NOC and gender',
    officialName: cleanName
  };
}

const evidenceNotesBase = 'Official OCA/Atos 19th Asian Games Information System results archive. Event held at Ningbo Xiangshan Sailing Centre, Sep 21-27, 2023. Host server now decommissioned; all race scores, discards, and net totals independently transcribed and reconciled against visible tables.';

function parseSingleHandedFile(filePath, config) {
  const html = fs.readFileSync(filePath, 'utf8');
  const tableMatch = html.match(/<table[^>]*class="[^"]*table-result[^"]*"[^>]*>([\s\S]*?)<\/table>/i);
  const rows = tableMatch[1].split(/<tr/i).slice(2);

  const results = [];
  for (const r of rows) {
    const cells = r.split(/<td/i).slice(1);
    if (cells.length < 5) continue;

    const rank = parseInt(cleanCell(cells[0]), 10);
    const country = cleanCell(cells[1]).toUpperCase();
    const nameMatch = cells[2].match(/class="d-none d-md-inline">([^<]+)/);
    const rawName = nameMatch ? nameMatch[1].trim() : cleanCell(cells[2]);
    const cleanName = normalizeName(rawName);

    const grossScore = parseFloat(cleanCell(cells[3]));
    const nettScore = parseFloat(cleanCell(cells[4]));

    const races = [];
    let grossCheck = 0;
    let netCheck = 0;
    let discards = 0;

    for (let c = 5; c < cells.length; c++) {
      const parsed = parseScoreCell(cells[c]);
      if (!parsed) continue;
      const raceNumber = races.length + 1;
      races.push({
        raceNumber,
        score: parsed.score,
        code: parsed.code,
        discarded: parsed.discarded,
        raw: parsed.raw,
        sourceColumn: `${raceNumber}`
      });
      grossCheck += parsed.score;
      if (parsed.discarded) discards++;
      else netCheck += parsed.score;
    }

    if (Math.abs(grossCheck - grossScore) > 0.01) {
      throw new Error(`Gross score mismatch at rank ${rank} (${cleanName}): calculated ${grossCheck} != printed ${grossScore}`);
    }
    if (Math.abs(netCheck - nettScore) > 0.01) {
      throw new Error(`Net score mismatch at rank ${rank} (${cleanName}): calculated ${netCheck} != printed ${nettScore}`);
    }

    const sailorMatch = matchOrCreateSailor(cleanName, country, config.gender);

    results.push({
      rank,
      ordinal: rank,
      sourceName: rawName,
      name: cleanName,
      sailOrBoardNumber: '',
      nationality: country,
      gender: config.gender,
      grossScore,
      nettScore,
      races,
      sailorId: sailorMatch.sailorId,
      resultId: uuidv4(),
      participantId: uuidv4(),
      isNewProfile: sailorMatch.isNewProfile,
      identityBasis: sailorMatch.identityBasis,
      sourceNationality: country,
      officialName: sailorMatch.officialName,
      evidenceNotes: `${evidenceNotesBase} Class: ${config.boatClass}. Printed name: ${rawName}; NOC: ${country}.`
    });
  }

  return results;
}

function parseTwoPersonFile(filePath, config) {
  const html = fs.readFileSync(filePath, 'utf8');
  const tableMatch = html.match(/<table[^>]*class="[^"]*table-result[^"]*"[^>]*>([\s\S]*?)<\/table>/i);
  const rows = tableMatch[1].split(/<tr/i).slice(2);

  const results = [];
  for (let i = 0; i < rows.length; i++) {
    const r = rows[i];
    const cells = r.split(/<td/i).slice(1);
    if (cells.length < 7) continue;

    const rank = parseInt(cleanCell(cells[0]), 10);
    const country = cleanCell(cells[1]).toUpperCase();

    const helmMatch = cells[2].match(/class="d-none d-md-inline">([^<]+)/);
    const rawHelmName = helmMatch ? helmMatch[1].trim() : cleanCell(cells[2]);
    const cleanHelmName = normalizeName(rawHelmName);

    // Crew is in next row
    let rawCrewName = '';
    let cleanCrewName = '';
    if (i + 1 < rows.length) {
      const crewCells = rows[i + 1].split(/<td/i).slice(1);
      if (crewCells.length >= 1) {
        const cMatch = crewCells[0].match(/class="d-none d-md-inline">([^<]+)/);
        rawCrewName = cMatch ? cMatch[1].trim() : cleanCell(crewCells[0]);
        cleanCrewName = normalizeName(rawCrewName);
      }
    }

    const grossScore = parseFloat(cleanCell(cells[4]));
    const nettScore = parseFloat(cleanCell(cells[5]));

    const races = [];
    let grossCheck = 0;
    let netCheck = 0;
    let discards = 0;

    for (let c = 6; c < cells.length; c++) {
      const parsed = parseScoreCell(cells[c]);
      if (!parsed) continue;
      const raceNumber = races.length + 1;
      races.push({
        raceNumber,
        score: parsed.score,
        code: parsed.code,
        discarded: parsed.discarded,
        raw: parsed.raw,
        sourceColumn: `${raceNumber}`
      });
      grossCheck += parsed.score;
      if (parsed.discarded) discards++;
      else netCheck += parsed.score;
    }

    if (Math.abs(grossCheck - grossScore) > 0.01) {
      throw new Error(`Gross score mismatch at rank ${rank} (${cleanHelmName} / ${cleanCrewName}): calculated ${grossCheck} != printed ${grossScore}`);
    }
    if (Math.abs(netCheck - nettScore) > 0.01) {
      throw new Error(`Net score mismatch at rank ${rank} (${cleanHelmName} / ${cleanCrewName}): calculated ${netCheck} != printed ${nettScore}`);
    }

    const helmMatchData = matchOrCreateSailor(cleanHelmName, country, config.gender);
    const crewMatchData = matchOrCreateSailor(cleanCrewName, country, config.gender);

    const teamLabel = `${cleanHelmName} / ${cleanCrewName}`;

    results.push({
      rank,
      ordinal: rank,
      sourceName: `${rawHelmName} / ${rawCrewName}`,
      name: teamLabel,
      sailOrBoardNumber: '',
      nationality: country,
      gender: config.gender,
      grossScore,
      nettScore,
      races,
      sailorId: helmMatchData.sailorId, // Primary anchor
      resultId: uuidv4(),
      participants: [
        {
          id: uuidv4(),
          sailorId: helmMatchData.sailorId,
          sourceName: rawHelmName,
          name: cleanHelmName,
          role: 'helm',
          displayOrder: 1,
          isNewProfile: helmMatchData.isNewProfile,
          identityBasis: helmMatchData.identityBasis
        },
        {
          id: uuidv4(),
          sailorId: crewMatchData.sailorId,
          sourceName: rawCrewName,
          name: cleanCrewName,
          role: 'crew',
          displayOrder: 2,
          isNewProfile: crewMatchData.isNewProfile,
          identityBasis: crewMatchData.identityBasis
        }
      ],
      sourceNationality: country,
      officialName: teamLabel,
      evidenceNotes: `${evidenceNotesBase} Class: ${config.boatClass}. Helm: ${rawHelmName}; Crew: ${rawCrewName}; NOC: ${country}.`
    });
  }

  return results;
}

function parseIqFoilFile(filePath, config) {
  const html = fs.readFileSync(filePath, 'utf8');
  const tableMatch = html.match(/<table[^>]*class="[^"]*table-result[^"]*"[^>]*>([\s\S]*?)<\/table>/i);
  const rows = tableMatch[1].split(/<tr/i).slice(2);

  const results = [];
  for (const r of rows) {
    const cells = r.split(/<td/i).slice(1);
    if (cells.length < 22) continue;

    const rank = parseInt(cleanCell(cells[0]), 10);
    const country = cleanCell(cells[1]).toUpperCase();
    const nameMatch = cells[2].match(/class="d-none d-md-inline">([^<]+)/);
    const rawName = nameMatch ? nameMatch[1].trim() : cleanCell(cells[2]);
    const cleanName = normalizeName(rawName);

    // Races are cells 3 to 20 (18 opening series races)
    const races = [];
    let grossCheck = 0;
    let netCheck = 0;
    let discards = 0;

    for (let c = 3; c <= 20; c++) {
      const parsed = parseScoreCell(cells[c]);
      if (!parsed) continue;
      const raceNumber = races.length + 1;
      races.push({
        raceNumber,
        score: parsed.score,
        code: parsed.code,
        discarded: parsed.discarded,
        raw: parsed.raw,
        sourceColumn: `${raceNumber}`
      });
      grossCheck += parsed.score;
      if (parsed.discarded) discards++;
      else netCheck += parsed.score;
    }

    const grossScore = parseFloat(cleanCell(cells[21]));
    const nettScore = parseFloat(cleanCell(cells[22]));

    if (Math.abs(grossCheck - grossScore) > 0.01) {
      throw new Error(`Gross score mismatch at rank ${rank} (${cleanName}): calculated ${grossCheck} != printed ${grossScore}`);
    }
    if (Math.abs(netCheck - nettScore) > 0.01) {
      throw new Error(`Net score mismatch at rank ${rank} (${cleanName}): calculated ${netCheck} != printed ${nettScore}`);
    }

    const sailorMatch = matchOrCreateSailor(cleanName, country, config.gender);

    results.push({
      rank,
      ordinal: rank,
      sourceName: rawName,
      name: cleanName,
      sailOrBoardNumber: '',
      nationality: country,
      gender: config.gender,
      grossScore,
      nettScore,
      races,
      sailorId: sailorMatch.sailorId,
      resultId: uuidv4(),
      participantId: uuidv4(),
      isNewProfile: sailorMatch.isNewProfile,
      identityBasis: sailorMatch.identityBasis,
      sourceNationality: country,
      officialName: sailorMatch.officialName,
      evidenceNotes: `${evidenceNotesBase} Class: ${config.boatClass}. Printed name: ${rawName}; NOC: ${country}.`
    });
  }

  return results;
}

// 8 Sheets definitions
const sheetsConfig = [
  {
    file: 'overall-results-ilca4-boy-s.htm',
    parser: parseSingleHandedFile,
    id: 'b1a02023-a510-48e0-8002-000000000001',
    slug: '19th-asian-games-hangzhou-2022-sailing-ilca4-boys',
    name: '19th Asian Games Hangzhou 2022 (Boy\'s Dinghy - ILCA 4)',
    boatClass: 'ILCA 4',
    division: 'Boy\'s Dinghy',
    gender: 'M',
    raceCount: 11,
    discardCount: 1,
    entryType: 'individual',
    date: '2023-09-21',
    endDate: '2023-09-26'
  },
  {
    file: 'overall-results-ilca4-girl-s.htm',
    parser: parseSingleHandedFile,
    id: 'b1a02023-a510-48e0-8002-000000000002',
    slug: '19th-asian-games-hangzhou-2022-sailing-ilca4-girls',
    name: '19th Asian Games Hangzhou 2022 (Girl\'s Dinghy - ILCA 4)',
    boatClass: 'ILCA 4',
    division: 'Girl\'s Dinghy',
    gender: 'F',
    raceCount: 11,
    discardCount: 1,
    entryType: 'individual',
    date: '2023-09-21',
    endDate: '2023-09-26'
  },
  {
    file: 'overall-results-ilca7-men.htm',
    parser: parseSingleHandedFile,
    id: 'b1a02023-a510-48e0-8002-000000000003',
    slug: '19th-asian-games-hangzhou-2022-sailing-ilca7-men',
    name: '19th Asian Games Hangzhou 2022 (Men\'s Dinghy - ILCA 7)',
    boatClass: 'ILCA 7',
    division: 'Men\'s Dinghy',
    gender: 'M',
    raceCount: 11,
    discardCount: 1,
    entryType: 'individual',
    date: '2023-09-21',
    endDate: '2023-09-27'
  },
  {
    file: 'overall-results-ilca6-women.htm',
    parser: parseSingleHandedFile,
    id: 'b1a02023-a510-48e0-8002-000000000004',
    slug: '19th-asian-games-hangzhou-2022-sailing-ilca6-women',
    name: '19th Asian Games Hangzhou 2022 (Women\'s Single Dinghy - ILCA 6)',
    boatClass: 'ILCA 6',
    division: 'Women\'s Single Dinghy',
    gender: 'F',
    raceCount: 11,
    discardCount: 1,
    entryType: 'individual',
    date: '2023-09-21',
    endDate: '2023-09-27'
  },
  {
    file: 'overall-results-49er-men.htm',
    parser: parseTwoPersonFile,
    id: 'b1a02023-a510-48e0-8002-000000000005',
    slug: '19th-asian-games-hangzhou-2022-sailing-49er-men',
    name: '19th Asian Games Hangzhou 2022 (Men\'s Skiff - 49er)',
    boatClass: '49er',
    division: 'Men\'s Skiff',
    gender: 'M',
    raceCount: 14,
    discardCount: 1,
    entryType: 'crew',
    date: '2023-09-21',
    endDate: '2023-09-26'
  },
  {
    file: 'overall-results-49er-fx-women.htm',
    parser: parseTwoPersonFile,
    id: 'b1a02023-a510-48e0-8002-000000000006',
    slug: '19th-asian-games-hangzhou-2022-sailing-49er-fx-women',
    name: '19th Asian Games Hangzhou 2022 (Women\'s Skiff - 49erFX)',
    boatClass: '49erFX',
    division: 'Women\'s Skiff',
    gender: 'F',
    raceCount: 14,
    discardCount: 1,
    entryType: 'crew',
    date: '2023-09-21',
    endDate: '2023-09-26'
  },
  {
    file: 'overall-results-iqfoil-men.htm',
    parser: parseIqFoilFile,
    id: 'b1a02023-a510-48e0-8002-000000000007',
    slug: '19th-asian-games-hangzhou-2022-sailing-iqfoil-men',
    name: '19th Asian Games Hangzhou 2022 (Men\'s Windsurfing - iQFoil)',
    boatClass: 'iQFoil',
    division: 'Men\'s Windsurfing',
    gender: 'M',
    raceCount: 18,
    discardCount: 3,
    entryType: 'individual',
    date: '2023-09-21',
    endDate: '2023-09-26'
  },
  {
    file: 'overall-results-iqfoil-women.htm',
    parser: parseIqFoilFile,
    id: 'b1a02023-a510-48e0-8002-000000000008',
    slug: '19th-asian-games-hangzhou-2022-sailing-iqfoil-women',
    name: '19th Asian Games Hangzhou 2022 (Women\'s Windsurfing - iQFoil)',
    boatClass: 'iQFoil',
    division: 'Women\'s Windsurfing',
    gender: 'F',
    raceCount: 18,
    discardCount: 3,
    entryType: 'individual',
    date: '2023-09-21',
    endDate: '2023-09-26'
  }
];

const parsedSheets = [];
for (const conf of sheetsConfig) {
  const filePath = `scripts/imports/asian-championships-priority1/sources/asian-games-2023/${conf.file}`;
  const results = conf.parser(filePath, conf);
  console.log(`Parsed ${conf.name}: ${results.length} entries`);
  parsedSheets.push({
    config: conf,
    results
  });
}

const eventManifest = {
  id: 'e1a02023-a510-48e0-8002-000000002023',
  slug: '19th-asian-games-hangzhou-2022-sailing',
  name: '19th Asian Games Hangzhou 2022 (Sailing)',
  startDate: '2023-09-21',
  endDate: '2023-09-27',
  venue: 'Ningbo Xiangshan Sailing Centre, Ningbo, China',
  organizer: 'Hangzhou Asian Games Organising Committee (HAGOC) / Olympic Council of Asia (OCA)',
  norUrl: 'https://www.racingrulesofsailing.org/documents/10653/event'
};

const fullBatchB = {
  batch: 'asian-games-2022-import-2026-10-29',
  event: eventManifest,
  sheets: parsedSheets,
  newProfiles: Array.from(batchBNewProfiles.values())
};

fs.writeFileSync('scripts/imports/asian-championships-priority1/manifest-batch-b.json', JSON.stringify(fullBatchB, null, 2));

console.log(`\n--- Batch B Summary ---`);
console.log(`Total new athlete profiles to create: ${fullBatchB.newProfiles.length}`);
console.log(`Total sheets: ${parsedSheets.length}`);
let totalEntries = 0;
parsedSheets.forEach(s => {
  totalEntries += s.results.length;
});
console.log(`Total entries across all 8 sheets: ${totalEntries}`);

// Generate SQL migration
function buildSql() {
  const payloadJson = JSON.stringify(fullBatchB).replace(/'/g, "''");

  return `-- Migration: Import Batch B — 19th Asian Games Hangzhou 2022 (Sailing)
-- 8 Classes: ILCA 4 Boys, ILCA 4 Girls, ILCA 7 Men, ILCA 6 Women, 49er Men, 49erFX Women, iQFoil Men, iQFoil Women.
-- Source: Official OCA / Atos Games Information System results archive.
-- PDF Search: Examined info.hangzhou2022.cn (decommissioned), ocagames.com/orb/books/Hangzhou_2022/ (no PDF book published), RRS notice board 10653. PDF corroboration unavailable; verified directly from official OCA/Atos Games Information System archive tables.
-- Overseas continental Games policy: counts_for_ranking is false for all sheets and entries.

begin;
set local lock_timeout = '10s';

do $import$
declare
  b jsonb := '${payloadJson}'::jsonb;
  p jsonb;
  s jsonb;
  r jsonb;
  pt jsonb;
  race jsonb;
begin
  -- 1. Insert new sailor profiles
  for p in select value from jsonb_array_elements(b->'newProfiles') loop
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

  -- 2. Insert Parent Event
  if not exists (select 1 from regatta_events where id = (b#>>'{event,id}')::uuid) then
    insert into regatta_events(id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, counts_for_ranking)
    values (
      (b#>>'{event,id}')::uuid,
      b#>>'{event,name}',
      b#>>'{event,slug}',
      (b#>>'{event,startDate}')::date,
      (b#>>'{event,endDate}')::date,
      b#>>'{event,venue}',
      b#>>'{event,organizer}',
      '["ILCA 4", "ILCA 6", "ILCA 7", "49er", "49erFX", "iQFoil"]'::jsonb,
      b#>>'{event,norUrl}',
      false
    );
  end if;

  -- 3. Insert each Sheet and Results
  for s in select value from jsonb_array_elements(b->'sheets') loop
    if not exists (select 1 from regattas where id = (s#>>'{config,id}')::uuid) then
      insert into regattas(id, name, slug, event_id, date, end_date, total_fleet_size, division, race_count, geography, boat_class, entry_type, min_participants, max_participants, counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name, reviewed_at)
      values (
        (s#>>'{config,id}')::uuid,
        s#>>'{config,name}',
        s#>>'{config,slug}',
        (b#>>'{event,id}')::uuid,
        (s#>>'{config,date}')::date,
        (s#>>'{config,endDate}')::date,
        jsonb_array_length(s->'results'),
        s#>>'{config,division}',
        (s#>>'{config,raceCount}')::int,
        'CHN',
        s#>>'{config,boatClass}',
        s#>>'{config,entryType}',
        case when s#>>'{config,entryType}' = 'crew' then 2 else 1 end,
        case when s#>>'{config,entryType}' = 'crew' then 2 else 1 end,
        false,
        b#>>'{event,venue}',
        b#>>'{event,organizer}',
        'published',
        b#>>'{event,norUrl}',
        'Official 19th Asian Games Information System Results',
        now()
      );
    end if;

    for r in select value from jsonb_array_elements(s->'results') loop
      insert into regatta_results(id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes, verification_status, verified_at)
      values (
        (r->>'resultId')::uuid,
        (r->>'sailorId')::uuid,
        (s#>>'{config,id}')::uuid,
        r->>'name',
        r->>'sailOrBoardNumber',
        s#>>'{config,entryType}',
        (r->>'rank')::int,
        (r->>'grossScore')::real,
        (r->>'nettScore')::real,
        r->>'gender',
        r->>'nationality',
        false,
        false,
        b#>>'{event,norUrl}',
        b#>>'{event,norUrl}',
        'Official 19th Asian Games Information System Results',
        'other',
        r->>'evidenceNotes',
        'verified',
        now()
      )
      on conflict (id) do nothing;

      -- Participants insertion
      if s#>>'{config,entryType}' = 'crew' then
        for pt in select value from jsonb_array_elements(r->'participants') loop
          insert into regatta_result_participants(id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
          values (
            (pt->>'id')::uuid,
            (r->>'resultId')::uuid,
            (pt->>'sailorId')::uuid,
            pt->>'name',
            (pt->>'displayOrder')::int,
            pt->>'role',
            'matched',
            false
          )
          on conflict (id) do nothing;
        end loop;
      else
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
      end if;

      -- Race results insertion
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
      'results.import_asian_games_2022',
      'regatta',
      (s#>>'{config,id}')::uuid,
      s#>>'{config,name}',
      'Imported official 19th Asian Games sheet with reconciled scores and participant links.',
      jsonb_build_object(
        'sheetId', s#>>'{config,id}',
        'name', s#>>'{config,name}',
        'entryCount', jsonb_array_length(s->'results'),
        'raceCount', s#>>'{config,raceCount}'
      ),
      b->>'batch'
    );
  end loop;

  -- 4. Post-flight Integrity Assertions
  if (select count(*) from regatta_results where regatta_id in (select (value#>>'{config,id}')::uuid from jsonb_array_elements(b->'sheets'))) <> 70 then
    raise exception 'Entry count mismatch: expected 70';
  end if;

  -- Reconcile score math across all 8 sheets
  if exists (
    select 1 from regatta_race_results rr
    join regatta_results r on r.id = rr.regatta_result_id
    where r.regatta_id in (select (value#>>'{config,id}')::uuid from jsonb_array_elements(b->'sheets'))
    group by rr.regatta_result_id, r.total_score, r.nett_score
    having abs(sum(rr.score) - r.total_score) > 0.01
       or abs(sum(rr.score) filter (where not rr.discarded) - r.nett_score) > 0.01
  ) then
    raise exception 'Score reconciliation failed in Asian Games race results';
  end if;

end
$import$;

commit;
`;
}

const sql = buildSql();
fs.writeFileSync('scripts/imports/asian-championships-priority1/02-import-batch-b.sql', sql);
console.log('Successfully wrote 02-import-batch-b.sql');
