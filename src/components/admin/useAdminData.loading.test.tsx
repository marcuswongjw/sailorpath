// @vitest-environment jsdom
import React from "react";
import { act, cleanup, renderHook, waitFor } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import type { AdminActiveTab, AdminEditSubTab, AdminEventsView } from "./adminNav";
import { adminQueryKeys } from "./adminQueryKeys";
const reads = vi.hoisted(() => ({
  fetchAdminSailors: vi.fn(), fetchAdminRegattas: vi.fn(), fetchAdminRegattaEvents: vi.fn(),
  fetchAdminResultsAll: vi.fn(), fetchAdminResultsForRegatta: vi.fn(),
}));
vi.mock("./adminFetch", () => reads);
import { useAdminData } from "./useAdminData";

function mount(initial: { activeTab: AdminActiveTab; editSubTab?: AdminEditSubTab; eventsView?: AdminEventsView }) {
  const client = new QueryClient({ defaultOptions: { queries: { retry: false, staleTime: 60_000, gcTime: 0 } } });
  const hook = renderHook((props: typeof initial) => useAdminData({ isSuperadmin: true, editSubTab: "sailors", ...props }), {
    initialProps: initial,
    wrapper: ({ children }: { children: React.ReactNode }) => <QueryClientProvider client={client}>{children}</QueryClientProvider>,
  });
  return { ...hook, client };
}
beforeEach(() => { for (const read of Object.values(reads)) read.mockReset().mockResolvedValue([]); });
afterEach(cleanup);

describe("workspace loading boundaries", () => {
  it.each(["overview", "ops", "stats"] as const)("does not download full lists for %s", (activeTab) => {
    const { result } = mount({ activeTab });
    expect(result.current.dataReady).toBe(true);
    for (const read of Object.values(reads)) expect(read).not.toHaveBeenCalled();
  });
  it.each(["missing-results", "attention", "ready-to-publish"] as const)("keeps %s on the compact checks API", (eventsView) => {
    const { result } = mount({ activeTab: "regattas", eventsView });
    expect(result.current.dataReady).toBe(true);
    for (const read of Object.values(reads)) expect(read).not.toHaveBeenCalled();
  });
  it("loads only regattas for the event index and readiness views", async () => {
    const { result } = mount({ activeTab: "regattas", eventsView: "readiness" });
    act(() => result.current.setSelectedRegattaIdForResultEdit("sheet-1"));
    await waitFor(() => expect(result.current.dataReady).toBe(true));
    expect(reads.fetchAdminRegattas).toHaveBeenCalledTimes(1);
    expect(reads.fetchAdminSailors).not.toHaveBeenCalled();
    expect(reads.fetchAdminResultsAll).not.toHaveBeenCalled();
    expect(reads.fetchAdminResultsForRegatta).not.toHaveBeenCalled();
  });
  it("loads the selected sheet's details without downloading all results", async () => {
    const { result } = mount({ activeTab: "regattas", eventsView: "results" });
    act(() => result.current.setSelectedRegattaIdForResultEdit("sheet-1"));
    await waitFor(() => expect(result.current.resultsEditorReady).toBe(true));
    expect(reads.fetchAdminResultsForRegatta).toHaveBeenCalledWith("sheet-1", true, { signal: expect.any(AbortSignal) });
    expect(reads.fetchAdminResultsAll).not.toHaveBeenCalled();
  });
  it("keeps the event workspace ready while a new sheet's rows are loading", async () => {
    reads.fetchAdminResultsForRegatta.mockReturnValue(new Promise(() => {}));
    const { result } = mount({ activeTab: "regattas", eventsView: "results" });
    await waitFor(() => expect(result.current.loadedData.regattas).toBe(true));
    act(() => result.current.setSelectedRegattaIdForResultEdit("sheet-1"));
    expect(result.current.dataReady).toBe(true);
    expect(result.current.resultsEditorReady).toBe(false);
    expect(result.current.dataLoading).toBe(true);
  });
  it("does not show a previous workspace's error after navigating away", async () => {
    reads.fetchAdminSailors.mockRejectedValue(new Error("Sailors unavailable"));
    const { result, rerender } = mount({ activeTab: "edit" });
    await waitFor(() => expect(result.current.dataLoadError).toBe("Sailors unavailable"));
    expect(result.current.dataReady).toBe(false);
    rerender({ activeTab: "overview" });
    expect(result.current.dataLoadError).toBeNull();
    expect(result.current.dataLoading).toBe(false);
    expect(result.current.dataReady).toBe(true);
  });
  it("retries only the active workspace and recovers from initial failure", async () => {
    reads.fetchAdminSailors.mockRejectedValueOnce(new Error("Unavailable")).mockResolvedValue([]);
    const { result } = mount({ activeTab: "edit" });
    await waitFor(() => expect(result.current.dataLoadError).toBe("Unavailable"));
    await act(async () => { await result.current.retryActiveData(); });
    await waitFor(() => expect(result.current.dataReady).toBe(true));
    expect(result.current.dataLoadError).toBeNull();
    expect(reads.fetchAdminSailors).toHaveBeenCalledTimes(2);
    expect(reads.fetchAdminRegattas).not.toHaveBeenCalled();
  });
  it("keeps cached rows visible when a background refresh fails", async () => {
    reads.fetchAdminSailors.mockResolvedValueOnce([{ id: "s1", name: "Sailor" }]).mockRejectedValue(new Error("Offline"));
    const { result } = mount({ activeTab: "edit" });
    await waitFor(() => expect(result.current.dataReady).toBe(true));
    await act(async () => { await result.current.retryActiveData(); });
    await waitFor(() => expect(result.current.dataLoadError).toBe("Offline"));
    expect(result.current.dataReady).toBe(true);
    expect(result.current.sailorList).toHaveLength(1);
  });
  it("an explicit refresh reads from the server even with a fresh cached result list", async () => {
    const { result, client } = mount({ activeTab: "overview" });
    client.setQueryData(adminQueryKeys.resultsAll(), [{ id: "old" }]);
    reads.fetchAdminResultsAll.mockResolvedValue([{ id: "new" }]);
    await act(async () => { await result.current.refreshResultsList(); });
    expect(reads.fetchAdminResultsAll).toHaveBeenCalledOnce();
    expect(client.getQueryData(adminQueryKeys.resultsAll())).toEqual([{ id: "new" }]);
  });
  it("surfaces explicit refresh failures to the results modal", async () => {
    const { result } = mount({ activeTab: "overview" });
    reads.fetchAdminResultsAll.mockRejectedValue(new Error("Results unavailable"));
    await expect(result.current.refreshResultsList()).rejects.toThrow("Results unavailable");
  });
});
