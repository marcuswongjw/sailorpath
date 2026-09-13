import readXlsxFile from "read-excel-file/web-worker";

self.onmessage = async (e: MessageEvent<ArrayBuffer>) => {
  try {
    const sheets = await readXlsxFile(e.data);
    self.postMessage({ ok: true, sheets });
  } catch (err) {
    self.postMessage({
      ok: false,
      error: err instanceof Error ? err.message : String(err),
    });
  }
};
