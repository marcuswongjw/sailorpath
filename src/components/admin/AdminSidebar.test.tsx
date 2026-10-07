/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import { AdminSidebar } from "./AdminSidebar";

const base = {
  sailorsView: "directory",
  inboxView: "claims",
  insightsView: "optimist",
  settingsView: "audit",
  eventsView: "card",
  inboxCount: 3,
  queueCounts: { claims: 2 },
  landingView: "claims" as const,
  onNavigate: () => true,
};

describe("AdminSidebar", () => {
  it("puts the areas on one row and the open section on the next", () => {
    const { container } = render(<AdminSidebar {...base} activeArea="events" />);
    expect(screen.getByRole("link", { name: "Events" })).toHaveAttribute("aria-current", "page");
    expect(screen.getByRole("link", { name: "Import" })).toBeInTheDocument();
    expect(screen.queryByRole("link", { name: "Directory" })).not.toBeInTheDocument();
    const rows = container.querySelectorAll("ul");
    expect(rows[0]?.className).toContain("flex-wrap");
    expect(rows[1]?.className).toContain("flex-wrap");
    expect(rows[0]?.className).not.toContain("space-y-1");
  });

  it("shows the sailor sections when Sailors is open", () => {
    render(<AdminSidebar {...base} activeArea="sailors" sailorsView="duplicates" />);
    expect(screen.getByRole("link", { name: "Duplicates" })).toHaveAttribute("aria-current", "page");
    expect(screen.getByRole("link", { name: "ILCA 4 squad" })).toBeInTheDocument();
  });

  it("shows focused event queues and marks the selected queue", () => {
    render(
      <AdminSidebar {...base} activeArea="events" eventsView="missing-results" />
    );
    expect(screen.getByRole("link", { name: "Missing results" })).toHaveAttribute(
      "aria-current",
      "page"
    );
    expect(screen.getByRole("link", { name: "Ready to publish" })).toHaveAttribute(
      "href",
      "/admin?area=events&view=ready-to-publish"
    );
    expect(screen.getByRole("link", { name: "Data health" })).toHaveAttribute(
      "href",
      "/admin?area=events&view=attention"
    );
  });
});
