import { describe, expect, it } from "vitest";
import { parseNewsBody } from "./newsBody";

describe("parseNewsBody", () => {
  it("keeps plain paragraphs", () => {
    expect(parseNewsBody("One.\n\nTwo.")).toEqual([
      { type: "paragraph", text: "One." },
      { type: "paragraph", text: "Two." },
    ]);
  });

  it("recognises headings and bullet lists", () => {
    expect(parseNewsBody("## Heading\n\n• A\n• B\n\n### Sub\n\n- C")).toEqual([
      { type: "heading", level: 2, text: "Heading" },
      { type: "list", items: ["A", "B"] },
      { type: "heading", level: 3, text: "Sub" },
      { type: "list", items: ["C"] },
    ]);
  });

  it("treats a block mixing bullets and prose as a paragraph", () => {
    expect(parseNewsBody("Intro\n• A")).toEqual([{ type: "paragraph", text: "Intro\n• A" }]);
  });

  it("ignores empty input", () => {
    expect(parseNewsBody("  \n\n ")).toEqual([]);
  });
});
