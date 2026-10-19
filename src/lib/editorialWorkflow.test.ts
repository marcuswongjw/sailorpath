import { describe, expect, it } from "vitest";
import {
  parseEditorialFields,
  SEEDED_EDITORIAL_DRAFTS,
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

  it("supports publishing or saving as draft across states while keeping review and archive transitions", () => {
    expect(transitionEditorialStatus("draft", "save_draft")).toBe("draft");
    expect(transitionEditorialStatus("draft", "submit_review")).toBe("in_review");
    expect(transitionEditorialStatus("draft", "publish")).toBe("published");
    expect(transitionEditorialStatus("in_review", "publish")).toBe("published");
    expect(transitionEditorialStatus("in_review", "save_draft")).toBe("draft");
    expect(transitionEditorialStatus("published", "save_draft")).toBe("draft");
    expect(transitionEditorialStatus("published", "publish")).toBe("published");
    expect(transitionEditorialStatus("published", "archive")).toBe("archived");
    expect(transitionEditorialStatus("archived", "save_draft")).toBe("draft");
    expect(() => transitionEditorialStatus("archived", "archive")).toThrow("cannot archive");
  });

  it("includes the SailorPath Asian Optimist Index (Beta) methodology and event register draft", () => {
    const draft = SEEDED_EDITORIAL_DRAFTS.find(
      (item) => item.slug === "asian-optimist-index-beta-methodology-and-event-register"
    );
    expect(draft).toBeDefined();
    expect(draft?.status).toBe("draft");
    expect(draft?.kind).toBe("class_announcement");
    expect(draft?.body).toContain("22nd LIRP 2026");
    expect(draft?.body).toContain("5th LIYSC 2026");
    expect(draft?.body).toContain("MSA–NSC–MILO National Open");
    expect(draft?.body).toContain("Thailand International Sailing Championships");
    expect(draft?.body).toContain("Singapore Youth Sailing Championships");
    expect(draft?.body).toContain("Hong Kong Race Week");
    expect(draft?.body).toContain("Mussanah Race Week");
  });

  it("includes the scoring deep dive draft for coaches and families", () => {
    const draft = SEEDED_EDITORIAL_DRAFTS.find(
      (item) => item.slug === "how-the-asian-optimist-index-scores-regattas"
    );
    expect(draft).toBeDefined();
    expect(draft?.status).toBe("draft");
    expect(draft?.kind).toBe("product_update");
    expect(draft?.body).toContain("Points = E × (N − P + 1) / N");
    expect(draft?.body).toContain("The host-country cap is essential");
    expect(draft?.body).toContain("Lower Grades Can Beat Weak Higher Grades");
  });
});
