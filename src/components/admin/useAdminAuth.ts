"use client";

import { useState, useEffect } from "react";
import { createBrowserSupabase } from "@/lib/supabase/browser";

export type AdminRole = "superadmin" | "coach" | "sailor" | "parent";

/**
 * Session + role for the admin shell. Role comes from `/api/admin/me`
 * (profiles), never from user_metadata.
 */
export function useAdminAuth() {
  const [user, setUser] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [adminRole, setAdminRole] = useState<AdminRole>("sailor");

  useEffect(() => {
    let subscription: { unsubscribe: () => void } | undefined;

    async function loadRole() {
      try {
        const supabase = createBrowserSupabase();
        const {
          data: { session },
        } = await supabase.auth.getSession();
        if (!session?.user) {
          setUser(null);
          setAdminRole("sailor");
          setLoading(false);
          return;
        }
        setUser(session.user);
        try {
          const res = await fetch("/api/admin/me");
          const data = await res.json();
          setAdminRole((data.role || "sailor") as AdminRole);
        } catch {
          setAdminRole("sailor");
        }
      } catch {
        setUser(null);
        setAdminRole("sailor");
      } finally {
        setLoading(false);
      }
    }

    try {
      const supabase = createBrowserSupabase();
      loadRole();
      const { data } = supabase.auth.onAuthStateChange(() => {
        loadRole();
      });
      subscription = data.subscription;
    } catch {
      setLoading(false);
    }

    return () => subscription?.unsubscribe();
  }, []);

  const isSuperadmin = adminRole === "superadmin";

  return { user, loading, adminRole, isSuperadmin };
}
