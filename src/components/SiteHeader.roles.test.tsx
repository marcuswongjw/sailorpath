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
    state.email = "sailor@example.com";
    state.role = "sailor";
    state.owned = [{ id: "1", name: "Sailor", handle: "sailor", ownerRelation: "sailor" }];
    state.signOut.mockClear();
  });

  it("offers logged-out visitors one login or sign-up entry on desktop and mobile", async () => {
    state.email = "";
    const user = userEvent.setup();
    render(<SiteHeader />);
    const desktop = screen.getAllByRole("link", { name: "Log in or sign up" });
    expect(desktop).toHaveLength(1);
    expect(desktop[0]).toHaveAttribute("href", "/login");
    expect(screen.queryByRole("link", { name: "Create account" })).not.toBeInTheDocument();
    await user.click(screen.getByRole("button", { name: "Toggle menu" }));
    const mobile = screen.getByRole("navigation", { name: "Mobile public" }).parentElement!;
    expect(within(mobile).getByRole("link", { name: "Log in or sign up" })).toHaveAttribute("href", "/login");
    expect(within(mobile).queryByRole("link", { name: "Create account" })).not.toBeInTheDocument();
    state.email = "sailor@example.com";
  });

  it("shows a sailor their profile without parent or coach workspaces on desktop and mobile", async () => {
    const user = userEvent.setup();
    render(<SiteHeader />);
    const headerLogOutButtons = screen.getAllByRole("button", { name: "Log out" });
    expect(headerLogOutButtons.length).toBeGreaterThanOrEqual(2);
    await user.click(headerLogOutButtons[1]);
    expect(state.signOut).toHaveBeenCalledTimes(1);
    await user.click(screen.getByRole("button", { name: "Account" }));
    expect(screen.getByRole("link", { name: "My profile" })).toHaveAttribute("href", "/sailors/sailor");
    expect(screen.queryByRole("link", { name: /workspace/i })).not.toBeInTheDocument();
    await user.click(screen.getByRole("button", { name: "Toggle menu" }));
    const mobile = screen.getByRole("navigation", { name: "Mobile public" }).parentElement!;
    expect(within(mobile).getByRole("link", { name: "My profile" })).toHaveAttribute("href", "/sailors/sailor");
    expect(within(mobile).queryByRole("link", { name: /workspace/i })).not.toBeInTheDocument();
    await user.click(within(mobile).getByRole("button", { name: "Log out" }));
    expect(state.signOut).toHaveBeenCalledTimes(2);
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
