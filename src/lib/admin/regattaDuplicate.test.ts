import { describe, expect, it } from "vitest";
import { getRegattaEvent } from "@/lib/regattaEvents";
import {
  availableRegattaSlug,
  findRegattaDuplicate,
  mergeRegattaIdentities,
  planNewClassSave,
  planNewRegattaSave,
  regattaNameSimilarity,
} from "./regattaDuplicate";

const SILVER = {
  id: "evt-silver",
  slug: "rsyc-optimist-silver-fleet-knockout-championship-2026",
  name: "RSYC Optimist Silver Fleet Knockout Championship 2026",
  startDate: "2026-09-26",
  classes: ["Optimist Silver"],
  countsForRanking: true,
};

describe("regatta duplicate names", () => {
  it("flags a long name contained in an existing regatta", () => {
    const match = findRegattaDuplicate(
      { name: "RSYC Optimist Knockout Championship 2026" },
      [SILVER]
    );
    expect(match?.reason).toBe("name");
    expect(match?.existing.slug).toBe(SILVER.slug);
    expect(regattaNameSimilarity(
      "RSYC Optimist Knockout Championship 2026",
      SILVER.name
    )).toBeGreaterThanOrEqual(0.9);
  });

  it("flags the known short RSYC alias as the silver weekend", () => {
    const match = findRegattaDuplicate(
      { name: "RSYC Optimist Knockout 2026" },
      [SILVER]
    );
    expect(match?.reason).toBe("alias");
    expect(getRegattaEvent("rsyc-optimist-knockout-2026")?.slug).toBe(SILVER.slug);
  });

  it("flags the same slug when punctuation differs", () => {
    const match = findRegattaDuplicate(
      { name: "RSYC Optimist Silver Fleet Knockout Championship, 2026" },
      [SILVER]
    );
    expect(match?.reason).toBe("slug");
  });

  it("leaves NSC Cup 1 and NSC Cup 2 as different regattas", () => {
    expect(
      findRegattaDuplicate(
        { name: "NSC Cup 1 2025" },
        [{ slug: "nsc-cup-2-2025", name: "NSC Cup 2 2025", startDate: "2025-08-01" }]
      )
    ).toBeNull();
  });

  it("leaves Gold and Silver, and ILCA 4 and ILCA 6, as different regattas", () => {
    expect(
      findRegattaDuplicate(
        { name: "RSYC Optimist Gold Fleet Knockout Championship 2026" },
        [SILVER]
      )
    ).toBeNull();
    expect(
      findRegattaDuplicate(
        { name: "ILCA 4 Nationals 2026" },
        [{ slug: "ilca-6-nationals-2026", name: "ILCA 6 Nationals 2026" }]
      )
    ).toBeNull();
  });

  it("flags a one-character typo of the same regatta", () => {
    const match = findRegattaDuplicate(
      { name: "RSYC Optimist Silver Fleet Knockout Champioship 2026" },
      [SILVER]
    );
    expect(match?.reason).toBe("name");
  });

  it("prefers the slug collision over a weaker similar name", () => {
    const match = findRegattaDuplicate(
      { name: "RSYC Optimist Silver Fleet Knockout Championship 2026" },
      [
        {
          slug: "other-knockout-2026",
          name: "RSYC Optimist Knockout Championship 2026",
        },
        SILVER,
      ]
    );
    expect(match?.reason).toBe("slug");
    expect(match?.existing.slug).toBe(SILVER.slug);
  });
});

describe("planNewRegattaSave", () => {
  const input = {
    name: "RSYC Optimist Knockout Championship 2026",
    startDate: "2026-09-26",
    endDate: "2026-10-04",
    venue: "RSYC",
  };

  it("asks before saving a similar name", () => {
    const plan = planNewRegattaSave(input, [SILVER], null);
    expect(plan.action).toBe("needs-decision");
  });

  it("updates the existing weekend without clearing its classes", () => {
    const plan = planNewRegattaSave(input, [SILVER], "update");
    expect(plan.action).toBe("save");
    if (plan.action !== "save") return;
    expect(plan.body.slug).toBe(SILVER.slug);
    expect(plan.body.create).toBe(false);
    expect(plan.body.keepUnspecified).toBe(true);
    expect(plan.body.classes).toBe("Optimist Silver");
    expect(plan.body.name).toBe(input.name);
    expect(plan.body.venue).toBe("RSYC");
  });

  it("creates a separate regatta on a slug that does not replace the existing one", () => {
    const plan = planNewRegattaSave(input, [SILVER], "separate");
    expect(plan.action).toBe("save");
    if (plan.action !== "save") return;
    expect(plan.body.create).toBe(true);
    expect(plan.body.slug).not.toBe(SILVER.slug);
    expect(getRegattaEvent(plan.body.slug)?.slug).not.toBe(SILVER.slug);
  });

  it("saves a distinct name without asking", () => {
    const plan = planNewRegattaSave(
      { name: "Harbour Cup 2026", startDate: "2026-11-01" },
      [SILVER],
      null
    );
    expect(plan.action).toBe("save");
    if (plan.action !== "save") return;
    expect(plan.body.create).toBe(true);
    expect(plan.body.slug).toBe("harbour-cup-2026");
  });
});

describe("availableRegattaSlug", () => {
  it("keeps an alias off the canonical weekend and then uses the date", () => {
    const slug = availableRegattaSlug("RSYC Optimist Knockout 2026", [SILVER.slug], {
      startDate: "2026-09-26",
      avoidAliases: true,
    });
    expect(slug).toBe("rsyc-optimist-knockout-2026-2026-09-26");
    expect(getRegattaEvent(slug)).toBeNull();
  });

  it("adds the boat class when that class name is already stored", () => {
    const slug = availableRegattaSlug(SILVER.name, [SILVER.slug], {
      extra: "Optimist Silver",
      startDate: "2026-09-26",
    });
    expect(slug).toBe(
      "rsyc-optimist-silver-fleet-knockout-championship-2026-optimist-silver"
    );
  });
});

describe("planNewClassSave", () => {
  const existing = [
    {
      id: "class-1",
      slug: "temasek-regatta-2026",
      name: "Temasek Regatta 2026",
      startDate: "2026-06-20",
    },
  ];

  it("asks, then updates that class or creates one with its own slug", () => {
    const input = {
      name: "Temasek Regatta 2026",
      date: "2026-06-20",
      boatClass: "Optimist",
      division: "Gold",
    };
    expect(planNewClassSave(input, existing, null).action).toBe("needs-decision");
    expect(planNewClassSave(input, existing, "update")).toEqual({
      action: "update",
      id: "class-1",
    });
    expect(planNewClassSave(input, existing, "separate")).toEqual({
      action: "create",
      slug: "temasek-regatta-2026-optimist-gold",
    });
  });
});

describe("mergeRegattaIdentities", () => {
  it("keeps a saved class list when a later copy omits classes", () => {
    const merged = mergeRegattaIdentities([
      [{ slug: SILVER.slug, name: SILVER.name, classes: ["Optimist Silver"] }],
      [{ slug: SILVER.slug, name: "Saved name", classes: [], id: "saved-1" }],
    ]);
    expect(merged).toEqual([
      {
        slug: SILVER.slug,
        name: "Saved name",
        classes: ["Optimist Silver"],
        id: "saved-1",
      },
    ]);
  });
});
