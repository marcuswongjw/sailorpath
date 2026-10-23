/** @vitest-environment jsdom */
import { render, screen, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import AccountPage from "./page";

const state = vi.hoisted(() => ({ role: "sailor", isSuperadmin: false }));
const params = new URLSearchParams();
vi.mock("next/navigation", () => ({ useRouter: () => ({ replace: vi.fn() }), useSearchParams: () => params }));
vi.mock("@/components/AccountProvider", () => ({ useAccount: () => state }));
vi.mock("@/lib/supabase/browser", () => ({ createBrowserSupabase: () => ({ auth: {
  getSession: async () => ({ data: { session: { user: { id: "user", email: "parent@example.com", user_metadata: {} } } } }),
} }) }));

describe("account workspace navigation", () => {
  afterEach(() => vi.unstubAllGlobals());
  beforeEach(() => {
    state.role = "sailor";
    state.isSuperadmin = false;
    vi.stubGlobal("fetch", vi.fn().mockResolvedValue({ ok: true, json: async () => ({
      owned: [{ id: "sailor", name: "Test Sailor", handle: "test-sailor", sailNumber: "SGP 1", club: "CSC" }],
      claims: [], user: { id: "user", fullName: "Test Parent", email: "parent@example.com", role: state.role },
    }) }));
  });

  it("puts sailing and managed profiles before expandable account settings", async () => {
    const user = userEvent.setup();
    render(<AccountPage />);
    const sailing = await screen.findByRole("region", { name: "Continue your sailing" });
    expect(within(sailing).getByRole("link", { name: /Family dashboard/ })).toHaveAttribute("href", "/account/parent");
    expect(screen.getByRole("link", { name: "Open logbook" })).toHaveAttribute("href", "/athlete?id=sailor");
    const summary = screen.getByText("Account settings", { selector: "summary" });
    const details = summary.closest("details")!;
    expect(sailing.compareDocumentPosition(details) & Node.DOCUMENT_POSITION_FOLLOWING).toBeTruthy();
    expect(details).not.toHaveAttribute("open");
    await user.click(summary);
    expect(details).toHaveAttribute("open");
    expect(within(details).getByRole("button", { name: "Update password" })).toBeVisible();
    expect(within(details).getByRole("checkbox")).toBeChecked();
  });

  it("keeps coach workspaces and admin links restricted to their existing roles", async () => {
    state.role = "coach";
    render(<AccountPage />);
    await screen.findByRole("link", { name: /Squad dashboard/ });
    expect(screen.queryByRole("link", { name: /Family dashboard/ })).not.toBeInTheDocument();
    expect(screen.queryByRole("link", { name: /Admin console/ })).not.toBeInTheDocument();
    expect(screen.queryByRole("link", { name: "Request coach access" })).not.toBeInTheDocument();
  });
});
