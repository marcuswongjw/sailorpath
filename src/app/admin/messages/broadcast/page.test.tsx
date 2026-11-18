// @vitest-environment jsdom
import { fireEvent, render, screen, waitFor } from "@testing-library/react";
import { beforeEach, expect, it, vi } from "vitest";
import AdminBroadcastPage from "./page";

vi.mock("@/components/admin/AdminSidebar", () => ({ AdminSidebar: () => null }));

beforeEach(() => { vi.restoreAllMocks(); });

it("invalidates the preview when a broadcast is edited", async () => {
  const fetchMock = vi.spyOn(globalThis, "fetch").mockResolvedValue(new Response(JSON.stringify({ text: "New results", buttonLabel: null, buttonUrl: null, audience: "all", audienceValue: "", targeted: 1 }), { status: 200 }));
  render(<AdminBroadcastPage />);
  fireEvent.change(screen.getByLabelText("Message"), { target: { value: "New results" } });
  fireEvent.click(screen.getByRole("button", { name: "Preview" }));
  await screen.findByRole("button", { name: "Send to 1" });
  expect(fetchMock).toHaveBeenCalledTimes(1);
  fireEvent.change(screen.getByLabelText("Message"), { target: { value: "Changed results" } });
  expect(screen.queryByRole("button", { name: "Send to 1" })).toBeNull();
  await waitFor(() => expect(fetchMock).toHaveBeenCalledTimes(1));
});
