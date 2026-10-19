// @vitest-environment jsdom
import React from "react";
import { render, screen, within } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { afterEach, describe, expect, it, vi } from "vitest";
import type { RegattaAdmin } from "@/types/regatta";
import { AdminBoardClassesPanel } from "./AdminBoardClassesPanel";
const sheets = [{ id: "foil-1", name: "Foil regatta", boatClass: "WingFoil", status: "published" }] as RegattaAdmin[];
function mount() {
  const client = new QueryClient({ defaultOptions: { queries: { retry: false, gcTime: 0 } } });
  return render(<QueryClientProvider client={client}><AdminBoardClassesPanel regattas={sheets} onOpenClass={vi.fn()} /></QueryClientProvider>);
}
function foilCard() {
  return within(screen.getByRole("heading", { name: "WingFoil" }).closest("article")!);
}
afterEach(() => vi.unstubAllGlobals());
describe("board class result counts", () => {
  it("uses aggregate counts on a fresh visit without downloading results", async () => {
    const fetch = vi.fn().mockResolvedValue(Response.json({ resultCounts: { "foil-1": 26 } }));
    vi.stubGlobal("fetch", fetch);
    mount();
    expect(await foilCard().findByText("26")).toBeInTheDocument();
    expect(fetch).toHaveBeenCalledWith("/api/admin/overview?section=events", expect.objectContaining({ signal: expect.any(AbortSignal) }));
    expect(fetch).toHaveBeenCalledTimes(1);
  });
  it("shows loading rather than an unverified zero while counts are pending", () => {
    vi.stubGlobal("fetch", vi.fn(() => new Promise(() => {})));
    mount();
    expect(foilCard().getByText("Loading…")).toBeInTheDocument();
  });
  it("shows an unavailable count and a retry action after a failed read", async () => {
    vi.stubGlobal("fetch", vi.fn().mockResolvedValue(Response.json({ error: "Unavailable" }, { status: 503 })));
    mount();
    expect(await foilCard().findByText("Unavailable")).toBeInTheDocument();
    expect(screen.getByRole("button", { name: "Retry counts" })).toBeInTheDocument();
  });
});
