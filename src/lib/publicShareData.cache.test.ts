import { describe, expect, it, vi } from "vitest";
const mocks = vi.hoisted(() => ({ shared: vi.fn(async () => [{ regattaSlug: "published" }]), uncached: vi.fn() }));
vi.mock("react", () => ({ cache: (fn: unknown) => fn }));
vi.mock("@/db", () => ({ getDatabaseUrlMeta: () => true }));
vi.mock("@/lib/queries", () => ({ getCachedResultsForSailor: mocks.shared, getResultsForSailor: mocks.uncached,
  getCachedPublicRegattas: vi.fn(), getCachedSailorByHandle: vi.fn(), getRegattaBySlug: vi.fn(), getResultsForRegatta: vi.fn() }));
import { loadShareSailorResults } from "./publicShareData";
describe("profile and social metadata cache routing", () => {
  it("uses the cross-request published-history cache even across separate render calls", async () => {
    await loadShareSailorResults("sailor"); await loadShareSailorResults("sailor");
    expect(mocks.shared).toHaveBeenCalledTimes(2);
    expect(mocks.uncached).not.toHaveBeenCalled();
  });
});
