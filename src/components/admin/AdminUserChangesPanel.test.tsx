/** @vitest-environment jsdom */
import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { afterEach, describe, expect, it, vi } from "vitest";
import { AdminUserChangesPanel } from "./AdminUserChangesPanel";

function show(isSuperadmin = true) {
  const client = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  return render(<QueryClientProvider client={client}><AdminUserChangesPanel isSuperadmin={isSuperadmin} /></QueryClientProvider>);
}

afterEach(() => vi.unstubAllGlobals());

describe("User changes panel", () => {
  it("shows the actor and expandable details, and applies email and date filters", async () => {
    const fetchMock = vi.fn().mockResolvedValue({ ok: true, json: async () => ({
      changes: [{ id: "change-1", actorEmail: "parent@example.com", createdAt: "2026-10-10T00:00:00Z", summary: "results: updated", action: "user.results.updated", details: { submittedFields: ["rank"] } }],
      hasMore: false,
    }) });
    vi.stubGlobal("fetch", fetchMock);
    show();
    expect(await screen.findByText("results: updated")).toBeInTheDocument();
    expect(screen.getByText(/parent@example.com/)).toBeInTheDocument();
    const user = userEvent.setup();
    await user.click(screen.getByText("Change details"));
    expect(screen.getByText(/submittedFields/)).toBeVisible();
    await user.type(screen.getByLabelText("User email"), "parent@example.com");
    await user.click(screen.getByRole("button", { name: "Filter" }));
    await waitFor(() => expect(fetchMock).toHaveBeenLastCalledWith("/api/admin/user-changes?days=30&email=parent%40example.com&offset=0"));
    await user.selectOptions(screen.getByLabelText("Period"), "7");
    await waitFor(() => expect(fetchMock).toHaveBeenLastCalledWith("/api/admin/user-changes?days=7&email=parent%40example.com&offset=0"));
  });

  it("supports pagination beyond the first hundred entries", async () => {
    const fetchMock = vi.fn().mockResolvedValue({ ok: true, json: async () => ({ changes: [], hasMore: true }) });
    vi.stubGlobal("fetch", fetchMock);
    show();
    await waitFor(() => expect(screen.getByRole("button", { name: "Next" })).toBeEnabled());
    await userEvent.setup().click(screen.getByRole("button", { name: "Next" }));
    await waitFor(() => expect(fetchMock).toHaveBeenLastCalledWith("/api/admin/user-changes?days=30&email=&offset=100"));
    expect(screen.getByText("Page 2")).toBeInTheDocument();
  });

  it("does not fetch for a non-superadmin", () => {
    const fetchMock = vi.fn();
    vi.stubGlobal("fetch", fetchMock);
    show(false);
    expect(screen.getByText(/require superadmin/)).toBeInTheDocument();
    expect(fetchMock).not.toHaveBeenCalled();
  });
});
