"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { Menu, X, ChevronDown } from "lucide-react";
import { createBrowserSupabase } from "@/lib/supabase/browser";

type Owned = { id: string; name: string; handle: string };

export function SiteHeader() {
  const [email, setEmail] = useState<string | null>(null);
  const [isSuperadmin, setIsSuperadmin] = useState(false);
  const [owned, setOwned] = useState<Owned[]>([]);
  const [ready, setReady] = useState(false);
  const [mobileOpen, setMobileOpen] = useState(false);

  const loadAccount = async () => {
    try {
      const res = await fetch("/api/admin/me", { credentials: "include" });
      const data = await res.json();
      setIsSuperadmin(Boolean(data.isSuperadmin));
      if (data.user?.email) setEmail(data.user.email);
    } catch {
      setIsSuperadmin(false);
    }
    try {
      const res = await fetch("/api/account", { credentials: "include" });
      if (!res.ok) {
        setOwned([]);
        return;
      }
      const data = await res.json();
      setOwned(data.owned || []);
      if (data.email) setEmail(data.email);
    } catch {
      setOwned([]);
    }
  };

  useEffect(() => {
    let unsub: (() => void) | undefined;
    let cancelled = false;

    (async () => {
      try {
        const supabase = createBrowserSupabase();
        const {
          data: { session },
        } = await supabase.auth.getSession();
        setEmail(session?.user?.email ?? null);
        setReady(true);
        if (session?.user) {
          if (!cancelled) await loadAccount();
        } else {
          setIsSuperadmin(false);
          setOwned([]);
        }

        const { data } = supabase.auth.onAuthStateChange((_e, s) => {
          setEmail(s?.user?.email ?? null);
          if (s?.user) void loadAccount();
          else {
            setIsSuperadmin(false);
            setOwned([]);
          }
        });
        unsub = () => data.subscription.unsubscribe();
      } catch {
        setReady(true);
      }
    })();
    return () => {
      cancelled = true;
      unsub?.();
    };
  }, []);

  const signOut = async () => {
    try {
      await createBrowserSupabase().auth.signOut();
    } catch {
      /* ignore */
    }
    window.location.assign("/");
  };

  const primaryProfile = owned[0] || null;

  const navLinks = (
    <>
      <div className="relative group">
        <button
          type="button"
          className="text-sm font-semibold text-slate-400 hover:text-white transition-colors flex items-center gap-1 py-2 md:py-5 focus:outline-none"
        >
          SG Optimist
          <ChevronDown className="h-4 w-4 text-slate-500 group-hover:text-slate-300" />
        </button>
        <div className="absolute left-0 top-[52px] hidden group-hover:block w-52 rounded-2xl bg-[#131520] border border-white/5 p-2 shadow-2xl z-50">
          <Link
            href="/sg/optimist/gold"
            className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
          >
            Gold Fleet Standings
          </Link>
          <Link
            href="/sg/optimist/silver"
            className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
          >
            Silver Fleet Standings
          </Link>
          <Link
            href="/sg/optimist/regattas"
            className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
          >
            Regattas List
          </Link>
          <Link
            href="/sg/optimist/goldsailors"
            className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
          >
            All Gold Fleet Sailors
          </Link>
        </div>
      </div>
      <Link
        href="/search"
        onClick={() => setMobileOpen(false)}
        className="text-sm font-semibold text-slate-400 hover:text-white py-2 md:py-0"
      >
        Search
      </Link>
      <Link
        href="/sample"
        onClick={() => setMobileOpen(false)}
        className="text-sm font-semibold text-amber-300/90 hover:text-amber-200 py-2 md:py-0"
      >
        Demo
      </Link>
    </>
  );

  const authButtons = !ready ? (
    <span className="text-xs text-slate-600">…</span>
  ) : email ? (
    <>
      <span className="hidden xl:inline text-xs text-slate-300 max-w-[140px] truncate">
        {email}
      </span>
      {primaryProfile && (
        <Link
          href={
            owned.length === 1
              ? `/${primaryProfile.handle}?edit=1`
              : "/account#profiles"
          }
          onClick={() => setMobileOpen(false)}
          className="text-sm font-semibold text-white hover:text-orange-300"
        >
          My profile
        </Link>
      )}
      <Link
        href="/account"
        onClick={() => setMobileOpen(false)}
        className="text-sm font-semibold text-orange-400 hover:text-orange-300"
      >
        My account
      </Link>
      {isSuperadmin && (
        <a
          href="https://admin.sailorpath.com/"
          className="text-xs font-bold text-slate-400 hover:text-white"
        >
          Admin
        </a>
      )}
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
        Create account
      </Link>
    </>
  );

  return (
    <header className="sticky top-0 z-50 w-full border-b border-white/5 bg-[#090a0f]/95 backdrop-blur-md">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex h-14 sm:h-16 items-center justify-between gap-3 sm:gap-4">
          <div className="flex items-center gap-4 lg:gap-10 min-w-0">
            <Link href="/" className="flex items-center gap-2 group shrink-0">
              <span className="flex h-8 w-8 items-center justify-center rounded-lg bg-orange-600 font-black text-white text-lg group-hover:bg-orange-500">
                SP
              </span>
              <span className="font-extrabold text-base sm:text-xl text-white tracking-tight">
                Sailor<span className="text-orange-500">Path</span>
              </span>
            </Link>
            <nav className="hidden md:flex items-center gap-6">{navLinks}</nav>
          </div>

          <div className="hidden md:flex items-center gap-2 lg:gap-3 flex-wrap justify-end">
            {authButtons}
          </div>

          <button
            type="button"
            className="md:hidden rounded-lg border border-white/10 p-2 text-slate-300"
            aria-label="Toggle menu"
            onClick={() => setMobileOpen((o) => !o)}
          >
            {mobileOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}
          </button>
        </div>

        {mobileOpen && (
          <div className="md:hidden border-t border-white/5 py-4 flex flex-col gap-1">
            <p className="px-1 pb-1 text-[10px] font-bold uppercase tracking-wider text-slate-500">
              SG Optimist
            </p>
            <Link
              href="/sg/optimist/gold"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
            >
              Gold Fleet Standings
            </Link>
            <Link
              href="/sg/optimist/silver"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
            >
              Silver Fleet Standings
            </Link>
            <Link
              href="/sg/optimist/regattas"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
            >
              Regattas List
            </Link>
            <Link
              href="/sg/optimist/goldsailors"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
            >
              All Gold Fleet Sailors
            </Link>
            <Link
              href="/search"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
            >
              Search
            </Link>
            <Link
              href="/sample"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-amber-200 hover:bg-white/5"
            >
              Demo profiles
            </Link>
            <Link
              href="/support"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
            >
              Help / Support
            </Link>
            <div className="mt-3 pt-3 border-t border-white/5 flex flex-col gap-1">
              {authButtons}
            </div>
          </div>
        )}
      </div>
    </header>
  );
}
