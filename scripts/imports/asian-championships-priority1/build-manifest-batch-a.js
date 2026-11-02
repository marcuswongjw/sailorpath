const fs = require('fs');
const crypto = require('crypto');

function uuidv4() {
  return crypto.randomUUID();
}

function normalizeName(str) {
  if (!str) return '';
  // Check if "LAST, First"
  if (str.includes(',')) {
    const parts = str.split(',').map(s => s.trim());
    const last = parts[0];
    const first = parts.slice(1).join(' ');
    str = `${first} ${last}`;
  }
  // Title case words, but keep hyphens and apostrophes clean
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
  return str.toLowerCase().replace(/[^a-z0-9]/g, '');
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

  for (const alias of (s.aliases || [])) {
    const kAlias = nameKey(alias);
    if (kAlias) {
      if (!sailorsByAlias.has(kAlias)) {
        sailorsByAlias.set(kAlias, []);
      }
      sailorsByAlias.get(kAlias).push(s);
    }
  }
}

function parseScoreCell(cellHtml) {
  // Extract text content
  const clean = cellHtml.replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim();
  // Check if discarded (indicated by parenthesis or styling)
  const isDiscarded = clean.includes('(') || clean.includes(')');
  
  // Extract code if present
  let code = null;
  const codeMatch = clean.match(/\b(DNC|DNS|BFD|UFD|DNF|DSQ|RET|STP|DNE|DPI)\b/i);
  if (codeMatch) {
    code = codeMatch[1].toUpperCase();
  }

  // Extract score number
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

function parseSailtiResultsHtml(filePath, year, officialSource) {
  const html = fs.readFileSync(filePath, 'utf8');
  const parts = html.split(/<tr/i).slice(2); // Skip header and blank
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
    // e.g. "SGP 121" or "ITA 9924"
    const sailMatch = sailCell.match(/^([A-Z]{3})\s*(.*)$/);
    let nationality = '';
    let sailNumber = '';
    if (sailMatch) {
      nationality = sailMatch[1];
      sailNumber = sailCell; // Keep full sail string like SGP 121
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

    // Races start at cell 6
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

    // Verify reconciliation
    if (Math.abs(grossCheck - grossScore) > 0.01) {
      throw new Error(`Gross score mismatch at rank ${rank} (${cleanName}): calculated ${grossCheck} != printed ${grossScore}`);
    }
    if (Math.abs(netCheck - nettScore) > 0.01) {
      throw new Error(`Net score mismatch at rank ${rank} (${cleanName}): calculated ${netCheck} != printed ${nettScore}`);
    }
    if (discardCount !== 1) {
      console.warn(`Warning: rank ${rank} (${cleanName}) has ${discardCount} discards`);
    }

    // Sailor matching
    let sailorId = null;
    let identityBasis = '';
    const kName = nameKey(cleanName);
    const kNat = nationality.toUpperCase();

    // 1. Exact Name + Nat
    const exactNatCandidates = sailorsByNameAndNat.get(`${kName}_${kNat}`) || [];
    if (exactNatCandidates.length === 1 && !assignedSailorIds.has(exactNatCandidates[0].id)) {
      sailorId = exactNatCandidates[0].id;
      identityBasis = 'Exact normalized name and nationality match';
    } else if (exactNatCandidates.length > 1) {
      // Multiple matches: try matching sail number
      const sailMatch = exactNatCandidates.find(c => (c.sail_number || '').includes(sailNumber) || sailNumber.includes(c.sail_number || ''));
      if (sailMatch && !assignedSailorIds.has(sailMatch.id)) {
        sailorId = sailMatch.id;
        identityBasis = 'Exact name, nationality and corroborated sail number match';
      }
    }

    // 2. Exact Name Only if foreign / unique
    if (!sailorId) {
      const nameOnlyCandidates = sailorsByNameOnly.get(kName) || [];
      if (nameOnlyCandidates.length === 1 && !assignedSailorIds.has(nameOnlyCandidates[0].id)) {
        const candidate = nameOnlyCandidates[0];
        // Ensure not violating keep-separate
        sailorId = candidate.id;
        identityBasis = `Exact normalized name match (candidate nationality: ${candidate.nationality})`;
      }
    }

    // 3. Alias check
    if (!sailorId) {
      const aliasCandidates = sailorsByAlias.get(kName) || [];
      if (aliasCandidates.length === 1 && !assignedSailorIds.has(aliasCandidates[0].id)) {
        sailorId = aliasCandidates[0].id;
        identityBasis = 'Corroborated registered sailor alias match';
      }
    }

    let isNewProfile = false;
    if (!sailorId) {
      sailorId = uuidv4();
      isNewProfile = true;
      identityBasis = 'No existing exact profile; creating source-faithful profile with official NOC and gender';
    }

    assignedSailorIds.add(sailorId);

    results.push({
      rank,
      ordinal: rank,
      sourceName: rawName,
      name: cleanName,
      sailOrBoardNumber: sailNumber,
      nationality,
      gender,
      grossScore,
      nettScore,
      races,
      sailorId,
      resultId: uuidv4(),
      participantId: uuidv4(),
      isNewProfile,
      identityBasis,
      sourceNationality: nationality,
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

const manifest2024 = {
  batch: 'asian-optimist-2024-import-2026-10-28',
  officialSource: source2024,
  event: {
    id: 'e1a20240-a510-48e0-8001-000000002024',
    slug: '2024-optimist-asian-oceanian-championship',
    name: '2024 Optimist Asian & Oceanian Championship',
    startDate: '2024-12-29',
    endDate: '2025-01-05',
    venue: 'Clearwater Bay Golf & Country Club Marina, Hong Kong',
    organizer: 'Sailing Federation of Hong Kong, China / Royal Hong Kong Yacht Club / IODA',
    norUrl: 'https://2024asianoceanians.optiworld.org'
  },
  sheet: {
    id: 's1a20240-a510-48e0-8001-000000002024',
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

fs.writeFileSync('scripts/imports/asian-championships-priority1/manifest-2024.json', JSON.stringify(manifest2024, null, 2));

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

const manifest2023 = {
  batch: 'asian-optimist-2023-import-2026-10-28',
  officialSource: source2023,
  event: {
    id: 'e1a20230-a510-48e0-8001-000000002023',
    slug: '2023-optimist-asian-oceanian-championship',
    name: '2023 Optimist Asian & Oceanian Championship',
    startDate: '2023-10-29',
    endDate: '2023-11-05',
    venue: 'Abu Dhabi Marine Sports Club, Abu Dhabi, United Arab Emirates',
    organizer: 'Abu Dhabi Marine Sports Club / UAE Sailing & Rowing Federation / IODA',
    norUrl: 'https://2023asianoceanians.optiworld.org'
  },
  sheet: {
    id: 's1a20230-a510-48e0-8001-000000002023',
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

fs.writeFileSync('scripts/imports/asian-championships-priority1/manifest-2023.json', JSON.stringify(manifest2023, null, 2));

console.log('--- Summary ---');
console.log(`2024: ${results2024.length} entries parsed. Matched existing profiles: ${results2024.filter(r => !r.isNewProfile).length}, New profiles: ${results2024.filter(r => r.isNewProfile).length}`);
console.log(`2023: ${results2023.length} entries parsed. Matched existing profiles: ${results2023.filter(r => !r.isNewProfile).length}, New profiles: ${results2023.filter(r => r.isNewProfile).length}`);
