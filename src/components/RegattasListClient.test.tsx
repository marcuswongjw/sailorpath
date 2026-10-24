/** @vitest-environment jsdom */
import { fireEvent, render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import { RegattasListClient } from "./RegattasListClient";

describe("class listing aliases", () => {
  it("offers one filter per class and includes every spelling without mixing disciplines", () => {
    render(<RegattasListClient hideBoatClassFilter={false} regattas={[
      { id: "a", name: "Wind event A", slug: "wind-a", boatClass: "Windfoil", date: "2026-08-01", totalFleetSize: 10 },
      { id: "b", name: "Wind event B", slug: "wind-b", boatClass: "WindFoil", date: "2026-08-01", totalFleetSize: 10 },
      { id: "c", name: "Wing event", slug: "wing", boatClass: "Wingfoil", date: "2026-08-01", totalFleetSize: 10 },
    ]} />);
    const filter = screen.getByRole("combobox", { name: "Boat Class" });
    expect(filter.querySelectorAll('option[value="Windfoil"]')).toHaveLength(1);
    fireEvent.change(filter, { target: { value: "Windfoil" } });
    expect(screen.getByRole("heading", { name: "Wind event A" })).toBeInTheDocument();
    expect(screen.getByRole("heading", { name: "Wind event B" })).toBeInTheDocument();
    expect(screen.queryByRole("heading", { name: "Wing event" })).not.toBeInTheDocument();
    fireEvent.change(screen.getByPlaceholderText("Search regatta name…"), { target: { value: "unmatched" } });
    fireEvent.click(screen.getByRole("button", { name: "Reset all filters" }));
    expect(filter).toHaveValue("all");
    expect(screen.getByRole("heading", { name: "Wing event" })).toBeInTheDocument();
  });
});
