"use client";

import { useState, type ReactNode } from "react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

/**
 * Scoped to the admin shell — public pages do not pay for the query client.
 */
export function AdminQueryProvider({ children }: { children: ReactNode }) {
  const [client] = useState(
    () =>
      new QueryClient({
        defaultOptions: {
          queries: {
            staleTime: 60_000,
            gcTime: 5 * 60_000,
            refetchOnWindowFocus: false,
            retry: (failureCount, error) => {
              if (failureCount >= 1) return false;
              if ((error as Error)?.name === "AbortError") return false;
              const msg = (error as Error)?.message || "";
              if (
                msg.includes("401") ||
                msg.includes("403") ||
                msg.includes("404") ||
                msg.includes("Unauthorized") ||
                msg.includes("Forbidden") ||
                msg.includes("aborted")
              ) {
                return false;
              }
              return true;
            },
          },
        },
      })
  );

  return <QueryClientProvider client={client}>{children}</QueryClientProvider>;
}
