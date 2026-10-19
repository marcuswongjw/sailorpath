// @vitest-environment jsdom
import { cleanup, renderHook, act } from "@testing-library/react";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import type { SailorAdmin } from "@/types/sailor";

const decisions = vi.hoisted(() => ({ keys: new Set<string>(), subscribe: vi.fn() }));
vi.mock("./useSailorDuplicateDecisions", () => ({
  useSailorDuplicateDecisions: (enabled: boolean) => {
    decisions.subscribe(enabled);
    return { keys: decisions.keys };
  },
}));
vi.mock("@/components/ui/FeedbackProvider", () => ({
  useFeedback: () => ({ toast: {}, confirm: vi.fn() }),
}));
vi.mock("@/lib/nameMatch", async (importOriginal) => {
  const actual = await importOriginal<typeof import("@/lib/nameMatch")>();
  return { ...actual, findDuplicateSailorPairs: vi.fn(actual.findDuplicateSailorPairs) };
});
import { findDuplicateSailorPairs } from "@/lib/nameMatch";
import { useAdminSailors } from "./useAdminSailors";

const sailorList = [
  { id: "a", name: "Alice Tan", club: "East" },
  { id: "b", name: "Tan Alice", club: "West" },
  { id: "c", name: "Zachary Wilson", club: "North" },
] as SailorAdmin[];
const args = {
  isSuperadmin: true,
  sailorList,
  setSailorList: vi.fn(),
  resultsList: [],
  setResultsList: vi.fn(),
  regattaListLength: 0,
  refreshResultsList: vi.fn(),
  openSailorResultsBase: vi.fn(),
  competitionsSailorId: null,
  setCompetitionsSailorId: vi.fn(),
  loadRankingSummary: false,
};

beforeEach(() => { vi.clearAllMocks(); decisions.keys = new Set(); localStorage.clear(); });
afterEach(cleanup);

describe("admin sailor directory performance", () => {
  it("loads and filters a large directory without scanning pairs or subscribing to decisions", () => {
    const roster = Array.from({ length: 1500 }, (_, i) => ({
      ...sailorList[0], id: String(i), name: `Sailor ${i}`,
    }));
    const { result } = renderHook(() => useAdminSailors({ ...args, sailorList: roster }));
    expect(result.current.panelProps.sortedDbSailors).toHaveLength(1500);
    act(() => result.current.panelProps.setDbSearch("Sailor 1499"));
    expect(result.current.panelProps.sortedDbSailors.map(s => s.id)).toEqual(["1499"]);
    expect(findDuplicateSailorPairs).not.toHaveBeenCalled();
    expect(decisions.subscribe.mock.calls.every(([enabled]) => !enabled)).toBe(true);
  });

  it("keeps filtered and sorted lists stable when selection changes", () => {
    const { result } = renderHook(() => useAdminSailors(args));
    const { filteredDbSailors, sortedDbSailors } = result.current.panelProps;
    act(() => result.current.panelProps.setSelectedSailors(["a"]));
    expect(result.current.panelProps.filteredDbSailors).toBe(filteredDbSailors);
    expect(result.current.panelProps.sortedDbSailors).toBe(sortedDbSailors);
  });

  it("scans on direct duplicate-review navigation and excludes confirmed different sailors", () => {
    decisions.keys = new Set(["a|b"]);
    const { result } = renderHook(() => useAdminSailors({ ...args, loadDuplicateReview: true }));
    expect(findDuplicateSailorPairs).toHaveBeenCalledTimes(1);
    expect(decisions.subscribe).toHaveBeenLastCalledWith(true);
    expect(result.current.panelProps.duplicatePairs).toEqual([]);
  });

  it("starts matching on entering duplicate review and stops on returning to the directory", () => {
    const { result, rerender } = renderHook(({ review, roster }) => useAdminSailors({
      ...args, sailorList: roster, loadDuplicateReview: review,
    }), { initialProps: { review: false, roster: sailorList } });
    expect(findDuplicateSailorPairs).not.toHaveBeenCalled();
    rerender({ review: true, roster: sailorList });
    expect(result.current.panelProps.duplicatePairs).toEqual([
      expect.objectContaining({ a: expect.objectContaining({ id: "a" }), b: expect.objectContaining({ id: "b" }), similarity: 1 }),
    ]);
    expect(findDuplicateSailorPairs).toHaveBeenCalledTimes(1);
    act(() => result.current.panelProps.setSelectedSailors(["a", "b"]));
    expect(findDuplicateSailorPairs).toHaveBeenCalledTimes(1);
    rerender({ review: false, roster: [...sailorList] });
    expect(findDuplicateSailorPairs).toHaveBeenCalledTimes(1);
    expect(decisions.subscribe).toHaveBeenLastCalledWith(false);
  });
});
