/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { FleetMembershipFields } from "./FleetMembershipFields";
import { emptySailorForm, type SailorFormState } from "./adminForms";

function renderFields(overrides: Partial<SailorFormState> = {}) {
  const onChange = vi.fn();
  const form: SailorFormState = {
    ...emptySailorForm(),
    name: "Ian Goh",
    ...overrides,
  };
  render(<FleetMembershipFields form={form} onChange={onChange} />);
  return { onChange, form };
}

describe("FleetMembershipFields", () => {
  it("offers SG Optimist, SG ILCA 4, and SG ILCA 6 together", () => {
    renderFields();
    expect(screen.getByRole("checkbox", { name: /SG Optimist/ })).not.toBeChecked();
    expect(screen.getByRole("checkbox", { name: /SG ILCA 4/ })).not.toBeChecked();
    expect(screen.getByRole("checkbox", { name: /SG ILCA 6/ })).not.toBeChecked();
    expect(screen.queryByRole("radio", { name: "Gold" })).not.toBeInTheDocument();
  });

  it("shows Gold or Silver once SG Optimist is on", async () => {
    const user = userEvent.setup();
    const { onChange } = renderFields();
    await user.click(screen.getByRole("checkbox", { name: /SG Optimist/ }));
    const next = onChange.mock.calls[0][0] as SailorFormState;
    expect(next.currentFleet).toBe("Series");
    expect(next.silverEntryDate).toMatch(/^\d{4}-\d{2}-\d{2}$/);
    expect(next.goldEntryDate).toBe("");
  });

  it("selects Gold without clearing an existing silver date", async () => {
    const user = userEvent.setup();
    const { onChange } = renderFields({
      currentFleet: "Series",
      silverEntryDate: "2024-02-01",
    });
    expect(screen.getByRole("radio", { name: "Silver" })).toBeChecked();
    await user.click(screen.getByRole("radio", { name: "Gold" }));
    const next = onChange.mock.calls[0][0] as SailorFormState;
    expect(next.goldEntryDate).toMatch(/^\d{4}-(01|07)-01$/);
    expect(next.silverEntryDate).toBe("2024-02-01");
    expect(next.currentFleet).toBe("Series");
  });

  it("checks ILCA 6 from the name seed until an explicit flag is stored", () => {
    renderFields({ name: "Tan, Kenan Kee Zen", ilca6NationalList: null });
    expect(screen.getByRole("checkbox", { name: /SG ILCA 6/ })).toBeChecked();
    expect(screen.getByText(/Matched the official list by name/)).toBeInTheDocument();
  });

  it("lets one sailor hold Optimist and both ILCA tags", async () => {
    const user = userEvent.setup();
    const { onChange } = renderFields({
      currentFleet: "Series",
      goldEntryDate: "2024-01-01",
      silverEntryDate: "2023-01-01",
      ilca4NationalList: true,
    });
    expect(screen.getByRole("checkbox", { name: /SG Optimist/ })).toBeChecked();
    expect(screen.getByRole("radio", { name: "Gold" })).toBeChecked();
    expect(screen.getByRole("checkbox", { name: /SG ILCA 4/ })).toBeChecked();
    await user.click(screen.getByRole("checkbox", { name: /SG ILCA 6/ }));
    expect(onChange.mock.calls[0][0].ilca6NationalList).toBe(true);
    expect(onChange.mock.calls[0][0].ilca4NationalList).toBe(true);
    expect(onChange.mock.calls[0][0].currentFleet).toBe("Series");
  });
});
