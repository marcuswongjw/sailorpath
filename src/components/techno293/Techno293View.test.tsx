/** @vitest-environment jsdom */
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
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

beforeEach(() => {
  vi.stubGlobal("fetch", vi.fn().mockResolvedValue({ ok: false }));
});

afterEach(() => {
  vi.unstubAllGlobals();
});

describe("Techno293View", () => {
  it("renders the shared Techno 293 header and event calendar by default", () => {
    render(<Techno293View />);

    expect(screen.getByText("Techno 293")).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Event calendar/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Published results/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Overall Championship/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /^Scorecard$/i })).toBeInTheDocument();
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

  it("switches to Scorecard and renders regatta select dropdown & gender pills", () => {
    render(<Techno293View />);

    const resultsTab = screen.getByRole("button", { name: /^Scorecard$/i });
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
