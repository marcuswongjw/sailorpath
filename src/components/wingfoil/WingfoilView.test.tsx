/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
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

describe("WingfoilView", () => {
  it("renders WingFoil hub header and results", () => {
    render(<WingfoilView />);

    expect(screen.getByText("WingFoil Racing")).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Regatta Standings/i })).toBeInTheDocument();
    expect(screen.getAllByText(/Kate En Rui Bateman/i).length).toBeGreaterThanOrEqual(1);
  });

  it("defaults to Overall Championship tab and verifies Rules & Format tab is removed", () => {
    render(<WingfoilView />);

    expect(screen.getByRole("button", { name: /Overall Championship/i })).toBeInTheDocument();
    expect(screen.queryByRole("button", { name: /Rules & Format/i })).toBeNull();
  });

  it("switches to Singapore Series calendar tab", () => {
    render(<WingfoilView />);

    const seriesButton = screen.getByRole("button", { name: /Singapore Series/i });
    fireEvent.click(seriesButton);

    expect(
      screen.getByText("2026 SW Monsoon Grand Prix 1 (Round 1 of 3)")
    ).toBeInTheDocument();
  });

  it("switches between NE Monsoon and SW Monsoon series championships", () => {
    render(<WingfoilView />);

    // By default, NE Monsoon is selected
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

  it("arranges regattas in chronological order with latest at the top", () => {
    render(<WingfoilView />);

    // Switch to Singapore Series calendar tab
    const seriesButton = screen.getByRole("button", { name: /Singapore Series/i });
    fireEvent.click(seriesButton);

    const headings = screen.getAllByRole("heading", { level: 3 }).map((h) => h.textContent);
    // Expect top heading to be the October event, followed by September, August, July, etc.
    expect(headings[0]).toContain("2026 SW Monsoon Grand Prix 3");
    expect(headings[1]).toContain("Singapore National Sailing Championships 2026");
    expect(headings[2]).toContain("2026 SW Monsoon Grand Prix 2");
    expect(headings[3]).toContain("2026 SW Monsoon Grand Prix 1");
  });
});
