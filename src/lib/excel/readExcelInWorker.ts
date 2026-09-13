import type { ResultsSheet } from "./readResultsWorkbook";

/**
 * Parse an Excel file using read-excel-file in a dedicated Web Worker
 * so large workbooks (up to 15MB) do not freeze the main UI thread.
 * Falls back to main-thread browser parsing if Workers are not supported.
 */
export async function readExcelInWorker(data: ArrayBuffer): Promise<ResultsSheet[]> {
  if (typeof window !== "undefined" && typeof Worker !== "undefined") {
    return new Promise((resolve, reject) => {
      let worker: Worker | null = null;
      try {
        worker = new Worker(new URL("./excelWorker.ts", import.meta.url));
      } catch (err) {
        // Fallback if worker construction fails (e.g. strict CSP / environment)
        console.warn("Worker creation failed, falling back to main thread:", err);
        import("read-excel-file/browser")
          .then(({ default: readXlsxFile }) => readXlsxFile(data))
          .then((sheets) => resolve(sheets as unknown as ResultsSheet[]))
          .catch(reject);
        return;
      }

      worker.onmessage = (e: MessageEvent<{ ok: boolean; sheets?: ResultsSheet[]; error?: string }>) => {
        worker?.terminate();
        if (e.data.ok && e.data.sheets) {
          resolve(e.data.sheets);
        } else {
          reject(new Error(e.data.error || "Failed to parse spreadsheet in worker"));
        }
      };

      worker.onerror = (err) => {
        worker?.terminate();
        reject(new Error(err.message || "Excel worker parsing error"));
      };

      try {
        // Transfer ArrayBuffer ownership to worker for zero-copy performance
        worker.postMessage(data, [data]);
      } catch {
        worker.postMessage(data);
      }
    });
  }

  // Fallback for SSR or non-worker test environments
  const { default: readXlsxFile } = await import("read-excel-file/browser");
  const sheets = await readXlsxFile(data);
  return sheets as unknown as ResultsSheet[];
}
