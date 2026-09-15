"use client";

import Link from "next/link";
import { useEffect, useRef, useState, useSyncExternalStore } from "react";
import { Menu, X, ChevronDown } from "lucide-react";
import { useAccount } from "@/components/AccountProvider";
import { BrandLogoLink } from "@/components/BrandMark";
import { shouldShowDemoNavigation } from "@/lib/adminHost";

type OpenMenu = "optimist" | "ilca" | null;

const subscribeToHost = () => () => {};
const getBrowserHost = () => window.location.hostname;
const getServerHost = () => "";

export function SiteHeader() {
  const { email, role, isSuperadmin, owned, ready, signOut } = useAccount();
  const [mobileOpen, setMobileOpen] = useState(false);
  const [openMenu, setOpenMenu] = useState<OpenMenu>(null);
  const host = useSyncExternalStore(
    subscribeToHost,
    getBrowserHost,
    getServerHost
  );
  const navRef = useRef<HTMLElement>(null);

  const primaryProfile = owned[0] || null;
  const showClaimCta = ready && !email;

  useEffect(() => {
    if (!openMenu) return;
    const onDoc = (e: MouseEvent) => {
      if (!navRef.current?.contains(e.target as Node)) setOpenMenu(null);
    };
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpenMenu(null);
    };
    document.addEventListener("mousedown", onDoc);
    document.addEventListener("keydown", onKey);
    return () => {
      document.removeEventListener("mousedown", onDoc);
      document.removeEventListener("keydown", onKey);
    };
  }, [openMenu]);

  const optimistLinks = (
    <>
      <Link
        href="/sg/optimist/gold"
        prefetch
        onClick={() => {
          setMobileOpen(false);
          setOpenMenu(null);
        }}
        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
      >
        Gold standings
      </Link>
      <Link
        href="/sg/optimist/silver"
        prefetch
        onClick={() => {
          setMobileOpen(false);
          setOpenMenu(null);
        }}
        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
      >
        Silver standings
      </Link>
      <Link
        href="/sg/optimist/regattas"
        onClick={() => {
          setMobileOpen(false);
          setOpenMenu(null);
        }}
        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
      >
        Optimist regattas
      </Link>
      <Link
        href="/sg/optimist/selection"
        prefetch
        onClick={() => {
          setMobileOpen(false);
          setOpenMenu(null);
        }}
        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-orange-400 hover:bg-white/5 hover:text-orange-300"
      >
        Selection trials 2026
      </Link>
      {isSuperadmin && (
        <Link
          href="/sg/optimist/goldsailors"
          onClick={() => {
            setMobileOpen(false);
            setOpenMenu(null);
          }}
          className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
        >
          All Gold Fleet sailors
        </Link>
      )}
    </>
  );

  const ilcaLinks = (
    <>
      <Link
        href="/sg/ilca4"
        onClick={() => {
          setMobileOpen(false);
          setOpenMenu(null);
        }}
        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
      >
        ILCA 4 standings
      </Link>
      <Link
        href="/sg/ilca4/regattas"
        onClick={() => {
          setMobileOpen(false);
          setOpenMenu(null);
        }}
        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
      >
        ILCA 4 regattas
      </Link>
    </>
  );

  const navLinks = (
    <>
      <Link
        href="/calendar"
        prefetch
        className="text-sm font-semibold text-slate-400 hover:text-white py-2 md:py-0"
      >
        Calendar
      </Link>
      <div className="relative">
        <button
          type="button"
          aria-expanded={openMenu === "optimist"}
          aria-haspopup="menu"
          onClick={() =>
            setOpenMenu((m) => (m === "optimist" ? null : "optimist"))
          }
          className="text-sm font-semibold text-slate-400 hover:text-white transition-colors flex items-center gap-1 py-2 md:py-5 focus:outline-none focus-visible:text-white"
        >
          Optimist
          <ChevronDown
            className={`h-4 w-4 text-slate-500 transition-transform ${
              openMenu === "optimist" ? "rotate-180 text-slate-300" : ""
            }`}
          />
        </button>
        {openMenu === "optimist" && (
          <div
            role="menu"
            className="absolute left-0 top-[52px] w-56 rounded-xl bg-warm-white border border-cool-veil p-2 shadow-xl z-50"
          >
            {optimistLinks}
          </div>
        )}
      </div>
      <div className="relative">
        <button
          type="button"
          aria-expanded={openMenu === "ilca"}
          aria-haspopup="menu"
          onClick={() => setOpenMenu((m) => (m === "ilca" ? null : "ilca"))}
          className="text-sm font-semibold text-slate-400 hover:text-white transition-colors flex items-center gap-1 py-2 md:py-5 focus:outline-none focus-visible:text-white"
        >
          ILCA 4
          <ChevronDown
            className={`h-4 w-4 text-slate-500 transition-transform ${
              openMenu === "ilca" ? "rotate-180 text-slate-300" : ""
            }`}
          />
        </button>
        {openMenu === "ilca" && (
          <div
            role="menu"
            className="absolute left-0 top-[52px] w-52 rounded-xl bg-warm-white border border-cool-veil p-2 shadow-xl z-50"
          >
            {ilcaLinks}
          </div>
        )}
      </div>
      <Link
        href="/sg/wingfoil"
        prefetch
        className="text-sm font-semibold text-slate-400 hover:text-white py-2 md:py-0 flex items-center gap-1.5"
      >
        <span>WingFoil</span>
        <span className="text-[9px] font-black uppercase text-teal-400 bg-teal-500/10 px-1.5 py-0.5 rounded border border-teal-500/20">
          New
        </span>
      </Link>
      <Link
        href="/sg/techno293"
        prefetch
        className="text-sm font-semibold text-slate-400 hover:text-white py-2 md:py-0 flex items-center gap-1.5"
      >
        <span>Techno 293</span>
        <span className="text-[9px] font-black uppercase text-cyan-400 bg-cyan-500/10 px-1.5 py-0.5 rounded border border-cyan-500/20">
          New
        </span>
      </Link>
      <Link
        href="/search"
        onClick={() => setMobileOpen(false)}
        className="text-sm font-semibold text-slate-400 hover:text-white py-2 md:py-0"
      >
        Search
      </Link>
      {host && shouldShowDemoNavigation(host, owned.length, Boolean(email)) && (
        <Link
          href="/sample"
          onClick={() => setMobileOpen(false)}
          className="text-sm font-semibold text-amber-300/90 hover:text-amber-200 py-2 md:py-0"
        >
          Explore demo
        </Link>
      )}
    </>
  );

  const authButtons = !ready ? (
    <span className="text-xs text-slate-600">…</span>
  ) : email ? (
    <>
      <span className="hidden xl:inline text-xs text-slate-300 max-w-[140px] truncate">
        {email}
      </span>
      {owned.length > 0 && (
        <Link
          href="/parent"
          onClick={() => setMobileOpen(false)}
          className="text-sm font-semibold text-emerald-400 hover:text-emerald-300"
        >
          {(() => {
            const rels = owned
              .map((o) => String(o.ownerRelation || "").toLowerCase())
              .filter(Boolean);
            const anyParent = rels.includes("parent");
            const allSailor =
              rels.length > 0 && rels.every((r) => r === "sailor");
            if (allSailor) return "Sailor Dashboard";
            if (anyParent) return "Parent Dashboard";
            if (String(role || "").toLowerCase() === "sailor")
              return "Sailor Dashboard";
            if (String(role || "").toLowerCase() === "parent")
              return "Parent Dashboard";
            return "Parent Dashboard";
          })()}
        </Link>
      )}
      {primaryProfile && (
        <Link
          href={
            owned.length === 1 ? `/${primaryProfile.handle}` : "/parent"
          }
          onClick={() => setMobileOpen(false)}
          className="text-sm font-semibold text-white hover:text-orange-300"
        >
          My profile
        </Link>
      )}
      {role === "coach" && (
        <Link
          href="/coach-tools"
          onClick={() => setMobileOpen(false)}
          className="text-sm font-semibold text-orange-400 hover:text-orange-300"
        >
          Coach Dashboard
        </Link>
      )}
      <Link
        href="/account"
        onClick={() => setMobileOpen(false)}
        className={`text-sm font-semibold hover:text-orange-300 ${
          role === "coach" ? "text-slate-400" : "text-orange-400"
        }`}
      >
        My account
      </Link>
      {isSuperadmin && (
        <a
          href={
            host &&
            (host.includes("localhost") ||
              host.includes("127.0.0.1") ||
              host.includes("vercel.app"))
              ? "/admin"
              : "https://admin.sailorpath.com/"
          }
          className="text-xs font-bold text-slate-400 hover:text-white"
        >
          Admin console
        </a>
      )}
      <button
        type="button"
        onClick={() => void signOut()}
        className="text-sm font-semibold text-slate-400 hover:text-white"
      >
        Log out
      </button>
    </>
  ) : (
    <>
      <Link
        href="/search"
        onClick={() => setMobileOpen(false)}
        className="rounded-full bg-orange-600 px-4 py-1.5 text-xs font-bold text-white hover:bg-orange-500"
      >
        Find and claim a profile
      </Link>
      <Link
        href="/login"
        className="text-sm font-semibold text-slate-400 hover:text-white"
      >
        Log in
      </Link>
      <Link
        href="/register"
        className="text-sm font-semibold text-slate-400 hover:text-white"
      >
        Create account
      </Link>
    </>
  );

  return (
    <header className="sticky top-0 z-50 w-full max-w-[100vw] border-b border-cool-veil bg-warm-white overflow-x-clip pt-[env(safe-area-inset-top,0px)]">
      <div className="mx-auto w-full max-w-7xl px-3 sm:px-6 lg:px-8 min-w-0">
        <div className="flex h-14 sm:h-16 items-center justify-between gap-2 sm:gap-4 min-w-0">
          <div className="flex items-center gap-3 lg:gap-8 min-w-0 flex-1">
            <BrandLogoLink />
            <nav
              ref={navRef}
              className="hidden md:flex items-center gap-5 lg:gap-6"
            >
              {navLinks}
            </nav>
          </div>

          <div className="hidden md:flex items-center gap-2 lg:gap-3 flex-wrap justify-end">
            {authButtons}
          </div>

          <button
            type="button"
            className="md:hidden rounded-lg border border-white/10 p-2.5 text-slate-300 touch-manipulation min-h-[2.5rem] min-w-[2.5rem] inline-flex items-center justify-center"
            aria-label="Toggle menu"
            aria-expanded={mobileOpen}
            onClick={() => {
              setOpenMenu(null);
              setMobileOpen((o) => !o);
            }}
          >
            {mobileOpen ? (
              <X className="h-5 w-5" />
            ) : (
              <Menu className="h-5 w-5" />
            )}
          </button>
        </div>

        {mobileOpen && (
          <div className="md:hidden border-t border-white/5 py-3 pb-[max(1rem,env(safe-area-inset-bottom))] flex flex-col gap-0.5 max-h-[min(70vh,32rem)] overflow-y-auto">
            <Link
              href="/calendar"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-3 text-sm font-semibold text-sky-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center"
            >
              Race Calendar
            </Link>
            {showClaimCta && (
              <Link
                href="/search"
                onClick={() => setMobileOpen(false)}
                className="rounded-xl px-3 py-3 text-sm font-bold text-white bg-orange-600/90 hover:bg-orange-500 touch-manipulation min-h-[2.75rem] flex items-center justify-center"
              >
                Find and claim a profile
              </Link>
            )}
            <p className="px-1 pt-2 pb-1 text-[10px] font-bold uppercase tracking-wider text-slate-500">
              Optimist
            </p>
            <Link
              href="/sg/optimist/gold"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-3 text-sm font-semibold text-slate-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center"
            >
              Gold standings
            </Link>
            <Link
              href="/sg/optimist/silver"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-3 text-sm font-semibold text-slate-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center"
            >
              Silver standings
            </Link>
            <Link
              href="/sg/optimist/regattas"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-3 text-sm font-semibold text-slate-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center"
            >
              Optimist regattas
            </Link>
            {isSuperadmin && (
              <Link
                href="/sg/optimist/goldsailors"
                onClick={() => setMobileOpen(false)}
                className="rounded-xl px-3 py-3 text-sm font-semibold text-slate-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center"
              >
                All Gold Fleet sailors
              </Link>
            )}
            <p className="px-1 pt-3 pb-1 text-[10px] font-bold uppercase tracking-wider text-slate-500">
              ILCA 4
            </p>
            <Link
              href="/sg/ilca4"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-3 text-sm font-semibold text-slate-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center"
            >
              ILCA 4 standings
            </Link>
            <Link
              href="/sg/ilca4/regattas"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-3 text-sm font-semibold text-slate-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center"
            >
              ILCA 4 regattas
            </Link>
            <p className="px-1 pt-3 pb-1 text-[10px] font-bold uppercase tracking-wider text-slate-500">
              WingFoil
            </p>
            <Link
              href="/sg/wingfoil"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-3 text-sm font-semibold text-teal-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center justify-between"
            >
              <span>WingFoil Racing</span>
              <span className="text-[9px] font-black uppercase text-teal-400 bg-teal-500/10 px-1.5 py-0.5 rounded border border-teal-500/20">
                New
              </span>
            </Link>
            <p className="px-1 pt-3 pb-1 text-[10px] font-bold uppercase tracking-wider text-slate-500">
              Techno 293
            </p>
            <Link
              href="/sg/techno293"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-3 text-sm font-semibold text-cyan-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center justify-between"
            >
              <span>Techno 293 Racing</span>
              <span className="text-[9px] font-black uppercase text-cyan-400 bg-cyan-500/10 px-1.5 py-0.5 rounded border border-cyan-500/20">
                New
              </span>
            </Link>
            <Link
              href="/search"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-3 text-sm font-semibold text-slate-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center"
            >
              Search
            </Link>
            {host && shouldShowDemoNavigation(host, owned.length, Boolean(email)) && (
              <Link
                href="/sample"
                onClick={() => setMobileOpen(false)}
                className="rounded-xl px-3 py-3 text-sm font-semibold text-amber-200 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center"
              >
                Explore demo
              </Link>
            )}
            <Link
              href="/support"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-3 text-sm font-semibold text-slate-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center"
            >
              Help &amp; support
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
