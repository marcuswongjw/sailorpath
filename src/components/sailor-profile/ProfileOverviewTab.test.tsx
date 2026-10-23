/** @vitest-environment jsdom */
import { render, screen, within } from "@testing-library/react";
import { describe, expect, it, vi } from "vitest";
import { ProfileOverviewTab, type ProfileOverviewTabProps } from "./ProfileOverviewTab";

vi.mock("next/dynamic", () => ({ default: () => () => null }));

const props: ProfileOverviewTabProps = {
  activeStanding: null, standingIsIlca: false, seriesDnsCount: 0, cardClass: "",
  resultsTab: "optimist", trendPoints: [], trendMode: "other", trendGoldEntry: null,
  trendCaption: "", trendCountry: "SGP", setTrendCountry: vi.fn(),
  trendCountryOptions: [{code: "SGP", name: "Singapore"}], primaryIsIlca: false,
  onNavigateTab: vi.fn(), activeResultsList: [],
};
function metric(region: HTMLElement, label: string) {
  return within(region).getByText(label).parentElement?.querySelector("dd")?.textContent;
}

describe("profile results summary", () => {
  it("separates DNS and unplaced records from real finishes and shows the latest finish with fleet context", () => {
    render(<ProfileOverviewTab {...props} activeResultsList={[
      {id:"dns",regattaName:"Missed Cup",rank:51,isDNS:true},
      {id:"latest",regattaName:"Recent Cup",rank:7,totalFleetSize:30,regattaDate:"2026-10-01"},
      {id:"old",regattaName:"Older Cup",rank:1,fleetSize:12},
      {id:"unknown",regattaName:"Unplaced Cup",rank:null},
      {id:"invalid",regattaName:"Invalid Cup",rank:0},
    ]} />);
    const summary = screen.getByRole("region",{name:"Optimist results summary"});
    expect(metric(summary,"Recorded finishes")).toBe("2");
    expect(metric(summary,"Did not start (DNS)")).toBe("1");
    expect(metric(summary,"Latest recorded finish")).toBe("7th of 30");
    expect(within(summary).getByText(/Recent Cup/)).toBeInTheDocument();
  });

  it("updates class context and handles unknown fleet size without inventing a denominator", () => {
    const {rerender} = render(<ProfileOverviewTab {...props} classLabel="Techno 293" hideStanding activeResultsList={[{id:"board",rank:2,fleetSize:null}]} />);
    expect(metric(screen.getByRole("region",{name:"Techno 293 results summary"}),"Latest recorded finish")).toBe("2nd");
    rerender(<ProfileOverviewTab {...props} classLabel="ILCA 6" activeResultsList={[]} />);
    const summary = screen.getByRole("region",{name:"ILCA 6 results summary"});
    expect(metric(summary,"Recorded finishes")).toBe("0");
    expect(metric(summary,"Latest recorded finish")).toBe("No finish yet");
  });
});
