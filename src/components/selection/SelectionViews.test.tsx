/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { IlcaSelectionView } from "./IlcaSelectionView";
import { WingfoilSelectionView } from "./WingfoilSelectionView";

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

describe("IlcaSelectionView", () => {
  it("renders overview, campaigns, and switches tabs", () => {
    render(<IlcaSelectionView />);

    expect(
      screen.getByText("ILCA 4 Selection Trials & Squad Policies")
    ).toBeInTheDocument();
    expect(screen.getByText("Eastern Seaboard 2026")).toBeInTheDocument();
    expect(screen.getByText("Asian Open Champs 2026")).toBeInTheDocument();
    expect(screen.getByText("NJTS Squad Policy")).toBeInTheDocument();

    // Click Eastern Seaboard tab
    fireEvent.click(screen.getByText("Eastern Seaboard 2026"));
    expect(
      screen.getByText(/Eastern Seaboard Regatta 2026 & ILCA District Championships 2026/i)
    ).toBeInTheDocument();
    expect(screen.getByText("Top 3 boys & Top 3 girls")).toBeInTheDocument();
    expect(screen.getByText("Singapore Citizens born in 2012 or later")).toBeInTheDocument();

    // Click Asian Open Champs tab
    fireEvent.click(screen.getByText("Asian Open Champs 2026"));
    expect(
      screen.getByText(/ILCA Asian Open Championships 2026/i)
    ).toBeInTheDocument();
    expect(screen.getByText("Top 4 boys & Top 4 girls")).toBeInTheDocument();
    expect(screen.getByText("Singapore Citizens born in 2010 or later")).toBeInTheDocument();

    // Click NJTS Squad Policy tab
    fireEvent.click(screen.getByText("NJTS Squad Policy"));
    expect(
      screen.getAllByText(/National Junior Training Squad \(NJTS\)/i).length
    ).toBeGreaterThanOrEqual(1);
    expect(
      screen.getByText(/16-Athlete Selection Matrix/i)
    ).toBeInTheDocument();
  });
});

describe("WingfoilSelectionView", () => {
  it("renders funding policy, categories, and survey link", () => {
    render(<WingfoilSelectionView />);

    expect(screen.getByText("Wingfoil Funding Policy")).toBeInTheDocument();
    expect(screen.getByText(/Category Selection Survey Deadline/i)).toBeInTheDocument();
    expect(screen.getByText("Top Youth U17")).toBeInTheDocument();
    expect(screen.getByText("Top Junior U15")).toBeInTheDocument();
    expect(screen.getByText("Top Senior Female")).toBeInTheDocument();
    expect(
      screen.getByText(/Athlete Contribution Capped at \$2,800 per event/i)
    ).toBeInTheDocument();
    expect(
      screen.getByText(/Southwest Monsoon Grand Prix Series 3/i)
    ).toBeInTheDocument();
  });
});
