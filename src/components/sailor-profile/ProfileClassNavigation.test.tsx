/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { ProfileClassNavigation } from "./ProfileClassNavigation";

describe("ProfileClassNavigation", () => {
  it("shows class counts and reports tab changes", async () => {
    const onTabChange = vi.fn();
    render(
      <ProfileClassNavigation
        dualClass
        preferIlcaFirst={false}
        activeTab="optimist"
        optimistCount={12}
        ilcaCount={4}
        journeyCount={3}
        showStanding
        showEquipment
        onTabChange={onTabChange}
      />
    );

    expect(screen.getByRole("tab", { name: /Optimist.*12/ })).toHaveAttribute(
      "aria-selected",
      "true"
    );
    await userEvent.click(screen.getByRole("tab", { name: /ILCA 4.*4/ }));
    expect(onTabChange).toHaveBeenCalledWith("ilca4");
    expect(screen.getByRole("link", { name: "Standing" })).toHaveAttribute(
      "href",
      "#profile-standing"
    );
  });

  it("uses journey labels and hides unavailable links", () => {
    render(
      <ProfileClassNavigation
        dualClass={false}
        preferIlcaFirst={false}
        activeTab="journey"
        optimistCount={0}
        ilcaCount={0}
        journeyCount={1}
        showStanding={false}
        showEquipment={false}
        onTabChange={() => {}}
      />
    );

    expect(screen.getByRole("link", { name: "Journey" })).toBeInTheDocument();
    expect(screen.queryByRole("link", { name: "Standing" })).toBeNull();
    expect(screen.queryByRole("link", { name: "Equipment" })).toBeNull();
  });
});
