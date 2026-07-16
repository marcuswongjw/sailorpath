"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { createBrowserSupabase } from "@/lib/supabase/browser";

type HeaderUser = {
  email: string | null;
};

export function SiteHeader() {
  const [user, setUser] = useState<HeaderUser | null>(null);
  const [ready, setReady] = useState(false);

  useEffect(() => {
    let cancelled = false;
    let unsub: (() => void) | undefined;

    async function load() {
      try {
        const supabase = createBrowserSupabase();
        const {
          data: { session },
        } = await supabase.auth.getSession();
        if (!cancelled) {
          setUser(session?.user ? { email: session.user.email ?? null } : null);
          setReady(true);
        }
        const { data } = supabase.auth.onAuthStateChange((_event, session) => {
          setUser(session?.user ? { email: session.user.email ?? null } : null);
        });
        unsub = () => data.subscription.unsubscribe();
      } catch {
        if (!cancelled) {
          setUser(null);
          setReady(true);
        }
      }
    }

    load();
    return () => {
      cancelled = true;
      unsub?.();
    };
  }, []);

  const signOut = async () => {
    try {
      const supabase = createBrowserSupabase();
      await supabase.auth.signOut();
    } catch {
      /* ignore */
    }
    setUser(null);
    window.location.assign("/");
  };

  return (
    <header className="sticky top-0 z-50 w-full border-b border-white/5 bg-[#090a0f]/80 backdrop-blur-md">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex h-16 items-center justify-between">
          <div className="flex items-center gap-8">
            <Link href="/" className="flex items-center gap-2 group">
              <span className="flex h-8 w-8 items-center justify-center rounded-lg bg-orange-600 font-black text-white text-lg tracking-tighter group-hover:bg-orange-500 transition-colors">
                SP
              </span>
              <span className="font-extrabold text-xl tracking-tight text-white group-hover:text-orange-500 transition-colors">
                Sailor
                <span className="text-orange-500 group-hover:text-white transition-colors">
                  Path
                </span>
              </span>
            </Link>

            <nav className="hidden md:flex items-center gap-6">
              <div className="relative group">
                <button className="text-sm font-semibold text-slate-400 hover:text-white transition-colors flex items-center gap-1 py-5 focus:outline-none">
                  SG Optimist
                  <svg
                    className="h-4 w-4 text-slate-500 group-hover:text-slate-300 transition-colors"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    strokeWidth={2.5}
                  >
                    <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
                  </svg>
                </button>
                <div className="absolute left-0 top-[60px] hidden group-hover:block w-48 rounded-2xl bg-[#131520] border border-white/5 p-2 shadow-2xl">
                  <Link
                    href="/sg/optimist/gold"
                    className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white transition-all"
                  >
                    Gold Fleet Standings
                  </Link>
                  <Link
                    href="/sg/optimist/silver"
                    className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white transition-all"
                  >
                    Silver Fleet Standings
                  </Link>
                  <Link
                    href="/sg/optimist/regattas"
                    className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white transition-all"
                  >
                    Regattas List
                  </Link>
                  <Link
                    href="/sg/optimist/goldsailors"
                    className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white transition-all"
                  >
                    All Gold Fleet Sailors
                  </Link>
                </div>
              </div>
            </nav>
          </div>

          <div className="flex items-center gap-3 sm:gap-4">
            {!ready ? (
              <span className="text-xs text-slate-600">…</span>
            ) : user ? (
              <>
                <span
                  className="hidden sm:inline max-w-[180px] truncate text-xs font-semibold text-slate-300"
                  title={user.email || ""}
                >
                  {user.email}
                </span>
                <a
                  href="https://admin.sailorpath.com/"
                  className="hidden sm:inline text-xs font-bold text-slate-400 hover:text-white transition-colors"
                >
                  Admin
                </a>
                <button
                  type="button"
                  onClick={signOut}
                  className="text-sm font-semibold text-slate-400 hover:text-white transition-colors"
                >
                  Log out
                </button>
              </>
            ) : (
              <>
                <Link
                  href="/login"
                  className="text-sm font-semibold text-slate-400 hover:text-white transition-colors"
                >
                  Log In
                </Link>
                <Link
                  href="/register"
                  className="hidden sm:inline-flex rounded-full bg-orange-600 px-4 py-1.5 text-xs font-bold text-white hover:bg-orange-500 transition-all shadow-md shadow-orange-950/20"
                >
                  Claim your profile
                </Link>
              </>
            )}
          </div>
        </div>
      </div>
    </header>
  );
}
