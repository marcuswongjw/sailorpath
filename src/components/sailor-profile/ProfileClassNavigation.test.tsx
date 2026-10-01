/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { ProfileClassNavigation } from "./ProfileClassNavigation";

describe("ProfileClassNavigation", () => {
  it("keeps sections separate from class choice and exposes the standing anchor", () => {
    render(
      <ProfileClassNavigation
        dualClass
        preferIlcaFirst={false}
        activeTab="optimist"
        optimistCount={12}
        ilcaCount={4}
        journeyCount={3}
        awardsCount={6}
        showStanding
        showEquipment
        onTabChange={() => {}}
      />
    );

    expect(screen.queryByRole("tab", { name: /Optimist/ })).toBeNull();
    expect(screen.queryByRole("tab", { name: /ILCA 4/ })).toBeNull();
    expect(screen.getByRole("button", { name: /Regattas\s*12/ })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Awards\s*6/ })).toBeInTheDocument();
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
