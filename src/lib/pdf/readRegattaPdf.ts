import { parseSailwaveResults, type PdfTextPage } from "./parseSailwaveResults";

export const MAX_PDF_BYTES = 15 * 1024 * 1024;
export const MAX_PDF_PAGES = 20;

export async function readRegattaPdf(file: File) {
  if (file.size > MAX_PDF_BYTES) {
    throw new Error("PDF is too large. The limit is 15 MB.");
  }

  const moduleUrl = "/vendor/pdfjs/pdf.mjs";
  const pdfjs = (await import(
    /* webpackIgnore: true */ moduleUrl
  )) as typeof import("pdfjs-dist/legacy/build/pdf.mjs");
  pdfjs.GlobalWorkerOptions.workerSrc = "/vendor/pdfjs/pdf.worker.min.mjs";
  const pdfDocument = await pdfjs.getDocument({ data: new Uint8Array(await file.arrayBuffer()) }).promise;
  if (pdfDocument.numPages > MAX_PDF_PAGES) {
    const pageCount = pdfDocument.numPages;
    await pdfDocument.destroy();
    throw new Error(`PDF has ${pageCount} pages. The limit is ${MAX_PDF_PAGES}.`);
  }

  const pages: PdfTextPage[] = [];
  const screenshots: { pageNumber: number; dataUrl: string }[] = [];
  for (let pageNumber = 1; pageNumber <= pdfDocument.numPages; pageNumber++) {
    const page = await pdfDocument.getPage(pageNumber);
    const content = await page.getTextContent();
    const items = content.items.flatMap((item) => {
      if (!("str" in item) || !item.str.trim()) return [];
      return [{ str: item.str, x: item.transform[4], y: item.transform[5] }];
    });
    pages.push({
      pageNumber,
      items,
      text: items.map((item) => item.str).join(" "),
    });

    const viewport = page.getViewport({ scale: 1.35 });
    const canvas = window.document.createElement("canvas");
    canvas.width = Math.ceil(viewport.width);
    canvas.height = Math.ceil(viewport.height);
    const context = canvas.getContext("2d", { alpha: false });
    if (!context) throw new Error("This browser cannot create a PDF preview.");
    await page.render({ canvas, canvasContext: context, viewport }).promise;
    screenshots.push({ pageNumber, dataUrl: canvas.toDataURL("image/jpeg", 0.82) });
    page.cleanup();
  }
  await pdfDocument.destroy();
  return { ...parseSailwaveResults(pages), screenshots };
}
