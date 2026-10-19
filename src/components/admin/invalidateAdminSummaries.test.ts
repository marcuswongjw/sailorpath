import { QueryClient } from "@tanstack/react-query";
import { describe, expect, it, vi } from "vitest";
import { invalidateAdminSummaries } from "./invalidateAdminSummaries";
import { adminQueryKeys } from "./adminQueryKeys";
describe("derived admin summaries", () => {
  it("invalidates event checks, duplicates, stats and audit activity after a write", () => {
    const client = new QueryClient();
    const invalidate = vi.spyOn(client, "invalidateQueries");
    invalidateAdminSummaries(client);
    for (const key of [
      adminQueryKeys.overview(),
      adminQueryKeys.duplicates(),
      adminQueryKeys.stats(),
      adminQueryKeys.recentChanges(),
      ["admin", "audit"],
    ])
      expect(invalidate).toHaveBeenCalledWith({ queryKey: key });
  });
});
