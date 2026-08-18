import { describe, expect, it } from "vitest";
import { parseAdminNav, serializeAdminNav } from "./adminNav";

describe("parseAdminNav", () => {
  it("defaults to Database → Sailors", () => {
    expect(parseAdminNav(new URLSearchParams())).toEqual({
      tab: "edit",
      sub: "sailors",
      regattaId: null,
    });
  });

  it("parses stats / import / ranking tabs", () => {
    expect(parseAdminNav(new URLSearchParams("tab=stats")).tab).toBe("stats");
    expect(parseAdminNav(new URLSearchParams("tab=ilca")).tab).toBe("ilca");
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

  it("keeps Database results + regattaId", () => {
    expect(
      parseAdminNav(
        new URLSearchParams("tab=edit&sub=results&regattaId=abc-123")
      )
    ).toEqual({
      tab: "edit",
      sub: "results",
      regattaId: "abc-123",
    });
  });

  it("ignores regattaId outside results", () => {
    expect(
      parseAdminNav(
        new URLSearchParams("tab=edit&sub=sailors&regattaId=abc-123")
      ).regattaId
    ).toBeNull();
  });
});

describe("serializeAdminNav", () => {
  it("writes tab + sub for edit/ops", () => {
    expect(
      serializeAdminNav({ tab: "edit", sub: "regattas" })
    ).toBe("tab=edit&sub=regattas");
    expect(
      serializeAdminNav({ tab: "ops", sub: "support" })
    ).toBe("tab=ops&sub=support");
  });

  it("includes regattaId only for results", () => {
    expect(
      serializeAdminNav({
        tab: "edit",
        sub: "results",
        regattaId: "r1",
      })
    ).toBe("tab=edit&sub=results&regattaId=r1");
    expect(
      serializeAdminNav({
        tab: "edit",
        sub: "sailors",
        regattaId: "r1",
      })
    ).toBe("tab=edit&sub=sailors");
  });

  it("omits sub for top-level tabs", () => {
    expect(serializeAdminNav({ tab: "stats", sub: "sailors" })).toBe(
      "tab=stats"
    );
  });
});
