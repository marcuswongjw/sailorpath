/** @vitest-environment jsdom */
import { fireEvent, render, screen } from "@testing-library/react";
import { afterEach, describe, expect, it, vi } from "vitest";
import { QuickSearchModal } from "./QuickSearchModal";

const push = vi.hoisted(() => vi.fn());
vi.mock("next/navigation", () => ({ useRouter: () => ({ push }) }));

afterEach(() => {
  vi.unstubAllGlobals();
  push.mockReset();
});

describe("quick search sailor labels", () => {
  it("shows the recorded Indian nationality for both Krishna matches and links to the right profile", async () => {
    vi.stubGlobal("fetch", vi.fn().mockResolvedValue({
      ok: true,
      json: async () => ({ sailors: [
        { id: "krishna", name: "Krishna Venkitachalam Ramakrishnan", handle: "krishna-venkitachalam-ramakrishnan-94z5qb6", sailNumber: "1639", nationality: "IND", club: "YAI" },
        { id: "shreya", name: "Shreya Krishna Lakshminarayanan", handle: "shreya-krishna", sailNumber: "1632", nationality: "IND", club: "YAI" },
      ], regattas: [] }),
    }));
    render(<QuickSearchModal isOpen onClose={vi.fn()} />);
    fireEvent.change(screen.getByRole("searchbox"), { target: { value: "krish" } });
    expect(await screen.findByText("IND 1639")).toBeInTheDocument();
    expect(screen.getByText("IND 1632")).toBeInTheDocument();
    expect(screen.queryByText("SGP 1639")).not.toBeInTheDocument();
    expect(screen.getByRole("link", { name: /Krishna Venkitachalam Ramakrishnan/ })).toHaveAttribute("href", "/sailors/krishna-venkitachalam-ramakrishnan-94z5qb6");
    fireEvent.keyDown(screen.getByRole("searchbox"), { key: "Enter" });
    expect(push).toHaveBeenCalledWith("/sailors/krishna-venkitachalam-ramakrishnan-94z5qb6");
  });

  it("keeps international prefixes and hides placeholder sail numbers", async () => {
    vi.stubGlobal("fetch", vi.fn().mockResolvedValue({
      ok: true,
      json: async () => ({ sailors: [
        { id: "nz", name: "New Zealand sailor", handle: "nz", sailNumber: "NZL 4818", nationality: "NZL", club: "Club" },
        { id: "empty", name: "Board sailor", handle: "board", sailNumber: "NONE4", nationality: "SGP", boardNumber: "29", club: "Club" },
      ], regattas: [] }),
    }));
    render(<QuickSearchModal isOpen onClose={vi.fn()} />);
    fireEvent.change(screen.getByRole("searchbox"), { target: { value: "sailor" } });
    expect(await screen.findByText("NZL 4818")).toBeInTheDocument();
    expect(screen.getByText("Board 29")).toBeInTheDocument();
    expect(screen.queryByText(/SGP NZL|NONE4/)).not.toBeInTheDocument();
  });
});
