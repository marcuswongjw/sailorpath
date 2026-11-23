/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { IlcaSelectionView } from "./IlcaSelectionView";
import { Ilca6SelectionView } from "./Ilca6SelectionView";
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

    expect(screen.getByRole("link", { name: "Log in or sign up to view selection" })).toHaveAttribute(
      "href",
      "/login?next=%2Fsg%2Filca4%2Fselection"
    );
    expect(screen.queryByText("Create Free Account")).not.toBeInTheDocument();
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

    // Click 2027 Policies tab
    fireEvent.click(screen.getByRole("tab", { name: /2027 Policies/i }));
    expect(screen.getByText("2027 Selection Policy for ILCA 4")).toBeInTheDocument();
    expect(
      screen.getByRole("heading", { level: 3, name: "23rd Langkawi International Regatta 2027" })
    ).toBeInTheDocument();
    expect(
      screen.getByRole("heading", { level: 3, name: "ILCA 4 China Training Camp 2027" })
    ).toBeInTheDocument();
    expect(
      screen.getByRole("heading", { level: 3, name: "ILCA 4 Youth World Championships 2027" })
    ).toBeInTheDocument();
    expect(
      screen.getByRole("heading", { level: 3, name: "Eastern Seaboard Regatta 2027" })
    ).toBeInTheDocument();
  });
});

describe("Ilca6SelectionView", () => {
  it("renders all 5 ILCA 6 2027 selection campaigns and class cross-links", () => {
    render(<Ilca6SelectionView />);

    expect(screen.getByText("ILCA 6 Selection Policies 2027")).toBeInTheDocument();
    expect(
      screen.getByRole("heading", { level: 3, name: "23rd Langkawi International Regatta 2027" })
    ).toBeInTheDocument();
    expect(
      screen.getByRole("heading", { level: 3, name: "ILCA 6 China Training Camp 2027" })
    ).toBeInTheDocument();
    expect(
      screen.getByRole("heading", { level: 3, name: "Kieler Woche 2027" })
    ).toBeInTheDocument();
    expect(
      screen.getByRole("heading", { level: 3, name: "ILCA 6 Youth World Championships 2027" })
    ).toBeInTheDocument();
    expect(
      screen.getByRole("heading", { level: 3, name: "Eastern Seaboard Regatta 2027" })
    ).toBeInTheDocument();
    expect(screen.getByRole("link", { name: /ILCA 4 Selection/i })).toHaveAttribute(
      "href",
      "/sg/ilca4/selection"
    );
    expect(screen.getByRole("link", { name: /Optimist Selection/i })).toHaveAttribute(
      "href",
      "/sg/optimist/selection"
    );
  });
});

describe("WingfoilSelectionView", () => {
  it("renders funding policy, categories, and survey link", () => {
    render(<WingfoilSelectionView />);

    expect(screen.getByText("Wingfoil Funding Policy")).toBeInTheDocument();
    expect(screen.getByText(/Category Selection Survey (?:Deadline|Closed)/i)).toBeInTheDocument();
    expect(screen.getByText("Top Youth U17")).toBeInTheDocument();
    expect(screen.getByText("Top Junior U15")).toBeInTheDocument();
    expect(screen.getByText("Top Female (Youth/Junior)")).toBeInTheDocument();
    expect(
      screen.getByText(/Athlete Contribution Capped at \$2,800 per event/i)
    ).toBeInTheDocument();
    expect(screen.getAllByText(/Selection Trials/i).length).toBeGreaterThan(0);
    expect(screen.getByText("Official Selection Document")).toBeInTheDocument();
  });
});
