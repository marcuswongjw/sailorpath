import {
  type WingfoilRaceScore,
  type WingfoilSailorResult,
  parseWingfoilScreenshotFilename,
  recalculateScoreboard,
} from "./wingfoil";

export type ParsedWingfoilScreenshot = {
  regattaName: string;
  startDate: string;
  sailedCount: number;
  discardsCount: number;
  scoringSystem: string;
  results: WingfoilSailorResult[];
  rawText: string;
};

export const KNOWN_WINGFOIL_CLUBS = [
  "Windsurfing Association of Singapore",
  "Windsurfing Association of",
  "PAssion Wave",
  "Constant Wind SeaSports",
  "Constant Wind",
  "Changi Sailing Club",
  "ONE°15 Marina Club",
  "ONE®15 Marina Club",
  "ONE 15 Marina Club",
  "SAF Yacht Club",
  "Singapore Sailing Federation",
  "National Sailing Centre",
  "Singapore Island Country Club",
  "Marina Country Club",
];

export const KNOWN_WINGFOIL_SCHOOLS = [
  "CHIJ Secondary (Toa Payoh)",
  "CHIJ SECONDARY (TOA PAYOH)",
  "Methodist Girls' School",
  "METHODIST GIRLS' SCHOOL",
  "Tao Nan School",
  "TAO NAN SCHOOL",
  "Home School",
  "HOME SCHOOL",
  "Anglo-Chinese School (Barker Road)",
  "ANGLO-CHINESE SCHOOL (BARKER ROAD)",
  "ANGLO-CHINESE SCHOOL",
  "Tanglin Trust School",
  "St. Gabriel's Secondary School",
  "ST. GABRIEL'S SECONDARY SCHOOL",
  "ST. GABRIEL'S SECONDARY",
  "Raffles Institution",
  "Victoria School",
  "Hwa Chong Institution",
  "Saint Joseph's Institution",
];

/**
 * Clean up text artifacts from OCR
 */
function cleanOcrString(str: string): string {
  return str
    .replace(/[™®©=—–_]+/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

/**
 * Format month day, year (e.g. "September 7, 2026") into "YYYY-MM-DD"
 */
function parseDateStringToIso(dateStr: string): string | null {
  const months: Record<string, string> = {
    jan: "01",
    feb: "02",
    mar: "03",
    apr: "04",
    may: "05",
    jun: "06",
    jul: "07",
    aug: "08",
    sep: "09",
    oct: "10",
    nov: "11",
    dec: "12",
  };
  const match = dateStr.match(/([a-zA-Z]+)\s+(\d{1,2}),?\s+(\d{4})/);
  if (match) {
    const monthKey = match[1].slice(0, 3).toLowerCase();
    const month = months[monthKey];
    if (month) {
      const day = match[2].padStart(2, "0");
      const year = match[3];
      return `${year}-${month}-${day}`;
    }
  }
  return null;
}

/**
 * Parse raw text extracted by OCR from a WingFoil results screenshot.
 */
export function parseWingfoilOcrText(
  rawText: string,
  options?: { fileName?: string }
): Omit<ParsedWingfoilScreenshot, "rawText"> {
  const lines = rawText
    .split(/\r?\n/)
    .map((l) => l.trim())
    .filter(Boolean);

  let regattaName = "";
  let startDate = "";
  let sailedCount = 9;
  let discardsCount = 1;
  let scoringSystem = "World Sailing RRS Appendix A";

  // 1. Parse header metadata
  for (const line of lines) {
    // Check for provisional / published date: "as of 16:31 on September 7, 2026"
    const dateMatch = line.match(
      /(?:as of.*on\s+|date:?\s*)([A-Za-z]+\s+\d{1,2},?\s+\d{4})/i
    );
    if (dateMatch && !startDate) {
      const parsedIso = parseDateStringToIso(dateMatch[1]);
      if (parsedIso) startDate = parsedIso;
    }

    // Sailed count
    const sailedMatch = line.match(/Sailed:\s*(\d+)/i);
    if (sailedMatch) {
      sailedCount = parseInt(sailedMatch[1], 10);
    }

    // Discards count
    const discardsMatch = line.match(/Discards:\s*(\d+)/i);
    if (discardsMatch) {
      discardsCount = parseInt(discardsMatch[1], 10);
    }

    // Scoring system
    const scoringMatch = line.match(/Scoring system:\s*([^,\n]+)/i);
    if (scoringMatch) {
      scoringSystem = cleanOcrString(scoringMatch[1]);
    }

    // Class / Event name
    if (
      /wingfoil/i.test(line) &&
      !/sailed/i.test(line) &&
      !/provisional/i.test(line) &&
      !/appendix/i.test(line)
    ) {
      const clean = cleanOcrString(line);
      if (clean && clean.length > 3) {
        regattaName = clean;
      }
    }
  }

  // Fallback to filename if regattaName or startDate not found in OCR text
  if (options?.fileName) {
    const fileMeta = parseWingfoilScreenshotFilename(options.fileName);
    if (!regattaName || regattaName.toLowerCase() === "wingfoil class") {
      if (
        fileMeta.regattaName &&
        fileMeta.regattaName !== "Singapore WingFoil Sprint Slalom"
      ) {
        regattaName = fileMeta.regattaName;
      }
    }
    if (!startDate && fileMeta.startDate) {
      startDate = fileMeta.startDate;
    }
  }

  if (!regattaName) {
    regattaName = "Singapore WingFoil Sprint Slalom";
  }
  if (!startDate) {
    startDate = new Date().toISOString().split("T")[0];
  }

  // 2. Competitor Row Clustering
  type RawCompetitorBlock = {
    header: string;
    extra: string[];
  };

  const blocks: RawCompetitorBlock[] = [];
  let currentBlock: RawCompetitorBlock | null = null;

  const rankRegex = /^([1-9]\d?(?:st|nd|rd|th)?|[s$]th)\b/i;

  for (const line of lines) {
    const rankMatch = line.match(rankRegex);
    const hasPivot = /\b\d{1,4}\s+[FM]\s+(?:16[&8]U|U16|U19|Open|Masters)/i.test(
      line
    );

    if (rankMatch || (hasPivot && !currentBlock)) {
      if (currentBlock) {
        blocks.push(currentBlock);
      }
      currentBlock = { header: line, extra: [] };
    } else if (currentBlock) {
      if (
        /^(Results|Sailed:|Wingfoil|Rank\s+Nat)/i.test(line) ||
        /scoring system/i.test(line)
      ) {
        // Skip
      } else {
        currentBlock.extra.push(line);
      }
    }
  }
  if (currentBlock) {
    blocks.push(currentBlock);
  }

  const results: WingfoilSailorResult[] = [];

  // 3. Process each competitor block
  blocks.forEach((b, blockIdx) => {
    // 3a. Extract Rank
    const rankMatch = b.header.match(rankRegex);
    let rank = blockIdx + 1;
    if (rankMatch) {
      const rankNumStr = rankMatch[1].replace(/\D/g, "");
      if (rankNumStr) {
        rank = parseInt(rankNumStr, 10);
      } else if (/^[s$]th/i.test(rankMatch[1])) {
        rank = 5;
      }
    }

    // 3b. Find Pivot: Sail Number + Gender + Age Category
    const pivotMatch = b.header.match(
      /\b(\d{1,4})\s+([FM])\s+(16[&8]U|U16|U19|Open|Masters)/i
    );
    if (!pivotMatch || pivotMatch.index == null) {
      return;
    }

    const sailNumber = pivotMatch[1];
    const gender = pivotMatch[2].toUpperCase() as "M" | "F";
    const ageCategory = pivotMatch[3].replace(/8/, "&");

    // 3c. Extract Sailor Name (before pivot + surname from extra line)
    const beforePivot = b.header.slice(0, pivotMatch.index).trim();
    let nameCandidate = beforePivot
      .replace(rankRegex, "")
      .replace(/[™®©=—–\-_|]+/g, " ")
      .replace(/\b(SGP|SIN)\b/gi, "")
      .trim();

    // Check extra lines for surname or multi-line wrap
    const extraTokens = b.extra
      .join(" ")
      .trim()
      .split(/\s+/)
      .filter(Boolean);

    // If first token is country code / flag artifact, discard it
    if (
      extraTokens.length &&
      /^(SGP|SIN|sep|sor|sop|sge|sg|00)$/i.test(extraTokens[0])
    ) {
      extraTokens.shift();
    }

    // Check if next token is a surname (e.g. Bateman, Chew, Lau, Chiam)
    if (
      extraTokens.length &&
      /^[A-Z][a-zA-Z'-]+$/.test(extraTokens[0]) &&
      !/^(PAYOH|ROAD|SCHOOL|SECONDARY|SINGAPORE|WAVE|CLUB|DNF|DNS|DSQ|DNC|RDG)$/i.test(
        extraTokens[0]
      )
    ) {
      nameCandidate = `${nameCandidate} ${extraTokens[0]}`.trim();
    }

    const cleanedName = cleanOcrString(nameCandidate);

    // 3d. Extract School & Club (after pivot)
    const afterPivot = b.header.slice(pivotMatch.index + pivotMatch[0].length);
    const combinedAfter = `${afterPivot} ${b.extra.join(" ")}`;

    let matchedClub = "";
    if (/windsurfing/i.test(combinedAfter)) {
      matchedClub = "Windsurfing Association of Singapore";
    } else if (/passion/i.test(combinedAfter)) {
      matchedClub = "PAssion Wave";
    } else if (/constant\s*wind/i.test(combinedAfter)) {
      matchedClub = "Constant Wind SeaSports";
    } else if (/changi/i.test(combinedAfter)) {
      matchedClub = "Changi Sailing Club";
    } else if (/one[°®]?\s*15/i.test(combinedAfter)) {
      matchedClub = "ONE°15 Marina Club";
    } else if (/saf/i.test(combinedAfter)) {
      matchedClub = "SAF Yacht Club";
    } else {
      for (const club of KNOWN_WINGFOIL_CLUBS) {
        const re = new RegExp(club.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"), "i");
        if (re.test(combinedAfter)) {
          matchedClub = club;
          break;
        }
      }
    }

    let matchedSchool = "";
    if (/chij/i.test(combinedAfter)) {
      matchedSchool = "CHIJ Secondary (Toa Payoh)";
    } else if (/methodist/i.test(combinedAfter)) {
      matchedSchool = "Methodist Girls' School";
    } else if (/tao\s*nan/i.test(combinedAfter)) {
      matchedSchool = "Tao Nan School";
    } else if (/home\s*school/i.test(combinedAfter)) {
      matchedSchool = "Home School";
    } else if (/anglo[- ]chinese/i.test(combinedAfter)) {
      matchedSchool = "Anglo-Chinese School (Barker Road)";
    } else if (/tanglin/i.test(combinedAfter)) {
      matchedSchool = "Tanglin Trust School";
    } else if (/gabriel/i.test(combinedAfter)) {
      matchedSchool = "St. Gabriel's Secondary School";
    } else if (/raffles/i.test(combinedAfter)) {
      matchedSchool = "Raffles Institution";
    } else if (/victoria/i.test(combinedAfter)) {
      matchedSchool = "Victoria School";
    } else if (/hwa\s*chong/i.test(combinedAfter)) {
      matchedSchool = "Hwa Chong Institution";
    } else if (/joseph/i.test(combinedAfter)) {
      matchedSchool = "Saint Joseph's Institution";
    } else {
      for (const school of KNOWN_WINGFOIL_SCHOOLS) {
        const re = new RegExp(
          school.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"),
          "i"
        );
        if (re.test(combinedAfter)) {
          matchedSchool = school;
          break;
        }
      }
    }

    // 3e. Extract Gross & Nett totals from header end
    const totalsMatch = b.header.match(/(\d{1,3})\s+(\d{1,3})\s*$/);
    const grossScore = totalsMatch ? parseInt(totalsMatch[1], 10) : 0;
    const nettScore = totalsMatch ? parseInt(totalsMatch[2], 10) : 0;

    // 3f. Extract Heat Scores (R1..R9)
    const scoreMatches = [
      ...combinedAfter.matchAll(
        /(\(?\d{1,2}\)?(?:\s+(?:DNF|DNS|DSQ|DNC|RDG|OCS|BFD|UFD))?|\b(?:DNF|DNS|DSQ|DNC|RDG)\b)/gi
      ),
    ];

    const validScores: WingfoilRaceScore[] = [];
    for (const sm of scoreMatches) {
      const token = sm[0].trim();
      if (
        totalsMatch &&
        (token === totalsMatch[1] || token === totalsMatch[2])
      ) {
        continue;
      }
      if (
        token === sailNumber ||
        token === `${rank}` ||
        token === `${rank}st` ||
        token === `${rank}nd` ||
        token === `${rank}rd` ||
        token === `${rank}th`
      ) {
        continue;
      }

      const isDiscarded = token.includes("(") || token.includes(")");
      const numMatch = token.match(/\d+/);
      const codeMatch = token.match(/\b(DNF|DNS|DSQ|DNC|RDG|OCS|BFD|UFD)\b/i);

      const code = codeMatch
        ? (codeMatch[1].toUpperCase() as WingfoilRaceScore["code"])
        : undefined;

      let scoreNum = numMatch ? parseInt(numMatch[0], 10) : 8;
      if (!numMatch && code) {
        scoreNum = 8;
      }

      if (scoreNum >= 1 && scoreNum <= 20) {
        validScores.push({
          score: scoreNum,
          isDiscarded,
          code,
        });
      }
    }

    const finalScores: WingfoilRaceScore[] = validScores.slice(0, sailedCount);

    while (finalScores.length < sailedCount) {
      const isPenaltySeries =
        grossScore >= 70 || finalScores.some((s) => s.code === "DNF");
      finalScores.push({
        score: 8,
        code: isPenaltySeries ? "DNF" : undefined,
      });
    }

    results.push({
      rank,
      name: cleanedName || `Sailor ${sailNumber}`,
      sailNumber,
      gender,
      ageCategory: ageCategory || "16&U",
      schoolName: matchedSchool || "Singapore School",
      club: matchedClub || "Singapore Sailing Club",
      races: finalScores,
      grossScore,
      nettScore,
    });
  });

  const recalculated = recalculateScoreboard(results);

  return {
    regattaName,
    startDate,
    sailedCount,
    discardsCount,
    scoringSystem,
    results: recalculated,
  };
}

/**
 * Preprocess a screenshot image in the browser using HTML5 Canvas:
 * 1. Upscale by 2.5x to reach optimal ~300 DPI OCR resolution.
 * 2. Convert to grayscale and apply contrast boost so dark numbers inside
 *    yellow/gold, blue, and salmon podium background cells are rendered clearly.
 */
export async function preprocessWingfoilImage(
  imageSource: HTMLImageElement | HTMLCanvasElement
): Promise<HTMLCanvasElement> {
  const canvas = document.createElement("canvas");
  const scale = 2.5;

  const width =
    "naturalWidth" in imageSource
      ? imageSource.naturalWidth
      : imageSource.width;
  const height =
    "naturalHeight" in imageSource
      ? imageSource.naturalHeight
      : imageSource.height;

  canvas.width = Math.round(width * scale);
  canvas.height = Math.round(height * scale);

  const ctx = canvas.getContext("2d", { willReadFrequently: true });
  if (!ctx) {
    throw new Error("Could not acquire 2D canvas context for image preprocessing");
  }

  ctx.imageSmoothingEnabled = true;
  ctx.imageSmoothingQuality = "high";
  ctx.drawImage(imageSource, 0, 0, canvas.width, canvas.height);

  const imgData = ctx.getImageData(0, 0, canvas.width, canvas.height);
  const data = imgData.data;

  for (let i = 0; i < data.length; i += 4) {
    const r = data[i];
    const g = data[i + 1];
    const b = data[i + 2];

    const luma = 0.299 * r + 0.587 * g + 0.114 * b;

    let enhanced = luma;
    if (luma > 130) {
      enhanced = 255;
    } else if (luma < 85) {
      enhanced = 0;
    } else {
      enhanced = (luma - 85) * (255 / 45);
    }

    data[i] = enhanced;
    data[i + 1] = enhanced;
    data[i + 2] = enhanced;
  }

  ctx.putImageData(imgData, 0, 0);
  return canvas;
}

/**
 * Load a File into an HTMLImageElement
 */
export function loadImageFromFile(file: File): Promise<HTMLImageElement> {
  return new Promise((resolve, reject) => {
    const url = URL.createObjectURL(file);
    const img = new Image();
    img.onload = () => {
      URL.revokeObjectURL(url);
      resolve(img);
    };
    img.onerror = () => {
      URL.revokeObjectURL(url);
      reject(new Error("Failed to load image file into browser Image element"));
    };
    img.src = url;
  });
}

/**
 * High-level OCR reader for WingFoil results screenshots.
 * Browser-safe: Dynamically imports tesseract.js and uses bundled vendor assets.
 */
export async function readWingfoilScreenshot(
  file: File,
  onProgress?: (progress: { status: string; progress: number }) => void
): Promise<ParsedWingfoilScreenshot> {
  onProgress?.({ status: "Loading screenshot…", progress: 0.1 });

  const img = await loadImageFromFile(file);

  onProgress?.({ status: "Enhancing contrast and upscaling image…", progress: 0.25 });

  const canvas = await preprocessWingfoilImage(img);

  onProgress?.({ status: "Initializing OCR worker…", progress: 0.4 });

  const { createWorker, OEM, PSM } = await import("tesseract.js");

  const worker = await createWorker("eng", OEM.LSTM_ONLY, {
    workerPath: "/vendor/tesseract/worker.min.js",
    corePath: "/vendor/tesseract/core",
    langPath: "/vendor/tesseract/lang",
    logger(message) {
      if (message.status === "recognizing text") {
        const p = 0.4 + (message.progress || 0) * 0.45;
        onProgress?.({ status: "Recognizing scores and competitors…", progress: p });
      }
    },
  });

  try {
    await worker.setParameters({
      tessedit_pageseg_mode: PSM.AUTO,
      preserve_interword_spaces: "1",
      user_defined_dpi: "300",
    });

    const ret = await worker.recognize(canvas);
    const rawText = ret.data.text || "";

    onProgress?.({ status: "Parsing scorecard scoreboard…", progress: 0.9 });

    const parsed = parseWingfoilOcrText(rawText, { fileName: file.name });

    onProgress?.({ status: "Complete", progress: 1.0 });

    return {
      ...parsed,
      rawText,
    };
  } finally {
    await worker.terminate();
  }
}
