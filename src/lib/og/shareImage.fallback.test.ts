import { describe, expect, it, vi } from "vitest";
vi.mock("node:fs/promises", () => ({ readFile: vi.fn().mockRejectedValue(new Error("ENOENT")) }));
import { renderResultShareImage } from "./shareImage";
describe("share image resilience", () => {
  it("renders PNG even when the brand font cannot be read", async () => {
    const response = await renderResultShareImage({ regattaName: "Test Cup", classLabel: "ILCA 6", datesText: "2026", top3: [] });
    const bytes = new Uint8Array(await response.arrayBuffer());
    expect([...bytes.slice(0, 8)]).toEqual([137,80,78,71,13,10,26,10]);
  }, 20000);
});
