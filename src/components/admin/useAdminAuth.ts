"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { isProductChangelogUnread } from "@/lib/productChangelog";

export type AdminRole = "superadmin" | "coach" | "sailor" | "parent";
export type InitialAdminAuth = {
  id: string;
  email: string | null;
  role: AdminRole;
};
type AdminUser = { id: string; email?: string | null };

export type UseAdminAuthReturn = {
  user: AdminUser | null;
  loading: boolean;
  isRevalidating: boolean;
  adminRole: AdminRole;
  isSuperadmin: boolean;
  authUnavailable: boolean;
  authError: string | null;
  lastSeenProductChangelogAt: string | null;
  productChangelogUnread: boolean;
  markProductChangelogSeen: () => void;
  refreshAuth: () => Promise<void>;
};

/**
 * Session + role for the admin shell. Role comes from `/api/admin/me`
 * (profiles), never from user_metadata.
 *
 * Distinguishes verified unauthorized/forbidden responses from temporary
 * backend/network failures, ensuring valid sessions are never downgraded
 * during transient database or connection stalls.
 */
export function useAdminAuth(initialAuth?: InitialAdminAuth): UseAdminAuthReturn {
  const [user, setUser] = useState<AdminUser | null>(
    initialAuth ? { id: initialAuth.id, email: initialAuth.email } : null
  );
  const [loading, setLoading] = useState(!initialAuth);
  const [isRevalidating, setIsRevalidating] = useState(false);
  const [adminRole, setAdminRole] = useState<AdminRole>(
    initialAuth?.role ?? "sailor"
  );
  const [authUnavailable, setAuthUnavailable] = useState(false);
  const [authError, setAuthError] = useState<string | null>(null);
  const [lastSeenProductChangelogAt, setLastSeenProductChangelogAt] = useState<
    string | null
  >(null);

  const inFlightRef = useRef<Promise<void> | null>(null);

  const loadRole = useCallback(async () => {
    if (inFlightRef.current) {
      return inFlightRef.current;
    }

    const task = (async () => {
      setIsRevalidating(true);
      try {
        let sessionUser: AdminUser | null = null;
        try {
          const supabase = createBrowserSupabase();
          const {
            data: { session },
          } = await supabase.auth.getSession();
          if (session?.user) {
            sessionUser = { id: session.user.id, email: session.user.email ?? null };
          }
        } catch {
          // Supabase browser client failed (e.g. cookie or storage issue); proceed with server probe
        }

        let res: Response;
        try {
          res = await fetch("/api/admin/me", {
            headers: { Accept: "application/json" },
            cache: "no-store",
          });
        } catch (fetchErr) {
          // Network failure or client offline
          setAuthUnavailable(true);
          setAuthError(
            fetchErr instanceof Error ? fetchErr.message : "Network error contacting server"
          );
          if (sessionUser) {
            setUser((prev) => prev ?? sessionUser);
          }
          return;
        }

        if (res.ok) {
          const data = await res.json().catch(() => null);
          if (!data || !data.user || !data.role) {
            // Server explicitly reported unauthenticated (no active session)
            setUser(null);
            setAdminRole("sailor");
            setLastSeenProductChangelogAt(null);
            setAuthUnavailable(false);
            setAuthError(null);
          } else {
            // Server verified authenticated session & role
            setUser({ id: data.user.id, email: data.user.email ?? null });
            setAdminRole((data.role || "sailor") as AdminRole);
            setLastSeenProductChangelogAt(
              typeof data.lastSeenProductChangelogAt === "string"
                ? data.lastSeenProductChangelogAt
                : null
            );
            setAuthUnavailable(false);
            setAuthError(null);
          }
          return;
        }

        if (res.status === 401) {
          // Verified unauthorized / session expired
          setUser(null);
          setAdminRole("sailor");
          setLastSeenProductChangelogAt(null);
          setAuthUnavailable(false);
          setAuthError("Unauthorized");
          return;
        }

        if (res.status === 403) {
          // Verified forbidden - authenticated but lacks admin privileges
          setAdminRole("sailor");
          setAuthUnavailable(false);
          setAuthError("Admin access required");
          return;
        }

        // Temporary server failure (e.g. 503 Service Unavailable, 500, 502, 504)
        setAuthUnavailable(true);
        setAuthError(
          res.status === 503
            ? "Database temporarily unavailable"
            : `Authentication service temporarily unavailable (${res.status})`
        );
        // Do NOT downgrade adminRole or user if they were already authenticated
        if (sessionUser) {
          setUser((prev) => prev ?? sessionUser);
        }
      } catch (err) {
        setAuthUnavailable(true);
        setAuthError(
          err instanceof Error ? err.message : "Unexpected error verifying authentication"
        );
      } finally {
        setLoading(false);
        setIsRevalidating(false);
        inFlightRef.current = null;
      }
    })();

    inFlightRef.current = task;
    return task;
  }, []);

  useEffect(() => {
    let subscription: { unsubscribe: () => void } | undefined;

    try {
      const supabase = createBrowserSupabase();
      // Initial auth synchronization; later calls come from the auth subscription.
      void loadRole();
      const { data } = supabase.auth.onAuthStateChange((event) => {
        if (event === "SIGNED_OUT") {
          setUser(null);
          setAdminRole("sailor");
          setLastSeenProductChangelogAt(null);
          setAuthUnavailable(false);
          setAuthError(null);
          return;
        }
        void loadRole();
      });
      subscription = data.subscription;
    } catch {
      queueMicrotask(() => {
        setLoading(false);
      });
    }

    return () => subscription?.unsubscribe();
  }, [loadRole]);

  const isSuperadmin = adminRole === "superadmin";
  const productChangelogUnread = isProductChangelogUnread(
    lastSeenProductChangelogAt
  );

  const markProductChangelogSeen = useCallback(() => {
    setLastSeenProductChangelogAt(new Date().toISOString());
  }, []);

  return {
    user,
    loading,
    isRevalidating,
    adminRole,
    isSuperadmin,
    authUnavailable,
    authError,
    lastSeenProductChangelogAt,
    productChangelogUnread,
    markProductChangelogSeen,
    refreshAuth: loadRole,
  };
}
