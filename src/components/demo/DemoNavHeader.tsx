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
}: DemoNavHeaderProps) {
  return (
    <header className="sp-reversed sm:sticky sm:top-16 z-30 border-b border-[var(--sp-soft-aqua)]/20 bg-[var(--sp-harbour-shadow)] text-[var(--sp-sailcloth)] shadow-md">
      <div className="mx-auto max-w-7xl px-3 sm:px-6 py-2">
        <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
          {/* Row 1 (mobile): Exit Demo + Live Demo + Login CTA */}
          <div className="flex items-center justify-between gap-2 sm:justify-start sm:gap-3">
            <div className="flex items-center gap-2.5 min-w-0">
              <Link
                href="/"
                className="inline-flex min-h-10 items-center gap-1.5 text-xs font-bold text-[var(--sp-soft-aqua)] hover:text-white transition-colors shrink-0"
                title="Return to SailorPath Home"
              >
                <ArrowLeft className="h-3.5 w-3.5 text-[var(--sp-soft-aqua)]" />
                <span>Exit Demo</span>
              </Link>
              <div className="h-4 w-px bg-[var(--sp-soft-aqua)]/20 hidden sm:block" />
              <div className="flex items-center gap-2 min-w-0">
                <span className="inline-flex items-center gap-1 rounded-full bg-[var(--sp-racing-orange)]/20 border border-[var(--sp-racing-orange)]/40 px-2 py-0.5 text-[11px] font-black uppercase tracking-wider text-[var(--sp-racing-mist)] shrink-0">
                  <Sparkles className="h-3 w-3 text-[var(--sp-racing-orange)]" />
                  Live Demo
                </span>
                <span className="text-xs font-bold !text-[var(--sp-sailcloth)] hidden lg:inline font-display truncate">
                  SailorPath Role Experiences
                </span>
              </div>
            </div>
            <Link
              href="/login"
              className="sm:hidden inline-flex min-h-10 items-center rounded-xl bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] !text-white px-3 text-xs font-bold transition-colors shrink-0"
            >
              Log in
            </Link>
          </div>

          {/* Demo Hubs Switcher (single-row horizontally scrollable on mobile) */}
          <nav
            className="sp-tabs-scroll items-center gap-1 p-1 rounded-2xl bg-[#0c1f22] border border-[var(--sp-soft-aqua)]/25 shadow-inner"
            aria-label="Demo role hubs"
          >
            <Link
              href="/sample"
              className={`min-h-10 sm:min-h-0 flex-1 sm:flex-none inline-flex items-center justify-center gap-1.5 px-3.5 py-1.5 rounded-xl text-[13px] font-bold transition-all whitespace-nowrap ${
                activeDemo === "sailor"
                  ? "bg-[var(--sp-harbour-teal)] !text-white shadow-sm"
                  : "text-[var(--sp-soft-aqua)] hover:text-white hover:bg-white/10"
              }`}
            >
              <User className="h-3.5 w-3.5 shrink-0" />
              <span>Sailor Profile</span>
            </Link>

            <Link
              href="/demo/parent"
              className={`min-h-10 sm:min-h-0 flex-1 sm:flex-none inline-flex items-center justify-center gap-1.5 px-3.5 py-1.5 rounded-xl text-[13px] font-bold transition-all whitespace-nowrap ${
                activeDemo === "parent"
                  ? "bg-[var(--sp-harbour-teal)] !text-white shadow-sm"
                  : "text-[var(--sp-soft-aqua)] hover:text-white hover:bg-white/10"
              }`}
            >
              <Heart className="h-3.5 w-3.5 shrink-0" />
              <span>Parent Hub</span>
            </Link>

            <Link
              href="/demo/coach"
              className={`min-h-10 sm:min-h-0 flex-1 sm:flex-none inline-flex items-center justify-center gap-1.5 px-3.5 py-1.5 rounded-xl text-[13px] font-bold transition-all whitespace-nowrap ${
                activeDemo === "coach"
                  ? "bg-[var(--sp-harbour-teal)] !text-white shadow-sm"
                  : "text-[var(--sp-soft-aqua)] hover:text-white hover:bg-white/10"
              }`}
            >
              <ClipboardList className="h-3.5 w-3.5 shrink-0" />
              <span>Coach Hub</span>
            </Link>
          </nav>

          {/* Desktop Quick CTA */}
          <div className="hidden sm:flex items-center gap-2.5 shrink-0">
            <Link
              href="/login"
              className="rounded-xl bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] !text-white px-3.5 py-1.5 text-sm font-semibold transition-colors shadow-xs"
            >
              Log in or sign up
            </Link>
          </div>
        </div>
      </div>
    </header>
  );
}
