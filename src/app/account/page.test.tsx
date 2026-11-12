/** @vitest-environment jsdom */
import { render, screen, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import AccountPage from "./page";

const state = vi.hoisted(() => ({ role: "sailor", isSuperadmin: false, signOut: vi.fn() }));
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
      owned: [{ id: "sailor", name: "Test Sailor", handle: "test-sailor", sailNumber: "SGP 1", club: "CSC", ownerRelation: "sailor" }],
      claims: [], user: { id: "user", fullName: "Test Parent", email: "parent@example.com", role: state.role },
    }) }));
  });

  it("puts sailing and managed profiles before expandable account settings and exposes Log out", async () => {
    const user = userEvent.setup();
    state.signOut.mockClear();
    render(<AccountPage />);
    const sailing = await screen.findByRole("region", { name: "Continue your sailing" });
    await user.click(screen.getByRole("button", { name: "Log out" }));
    expect(state.signOut).toHaveBeenCalledTimes(1);
    expect(within(sailing).queryByRole("link", { name: /Family dashboard/ })).not.toBeInTheDocument();
    const followingLink = within(sailing).getByRole("link", { name: /Following/ });
    expect(followingLink).toHaveClass("min-w-0", "w-full");
    expect(screen.getByRole("link", { name: "Open logbook" })).toHaveAttribute("href", "/athlete?id=sailor");
    expect(screen.queryByRole("link", { name: "Request coach access" })).not.toBeInTheDocument();
    const summary = screen.getByText("Account settings", { selector: "summary" });
    const details = summary.closest("details")!;
    expect(sailing.compareDocumentPosition(details) & Node.DOCUMENT_POSITION_FOLLOWING).toBeTruthy();
    expect(details).not.toHaveAttribute("open");
    await user.click(summary);
    expect(details).toHaveAttribute("open");
    expect(within(details).getByRole("button", { name: "Update password" })).toBeVisible();
    expect(within(details).getByRole("checkbox")).toBeChecked();
  });

  it("shows Connect Telegram in account settings when Telegram login is configured", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn().mockResolvedValue({
        ok: true,
        json: async () => ({
          owned: [],
          claims: [],
          email: "parent@example.com",
          user: {
            id: "user",
            fullName: "Test Parent",
            email: "parent@example.com",
            role: "sailor",
          },
          telegram: { enabled: true, linked: false, username: null, canDisconnect: false },
        }),
      })
    );
    const user = userEvent.setup();
    render(<AccountPage />);
    const summary = await screen.findByText("Account settings", { selector: "summary" });
    await user.click(summary);
    expect(screen.getByRole("link", { name: "Connect Telegram" })).toHaveAttribute(
      "href",
      "/auth/telegram?mode=link&next=%2Faccount%23settings"
    );
  });

  it("shows Connect Google in account settings when Google auth is enabled", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn().mockResolvedValue({
        ok: true,
        json: async () => ({
          owned: [],
          claims: [],
          email: "parent@example.com",
          user: {
            id: "user",
            fullName: "Test Parent",
            email: "parent@example.com",
            role: "sailor",
          },
          google: { enabled: true, linked: false },
        }),
      })
    );
    const user = userEvent.setup();
    render(<AccountPage />);
    await user.click(await screen.findByText("Account settings", { selector: "summary" }));
    expect(screen.getByRole("button", { name: "Connect Google" })).toBeVisible();
    expect(screen.queryByRole("link", { name: "Connect Telegram" })).not.toBeInTheDocument();
  });

  it("shows the family dashboard for parent accounts", async () => {
    state.role = "parent";
    render(<AccountPage />);
    expect(await screen.findByRole("link", { name: /Family dashboard/ })).toHaveAttribute("href", "/account/parent");
  });

  it("keeps coach workspaces and admin links restricted to their existing roles", async () => {
    state.role = "coach";
    render(<AccountPage />);
    await screen.findByRole("link", { name: /Squad dashboard/ });
    expect(screen.queryByRole("link", { name: /Family dashboard/ })).not.toBeInTheDocument();
    expect(screen.queryByRole("link", { name: /Admin console/ })).not.toBeInTheDocument();
    expect(screen.queryByRole("link", { name: "Request coach access" })).not.toBeInTheDocument();
  });

  it("shows unified onboarding and omits My logbook when no sailor profile is linked", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn().mockResolvedValue({
        ok: true,
        json: async () => ({
          owned: [],
          claims: [
            {
              id: "inv-1",
              status: "pending",
              source: "admin",
              relation: "parent",
              sailorName: "Invite Sailor",
              sailorHandle: "invite-sailor",
              createdAt: "2026-11-10T00:00:00Z",
            },
          ],
          email: "parent@example.com",
          user: { id: "user", fullName: "Test Parent", email: "parent@example.com", role: "sailor" },
        }),
      })
    );
    render(<AccountPage />);
    const sailing = await screen.findByRole("region", { name: "Continue your sailing" });
    expect(within(sailing).queryByRole("link", { name: /My logbook/ })).not.toBeInTheDocument();
    expect(screen.getByRole("link", { name: /Find & claim a sailor profile/ })).toHaveAttribute("href", "/sailors");
    // Pending admin invite is shown in SailorInviteAccept once, and Claim requests is removed.
    expect(screen.getAllByRole("button", { name: "Accept" })).toHaveLength(1);
    expect(screen.queryByRole("heading", { name: "Claim requests" })).not.toBeInTheDocument();
    expect(screen.queryByRole("link", { name: /\+ Link another/i })).not.toBeInTheDocument();
  });

  it("omits + Link another and Claim requests for claimed individual sailors", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn().mockResolvedValue({
        ok: true,
        json: async () => ({
          owned: [{ id: "sailor", name: "Test Sailor", handle: "test-sailor", sailNumber: "SGP 1", club: "CSC", ownerRelation: "sailor" }],
          claims: [
            {
              id: "c-1",
              status: "pending",
              source: "self",
              relation: "sailor",
              sailorName: "Another Sailor",
              sailorHandle: "another-sailor",
              createdAt: "2026-11-10T00:00:00Z",
            },
          ],
          user: { id: "user", fullName: "Test Sailor", email: "sailor@example.com", role: "sailor" },
        }),
      })
    );
    render(<AccountPage />);
    await screen.findByRole("region", { name: "Your sailor profile" });
    expect(screen.queryByRole("link", { name: /\+ Link another/i })).not.toBeInTheDocument();
    expect(screen.queryByRole("heading", { name: "Claim requests" })).not.toBeInTheDocument();
  });

  it("expands Account settings and shows accessible password error and visibility toggle", async () => {
    const user = userEvent.setup();
    render(<AccountPage />);
    const profileRegion = await screen.findByRole("region", { name: "Your sailor profile" });
    const sailing = screen.getByRole("region", { name: "Continue your sailing" });
    expect(within(sailing).queryByRole("link", { name: /My logbook/ })).not.toBeInTheDocument();
    expect(profileRegion.compareDocumentPosition(sailing) & Node.DOCUMENT_POSITION_FOLLOWING).toBeTruthy();

    const summary = screen.getByText("Account settings", { selector: "summary" });
    const details = summary.closest("details")!;
    expect(details).not.toHaveAttribute("open");

    await user.click(summary);
    expect(details).toHaveAttribute("open");

    const newPwInput = screen.getByLabelText("New password");
    const toggle = screen.getByRole("button", { name: "Show passwords" });
    expect(newPwInput).toHaveAttribute("type", "password");
    expect(toggle).toHaveAttribute("aria-pressed", "false");

    await user.click(toggle);
    expect(newPwInput).toHaveAttribute("type", "text");
    expect(screen.getByRole("button", { name: "Hide passwords" })).toHaveAttribute("aria-pressed", "true");

    await user.type(newPwInput, "123");
    await user.click(screen.getByRole("button", { name: "Update password" }));
    const alert = screen.getByRole("alert");
    expect(alert).toHaveTextContent("Password must be at least 6 characters.");
    expect(alert.className).toContain("text-rose-700");
    expect(newPwInput).toHaveAttribute("aria-invalid", "true");
  });
});
