"use client";

import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
  type ReactNode,
} from "react";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import {
  VIEW_AS_STORAGE_KEY,
  parseViewAs,
  type ViewAs,
} from "@/lib/viewAs";

export type OwnedSailor = {
  id: string;
  name: string;
  handle: string;
  /** parent | sailor | other — how this account relates to the athlete */
  ownerRelation?: string | null;
};

type AccountState = {
  email: string | null;
  role: string | null;
  isSuperadmin: boolean;
  /**
   * Superadmin only: working as admin tools vs parent UX.
   * Capability stays superadmin either way.
   */
  viewAs: ViewAs;
  setViewAs: (mode: ViewAs) => Promise<void>;
  owned: OwnedSailor[];
  /** Auth + first account load finished */
  ready: boolean;
  /** Re-fetch /api/account (e.g. after claim) */
  refresh: () => Promise<void>;
  signOut: () => Promise<void>;
};

const AccountContext = createContext<AccountState | null>(null);

/**
 * Single shared /api/account fetch for header, footer, and any consumer.
 * Avoids double network on every page.
 */
export function AccountProvider({ children }: { children: ReactNode }) {
  const [email, setEmail] = useState<string | null>(null);
  const [role, setRole] = useState<string | null>(null);
  const [isSuperadmin, setIsSuperadmin] = useState(false);
  const [viewAs, setViewAsState] = useState<ViewAs>("admin");
  const [owned, setOwned] = useState<OwnedSailor[]>([]);
  const [ready, setReady] = useState(false);

  const loadAccount = useCallback(async () => {
    try {
      const res = await fetch("/api/account", { credentials: "include" });
      if (!res.ok) {
        setOwned([]);
        setRole(null);
        setIsSuperadmin(false);
        setViewAsState("admin");
        return;
      }
      const data = await res.json();
      setOwned(data.owned || []);
      if (data.email) setEmail(data.email);
      const r = data.role || null;
      setRole(r);
      const superA = r === "superadmin" || Boolean(data.isSuperadmin);
      setIsSuperadmin(superA);
      if (superA) {
        const mode = parseViewAs(data.viewAs);
        setViewAsState(mode);
        try {
          localStorage.setItem(VIEW_AS_STORAGE_KEY, mode);
        } catch {
          /* ignore */
        }
      } else {
        setViewAsState("admin");
      }
    } catch {
      setOwned([]);
      setRole(null);
      setIsSuperadmin(false);
      setViewAsState("admin");
    }
  }, []);

  useEffect(() => {
    let unsub: (() => void) | undefined;
    let cancelled = false;

    (async () => {
      try {
        // Hydrate mode early from localStorage for snappy UI
        try {
          const stored = localStorage.getItem(VIEW_AS_STORAGE_KEY);
          if (stored) setViewAsState(parseViewAs(stored));
        } catch {
          /* ignore */
        }

        const supabase = createBrowserSupabase();
        const {
          data: { session },
        } = await supabase.auth.getSession();
        if (cancelled) return;
        setEmail(session?.user?.email ?? null);
        setReady(true);
        if (session?.user) {
          await loadAccount();
        } else {
          setIsSuperadmin(false);
          setOwned([]);
          setRole(null);
          setViewAsState("admin");
        }

        const { data } = supabase.auth.onAuthStateChange((_e, s) => {
          setEmail(s?.user?.email ?? null);
          if (s?.user) void loadAccount();
          else {
            setIsSuperadmin(false);
            setOwned([]);
            setRole(null);
            setViewAsState("admin");
          }
        });
        unsub = () => data.subscription.unsubscribe();
      } catch {
        if (!cancelled) setReady(true);
      }
    })();

    return () => {
      cancelled = true;
      unsub?.();
    };
  }, [loadAccount]);

  const setViewAs = useCallback(
    async (mode: ViewAs) => {
      const next = parseViewAs(mode);
      setViewAsState(next);
      try {
        localStorage.setItem(VIEW_AS_STORAGE_KEY, next);
      } catch {
        /* ignore */
      }
      try {
        await fetch("/api/account/view-as", {
          method: "POST",
          credentials: "include",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ viewAs: next }),
        });
      } catch {
        /* cookie best-effort; local state already set */
      }
      // Soft refresh so SSR pages pick up cookie on next navigation
      if (typeof window !== "undefined") {
        window.dispatchEvent(
          new CustomEvent("sp-view-as", { detail: { viewAs: next } })
        );
      }
    },
    []
  );

  const signOut = useCallback(async () => {
    try {
      await createBrowserSupabase().auth.signOut();
    } catch {
      /* ignore */
    }
    window.location.assign("/");
  }, []);

  const value = useMemo<AccountState>(
    () => ({
      email,
      role,
      isSuperadmin,
      viewAs: isSuperadmin ? viewAs : "admin",
      setViewAs,
      owned,
      ready,
      refresh: loadAccount,
      signOut,
    }),
    [
      email,
      role,
      isSuperadmin,
      viewAs,
      setViewAs,
      owned,
      ready,
      loadAccount,
      signOut,
    ]
  );

  return (
    <AccountContext.Provider value={value}>{children}</AccountContext.Provider>
  );
}

export function useAccount(): AccountState {
  const ctx = useContext(AccountContext);
  if (!ctx) {
    throw new Error("useAccount must be used within AccountProvider");
  }
  return ctx;
}

/** Safe for optional consumers outside provider (returns guest defaults). */
export function useAccountOptional(): AccountState | null {
  return useContext(AccountContext);
}
