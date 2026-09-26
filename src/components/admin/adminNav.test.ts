import { describe, expect, it } from "vitest";
import {
  parseAdminArea,
  parseAdminNav,
  reconcileEventsAddress,
  serializeAdminArea,
  serializeAdminNav,
} from "./adminNav";

describe("parseAdminNav", () => {
  it("defaults to Database → Sailors", () => {
    expect(parseAdminNav(new URLSearchParams())).toEqual({
      tab: "edit",
      sub: "sailors",
      regattaId: null,
    });
  });

  it("parses stats / import / ranking / wingfoil / techno293 / changelog tabs", () => {
    expect(parseAdminNav(new URLSearchParams("tab=stats")).tab).toBe("stats");
    expect(parseAdminNav(new URLSearchParams("tab=ilca")).tab).toBe("ilca");
    expect(parseAdminNav(new URLSearchParams("tab=wingfoil")).tab).toBe(
      "wingfoil"
    );
    expect(parseAdminNav(new URLSearchParams("tab=techno293")).tab).toBe(
      "techno293"
    );
    expect(parseAdminNav(new URLSearchParams("tab=changelog")).tab).toBe(
      "changelog"
    );
  });

  it("migrates legacy gold tab to Database → Selection", () => {
    expect(parseAdminNav(new URLSearchParams("tab=gold"))).toEqual({
      tab: "edit",
      sub: "selection",
      regattaId: null,
    });
  });

  it("migrates legacy edit+claims to ops+claims", () => {
    expect(parseAdminNav(new URLSearchParams("tab=edit&sub=claims"))).toEqual({
      tab: "ops",
      sub: "claims",
      regattaId: null,
    });
  });

  it("parses Ops → Audit", () => {
    expect(parseAdminNav(new URLSearchParams("tab=ops&sub=audit"))).toEqual({
      tab: "ops",
      sub: "audit",
      regattaId: null,
    });
  });

  it("parses Ops → Coach access", () => {
    expect(parseAdminNav(new URLSearchParams("tab=ops&sub=coaches"))).toEqual({
      tab: "ops",
      sub: "coaches",
      regattaId: null,
    });
  });

  it("opens a legacy results link inside Regattas", () => {
    expect(
      parseAdminNav(
        new URLSearchParams("tab=edit&sub=results&regattaId=abc-123")
      )
    ).toEqual({
      tab: "regattas",
      sub: "sailors",
      regattaId: "abc-123",
    });
  });

  it("reads the sheet selected on an event", () => {
    expect(
      parseAdminNav(
        new URLSearchParams("tab=regattas&sheet=abc-123")
      ).regattaId
    ).toBe("abc-123");
    expect(
      parseAdminNav(
        new URLSearchParams("tab=edit&sub=regattas&sheet=abc-123")
      ).regattaId
    ).toBe("abc-123");
  });

  it("ignores regattaId outside regattas", () => {
    expect(
      parseAdminNav(
        new URLSearchParams("tab=edit&sub=sailors&regattaId=abc-123")
      ).regattaId
    ).toBeNull();
  });
});

describe("serializeAdminNav", () => {
  it("writes the canonical area for the current screens", () => {
    expect(serializeAdminNav({ tab: "regattas", sub: "sailors" })).toBe(
      "area=events&view=card"
    );
    expect(serializeAdminNav({ tab: "ops", sub: "support" })).toBe(
      "area=inbox&view=support"
    );
    expect(serializeAdminNav({ tab: "ops", sub: "audit" })).toBe(
      "area=settings&view=audit"
    );
    expect(serializeAdminNav({ tab: "ops", sub: "coaches" })).toBe(
      "area=inbox&view=coaches"
    );
  });

  it("includes the open class sheet on Events", () => {
    expect(
      serializeAdminNav({
        tab: "regattas",
        sub: "sailors",
        regattaId: "r1",
      })
    ).toBe("area=events&view=results&sheet=r1");
    expect(
      serializeAdminNav(
        { tab: "edit", sub: "regattas", regattaId: "r1" },
        "singapore-nationals-2026"
      )
    ).toBe("area=events&view=results&event=singapore-nationals-2026&sheet=r1");
    expect(
      serializeAdminNav({
        tab: "edit",
        sub: "sailors",
        regattaId: "r1",
      })
    ).toBe("area=sailors&view=directory");
  });

  it("omits class context outside Events", () => {
    expect(serializeAdminNav({ tab: "stats", sub: "sailors" })).toBe(
      "area=insights&view=metrics"
    );
    expect(serializeAdminNav({ tab: "wingfoil", sub: "sailors" })).toBe(
      "area=insights&view=wingfoil"
    );
    expect(serializeAdminNav({ tab: "changelog", sub: "sailors" })).toBe(
      "area=settings&view=changelog"
    );
  });
});

describe("canonical admin areas", () => {
  it("keeps Overview as its own canonical destination", () => {
    expect(parseAdminNav(new URLSearchParams("area=overview"))).toMatchObject({
      tab: "overview",
      regattaId: null,
    });
    expect(
      serializeAdminNav({ tab: "overview", sub: "sailors" })
    ).toBe("area=overview");
  });

  it("maps both regatta addresses to Events and keeps the class", () => {
    expect(parseAdminArea(new URLSearchParams("tab=regattas&sheet=abc"))).toMatchObject({
      area: "events",
      view: "results",
      sheet: "abc",
    });
    expect(
      parseAdminArea(new URLSearchParams("tab=edit&sub=regattas&regattaId=abc"))
    ).toMatchObject({ area: "events", sheet: "abc" });
  });

  it("ignores a class id on an unrelated destination", () => {
    expect(
      parseAdminArea(new URLSearchParams("tab=stats&sheet=abc"))
    ).toEqual({
      area: "insights",
      view: "metrics",
      event: null,
      sheet: null,
    });
    expect(
      parseAdminArea(
        new URLSearchParams("area=insights&view=metrics&sheet=abc&regattaId=zzz")
      ).sheet
    ).toBeNull();
  });

  it("maps the remaining legacy screens", () => {
    expect(parseAdminArea(new URLSearchParams("tab=edit")).view).toBe("directory");
    expect(parseAdminArea(new URLSearchParams("tab=ops")).view).toBe("claims");
    expect(parseAdminArea(new URLSearchParams("tab=gold")).view).toBe("selection");
    expect(parseAdminArea(new URLSearchParams("tab=ops&sub=promote")).view).toBe(
      "promotions"
    );
    expect(parseAdminArea(new URLSearchParams("tab=import")).view).toBe("import");
    expect(parseAdminArea(new URLSearchParams("tab=analysis")).view).toBe("optimist");
    expect(parseAdminArea(new URLSearchParams("tab=changelog")).area).toBe("settings");
  });

  it("keeps all four Sailors views inside the Sailors workspace", () => {
    expect(
      parseAdminNav(new URLSearchParams("area=sailors&view=directory"))
    ).toMatchObject({ tab: "edit", sub: "sailors" });
    expect(
      parseAdminNav(new URLSearchParams("area=sailors&view=duplicates"))
    ).toMatchObject({ tab: "edit", sub: "duplicates" });
    expect(
      parseAdminNav(new URLSearchParams("area=sailors&view=promotions"))
    ).toMatchObject({ tab: "edit", sub: "promotions" });
    expect(
      parseAdminNav(new URLSearchParams("area=sailors&view=selection"))
    ).toMatchObject({ tab: "edit", sub: "selection" });
    expect(
      parseAdminNav(new URLSearchParams("tab=ops&sub=promote"))
    ).toMatchObject({ tab: "edit", sub: "promotions" });
  });

  it("normalizes every legacy Ops queue into Inbox", () => {
    expect(parseAdminArea(new URLSearchParams("tab=ops&sub=suggestions"))).toMatchObject({
      area: "inbox",
      view: "suggestions",
    });
    expect(parseAdminArea(new URLSearchParams("tab=ops&sub=claims"))).toMatchObject({
      area: "inbox",
      view: "claims",
    });
    expect(parseAdminArea(new URLSearchParams("tab=ops&sub=coaches"))).toMatchObject({
      area: "inbox",
      view: "coaches",
    });
    expect(parseAdminArea(new URLSearchParams("tab=ops&sub=support"))).toMatchObject({
      area: "inbox",
      view: "support",
    });
  });

  it("drops an unknown class and keeps the Events view", () => {
    const parsed = parseAdminArea(
      new URLSearchParams("area=events&sheet=missing&view=import")
    );
    const next = reconcileEventsAddress(parsed, () => ({
      found: false,
      event: null,
    }));
    expect(next.error).toMatch(/not found/);
    expect(serializeAdminArea(next.state)).toBe("area=events&view=import");
  });

  it("replaces a disagreeing weekend with the class's real event", () => {
    const parsed = parseAdminArea(
      new URLSearchParams("area=events&event=other&sheet=abc&view=results")
    );
    const next = reconcileEventsAddress(parsed, () => ({
      found: true,
      event: "singapore-nationals-2026",
    }));
    expect(next.state.event).toBe("singapore-nationals-2026");
    expect(next.state.sheet).toBe("abc");
    expect(next.error).toBeNull();
  });
});
