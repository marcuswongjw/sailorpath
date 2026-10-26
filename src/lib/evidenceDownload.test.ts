import { afterEach, describe, expect, it, vi } from "vitest";
import { evidenceDownloadUrl, evidenceDownloadUrlForPath, isEvidenceObjectPath } from "./evidenceDownload";
const path = "11111111-1111-4111-8111-111111111111/123_results.pdf";
afterEach(() => vi.unstubAllEnvs());
describe("private evidence references", () => {
  it("rewrites own-project legacy public URLs without exposing a storage URL", () => {
    vi.stubEnv("NEXT_PUBLIC_SUPABASE_URL", "https://fixture.supabase.co");
    const result = evidenceDownloadUrl(`https://fixture.supabase.co/storage/v1/object/public/regatta-evidence/${path}`);
    expect(result).toBe(evidenceDownloadUrlForPath(path));
    expect(new URL(result!, "https://sailorpath.com").searchParams.get("path")).toBe(path);
  });
  it("preserves official external evidence and stable internal URLs", () => {
    vi.stubEnv("NEXT_PUBLIC_SUPABASE_URL", "https://fixture.supabase.co");
    expect(evidenceDownloadUrl("https://organiser.example/results.pdf")).toBe("https://organiser.example/results.pdf");
    expect(evidenceDownloadUrl(evidenceDownloadUrlForPath(path))).toBe(evidenceDownloadUrlForPath(path));
    expect(evidenceDownloadUrl(null)).toBeNull();
  });
  it.each(["../secret", path.replace("123_results.pdf", "../other.pdf"), `${path}/extra`, path.replace("/", "\\"), "/absolute.pdf", "user/file.pdf"])("rejects traversal and malformed object keys: %s", (value) => {
    expect(isEvidenceObjectPath(value)).toBe(false);
    expect(() => evidenceDownloadUrlForPath(value)).toThrow();
  });
});
