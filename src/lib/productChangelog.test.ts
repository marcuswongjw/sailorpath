import { describe, expect, it } from "vitest";
import {
  PRODUCT_CHANGELOG,
  getLatestProductChangelogAt,
  getPublicChangelogEntries,
  isProductChangelogUnread,
} from "./productChangelog";

describe("productChangelog", () => {
  it("has stable unique ids and slugs", () => {
    const ids = PRODUCT_CHANGELOG.map((e) => e.id);
    const slugs = PRODUCT_CHANGELOG.map((e) => e.slug);
    expect(new Set(ids).size).toBe(ids.length);
    expect(new Set(slugs).size).toBe(slugs.length);
  });

  it("excludes admin-only entries from public list", () => {
    const publicIds = new Set(getPublicChangelogEntries().map((e) => e.id));
    expect(publicIds.has("2026-08-17-admin-ux")).toBe(false);
    expect(publicIds.has("2026-08-16-admin-stats")).toBe(false);
    expect(publicIds.has("2026-08-18-gender-audit")).toBe(false);
    expect(publicIds.has("2026-08-18-audience-cards")).toBe(true);
  });

  it("detects unread when lastSeen is null or older", () => {
    expect(isProductChangelogUnread(null)).toBe(true);
    expect(isProductChangelogUnread(new Date("2020-01-01"))).toBe(true);
    const after = new Date(getLatestProductChangelogAt().getTime() + 86400000);
    expect(isProductChangelogUnread(after)).toBe(false);
  });
});
