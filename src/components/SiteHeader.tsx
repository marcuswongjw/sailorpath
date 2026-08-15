"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { Menu, X, ChevronDown } from "lucide-react";
import { useAccount } from "@/components/AccountProvider";
import type { ViewAs } from "@/lib/viewAs";

export function SiteHeader() {
  const { email, role, isSuperadmin, viewAs, setViewAs, owned, ready, signOut } =
    useAccount();
  const router = useRouter();
  const [mobileOpen, setMobileOpen] = useState(false);
  const [modeBusy, setModeBusy] = useState(false);

  const switchMode = async (mode: ViewAs) => {
    if (mode === viewAs || modeBusy) return;
    setModeBusy(true);
    try {
      await setViewAs(mode);
      router.refresh();
    } finally {
      setModeBusy(false);
      setMobileOpen(false);
    }
  };

  const primaryProfile = owned[0] || null;

  const optimistLinks = (
    <>
      <Link
        href="/sg/optimist/gold"
        prefetch
        onClick={() => setMobileOpen(false)}
        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
      >
        SG Gold Fleet
      </Link>
      <Link
        href="/sg/optimist/silver"
        prefetch
        onClick={() => setMobileOpen(false)}
        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
      >
        SG Silver Fleet
      </Link>
      <Link
        href="/sg/optimist/regattas"
        onClick={() => setMobileOpen(false)}
        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
      >
        SG Regattas
      </Link>
      {isSuperadmin && (
        <Link
          href="/sg/optimist/goldsailors"
          onClick={() => setMobileOpen(false)}
          className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
        >
          SG All Gold Fleet Sailors
        </Link>
      )}
    </>
  );

  const ilcaLinks = (
    <>
      <Link
        href="/sg/ilca4"
        onClick={() => setMobileOpen(false)}
        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
      >
        SG Ranking
      </Link>
      <Link
        href="/sg/ilca4/regattas"
        onClick={() => setMobileOpen(false)}
        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white"
      >
        SG Regattas
      </Link>
    </>
  );

  const navLinks = (
    <>
      <div className="relative group">
        <button
          type="button"
          className="text-sm font-semibold text-slate-400 hover:text-white transition-colors flex items-center gap-1 py-2 md:py-5 focus:outline-none"
        >
          Optimist
          <ChevronDown className="h-4 w-4 text-slate-500 group-hover:text-slate-300" />
        </button>
        <div className="absolute left-0 top-[52px] hidden group-hover:block w-56 rounded-2xl bg-[#131520] border border-white/5 p-2 shadow-2xl z-50">
          {optimistLinks}
        </div>
      </div>
      <div className="relative group">
        <button
          type="button"
          className="text-sm font-semibold text-slate-400 hover:text-white transition-colors flex items-center gap-1 py-2 md:py-5 focus:outline-none"
        >
          ILCA 4
          <ChevronDown className="h-4 w-4 text-slate-500 group-hover:text-slate-300" />
        </button>
        <div className="absolute left-0 top-[52px] hidden group-hover:block w-52 rounded-2xl bg-[#131520] border border-white/5 p-2 shadow-2xl z-50">
          {ilcaLinks}
        </div>
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
          Demo
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
      {(owned.length > 0 ||
        (isSuperadmin && viewAs === "parent")) && (
        <Link
          href="/parent"
          onClick={() => setMobileOpen(false)}
          className="text-sm font-semibold text-emerald-400 hover:text-emerald-300"
        >
          {(() => {
            // Prefer parent if any linked profile is a parent claim; sailor if all self
            const rels = owned
              .map((o) => String(o.ownerRelation || "").toLowerCase())
              .filter(Boolean);
            const anyParent = rels.includes("parent");
            const allSailor =
              rels.length > 0 && rels.every((r) => r === "sailor");
            if (allSailor) return "Sailor Dashboard";
            if (anyParent) return "Parent Dashboard";
            if (isSuperadmin && viewAs === "parent") return "Parent Dashboard";
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
            owned.length === 1
              ? `/${primaryProfile.handle}`
              : "/parent"
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
        <div className="flex items-center rounded-full border border-white/10 bg-white/5 p-0.5 text-[10px] font-black uppercase tracking-wide">
          <button
            type="button"
            disabled={modeBusy}
            onClick={() => void switchMode("admin")}
            className={`rounded-full px-2.5 py-1 transition-colors ${
              viewAs === "admin"
                ? "bg-orange-600 text-white"
                : "text-slate-400 hover:text-white"
            }`}
            title="Full superadmin tools"
          >
            Admin
          </button>
          <button
            type="button"
            disabled={modeBusy}
            onClick={() => void switchMode("parent")}
            className={`rounded-full px-2.5 py-1 transition-colors ${
              viewAs === "parent"
                ? "bg-sky-600 text-white"
                : "text-slate-400 hover:text-white"
            }`}
            title="Parent mode — claim and manage linked sailors"
          >
            Parent
          </button>
        </div>
      )}
      {isSuperadmin && viewAs === "admin" && (
        <a
          href="https://admin.sailorpath.com/"
          className="text-xs font-bold text-slate-400 hover:text-white"
        >
          Console
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
    <header className="sticky top-0 z-50 w-full max-w-[100vw] border-b border-white/5 bg-[#090a0f]/95 backdrop-blur-md overflow-x-clip">
      <div className="mx-auto w-full max-w-7xl px-3 sm:px-6 lg:px-8 min-w-0">
        <div className="flex h-14 sm:h-16 items-center justify-between gap-2 sm:gap-4 min-w-0">
          <div className="flex items-center gap-3 lg:gap-10 min-w-0 flex-1">
            <Link
              href="/"
              prefetch
              className="flex items-center gap-2 group shrink-0 min-w-0"
            >
              <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-orange-600 font-black text-white text-lg group-hover:bg-orange-500">
                SP
              </span>
              <span className="font-extrabold text-base sm:text-xl text-white tracking-tight truncate">
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
            {mobileOpen ? (
              <X className="h-5 w-5" />
            ) : (
              <Menu className="h-5 w-5" />
            )}
          </button>
        </div>

        {mobileOpen && (
          <div className="md:hidden border-t border-white/5 py-4 flex flex-col gap-1">
            <p className="px-1 pb-1 text-[10px] font-bold uppercase tracking-wider text-slate-500">
              Optimist
            </p>
            <Link
              href="/sg/optimist/gold"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
            >
              SG Gold Fleet
            </Link>
            <Link
              href="/sg/optimist/silver"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
            >
              SG Silver Fleet
            </Link>
            <Link
              href="/sg/optimist/regattas"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
            >
              SG Regattas
            </Link>
            {isSuperadmin && (
              <Link
                href="/sg/optimist/goldsailors"
                onClick={() => setMobileOpen(false)}
                className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
              >
                SG All Gold Fleet Sailors
              </Link>
            )}
            <p className="px-1 pt-3 pb-1 text-[10px] font-bold uppercase tracking-wider text-slate-500">
              ILCA 4
            </p>
            <Link
              href="/sg/ilca4"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
            >
              SG Ranking
            </Link>
            <Link
              href="/sg/ilca4/regattas"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
            >
              SG Regattas
            </Link>
            <Link
              href="/search"
              onClick={() => setMobileOpen(false)}
              className="rounded-xl px-3 py-2.5 text-sm font-semibold text-slate-300 hover:bg-white/5"
            >
              Search
            </Link>
            {owned.length === 0 && (
              <Link
                href="/sample"
                onClick={() => setMobileOpen(false)}
                className="rounded-xl px-3 py-2.5 text-sm font-semibold text-amber-200 hover:bg-white/5"
              >
                Demo profiles
              </Link>
            )}
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
