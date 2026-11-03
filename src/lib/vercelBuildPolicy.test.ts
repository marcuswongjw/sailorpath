import { execFileSync, spawnSync } from "node:child_process";
import { mkdtempSync, writeFileSync, mkdirSync, rmSync } from "node:fs";
import { tmpdir } from "node:os";
import { resolve, join } from "node:path";
import { afterEach, expect, it } from "vitest";

const script = resolve("scripts/vercel-ignore-build.cjs");
const fixtures: string[] = [];
afterEach(() => { fixtures.splice(0).forEach((dir) => rmSync(dir, { recursive: true, force: true })); });
function fixture() {
  const cwd = mkdtempSync(join(tmpdir(), "sailorpath-build-policy-")); fixtures.push(cwd);
  const git = (...args: string[]) => execFileSync("git", args, { cwd, encoding: "utf8", stdio: ["ignore", "pipe", "pipe"] }).trim();
  git("init", "-q"); git("config", "user.email", "test@sailorpath.invalid"); git("config", "user.name", "Build policy test");
  const commit = (path: string, text: string) => {
    mkdirSync(resolve(cwd, path, ".."), { recursive: true }); writeFileSync(join(cwd, path), text);
    git("add", path); git("-c", "commit.gpgsign=false", "commit", "-qm", "fixture"); return git("rev-parse", "HEAD");
  };
  const base = commit("src/app/page.tsx", "export default function Page() { return null; }");
  const run = (environment = "preview", previous = base) => spawnSync(process.execPath, [script], { cwd, env: { ...process.env, VERCEL_ENV: environment, VERCEL_GIT_PREVIOUS_SHA: previous, VERCEL_GIT_COMMIT_SHA: git("rev-parse", "HEAD") }, encoding: "utf8" });
  return { commit, run, base };
}

it("skips evidence-only previews but always builds production", () => {
  const f = fixture(); f.commit("outputs/review.md", "review"); f.commit("src/db/migrations/999_fixture.sql", "-- database evidence");
  expect(f.run().status).toBe(0);
  expect(f.run("production").status).toBe(1);
});
it("sees runtime changes earlier in a multi-commit push", () => {
  const f = fixture(); f.commit("src/app/page.tsx", "changed runtime"); f.commit("README.md", "docs after runtime");
  expect(f.run().status).toBe(1);
});
it("builds unknown inputs and build scripts", () => {
  const f = fixture(); f.commit("scripts/copy-pdfjs-assets.mjs", "changed build input");
  expect(f.run().status).toBe(1);
});
it("builds first previews, missing history and explicit redeployments", () => {
  const f = fixture();
  expect(f.run("preview", "").status).toBe(1);
  expect(f.run("preview", "a".repeat(40)).status).toBe(1);
  expect(f.run("preview", f.base).status).toBe(1);
});
