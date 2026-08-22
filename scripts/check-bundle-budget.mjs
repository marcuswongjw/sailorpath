import { readdir, stat } from "node:fs/promises";
import path from "node:path";

const chunksDir = path.resolve(".next/static/chunks");
const maxTotalBytes = Number(process.env.MAX_CLIENT_JS_BYTES || 2_500_000);
const maxChunkBytes = Number(process.env.MAX_CLIENT_CHUNK_BYTES || 400_000);

async function listJavaScriptFiles(directory) {
  const entries = await readdir(directory, { withFileTypes: true });
  const nested = await Promise.all(
    entries.map(async (entry) => {
      const absolute = path.join(directory, entry.name);
      if (entry.isDirectory()) return listJavaScriptFiles(absolute);
      return entry.isFile() && entry.name.endsWith(".js") ? [absolute] : [];
    })
  );
  return nested.flat();
}

const files = await listJavaScriptFiles(chunksDir);
if (files.length === 0) {
  throw new Error(`No client JavaScript chunks found in ${chunksDir}`);
}

const sizes = await Promise.all(
  files.map(async (file) => ({ file, bytes: (await stat(file)).size }))
);
const totalBytes = sizes.reduce((sum, item) => sum + item.bytes, 0);
const largest = sizes.reduce((current, item) =>
  item.bytes > current.bytes ? item : current
);

console.log(
  `Client JS: ${totalBytes.toLocaleString()} bytes across ${files.length} chunks; largest ${largest.bytes.toLocaleString()} bytes (${path.basename(largest.file)})`
);

if (totalBytes > maxTotalBytes) {
  throw new Error(
    `Client JS total exceeds budget: ${totalBytes} > ${maxTotalBytes} bytes`
  );
}
if (largest.bytes > maxChunkBytes) {
  throw new Error(
    `Largest client chunk exceeds budget: ${largest.bytes} > ${maxChunkBytes} bytes`
  );
}
