// @vitest-environment jsdom
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { fireEvent, render, screen, waitFor } from "@testing-library/react";
import { afterEach, describe, expect, it, vi } from "vitest";
import { useSailorDuplicateDecisions } from "./useSailorDuplicateDecisions";
import { SailorDuplicateDecisionButton } from "./SailorDuplicateDecisionButton";
const feedback = vi.hoisted(() => ({ success: vi.fn(), error: vi.fn() }));
vi.mock("@/components/ui/FeedbackProvider", () => ({ useFeedback: () => ({ toast: feedback }) }));
function Probe() {
  const r = useSailorDuplicateDecisions();
  return <><p>{r.loading ? "Loading" : `${r.decisions.length} confirmed different`}</p>
    <SailorDuplicateDecisionButton a={{ id: "a", name: "A" }} b={{ id: "b", name: "B" }} />
    <SailorDuplicateDecisionButton a={{ id: "b", name: "B" }} b={{ id: "a", name: "A" }} separate={false} /></>;
}
const mount = () => render(<QueryClientProvider client={new QueryClient({ defaultOptions: { queries: { retry: false }, mutations: { retry: false } } })}><Probe /></QueryClientProvider>);
afterEach(() => { vi.unstubAllGlobals(); vi.restoreAllMocks(); vi.clearAllMocks(); });
const reason = "Verified distinct people from official evidence.";
const enterReason = () => fireEvent.change(screen.getByLabelText("Source evidence or reason (10–2000 characters)"), { target: { value: reason } });
describe("shared sailor identity decisions", () => {
  it("saves through the visible form, reloads on a fresh client, and explicitly reopens in reverse pair order", async () => {
    let separate = false;
    const fetch = vi.fn(async (_url, options) => {
      if (options?.method === "POST") { separate = JSON.parse(options.body).separate; return Response.json({ ok: true }); }
      return Response.json({ decisions: separate ? [{ aId: "a", bId: "b", pairKey: "a|b", aName: "A", bName: "B", reason }] : [] });
    });
    vi.stubGlobal("fetch", fetch);
    const prompt = vi.spyOn(window, "prompt");
    const first = mount(); await screen.findByText("0 confirmed different");
    fireEvent.click(screen.getByRole("button", { name: "Confirm different sailors" }));
    expect(screen.getByRole("form")).toHaveTextContent("A / B");
    enterReason(); fireEvent.click(screen.getByRole("button", { name: "Save as different sailors" }));
    await screen.findByText("1 confirmed different");
    expect(prompt).not.toHaveBeenCalled();
    first.unmount(); mount(); await screen.findByText("1 confirmed different");
    fireEvent.click(screen.getByRole("button", { name: "Reopen review" }));
    enterReason(); fireEvent.click(screen.getByRole("button", { name: "Save reopened review" }));
    await screen.findByText("0 confirmed different");
    expect(fetch.mock.calls.filter(c => c[1]?.method === "POST")).toHaveLength(2);
  });
  it("keeps the form, reason and visible error when saving fails and permits a retry", async () => {
    let fail = true;
    vi.stubGlobal("fetch", vi.fn(async (_url, options) => options?.method === "POST"
      ? fail ? Response.json({ error: "Save failed" }, { status: 500 }) : Response.json({ ok: true })
      : Response.json({ decisions: [] })));
    mount(); await screen.findByText("0 confirmed different");
    fireEvent.click(screen.getByRole("button", { name: "Confirm different sailors" })); enterReason();
    fireEvent.click(screen.getByRole("button", { name: "Save as different sailors" }));
    expect(await screen.findByRole("alert")).toHaveTextContent("Save failed");
    expect(screen.getByRole("textbox")).toHaveValue(reason);
    expect(screen.getByText("0 confirmed different")).toBeInTheDocument();
    expect(feedback.success).not.toHaveBeenCalled();
    fail = false; fireEvent.click(screen.getByRole("button", { name: "Save as different sailors" }));
    await waitFor(() => expect(screen.queryByRole("form")).not.toBeInTheDocument());
    expect(feedback.success).toHaveBeenCalled();
  });
  it("validates and cancels without writing a decision", async () => {
    const fetch = vi.fn<typeof globalThis.fetch>(async () => Response.json({ decisions: [] })); vi.stubGlobal("fetch", fetch);
    mount(); await screen.findByText("0 confirmed different");
    const open = screen.getByRole("button", { name: "Confirm different sailors" });
    fireEvent.click(open); fireEvent.click(screen.getByRole("button", { name: "Save as different sailors" }));
    expect(await screen.findByRole("alert")).toHaveTextContent("10–2000");
    fireEvent.click(screen.getByRole("button", { name: "Cancel" }));
    expect(screen.queryByRole("form")).not.toBeInTheDocument(); expect(open).toHaveFocus();
    expect(fetch.mock.calls.every(c => !(c[1] as RequestInit | undefined)?.method)).toBe(true);
  });
});
