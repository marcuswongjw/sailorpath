/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { HeroAthleteCard } from "./HeroAthleteCard";

describe("HeroAthleteCard", () => {
  const defaultProps = {
    displaySailor: {
      id: "s1",
      name: "Ethan Wong",
      handle: "ethan-wong",
      sailNumber: "123",
      club: "SAFYC",
      school: "ACS(I)",
      nationality: "SGP",
      bio: "Dedicated youth Optimist sailor aiming for National Squad selection.",
    },
    sailDisplay: "123",
    fleetBadge: {
      label: "Gold fleet",
      className: "bg-yellow-400 text-yellow-950",
    },
    activeStanding: {
      periodLabel: "2026 Season",
      fleet: "Gold",
      overallRank: 4,
      fleetSize: 68,
      best3of5: 12,
      rScores: [],
      trendNote: "Ranked #4 · Top 6%",
    },
    standingIsIlca: false,
    totalRegattasCount: 15,
    medals: { gold: 2, silver: 1, bronze: 3, show: true },
    profileClaimed: true,
  };

  it("shows Follow for a signed-in viewer and disables it for the linked owner", () => {
    const { rerender } = render(
      <HeroAthleteCard
        {...defaultProps}
        isLoggedIn
        followControl={{ sailorId: "s1", following: false, disabled: false }}
      />
    );
    expect(screen.getByRole("button", { name: "Follow" })).toBeEnabled();

    rerender(
      <HeroAthleteCard
        {...defaultProps}
        isLoggedIn
        isOwner
        followControl={{ sailorId: "s1", following: false, disabled: true }}
      />
    );
    expect(screen.getByRole("button", { name: "Follow" })).toBeDisabled();
  });

  it("renders athlete passport identity and hero metric modules", () => {
    render(<HeroAthleteCard {...defaultProps} />);

    expect(screen.getByRole("heading", { name: "Ethan Wong" })).toBeInTheDocument();
    expect(screen.getByText("Claimed")).toBeInTheDocument();
    expect(screen.queryByText("Dual-class athlete")).toBeNull();

    expect(screen.getByText("SGP 123", { exact: false })).toBeInTheDocument();
    expect(screen.queryByText(/Board /)).toBeNull();
    expect(screen.getByText("SAFYC")).toBeInTheDocument();
    expect(screen.getByText("Singapore")).toBeInTheDocument();

    expect(screen.getByLabelText("4 of 68")).toBeInTheDocument();
    expect(screen.getByText("Gold fleet series")).toBeInTheDocument();
    expect(screen.getByText("Active competitor")).toBeInTheDocument();
    expect(screen.getByText("Gold fleet")).toBeInTheDocument();
    expect(screen.getByText("6 awards")).toBeInTheDocument();
    expect(screen.getByText("View awards")).toBeInTheDocument();
    expect(screen.getByLabelText("Optimist, 15 regattas")).toBeInTheDocument();

    expect(screen.getByText(/Dedicated youth Optimist sailor/)).toBeInTheDocument();
  });

  it("shows a board number separately from the Optimist sail", () => {
    render(
      <HeroAthleteCard
        {...defaultProps}
        boardNumber="S24"
        sailIlca4="219111"
      />
    );
    expect(screen.getByText("Board S24")).toBeInTheDocument();
    expect(screen.getByText("SGP 123", { exact: false })).toBeInTheDocument();
    expect(screen.getByText(/ILCA/)).toBeInTheDocument();
  });

  it("handles share action with clipboard copy fallback", async () => {
    Object.assign(navigator, {
      clipboard: {
        writeText: vi.fn().mockResolvedValue(undefined),
      },
    });

    render(<HeroAthleteCard {...defaultProps} />);

    const shareBtn = screen.getByRole("button", { name: /Share profile/i });
    await userEvent.click(shareBtn);

    expect(screen.getByText("Copied link")).toBeInTheDocument();
  });

  it("renders owner edit and preview public buttons when isOwner is true", async () => {
    const onToggleEditing = vi.fn();
    const onTogglePreviewPublic = vi.fn();

    render(
      <HeroAthleteCard
        {...defaultProps}
        isOwner={true}
        ownerView={true}
        onToggleEditing={onToggleEditing}
        onTogglePreviewPublic={onTogglePreviewPublic}
      />
    );

    const editBtn = screen.getByRole("button", { name: /Edit profile/i });
    expect(editBtn).toBeInTheDocument();
    await userEvent.click(editBtn);
    expect(onToggleEditing).toHaveBeenCalledTimes(1);

    const previewBtn = screen.getByRole("button", { name: /Preview public/i });
    expect(previewBtn).toBeInTheDocument();
    await userEvent.click(previewBtn);
    expect(onTogglePreviewPublic).toHaveBeenCalledTimes(1);
  });

  it("supports one count-aware class selector", async () => {
    const onSelectBoatClass = vi.fn();

    render(
      <HeroAthleteCard
        {...defaultProps}
        dualClass={true}
        selectedBoatClass="optimist"
        optimistCount={14}
        ilcaCount={2}
        onSelectBoatClass={onSelectBoatClass}
      />
    );

    expect(screen.queryByText("Dual-class athlete")).not.toBeInTheDocument();
    expect(screen.getByRole("tab", { name: "Optimist, 14 regattas" })).toHaveAttribute(
      "aria-selected",
      "true"
    );
    const ilcaBtn = screen.getByRole("tab", { name: "ILCA 4, 2 regattas" });
    await userEvent.click(ilcaBtn);
    expect(onSelectBoatClass).toHaveBeenCalledWith("ilca4");
  });

  it("shows a single class as a label, not an empty second option", () => {
    render(
      <HeroAthleteCard
        {...defaultProps}
        dualClass={false}
        standingIsIlca
        selectedBoatClass="ilca4"
        ilcaCount={9}
        activeStanding={{
          ...defaultProps.activeStanding,
          overallRank: 12,
          fleetSize: 36,
          fleet: "Open",
          periodLabel: "ILCA 4 · ranking as of 2026-09-30",
          rankBasis: "recorded-results",
          unrestricted: true,
        }}
      />
    );

    expect(screen.getByLabelText("ILCA 4, 9 regattas")).toBeInTheDocument();
    expect(screen.queryByRole("tab", { name: /Optimist/ })).toBeNull();
    expect(screen.getByLabelText("12 of 36")).toBeInTheDocument();
    expect(screen.getByText("Recorded results")).toBeInTheDocument();
  });

  it("leads a Techno sailor with finishes and leaves Status off", () => {
    render(
      <HeroAthleteCard
        {...defaultProps}
        boardNumber="S24"
        boardSummary={{
          label: "Techno 293",
          seasonYear: 2025,
          seasonEventCount: 4,
          bestFinishLabel: "2nd",
          bestFinishEvent: "SNSC 2025",
        }}
        classChoices={[{ id: "techno293", label: "Techno 293", count: 4 }]}
        selectedClassId="techno293"
        medals={{ gold: 1, silver: 0, bronze: 0, show: true }}
      />
    );

    expect(screen.getByLabelText("Techno 293, 4 regattas")).toBeInTheDocument();
    expect(screen.getByText("Best finish")).toBeInTheDocument();
    expect(screen.getByText("2nd")).toBeInTheDocument();
    expect(screen.getByText("SNSC 2025")).toBeInTheDocument();
    expect(screen.getByText("Season events")).toBeInTheDocument();
    expect(screen.getByText("2025 Techno 293")).toBeInTheDocument();
    expect(screen.getByText("Career awards")).toBeInTheDocument();
    expect(screen.getByText("Board S24")).toBeInTheDocument();
    expect(screen.queryByText("Status")).toBeNull();
    expect(screen.queryByText("Active competitor")).toBeNull();
    expect(screen.queryByText("Optimist rank")).toBeNull();
    expect(screen.queryByRole("tab", { name: /Optimist/ })).toBeNull();
    expect(screen.queryByRole("tab", { name: /ILCA/ })).toBeNull();
    expect(screen.queryByText(/SGP 123/)).toBeNull();
  });

  it("switches board classes without offering WingFoil or a blank awards card", async () => {
    const onSelectClass = vi.fn();
    render(
      <HeroAthleteCard
        {...defaultProps}
        boardSummary={{
          label: "Windsurfing LT",
          seasonYear: 2024,
          seasonEventCount: 1,
          bestFinishLabel: "1st",
          bestFinishEvent: "NSC Cup 2024",
        }}
        classChoices={[
          { id: "windsurfing", label: "Windsurfing LT", count: 1 },
          { id: "techno293", label: "Techno 293", count: 3 },
        ]}
        selectedClassId="windsurfing"
        onSelectClass={onSelectClass}
        medals={{ gold: 0, silver: 0, bronze: 0, show: false }}
      />
    );

    expect(screen.queryByText("Career awards")).toBeNull();
    expect(screen.queryByText("Status")).toBeNull();
    expect(screen.queryByRole("tab", { name: /WingFoil/ })).toBeNull();
    await userEvent.click(
      screen.getByRole("tab", { name: "Techno 293, 3 regattas" })
    );
    expect(onSelectClass).toHaveBeenCalledWith("techno293");
  });

  it("explains a missing rank instead of showing a dash", () => {
    render(
      <HeroAthleteCard
        {...defaultProps}
        standingIsIlca
        selectedBoatClass="ilca4"
        activeStanding={null}
      />
    );

    expect(
      screen.getByText("No ranked ILCA 4 results for this series yet.")
    ).toBeInTheDocument();
  });
});
