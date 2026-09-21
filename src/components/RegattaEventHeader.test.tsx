/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import { describe, it, expect } from "vitest";
import { RegattaEventHeader } from "./RegattaEventHeader";

describe("RegattaEventHeader", () => {
  it("renders regatta title, division, class and metadata", () => {
    render(
      <RegattaEventHeader
        name="Singapore National Sailing Championships 2026"
        date="2026-09-11"
        division="National"
        totalFleetSize={130}
        raceCount={8}
        series="optimist"
        countsForRanking={true}
      />
    );

    expect(
      screen.getByRole("heading", { name: "Singapore National Sailing Championships 2026" })
    ).toBeInTheDocument();
    expect(screen.getByText("Optimist")).toBeInTheDocument();
    expect(screen.getByText("National")).toBeInTheDocument();
    expect(screen.getByText(/fleet 130/)).toBeInTheDocument();
    expect(screen.getByText(/8 races/)).toBeInTheDocument();
    expect(screen.queryByText(/official notice board/i)).not.toBeInTheDocument();
  });

  it("renders Official Notice Board link when norUrl is provided", () => {
    render(
      <RegattaEventHeader
        name="Singapore National Sailing Championships 2026"
        date="2026-09-11"
        division="National"
        totalFleetSize={130}
        raceCount={8}
        series="optimist"
        countsForRanking={true}
        norUrl="https://www.racingrulesofsailing.org/documents/14487/event"
      />
    );

    const onbLink = screen.getByRole("link", { name: /official notice board/i });
    expect(onbLink).toBeInTheDocument();
    expect(onbLink).toHaveAttribute("href", "https://www.racingrulesofsailing.org/documents/14487/event");
    expect(onbLink).toHaveAttribute("target", "_blank");
  });
});
