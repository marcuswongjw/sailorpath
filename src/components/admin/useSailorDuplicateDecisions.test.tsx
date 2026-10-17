// @vitest-environment jsdom
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { fireEvent, render, screen, waitFor } from "@testing-library/react";
import { afterEach, describe, expect, it, vi } from "vitest";
import { useSailorDuplicateDecisions } from "./useSailorDuplicateDecisions";
const feedback = vi.hoisted(() => ({ success: vi.fn(), error: vi.fn() }));
vi.mock("@/components/ui/FeedbackProvider", () => ({ useFeedback: () => ({ toast: feedback }) }));
function Probe() {
  const r = useSailorDuplicateDecisions();
  return <><p>{r.loading ? "Loading" : `${r.decisions.length} confirmed different`}</p>
    <button onClick={() => void r.decide("a", "b")}>Confirm different</button>
    <button onClick={() => void r.decide("a", "b", false)}>Reopen</button></>;
}
const mount = () => render(<QueryClientProvider client={new QueryClient({ defaultOptions: { queries: { retry: false }, mutations: { retry: false } } })}><Probe /></QueryClientProvider>);
afterEach(() => { vi.unstubAllGlobals(); vi.restoreAllMocks(); });
describe("shared sailor identity decisions", () => {
  it("loads a saved decision after a fresh client mount and persists an explicit reopen", async () => {
    let separate = false;
    vi.stubGlobal("fetch", vi.fn(async (_url, options) => {
      if (options?.method === "POST") { separate = JSON.parse(options.body).separate; return Response.json({ ok: true }); }
      return Response.json({ decisions: separate ? [{ aId: "a", bId: "b", pairKey: "a|b", aName: "A", bName: "B", reason: "Verified distinct people." }] : [] });
    }));
    vi.spyOn(window, "prompt").mockReturnValue("Verified distinct people from official evidence.");
    const first = mount(); await screen.findByText("0 confirmed different");
    fireEvent.click(screen.getByText("Confirm different")); await screen.findByText("1 confirmed different");
    first.unmount(); mount(); await screen.findByText("1 confirmed different");
    fireEvent.click(screen.getByText("Reopen")); await screen.findByText("0 confirmed different");
  });
  it("does not hide a pair when saving fails", async () => {
    vi.stubGlobal("fetch", vi.fn(async (_url, options) => options?.method === "POST"
      ? Response.json({ error: "Save failed" }, { status: 500 }) : Response.json({ decisions: [] })));
    vi.spyOn(window, "prompt").mockReturnValue("Verified distinct people from official evidence.");
    mount(); await screen.findByText("0 confirmed different");
    fireEvent.click(screen.getByText("Confirm different"));
    await waitFor(() => expect(feedback.error).toHaveBeenCalledWith("Save failed"));
    expect(screen.getByText("0 confirmed different")).toBeInTheDocument();
  });
});
