import { describe, expect, it } from "vitest";
import {
  externalRegattaImportPolicy,
  normalizeOfficialResultsSourceName,
  normalizeOfficialResultsUrl,
} from "./externalRegattaImport";

describe("externalRegattaImportPolicy", () => {
  it("keeps Singapore imports in the Singapore policy", () => {
    expect(externalRegattaImportPolicy("Singapore")).toMatchObject({
      geography: "SGP",
      isExternal: false,
      requiresOfficialResultsSource: false,
      forcesNonRanking: false,
    });
  });

  it("requires reviewed, non-ranking imports for Malaysia", () => {
    expect(externalRegattaImportPolicy("MY")).toMatchObject({
      geography: "MAS",
      isExternal: true,
      requiresOfficialResultsSource: true,
      forcesNonRanking: true,
      importLifecycle: "in_review",
    });
  });

  it("accepts only web result source URLs", () => {
    expect(
      normalizeOfficialResultsUrl(
        "https://drive.google.com/drive/folders/example"
      )
    ).toBe("https://drive.google.com/drive/folders/example");
    expect(normalizeOfficialResultsUrl("javascript:alert(1)")).toBeNull();
    expect(normalizeOfficialResultsUrl("not a url")).toBeNull();
  });

  it("normalizes source labels for safe display", () => {
    expect(normalizeOfficialResultsSourceName("  Optimist   Overall.pdf  ")).toBe(
      "Optimist Overall.pdf"
    );
    expect(normalizeOfficialResultsSourceName(" ")).toBeNull();
  });
});
