import { renderToStaticMarkup } from "react-dom/server";
import { beforeEach, describe, expect, it, vi } from "vitest";
vi.mock("@/lib/queries", () => ({getCachedPublicRegattas: vi.fn()}));
import { getCachedPublicRegattas } from "@/lib/queries";
import ClassesIndexPage from "./page";

beforeEach(() => { vi.mocked(getCachedPublicRegattas).mockReset().mockResolvedValue([]); });
describe("class directory", () => {
  it("includes scored classes and their existing standings alongside class guides", async () => {
    vi.mocked(getCachedPublicRegattas).mockResolvedValue(["ILCA 4", "29er", "420", "WingFoil"].map((boatClass) => ({
      id: boatClass, slug: boatClass, name: boatClass, boatClass, division: "Open", date: "2026-01-01", totalFleetSize: 10, raceCount: 3,
    })));
    const html = renderToStaticMarkup(await ClassesIndexPage());
    for (const name of ["ILCA 4", "29er", "420", "WingFoil"]) expect(html).toContain(`Browse ${name} results`);
    expect(html).toContain('href="/results?class=ILCA%204"');
    expect(html).toContain('href="/sg/wingfoil"');
    expect(html).toContain('href="/classes/x15"');
    expect(html).toContain('href="/classes/optimist"');
    expect(html).not.toContain('/classes/ilca');
  });
  it("retains guides and explains unavailable results", async () => {
    vi.mocked(getCachedPublicRegattas).mockRejectedValue(new Error("offline"));
    const html = renderToStaticMarkup(await ClassesIndexPage());
    expect(html).toContain("Class results are temporarily unavailable");
    expect(html).toContain("X-15");
  });
});
