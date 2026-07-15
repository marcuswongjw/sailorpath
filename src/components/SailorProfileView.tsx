"use client";

import { useState } from "react";
import Image from "next/image";
import Link from "next/link";
import { getPercentileBadge } from "@/lib/ranking";
import {
  Trophy,
  Scale,
  Calendar,
  Compass,
  Eye,
  EyeOff,
  User,
  Users,
  Settings,
  Shield,
  ChevronDown,
  ChevronUp,
  MapPin,
  TrendingUp,
} from "lucide-react";

interface SailorProfileViewProps {
  initialSailor: any;
  initialResults: any[];
  initialEquipment: any;
}

export function SailorProfileView({
  initialSailor,
  initialResults,
  initialEquipment,
}: SailorProfileViewProps) {
  // Demo interactive states
  const [viewAs, setViewAs] = useState<"public" | "owner" | "parent" | "coach" | "admin">("public");
  
  // Privacy states
  const [isPublicWeight, setIsPublicWeight] = useState(initialSailor.isPublicWeight || false);
  const [isPublicDob, setIsPublicDob] = useState(initialSailor.isPublicDob || false);
  const [isPublicEquipment, setIsPublicEquipment] = useState(initialSailor.isPublicEquipment || false);

  // Pagination limit
  const [visibleCount, setVisibleCount] = useState(15);
  
  // Expanded race detail view
  const [expandedRegattaId, setExpandedRegattaId] = useState<string | null>(null);

  // Check visibility rights
  const hasPrivateAccess =
    viewAs === "owner" ||
    viewAs === "parent" ||
    viewAs === "coach" ||
    viewAs === "admin";

  const showWeight = isPublicWeight || hasPrivateAccess;
  const showDob = isPublicDob || hasPrivateAccess;
  const showEquipment = isPublicEquipment || hasPrivateAccess;

  // Dynamic Honors Chips
  const honors = [
    { text: "🇸🇬 IODA Worlds Rep", className: "bg-red-500/10 text-red-400 border border-red-500/20" },
    { text: "🥇 National Champion", className: "bg-amber-500/10 text-amber-400 border border-amber-500/20" },
    { text: "🏆 Top 3 Girls", className: "bg-pink-500/10 text-pink-400 border border-pink-500/20" },
  ];

  // Calculate age
  const calculateAge = (dobString: string) => {
    if (!dobString) return "N/A";
    const today = new Date();
    const birthDate = new Date(dobString);
    let age = today.getFullYear() - birthDate.getFullYear();
    const m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }
    return age;
  };

  // Mock race details for logbook timeline expansion
  const getMockRaceDetails = (regattaName: string, overallRank: number) => {
    return [
      { race: "Race 1", rank: Math.max(1, overallRank - 2), wind: "8-10 kts", notes: "Good start on pin end, held lane." },
      { race: "Race 2", rank: overallRank + 4, wind: "12 kts", notes: "Got caught in traffic at windward mark." },
      { race: "Race 3", rank: Math.max(1, overallRank - 1), wind: "10 kts", notes: "Solid downwind speed, gained 3 boats." },
      { race: "Race 4", rank: overallRank, wind: "9 kts", notes: "Clean racing, consolidated position." },
      { race: "Race 5", rank: Math.max(1, overallRank - 3), wind: "7 kts", notes: "Great shifts on the right side of the course." },
    ];
  };

  return (
    <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-8 flex-1 flex flex-col gap-8">
      {/* View As Simulator Control Panel */}
      <div className="glass-panel rounded-2xl p-4 flex flex-col sm:flex-row items-center justify-between gap-4 border border-white/5">
        <div className="flex items-center gap-2 text-xs font-semibold text-slate-400">
          <Eye className="h-4 w-4 text-orange-500" />
          <span>SIMULATE ACCESS LEVEL (RLS):</span>
        </div>
        <div className="flex flex-wrap gap-1.5">
          {(["public", "owner", "parent", "coach", "admin"] as const).map((role) => (
            <button
              key={role}
              onClick={() => setViewAs(role)}
              className={`rounded-full px-3 py-1 text-xs font-bold transition-all capitalize border ${
                viewAs === role
                  ? "bg-orange-600 text-white border-orange-500"
                  : "bg-slate-800 text-slate-400 border-white/5 hover:text-white"
              }`}
            >
              {role === "owner" ? "Sailor (Self)" : role === "admin" ? "Superadmin" : role}
            </button>
          ))}
        </div>
      </div>

      {/* Main Profile Header Section */}
      <div className="glass-panel rounded-3xl p-6 md:p-8 border border-white/5 relative overflow-hidden flex flex-col md:flex-row items-center md:items-start justify-between gap-6">
        <div className="absolute top-0 right-0 w-64 h-64 bg-orange-600/5 rounded-full blur-3xl -z-10" />

        <div className="flex flex-col md:flex-row items-center gap-6">
          {/* Sailor Profile Image */}
          <div className="relative h-32 w-32 md:h-36 md:w-36 rounded-full overflow-hidden border-2 border-orange-500/20 shadow-xl">
            <Image
              src="/avatar-demo.png"
              alt={initialSailor.name}
              fill
              className="object-cover"
              priority
            />
          </div>

          {/* Sailor Identity */}
          <div className="text-center md:text-left">
            <div className="flex flex-col md:flex-row md:items-center gap-3">
              <h1 className="text-3xl font-black text-white tracking-tight">
                {initialSailor.name}
              </h1>
              <span className="self-center inline-flex items-center rounded-full bg-emerald-500/10 px-3 py-0.5 text-xs font-bold text-emerald-400 border border-emerald-500/20">
                {initialSailor.goldEntryDate ? "Gold Fleet" : "Silver Fleet"}
              </span>
            </div>
            
            <p className="mt-2 text-slate-400 flex flex-wrap items-center justify-center md:justify-start gap-x-3 gap-y-1.5 text-sm font-medium">
              <span className="flex items-center gap-1">
                <MapPin className="h-4 w-4 text-orange-500" />
                {initialSailor.club}
              </span>
              {(initialSailor.instagram || initialSailor.facebook) && (
                <span className="text-slate-700 hidden md:inline">|</span>
              )}
              {initialSailor.instagram && (
                <a
                  href={`https://instagram.com/${initialSailor.instagram.replace('@', '')}`}
                  target="_blank"
                  rel="noreferrer"
                  className="text-slate-400 hover:text-orange-500 transition-colors text-xs font-semibold flex items-center gap-1.5"
                >
                  <svg className="h-3.5 w-3.5 text-orange-500" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zM12 0C8.741 0 8.333.014 7.053.072 2.695.272.273 2.69.073 7.051.014 8.333 0 8.741 0 12c0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98C15.668.014 15.259 0 12 0zm0 5.838a6.162 6.162 0 100 12.324 6.162 6.162 0 000-12.324zM12 16a4 4 0 110-8 4 4 0 010 8zm6.406-11.845a1.44 1.44 0 100 2.881 1.44 1.44 0 000-2.881z" />
                  </svg>
                  {initialSailor.instagram}
                </a>
              )}
              {initialSailor.facebook && (
                <a
                  href={`https://facebook.com/${initialSailor.facebook}`}
                  target="_blank"
                  rel="noreferrer"
                  className="text-slate-400 hover:text-blue-500 transition-colors text-xs font-semibold flex items-center gap-1.5"
                >
                  <svg className="h-3.5 w-3.5 text-blue-500" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M22 12c0-5.523-4.477-10-10-10S2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.988C18.343 21.128 22 16.991 22 12z" />
                  </svg>
                  Facebook
                </a>
              )}
            </p>

            {initialSailor.bio && (
              <p className="mt-3 text-xs md:text-sm text-slate-300 italic max-w-md bg-white/5 px-3 py-2 rounded-xl border border-white/5">
                "{initialSailor.bio}"
              </p>
            )}

            <div className="mt-4 flex flex-wrap justify-center md:justify-start gap-2">
              {honors.map((h, idx) => (
                <span
                  key={idx}
                  className={`rounded-full px-3 py-0.5 text-xs font-semibold ${h.className}`}
                >
                  {h.text}
                </span>
              ))}
            </div>
          </div>
        </div>

        {/* Big Badge Sail Number */}
        <div className="text-center md:text-right border-t md:border-t-0 border-white/5 pt-4 md:pt-0 w-full md:w-auto">
          <span className="block text-xs font-bold text-slate-500 tracking-widest uppercase">
            SAIL NUMBER
          </span>
          <span className="block text-4xl md:text-5xl font-black text-orange-500 tracking-tight mt-1 font-mono">
            {initialSailor.sailNumber}
          </span>
        </div>
      </div>

      {/* Grid of Stats and Equipment Log */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Core Stats Card */}
        <div className="glass-card rounded-2xl p-6 border border-white/5 flex flex-col justify-between">
          <h2 className="text-sm font-bold text-slate-400 tracking-wider uppercase mb-6 flex items-center gap-2">
            <TrendingUp className="h-4 w-4 text-orange-500" />
            Athlete Statistics
          </h2>

          <div className="grid grid-cols-2 gap-4">
            {/* Stat: Age */}
            <div className="bg-white/5 border border-white/5 rounded-xl p-4 text-center">
              <span className="block text-xs text-slate-500 font-bold uppercase">AGE</span>
              <span className="block text-2xl font-extrabold text-white mt-1">
                {calculateAge(initialSailor.dob)} yrs
              </span>
            </div>

            {/* Stat: Weight */}
            <div className="bg-white/5 border border-white/5 rounded-xl p-4 text-center">
              <span className="block text-xs text-slate-500 font-bold uppercase">WEIGHT</span>
              <span className="block text-2xl font-extrabold text-white mt-1 font-mono">
                {showWeight ? `${initialSailor.weight} kg` : "Private"}
              </span>
              {!showWeight && (
                <span className="text-[10px] text-slate-500 mt-1 block flex items-center justify-center gap-0.5">
                  <EyeOff className="h-3 w-3" /> Locked
                </span>
              )}
            </div>

            {/* Stat: Regattas Logged */}
            <div className="bg-white/5 border border-white/5 rounded-xl p-4 text-center">
              <span className="block text-xs text-slate-500 font-bold uppercase">REGATTAS</span>
              <span className="block text-2xl font-extrabold text-orange-500 mt-1">
                {initialResults.length}
              </span>
            </div>

            {/* Stat: Rank */}
            <div className="bg-white/5 border border-white/5 rounded-xl p-4 text-center">
              <span className="block text-xs text-slate-500 font-bold uppercase">RANKING</span>
              <span className="block text-2xl font-extrabold text-white mt-1">
                #3
              </span>
            </div>
          </div>
        </div>

        {/* Equipment Log Card */}
        <div className={`glass-card rounded-2xl p-6 border border-white/5 flex flex-col justify-between ${
          !hasPrivateAccess ? "lg:col-span-2" : ""
        }`}>
          <h2 className="text-sm font-bold text-slate-400 tracking-wider uppercase mb-6 flex items-center gap-2">
            <Compass className="h-4 w-4 text-orange-500" />
            Equipment & Rig Log
          </h2>

          {showEquipment && initialEquipment ? (
            <div className="space-y-4 font-medium text-sm">
              <div className="flex justify-between border-b border-white/5 pb-2">
                <span className="text-slate-500">Hull Brand</span>
                <span className="text-white font-bold">{initialEquipment.hullBrand}</span>
              </div>
              <div className="flex justify-between border-b border-white/5 pb-2">
                <span className="text-slate-500">Sail Make</span>
                <span className="text-white font-bold">{initialEquipment.sailMake}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-500">Foil Brand</span>
                <span className="text-white font-bold">{initialEquipment.foilBrand}</span>
              </div>
            </div>
          ) : (
            <div className="flex-1 flex flex-col items-center justify-center text-center p-4">
              <EyeOff className="h-8 w-8 text-slate-600 mb-2" />
              <p className="text-xs text-slate-400">Equipment log is private.</p>
              {hasPrivateAccess && (
                <p className="text-[10px] text-slate-500 mt-1">
                  (Simulating {viewAs} view - toggle privacy settings below to test)
                </p>
              )}
            </div>
          )}
        </div>

        {/* Settings / Privacy Control (Self / Parent / Admin only) */}
        {(viewAs === "owner" || viewAs === "parent" || viewAs === "admin") && (
          <div className="glass-card rounded-2xl p-6 border border-white/5 flex flex-col justify-between">
            <h2 className="text-sm font-bold text-slate-400 tracking-wider uppercase mb-6 flex items-center gap-2">
              <Settings className="h-4 w-4 text-orange-500" />
              Privacy Toggles
            </h2>

            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <label className="text-xs font-semibold text-slate-300">Share Weight</label>
                <input
                  type="checkbox"
                  checked={isPublicWeight}
                  onChange={(e) => setIsPublicWeight(e.target.checked)}
                  className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                />
              </div>
              <div className="flex items-center justify-between border-t border-white/5 pt-3">
                <label className="text-xs font-semibold text-slate-300">Share Equipment Log</label>
                <input
                  type="checkbox"
                  checked={isPublicEquipment}
                  onChange={(e) => setIsPublicEquipment(e.target.checked)}
                  className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                />
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Logbook Timeline */}
      <div className="glass-panel rounded-3xl p-6 md:p-8 border border-white/5">
        <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 mb-8">
          <div>
            <h2 className="text-xl font-bold text-white flex items-center gap-2">
              <Trophy className="h-5 w-5 text-orange-500" />
              Regatta Logbook
            </h2>
            <p className="text-xs text-slate-400 mt-1">
              Historical racing records and percentile badges.
            </p>
          </div>
          <span className="text-xs text-slate-500 font-bold uppercase">
            {initialResults.length} Regattas Tracked
          </span>
        </div>

        {/* Results List */}
        <div className="space-y-4">
          {initialResults.slice(0, visibleCount).map((res) => {
            const { label, className } = getPercentileBadge(res.rank, res.totalFleetSize);
            const isExpanded = expandedRegattaId === res.id;
            
            return (
              <div
                key={res.id}
                className="glass-card rounded-2xl border border-white/5 hover:border-white/10 overflow-hidden transition-all"
              >
                {/* Main Summary Row */}
                <div
                  onClick={() => hasPrivateAccess && setExpandedRegattaId(isExpanded ? null : res.id)}
                  className={`p-5 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 ${
                    hasPrivateAccess ? "cursor-pointer hover:bg-white/5" : ""
                  } transition-colors`}
                >
                  <div className="flex-1">
                    <h3 className="text-base font-bold text-white">{res.regattaName}</h3>
                    <p className="text-xs text-slate-500 mt-1 font-semibold">{res.regattaDate}</p>
                  </div>
                  
                  <div className="flex items-center gap-4 w-full sm:w-auto justify-between sm:justify-end">
                    <div className="text-left sm:text-right font-semibold text-sm">
                      <span className="block text-xs text-slate-500 uppercase">Rank</span>
                      <span className="text-white text-lg font-black">{res.rank}</span>
                      <span className="text-slate-400 text-xs"> / {res.totalFleetSize}</span>
                    </div>

                    <div className="text-left sm:text-right font-semibold text-sm">
                      <span className="block text-xs text-slate-500 uppercase">Nett</span>
                      <span className="text-white text-lg font-black">{res.nettScore}</span>
                    </div>

                    <div className="flex items-center gap-2">
                      <span className={`rounded-full px-2.5 py-0.5 text-xs font-bold ${className}`}>
                        {label}
                      </span>
                      {hasPrivateAccess && (
                        <div>
                          {isExpanded ? (
                            <ChevronUp className="h-4 w-4 text-slate-400" />
                          ) : (
                            <ChevronDown className="h-4 w-4 text-slate-400" />
                          )}
                        </div>
                      )}
                    </div>
                  </div>
                </div>

                {/* Micro-Details Dropdown */}
                {isExpanded && hasPrivateAccess && (
                  <div className="border-t border-white/5 bg-slate-950/30 p-5">
                    <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-4">
                      Race-by-Race Analysis
                    </h4>
                    <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
                      {getMockRaceDetails(res.regattaName, res.rank).map((race, idx) => (
                        <div
                          key={idx}
                          className="bg-[#090a0f] border border-white/5 rounded-xl p-3 flex flex-col justify-between"
                        >
                          <div className="flex justify-between items-center mb-2">
                            <span className="text-xs font-bold text-slate-500">{race.race}</span>
                            <span className="text-[10px] text-slate-400">{race.wind}</span>
                          </div>
                          <p className="text-xl font-black text-white">{race.rank}</p>
                          <p className="text-[10px] text-slate-400 mt-2 italic leading-relaxed border-t border-white/5 pt-1.5">
                            {race.notes}
                          </p>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            );
          })}
        </div>

        {/* Load More Button */}
        {initialResults.length > visibleCount && (
          <div className="mt-8 text-center">
            <button
              onClick={() => setVisibleCount((prev) => prev + 15)}
              className="rounded-full bg-slate-800 px-6 py-2.5 text-sm font-semibold text-slate-200 hover:bg-slate-700 hover:text-white transition-all border border-white/5"
            >
              Load More
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
