// @vitest-environment jsdom
import React from "react";
import { fireEvent, render, screen } from "@testing-library/react";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { FeedbackProvider } from "@/components/ui/FeedbackProvider";
const state = vi.hoisted(() => ({ search: new URLSearchParams(), replace: vi.fn() }));
vi.mock("next/navigation", () => ({
  useSearchParams: () => state.search,
  usePathname: () => "/admin",
  useRouter: () => ({ replace: state.replace, push: vi.fn() }),
}));
vi.mock("./useAdminAuth", () => ({ useAdminAuth: () => ({
  user: { id: "admin" }, loading: false, isSuperadmin: true,
}) }));
vi.mock("./useAdminData", () => {
  const data = {
    sailorList: [], regattaList: [], resultsList: [], calendarEvents: [],
    dataReady: true, dataLoading: false, dataLoadError: null,
    loadedData: { sailors: true, regattas: true, results: true },
    selectedRegattaIdForResultEdit: "", setSelectedRegattaIdForResultEdit: vi.fn(),
  };
  return { useAdminData: () => data };
});
vi.mock("./useAdminNotifications", () => ({ useAdminNotifications: () => ({
  inboxQueueCounts: { claims: 0, coaches: 0, support: 0, suggestions: 0 },
  inboxNotifCount: 0, inboxLandingView: "claims",
}) }));
vi.mock("./AdminBoardClassesPanel", () => ({
  AdminBoardClassesPanel: ({ onOpenClass }: { onOpenClass: (key: "wingfoil") => void }) => <>
    <h2>Board classes loaded</h2>
    <button onClick={() => onOpenClass("wingfoil")}>Open foil classes</button>
  </>,
}));
vi.mock("./AdminRegattasPanel", () => ({
  AdminRegattasPanel: () => <h2>Event index loaded</h2>,
}));
import { AdminDashboard } from "./AdminDashboard";
const dashboard = () => <FeedbackProvider><AdminDashboard /></FeedbackProvider>;
beforeEach(() => vi.clearAllMocks());
describe("board class navigation", () => {
  it("preserves a fresh board-class bookmark", async () => {
    state.search = new URLSearchParams("area=events&view=board");
    render(dashboard());
    expect(await screen.findByRole("heading", { name: "Board classes loaded" })).toBeInTheDocument();
    expect(state.replace).not.toHaveBeenCalled();
  });
  it("does not replace board navigation with the previous event-card view", async () => {
    state.search = new URLSearchParams("area=events&view=card");
    const { rerender } = render(dashboard());
    await screen.findByRole("heading", { name: "Event index loaded" });
    state.replace.mockClear();
    state.search = new URLSearchParams("area=events&view=board");
    rerender(dashboard());
    expect(await screen.findByRole("heading", { name: "Board classes loaded" })).toBeInTheDocument();
    expect(state.replace).not.toHaveBeenCalled();
  });
  it("does not write a previous board view over navigation back to the event index", async () => {
    state.search = new URLSearchParams("area=events&view=board");
    const { rerender } = render(dashboard());
    await screen.findByRole("heading", { name: "Board classes loaded" });
    state.replace.mockClear();
    state.search = new URLSearchParams("area=events&view=card");
    rerender(dashboard());
    expect(await screen.findByRole("heading", { name: "Event index loaded" })).toBeInTheDocument();
    expect(state.replace).not.toHaveBeenCalled();
  });
  it("serializes state-driven class navigation from the board page", async () => {
    state.search = new URLSearchParams("area=events&view=board");
    render(dashboard());
    fireEvent.click(await screen.findByRole("button", { name: "Open foil classes" }));
    await screen.findByRole("heading", { name: "Event index loaded" });
    expect(state.replace).toHaveBeenCalledWith("/admin?area=events&view=card", { scroll: false });
  });

});
