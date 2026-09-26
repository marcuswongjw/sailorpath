"use client";

import React, { useState, useEffect, useRef } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import {
  Search,
  X,
  Trophy,
  User,
  ChevronRight,
  Loader2,
  ArrowRight,
  GraduationCap,
} from "lucide-react";
import type { SailorSearchResult, RegattaSearchResult } from "@/lib/search";

export type QuickSearchModalProps = {
  isOpen: boolean;
  onClose: () => void;
};

export function QuickSearchModal({ isOpen, onClose }: QuickSearchModalProps) {
  const router = useRouter();
  const [query, setQuery] = useState("");
  const [sailors, setSailors] = useState<SailorSearchResult[]>([]);
  const [regattas, setRegattas] = useState<RegattaSearchResult[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [selectedIndex, setSelectedIndex] = useState(0);

  const inputRef = useRef<HTMLInputElement>(null);
  const containerRef = useRef<HTMLDivElement>(null);
  const abortControllerRef = useRef<AbortController | null>(null);

  // Focus input when opened
  useEffect(() => {
    if (isOpen) {
      setQuery("");
      setSailors([]);
      setRegattas([]);
      setSelectedIndex(0);
      setTimeout(() => {
        inputRef.current?.focus();
      }, 50);
    }
  }, [isOpen]);

  // Handle escape and click outside
  useEffect(() => {
    if (!isOpen) return;

    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape") {
        e.preventDefault();
        onClose();
      }
    };

    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [isOpen, onClose]);

  // Debounced search
  useEffect(() => {
    if (!isOpen) return;

    if (!query.trim()) {
      setSailors([]);
      setRegattas([]);
      setIsLoading(false);
      return;
    }

    if (abortControllerRef.current) {
      abortControllerRef.current.abort();
    }

    const controller = new AbortController();
    abortControllerRef.current = controller;

    const timer = setTimeout(async () => {
      setIsLoading(true);
      try {
        const res = await fetch(`/api/search?q=${encodeURIComponent(query.trim())}&limit=8`, {
          signal: controller.signal,
        });
        if (res.ok) {
          const data = await res.json();
          setSailors(data.sailors || []);
          setRegattas(data.regattas || []);
          setSelectedIndex(0);
        }
      } catch (err: any) {
        if (err.name !== "AbortError") {
          console.error("Quick search fetch error:", err);
        }
      } finally {
        setIsLoading(false);
      }
    }, 180);

    return () => {
      clearTimeout(timer);
      controller.abort();
    };
  }, [query, isOpen]);

  // Combined flat items for keyboard arrow navigation
  const flatItems = [
    ...regattas.map((r) => ({ type: "regatta" as const, item: r })),
    ...sailors.map((s) => ({ type: "sailor" as const, item: s })),
  ];

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === "ArrowDown") {
      e.preventDefault();
      setSelectedIndex((prev) => (prev + 1 < flatItems.length ? prev + 1 : 0));
    } else if (e.key === "ArrowUp") {
      e.preventDefault();
      setSelectedIndex((prev) => (prev - 1 >= 0 ? prev - 1 : flatItems.length - 1));
    } else if (e.key === "Enter" && flatItems[selectedIndex]) {
      e.preventDefault();
      const selected = flatItems[selectedIndex];
      if (selected.type === "regatta") {
        router.push(selected.item.href);
      } else {
        router.push(`/${selected.item.handle}`);
      }
      onClose();
    }
  };

  if (!isOpen) return null;

  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-label="Quick search modal"
      className="fixed inset-0 z-[100] flex items-start justify-center p-3 sm:p-6 sm:pt-20 bg-slate-950/70 backdrop-blur-xs animate-in fade-in duration-150"
      onClick={(e) => {
        if (e.target === e.currentTarget) onClose();
      }}
    >
      <div
        ref={containerRef}
        className="w-full max-w-xl rounded-3xl bg-white shadow-2xl border border-slate-200 overflow-hidden flex flex-col max-h-[min(85vh,640px)] animate-in zoom-in-95 duration-150"
      >
        {/* Search Input Bar */}
        <div className="flex items-center gap-3 px-4 py-3.5 border-b border-slate-100 bg-slate-50/50">
          {isLoading ? (
            <Loader2 className="h-5 w-5 text-orange-500 animate-spin shrink-0" />
          ) : (
            <Search className="h-5 w-5 text-slate-400 shrink-0" />
          )}

          <input
            ref={inputRef}
            type="search"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            onKeyDown={handleKeyDown}
            placeholder="Type a sailor name, sail # (e.g. 4652), club, or regatta…"
            enterKeyHint="search"
            aria-label="Search"
            className="w-full bg-transparent text-sm sm:text-base text-slate-900 placeholder:text-slate-400 focus:outline-none"
            autoComplete="off"
            autoCorrect="off"
            spellCheck="false"
          />

          {query && (
            <button
              type="button"
              onClick={() => {
                setQuery("");
                inputRef.current?.focus();
              }}
              className="p-1 rounded-full text-slate-400 hover:text-slate-700 hover:bg-slate-200/60 transition-colors shrink-0"
              aria-label="Clear query"
            >
              <X className="h-4 w-4" />
            </button>
          )}

          <button
            type="button"
            onClick={onClose}
            className="text-xs font-semibold text-slate-400 hover:text-slate-600 px-2 py-1 rounded-md bg-slate-100 hover:bg-slate-200 transition-colors shrink-0"
          >
            Esc
          </button>
        </div>

        {/* Results Area */}
        <div className="overflow-y-auto p-2 space-y-3">
          {flatItems.length > 0 ? (
            <>
              {regattas.length > 0 && (
                <div className="space-y-1">
                  <p className="px-3 py-1 text-[11px] font-bold uppercase tracking-wider text-slate-400 flex items-center gap-1.5">
                    <Trophy className="h-3 w-3 text-amber-500" />
                    Regattas &amp; Events
                  </p>
                  {regattas.map((reg, idx) => {
                    const isSelected = selectedIndex === idx;
                    return (
                      <Link
                        key={reg.id}
                        href={reg.href}
                        onClick={onClose}
                        className={`flex items-center justify-between gap-3 px-3 py-2.5 rounded-2xl transition-colors ${
                          isSelected
                            ? "bg-orange-500 text-white"
                            : "hover:bg-slate-100 text-slate-900"
                        }`}
                      >
                        <div className="min-w-0">
                          <p className={`text-xs font-bold truncate ${isSelected ? "text-white" : "text-slate-900"}`}>
                            {reg.name}
                          </p>
                          <p className={`text-[11px] truncate ${isSelected ? "text-orange-100" : "text-slate-500"}`}>
                            {reg.date} {reg.venue ? `· ${reg.venue}` : ""}
                          </p>
                        </div>
                        <ChevronRight className={`h-4 w-4 shrink-0 ${isSelected ? "text-white" : "text-slate-300"}`} />
                      </Link>
                    );
                  })}
                </div>
              )}

              {sailors.length > 0 && (
                <div className="space-y-1">
                  <p className="px-3 py-1 text-[11px] font-bold uppercase tracking-wider text-slate-400 flex items-center gap-1.5">
                    <User className="h-3 w-3 text-slate-400" />
                    Sailors
                  </p>
                  {sailors.map((s, idx) => {
                    const itemIndex = regattas.length + idx;
                    const isSelected = selectedIndex === itemIndex;
                    return (
                      <Link
                        key={s.id}
                        href={`/${s.handle}`}
                        onClick={onClose}
                        className={`flex items-center justify-between gap-3 px-3 py-2.5 rounded-2xl transition-colors ${
                          isSelected
                            ? "bg-slate-900 text-white"
                            : "hover:bg-slate-100 text-slate-900"
                        }`}
                      >
                        <div className="flex items-center gap-2.5 min-w-0">
                          <span className={`h-8 w-8 rounded-full flex items-center justify-center text-xs font-black shrink-0 ${
                            isSelected ? "bg-white/20 text-white" : "bg-slate-100 text-slate-700"
                          }`}>
                            {s.name.charAt(0).toUpperCase()}
                          </span>

                          <div className="min-w-0">
                            <div className="flex items-center gap-1.5">
                              <span className={`text-xs font-bold truncate ${isSelected ? "text-white" : "text-slate-900"}`}>
                                {s.name}
                              </span>
                              <span className={`px-1.5 py-0.5 rounded text-[10px] font-mono font-bold shrink-0 ${
                                isSelected ? "bg-white/20 text-white" : "bg-slate-100 text-slate-700"
                              }`}>
                                {s.sailNumber.startsWith("SGP") ? s.sailNumber : `SGP ${s.sailNumber}`}
                              </span>
                            </div>
                            <p className={`text-[11px] truncate ${isSelected ? "text-slate-300" : "text-slate-500"}`}>
                              {s.club} {s.school ? `· ${s.school}` : ""}
                            </p>
                          </div>
                        </div>

                        <div className="flex items-center gap-1.5 shrink-0">
                          {s.activeFleet === "Gold" && (
                            <span className="text-xs" title="Gold Fleet">🥇</span>
                          )}
                          {s.activeFleet === "Silver" && (
                            <span className="text-xs" title="Silver Fleet">🥈</span>
                          )}
                          <ChevronRight className={`h-4 w-4 shrink-0 ${isSelected ? "text-white" : "text-slate-300"}`} />
                        </div>
                      </Link>
                    );
                  })}
                </div>
              )}

              {/* View all results on /search link */}
              <div className="pt-2 border-t border-slate-100 px-2 pb-1">
                <Link
                  href={`/search?q=${encodeURIComponent(query.trim())}`}
                  onClick={onClose}
                  className="flex items-center justify-between px-3 py-2 rounded-xl text-xs font-bold text-orange-600 hover:bg-orange-50 transition-colors"
                >
                  <span>View all results on Search page</span>
                  <ArrowRight className="h-3.5 w-3.5" />
                </Link>
              </div>
            </>
          ) : query ? (
            <div className="p-6 text-center text-slate-500 space-y-1">
              <p className="text-xs font-semibold text-slate-700">No quick results for &ldquo;{query}&rdquo;</p>
              <p className="text-[11px] text-slate-400">
                Press Enter or{" "}
                <Link
                  href={`/search?q=${encodeURIComponent(query.trim())}`}
                  onClick={onClose}
                  className="text-orange-600 font-bold hover:underline"
                >
                  view the full search page
                </Link>{" "}
                with all filters.
              </p>
            </div>
          ) : (
            <div className="p-6 text-center text-slate-400 text-xs">
              Search by sailor name, sail number (e.g. 4652), club (e.g. CSC), or regatta title.
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
