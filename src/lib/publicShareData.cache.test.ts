import { describe, expect, it, vi } from "vitest";
const mocks = vi.hoisted(() => ({ shared: vi.fn(async () => [{ regattaSlug: "published" }]), uncached: vi.fn() }));
vi.mock("react", () => ({ cache: (fn: unknown) => fn }));
vi.mock("@/db", () => ({ getDatabaseUrlMeta: () => true }));
vi.mock("@/lib/queries", () => ({ getCachedResultsForSailor: mocks.shared, getResultsForSailor: mocks.uncached,
  getCachedPublicRegattas: vi.fn(), getCachedSailorByHandle: vi.fn(), getRegattaBySlug: vi.fn(), getResultsForRegatta: vi.fn() }));
import { loadShareSailorResults } from "./publicShareData";
import { resolveFleetResultSheet } from "./publicShareData";
import { getCachedPublicRegattas } from "./queries";
describe("profile and social metadata cache routing", () => {
  it("uses the cross-request published-history cache even across separate render calls", async () => {
    await loadShareSailorResults("sailor"); await loadShareSailorResults("sailor");
    expect(mocks.shared).toHaveBeenCalledTimes(2);
    expect(mocks.uncached).not.toHaveBeenCalled();
  });
  it("propagates a public directory outage instead of caching a false missing-fleet response", async () => {
    vi.mocked(getCachedPublicRegattas).mockRejectedValueOnce(new Error("directory offline"));
    await expect(resolveFleetResultSheet("snsc-2026", "optimist-gold")).rejects.toThrow("directory offline");
  });
});
