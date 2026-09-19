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
    <header className="sticky top-0 z-50 border-b border-amber-500/30 bg-[#0d1017]/95 backdrop-blur-md">
      <div className="mx-auto max-w-7xl px-3 sm:px-6 py-2.5">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          {/* Brand & Demo Pill */}
          <div className="flex items-center gap-3">
            <Link
              href="/"
              className="inline-flex items-center gap-1.5 text-xs font-semibold text-slate-400 hover:text-white transition-colors"
              title="Return to Home"
            >
              <ArrowLeft className="h-3.5 w-3.5" />
              <span className="hidden sm:inline">Exit Demo</span>
            </Link>
            <div className="h-4 w-px bg-white/10 hidden sm:block" />
            <div className="flex items-center gap-2">
              <span className="inline-flex items-center gap-1 rounded-full bg-amber-500/15 border border-amber-500/30 px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider text-amber-300">
                <Sparkles className="h-3 w-3" />
                Interactive Demo
              </span>
              <span className="text-xs font-bold text-white hidden md:inline">
                SailorPath Role Experiences
              </span>
            </div>
          </div>

          {/* Three Dedicated Demos Switcher */}
          <nav
            className="flex items-center gap-1 p-1 rounded-2xl bg-black/50 border border-white/10 self-stretch sm:self-auto overflow-x-auto"
            aria-label="Demo hubs"
          >
            <Link
              href="/sample"
              className={`flex-1 sm:flex-none inline-flex items-center justify-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                activeDemo === "sailor"
                  ? "bg-orange-600 text-white shadow-sm shadow-orange-900/50"
                  : "text-slate-400 hover:text-white hover:bg-white/5"
              }`}
            >
              <User className="h-3.5 w-3.5 shrink-0" />
              <span>Sailor Profile</span>
            </Link>

            <Link
              href="/demo/parent"
              className={`flex-1 sm:flex-none inline-flex items-center justify-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                activeDemo === "parent"
                  ? "bg-emerald-600 text-white shadow-sm shadow-emerald-900/50"
                  : "text-slate-400 hover:text-white hover:bg-white/5"
              }`}
            >
              <Heart className="h-3.5 w-3.5 shrink-0" />
              <span>Parent Hub</span>
            </Link>

            <Link
              href="/demo/coach"
              className={`flex-1 sm:flex-none inline-flex items-center justify-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                activeDemo === "coach"
                  ? "bg-sky-600 text-white shadow-sm shadow-sky-900/50"
                  : "text-slate-400 hover:text-white hover:bg-white/5"
              }`}
            >
              <ClipboardList className="h-3.5 w-3.5 shrink-0" />
              <span>Coach Hub</span>
            </Link>
          </nav>

          {/* Quick CTAs */}
          <div className="flex items-center gap-2 shrink-0 self-end sm:self-auto">
            <Link
              href="/login"
              className="text-xs font-semibold text-slate-300 hover:text-white px-2.5 py-1"
            >
              Sign in
            </Link>
            <Link
              href="/register"
              className="rounded-xl bg-white/10 hover:bg-white/15 border border-white/15 px-3 py-1.5 text-xs font-bold text-white transition-colors"
            >
              Sign up
            </Link>
          </div>
        </div>

        {/* Sub-view toggle for Sailor Demo (Public vs Athlete Owner) */}
        {activeDemo === "sailor" && onSailorViewChange && (
          <div className="mt-2.5 pt-2.5 border-t border-white/5 flex flex-col sm:flex-row sm:items-center justify-between gap-2">
            <div className="flex items-center gap-2">
              <span className="text-[11px] font-bold text-slate-400 uppercase tracking-wider">
                Profile Perspective:
              </span>
              <div className="flex items-center gap-1 bg-black/40 border border-white/10 p-0.5 rounded-lg">
                <button
                  type="button"
                  onClick={() => onSailorViewChange("public")}
                  className={`px-2.5 py-1 rounded-md text-[11px] font-bold transition-all ${
                    sailorViewMode === "public"
                      ? "bg-orange-600 text-white"
                      : "text-slate-400 hover:text-white"
                  }`}
                >
                  Public View
                </button>
                <button
                  type="button"
                  onClick={() => onSailorViewChange("sailor")}
                  className={`px-2.5 py-1 rounded-md text-[11px] font-bold transition-all ${
                    sailorViewMode === "sailor"
                      ? "bg-orange-600 text-white"
                      : "text-slate-400 hover:text-white"
                  }`}
                >
                  Sailor Private View
                </button>
              </div>
            </div>

            <p className="text-[11px] text-slate-400">
              {sailorViewMode === "public"
                ? "Public view: what clubs, scouts, and competitors see (no private locker or notes)."
                : "Sailor view: private equipment locker, private notes, and personal verified logbook."}
            </p>
          </div>
        )}
      </div>
    </header>
  );
}
