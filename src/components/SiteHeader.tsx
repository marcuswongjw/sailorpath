"use client";

import Link from "next/link";
import dynamic from "next/dynamic";
import { Menu, Search, X, ChevronDown } from "lucide-react";
import { useEffect, useState } from "react";
import { useAccount } from "@/components/AccountProvider";
import { BrandLogoLink } from "@/components/BrandMark";

const QuickSearchModal = dynamic(() =>
  import("@/components/search/QuickSearchModal").then((mod) => mod.QuickSearchModal)
);

const publicLinks = [
  ["Results", "/results"],
  ["Rankings", "/rankings"],
  ["Sailors", "/sailors"],
  ["Calendar", "/calendar"],
] as const;

/** The public navigation is intentionally identical before and after sign-in. */
export function SiteHeader() {
  const { email, owned, ready, signOut } = useAccount();
  const [mobileOpen, setMobileOpen] = useState(false);
  const [accountOpen, setAccountOpen] = useState(false);
  const [quickSearchOpen, setQuickSearchOpen] = useState(false);

  useEffect(() => {
    const onKeyDown = (event: KeyboardEvent) => {
      if ((event.metaKey || event.ctrlKey) && event.key.toLowerCase() === "k") {
        event.preventDefault();
        setQuickSearchOpen((open) => !open);
      }
      if (event.key === "Escape") {
        setMobileOpen(false);
        setAccountOpen(false);
      }
    };
    window.addEventListener("keydown", onKeyDown);
    return () => window.removeEventListener("keydown", onKeyDown);
  }, []);

  const closeMobile = () => setMobileOpen(false);
  const primaryProfile = owned[0];

  return (
    <header className="sticky top-0 z-[60] w-full border-b border-harbour-shadow bg-harbour text-sailcloth">
      <div className="mx-auto flex h-14 max-w-7xl items-center justify-between gap-3 px-3 sm:h-16 sm:px-6 lg:px-8">
        <div className="flex min-w-0 items-center gap-6">
          <BrandLogoLink variant="reversed" />
          <nav aria-label="Public" className="hidden items-center gap-5 lg:flex">
            {publicLinks.map(([label, href]) => (
              <Link key={href} href={href} className="text-sm font-semibold text-sailcloth hover:text-white hover:underline underline-offset-4">
                {label}
              </Link>
            ))}
          </nav>
        </div>

        <div className="hidden items-center gap-3 lg:flex">
          <button type="button" aria-label="Search SailorPath" onClick={() => setQuickSearchOpen(true)} className="inline-flex h-9 w-9 items-center justify-center rounded-lg text-sailcloth hover:bg-harbour-mid hover:text-white" title="Search (⌘K)">
            <Search className="h-5 w-5" />
          </button>
          {!ready ? <span className="text-sm text-soft-aqua">…</span> : email ? (
            <div className="relative">
              <button type="button" onClick={() => setAccountOpen((open) => !open)} aria-expanded={accountOpen} className="inline-flex items-center gap-1 text-sm font-semibold text-sailcloth hover:text-white">
                Account <ChevronDown className={`h-4 w-4 transition-transform ${accountOpen ? "rotate-180" : ""}`} />
              </button>
              {accountOpen && (
                <div className="absolute right-0 top-8 w-56 rounded-xl border border-cool-veil bg-warm-white p-2 text-charcoal shadow-xl">
                  <p className="truncate px-3 py-2 text-xs text-slate-soft">{email}</p>
                  <Link href="/account" onClick={() => setAccountOpen(false)} className="block rounded-lg px-3 py-2 text-sm font-semibold hover:bg-sailcloth">My account</Link>
                  {primaryProfile && <Link href={`/sailors/${primaryProfile.handle}`} onClick={() => setAccountOpen(false)} className="block rounded-lg px-3 py-2 text-sm font-semibold hover:bg-sailcloth">My profile</Link>}
                  <Link href="/account/parent" onClick={() => setAccountOpen(false)} className="block rounded-lg px-3 py-2 text-sm font-semibold hover:bg-sailcloth">Parent workspace</Link>
                  <Link href="/account/coach" onClick={() => setAccountOpen(false)} className="block rounded-lg px-3 py-2 text-sm font-semibold hover:bg-sailcloth">Coach workspace</Link>
                  <button type="button" onClick={() => void signOut()} className="block w-full rounded-lg px-3 py-2 text-left text-sm font-semibold text-rose-700 hover:bg-rose-50">Log out</button>
                </div>
              )}
            </div>
          ) : <>
            <Link href="/login" className="text-sm font-semibold text-sailcloth hover:text-white">Log in</Link>
            <Link href="/register" className="rounded-lg border border-soft-aqua/50 px-3 py-1.5 text-sm font-semibold text-sailcloth hover:bg-harbour-mid hover:text-white">Create account</Link>
          </>}
        </div>

        <div className="flex items-center gap-1 lg:hidden">
          <button type="button" aria-label="Search SailorPath" onClick={() => setQuickSearchOpen(true)} className="inline-flex h-10 w-10 items-center justify-center rounded-lg text-sailcloth hover:bg-harbour-mid"><Search className="h-5 w-5" /></button>
          <button type="button" aria-label="Toggle menu" aria-expanded={mobileOpen} onClick={() => setMobileOpen((open) => !open)} className="inline-flex h-10 w-10 items-center justify-center rounded-lg text-sailcloth hover:bg-harbour-mid">{mobileOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}</button>
        </div>
      </div>

      {mobileOpen && <div className="border-t border-harbour-shadow bg-harbour px-3 py-3 lg:hidden">
        <nav aria-label="Mobile public" className="grid gap-1">
          {publicLinks.map(([label, href]) => <Link key={href} href={href} onClick={closeMobile} className="rounded-lg px-3 py-2.5 text-sm font-semibold hover:bg-harbour-mid">{label}</Link>)}
        </nav>
        <div className="mt-3 border-t border-harbour-shadow pt-3">
          {email ? <div className="grid gap-1"><Link href="/account" onClick={closeMobile} className="rounded-lg px-3 py-2.5 text-sm font-semibold hover:bg-harbour-mid">Account</Link><Link href="/account/parent" onClick={closeMobile} className="rounded-lg px-3 py-2.5 text-sm font-semibold hover:bg-harbour-mid">Parent workspace</Link><Link href="/account/coach" onClick={closeMobile} className="rounded-lg px-3 py-2.5 text-sm font-semibold hover:bg-harbour-mid">Coach workspace</Link></div> : <div className="grid grid-cols-2 gap-2"><Link href="/login" onClick={closeMobile} className="rounded-lg border border-soft-aqua/50 px-3 py-2.5 text-center text-sm font-semibold">Log in</Link><Link href="/register" onClick={closeMobile} className="rounded-lg bg-racing-orange px-3 py-2.5 text-center text-sm font-semibold text-white">Create account</Link></div>}
        </div>
      </div>}
      {quickSearchOpen && <QuickSearchModal isOpen onClose={() => setQuickSearchOpen(false)} />}
    </header>
  );
}
