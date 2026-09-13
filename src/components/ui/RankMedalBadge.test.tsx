/** @vitest-environment jsdom */
import { describe, expect, it } from "vitest";
import { render, screen } from "@testing-library/react";
import { RankMedalBadge } from "./RankMedalBadge";

describe("RankMedalBadge", () => {
  it("renders Gold medal styling for rank 1", () => {
    render(<RankMedalBadge rank={1} />);
    const badge = screen.getByTitle("1st Place (Gold Medal)");
    expect(badge).toBeInTheDocument();
    expect(badge).toHaveClass("bg-amber-400");
    expect(badge.textContent).toBe("1");
  });

  it("renders Silver medal styling for rank 2", () => {
    render(<RankMedalBadge rank={2} />);
    const badge = screen.getByTitle("2nd Place (Silver Medal)");
    expect(badge).toBeInTheDocument();
    expect(badge).toHaveClass("bg-slate-300");
    expect(badge.textContent).toBe("2");
  });

  it("renders Bronze medal styling for rank 3", () => {
    render(<RankMedalBadge rank={3} />);
    const badge = screen.getByTitle("3rd Place (Bronze Medal)");
    expect(badge).toBeInTheDocument();
    expect(badge).toHaveClass("bg-amber-700");
    expect(badge.textContent).toBe("3");
  });

  it("renders plain font-mono text for rank 4 and above", () => {
    render(<RankMedalBadge rank={4} />);
    expect(screen.queryByTitle(/Medal/i)).toBeNull();
    expect(screen.getByText("4")).toHaveClass("font-mono");
  });

  it("appends suffix when provided", () => {
    render(<RankMedalBadge rank={1} suffix="*" />);
    expect(screen.getByText("1*")).toBeInTheDocument();
  });
});
