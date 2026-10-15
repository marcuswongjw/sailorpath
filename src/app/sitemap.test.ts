import { describe, expect, it } from "vitest";
import sitemap from "./sitemap";

describe("public sitemap", () => {
  it("does not advertise the X-15 review route", () => {
    expect(sitemap().map((entry) => entry.url)).not.toContain(
      "https://sailorpath.com/classes/x-15"
    );
  });
});
