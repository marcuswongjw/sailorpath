import { describe, expect, it } from "vitest";
import { cascadeLine, summarizeNames } from "./confirmCopy";

describe("summarizeNames", () => {
  it("lists up to the limit then counts extras", () => {
    const names = ["A", "B", "C", "D", "E", "F"];
    expect(summarizeNames(names, 3)).toEqual({
      listed: "• A\n• B\n• C",
      extra: 3,
    });
  });

  it("handles empty", () => {
    expect(summarizeNames([])).toEqual({ listed: "(none)", extra: 0 });
  });
});

describe("cascadeLine", () => {
  it("formats counts", () => {
    expect(cascadeLine("Results", 0)).toBe("• Results: none");
    expect(cascadeLine("Results", 12)).toBe("• Results: 12");
  });
});
