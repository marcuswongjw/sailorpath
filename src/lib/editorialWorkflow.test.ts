import { describe, expect, it } from "vitest";
import {
  parseEditorialFields,
  transitionEditorialStatus,
} from "./editorialWorkflow";

describe("editorial workflow", () => {
  it("normalizes a valid article draft and its tags", () => {
    expect(
      parseEditorialFields({
        slug: "  x15-worlds-preview  ",
        kind: "class_announcement",
        title: "X-15 Worlds preview",
        summary: "Reviewed event context.",
        body: "An editorial draft body.",
        authorDisplayName: "SailorPath editorial",
        sourceUrl: "https://x-15class.org/events/",
        sourceLabel: "Official calendar",
        tags: "X-15, source-led, x-15",
      })
    ).toMatchObject({
      slug: "x15-worlds-preview",
      kind: "class_announcement",
      tags: ["x-15", "source-led"],
    });
  });

  it("rejects unsafe slugs and orphaned source labels", () => {
    expect(() =>
      parseEditorialFields({
        slug: "Not valid",
        title: "Title",
        summary: "Summary",
        body: "Body",
      })
    ).toThrow("slug");

    expect(() =>
      parseEditorialFields({
        slug: "valid-slug",
        title: "Title",
        summary: "Summary",
        body: "Body",
        sourceLabel: "No URL",
      })
    ).toThrow("source label");
  });

  it("requires review before publication and supports returning a review to draft", () => {
    expect(transitionEditorialStatus("draft", "submit_review")).toBe("in_review");
    expect(transitionEditorialStatus("in_review", "publish")).toBe("published");
    expect(transitionEditorialStatus("in_review", "save_draft")).toBe("draft");
    expect(() => transitionEditorialStatus("draft", "publish")).toThrow("cannot publish");
  });
});
