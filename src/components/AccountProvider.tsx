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

export type OwnedSailor = { id: string; name: string; handle: string };

type AccountState = {
  email: string | null;
  role: string | null;
  isSuperadmin: boolean;
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
  const [owned, setOwned] = useState<OwnedSailor[]>([]);
  const [ready, setReady] = useState(false);

  const loadAccount = useCallback(async () => {
    try {
      const res = await fetch("/api/account", { credentials: "include" });
      if (!res.ok) {
        setOwned([]);
        setRole(null);
        setIsSuperadmin(false);
        return;
      }
      const data = await res.json();
      setOwned(data.owned || []);
      if (data.email) setEmail(data.email);
      const r = data.role || null;
      setRole(r);
      setIsSuperadmin(r === "superadmin" || Boolean(data.isSuperadmin));
    } catch {
      setOwned([]);
      setRole(null);
      setIsSuperadmin(false);
    }
  }, []);

  useEffect(() => {
    let unsub: (() => void) | undefined;
    let cancelled = false;

    (async () => {
      try {
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
        }

        const { data } = supabase.auth.onAuthStateChange((_e, s) => {
          setEmail(s?.user?.email ?? null);
          if (s?.user) void loadAccount();
          else {
            setIsSuperadmin(false);
            setOwned([]);
            setRole(null);
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
      owned,
      ready,
      refresh: loadAccount,
      signOut,
    }),
    [email, role, isSuperadmin, owned, ready, loadAccount, signOut]
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
