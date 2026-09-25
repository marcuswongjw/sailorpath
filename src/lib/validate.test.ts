import { describe, expect, it } from "vitest";
import {
  asEmail,
  asOptionalRaceCount,
  asPositiveInteger,
  asRank,
  asUuid,
  asYmd,
  asBoundedText,
  asHttpUrl,
} from "./validate";

describe("validate", () => {
  it("asUuid", () => {
    expect(asUuid("not-a-uuid").ok).toBe(false);
    expect(
      asUuid("550e8400-e29b-41d4-a716-446655440000").ok
    ).toBe(true);
  });

  it("asRank", () => {
    expect(asRank(0).ok).toBe(false);
    expect(asRank(1).ok).toBe(true);
    if (asRank(3.7).ok) {
      expect(asRank(3.7)).toMatchObject({ value: 4 });
    }
  });

  it("asOptionalRaceCount keeps zero and rejects junk", () => {
    expect(asOptionalRaceCount("")).toMatchObject({ value: null });
    expect(asOptionalRaceCount(null)).toMatchObject({ value: null });
    expect(asOptionalRaceCount(0)).toMatchObject({ value: 0 });
    expect(asOptionalRaceCount("0")).toMatchObject({ value: 0 });
    expect(asOptionalRaceCount(6)).toMatchObject({ value: 6 });
    expect(asOptionalRaceCount(-1).ok).toBe(false);
    expect(asOptionalRaceCount("nope").ok).toBe(false);
  });

  it("asPositiveInteger", () => {
    expect(asPositiveInteger(-1, "fleet size").ok).toBe(false);
    expect(asPositiveInteger(0, "fleet size").ok).toBe(false);
    expect(asPositiveInteger(1, "fleet size")).toMatchObject({ value: 1 });
  });

  it("asYmd", () => {
    expect(asYmd("2026-08-15").ok).toBe(true);
    expect(asYmd("15/08/2026").ok).toBe(false);
    expect(asYmd("2026-02-31").ok).toBe(false);
    expect(asYmd("2025-02-29").ok).toBe(false);
    expect(asYmd("2024-02-29").ok).toBe(true);
    expect(asYmd("2026-04-31").ok).toBe(false);
  });

  it("asEmail", () => {
    expect(asEmail("a@b.com").ok).toBe(true);
    expect(asEmail("nope").ok).toBe(false);
  });

  it("asBoundedText", () => {
    expect(
      asBoundedText("hi", { min: 10, max: 100, required: true }).ok
    ).toBe(false);
    expect(
      asBoundedText("hello world", { min: 5, max: 100, required: true }).ok
    ).toBe(true);
  });

  it("asHttpUrl", () => {
    expect(asHttpUrl("https://x.com/a").ok).toBe(true);
    expect(asHttpUrl("ftp://x.com").ok).toBe(false);
    expect(asHttpUrl("").ok).toBe(true);
  });
});
