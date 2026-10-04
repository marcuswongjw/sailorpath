/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import { EventFacts, joinDateRange } from "./EventFacts";

describe("EventFacts", () => {
  it("lists dates, venue, and organiser on separate rows", () => {
    render(
      <EventFacts
        dates="3–4 October 2026"
        venue="Republic of Singapore Yacht Club, Singapore"
        organiser="Republic of Singapore Yacht Club"
      />
    );

    expect(screen.getByText("Dates:")).toBeInTheDocument();
    expect(screen.getByText("3–4 October 2026")).toBeInTheDocument();
    expect(screen.getByText("Venue:")).toBeInTheDocument();
    expect(screen.getByText("Republic of Singapore Yacht Club, Singapore")).toBeInTheDocument();
    expect(screen.getByText("Organiser:")).toBeInTheDocument();
    expect(screen.getByText("Republic of Singapore Yacht Club")).toBeInTheDocument();
  });

  it("omits a blank fact", () => {
    render(<EventFacts dates="3–4 October 2026" venue="" organiser="" />);
    expect(screen.getByText("Dates:")).toBeInTheDocument();
    expect(screen.queryByText("Venue:")).not.toBeInTheDocument();
    expect(screen.queryByText("Organiser:")).not.toBeInTheDocument();
  });
});

describe("joinDateRange", () => {
  it("joins a start and end date", () => {
    expect(joinDateRange("2026-10-03", "2026-10-04")).toBe("2026-10-03 – 2026-10-04");
    expect(joinDateRange("2026-10-03", "2026-10-03")).toBe("2026-10-03");
    expect(joinDateRange("", "2026-10-04")).toBe("");
  });
});
