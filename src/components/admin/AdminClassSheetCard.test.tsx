/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { AdminClassSheetCard } from "./AdminClassSheetCard";
import type { GroupableRegatta } from "@/lib/admin/groupRegattaEvents";

const sheet: GroupableRegatta = {
  id: "sheet-1",
  name: "NSC 2026 ILCA 4",
  slug: "nsc-ilca-4-2026",
  date: "2026-09-05",
  boatClass: "ILCA 4",
  status: "published",
  raceCount: null,
  totalFleetSize: 31,
};

describe("AdminClassSheetCard", () => {
  it("keeps an unassigned sheet's facts together and links from its own row", async () => {
    const user = userEvent.setup();
    const onLink = vi.fn();
    const onLinkTargetChange = vi.fn();

    render(
      <AdminClassSheetCard
        sheet={sheet}
        unassigned
        isSuperadmin
        weekends={[{ id: "evt-1", name: "National Sailing Championships", startDate: "2026-09-05" }]}
        linkTarget=""
        onLinkTargetChange={onLinkTargetChange}
        onLink={onLink}
        onEditDetails={vi.fn()}
        onOpenResults={vi.fn()}
        onTogglePublish={vi.fn()}
      />
    );

    expect(screen.getByRole("heading", { name: "NSC 2026 ILCA 4" })).toBeInTheDocument();
    expect(screen.getByText("Races not set")).toHaveClass("whitespace-nowrap");
    expect(screen.getByText("Fleet 31")).toBeInTheDocument();
    expect(screen.getByText("2026-09-05")).toBeInTheDocument();
    expect(screen.getByText("ILCA 4").closest("span")).toHaveClass("whitespace-nowrap");
    expect(screen.getByRole("combobox", { name: "Event for NSC 2026 ILCA 4" })).toBeInTheDocument();
    expect(screen.getByText("Choose an event")).toBeInTheDocument();

    const link = screen.getByRole("button", { name: "Link" });
    expect(link).toBeDisabled();
    await user.selectOptions(screen.getByRole("combobox"), "evt-1");
    expect(onLinkTargetChange).toHaveBeenCalledWith("evt-1");
  });

  it("moves a class onto another regatta and leaves the current one out", async () => {
    const user = userEvent.setup();
    const onLink = vi.fn();
    const onLinkTargetChange = vi.fn();

    render(
      <AdminClassSheetCard
        sheet={sheet}
        isSuperadmin
        currentEventId="evt-current"
        weekends={[
          { id: "evt-current", name: "RSYC Optimist Silver Fleet Knockout Championship 2026", startDate: "2026-09-26" },
          { id: "evt-parent", name: "RSYC Optimist Knockout Championship 2026", startDate: "2026-09-26" },
        ]}
        linkTarget=""
        onLinkTargetChange={onLinkTargetChange}
        onLink={onLink}
        onEditDetails={vi.fn()}
        onOpenResults={vi.fn()}
      />
    );

    expect(screen.getByText("Move to another regatta")).toBeInTheDocument();
    expect(screen.queryByRole("option", { name: /Silver Fleet/ })).not.toBeInTheDocument();
    const move = screen.getByRole("button", { name: "Move" });
    expect(move).toBeDisabled();
    await user.selectOptions(screen.getByRole("combobox", { name: "Regatta for ILCA 4" }), "evt-parent");
    expect(onLinkTargetChange).toHaveBeenCalledWith("evt-parent");
    expect(screen.getByRole("option", { name: /Knockout Championship 2026/ })).toBeInTheDocument();
  });

  it("uses the class label as the title once a sheet belongs to a weekend", () => {
    render(
      <AdminClassSheetCard
        sheet={sheet}
        onEditDetails={vi.fn()}
        onOpenResults={vi.fn()}
      />
    );

    expect(screen.getByRole("heading", { name: "ILCA 4" })).toBeInTheDocument();
    expect(screen.queryByText("Choose an event")).not.toBeInTheDocument();
    expect(screen.getByRole("button", { name: "View results" })).toBeInTheDocument();
    expect(screen.queryByRole("button", { name: "Unpublish" })).not.toBeInTheDocument();
    expect(screen.queryByRole("button", { name: "Delete ILCA 4" })).not.toBeInTheDocument();
  });

  it("deletes a class from the card without opening it", async () => {
    const user = userEvent.setup();
    const onDelete = vi.fn();

    render(
      <AdminClassSheetCard
        sheet={sheet}
        isSuperadmin
        onDelete={onDelete}
        onEditDetails={vi.fn()}
        onOpenResults={vi.fn()}
      />
    );

    await user.click(screen.getByRole("button", { name: "Class actions" }));
    await user.click(screen.getByRole("menuitem", { name: "Delete ILCA 4" }));
    expect(onDelete).toHaveBeenCalledOnce();
  });

  it("asks for results on an unpublished class and review when the class is ready", async () => {
    const user = userEvent.setup();
    const onOpenResults = vi.fn();
    const onOpenCheck = vi.fn();
    const { rerender } = render(
      <AdminClassSheetCard
        sheet={{ ...sheet, status: "draft" }}
        onEditDetails={vi.fn()}
        onOpenResults={onOpenResults}
        onOpenCheck={onOpenCheck}
      />
    );
    await user.click(screen.getByRole("button", { name: "Enter results" }));
    expect(onOpenResults).toHaveBeenCalledOnce();

    rerender(
      <AdminClassSheetCard
        sheet={{ ...sheet, status: "draft" }}
        readiness={{ summary: "publishable_ranking", checks: [] }}
        onEditDetails={vi.fn()}
        onOpenResults={onOpenResults}
        onOpenCheck={onOpenCheck}
      />
    );
    await user.click(screen.getByRole("button", { name: "Review and publish" }));
    expect(onOpenCheck).toHaveBeenCalledOnce();
  });
});
