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

  it("verifies Singapore Series and Rules & Format tabs are dropped", () => {
    render(<WingfoilView />);

    expect(screen.getByRole("button", { name: /Overall Championship/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Regatta Standings/i })).toBeInTheDocument();
    expect(screen.queryByRole("button", { name: /Singapore Series/i })).toBeNull();
    expect(screen.queryByRole("button", { name: /Rules & Format/i })).toBeNull();
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

  it("switches to Regatta Standings tab and renders regatta select dropdown & gender pills", () => {
    render(<WingfoilView />);

    const resultsTab = screen.getByRole("button", { name: /Regatta Standings/i });
    fireEvent.click(resultsTab);

    // Regatta dropdown
    expect(screen.getByRole("combobox")).toBeInTheDocument();
    // Gender pill buttons
    expect(screen.getByRole("button", { name: /^All$/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Men \/ Boys/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Women \/ Girls/i })).toBeInTheDocument();
  });
});
