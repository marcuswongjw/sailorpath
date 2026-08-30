import type { PdfTextItem, PdfTextPage } from "./parseSailwaveResults";

type OcrProgress = {
  pageNumber: number;
  pageCount: number;
  status: string;
  progress: number;
};

type OcrCanvasPage = {
  pageNumber: number;
  canvas: HTMLCanvasElement;
};

/** Convert Tesseract's word-level TSV into the coordinates used by the PDF parser. */
export function tesseractTsvToPdfPage(
  tsv: string,
  pageNumber: number,
  imageHeight: number
): PdfTextPage {
  const items: PdfTextItem[] = [];
  const lineYs = new Map<string, number>();
  // Parser tolerances are expressed in PDF points, while OCR coordinates are pixels.
  // Normalize high-resolution canvases to a stable coordinate space.
  const coordinateScale = Math.max(1, imageHeight / 1000);

  for (const rawLine of tsv.split(/\r?\n/).slice(1)) {
    const fields = rawLine.split("\t");
    if (fields.length < 12 || fields[0] !== "5") continue;
    const [block, paragraph, line] = fields.slice(2, 5);
    const left = Number(fields[6]);
    const top = Number(fields[7]);
    const width = Number(fields[8]);
    const height = Number(fields[9]);
    const confidence = Number(fields[10]);
    const str = fields.slice(11).join("\t").trim();
    // Keep low-confidence words: compact headers such as "Nett" can score below
    // 20 even when correctly recognized. Tesseract uses -1 for non-word entries.
    if (!str || !Number.isFinite(left) || !Number.isFinite(top) || confidence < 0) continue;

    const lineKey = `${block}:${paragraph}:${line}`;
    const y =
      lineYs.get(lineKey) ?? (imageHeight - (top + height / 2)) / coordinateScale;
    lineYs.set(lineKey, y);
    const scoreMatches = [...str.matchAll(/\(?\d{1,3}\.\d\)?(?:[A-Z]{2,5})?/gi)];
    if (scoreMatches.length > 1 && Number.isFinite(width) && width > 0) {
      for (const match of scoreMatches) {
        const relativeX = (match.index || 0) / str.length;
        items.push({
          str: match[0],
          x: (left + width * relativeX) / coordinateScale,
          y,
        });
      }
    } else {
      items.push({ str, x: left / coordinateScale, y });
    }
  }

  return {
    pageNumber,
    items,
    text: items.map((item) => item.str).join(" "),
  };
}

/** OCR raster-only PDF pages in the browser. Loaded only when embedded text is absent. */
export async function ocrRegattaPdfPages(
  pages: OcrCanvasPage[],
  onProgress?: (progress: OcrProgress) => void
): Promise<PdfTextPage[]> {
  const { createWorker, OEM, PSM } = await import("tesseract.js");
  const pageCount = pages.length;
  let activePage = 1;
  const worker = await createWorker("eng", OEM.LSTM_ONLY, {
    workerPath: "/vendor/tesseract/worker.min.js",
    corePath: "/vendor/tesseract/core",
    langPath: "/vendor/tesseract/lang",
    logger(message) {
      onProgress?.({
        pageNumber: activePage,
        pageCount,
        status: message.status,
        progress: message.progress,
      });
    },
  });

  try {
    await worker.setParameters({
      tessedit_pageseg_mode: PSM.AUTO,
      preserve_interword_spaces: "1",
      user_defined_dpi: "300",
    });
    const results: PdfTextPage[] = [];
    for (const page of pages) {
      activePage = page.pageNumber;
      onProgress?.({
        pageNumber: activePage,
        pageCount,
        status: "recognizing text",
        progress: 0,
      });
      const { data } = await worker.recognize(
        page.canvas,
        {},
        { text: true, tsv: true }
      );
      results.push(
        tesseractTsvToPdfPage(data.tsv || "", page.pageNumber, page.canvas.height)
      );
    }
    return results;
  } finally {
    await worker.terminate();
  }
}
