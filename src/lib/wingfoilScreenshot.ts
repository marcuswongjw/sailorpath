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

export const KNOWN_SINGAPORE_WINGFOILERS: Record<
  string,
  { name: string; gender: "M" | "F"; defaultClub?: string }
> = {
  "43": { name: "Jun Hao Lo", gender: "M", defaultClub: "Singapore Sailing Federation" },
  "29": { name: "Wearn Haw Tan", gender: "M", defaultClub: "Changi Sailing Club" },
  "18": { name: "Ker Wan Chew", gender: "M", defaultClub: "Constant Wind SeaSports" },
  "49": { name: "Damien Gay", gender: "M", defaultClub: "Constant Wind SeaSports" },
  "41": { name: "Jean-Marc Provost", gender: "M", defaultClub: "ONE°15 Marina Club" },
  "3": { name: "Ange Chew", gender: "M", defaultClub: "Changi Sailing Club" },
  "19": { name: "Harun Talikov", gender: "M", defaultClub: "Constant Wind SeaSports" },
  "1": { name: "Victoria Natasha Chew", gender: "F", defaultClub: "PAssion Wave" },
  "8": { name: "Mason Qifeng Lau", gender: "M", defaultClub: "Constant Wind SeaSports" },
  "6": { name: "Kate En Rui Bateman", gender: "F", defaultClub: "Windsurfing Association of Singapore" },
  "7": { name: "Ryo En Hua Bateman", gender: "M", defaultClub: "Windsurfing Association of Singapore" },
  "13": { name: "Pandora Chew", gender: "F", defaultClub: "Changi Sailing Club" },
  "30": { name: "Arthur Phan", gender: "M", defaultClub: "Constant Wind SeaSports" },
  "5": { name: "Malo Pichoir", gender: "M", defaultClub: "ONE°15 Marina Club" },
  "50": { name: "Sven Welak", gender: "M", defaultClub: "Constant Wind SeaSports" },
  "42": { name: "Xavier Lau", gender: "M", defaultClub: "Constant Wind SeaSports" },
  "48": { name: "Guillaume Pichoir", gender: "M", defaultClub: "ONE°15 Marina Club" },
  "28": { name: "Laurence Ng", gender: "M", defaultClub: "SAF Yacht Club" },
  "46": { name: "Felix Knick", gender: "M", defaultClub: "ONE°15 Marina Club" },
  "4": { name: "Jayden Li", gender: "M", defaultClub: "Changi Sailing Club" },
  "2": { name: "Cyrus Jing Yi Chiam", gender: "M", defaultClub: "SAF Yacht Club" },
  "21": { name: "Kate En Rui Bateman", gender: "F", defaultClub: "Windsurfing Association of Singapore" },
  "23": { name: "Ryo En Hua Bateman", gender: "M", defaultClub: "Windsurfing Association of Singapore" },
  "27": { name: "Mason Qifeng Lau", gender: "M", defaultClub: "Constant Wind SeaSports" },
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
    const isGenericName =
      !regattaName ||
      /^(wingfoil\s*(class|fleet)?|wing\s*foil)$/i.test(regattaName.trim());

    if (isGenericName) {
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

  const rankRegex = /^(\d{1,2}(?:st|nd|rd|th|h|d)?|[fs$oa]th|[foa]h|fst|130)\b/i;

  for (const line of lines) {
    const rankMatch = line.match(rankRegex);
    const hasPivot =
      /\b\d{1,4}\s+[FM]\s+(?:16[&8]U|U16|U19|Open|Masters)/i.test(line) ||
      /^(\d{1,2}(?:st|nd|rd|th|h|d)?|[fs$oa]th|[foa]h|fst|130)\s+[A-Za-z]/i.test(line);

    if (rankMatch || (hasPivot && !currentBlock)) {
      if (currentBlock) {
        blocks.push(currentBlock);
      }
      currentBlock = { header: line, extra: [] };
    } else if (currentBlock) {
      if (
        /^(Results|Sailed:|Wingfoil|Rank\s+Name|Rank\s+Nat)/i.test(line) ||
        /scoring system/i.test(line)
      ) {
        // Skip header lines
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
      const raw = rankMatch[1].toLowerCase();
      if (raw === "fst" || raw.startsWith("1st") || raw === "1") rank = 1;
      else if (raw.startsWith("2")) rank = 2;
      else if (raw.startsWith("3")) rank = 3;
      else if (raw === "ath" || raw.startsWith("4")) rank = 4;
      else if (raw === "sth" || raw.startsWith("5")) rank = 5;
      else if (raw === "6h" || raw.startsWith("6")) rank = 6;
      else if (raw === "7h" || raw.startsWith("7")) rank = 7;
      else if (raw === "8h" || raw.startsWith("8")) rank = 8;
      else if (raw === "oh" || raw.startsWith("9")) rank = 9;
      else if (raw === "10h" || raw.startsWith("10")) rank = 10;
      else if (raw === "fh" || raw.startsWith("11")) rank = 11;
      else if (raw === "12h" || raw.startsWith("12")) rank = 12;
      else if (raw === "130" || raw.startsWith("13")) rank = 13;
      else if (raw === "14h" || raw.startsWith("14")) rank = 14;
      else {
        const d = raw.replace(/\D/g, "");
        if (d) rank = parseInt(d, 10);
      }
    }

    // 3b. Format A pivot (SailNum + Gender + Age) vs Format B (Name + SailNum + Division)
    const pivotMatchA = b.header.match(
      /\b(\d{1,4})\s+([FM])\s+(16[&8]U|U16|U19|Open|Masters)/i
    );

    let sailNumber = "";
    let gender: "M" | "F" = "M";
    let ageCategory = "Open";
    let cleanedName = "";
    let matchedClub = "";
    let matchedSchool = "—";
    let afterPivot = "";

    if (pivotMatchA && pivotMatchA.index != null) {
      // Format A (SSF National Championship)
      sailNumber = pivotMatchA[1];
      gender = pivotMatchA[2].toUpperCase() as "M" | "F";
      ageCategory = pivotMatchA[3].replace(/8/, "&");

      const beforePivot = b.header.slice(0, pivotMatchA.index).trim();
      let nameCandidate = beforePivot
        .replace(rankRegex, "")
        .replace(/[™®©=—–\-_|]+/g, " ")
        .replace(/\b(SGP|SIN)\b/gi, "")
        .trim();

      const extraTokens = b.extra
        .join(" ")
        .trim()
        .split(/\s+/)
        .filter(Boolean);

      if (
        extraTokens.length &&
        /^(SGP|SIN|sep|sor|sop|sge|sg|00)$/i.test(extraTokens[0])
      ) {
        extraTokens.shift();
      }

      if (
        extraTokens.length &&
        /^[A-Z][a-zA-Z'-]+$/.test(extraTokens[0]) &&
        !/^(PAYOH|ROAD|SCHOOL|SECONDARY|SINGAPORE|WAVE|CLUB|DNF|DNS|DSQ|DNC|RDG)$/i.test(
          extraTokens[0]
        )
      ) {
        nameCandidate = `${nameCandidate} ${extraTokens[0]}`.trim();
      }

      cleanedName = cleanOcrString(nameCandidate);
      afterPivot = b.header.slice(pivotMatchA.index + pivotMatchA[0].length);
    } else {
      // Format B (Grand Prix / Monsoon Series)
      const rest = b.header.replace(rankRegex, "").trim();
      const sailMatch = rest.match(/^([A-Za-z\s\-']+?)\s+(\d{1,3})\b/);
      let namePart = `Sailor ${blockIdx + 1}`;
      let division = "Open";

      if (sailMatch && sailMatch.index != null) {
        namePart = sailMatch[1].trim();
        sailNumber = sailMatch[2];
        const afterSail = rest
          .slice(sailMatch.index + sailMatch[0].length)
          .trim();
        const divMatch = afterSail.match(
          /^(Masters?|Grand Master|Grand|U16,\s*U19|U16\s*U19|U16|U19|Fun Open|Fun Masters?|FunOpen|FunMaster|Open|Youth|GrandMaster)\b/i
        );
        if (divMatch) {
          division = divMatch[1];
          afterPivot = afterSail.slice(divMatch[0].length);
        } else {
          afterPivot = afterSail;
        }
      } else {
        const anyNum = rest.match(/\b(\d{1,3})\b/);
        if (anyNum && anyNum.index != null) {
          namePart = rest.slice(0, anyNum.index).trim();
          sailNumber = anyNum[1];
          afterPivot = rest.slice(anyNum.index + anyNum[0].length);
        } else {
          afterPivot = rest;
        }
      }

      if (b.extra.length) {
        const extraFirst = b.extra[0]
          .split(/\s+(?:DNF|DNS|DSQ|DNC|RDG|\d)/)[0]
          .trim();
        if (
          /^[A-Za-z\-'\s]+$/.test(extraFirst) &&
          !/^(DNF|DNS|DSQ|DNC|RDG)$/i.test(extraFirst)
        ) {
          namePart = `${namePart} ${extraFirst}`.trim();
        }
      }

      const known = KNOWN_SINGAPORE_WINGFOILERS[sailNumber];
      if (known) {
        cleanedName = known.name;
        gender = known.gender;
        matchedClub = known.defaultClub || "Singapore Sailing Club";
      } else {
        cleanedName = cleanOcrString(namePart);
        gender = /^(Kate|Victoria|Pandora)\b/i.test(cleanedName) ? "F" : "M";
      }

      if (/grand/i.test(division)) ageCategory = "Grand Masters";
      else if (/fun\s*master/i.test(division)) ageCategory = "Fun Masters";
      else if (/fun\s*open/i.test(division)) ageCategory = "Fun Open";
      else if (/master/i.test(division)) ageCategory = "Masters";
      else if (/u16/i.test(division) || /u19/i.test(division))
        ageCategory = "U16, U19";
      else ageCategory = division || "Open";
    }

    // 3c. Extract School & Club from remainder if not already resolved
    const combinedAfter = `${afterPivot} ${b.extra.join(" ")}`;

    if (!matchedClub) {
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
          const re = new RegExp(
            club.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"),
            "i"
          );
          if (re.test(combinedAfter)) {
            matchedClub = club;
            break;
          }
        }
      }
    }

    if (matchedSchool === "—") {
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
    }

    // 3d. Extract Gross & Nett totals from header end
    const totalsMatch = b.header.match(
      /(\d{1,3}(?:\.0)?)\s+(\d{1,3}(?:\.0)?)\s*$/
    );
    const grossScore = totalsMatch ? parseFloat(totalsMatch[1]) : 0;
    const nettScore = totalsMatch ? parseFloat(totalsMatch[2]) : 0;

    // 3e. Extract Heat Scores (R1..Rn)
    const scoreMatches = [
      ...combinedAfter.matchAll(
        /(\(?\d{1,2}(?:\.0)?\)?(?:\s+(?:DNF|DNS|DSQ|DNC|RDG|OCS|BFD|UFD))?|\b(?:DNF|DNS|DSQ|DNC|RDG)\b)/gi
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
      const numMatch = token.match(/\d+(?:\.\d+)?/);
      const codeMatch = token.match(
        /\b(DNF|DNS|DSQ|DNC|RDG|OCS|BFD|UFD)\b/i
      );

      const code = codeMatch
        ? (codeMatch[1].toUpperCase() as WingfoilRaceScore["code"])
        : undefined;

      const penaltyDefault = sailedCount > 10 ? 22 : 8;
      let scoreNum = numMatch ? Math.round(parseFloat(numMatch[0])) : penaltyDefault;
      if (!numMatch && code) {
        scoreNum = penaltyDefault;
      }

      if (scoreNum >= 1 && scoreNum <= 100) {
        validScores.push({
          score: scoreNum,
          isDiscarded,
          code,
        });
      }
    }

    const finalScores: WingfoilRaceScore[] = validScores.slice(0, sailedCount);
    const defaultPts = sailedCount > 10 ? 22 : 8;

    while (finalScores.length < sailedCount) {
      const isPenaltySeries =
        grossScore >= sailedCount * 14 ||
        finalScores.some((s) => s.code === "DNF" || s.code === "DNC");
      finalScores.push({
        score: defaultPts,
        code: isPenaltySeries ? "DNF" : undefined,
      });
    }

    results.push({
      rank,
      name: cleanedName || `Sailor ${sailNumber}`,
      sailNumber: sailNumber || `${blockIdx + 1}`,
      gender,
      ageCategory: ageCategory || "Open",
      schoolName: matchedSchool || "—",
      club: matchedClub || "Singapore Sailing Club",
      races: finalScores,
      grossScore,
      nettScore,
    });
  });

  const recalculated = recalculateScoreboard(results, discardsCount);

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
