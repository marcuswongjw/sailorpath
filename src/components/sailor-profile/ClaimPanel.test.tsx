/** @vitest-environment jsdom */
import { describe, expect, it, vi, beforeEach } from "vitest";
import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { ClaimPanel } from "./ClaimPanel";

vi.mock("@/lib/clientUsage", () => ({
  getAcquisition: () => ({ source: "direct", device: "desktop", refHost: null }),
  getUsageSessionId: () => "sess-test",
  getVisitorId: () => "vid-test",
}));

async function fillClaimForm(
  user: ReturnType<typeof userEvent.setup>,
  noteText: string
) {
  await user.selectOptions(
    screen.getByRole("combobox"),
    "parent"
  );
  const note = screen.getByPlaceholderText(/parent of test sailor/i);
  await user.clear(note);
  await user.type(note, noteText);
}

describe("ClaimPanel UI", () => {
  beforeEach(() => {
    vi.restoreAllMocks();
  });

  it("keeps submit disabled until relation and note are ready", async () => {
    const user = userEvent.setup();
    render(
      <ClaimPanel
        sailorId="s1"
        sailorName="Test Sailor"
        sailNumber="SGP 115"
        onClose={() => {}}
        onResult={() => {}}
      />
    );

    const button = screen.getByRole("button", { name: /submit claim/i });
    const note = screen.getByPlaceholderText(/parent of test sailor/i);
    expect(button).toBeDisabled();

    await user.type(note, "Parent of Test Sailor at CSC");
    expect(button).toBeDisabled();

    await user.selectOptions(screen.getByRole("combobox"), "parent");
    expect(button).toBeEnabled();
  });

  it("submits a claim and reports pending on success", async () => {
    const user = userEvent.setup();
    const onClose = vi.fn();
    const onResult = vi.fn();

    vi.stubGlobal(
      "fetch",
      vi.fn(async (input: RequestInfo | URL) => {
        const url = String(input);
        if (url.includes("ensure-profile")) {
          return new Response("{}", { status: 200 });
        }
        return new Response(
          JSON.stringify({
            ok: true,
            message: "Claim submitted for Test Sailor.",
          }),
          { status: 200 }
        );
      })
    );

    render(
      <ClaimPanel
        sailorId="s1"
        sailorName="Test Sailor"
        sailNumber="SGP 115"
        onClose={onClose}
        onResult={onResult}
      />
    );

    await fillClaimForm(user, "Parent of Test Sailor at CSC");
    await user.click(screen.getByRole("button", { name: /submit claim/i }));

    await waitFor(() => {
      expect(onResult).toHaveBeenCalledWith(
        "pending",
        "Claim submitted for Test Sailor."
      );
      expect(onClose).toHaveBeenCalled();
    });
  });

  it("surfaces API errors without closing", async () => {
    const user = userEvent.setup();
    const onClose = vi.fn();
    const onResult = vi.fn();

    vi.stubGlobal(
      "fetch",
      vi.fn(async (input: RequestInfo | URL) => {
        const url = String(input);
        if (url.includes("ensure-profile")) {
          return new Response("{}", { status: 200 });
        }
        return new Response(JSON.stringify({ error: "Already claimed" }), {
          status: 400,
        });
      })
    );

    render(
      <ClaimPanel
        sailorId="s1"
        sailorName="Test Sailor"
        onClose={onClose}
        onResult={onResult}
      />
    );

    await fillClaimForm(user, "Parent of Test Sailor at CSC");
    await user.click(screen.getByRole("button", { name: /submit claim/i }));

    await waitFor(() => {
      expect(onResult).toHaveBeenCalledWith("error", "Already claimed");
    });
    expect(onClose).not.toHaveBeenCalled();
  });
});
