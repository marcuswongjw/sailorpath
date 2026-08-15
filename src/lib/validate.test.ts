import { describe, expect, it } from "vitest";
import {
  asEmail,
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

  it("asYmd", () => {
    expect(asYmd("2026-08-15").ok).toBe(true);
    expect(asYmd("15/08/2026").ok).toBe(false);
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
