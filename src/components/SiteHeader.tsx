"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { createBrowserSupabase } from "@/lib/supabase/browser";

export function SiteHeader() {
  const [email, setEmail] = useState<string | null>(null);
  const [ready, setReady] = useState(false);

  useEffect(() => {
    let unsub: (() => void) | undefined;
    (async () => {
      try {
        const supabase = createBrowserSupabase();
        const {
          data: { session },
        } = await supabase.auth.getSession();
        setEmail(session?.user?.email ?? null);
        setReady(true);
        const { data } = supabase.auth.onAuthStateChange((_e, s) => {
          setEmail(s?.user?.email ?? null);
        });
        unsub = () => data.subscription.unsubscribe();
      } catch {
        setReady(true);
      }
    })();
    return () => unsub?.();
  }, []);

  const signOut = async () => {
    try {
      await createBrowserSupabase().auth.signOut();
    } catch {
      /* ignore */
    }
    window.location.assign("/");
  };

  return (
    <header className="sticky top-0 z-50 w-full border-b border-white/5 bg-[#090a0f]/90 backdrop-blur-md">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 flex h-16 items-center justify-between">
        <div className="flex items-center gap-8">
          <Link href="/" className="flex items-center gap-2 group">
            <span className="flex h-8 w-8 items-center justify-center rounded-lg bg-orange-600 font-black text-white text-lg group-hover:bg-orange-500">
              SP
            </span>
            <span className="font-extrabold text-xl text-white">
              Sailor<span className="text-orange-500">Path</span>
            </span>
          </Link>
          <nav className="hidden md:flex items-center gap-5 text-sm font-semibold text-slate-400">
            <Link href="/sg/optimist/gold" className="hover:text-white">
              Gold
            </Link>
            <Link href="/sg/optimist/silver" className="hover:text-white">
              Silver
            </Link>
            <Link href="/sg/optimist/regattas" className="hover:text-white">
              Regattas
            </Link>
            <Link href="/search" className="hover:text-white">
              Search
            </Link>
          </nav>
        </div>
        <div className="flex items-center gap-3">
          {!ready ? (
            <span className="text-xs text-slate-600">…</span>
          ) : email ? (
            <>
              <span className="hidden sm:inline text-xs text-slate-300 max-w-[160px] truncate">
                {email}
              </span>
              <a
                href="https://admin.sailorpath.com/"
                className="text-xs font-bold text-slate-400 hover:text-white"
              >
                Admin
              </a>
              <button
                type="button"
                onClick={signOut}
                className="text-sm font-semibold text-slate-400 hover:text-white"
              >
                Log out
              </button>
            </>
          ) : (
            <>
              <Link
                href="/login"
                className="text-sm font-semibold text-slate-400 hover:text-white"
              >
                Log In
              </Link>
              <Link
                href="/register"
                className="rounded-full bg-orange-600 px-4 py-1.5 text-xs font-bold text-white hover:bg-orange-500"
              >
                Register
              </Link>
            </>
          )}
        </div>
      </div>
    </header>
  );
}
