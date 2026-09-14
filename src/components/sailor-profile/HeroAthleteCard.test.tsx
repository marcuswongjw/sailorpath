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

  it("renders athlete passport identity and hero metric modules", () => {
    render(<HeroAthleteCard {...defaultProps} />);

    // Name and fleet badge
    expect(screen.getByRole("heading", { name: "Ethan Wong" })).toBeInTheDocument();
    expect(screen.getAllByText("Gold fleet").length).toBeGreaterThanOrEqual(1);
    expect(screen.getByText("Claimed")).toBeInTheDocument();

    // Passport meta
    expect(screen.getByText("SGP 123", { exact: false })).toBeInTheDocument();
    expect(screen.getByText("SAFYC")).toBeInTheDocument();
    expect(screen.getByText("Singapore")).toBeInTheDocument();

    // Metrics strip
    expect(screen.getByText("#4")).toBeInTheDocument();
    expect(screen.getByText("of 68")).toBeInTheDocument();
    expect(screen.getByText("Best 3 of 5: 12 pts")).toBeInTheDocument();
    expect(screen.getByText("Ranked #4 · Top 6%")).toBeInTheDocument();
    expect(screen.getByText("🥇 2")).toBeInTheDocument();
    expect(screen.getByText("🥈 1")).toBeInTheDocument();
    expect(screen.getByText("🥉 3")).toBeInTheDocument();

    // Bio
    expect(screen.getByText(/Dedicated youth Optimist sailor/)).toBeInTheDocument();
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

  it("supports dual-class boat switcher", async () => {
    const onSelectBoatClass = vi.fn();

    render(
      <HeroAthleteCard
        {...defaultProps}
        dualClass={true}
        selectedBoatClass="optimist"
        onSelectBoatClass={onSelectBoatClass}
      />
    );

    expect(screen.getByText("Dual-class athlete")).toBeInTheDocument();
    const ilcaBtn = screen.getByRole("button", { name: /ILCA 4/i });
    await userEvent.click(ilcaBtn);
    expect(onSelectBoatClass).toHaveBeenCalledWith("ilca4");
  });
});
