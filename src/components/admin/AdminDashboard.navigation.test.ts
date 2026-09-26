import { describe, expect, it, vi } from "vitest";
import { resolveAdminUrlChange } from "./adminNavigationSync";

describe("AdminDashboard URL synchronization", () => {
  it("applies Back and Forward destinations instead of overwriting them", () => {
    const canLeave = vi.fn(() => true);
    expect(
      resolveAdminUrlChange({
        currentSearch: "area=events&event=snsc&sheet=ilca4&view=results",
        acceptedSearch: "area=sailors&view=directory",
        approvedSearch: null,
        canLeave,
      })
    ).toEqual({
      action: "apply",
      search: "area=events&event=snsc&sheet=ilca4&view=results",
    });
    expect(canLeave).toHaveBeenCalledOnce();
  });

  it("restores the open address when a dirty form blocks history navigation", () => {
    expect(
      resolveAdminUrlChange({
        currentSearch: "area=sailors&view=directory",
        acceptedSearch: "area=events&event=snsc&sheet=ilca4&view=results",
        approvedSearch: null,
        canLeave: () => false,
      })
    ).toEqual({
      action: "restore",
      search: "area=events&event=snsc&sheet=ilca4&view=results",
    });
  });

  it("accepts a sidebar destination that already passed the leave guard", () => {
    const canLeave = vi.fn(() => false);
    expect(
      resolveAdminUrlChange({
        currentSearch: "area=inbox&view=claims&shell=sidebar",
        acceptedSearch: "area=events&view=card&shell=sidebar",
        approvedSearch: "area=inbox&view=claims&shell=sidebar",
        canLeave,
      })
    ).toEqual({
      action: "apply",
      search: "area=inbox&view=claims&shell=sidebar",
    });
    expect(canLeave).not.toHaveBeenCalled();
  });
});
