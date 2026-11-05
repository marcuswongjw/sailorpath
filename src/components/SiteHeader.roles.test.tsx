/** @vitest-environment jsdom */
import { render, screen, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { beforeEach, describe, expect, it, vi } from "vitest";

const state = vi.hoisted(() => ({
  email: "sailor@example.com", role: "sailor", owned: [{ id: "1", name: "Sailor", handle: "sailor", ownerRelation: "sailor" }], ready: true, signOut: vi.fn(),
}));
vi.mock("next/navigation", () => ({ usePathname: () => "/" }));
vi.mock("@/components/AccountProvider", () => ({ useAccount: () => state }));
import { SiteHeader } from "./SiteHeader";

describe("account navigation by role", () => {
  beforeEach(() => {
    state.role = "sailor";
    state.owned = [{ id: "1", name: "Sailor", handle: "sailor", ownerRelation: "sailor" }];
  });

  it("shows a sailor their profile without parent or coach workspaces on desktop and mobile", async () => {
    const user = userEvent.setup();
    render(<SiteHeader />);
    await user.click(screen.getByRole("button", { name: "Account" }));
    expect(screen.getByRole("link", { name: "My profile" })).toHaveAttribute("href", "/sailors/sailor");
    expect(screen.queryByRole("link", { name: /workspace/i })).not.toBeInTheDocument();
    await user.click(screen.getByRole("button", { name: "Toggle menu" }));
    const mobile = screen.getByRole("navigation", { name: "Mobile public" }).parentElement!;
    expect(within(mobile).getByRole("link", { name: "My profile" })).toHaveAttribute("href", "/sailors/sailor");
    expect(within(mobile).queryByRole("link", { name: /workspace/i })).not.toBeInTheDocument();
  });

  it.each([
    ["parent", "parent", "Parent workspace", "Coach workspace"],
    ["coach", "sailor", "Coach workspace", "Parent workspace"],
    ["sailor", "parent", "Parent workspace", "Coach workspace"],
  ])("shows the relevant workspace for %s with %s relationship", async (role, relation, visible, hidden) => {
    state.role = role;
    state.owned[0].ownerRelation = relation;
    const user = userEvent.setup();
    render(<SiteHeader />);
    await user.click(screen.getByRole("button", { name: "Account" }));
    expect(screen.getByRole("link", { name: visible })).toBeInTheDocument();
    expect(screen.queryByRole("link", { name: hidden })).not.toBeInTheDocument();
  });
});
