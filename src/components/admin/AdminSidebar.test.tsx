/** @vitest-environment jsdom */
import { fireEvent, render, screen } from "@testing-library/react";
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
  it("links to user changes under Insights", () => {
    render(
      <AdminSidebar
        {...base}
        activeArea="insights"
        insightsView="user-changes"
      />,
    );
    expect(screen.getByRole("link", { name: "User changes" })).toHaveAttribute(
      "href",
      "/admin?area=insights&view=user-changes",
    );
    expect(screen.getByRole("link", { name: "User changes" })).toHaveAttribute(
      "aria-current",
      "page",
    );
  });
  it("uses one vertical navigation with contextual workspace tools", () => {
    const { container } = render(
      <AdminSidebar {...base} activeArea="events" />,
    );
    expect(
      screen.getByRole("link", { name: "Events & results" }),
    ).toHaveAttribute("aria-current", "page");
    expect(screen.getByRole("link", { name: "Import" })).toBeInTheDocument();
    expect(
      screen.queryByRole("link", { name: "Directory" }),
    ).not.toBeInTheDocument();
    const rows = container.querySelectorAll("ul");
    expect(rows[0]?.className).toContain("flex-col");
    expect(rows[1]?.className).toContain("flex-col");
    expect(rows[0]?.className).not.toContain("space-y-1");
  });

  it("shows the sailor sections when Sailors is open", () => {
    render(
      <AdminSidebar {...base} activeArea="sailors" sailorsView="duplicates" />,
    );
    expect(screen.getByRole("link", { name: "Duplicates" })).toHaveAttribute(
      "aria-current",
      "page",
    );
    expect(
      screen.getByRole("link", { name: "ILCA 4 squad" }),
    ).toBeInTheDocument();
  });

  it("makes Editorial a main destination", () => {
    render(
      <AdminSidebar {...base} activeArea="settings" settingsView="audit" />,
    );
    expect(screen.getByRole("link", { name: "Editorial" })).toHaveAttribute(
      "href",
      "/admin/news",
    );
  });
  it("has a labelled mobile navigation toggle", () => {
    render(<AdminSidebar {...base} activeArea="overview" />);
    const toggle = screen.getByRole("button", { name: "Admin navigation" });
    expect(toggle).toHaveAttribute("aria-expanded", "false");
    fireEvent.click(toggle);
    expect(toggle).toHaveAttribute("aria-expanded", "true");
    expect(screen.getByRole("link", { name: "Today" })).toHaveAttribute(
      "aria-current",
      "page",
    );
  });

  it("shows focused event queues and marks the selected queue", () => {
    render(
      <AdminSidebar
        {...base}
        activeArea="events"
        eventsView="missing-results"
      />,
    );
    expect(
      screen.getByRole("link", { name: "Missing results" }),
    ).toHaveAttribute("aria-current", "page");
    expect(
      screen.getByRole("link", { name: "Ready for review" }),
    ).toHaveAttribute("href", "/admin?area=events&view=ready-to-publish");
    expect(screen.getByRole("link", { name: "Data health" })).toHaveAttribute(
      "href",
      "/admin?area=events&view=attention",
    );
  });
});
