/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";
import { SailorInviteAccept, type SailorInviteClaim } from "./SailorInviteAccept";

const pending: SailorInviteClaim = {
  id: "claim-1",
  status: "pending",
  sailorName: "Chiang Zhiyi Aaron",
  sailorHandle: "chiang-zhiyi-aaron",
  source: "admin",
  relation: "parent",
};

describe("SailorInviteAccept", () => {
  it("shows Accept for a pending admin assignment", async () => {
    const user = userEvent.setup();
    const onRespond = vi.fn();
    render(
      <SailorInviteAccept
        claims={[pending]}
        inviteId={null}
        claimMsg={null}
        claimBusy={null}
        onRespond={onRespond}
      />
    );

    expect(screen.getByRole("heading", { name: "Accept a sailor link" })).toBeInTheDocument();
    expect(screen.getByText("Parent / guardian")).toBeInTheDocument();
    await user.click(screen.getByRole("button", { name: "Accept" }));
    expect(onRespond).toHaveBeenCalledWith(pending, "accept");
  });

  it("asks for the invited email when the link is for another account", () => {
    render(
      <SailorInviteAccept
        claims={[]}
        inviteId="claim-other"
        claimMsg={null}
        claimBusy={null}
        onRespond={vi.fn()}
      />
    );

    expect(
      screen.getByText(/sign in with the email address that received the invitation/i)
    ).toBeInTheDocument();
    expect(screen.queryByRole("button", { name: "Accept" })).not.toBeInTheDocument();
  });
});
