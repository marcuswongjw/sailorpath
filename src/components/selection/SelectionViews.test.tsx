/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { IlcaSelectionView } from "./IlcaSelectionView";
import { WingfoilSelectionView } from "./WingfoilSelectionView";
import { ILCA4_SELECTION_SAILORS } from "@/lib/ilcaSelectionData";

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

const useAccountOptionalMock = vi.fn();

vi.mock("@/components/AccountProvider", () => ({
  useAccountOptional: () => useAccountOptionalMock(),
}));

describe("IlcaSelectionView", () => {
  it("renders member access gate when user is not logged in", () => {
    useAccountOptionalMock.mockReturnValue({
      email: null,
      owned: [],
      ready: true,
    });
    render(<IlcaSelectionView initialSailors={[]} isAuthenticated={false} />);

    expect(
      screen.getByText("Sign In to View Selection")
    ).toBeInTheDocument();
    expect(screen.getByText("Create Free Account")).toBeInTheDocument();
    // Trial details stay hidden for signed-out visitors
    expect(screen.queryByText("Eastern Seaboard 2026")).not.toBeInTheDocument();
  });

  it("renders overview, campaigns, and switches tabs", () => {
    useAccountOptionalMock.mockReturnValue({
      email: "parent@example.com",
      owned: [],
      ready: true,
    });
    render(
      <IlcaSelectionView
        initialSailors={ILCA4_SELECTION_SAILORS}
        isAuthenticated={true}
      />
    );

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
    expect(screen.getByText("Top Female (Youth/Junior)")).toBeInTheDocument();
    expect(
      screen.getByText(/Athlete Contribution Capped at \$2,800 per event/i)
    ).toBeInTheDocument();
    expect(screen.getByText(/Selection Trials/i)).toBeInTheDocument();
    expect(screen.getByText("Official Selection Document")).toBeInTheDocument();
  });
});
