// Explicit operator command only. Never part of the normal application build.
import { build } from "esbuild";
import { join } from "node:path";
import { mkdtemp, rm } from "node:fs/promises";
import { pathToFileURL } from "node:url";

const check = process.argv.includes("--check");
if (!check && !/^[0-9a-f-]{36}$/.test(process.env.RUN_APPROVED_WELCOME_CLAIM_ID || "")) {
  throw new Error("An explicit approved claim ID is required.");
}
const directory = await mkdtemp(join(process.cwd(), ".approved-welcome-"));
try {
  const outfile = join(directory, "send.mjs");
  await build({ entryPoints: ["scripts/send-approved-welcome.ts"], outfile,
    bundle: true, platform: "node", format: "esm", packages: "external",
    alias: { "@": "./src" }, write: !check, logLevel: "silent" });
  if (check) console.log("Approved welcome command compiled; no email sent.");
  else {
    await import(pathToFileURL(outfile).href);
  }
} finally { await rm(directory, { recursive: true, force: true }); }
