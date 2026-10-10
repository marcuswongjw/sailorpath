/** @vitest-environment jsdom */
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { WingfoilView } from "./WingfoilView";

vi.mock("next/link", () => ({
  default: ({
    children,
    href,
    ...rest
  }: {
    children: React.ReactNode;
    href: string;
    [key: string]: unknown;
  }) => (
    <a href={href} {...rest}>
      {children}
    </a>
  ),
}));

beforeEach(() => {
  vi.stubGlobal("fetch", vi.fn().mockResolvedValue({ ok: false }));
});

afterEach(() => {
  vi.unstubAllGlobals();
});

describe("WingfoilView", () => {
  it("renders the shared WingFoil header and event calendar by default", () => {
    render(<WingfoilView />);

    expect(screen.getByText("WingFoil")).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Event calendar/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Published results/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Overall Championship/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /^Scorecard$/i })).toBeInTheDocument();

    // Default tab is Regattas table
    expect(screen.getByText("2025 Northeast Monsoon Grand Prix Series 2")).toBeInTheDocument();
  });

  it("verifies Singapore Series and Rules & Format tabs are dropped", () => {
    render(<WingfoilView />);

    expect(screen.getByRole("button", { name: /Event calendar/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Published results/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Overall Championship/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /^Scorecard$/i })).toBeInTheDocument();
    expect(screen.queryByRole("button", { name: /Singapore Series/i })).toBeNull();
    expect(screen.queryByRole("button", { name: /Rules & Format/i })).toBeNull();
  });

  it("switches to Overall Championship and toggles between NE Monsoon and SW Monsoon series championships", () => {
    render(<WingfoilView />);

    // Switch to Overall Championship
    const champTab = screen.getByRole("button", { name: /Overall Championship/i });
    fireEvent.click(champTab);

    // By default, NE Monsoon is selected in series view
    expect(screen.getByText("2026 Northeast Monsoon Grand Prix Series")).toBeInTheDocument();

    // Click the SW Monsoon GP switcher button
    const swButton = screen.getByRole("button", { name: /SW Monsoon GP/i });
    fireEvent.click(swButton);

    // Expect SW Monsoon series title and live championship standings to be displayed
    expect(
      screen.getAllByText("2026 SW Monsoon Grand Prix Series").length
    ).toBeGreaterThanOrEqual(1);
    expect(
      screen.getAllByText("Victoria Natasha Chew").length
    ).toBeGreaterThanOrEqual(1);
  });

  it("switches to Scorecard and renders regatta select dropdown & gender pills", () => {
    render(<WingfoilView />);

    const resultsTab = screen.getByRole("button", { name: /^Scorecard$/i });
    fireEvent.click(resultsTab);

    // Regatta dropdown
    expect(screen.getByRole("combobox")).toBeInTheDocument();
    // Gender pill buttons
    expect(screen.getByRole("button", { name: /^All$/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Men \/ Boys/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Women \/ Girls/i })).toBeInTheDocument();
  });

  it("lists a published scorecard even when it has no event-catalog slice", () => {
    render(
      <WingfoilView
        initialRegattas={[
          {
            id: "unregistered-wingfoil-round",
            name: "Unregistered WingFoil Round",
            shortName: "Unregistered Round",
            dates: "10 October 2026",
            venue: "Singapore",
            organizer: "Test Club",
            format: "Course Race",
            status: "Completed",
            lifecycleStatus: "published",
            scoringSystem: "Low point",
            rulesNotes: "Official results",
            results: [],
          },
        ]}
      />
    );

    fireEvent.click(screen.getByRole("button", { name: /Published results/i }));

    expect(screen.getByText("Unregistered WingFoil Round")).toBeInTheDocument();
    expect(screen.getByText("Specialist scorecard")).toBeInTheDocument();
  });
});
