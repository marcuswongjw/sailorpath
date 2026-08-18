/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { EquipmentEmptyState } from "./EquipmentEmptyState";

describe("EquipmentEmptyState UI", () => {
  it("shows owner quick-add actions", async () => {
    const user = userEvent.setup();
    const onQuickAdd = vi.fn();
    const onOpenFullRig = vi.fn();

    render(
      <EquipmentEmptyState
        isOwner
        onQuickAdd={onQuickAdd}
        onOpenFullRig={onOpenFullRig}
      />
    );

    expect(screen.getByText(/build your gear bag/i)).toBeInTheDocument();
    await user.click(screen.getByRole("button", { name: /\+ sail/i }));
    expect(onQuickAdd).toHaveBeenCalledWith("sail");

    await user.click(screen.getByRole("button", { name: /\+ full rig set/i }));
    expect(onOpenFullRig).toHaveBeenCalled();
  });

  it("hides owner actions for public viewers", () => {
    render(
      <EquipmentEmptyState
        isOwner={false}
        onQuickAdd={() => {}}
        onOpenFullRig={() => {}}
      />
    );

    expect(screen.getByText(/no equipment logged yet/i)).toBeInTheDocument();
    expect(screen.queryByRole("button")).not.toBeInTheDocument();
  });
});
