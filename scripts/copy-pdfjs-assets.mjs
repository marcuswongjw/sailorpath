import { copyFile, mkdir } from "node:fs/promises";
import path from "node:path";

const source = path.resolve("node_modules/pdfjs-dist/legacy/build");
const destination = path.resolve("public/vendor/pdfjs");
const xlsxDestination = path.resolve("public/vendor/xlsx");
const tesseractDestination = path.resolve("public/vendor/tesseract");
const tesseractCoreDestination = path.join(tesseractDestination, "core");
const tesseractLanguageDestination = path.join(tesseractDestination, "lang");

await mkdir(destination, { recursive: true });
await mkdir(xlsxDestination, { recursive: true });
await mkdir(tesseractCoreDestination, { recursive: true });
await mkdir(tesseractLanguageDestination, { recursive: true });
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
  copyFile(
    path.resolve("node_modules/tesseract.js/dist/worker.min.js"),
    path.join(tesseractDestination, "worker.min.js")
  ),
  copyFile(
    path.resolve("node_modules/tesseract.js-core/tesseract-core-lstm.wasm.js"),
    path.join(tesseractCoreDestination, "tesseract-core-lstm.wasm.js")
  ),
  copyFile(
    path.resolve("node_modules/tesseract.js-core/tesseract-core-simd-lstm.wasm.js"),
    path.join(tesseractCoreDestination, "tesseract-core-simd-lstm.wasm.js")
  ),
  copyFile(
    path.resolve("node_modules/@tesseract.js-data/eng/4.0.0_best_int/eng.traineddata.gz"),
    path.join(tesseractLanguageDestination, "eng.traineddata.gz")
  ),
]);
