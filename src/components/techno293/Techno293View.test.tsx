/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { Techno293View } from "./Techno293View";

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

describe("Techno293View", () => {
  it("renders Techno 293 hub header and Regattas list by default", () => {
    render(<Techno293View />);

    expect(screen.getByText("Singapore Techno 293")).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Regattas/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Overall Championship/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Regatta Standings/i })).toBeInTheDocument();
    expect(screen.queryByRole("button", { name: /Singapore Series/i })).toBeNull();
    expect(screen.getByRole("button", { name: /Class Specs/i })).toBeInTheDocument();

    // Default tab is Regattas table
    expect(screen.getByText("2025 Northeast Monsoon Grand Prix Series 2")).toBeInTheDocument();
  });

  it("switches to Overall Championship and displays series leader", () => {
    render(<Techno293View />);

    const champTab = screen.getByRole("button", { name: /Overall Championship/i });
    fireEvent.click(champTab);

    // Trevor Ng is the series leader in SW series
    expect(screen.getAllByText(/Trevor Ng/i).length).toBeGreaterThanOrEqual(1);
  });

  it("switches to Regatta Standings tab and renders regatta select dropdown & gender pills", () => {
    render(<Techno293View />);

    const resultsTab = screen.getByRole("button", { name: /Regatta Standings/i });
    fireEvent.click(resultsTab);

    // Regatta dropdown combobox
    expect(screen.getByRole("combobox")).toBeInTheDocument();

    // Gender pill buttons
    expect(screen.getByRole("button", { name: /^All$/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Men \/ Boys/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Women \/ Girls/i })).toBeInTheDocument();

    // Should show sailor names
    expect(screen.getAllByText(/Trevor Ng/i).length).toBeGreaterThanOrEqual(1);
  });

  it("switches to Class Specs tab", () => {
    render(<Techno293View />);

    const specsTab = screen.getByRole("button", { name: /Class Specs/i });
    fireEvent.click(specsTab);

    expect(screen.getByText(/Techno 293 One Design Class Overview/i)).toBeInTheDocument();
    expect(screen.getByText(/Bic Techno 293 One Design/i)).toBeInTheDocument();
  });
});
