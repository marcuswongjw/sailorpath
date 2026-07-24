"use client";

import { useEffect, useRef, useState } from "react";
import Link from "next/link";
import { getPercentileBadge } from "@/lib/ranking";
import {
  seriesFleetStatus,
  seriesStatusBadge,
} from "@/lib/seriesMembership";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import {
  Trophy,
  Compass,
  EyeOff,
  Settings,
  MapPin,
  TrendingUp,
  User,
  Link2,
  UserPlus,
  Pencil,
  BookOpen,
  ChevronDown,
  ChevronUp,
  Camera,
} from "lucide-react";

interface SailorProfileViewProps {
  initialSailor: any;
  initialResults: any[];
  initialEquipment: any;
  initialSeriesStanding?: {
    periodLabel: string;
    fleet: string;
    overallRank: number;
    fleetSize: number;
    best3of5: number;
    rScores: {
      regattaId: string;
      regattaName: string;
      score: number;
      isDNS?: boolean;
      isOverseasCommitment?: boolean;
      isCarryForward?: boolean;
    }[];
    trendNote: string;
  } | null;
  initialObservations?: any[];
  initialEquipmentHistory?: any[];
  canSeePrivate?: boolean;
  canClaim?: boolean;
  isOwner?: boolean;
  /** Logged-in visitor (not necessarily owner) */
  isLoggedIn?: boolean;
  /** Profile already has an approved parent_id link */
  profileClaimed?: boolean;
  /** Product-tour mode on /sample — claim does not hit the live API */
  demoMode?: boolean;
  demoRole?: "public" | "sailor" | "parent" | "coach";
  onDemoClaim?: () => void;
}

function resolveDisplayFleet(sailor: any): {
  label: string;
  className: string;
} {
  return seriesStatusBadge(seriesFleetStatus(sailor));
}

const SQUAD_HISTORY_SLOTS: {
  key: string;
  label: string;
}[] = [
  { key: "natSquadStatusJan25", label: "Jan – Jun 2025" },
  { key: "natSquadStatusJul25", label: "Jul – Dec 2025" },
  { key: "natSquadStatusJan26", label: "Jan – Jun 2026" },
  { key: "natSquadStatusJul26", label: "Jul – Dec 2026" },
];

function buildHonorTags(sailor: any): { text: string; className: string }[] {
  const tags: { text: string; className: string }[] = [];
  const squad =
    sailor.natSquadStatusJul26 ||
    sailor.nationalSquadStatus ||
    sailor.natSquadStatusJan26;
  if (squad) {
    tags.push({
      text: `Nat Squad (current): ${squad}`,
      className:
        "bg-orange-500/10 text-orange-300 border border-orange-500/25",
    });
  }
  if (sailor.worlds) {
    tags.push({
      text: `World Optimist Championships ${sailor.worlds}`,
      className: "bg-red-500/10 text-red-400 border border-red-500/20",
    });
  }
  if (sailor.european) {
    tags.push({
      text: `European Optimist Championships ${sailor.european}`,
      className: "bg-blue-500/10 text-blue-300 border border-blue-500/20",
    });
  }
  if (sailor.asian) {
    tags.push({
      text: `Asian Optimist Championships ${sailor.asian}`,
      className:
        "bg-emerald-500/10 text-emerald-400 border border-emerald-500/20",
    });
  }
  if (sailor.seaGames) {
    tags.push({
      text: `SEA Games ${sailor.seaGames}`,
      className: "bg-violet-500/10 text-violet-300 border border-violet-500/20",
    });
  }
  return tags;
}

function initials(name: string) {
  const parts = String(name || "")
    .trim()
    .split(/\s+/)
    .filter(Boolean);
  if (!parts.length) return "?";
  if (parts.length === 1) return parts[0].slice(0, 2).toUpperCase();
  return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
}

export function SailorProfileView({
  initialSailor,
  initialResults,
  initialEquipment,
  initialSeriesStanding = null,
  initialObservations = [],
  initialEquipmentHistory = [],
  canSeePrivate = false,
  canClaim = false,
  isOwner = false,
  isLoggedIn = false,
  profileClaimed = false,
  demoMode = false,
  demoRole,
  onDemoClaim,
}: SailorProfileViewProps) {
  const [isPublicWeight, setIsPublicWeight] = useState(
    initialSailor.isPublicWeight || false
  );
  const [isPublicDob, setIsPublicDob] = useState(
    initialSailor.isPublicDob || false
  );
  const [isPublicEquipment, setIsPublicEquipment] = useState(
    initialSailor.isPublicEquipment ?? false
  );
  const [visibleCount, setVisibleCount] = useState(15);
  const [claimStatus, setClaimStatus] = useState<string | null>(null);
  const [claimMsg, setClaimMsg] = useState<string | null>(null);
  const [claimBusy, setClaimBusy] = useState(false);
  const [claimPanelOpen, setClaimPanelOpen] = useState(false);
  const [claimRelation, setClaimRelation] = useState<"sailor" | "parent" | "other">(
    "parent"
  );
  const [claimNote, setClaimNote] = useState("");
  const [copyMsg, setCopyMsg] = useState<string | null>(null);
  const [editing, setEditing] = useState(false);
  const [saveBusy, setSaveBusy] = useState(false);
  const [saveMsg, setSaveMsg] = useState<string | null>(null);
  const [expandedRegattaId, setExpandedRegattaId] = useState<string | null>(null);
  const [observations, setObservations] = useState(initialObservations || []);
  const [obsForm, setObsForm] = useState({
    raceNumber: "",
    position: "",
    wind: "",
    note: "",
    isPrivate: true,
  });
  /** When set, form is editing an existing observation (id may be missing on legacy rows). */
  const [editingObsId, setEditingObsId] = useState<string | null>(null);
  const [obsBusy, setObsBusy] = useState(false);
  const [obsMsg, setObsMsg] = useState<string | null>(null);
  const [form, setForm] = useState({
    bio: initialSailor.bio || "",
    instagram: initialSailor.instagram || "",
    handle: initialSailor.handle || "",
    school: initialSailor.school || "",
    dob: initialSailor.dob
      ? String(initialSailor.dob).slice(0, 10)
      : "",
    weight:
      initialSailor.weight != null ? String(initialSailor.weight) : "",
    hullBrand: initialEquipment?.hullBrand || "",
    sailMake: initialEquipment?.sailMake || "",
    foilBrand: initialEquipment?.foilBrand || "",
    mast: initialEquipment?.mast || "",
    equipmentNotes: initialEquipment?.notes || "",
  });
  const [displaySailor, setDisplaySailor] = useState(initialSailor);
  const [results, setResults] = useState(initialResults || []);
  const [personalForm, setPersonalForm] = useState({
    name: "",
    date: "",
    rank: "",
    fleetSize: "",
    geography: "",
    nett: "",
  });
  const [personalBusy, setPersonalBusy] = useState(false);
  const [personalMsg, setPersonalMsg] = useState<string | null>(null);
  const [displayEquipment, setDisplayEquipment] = useState(initialEquipment);
  const [equipHistory, setEquipHistory] = useState(
    initialEquipmentHistory || []
  );
  const [avatarBusy, setAvatarBusy] = useState(false);
  const [avatarMsg, setAvatarMsg] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    if (!demoMode && isOwner && typeof window !== "undefined") {
      const sp = new URLSearchParams(window.location.search);
      if (sp.get("edit") === "1") setEditing(true);
    }
  }, [demoMode, isOwner]);

  // Load existing claim status for this sailor
  useEffect(() => {
    if (demoMode || !isLoggedIn || !canClaim) return;
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch("/api/claims", { credentials: "include" });
        const data = await res.json();
        if (!res.ok || cancelled) return;
        const mine = (data.claims || []).find(
          (c: any) =>
            c.sailorId === initialSailor.id && c.status === "pending"
        );
        if (mine) {
          setClaimStatus("pending");
          setClaimMsg(
            "Claim pending admin approval — track status on My account."
          );
        }
      } catch {
        /* ignore */
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [demoMode, isLoggedIn, canClaim, initialSailor.id]);

  const hasPrivateAccess = canSeePrivate;
  const showWeight = isPublicWeight || hasPrivateAccess;
  const showDob = isPublicDob || hasPrivateAccess;
  const showEquipment = isPublicEquipment || hasPrivateAccess;

  const saveProfile = async () => {
    if (demoMode) {
      setSaveMsg("Demo only — changes are not saved");
      setTimeout(() => setSaveMsg(null), 2500);
      return;
    }
    setSaveBusy(true);
    setSaveMsg(null);
    try {
      const res = await fetch("/api/account/sailor", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({
          sailorId: initialSailor.id,
          bio: form.bio,
          instagram: form.instagram,
          handle: form.handle,
          school: form.school,
          dob: form.dob === "" ? null : form.dob,
          weight: form.weight === "" ? null : Number(form.weight),
          isPublicWeight,
          isPublicDob,
          isPublicEquipment,
          hullBrand: form.hullBrand,
          sailMake: form.sailMake,
          foilBrand: form.foilBrand,
          mast: form.mast,
          equipmentNotes: form.equipmentNotes,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Save failed");
      setDisplaySailor((s: any) => ({
        ...s,
        ...data.sailor,
        dob: data.sailor.dob ?? (form.dob || s.dob),
      }));
      setDisplayEquipment({
        hullBrand: data.sailor.hullBrand,
        sailMake: data.sailor.sailMake,
        foilBrand: data.sailor.foilBrand,
        mast: data.sailor.mast,
        notes: data.sailor.equipmentNotes,
      });
      setIsPublicWeight(Boolean(data.sailor.isPublicWeight));
      setIsPublicDob(Boolean(data.sailor.isPublicDob));
      setIsPublicEquipment(Boolean(data.sailor.isPublicEquipment));
      if (form.handle) {
        setForm((f) => ({ ...f, handle: data.sailor.handle || f.handle }));
      }
      setSaveMsg("Saved");
      setEditing(false);
      if (data.handleChanged && data.sailor?.handle) {
        window.location.assign(`/${data.sailor.handle}?edit=1`);
        return;
      }
      setTimeout(() => setSaveMsg(null), 2500);
    } catch (e: any) {
      setSaveMsg(e.message || "Save failed");
    } finally {
      setSaveBusy(false);
    }
  };

  const uploadAvatar = async (file: File) => {
    if (demoMode) {
      setAvatarMsg("Demo only — photo not uploaded");
      return;
    }
    if (!file.type.startsWith("image/")) {
      setAvatarMsg("Please choose an image file");
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      setAvatarMsg("Image must be under 5 MB");
      return;
    }
    setAvatarBusy(true);
    setAvatarMsg(null);
    try {
      const supabase = createBrowserSupabase();
      const ext =
        file.type === "image/png"
          ? "png"
          : file.type === "image/webp"
            ? "webp"
            : "jpg";
      const path = `${initialSailor.id}/${Date.now()}.${ext}`;
      const { error: upErr } = await supabase.storage
        .from("avatars")
        .upload(path, file, { upsert: true, contentType: file.type });
      if (upErr) throw upErr;
      const { data: pub } = supabase.storage.from("avatars").getPublicUrl(path);
      const publicUrl = pub.publicUrl;
      const res = await fetch("/api/account/sailor", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({
          sailorId: initialSailor.id,
          avatarUrl: publicUrl,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not save photo");
      setDisplaySailor((s: any) => ({
        ...s,
        avatarUrl: data.sailor.avatarUrl || publicUrl,
      }));
      setAvatarMsg("Photo updated");
      setTimeout(() => setAvatarMsg(null), 2500);
    } catch (e: any) {
      setAvatarMsg(
        e.message ||
          "Upload failed — ensure avatars bucket exists (see docs)"
      );
    } finally {
      setAvatarBusy(false);
    }
  };

  const resetObsForm = () => {
    setEditingObsId(null);
    setObsForm({
      raceNumber: "",
      position: "",
      wind: "",
      note: "",
      isPrivate: true,
    });
  };

  const startEditObservation = (o: any, regattaId: string) => {
    setExpandedRegattaId(regattaId);
    setEditingObsId(o.id || null);
    setObsForm({
      raceNumber: o.raceNumber != null ? String(o.raceNumber) : "",
      position: o.position != null ? String(o.position) : "",
      wind: o.wind || "",
      note: o.note || "",
      isPrivate: o.isPrivate !== false,
    });
    setObsMsg(null);
  };

  const saveObservation = async (regattaId: string) => {
    if (demoMode) {
      setObsMsg("Demo only — not saved");
      return;
    }
    const raceNum = Number(obsForm.raceNumber);
    if (!obsForm.raceNumber.trim() || !Number.isFinite(raceNum) || raceNum < 1) {
      setObsMsg("Enter a race number");
      return;
    }
    setObsBusy(true);
    setObsMsg(null);
    try {
      const res = await fetch("/api/account/observations", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({
          sailorId: initialSailor.id,
          regattaId,
          raceNumber: raceNum,
          position: obsForm.position === "" ? null : Number(obsForm.position),
          wind: obsForm.wind,
          note: obsForm.note,
          isPrivate: obsForm.isPrivate,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Save failed");
      const row = data.observation;
      setObservations((prev: any[]) => {
        const rest = prev.filter(
          (o) =>
            !(
              o.regattaId === row.regattaId &&
              o.raceNumber === row.raceNumber
            )
        );
        return [
          ...rest,
          {
            ...row,
            regattaName:
              prev.find((p) => p.regattaId === row.regattaId)?.regattaName ||
              initialResults.find((r: any) => r.regattaId === regattaId)
                ?.regattaName,
          },
        ].sort(
          (a, b) =>
            String(b.regattaDate || "").localeCompare(String(a.regattaDate || "")) ||
            a.raceNumber - b.raceNumber
        );
      });
      setObsMsg(editingObsId ? "Observation updated" : "Observation saved");
      resetObsForm();
    } catch (e: any) {
      setObsMsg(e.message || "Failed");
    } finally {
      setObsBusy(false);
    }
  };

  const savePersonalResult = async () => {
    if (demoMode) {
      setPersonalMsg("Demo only — not saved");
      return;
    }
    if (!personalForm.name.trim() || !personalForm.date) {
      setPersonalMsg("Event name and date required");
      return;
    }
    setPersonalBusy(true);
    setPersonalMsg(null);
    try {
      const res = await fetch("/api/account/results", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({
          sailorId: initialSailor.id,
          name: personalForm.name.trim(),
          date: personalForm.date,
          rank: personalForm.rank === "" ? 1 : Number(personalForm.rank),
          totalFleetSize:
            personalForm.fleetSize === ""
              ? null
              : Number(personalForm.fleetSize),
          geography: personalForm.geography || "INT",
          nettScore: personalForm.nett === "" ? null : Number(personalForm.nett),
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Save failed");
      if (data.entry) {
        setResults((prev: any[]) =>
          [data.entry, ...prev].sort((a, b) =>
            String(b.regattaDate || "").localeCompare(String(a.regattaDate || ""))
          )
        );
      }
      setPersonalForm({
        name: "",
        date: "",
        rank: "",
        fleetSize: "",
        geography: "",
        nett: "",
      });
      setPersonalMsg("Added to logbook (non-ranking)");
    } catch (e: any) {
      setPersonalMsg(e.message || "Failed");
    } finally {
      setPersonalBusy(false);
    }
  };

  const deletePersonalResult = async (res: any) => {
    if (demoMode || !res?.resultId) return;
    if (!confirm(`Remove “${res.regattaName}” from your logbook?`)) return;
    setPersonalBusy(true);
    try {
      const r = await fetch("/api/account/results", {
        method: "DELETE",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({ resultId: res.resultId }),
      });
      const data = await r.json();
      if (!r.ok) throw new Error(data.error || "Delete failed");
      setResults((prev: any[]) =>
        prev.filter((x) => x.resultId !== res.resultId && x.id !== res.resultId)
      );
      setPersonalMsg("Removed");
    } catch (e: any) {
      setPersonalMsg(e.message || "Delete failed");
    } finally {
      setPersonalBusy(false);
    }
  };

  const deleteObservation = async (o: any) => {
    if (demoMode || !o?.id) return;
    if (!confirm(`Delete observation for race ${o.raceNumber}?`)) return;
    setObsBusy(true);
    setObsMsg(null);
    try {
      const res = await fetch("/api/account/observations", {
        method: "DELETE",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({ id: o.id }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Delete failed");
      setObservations((prev: any[]) => prev.filter((x) => x.id !== o.id));
      if (editingObsId === o.id) resetObsForm();
      setObsMsg("Observation deleted");
    } catch (e: any) {
      setObsMsg(e.message || "Delete failed");
    } finally {
      setObsBusy(false);
    }
  };

  const obsForRegatta = (regattaId: string) =>
    observations
      .filter((o: any) => o.regattaId === regattaId)
      .sort((a: any, b: any) => a.raceNumber - b.raceNumber);

  const fleetBadge = resolveDisplayFleet(displaySailor);
  const honors = buildHonorTags(displaySailor);

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

  return (
    <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-8 flex-1 flex flex-col gap-8">
      {/* Header */}
      <div className="glass-panel rounded-3xl p-6 md:p-8 border border-white/5 relative overflow-hidden flex flex-col md:flex-row items-center md:items-start justify-between gap-6">
        <div className="absolute top-0 right-0 w-64 h-64 bg-orange-600/5 rounded-full blur-3xl -z-10" />

        <div className="flex flex-col md:flex-row items-center gap-6 min-w-0">
          {/* Avatar: photo if set, else initials */}
          <div className="relative h-28 w-28 md:h-32 md:w-32 shrink-0">
            <div className="relative h-full w-full rounded-full border-2 border-orange-500/25 shadow-xl bg-gradient-to-br from-orange-600/30 to-slate-900 flex items-center justify-center overflow-hidden">
              {displaySailor.avatarUrl ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img
                  src={displaySailor.avatarUrl}
                  alt={displaySailor.name}
                  className="h-full w-full object-cover"
                />
              ) : (
                <span className="text-3xl md:text-4xl font-black text-orange-300 tracking-tight">
                  {initials(displaySailor.name)}
                </span>
              )}
            </div>
            {isOwner && !demoMode && (
              <>
                <button
                  type="button"
                  disabled={avatarBusy}
                  onClick={() => fileInputRef.current?.click()}
                  className="absolute inset-0 rounded-full bg-black/45 opacity-0 hover:opacity-100 focus:opacity-100 transition-opacity flex flex-col items-center justify-center gap-1 text-white"
                  title="Upload photo"
                >
                  <Camera className="h-6 w-6" />
                  <span className="text-[10px] font-bold">
                    {avatarBusy ? "…" : "Upload"}
                  </span>
                </button>
                <input
                  ref={fileInputRef}
                  type="file"
                  accept="image/jpeg,image/png,image/webp,image/gif"
                  className="hidden"
                  onChange={(e) => {
                    const f = e.target.files?.[0];
                    if (f) void uploadAvatar(f);
                    e.target.value = "";
                  }}
                />
              </>
            )}
            {!isOwner && (
              <span className="absolute -bottom-1 -right-1 h-8 w-8 rounded-full bg-slate-900 border border-white/10 flex items-center justify-center">
                <User className="h-4 w-4 text-slate-400" />
              </span>
            )}
            {avatarMsg && (
              <p className="absolute -bottom-6 left-1/2 -translate-x-1/2 whitespace-nowrap text-[10px] font-bold text-emerald-300">
                {avatarMsg}
              </p>
            )}
          </div>

          <div className="text-center md:text-left min-w-0">
            <div className="flex flex-col md:flex-row md:items-center gap-2 md:gap-3">
              <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
                {displaySailor.name}
              </h1>
              <span
                className={`self-center inline-flex items-center rounded-full px-3 py-0.5 text-xs font-bold border ${fleetBadge.className}`}
              >
                {fleetBadge.label}
              </span>
            </div>

            <p className="mt-2 text-slate-400 flex flex-wrap items-center justify-center md:justify-start gap-x-3 gap-y-1.5 text-sm font-medium">
              <span className="flex items-center gap-1">
                <MapPin className="h-4 w-4 text-orange-500" />
                {displaySailor.club}
                {displaySailor.school ? ` · ${displaySailor.school}` : ""}
                {displaySailor.nationality
                  ? ` · ${displaySailor.nationality}`
                  : ""}
              </span>
            </p>

            {displaySailor.bio && (
              <p className="mt-3 text-xs md:text-sm text-slate-300 italic max-w-md bg-white/5 px-3 py-2 rounded-xl border border-white/5">
                &ldquo;{displaySailor.bio}&rdquo;
              </p>
            )}

            <div className="mt-4 flex flex-wrap justify-center md:justify-start gap-2">
              {honors.length === 0 ? (
                <span className="text-[11px] text-slate-600">
                  No squad / campaign tags yet
                </span>
              ) : (
                honors.map((h, idx) => (
                  <span
                    key={idx}
                    className={`rounded-full px-3 py-0.5 text-xs font-semibold ${h.className}`}
                  >
                    {h.text}
                  </span>
                ))
              )}
            </div>

            <div className="mt-4 flex flex-wrap justify-center md:justify-start gap-2">
              <button
                type="button"
                onClick={async () => {
                  try {
                    const url = typeof window !== "undefined" ? window.location.href : "";
                    await navigator.clipboard.writeText(url);
                    setCopyMsg("Link copied");
                    setTimeout(() => setCopyMsg(null), 2000);
                  } catch {
                    setCopyMsg("Could not copy");
                  }
                }}
                className="inline-flex items-center gap-1.5 rounded-full bg-white/5 border border-white/10 px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white"
              >
                <Link2 className="h-3.5 w-3.5" />
                {copyMsg || "Copy profile link"}
              </button>
              {!demoMode && !isLoggedIn && !profileClaimed && (
                <Link
                  href={`/login?next=${encodeURIComponent(`/${displaySailor.handle || ""}`)}`}
                  className="inline-flex items-center gap-1.5 rounded-full bg-orange-600/90 hover:bg-orange-500 px-3 py-1.5 text-[11px] font-bold text-white"
                >
                  <UserPlus className="h-3.5 w-3.5" />
                  Log in to claim
                </Link>
              )}
              {canClaim && claimStatus !== "pending" && (
                <button
                  type="button"
                  disabled={demoMode && !onDemoClaim}
                  onClick={() => {
                    if (demoMode) {
                      onDemoClaim?.();
                      return;
                    }
                    setClaimPanelOpen((o) => !o);
                  }}
                  className="inline-flex items-center gap-1.5 rounded-full bg-orange-600/90 hover:bg-orange-500 disabled:opacity-50 px-3 py-1.5 text-[11px] font-bold text-white"
                >
                  <UserPlus className="h-3.5 w-3.5" />
                  {demoMode
                    ? "Claim this profile (demo)"
                    : claimPanelOpen
                      ? "Cancel claim"
                      : "Claim this profile"}
                </button>
              )}
              {canClaim && claimStatus === "pending" && (
                <span className="inline-flex items-center gap-1.5 rounded-full bg-amber-500/15 border border-amber-500/30 px-3 py-1.5 text-[11px] font-bold text-amber-200">
                  Claim pending review
                </span>
              )}
              {isOwner && (
                <>
                  <span className="text-[11px] font-bold text-emerald-400/90 self-center">
                    {demoMode
                      ? demoRole === "parent"
                        ? "Parent view · linked guardian"
                        : "You manage this profile"
                      : "You manage this profile"}
                  </span>
                  <button
                    type="button"
                    onClick={() => setEditing((e) => !e)}
                    className="inline-flex items-center gap-1.5 rounded-full bg-white/5 border border-white/10 px-3 py-1.5 text-[11px] font-bold text-slate-200 hover:text-white"
                  >
                    <Pencil className="h-3.5 w-3.5" />
                    {editing ? "Close editor" : "Edit profile"}
                  </button>
                </>
              )}
            </div>
            {claimPanelOpen && canClaim && !demoMode && claimStatus !== "pending" && (
              <div className="mt-4 rounded-2xl border border-orange-500/25 bg-orange-500/5 p-4 text-left space-y-3 max-w-lg">
                <p className="text-xs font-bold text-white">
                  Verify you are linked to this sailor
                </p>
                <p className="text-[11px] text-slate-400 leading-relaxed">
                  Your <strong className="text-slate-300">signup email</strong> is
                  shown to admins. Tell us your relationship and confirm sail
                  number / club so they can approve safely.
                </p>
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase">
                    I am
                  </label>
                  <select
                    value={claimRelation}
                    onChange={(e) =>
                      setClaimRelation(e.target.value as "sailor" | "parent" | "other")
                    }
                    className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-xs text-white"
                  >
                    <option value="parent">Parent / guardian</option>
                    <option value="sailor">The sailor</option>
                    <option value="other">Coach / other (explain below)</option>
                  </select>
                </div>
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase">
                    Verification note
                  </label>
                  <textarea
                    value={claimNote}
                    onChange={(e) => setClaimNote(e.target.value)}
                    rows={3}
                    placeholder={`e.g. Parent of ${displaySailor.name}. Sail ${displaySailor.sailNumber || "…"}, club ${displaySailor.club || "…"}. Contact via this email.`}
                    className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-xs text-white focus:border-orange-500 focus:outline-none"
                  />
                </div>
                <button
                  type="button"
                  disabled={claimBusy || claimNote.trim().length < 8}
                  onClick={async () => {
                    setClaimBusy(true);
                    setClaimMsg(null);
                    try {
                      await fetch("/api/auth/ensure-profile", {
                        method: "POST",
                        credentials: "include",
                      });
                      const note = `[${claimRelation}] ${claimNote.trim()}`;
                      const res = await fetch("/api/claims", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        credentials: "include",
                        body: JSON.stringify({
                          sailorId: initialSailor.id,
                          note,
                        }),
                      });
                      const data = await res.json();
                      if (!res.ok) throw new Error(data.error || "Claim failed");
                      setClaimStatus("pending");
                      setClaimPanelOpen(false);
                      setClaimMsg(
                        data.message ||
                          "Claim submitted with your email for admin review."
                      );
                    } catch (e: any) {
                      setClaimStatus("error");
                      setClaimMsg(e.message || "Error");
                    } finally {
                      setClaimBusy(false);
                    }
                  }}
                  className="rounded-full bg-orange-600 px-4 py-2 text-[11px] font-bold text-white disabled:opacity-50"
                >
                  {claimBusy ? "Submitting…" : "Submit claim for review"}
                </button>
                {claimNote.trim().length > 0 && claimNote.trim().length < 8 && (
                  <p className="text-[10px] text-amber-300/90">
                    Add a bit more detail (sail #, club, relationship).
                  </p>
                )}
              </div>
            )}
            {claimMsg && (
              <p
                className={`mt-2 text-[11px] text-center md:text-left ${
                  claimStatus === "error" ? "text-rose-300" : "text-emerald-300"
                }`}
              >
                {claimMsg}{" "}
                {claimStatus === "pending" && !demoMode && (
                  <Link href="/account" className="underline font-bold">
                    My account
                  </Link>
                )}
              </p>
            )}
            {saveMsg && (
              <p className="mt-2 text-[11px] text-emerald-300 text-center md:text-left">
                {saveMsg}
              </p>
            )}
          </div>
        </div>

        <div className="text-center md:text-right border-t md:border-t-0 border-white/5 pt-4 md:pt-0 w-full md:w-auto shrink-0">
          <span className="block text-xs font-bold text-slate-500 tracking-widest uppercase">
            Sail number
          </span>
          <span className="block text-3xl md:text-5xl font-black text-orange-500 tracking-tight mt-1 font-mono">
            {displaySailor.sailNumber || "—"}
          </span>
        </div>
      </div>

      {/* Live series standing */}
      {initialSeriesStanding && (
        <div className="glass-panel rounded-2xl border border-orange-500/20 p-4 sm:p-5 md:p-6">
          <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-3 sm:gap-4 mb-3 sm:mb-4">
            <div className="flex items-start gap-2 min-w-0">
              <Trophy className="h-5 w-5 text-orange-500 shrink-0 mt-0.5" />
              <div className="min-w-0">
                <h3 className="text-sm font-black text-white uppercase tracking-wider">
                  Series standing
                </h3>
                <p className="text-[11px] text-slate-500 leading-snug">
                  {initialSeriesStanding.periodLabel}
                  <span className="text-slate-600"> · </span>
                  <span className="text-orange-300/90 font-semibold">
                    {initialSeriesStanding.fleet} fleet
                  </span>
                </p>
              </div>
            </div>
            <div className="flex sm:flex-col items-baseline sm:items-end justify-between sm:justify-start gap-3 sm:gap-0 pl-7 sm:pl-0">
              <div>
                <p className="text-[10px] font-bold text-slate-500 uppercase">
                  Best 3 of 5 (sum of ranks)
                </p>
                <p className="text-2xl sm:text-3xl font-black text-white tabular-nums">
                  {initialSeriesStanding.best3of5}
                </p>
              </div>
              <p className="text-sm font-bold text-orange-400 tabular-nums">
                Series rank #{initialSeriesStanding.overallRank}
                <span className="text-slate-500 font-semibold text-xs ml-1">
                  of {initialSeriesStanding.fleetSize}
                </span>
              </p>
            </div>
          </div>
          <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-2">
            Event ranks (lower is better)
          </p>
          <div className="flex gap-2 overflow-x-auto pb-2 -mx-1 px-1 snap-x snap-mandatory sm:grid sm:grid-cols-5 sm:overflow-visible sm:pb-0 sm:mx-0 sm:px-0 sm:snap-none">
            {Array.from({ length: 5 }).map((_, i) => {
              const r = initialSeriesStanding.rScores[i];
              return (
                <div
                  key={r?.regattaId || i}
                  className={`rounded-xl border px-2.5 py-2.5 text-center shrink-0 w-[5.25rem] sm:w-auto snap-start ${
                    r?.isCarryForward
                      ? "bg-sky-500/10 border-sky-500/20"
                      : "bg-white/5 border-white/5"
                  }`}
                  title={r?.regattaName}
                >
                  <p className="text-[9px] font-black text-orange-400">
                    R{i + 1}
                    {r?.isCarryForward ? (
                      <span className="text-sky-400 font-bold"> CF</span>
                    ) : null}
                  </p>
                  <p className="text-[9px] text-slate-500 line-clamp-2 min-h-[1.5rem] leading-tight mt-0.5">
                    {r?.regattaName || "—"}
                  </p>
                  <p className="text-[9px] font-bold text-slate-500 uppercase mt-1">
                    Rank
                  </p>
                  <p className="text-base sm:text-sm font-mono font-bold text-white tabular-nums">
                    {r
                      ? `${r.score}${r.isOverseasCommitment ? "†" : r.isDNS ? "*" : ""}`
                      : "—"}
                  </p>
                </div>
              );
            })}
          </div>
          <p className="text-[11px] text-emerald-400/90 mt-3 font-semibold leading-snug">
            {initialSeriesStanding.trendNote}
          </p>
          <p className="text-[10px] text-slate-600 mt-1">
            * DNS · † overseas commitment · CF = carry-forward from prior half
          </p>
          <Link
            href={`/sg/optimist/${String(initialSeriesStanding.fleet).toLowerCase()}`}
            className="inline-flex items-center mt-3 text-[11px] font-bold text-orange-400 hover:underline min-h-[44px] sm:min-h-0 py-2 sm:py-0"
          >
            View full {initialSeriesStanding.fleet} standings →
          </Link>
        </div>
      )}

      {/* Owner edit panel */}
      {isOwner && editing && (
        <div className="glass-panel rounded-2xl border border-orange-500/25 p-5 md:p-6 space-y-4">
          <div className="flex items-center gap-2">
            <Pencil className="h-4 w-4 text-orange-400" />
            <h2 className="text-sm font-black text-white uppercase tracking-wider">
              Edit your profile
            </h2>
          </div>
          <p className="text-[11px] text-slate-500">
            Ranking, fleet, and squad fields are managed by SailorPath admins.
            Tap your photo above to upload. You can edit bio, date of birth,
            school, weight, profile URL, equipment, and privacy. Add overseas /
            non-series events in the logbook below.
          </p>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <label className="block sm:col-span-2">
              <span className="text-[10px] font-bold text-slate-500 uppercase">
                Bio
              </span>
              <textarea
                value={form.bio}
                onChange={(e) => setForm((f) => ({ ...f, bio: e.target.value }))}
                rows={3}
                className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-sm text-white focus:border-orange-500 focus:outline-none"
              />
            </label>
            <label className="block sm:col-span-2">
              <span className="text-[10px] font-bold text-slate-500 uppercase">
                Profile URL
              </span>
              <div className="mt-1 flex rounded-xl bg-slate-950 border border-white/10 overflow-hidden">
                <span className="pl-3 self-center text-[11px] text-slate-500 shrink-0">
                  sailorpath.com/
                </span>
                <input
                  value={form.handle}
                  onChange={(e) =>
                    setForm((f) => ({
                      ...f,
                      handle: e.target.value
                        .toLowerCase()
                        .replace(/[^a-z0-9-]/g, ""),
                    }))
                  }
                  className="w-full bg-transparent py-2 px-2 text-sm text-white font-mono focus:outline-none"
                  placeholder="your-handle"
                />
              </div>
              <p className="text-[10px] text-slate-600 mt-1">
                3–30 characters · letters, numbers, hyphens. Old URL stays as a
                redirect.
              </p>
            </label>
            <label className="block">
              <span className="text-[10px] font-bold text-slate-500 uppercase">
                School
              </span>
              <input
                value={form.school}
                onChange={(e) =>
                  setForm((f) => ({ ...f, school: e.target.value }))
                }
                className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-sm text-white focus:border-orange-500 focus:outline-none"
              />
            </label>
            <label className="block">
              <span className="text-[10px] font-bold text-slate-500 uppercase">
                Date of birth
              </span>
              <input
                type="date"
                value={form.dob}
                onChange={(e) =>
                  setForm((f) => ({ ...f, dob: e.target.value }))
                }
                className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-sm text-white focus:border-orange-500 focus:outline-none"
              />
              <p className="text-[10px] text-slate-600 mt-1">
                Privacy: use “Share DOB” below to control public age display.
              </p>
            </label>
            <label className="block">
              <span className="text-[10px] font-bold text-slate-500 uppercase">
                Weight (kg)
              </span>
              <input
                type="number"
                min={20}
                max={120}
                value={form.weight}
                onChange={(e) =>
                  setForm((f) => ({ ...f, weight: e.target.value }))
                }
                className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-sm text-white focus:border-orange-500 focus:outline-none"
              />
            </label>
            <label className="block sm:col-span-2">
              <span className="text-[10px] font-bold text-slate-500 uppercase">
                Instagram
              </span>
              <input
                value={form.instagram}
                onChange={(e) =>
                  setForm((f) => ({ ...f, instagram: e.target.value }))
                }
                placeholder="@handle"
                className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-sm text-white focus:border-orange-500 focus:outline-none"
              />
            </label>
            <p className="sm:col-span-2 text-[10px] font-bold text-orange-400/90 uppercase tracking-wider pt-2">
              Equipment
            </p>
            {(
              [
                ["hullBrand", "Hull brand"],
                ["sailMake", "Sail make"],
                ["foilBrand", "Foil brand"],
                ["mast", "Mast / spar"],
              ] as const
            ).map(([key, label]) => (
              <label key={key} className="block">
                <span className="text-[10px] font-bold text-slate-500 uppercase">
                  {label}
                </span>
                <input
                  value={form[key]}
                  onChange={(e) =>
                    setForm((f) => ({ ...f, [key]: e.target.value }))
                  }
                  className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-sm text-white focus:border-orange-500 focus:outline-none"
                />
              </label>
            ))}
            <label className="block sm:col-span-2">
              <span className="text-[10px] font-bold text-slate-500 uppercase">
                Equipment notes
              </span>
              <input
                value={form.equipmentNotes}
                onChange={(e) =>
                  setForm((f) => ({ ...f, equipmentNotes: e.target.value }))
                }
                placeholder="Rig settings, cut, etc."
                className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2 text-sm text-white focus:border-orange-500 focus:outline-none"
              />
            </label>
          </div>
          <button
            type="button"
            disabled={saveBusy}
            onClick={() => void saveProfile()}
            className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500 disabled:opacity-50"
          >
            {saveBusy ? "Saving…" : "Save changes"}
          </button>
        </div>
      )}

      {/* Nat squad history (period-locked) */}
      {SQUAD_HISTORY_SLOTS.some((s) => displaySailor[s.key]) && (
        <div className="glass-panel rounded-2xl border border-white/5 p-5 md:p-6">
          <h2 className="text-sm font-bold text-slate-400 tracking-wider uppercase mb-1">
            National squad history
          </h2>
          <p className="text-[11px] text-slate-600 mb-4">
            Squad selection is fixed for each half-year (Jan–Jun / Jul–Dec).
          </p>
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
            {SQUAD_HISTORY_SLOTS.map((slot) => {
              const v = displaySailor[slot.key];
              return (
                <div
                  key={slot.key}
                  className="rounded-xl bg-white/5 border border-white/5 px-3 py-2.5 text-center"
                >
                  <p className="text-[9px] font-bold text-slate-500 uppercase tracking-wide">
                    {slot.label}
                  </p>
                  <p
                    className={`mt-1 text-sm font-black ${
                      v ? "text-orange-400" : "text-slate-600"
                    }`}
                  >
                    {v || "—"}
                  </p>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* Equal-width Athlete Stats + Equipment */}
      <div
        className={`grid grid-cols-1 gap-6 ${
          canSeePrivate ? "lg:grid-cols-3" : "lg:grid-cols-2"
        }`}
      >
        <div className="glass-card rounded-2xl p-6 border border-white/5 flex flex-col h-full min-h-[220px]">
          <h2 className="text-sm font-bold text-slate-400 tracking-wider uppercase mb-6 flex items-center gap-2">
            <TrendingUp className="h-4 w-4 text-orange-500" />
            Athlete Statistics
          </h2>
          <div className="grid grid-cols-2 gap-4 flex-1">
            <div className="bg-white/5 border border-white/5 rounded-xl p-4 text-center">
              <span className="block text-xs text-slate-500 font-bold uppercase">
                Age
              </span>
              <span className="block text-2xl font-extrabold text-white mt-1">
                {showDob && displaySailor.dob
                  ? `${calculateAge(displaySailor.dob)} yrs`
                  : showDob
                    ? "—"
                    : "Private"}
              </span>
              {!showDob && (
                <span className="text-[10px] text-slate-500 mt-1 flex items-center justify-center gap-0.5">
                  <EyeOff className="h-3 w-3" /> Locked
                </span>
              )}
            </div>
            <div className="bg-white/5 border border-white/5 rounded-xl p-4 text-center">
              <span className="block text-xs text-slate-500 font-bold uppercase">
                Weight
              </span>
              <span className="block text-2xl font-extrabold text-white mt-1 font-mono">
                {showWeight && displaySailor.weight != null
                  ? `${displaySailor.weight} kg`
                  : "Private"}
              </span>
              {!showWeight && (
                <span className="text-[10px] text-slate-500 mt-1 flex items-center justify-center gap-0.5">
                  <EyeOff className="h-3 w-3" /> Locked
                </span>
              )}
            </div>
            <div className="bg-white/5 border border-white/5 rounded-xl p-4 text-center">
              <span className="block text-xs text-slate-500 font-bold uppercase">
                Regattas
              </span>
              <span className="block text-2xl font-extrabold text-orange-500 mt-1">
                {initialResults.length}
              </span>
            </div>
            <div className="bg-white/5 border border-white/5 rounded-xl p-4 text-center">
              <span className="block text-xs text-slate-500 font-bold uppercase">
                Gender
              </span>
              <span className="block text-2xl font-extrabold text-white mt-1">
                {displaySailor.gender || "—"}
              </span>
            </div>
          </div>
        </div>

        <div className="glass-card rounded-2xl p-6 border border-white/5 flex flex-col h-full min-h-[220px]">
          <h2 className="text-sm font-bold text-slate-400 tracking-wider uppercase mb-6 flex items-center gap-2">
            <Compass className="h-4 w-4 text-orange-500" />
            Equipment &amp; Rig Log
          </h2>
          {showEquipment &&
          displayEquipment &&
          (displayEquipment.hullBrand ||
            displayEquipment.sailMake ||
            displayEquipment.foilBrand ||
            displayEquipment.mast) ? (
            <div className="space-y-3 font-medium text-sm flex-1">
              {[
                ["Hull", displayEquipment.hullBrand],
                ["Sail", displayEquipment.sailMake],
                ["Foils", displayEquipment.foilBrand],
                ["Mast", displayEquipment.mast],
              ].map(([label, val]) => (
                <div
                  key={label as string}
                  className="flex justify-between border-b border-white/5 pb-2"
                >
                  <span className="text-slate-500">{label}</span>
                  <span className="text-white font-bold">{val || "—"}</span>
                </div>
              ))}
              {displayEquipment.notes && (
                <p className="text-[11px] text-slate-400 italic">
                  {displayEquipment.notes}
                </p>
              )}
              {equipHistory.length > 0 && (
                <div className="pt-2 border-t border-white/5">
                  <p className="text-[10px] font-bold text-slate-500 uppercase mb-1">
                    History
                  </p>
                  <ul className="space-y-1 max-h-24 overflow-y-auto">
                    {equipHistory.slice(0, 5).map((h: any) => (
                      <li
                        key={h.id}
                        className="text-[10px] text-slate-500 font-mono"
                      >
                        {String(h.effectiveDate).slice(0, 10)} ·{" "}
                        {[h.hullBrand, h.sailMake, h.foilBrand]
                          .filter(Boolean)
                          .join(" / ") || "update"}
                      </li>
                    ))}
                  </ul>
                </div>
              )}
            </div>
          ) : (
            <div className="flex-1 flex flex-col items-center justify-center text-center p-4">
              <EyeOff className="h-8 w-8 text-slate-600 mb-2" />
              <p className="text-xs text-slate-400">
                {!showEquipment
                  ? "Equipment log is private."
                  : isOwner
                    ? "No equipment yet — use Edit profile to add gear."
                    : "No equipment logged yet."}
              </p>
            </div>
          )}
        </div>

        {canSeePrivate && (
          <div className="glass-card rounded-2xl p-6 border border-white/5 flex flex-col h-full min-h-[220px]">
            <h2 className="text-sm font-bold text-slate-400 tracking-wider uppercase mb-6 flex items-center gap-2">
              <Settings className="h-4 w-4 text-orange-500" />
              Privacy Toggles
            </h2>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <label className="text-xs font-semibold text-slate-300">
                  Share Weight
                </label>
                <input
                  type="checkbox"
                  checked={isPublicWeight}
                  disabled={!isOwner}
                  onChange={(e) => setIsPublicWeight(e.target.checked)}
                  className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4 disabled:opacity-50"
                />
              </div>
              <div className="flex items-center justify-between border-t border-white/5 pt-3">
                <label className="text-xs font-semibold text-slate-300">
                  Share Equipment Log
                </label>
                <input
                  type="checkbox"
                  checked={isPublicEquipment}
                  disabled={!isOwner}
                  onChange={(e) => setIsPublicEquipment(e.target.checked)}
                  className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4 disabled:opacity-50"
                />
              </div>
              <div className="flex items-center justify-between border-t border-white/5 pt-3">
                <label className="text-xs font-semibold text-slate-300">
                  Share DOB
                </label>
                <input
                  type="checkbox"
                  checked={isPublicDob}
                  disabled={!isOwner}
                  onChange={(e) => setIsPublicDob(e.target.checked)}
                  className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4 disabled:opacity-50"
                />
              </div>
              {isOwner && (
                <button
                  type="button"
                  disabled={saveBusy}
                  onClick={() => void saveProfile()}
                  className="w-full mt-2 rounded-full bg-white/5 border border-white/10 py-2 text-[11px] font-bold text-slate-200 hover:text-white disabled:opacity-50"
                >
                  {saveBusy ? "Saving privacy…" : "Save privacy settings"}
                </button>
              )}
            </div>
          </div>
        )}
      </div>

      {/* Logbook */}
      <div className="glass-panel rounded-3xl p-6 md:p-8 border border-white/5">
        <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 mb-8">
          <div>
            <h2 className="text-xl font-bold text-white flex items-center gap-2">
              <Trophy className="h-5 w-5 text-orange-500" />
              Regatta Logbook
            </h2>
            <p className="text-xs text-slate-400 mt-1">
              Series results and race-by-race observations
              {isOwner
                ? " · add overseas / non-ranking events below"
                : ""}
              .
            </p>
          </div>
          <span className="text-xs text-slate-500 font-bold uppercase">
            {results.length} Regattas Tracked
          </span>
        </div>

        {isOwner && !demoMode && (
          <div className="mb-6 rounded-2xl border border-sky-500/25 bg-sky-500/5 p-4 space-y-3">
            <p className="text-[10px] font-bold text-sky-300 uppercase tracking-wider">
              Add non-ranking result (overseas / other)
            </p>
            <p className="text-[11px] text-slate-500">
              These appear in your logbook only — they do not affect SG Optimist
              Best 3 of 5 rankings.
            </p>
            <div className="grid grid-cols-2 sm:grid-cols-3 gap-2">
              <input
                value={personalForm.name}
                onChange={(e) =>
                  setPersonalForm((f) => ({ ...f, name: e.target.value }))
                }
                placeholder="Event name"
                className="col-span-2 sm:col-span-3 rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white"
              />
              <input
                type="date"
                value={personalForm.date}
                onChange={(e) =>
                  setPersonalForm((f) => ({ ...f, date: e.target.value }))
                }
                className="rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white"
              />
              <input
                type="number"
                min={1}
                value={personalForm.rank}
                onChange={(e) =>
                  setPersonalForm((f) => ({ ...f, rank: e.target.value }))
                }
                placeholder="Place / rank"
                className="rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white"
              />
              <input
                type="number"
                min={1}
                value={personalForm.fleetSize}
                onChange={(e) =>
                  setPersonalForm((f) => ({ ...f, fleetSize: e.target.value }))
                }
                placeholder="Fleet size"
                className="rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white"
              />
              <input
                value={personalForm.geography}
                onChange={(e) =>
                  setPersonalForm((f) => ({
                    ...f,
                    geography: e.target.value.toUpperCase(),
                  }))
                }
                placeholder="Country (e.g. ESP)"
                maxLength={12}
                className="rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white"
              />
              <input
                type="number"
                value={personalForm.nett}
                onChange={(e) =>
                  setPersonalForm((f) => ({ ...f, nett: e.target.value }))
                }
                placeholder="Nett (optional)"
                className="rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white"
              />
            </div>
            <button
              type="button"
              disabled={personalBusy}
              onClick={() => void savePersonalResult()}
              className="rounded-full bg-sky-600 hover:bg-sky-500 px-4 py-1.5 text-[11px] font-bold text-white disabled:opacity-50"
            >
              {personalBusy ? "Saving…" : "Add to logbook"}
            </button>
            {personalMsg && (
              <p className="text-[11px] text-emerald-300">{personalMsg}</p>
            )}
          </div>
        )}

        {results.length === 0 ? (
          <p className="text-sm text-slate-500">No regatta results yet.</p>
        ) : (
          <div className="space-y-3">
            {results.slice(0, visibleCount).map((res: any, idx: number) => {
              const fleetSize = res.totalFleetSize ?? res.fleetSize ?? 50;
              const regattaId = res.regattaId || res.id;
              const rowKey = regattaId || res.regattaSlug || `r-${idx}`;
              const nonRanking = res.countsForRanking === false;
              const { label, className } = getPercentileBadge(
                res.rank,
                fleetSize
              );
              const overseas = Boolean(res.isOverseasCommitment);
              const dns = Boolean(res.isDns || res.isDNS) && !overseas;
              const slug = res.regattaSlug || res.id;
              const expanded = expandedRegattaId === regattaId;
              const raceNotes = obsForRegatta(regattaId);
              const nameNode =
                !nonRanking && slug && String(slug).length > 2 ? (
                  <Link
                    href={`/sg/optimist/regattas/${slug}`}
                    className="text-base font-bold text-white truncate hover:text-orange-400"
                  >
                    {res.regattaName}
                  </Link>
                ) : (
                  <h3 className="text-base font-bold text-white truncate">
                    {res.regattaName}
                  </h3>
                );
              return (
                <div
                  key={rowKey}
                  className={`glass-card rounded-2xl border border-white/5 p-5 space-y-3 ${
                    nonRanking
                      ? "border-sky-500/25"
                      : overseas
                        ? "border-sky-500/20"
                        : dns
                          ? "border-rose-500/15"
                          : ""
                  }`}
                >
                  <div className="flex flex-col gap-3 sm:gap-4">
                    <div className="flex items-start justify-between gap-3">
                      <div className="flex-1 min-w-0">
                        {nameNode}
                        <p className="text-xs text-slate-500 mt-1 font-semibold">
                          {res.regattaDate}
                          {res.geography ? ` · ${res.geography}` : ""}
                          {res.division && !nonRanking
                            ? ` · ${res.division}`
                            : ""}
                        </p>
                      </div>
                      <button
                        type="button"
                        onClick={() =>
                          setExpandedRegattaId(expanded ? null : regattaId)
                        }
                        className="shrink-0 rounded-full border border-white/10 bg-white/5 p-2.5 min-h-[44px] min-w-[44px] flex items-center justify-center text-slate-400 hover:text-white sm:min-h-0 sm:min-w-0 sm:p-2"
                        title="Race observations"
                      >
                        {expanded ? (
                          <ChevronUp className="h-4 w-4" />
                        ) : (
                          <ChevronDown className="h-4 w-4" />
                        )}
                      </button>
                    </div>
                    <div className="flex flex-wrap gap-1.5">
                      {nonRanking && (
                        <span className="rounded-full bg-sky-500/10 border border-sky-500/25 px-2 py-0.5 text-[10px] font-bold text-sky-300">
                          Non-ranking
                        </span>
                      )}
                      {overseas && (
                        <span className="rounded-full bg-sky-500/10 border border-sky-500/25 px-2 py-0.5 text-[10px] font-bold text-sky-300">
                          Overseas†
                        </span>
                      )}
                      {dns && (
                        <span className="rounded-full bg-rose-500/10 border border-rose-500/25 px-2 py-0.5 text-[10px] font-bold text-rose-400">
                          DNS*
                        </span>
                      )}
                      {raceNotes.length > 0 && (
                        <span className="rounded-full bg-orange-500/10 border border-orange-500/20 px-2 py-0.5 text-[10px] font-bold text-orange-300">
                          {raceNotes.length} note
                          {raceNotes.length === 1 ? "" : "s"}
                        </span>
                      )}
                      <span
                        className={`rounded-full px-2.5 py-0.5 text-[10px] font-bold ${className}`}
                      >
                        {label}
                      </span>
                      {isOwner && !demoMode && nonRanking && res.resultId && (
                        <button
                          type="button"
                          disabled={personalBusy}
                          onClick={() => void deletePersonalResult(res)}
                          className="rounded-full border border-white/10 bg-white/5 px-2 py-0.5 text-[10px] font-bold text-rose-300 hover:border-rose-500/40"
                        >
                          Remove
                        </button>
                      )}
                    </div>
                    {/* Stats row: full width on mobile for readability */}
                    <div className="grid grid-cols-3 gap-2 sm:flex sm:items-center sm:justify-end sm:gap-6 border-t border-white/5 pt-3">
                      <div className="text-center sm:text-right font-semibold text-sm">
                        <span className="block text-[10px] sm:text-xs text-slate-500 uppercase">
                          Rank
                        </span>
                        <span className="text-white text-lg font-black tabular-nums">
                          {res.rank}
                          {overseas ? "†" : dns ? "*" : ""}
                        </span>
                        <span className="text-slate-400 text-xs">
                          {" "}
                          / {fleetSize}
                        </span>
                      </div>
                      <div className="text-center sm:text-right font-semibold text-sm">
                        <span className="block text-[10px] sm:text-xs text-slate-500 uppercase">
                          Total
                        </span>
                        <span className="text-white text-lg font-black tabular-nums">
                          {res.totalScore != null ? res.totalScore : "—"}
                        </span>
                      </div>
                      <div className="text-center sm:text-right font-semibold text-sm">
                        <span className="block text-[10px] sm:text-xs text-slate-500 uppercase">
                          Nett
                        </span>
                        <span className="text-white text-lg font-black tabular-nums">
                          {res.nettScore != null ? res.nettScore : "—"}
                        </span>
                      </div>
                    </div>
                  </div>

                  {expanded && (
                    <div className="border-t border-white/5 pt-3 space-y-3">
                      <div className="flex items-center gap-2 text-[11px] font-bold text-slate-400 uppercase tracking-wider">
                        <BookOpen className="h-3.5 w-3.5 text-orange-400" />
                        Race observations
                      </div>
                      {raceNotes.length === 0 ? (
                        <p className="text-xs text-slate-600">
                          {isOwner
                            ? "No notes yet — add wind, place, and takeaways below."
                            : "No public race notes for this event."}
                        </p>
                      ) : (
                        <ul className="space-y-2">
                          {raceNotes.map((o: any) => {
                            const isEditingThis =
                              isOwner &&
                              !demoMode &&
                              ((editingObsId && editingObsId === o.id) ||
                                (!editingObsId &&
                                  String(obsForm.raceNumber) ===
                                    String(o.raceNumber) &&
                                  obsForm.raceNumber !== ""));
                            return (
                              <li
                                key={o.id || `${o.regattaId}-${o.raceNumber}`}
                                className={`rounded-xl border px-3 py-2 ${
                                  isEditingThis
                                    ? "bg-orange-500/10 border-orange-500/30"
                                    : "bg-white/[0.03] border-white/5"
                                }`}
                              >
                                <div className="flex items-center justify-between gap-2">
                                  <span className="text-xs font-black text-orange-400">
                                    Race {o.raceNumber}
                                  </span>
                                  <div className="flex items-center gap-2">
                                    <span className="text-[11px] font-mono text-slate-400">
                                      {o.position != null
                                        ? `Score ${o.position}`
                                        : "—"}
                                      {o.wind ? ` · ${o.wind}` : ""}
                                      {o.isPrivate ? " · private" : ""}
                                    </span>
                                    {isOwner && !demoMode && (
                                      <span className="flex items-center gap-1">
                                        <button
                                          type="button"
                                          onClick={() =>
                                            startEditObservation(o, regattaId)
                                          }
                                          className="rounded-md border border-white/10 bg-white/5 px-1.5 py-0.5 text-[10px] font-bold text-slate-300 hover:text-white hover:border-orange-500/40"
                                          title="Edit observation"
                                        >
                                          Edit
                                        </button>
                                        {o.id && (
                                          <button
                                            type="button"
                                            disabled={obsBusy}
                                            onClick={() =>
                                              void deleteObservation(o)
                                            }
                                            className="rounded-md border border-white/10 bg-white/5 px-1.5 py-0.5 text-[10px] font-bold text-rose-300/90 hover:text-rose-200 hover:border-rose-500/40 disabled:opacity-50"
                                            title="Delete observation"
                                          >
                                            Del
                                          </button>
                                        )}
                                      </span>
                                    )}
                                  </div>
                                </div>
                                {o.note && (
                                  <p className="text-xs text-slate-300 mt-1 leading-relaxed">
                                    {o.note}
                                  </p>
                                )}
                              </li>
                            );
                          })}
                        </ul>
                      )}
                      {isOwner && !demoMode && (
                        <div className="rounded-xl border border-orange-500/20 bg-orange-500/5 p-3 space-y-2">
                          <div className="flex items-center justify-between gap-2">
                            <p className="text-[10px] font-bold text-orange-300 uppercase">
                              {editingObsId || obsForm.raceNumber
                                ? "Edit observation"
                                : "Add observation"}
                            </p>
                            {(editingObsId ||
                              obsForm.raceNumber ||
                              obsForm.note ||
                              obsForm.wind ||
                              obsForm.position) && (
                              <button
                                type="button"
                                onClick={resetObsForm}
                                className="text-[10px] font-bold text-slate-400 hover:text-white"
                              >
                                Clear
                              </button>
                            )}
                          </div>
                          <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
                            <input
                              type="number"
                              min={1}
                              value={obsForm.raceNumber}
                              onChange={(e) =>
                                setObsForm((f) => ({
                                  ...f,
                                  raceNumber: e.target.value,
                                }))
                              }
                              placeholder="Race #"
                              className="rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white"
                            />
                            <input
                              type="number"
                              min={1}
                              value={obsForm.position}
                              onChange={(e) =>
                                setObsForm((f) => ({
                                  ...f,
                                  position: e.target.value,
                                }))
                              }
                              placeholder="Score"
                              className="rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white"
                            />
                            <input
                              value={obsForm.wind}
                              onChange={(e) =>
                                setObsForm((f) => ({
                                  ...f,
                                  wind: e.target.value,
                                }))
                              }
                              placeholder="Wind"
                              className="rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white sm:col-span-2"
                            />
                            <input
                              value={obsForm.note}
                              onChange={(e) =>
                                setObsForm((f) => ({
                                  ...f,
                                  note: e.target.value,
                                }))
                              }
                              placeholder="Notes / coaching takeaways"
                              className="rounded-lg bg-slate-950 border border-white/10 px-2 py-1.5 text-xs text-white col-span-2 sm:col-span-3"
                            />
                            <label className="flex items-center gap-1.5 text-[10px] text-slate-400">
                              <input
                                type="checkbox"
                                checked={obsForm.isPrivate}
                                onChange={(e) =>
                                  setObsForm((f) => ({
                                    ...f,
                                    isPrivate: e.target.checked,
                                  }))
                                }
                                className="rounded border-slate-600"
                              />
                              Private
                            </label>
                          </div>
                          <button
                            type="button"
                            disabled={obsBusy}
                            onClick={() => void saveObservation(regattaId)}
                            className="rounded-full bg-orange-600 px-4 py-1.5 text-[11px] font-bold text-white disabled:opacity-50"
                          >
                            {obsBusy
                              ? "Saving…"
                              : editingObsId
                                ? "Update observation"
                                : "Save observation"}
                          </button>
                          {obsMsg && (
                            <p className="text-[11px] text-emerald-300">{obsMsg}</p>
                          )}
                        </div>
                      )}
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        )}

        {results.length > visibleCount && (
          <div className="mt-8 text-center">
            <button
              type="button"
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
