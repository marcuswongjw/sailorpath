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

  it("switches to Rules & Format tab", () => {
    render(<WingfoilView />);

    const formatButton = screen.getByRole("button", { name: /Rules & Format/i });
    fireEvent.click(formatButton);

    expect(screen.getByText("Singapore Sprint Slalom Targets")).toBeInTheDocument();
    expect(screen.getByText("Course & Equipment Rules")).toBeInTheDocument();
  });

  it("switches to Singapore Series calendar tab", () => {
    render(<WingfoilView />);

    const seriesButton = screen.getByRole("button", { name: /Singapore Series/i });
    fireEvent.click(seriesButton);

    expect(
      screen.getByText("2026 Southwest Monsoon Grand Prix Series 1–3")
    ).toBeInTheDocument();
  });
});
