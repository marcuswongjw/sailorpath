/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";

vi.mock("next/navigation", () => ({
  useRouter: () => ({ push: vi.fn(), replace: vi.fn(), refresh: vi.fn() }),
}));

import { HeroAthleteCard } from "./HeroAthleteCard";

describe("HeroAthleteCard", () => {
  it("respects school visibility in public preview while keeping the owner view complete", () => {
    const props = { activeStanding: null, standingIsIlca: false, displaySailor: { id: "qa", handle: "qa-sailor", name: "QA Sailor", school: "Private school", showSchoolOnPublicProfile: false } };
    const { rerender } = render(<HeroAthleteCard {...props} previewPublic />);
    expect(screen.queryByText("Private school")).toBeNull();
    rerender(<HeroAthleteCard {...props} previewPublic={false} />);
    expect(screen.getByText("Private school")).toBeInTheDocument();
    rerender(<HeroAthleteCard {...props} displaySailor={{ ...props.displaySailor, showSchoolOnPublicProfile: true }} previewPublic />);
    expect(screen.getByText("Private school")).toBeInTheDocument();
  });

  it("always displays profile pictures publicly and exposes remove photo in owner view", async () => {
    const onRemoveAvatar = vi.fn();
    const props = {
      activeStanding: null,
      standingIsIlca: false,
      displaySailor: {
        id: "11111111-1111-4111-8111-111111111111",
        handle: "qa-sailor",
        name: "QA Sailor",
        avatarUrl: "https://sailorpath.com/athlete-portraits/team-singapore/example.jpg",
        showProfilePhotoOnPublicProfile: false,
      },
    };
    const { rerender } = render(<HeroAthleteCard {...props} previewPublic />);
    expect(screen.getByRole("img", { name: "QA Sailor" })).toBeInTheDocument();

    rerender(<HeroAthleteCard {...props} ownerView onRemoveAvatar={onRemoveAvatar} />);
    const removeBtn = screen.getByRole("button", { name: "Remove photo" });
    await userEvent.click(removeBtn);
    expect(onRemoveAvatar).toHaveBeenCalledTimes(1);
  });
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
    expect(screen.getByRole("button", { name: "Follow" }).closest("form")).toHaveAttribute(
      "action",
      "/api/following"
    );

    rerender(
      <HeroAthleteCard
        {...defaultProps}
        isLoggedIn
        isOwner
        followControl={{ sailorId: "s1", following: false, disabled: true }}
      />
    );
    expect(screen.getByRole("button", { name: "Follow" })).toBeDisabled();
    expect(
      screen.queryByText(/Your account has links to the sailing workspace/)
    ).toBeNull();
  });

  it("hides a generated results bio and still shows the follow form before sign-in", () => {
    render(
      <HeroAthleteCard
        {...defaultProps}
        displaySailor={{ ...defaultProps.displaySailor, bio: "" }}
        followControl={{ sailorId: "s1", following: false, disabled: false, nextPath: "/sailors/ethan-wong" }}
      />
    );

    expect(screen.queryByText(/first raced/)).toBeNull();
    const follow = screen.getByRole("button", { name: "Follow" });
    expect(follow.closest("form")).toHaveAttribute("action", "/api/following");
    expect(follow.closest("form")?.querySelector('input[name="sailorId"]')).toHaveValue("s1");
  });

  it("hides Born when the birth year is unknown", () => {
    const { rerender } = render(
      <HeroAthleteCard {...defaultProps} bornYear={null} />
    );
    expect(screen.queryByText(/Born/)).toBeNull();

    rerender(<HeroAthleteCard {...defaultProps} bornYear="—" />);
    expect(screen.queryByText(/Born/)).toBeNull();

    rerender(<HeroAthleteCard {...defaultProps} bornYear="2012" />);
    expect(screen.getByText("2012")).toBeInTheDocument();
    expect(screen.getByText(/Born/)).toBeInTheDocument();
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
    expect(screen.getByText("Singapore Optimist Gold Fleet")).toBeInTheDocument();
    expect(screen.queryByText("Optimist series rank for this ranking cycle.")).not.toBeInTheDocument();
    expect(screen.queryByRole("button", { name: "What this rank means" })).toBeNull();
    expect(screen.queryByText("Status")).not.toBeInTheDocument();
    expect(screen.queryByText("Active competitor")).not.toBeInTheDocument();
    expect(screen.getByText("Regattas")).toBeInTheDocument();
    expect(
      within(
        screen.getByRole("group", { name: "15 Optimist regattas" })
      ).getByText("15")
    ).toBeInTheDocument();
    expect(screen.getByText("Optimist regattas logged")).toBeInTheDocument();
    expect(screen.getByText("6 awards")).toBeInTheDocument();
    expect(screen.getByText("View awards")).toBeInTheDocument();
    expect(
      screen.getByRole("group", { name: "15 Optimist regattas" }).parentElement
    ).toHaveClass("grid-cols-2");
    expect(screen.getByLabelText("Optimist")).toBeInTheDocument();

    expect(screen.getByRole("region", { name: "Bio" })).toBeInTheDocument();
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
    expect(screen.getByRole("tab", { name: "Optimist" })).toHaveAttribute(
      "aria-selected",
      "true"
    );
    const ilcaBtn = screen.getByRole("tab", { name: "ILCA 4" });
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
          rankBasis: "official-list",
          unrestricted: false,
        }}
      />
    );

    expect(screen.getByLabelText("ILCA 4")).toBeInTheDocument();
    expect(screen.queryByRole("tab", { name: /Optimist/ })).toBeNull();
    expect(screen.getByLabelText("12 of 36")).toBeInTheDocument();
    expect(screen.getByText("Official national list")).toBeInTheDocument();
    expect(screen.queryByText("Status")).not.toBeInTheDocument();
    expect(screen.queryByText("Active competitor")).not.toBeInTheDocument();
    expect(
      within(
        screen.getByRole("group", { name: "9 ILCA 4 regattas" })
      ).getByText("9")
    ).toBeInTheDocument();
    expect(screen.getByText("ILCA 4 logged")).toBeInTheDocument();
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

    expect(screen.getByLabelText("Techno 293")).toBeInTheDocument();
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
      screen.getByRole("tab", { name: "Techno 293" })
    );
    expect(onSelectClass).toHaveBeenCalledWith("techno293");
  });

  it("hides the rank section for non-Singapore sailors, non-national classes, and unranked sailors", () => {
    const { rerender } = render(
      <HeroAthleteCard
        {...defaultProps}
        displaySailor={{ ...defaultProps.displaySailor, nationality: "THA" }}
        standingIsIlca
        selectedBoatClass="ilca4"
        activeStanding={null}
      />
    );
    expect(screen.queryByText(/No ranked/i)).toBeNull();
    expect(screen.queryByText(/ILCA 4 rank/i)).toBeNull();

    rerender(
      <HeroAthleteCard
        {...defaultProps}
        standingIsIlca
        selectedBoatClass="ilca7"
        activeStanding={{
          ...defaultProps.activeStanding,
          boatClass: "ILCA 7",
          overallRank: 3,
          fleetSize: 12,
          rankBasis: "official-list",
        }}
      />
    );
    expect(screen.queryByText(/ILCA 7 rank/i)).toBeNull();

    rerender(
      <HeroAthleteCard
        {...defaultProps}
        standingIsIlca
        selectedBoatClass="ilca4"
        activeStanding={{
          ...defaultProps.activeStanding,
          boatClass: "ILCA 4",
          overallRank: 12,
          fleetSize: 36,
          rankBasis: "recorded-results",
          unrestricted: true,
        }}
      />
    );
    expect(screen.queryByText(/ILCA 4 rank/i)).toBeNull();
  });

  it("always renders profile photos publicly without a visibility toggle and offers Remove photo for owners", async () => {
    const onRemoveAvatar = vi.fn();
    const { rerender } = render(
      <HeroAthleteCard
        {...defaultProps}
        ownerView
        isOwner
        displaySailor={{
          ...defaultProps.displaySailor,
          avatarUrl: "https://example.com/avatar.jpg",
          showProfilePhotoOnPublicProfile: false,
        }}
        onRemoveAvatar={onRemoveAvatar}
      />
    );

    expect(screen.getByRole("img", { name: "Ethan Wong" })).toBeInTheDocument();
    expect(
      screen.queryByRole("button", { name: /Photo (visible|hidden)/i })
    ).toBeNull();

    const removeBtn = screen.getByRole("button", { name: "Remove photo" });
    expect(removeBtn).toBeInTheDocument();
    await userEvent.click(removeBtn);
    expect(onRemoveAvatar).toHaveBeenCalledTimes(1);

    rerender(
      <HeroAthleteCard
        {...defaultProps}
        ownerView={false}
        isOwner
        previewPublic
        displaySailor={{
          ...defaultProps.displaySailor,
          avatarUrl: "https://example.com/avatar.jpg",
          showProfilePhotoOnPublicProfile: false,
        }}
        onRemoveAvatar={onRemoveAvatar}
      />
    );
    expect(screen.getByRole("img", { name: "Ethan Wong" })).toBeInTheDocument();
    expect(screen.queryByRole("button", { name: "Remove photo" })).toBeNull();

    rerender(
      <HeroAthleteCard
        {...defaultProps}
        ownerView
        isOwner
        displaySailor={{
          ...defaultProps.displaySailor,
          avatarUrl: null,
        }}
        onRemoveAvatar={onRemoveAvatar}
      />
    );
    expect(screen.queryByRole("img", { name: "Ethan Wong" })).toBeNull();
    expect(screen.queryByRole("button", { name: "Remove photo" })).toBeNull();
  });

  it("always renders the Bio section and lets owners edit bio inline", async () => {
    const onSaveBio = vi.fn().mockResolvedValue(true);
    const { rerender } = render(
      <HeroAthleteCard
        {...defaultProps}
        displaySailor={{ ...defaultProps.displaySailor, bio: null }}
      />
    );

    const bioRegion = screen.getByRole("region", { name: "Bio" });
    expect(within(bioRegion).getByText("No bio added yet.")).toBeInTheDocument();

    rerender(
      <HeroAthleteCard
        {...defaultProps}
        ownerView
        isOwner
        displaySailor={{ ...defaultProps.displaySailor, bio: null }}
        onSaveBio={onSaveBio}
      />
    );

    await userEvent.click(screen.getByRole("button", { name: "Add bio" }));
    const input = screen.getByLabelText("Edit bio");
    await userEvent.type(input, "Laser & Optimist youth sailor.");
    await userEvent.click(screen.getByRole("button", { name: "Save bio" }));
    expect(onSaveBio).toHaveBeenCalledWith("Laser & Optimist youth sailor.");
  });

  it("renders a single owner photo upload button and clean claim/request access labels", async () => {
    const onUploadAvatar = vi.fn();
    const onRequestAccess = vi.fn();
    const onToggleClaimPanel = vi.fn();
    const { rerender } = render(
      <HeroAthleteCard
        {...defaultProps}
        ownerView
        isOwner
        onUploadAvatar={onUploadAvatar}
      />
    );

    const uploadButtons = screen.getAllByRole("button", { name: /Upload athlete photo/i });
    expect(uploadButtons).toHaveLength(1);
    expect(screen.queryByRole("button", { name: "Upload athlete photo button" })).toBeNull();

    rerender(
      <HeroAthleteCard
        {...defaultProps}
        profileClaimed={false}
        showUnclaimedBanner
        onRequestAccess={onRequestAccess}
      />
    );
    expect(screen.getByText(/Your profile or your child’s\?/)).toBeInTheDocument();
    await userEvent.click(screen.getByRole("button", { name: "Request profile access" }));
    expect(onRequestAccess).toHaveBeenCalledTimes(1);

    rerender(
      <HeroAthleteCard
        {...defaultProps}
        profileClaimed
        showUnclaimedBanner={false}
        canClaim
        onToggleClaimPanel={onToggleClaimPanel}
      />
    );
    expect(screen.queryByRole("button", { name: "Claim this profile" })).toBeNull();
    await userEvent.click(screen.getByRole("button", { name: "Request access" }));
    expect(onToggleClaimPanel).toHaveBeenCalledTimes(1);
  });
});
