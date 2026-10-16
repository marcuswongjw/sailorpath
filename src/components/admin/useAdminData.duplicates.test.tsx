// @vitest-environment jsdom
import React from "react";
import { renderHook, waitFor, cleanup } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
const fetchers = vi.hoisted(() => ({ sailors: vi.fn(), regattas: vi.fn(), results: vi.fn() }));
vi.mock("./adminFetch", () => ({ fetchAdminSailors: fetchers.sailors, fetchAdminRegattas: fetchers.regattas, fetchAdminResultsAll: fetchers.results, fetchAdminRegattaEvents: vi.fn(), fetchAdminResultsForRegatta: vi.fn() }));
import { useAdminData } from "./useAdminData";
const wrapper = () => {
  const client = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  return function TestProvider({ children }: { children: React.ReactNode }) { return <QueryClientProvider client={client}>{children}</QueryClientProvider>; };
};
beforeEach(() => { vi.clearAllMocks(); fetchers.sailors.mockResolvedValue([{ id: "sailor-1", name: "Example" }]); });
afterEach(cleanup);
describe("direct duplicate-review navigation", () => {
  it("loads sailors on a fresh duplicates link without loading all results or regattas", async () => {
    const { result } = renderHook(() => useAdminData({ isSuperadmin: true, activeTab: "edit", editSubTab: "duplicates" }), { wrapper: wrapper() });
    await waitFor(() => expect(result.current.loadedData.sailors).toBe(true));
    expect(result.current.sailorList).toHaveLength(1);
    expect(fetchers.sailors).toHaveBeenCalledTimes(1);
    expect(fetchers.regattas).not.toHaveBeenCalled();
    expect(fetchers.results).not.toHaveBeenCalled();
  });
  it("exposes an initial read failure without claiming that the list loaded empty", async () => {
    fetchers.sailors.mockRejectedValue(new Error("Sailor list unavailable"));
    const { result } = renderHook(() => useAdminData({ isSuperadmin: true, activeTab: "edit", editSubTab: "duplicates" }), { wrapper: wrapper() });
    await waitFor(() => expect(result.current.dataLoadError).toBe("Sailor list unavailable"));
    expect(result.current.loadedData.sailors).toBe(false);
  });
  it("does not fetch protected data without superadmin authorization", () => {
    renderHook(() => useAdminData({ isSuperadmin: false, activeTab: "edit", editSubTab: "duplicates" }), { wrapper: wrapper() });
    expect(fetchers.sailors).not.toHaveBeenCalled();
  });
});
