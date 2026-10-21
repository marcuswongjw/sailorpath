// @vitest-environment jsdom
import { fireEvent, render, screen } from "@testing-library/react";
import { afterEach, describe, expect, it, vi } from "vitest";
import { EventUrlAutofill } from "./EventUrlAutofill";
afterEach(() => vi.unstubAllGlobals());
describe("event URL autofill", () => {
  it("fills a draft without issuing a calendar write", async () => {
    const draft = { name: "Harbour Cup", startDate: "2026-10-23" };
    const fetcher = vi.fn<(url: string, options?: RequestInit) => Promise<Response>>(async () => Response.json({ draft, warnings: ["Confirm classes"] }));
    vi.stubGlobal("fetch", fetcher);
    const onExtract = vi.fn();
    render(<EventUrlAutofill onExtract={onExtract} onBusyChange={vi.fn()} />);
    fireEvent.change(screen.getByLabelText("Official event webpage"), { target: { value: "https://club.example/event" } });
    fireEvent.click(screen.getByRole("button", { name: "Extract event details" }));
    await screen.findByText(/Event details populated below/);
    expect(onExtract).toHaveBeenCalledWith(draft);
    expect(fetcher).toHaveBeenCalledTimes(1);
    expect(fetcher.mock.calls[0][0]).toBe("/api/admin/event-url");
    expect(screen.getByText("Confirm classes")).toBeInTheDocument();
  });
  it("preserves the current draft when extraction fails", async () => {
    vi.stubGlobal("fetch", vi.fn(async () => Response.json({ error: "Page unavailable" }, { status: 422 })));
    const onExtract = vi.fn();
    render(<EventUrlAutofill onExtract={onExtract} onBusyChange={vi.fn()} />);
    fireEvent.change(screen.getByLabelText("Official event webpage"), { target: { value: "https://club.example" } });
    fireEvent.click(screen.getByRole("button", { name: "Extract event details" }));
    await screen.findByText("Page unavailable");
    expect(onExtract).not.toHaveBeenCalled();
  });
});
