"use client";

import Link from "next/link";
import { useEffect, useRef, useState } from "react";
import { Menu, X, ChevronDown } from "lucide-react";
import { useAccount } from "@/components/AccountProvider";
import { BrandLogoLink } from "@/components/BrandMark";

type OpenMenu = "optimist" | "ilca" | null;

export function SiteHeader() {
  const { email, role, isSuperadmin, owned, ready, signOut } = useAccount();
  const [mobileOpen, setMobileOpen] = useState(false);
  const [openMenu, setOpenMenu] = useState<OpenMenu>(null);
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
        href="/rankings"
        prefetch
        className="text-sm font-semibold text-slate-400 hover:text-white py-2 md:py-0"
      >
        Rankings
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
            className="absolute left-0 top-[52px] w-56 rounded-2xl bg-[#131520] border border-white/5 p-2 shadow-2xl z-50"
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
            className="absolute left-0 top-[52px] w-52 rounded-2xl bg-[#131520] border border-white/5 p-2 shadow-2xl z-50"
          >
            {ilcaLinks}
          </div>
        )}
      </div>
      <Link
        href="/search"
        onClick={() => setMobileOpen(false)}
        className="text-sm font-semibold text-slate-400 hover:text-white py-2 md:py-0"
      >
        Search
      </Link>
      {owned.length === 0 && (
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
    <header className="sticky top-0 z-50 w-full max-w-[100vw] border-b border-white/5 bg-[#090a0f]/95 backdrop-blur-md overflow-x-clip pt-[env(safe-area-inset-top,0px)]">
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
              href="/rankings"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-3 text-sm font-semibold text-orange-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center"
            >
              Rankings
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
            <Link
              href="/search"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-3 text-sm font-semibold text-slate-300 hover:bg-white/5 touch-manipulation min-h-[2.75rem] flex items-center"
            >
              Search
            </Link>
            {owned.length === 0 && (
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
