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

  it("handles segmented tab navigation switching", async () => {
    const onSectionTabChange = vi.fn();
    render(
      <ProfileClassNavigation
        dualClass={false}
        preferIlcaFirst={false}
        activeTab="optimist"
        sectionTab="overview"
        optimistCount={15}
        ilcaCount={0}
        journeyCount={5}
        showStanding={true}
        showEquipment={true}
        onTabChange={() => {}}
        onSectionTabChange={onSectionTabChange}
      />
    );

    const regattasBtn = screen.getByRole("button", { name: /Regattas.*15/ });
    await userEvent.click(regattasBtn);
    expect(onSectionTabChange).toHaveBeenCalledWith("results");

    const milestonesBtn = screen.getByRole("button", { name: /Milestones.*5/ });
    await userEvent.click(milestonesBtn);
    expect(onSectionTabChange).toHaveBeenCalledWith("journey");

    const equipmentBtn = screen.getByRole("button", { name: /Equipment/ });
    await userEvent.click(equipmentBtn);
    expect(onSectionTabChange).toHaveBeenCalledWith("equipment");
  });
});
