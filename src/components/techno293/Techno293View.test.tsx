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
  it("renders Techno 293 hub header and championship leaderboard", () => {
    render(<Techno293View />);

    expect(screen.getByText("Singapore Techno 293")).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Overall Championship/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Regatta Standings/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Singapore Series/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Class Specs/i })).toBeInTheDocument();

    // Trevor Ng is the series leader
    expect(screen.getAllByText(/Trevor Ng/i).length).toBeGreaterThanOrEqual(1);
  });

  it("switches to Regatta Standings tab and renders round results", () => {
    render(<Techno293View />);

    const resultsTab = screen.getByRole("button", { name: /Regatta Standings/i });
    fireEvent.click(resultsTab);

    // Should show regatta round results and sailor names
    expect(screen.getAllByText(/Trevor Ng/i).length).toBeGreaterThanOrEqual(1);
    expect(screen.getAllByText(/Addy Armand Anuar/i).length).toBeGreaterThanOrEqual(1);
  });

  it("switches to Singapore Series calendar tab", () => {
    render(<Techno293View />);

    const calendarTab = screen.getByRole("button", { name: /Singapore Series/i });
    fireEvent.click(calendarTab);

    expect(screen.getByText(/2026 Singapore Techno 293 Calendar/i)).toBeInTheDocument();
    expect(screen.getByText(/SW Monsoon GP1/i)).toBeInTheDocument();
    expect(screen.getByText(/SW Monsoon GP2/i)).toBeInTheDocument();
    expect(screen.getByText(/SW Monsoon GP3/i)).toBeInTheDocument();
  });

  it("switches to Class Specs tab", () => {
    render(<Techno293View />);

    const specsTab = screen.getByRole("button", { name: /Class Specs/i });
    fireEvent.click(specsTab);

    expect(screen.getByText(/Techno 293 One Design Class Overview/i)).toBeInTheDocument();
    expect(screen.getByText(/Bic Techno 293 One Design/i)).toBeInTheDocument();
  });
});
