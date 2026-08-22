"use client";

import { useCallback, useEffect, useState } from "react";
import type { User } from "@supabase/supabase-js";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { isProductChangelogUnread } from "@/lib/productChangelog";

export type AdminRole = "superadmin" | "coach" | "sailor" | "parent";

/**
 * Session + role for the admin shell. Role comes from `/api/admin/me`
 * (profiles), never from user_metadata.
 */
export function useAdminAuth() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [adminRole, setAdminRole] = useState<AdminRole>("sailor");
  const [lastSeenProductChangelogAt, setLastSeenProductChangelogAt] = useState<
    string | null
  >(null);

  const loadRole = useCallback(async () => {
    try {
      const supabase = createBrowserSupabase();
      const {
        data: { session },
      } = await supabase.auth.getSession();
      if (!session?.user) {
        setUser(null);
        setAdminRole("sailor");
        setLastSeenProductChangelogAt(null);
        setLoading(false);
        return;
      }
      setUser(session.user);
      try {
        const res = await fetch("/api/admin/me");
        const data = await res.json();
        setAdminRole((data.role || "sailor") as AdminRole);
        setLastSeenProductChangelogAt(
          typeof data.lastSeenProductChangelogAt === "string"
            ? data.lastSeenProductChangelogAt
            : null
        );
      } catch {
        setAdminRole("sailor");
      }
    } catch {
      setUser(null);
      setAdminRole("sailor");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    let subscription: { unsubscribe: () => void } | undefined;

    try {
      const supabase = createBrowserSupabase();
      // Initial auth synchronization; later calls come from the auth subscription.
      // eslint-disable-next-line react-hooks/set-state-in-effect
      void loadRole();
      const { data } = supabase.auth.onAuthStateChange(() => {
        void loadRole();
      });
      subscription = data.subscription;
    } catch {
      setLoading(false);
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
    adminRole,
    isSuperadmin,
    lastSeenProductChangelogAt,
    productChangelogUnread,
    markProductChangelogSeen,
    refreshAuth: loadRole,
  };
}
