"use client";

import Link from "next/link";
import { User, Heart, ClipboardList, ArrowLeft, Sparkles } from "lucide-react";

export type DemoHubTab = "sailor" | "parent" | "coach";

interface DemoNavHeaderProps {
  activeDemo: DemoHubTab;
  sailorViewMode?: "public" | "sailor";
  onSailorViewChange?: (view: "public" | "sailor") => void;
}

export function DemoNavHeader({
  activeDemo,
  sailorViewMode,
  onSailorViewChange,
}: DemoNavHeaderProps) {
  return (
    <header className="sticky top-0 z-50 border-b border-white/10 bg-[var(--sp-harbour-shadow)] text-[var(--sp-sailcloth)] shadow-md">
      <div className="mx-auto max-w-7xl px-3 sm:px-6 py-2.5">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          {/* Brand & Demo Indicator */}
          <div className="flex items-center gap-3">
            <Link
              href="/"
              className="inline-flex items-center gap-1.5 text-xs font-semibold text-[var(--sp-sailcloth)]/80 hover:text-white transition-colors"
              title="Return to SailorPath Home"
            >
              <ArrowLeft className="h-3.5 w-3.5 text-[var(--sp-soft-aqua)]" />
              <span>Exit Demo</span>
            </Link>
            <div className="h-4 w-px bg-white/15 hidden sm:block" />
            <div className="flex items-center gap-2">
              <span className="inline-flex items-center gap-1 rounded-full bg-[var(--sp-racing-orange)]/20 border border-[var(--sp-racing-orange)]/40 px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider text-[var(--sp-racing-mist)]">
                <Sparkles className="h-3 w-3 text-[var(--sp-racing-orange)]" />
                Live Demo
              </span>
              <span className="text-xs font-bold text-white hidden md:inline font-display">
                SailorPath Role Experiences
              </span>
            </div>
          </div>

          {/* 3 Dedicated Demo Hubs Switcher */}
          <nav
            className="flex items-center gap-1 p-1 rounded-2xl bg-black/30 border border-white/10 self-stretch sm:self-auto overflow-x-auto"
            aria-label="Demo role hubs"
          >
            <Link
              href="/sample"
              className={`flex-1 sm:flex-none inline-flex items-center justify-center gap-1.5 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                activeDemo === "sailor"
                  ? "bg-[var(--sp-racing-orange)] text-white shadow-sm"
                  : "text-[var(--sp-sailcloth)]/80 hover:text-white hover:bg-white/5"
              }`}
            >
              <User className="h-3.5 w-3.5 shrink-0" />
              <span>Sailor Profile</span>
            </Link>

            <Link
              href="/demo/parent"
              className={`flex-1 sm:flex-none inline-flex items-center justify-center gap-1.5 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                activeDemo === "parent"
                  ? "bg-[var(--sp-harbour-teal)] text-white shadow-sm"
                  : "text-[var(--sp-sailcloth)]/80 hover:text-white hover:bg-white/5"
              }`}
            >
              <Heart className="h-3.5 w-3.5 shrink-0" />
              <span>Parent Hub</span>
            </Link>

            <Link
              href="/demo/coach"
              className={`flex-1 sm:flex-none inline-flex items-center justify-center gap-1.5 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                activeDemo === "coach"
                  ? "bg-[var(--sp-reef-line)] text-white shadow-sm"
                  : "text-[var(--sp-sailcloth)]/80 hover:text-white hover:bg-white/5"
              }`}
            >
              <ClipboardList className="h-3.5 w-3.5 shrink-0" />
              <span>Coach Hub</span>
            </Link>
          </nav>

          {/* Quick CTAs */}
          <div className="flex items-center gap-2.5 shrink-0 self-end sm:self-auto">
            <Link
              href="/login"
              className="text-xs font-semibold text-[var(--sp-sailcloth)] hover:text-white px-2 py-1 transition-colors"
            >
              Sign in
            </Link>
            <Link
              href="/register"
              className="rounded-xl bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] text-white px-3.5 py-1.5 text-xs font-bold transition-colors shadow-xs"
            >
              Get started
            </Link>
          </div>
        </div>

        {/* Sub-view toggle for Sailor Demo (Public vs Sailor Private View) */}
        {activeDemo === "sailor" && onSailorViewChange && (
          <div className="mt-2.5 pt-2.5 border-t border-white/10 flex flex-col sm:flex-row sm:items-center justify-between gap-2 text-xs">
            <div className="flex items-center gap-2">
              <span className="text-[11px] font-bold text-[var(--sp-soft-aqua)] uppercase tracking-wider">
                Profile View:
              </span>
              <div className="flex items-center gap-1 bg-black/30 border border-white/10 p-0.5 rounded-lg">
                <button
                  type="button"
                  onClick={() => onSailorViewChange("public")}
                  className={`px-3 py-1 rounded-md text-[11px] font-bold transition-all ${
                    sailorViewMode === "public"
                      ? "bg-[var(--sp-racing-orange)] text-white shadow-xs"
                      : "text-[var(--sp-sailcloth)]/80 hover:text-white"
                  }`}
                >
                  Public View
                </button>
                <button
                  type="button"
                  onClick={() => onSailorViewChange("sailor")}
                  className={`px-3 py-1 rounded-md text-[11px] font-bold transition-all ${
                    sailorViewMode === "sailor"
                      ? "bg-[var(--sp-racing-orange)] text-white shadow-xs"
                      : "text-[var(--sp-sailcloth)]/80 hover:text-white"
                  }`}
                >
                  Sailor Private View
                </button>
              </div>
            </div>

            <p className="text-[11px] text-[var(--sp-sailcloth)]/75">
              {sailorViewMode === "public"
                ? "Public view: what scouts, clubs, and competitors see (no private gear locker or personal notes)."
                : "Sailor private view: athlete logbook, private equipment locker, and private race notes."}
            </p>
          </div>
        )}
      </div>
    </header>
  );
}
