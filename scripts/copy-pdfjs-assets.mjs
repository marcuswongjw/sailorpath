import { copyFile, mkdir } from "node:fs/promises";
import path from "node:path";

const source = path.resolve("node_modules/pdfjs-dist/legacy/build");
const destination = path.resolve("public/vendor/pdfjs");
const xlsxDestination = path.resolve("public/vendor/xlsx");

await mkdir(destination, { recursive: true });
await mkdir(xlsxDestination, { recursive: true });
await Promise.all([
  copyFile(path.join(source, "pdf.min.mjs"), path.join(destination, "pdf.mjs")),
  copyFile(
    path.join(source, "pdf.worker.min.mjs"),
    path.join(destination, "pdf.worker.min.mjs")
  ),
  copyFile(
    path.resolve("node_modules/xlsx/xlsx.mjs"),
    path.join(xlsxDestination, "xlsx.mjs")
  ),
]);
