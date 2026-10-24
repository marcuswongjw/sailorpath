/** @vitest-environment jsdom */
import type { ComponentProps } from "react";
import { fireEvent, render, screen, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it } from "vitest";
import { PublicRegattaResults } from "./PublicRegattaResults";
import { ResultScoringGuide } from "./ResultScoringGuide";

type Result = ComponentProps<typeof PublicRegattaResults>["results"][number];

function result(id: string, name: string, rank: number): Result {
  return {
    resultId: id, sailorId: id, regattaId: "event", sailorName: name, handle: id,
    sailNumber: id, rank, totalScore: rank === 1 ? 2 : 14, nettScore: 2,
    isDns: false, isOverseasCommitment: false, profileClaimed: true,
    raceResults: [
      {regattaResultId:id,raceNumber:1,score:rank,rawValue:String(rank),scoringCode:null,discarded:false},
      {regattaResultId:id,raceNumber:3,score:rank === 1 ? 1 : 12,rawValue:rank === 1 ? "1" : "(12 DSQ)",scoringCode:rank === 1 ? null : "DSQ",discarded:rank !== 1},
    ],
  };
}

describe("public result comparison", () => {
  it("keeps both views in the same sort order when switching views", async () => {
    const user = userEvent.setup();
    render(<PublicRegattaResults accent="orange" totalFleetSize={12} results={[result("b","Beta Sailor",2),result("a","Alpha Sailor",1)]} />);
    const cardsButton = screen.getByRole("button",{name:"Sailor cards"});
    const comparisonButton = screen.getByRole("button",{name:"Compare scores"});
    const cards = document.getElementById(cardsButton.getAttribute("aria-controls")!)!;
    const cardNames = () => within(cards).getAllByRole("article").map((card) => within(card).getByRole("link").textContent);
    const tableNames = () => within(screen.getByRole("table",{name:"Regatta results"})).getAllByRole("row").slice(1).map((row) => within(row).getByRole("link").textContent);
    expect(cardNames()).toEqual(["Alpha Sailor","Beta Sailor"]);
    expect(tableNames()).toEqual(cardNames());

    await user.selectOptions(screen.getByRole("combobox",{name:"Sort results"}),"name");
    await user.click(screen.getByRole("button",{name:"Change to descending order"}));
    expect(cardNames()).toEqual(["Beta Sailor","Alpha Sailor"]);
    await user.click(comparisonButton);
    expect(comparisonButton).toHaveAttribute("aria-pressed","true");
    expect(cardsButton).toHaveAttribute("aria-pressed","false");
    expect(tableNames()).toEqual(cardNames());
    await user.click(cardsButton);
    expect(cardsButton).toHaveAttribute("aria-pressed","true");
    expect(cardNames()).toEqual(["Beta Sailor","Alpha Sailor"]);
  });

  it("keeps penalty notation and exposes both its meaning and discard status", () => {
    render(<PublicRegattaResults accent="sky" totalFleetSize={12} results={[result("b","Beta Sailor",2)]} />);
    const score = screen.getAllByTitle("Race 3: (12 DSQ). Discarded score. DSQ: Entry disqualified from the race.");
    expect(score).toHaveLength(2);
    for (const cell of score) expect(within(cell).getByText("(12 DSQ)")).toHaveAttribute("aria-hidden","true");
    expect(screen.getByText("Discarded",{exact:true})).toBeInTheDocument();
    expect(screen.getByTitle("Race 2: score unavailable.")).toBeInTheDocument();
  });

  it("sorts with the keyboard without treating Space as page scroll", () => {
    render(<PublicRegattaResults accent="sky" totalFleetSize={12} results={[result("b","Beta Sailor",2),result("a","Alpha Sailor",1)]} />);
    const name = screen.getByRole("columnheader",{name:"Name"});
    expect(fireEvent.keyDown(name,{key:" "})).toBe(false);
    expect(name).toHaveAttribute("aria-sort","ascending");
    fireEvent.keyDown(name,{key:"Enter"});
    expect(name).toHaveAttribute("aria-sort","descending");
  });

  it("only explains observed codes and preserves event-specific code uncertainty", () => {
    render(<ResultScoringGuide codes={[" DSQ ","DSQ","CUSTOM",""]} />);
    expect(screen.getAllByText("DSQ",{exact:true})).toHaveLength(1);
    expect(screen.getByText("CUSTOM",{exact:true})).toBeInTheDocument();
    expect(screen.queryByText("DNS",{exact:true})).toBeNull();
    expect(screen.getByText("See the organiser’s scoring notes for this code.")).toBeInTheDocument();
    expect(screen.getByRole("link",{name:/World Sailing scoring abbreviations/})).toHaveAttribute("href","https://www.sailing.org/document/2025-2028-rrs-with-changes-and-corrections/");
  });
});
