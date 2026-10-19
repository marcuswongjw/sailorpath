// @vitest-environment jsdom
import { act, cleanup, renderHook } from "@testing-library/react";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
const fetchRegattas = vi.hoisted(() => vi.fn());
vi.mock("./adminFetch", () => ({ fetchAdminRegattas: fetchRegattas }));
import { useAdminCompetitions } from "./useAdminCompetitions";
beforeEach(() => fetchRegattas.mockReset().mockResolvedValue([]));
afterEach(cleanup);
describe("sailor results refresh", () => {
  it("exposes failures and clears them after a successful retry", async () => {
    const refreshResultsList = vi.fn().mockRejectedValueOnce(new Error("Results unavailable")).mockResolvedValue(undefined);
    const { result } = renderHook(() => useAdminCompetitions({ refreshResultsList, setRegattaList: vi.fn(), setEditingResultId: vi.fn() }));
    await act(async () => { await result.current.openSailorResults("sailor-1"); });
    expect(result.current.competitionsError).toBe("Results unavailable");
    expect(result.current.competitionsLoading).toBe(false);
    await act(async () => { await result.current.openSailorResults("sailor-1"); });
    expect(result.current.competitionsError).toBeNull();
    expect(refreshResultsList).toHaveBeenCalledTimes(2);
  });
  it("does not let an older request clear the new modal's loading state", async () => {
    let finishOld!: () => void;
    let finishNew!: () => void;
    const refreshResultsList = vi.fn()
      .mockImplementationOnce(() => new Promise<void>(resolve => { finishOld = resolve; }))
      .mockImplementationOnce(() => new Promise<void>(resolve => { finishNew = resolve; }));
    const { result } = renderHook(() => useAdminCompetitions({ refreshResultsList, setRegattaList: vi.fn(), setEditingResultId: vi.fn() }));
    let old!: Promise<void>; let next!: Promise<void>;
    act(() => { old = result.current.openSailorResults("old"); });
    act(() => { next = result.current.openSailorResults("new"); });
    await act(async () => { finishOld(); await old; });
    expect(result.current.competitionsLoading).toBe(true);
    expect(result.current.competitionsSailorId).toBe("new");
    await act(async () => { finishNew(); await next; });
    expect(result.current.competitionsLoading).toBe(false);
  });
});
