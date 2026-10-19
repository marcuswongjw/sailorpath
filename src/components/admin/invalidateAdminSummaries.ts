import type { QueryClient } from "@tanstack/react-query";
import { adminQueryKeys } from "./adminQueryKeys";

/** Derived work queues must follow writes just as the editable lists do. */
export function invalidateAdminSummaries(client: QueryClient) {
  for (const queryKey of [
    adminQueryKeys.overview(),
    adminQueryKeys.duplicates(),
    adminQueryKeys.stats(),
    adminQueryKeys.recentChanges(),
    ["admin", "audit"],
  ])
    void client.invalidateQueries({ queryKey });
}
