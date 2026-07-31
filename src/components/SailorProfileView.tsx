"use client";

import { useEffect, useMemo, useRef, useState } from "react";

import Link from "next/link";
import {
  seriesFleetStatus,
  normalizeNationality,
} from "@/lib/seriesMembership";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import {
  Link2,
  UserPlus,
  Pencil,
  BookOpen,
  ChevronDown,
  ChevronUp,
  Camera,
  Settings,
  EyeOff,
  Anchor,
  Clock,
  Trophy,
} from "lucide-react";
import { formatEventWhen } from "@/lib/profileUi";
import {
  newJourneyId,
  parseSailingJourney,
  type JourneyHighlight,
} from "@/lib/sailingJourney";
import {
  buildProfileAnalytics,
  buildResultTags,
  fleetLabelForResult,
  ordinal,
} from "@/lib/profileAnalytics";

export interface SailorRecordProps {
  id: string;
  name: string;
  handle: string;
  sailNumber?: string | null;
  club?: string | null;
  school?: string | null;
  nationality?: string | null;
  dob?: string | null;
  goldEntryDate?: string | null;
  silverEntryDate?: string | null;
  dropDate?: string | null;
  bio?: string | null;
  instagram?: string | null;
  weight?: string | number | null;
  boatHull?: string | null;
  boatSail?: string | null;
  boatSpars?: string | null;
  boatFoil?: string | null;
  avatarUrl?: string | null;
  [key: string]: unknown;
}

export interface RegattaResultItem {
  id: string;
  regattaId: string;
  regattaName?: string;
  rank?: number | null;
  nettScore?: number | null;
  isDns?: boolean;
  notes?: string | null;
  [key: string]: unknown;
}

export interface ObservationItem {
  id: string;
  regattaId?: string | null;
  raceNumber?: number | null;
  note?: string | null;
  createdAt?: string | null;
  [key: string]: unknown;
}

interface SailorProfileViewProps {
  initialSailor: SailorRecordProps;
  initialResults: RegattaResultItem[];
  initialEquipment: Record<string, any>;
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
  initialObservations?: ObservationItem[];
  initialEquipmentHistory?: Record<string, unknown>[];
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


/** Shared card shell matching the refined profile mockup */
const cardClass =
  "rounded-2xl border border-white/[0.06] bg-[#151b2b] shadow-[0_0_0_1px_rgba(255,255,255,0.02)]";

function resolveDisplayFleet(sailor: Record<string, unknown>): {
  label: string;
  className: string;
} {
  const status = seriesFleetStatus(sailor as never);
  if (status === "gold") {
    return {
      label: "Gold fleet",
      className: "bg-yellow-400 text-yellow-950 border border-yellow-300/30",
    };
  }
  if (status === "silver" || status === "series") {
    return {
      label: "Silver fleet",
      className: "bg-neutral-600/80 text-neutral-100 border border-neutral-500/30",
    };
  }
  if (status === "dropped") {
    return {
      label: "Dropped",
      className: "bg-rose-500/15 text-rose-300 border border-rose-500/25",
    };
  }
  return {
    label: "Guest",
    className: "bg-white/10 text-neutral-300 border border-white/10",
  };
}

function fleetPillClass(fleet: "Gold" | "Silver" | "—"): string {
  if (fleet === "Gold") {
    return "bg-yellow-400 text-yellow-950 border border-yellow-300/20";
  }
  if (fleet === "Silver") {
    return "bg-neutral-600 text-neutral-100 border border-neutral-500/30";
  }
  return "bg-white/5 text-neutral-500 border border-white/10";
}

function nationalityFlag(raw: unknown): string {
  const code = normalizeNationality(raw);
  if (code === "SGP") return "🇸🇬";
  if (code === "MAS") return "🇲🇾";
  if (code === "INA") return "🇮🇩";
  if (code === "THA") return "🇹🇭";
  if (code === "PHI") return "🇵🇭";
  if (code === "CHN") return "🇨🇳";
  if (code === "HKG") return "🇭🇰";
  if (code === "AUS") return "🇦🇺";
  return "🏳️";
}

function nationalityLabel(raw: unknown): string {
  const code = normalizeNationality(raw);
  if (!code) return "—";
  if (code === "SGP") return "Singapore";
  return code;
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
  const [isPublicWeight, setIsPublicWeight] = useState<boolean>(
    Boolean(initialSailor.isPublicWeight)
  );
  const [isPublicDob, setIsPublicDob] = useState<boolean>(
    Boolean(initialSailor.isPublicDob)
  );
  const [isPublicEquipment, setIsPublicEquipment] = useState<boolean>(
    Boolean(initialSailor.isPublicEquipment)
  );
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
  const [journey, setJourney] = useState<JourneyHighlight[]>(() =>
    parseSailingJourney(initialSailor.sailingJourney)
  );
  const [journeyDraft, setJourneyDraft] = useState({
    when: "",
    title: "",
    detail: "",
  });
  const [journeyBusy, setJourneyBusy] = useState(false);
  const [journeyMsg, setJourneyMsg] = useState<string | null>(null);
  /** Public list shows 8 by default; owner/public can expand to full log */
  const [showAllResults, setShowAllResults] = useState(false);

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
    const raceNum = Number(obsForm.raceNumber);
    if (!obsForm.raceNumber.trim() || !Number.isFinite(raceNum) || raceNum < 1) {
      setObsMsg("Enter a race number");
      return;
    }
    // Demo: keep notes in local state only
    if (demoMode) {
      const row = {
        id: editingObsId || `demo-${regattaId}-${raceNum}`,
        regattaId,
        raceNumber: raceNum,
        position: obsForm.position === "" ? null : Number(obsForm.position),
        wind: obsForm.wind,
        note: obsForm.note,
        isPrivate: obsForm.isPrivate,
        regattaName: initialResults.find(
          (r: { regattaId?: string }) => r.regattaId === regattaId
        )?.regattaName,
      };
      setObservations((prev: ObservationItem[]) => {
        const rest = prev.filter(
          (o) =>
            !(
              o.regattaId === regattaId &&
              Number(o.raceNumber) === raceNum
            )
        );
        return [...rest, row as ObservationItem].sort(
          (a, b) => Number(a.raceNumber || 0) - Number(b.raceNumber || 0)
        );
      });
      setObsMsg(editingObsId ? "Observation updated (demo)" : "Observation saved (demo)");
      resetObsForm();
      setTimeout(() => setObsMsg(null), 2000);
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

  const persistJourney = async (next: JourneyHighlight[]) => {
    if (demoMode) {
      setJourney(next);
      setJourneyMsg("Demo only — not saved to server");
      return;
    }
    setJourneyBusy(true);
    setJourneyMsg(null);
    try {
      const res = await fetch("/api/account/sailor", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({
          sailorId: initialSailor.id,
          sailingJourney: next,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Save failed");
      setJourney(next);
      if (data.sailor?.sailingJourney != null) {
        setJourney(parseSailingJourney(data.sailor.sailingJourney));
      }
      setJourneyMsg("Journey saved");
      setTimeout(() => setJourneyMsg(null), 2000);
    } catch (e: unknown) {
      setJourneyMsg(e instanceof Error ? e.message : "Failed");
    } finally {
      setJourneyBusy(false);
    }
  };

  const addJourneyItem = async () => {
    const title = journeyDraft.title.trim();
    if (!title) return;
    const item: JourneyHighlight = {
      id: newJourneyId(),
      when: journeyDraft.when.trim(),
      title,
      detail: journeyDraft.detail.trim(),
    };
    const next = [item, ...journey];
    setJourneyDraft({ when: "", title: "", detail: "" });
    await persistJourney(next);
  };

  const removeJourneyItem = async (id: string) => {
    if (!confirm("Remove this highlight from your journey?")) return;
    await persistJourney(journey.filter((j) => j.id !== id));
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


  const fleetBadge = resolveDisplayFleet(
    displaySailor as Record<string, unknown>
  );
  const analytics = useMemo(
    () =>
      buildProfileAnalytics(
        displaySailor as never,
        results as never,
        observations as never,
        initialSeriesStanding
          ? {
              overallRank: initialSeriesStanding.overallRank,
              fleetSize: initialSeriesStanding.fleetSize,
              fleet: initialSeriesStanding.fleet,
            }
          : null
      ),
    [displaySailor, results, observations, initialSeriesStanding]
  );

  /** Born year is public whenever DOB is known */
  const bornYear = displaySailor.dob
    ? String(displaySailor.dob).slice(0, 4)
    : null;

  const hasEquipment =
    showEquipment &&
    displayEquipment &&
    (displayEquipment.hullBrand ||
      displayEquipment.sailMake ||
      displayEquipment.foilBrand ||
      displayEquipment.mast ||
      displayEquipment.notes);

  // Position trend SVG — silver (white) + gold (amber), rank labels, tight axis
  const trendSvg = useMemo(() => {
    const pts = analytics.trend;
    if (pts.length < 2) return null;
    const w = 680;
    const h = 240;
    const padL = 44;
    const padR = 24;
    const padT = 36;
    const padB = 36;
    const ranks = pts.map((p) => p.rank);
    const dataMin = Math.min(...ranks);
    const dataMax = Math.max(...ranks);
    // Axis: pad by ~10% of span, snap to clean integers, always show ≥ range of 5
    const rawSpan = Math.max(dataMax - dataMin, 1);
    const pad = Math.max(1, Math.ceil(rawSpan * 0.15));
    let minR = Math.max(1, dataMin - pad);
    let maxR = dataMax + pad;
    if (maxR - minR < 5) {
      maxR = minR + 5;
    }
    // Build ~4–6 nice tick ranks inclusive of min/max
    const span = maxR - minR;
    const step =
      span <= 6 ? 1 : span <= 12 ? 2 : span <= 25 ? 5 : span <= 50 ? 10 : 15;
    const gridRanks: number[] = [];
    const tickStart = Math.ceil(minR / step) * step;
    for (let r = tickStart; r <= maxR; r += step) {
      gridRanks.push(r);
    }
    if (!gridRanks.includes(minR)) gridRanks.unshift(minR);
    if (!gridRanks.includes(maxR)) gridRanks.push(maxR);
    // de-dupe + sort
    const uniqueTicks = [...new Set(gridRanks)].sort((a, b) => a - b);

    const yFor = (rank: number) =>
      padT + ((rank - minR) / (maxR - minR)) * (h - padT - padB);
    const xFor = (i: number) =>
      padL + (i / Math.max(pts.length - 1, 1)) * (w - padL - padR);

    let splitAt = -1;
    if (analytics.mode !== "established_gold") {
      if (analytics.goldEntryDate) {
        splitAt = pts.findIndex(
          (p) => p.fleet === "Gold" || p.date >= analytics.goldEntryDate!
        );
      } else {
        splitAt = pts.findIndex((p) => p.fleet === "Gold");
      }
    }

    const pathThrough = (from: number, to: number) => {
      const slice = pts.slice(from, to + 1);
      if (!slice.length) return "";
      return slice
        .map((p, j) => {
          const i = from + j;
          return `${j === 0 ? "M" : "L"} ${xFor(i).toFixed(1)} ${yFor(p.rank).toFixed(1)}`;
        })
        .join(" ");
    };

    let silverPath = "";
    let goldPath = "";
    let promoX: number | null = null;
    if (splitAt > 0) {
      silverPath = pathThrough(0, splitAt);
      goldPath = pathThrough(splitAt, pts.length - 1);
      promoX = xFor(splitAt);
    } else if (splitAt === 0 || analytics.mode === "established_gold") {
      goldPath = pathThrough(0, pts.length - 1);
    } else {
      silverPath = pathThrough(0, pts.length - 1);
    }

    return {
      w,
      h,
      padL,
      padR,
      padT,
      padB,
      silverPath,
      goldPath,
      pts,
      xFor,
      yFor,
      promoX,
      gridRanks: uniqueTicks,
      minR,
      maxR,
      showSegregation: splitAt > 0,
    };
  }, [analytics.trend, analytics.goldEntryDate, analytics.mode]);

  const visibleResults = showAllResults
    ? analytics.listResults
    : analytics.listResults.slice(0, 8);
  const hasMoreResults = analytics.listResults.length > 8;

  const sailDisplay = String(displaySailor.sailNumber || "—");
  const noc =
    normalizeNationality(displaySailor.nationality) ||
    (String(displaySailor.nationality || "").trim() ? "SGP" : "SGP");

  // Stats cells by mode
  const statCells =
    analytics.mode === "established_gold"
      ? [
          {
            value: String(analytics.regattaCount),
            label: "Regattas",
            color: "text-white",
          },
          {
            value: String(analytics.top10Count),
            label: "Top 10",
            color: "text-emerald-400",
          },
          {
            value: analytics.avgFinishLabel,
            label: "Avg. finish",
            color: "text-blue-400",
          },
          {
            value: analytics.bestGoldLabel,
            label: "Best finish",
            color: "text-white",
          },
        ]
      : [
          {
            value: String(analytics.regattaCount),
            label: "Regattas",
            color: "text-white",
          },
          {
            value: analytics.bestSilverLabel,
            label: "Best silver",
            color: "text-emerald-400",
          },
          {
            value: analytics.bestGoldLabel,
            label: "Best gold",
            color: "text-amber-400",
          },
          {
            value: analytics.timeInGoldLabel || "—",
            label: "In gold fleet",
            color: "text-white",
          },
        ];

  // For established, also show months in gold as subtle note under stats if useful
  // Medal tally only for established with podium/top10
  const showMedals =
    analytics.mode === "established_gold" && analytics.medals.show;

  return (
    <div className="mx-auto max-w-3xl px-4 sm:px-6 py-8 sm:py-12 flex-1 w-full space-y-4">
      {/* ── Header card ──────────────────────────────────────── */}
      <header className={`${cardClass} p-5 sm:p-6`}>
        <div className="flex items-start gap-3 sm:gap-4">
          <div className="relative shrink-0">
            <div className="h-14 w-14 sm:h-16 sm:w-16 rounded-2xl bg-[#2a3144] text-neutral-200 flex items-center justify-center overflow-hidden text-lg sm:text-xl font-semibold tracking-tight">
              {displaySailor.avatarUrl ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img
                  src={displaySailor.avatarUrl}
                  alt={displaySailor.name}
                  className="h-full w-full object-cover"
                />
              ) : (
                initials(displaySailor.name)
              )}
            </div>
            {isOwner && !demoMode && (
              <>
                <button
                  type="button"
                  disabled={avatarBusy}
                  onClick={() => fileInputRef.current?.click()}
                  className="absolute inset-0 rounded-2xl bg-black/50 opacity-0 hover:opacity-100 focus:opacity-100 transition-opacity flex items-center justify-center text-white"
                  title="Upload photo"
                >
                  <Camera className="h-5 w-5" />
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
          </div>

          <div className="min-w-0 flex-1">
            <div className="flex items-start justify-between gap-3">
              <div className="min-w-0">
                <div className="flex flex-wrap items-center gap-2">
                  <h1 className="text-xl sm:text-2xl font-semibold text-white tracking-tight">
                    {displaySailor.name}
                  </h1>
                  <span
                    className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-[11px] font-semibold ${fleetBadge.className}`}
                  >
                    {fleetBadge.label}
                  </span>
                </div>
                <p className="mt-0.5 text-[13px] text-neutral-400">
                  Optimist class
                  {displaySailor.club ? ` · ${displaySailor.club}` : ""}
                </p>
              </div>
              <div className="shrink-0 text-right">
                <p className="text-[8px] font-semibold uppercase tracking-[0.16em] text-neutral-500 mb-1">
                  Sail number
                </p>
                <div className="inline-flex items-center rounded-lg bg-orange-500/15 border border-orange-500/25 px-2.5 py-1.5">
                  <span className="text-sm sm:text-base font-bold tabular-nums text-orange-400 tracking-tight">
                    {noc} {sailDisplay}
                  </span>
                </div>
              </div>
            </div>

            {displaySailor.bio && (
              <p className="mt-2.5 text-[13px] leading-relaxed text-neutral-200 max-w-xl rounded-lg bg-orange-500/15 border border-orange-500/25 px-3 py-2">
                {displaySailor.bio}
              </p>
            )}

            <div className="mt-2.5 flex flex-wrap items-center gap-x-3 gap-y-1 text-[12px] text-neutral-500">
              <span className="inline-flex items-center gap-1.5">
                <span aria-hidden>
                  {nationalityFlag(displaySailor.nationality)}
                </span>
                {nationalityLabel(displaySailor.nationality)}
              </span>
              {bornYear && (
                <span>
                  Born{" "}
                  <span className="text-neutral-300 font-medium">{bornYear}</span>
                </span>
              )}
              {showWeight && displaySailor.weight != null && (
                <span>
                  Weight{" "}
                  <span className="text-neutral-300 font-medium">
                    {displaySailor.weight} kg
                  </span>
                </span>
              )}
              {analytics.timeInGoldLabel && analytics.isGoldFleet && (
                <span>
                  <span className="text-yellow-400/90 font-medium">
                    {analytics.timeInGoldLabel}
                  </span>{" "}
                  in gold
                </span>
              )}
            </div>

            <div className="mt-3 flex flex-wrap gap-2">
              <button
                type="button"
                onClick={async () => {
                  try {
                    const url =
                      typeof window !== "undefined" ? window.location.href : "";
                    await navigator.clipboard.writeText(url);
                    setCopyMsg("Copied");
                    setTimeout(() => setCopyMsg(null), 2000);
                  } catch {
                    setCopyMsg("Failed");
                  }
                }}
                className="inline-flex items-center gap-1.5 rounded-lg border border-white/10 bg-white/[0.03] px-2.5 py-1 text-[11px] font-medium text-neutral-400 hover:text-white"
              >
                <Link2 className="h-3 w-3" />
                {copyMsg || "Copy link"}
              </button>
              {!demoMode && !isLoggedIn && !profileClaimed && (
                <Link
                  href={`/login?next=${encodeURIComponent(`/${displaySailor.handle || ""}`)}`}
                  className="inline-flex items-center gap-1.5 rounded-lg bg-white text-neutral-900 px-2.5 py-1 text-[11px] font-semibold"
                >
                  <UserPlus className="h-3 w-3" />
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
                  className="inline-flex items-center gap-1.5 rounded-lg bg-white text-neutral-900 px-2.5 py-1 text-[11px] font-semibold disabled:opacity-50"
                >
                  <UserPlus className="h-3 w-3" />
                  {demoMode
                    ? "Claim (demo)"
                    : claimPanelOpen
                      ? "Cancel"
                      : "Claim profile"}
                </button>
              )}
              {canClaim && claimStatus === "pending" && (
                <span className="text-[11px] font-medium text-amber-300/90">
                  Claim pending
                </span>
              )}
              {isOwner && (
                <button
                  type="button"
                  onClick={() => setEditing((e) => !e)}
                  className="inline-flex items-center gap-1.5 rounded-lg border border-white/10 bg-white/[0.03] px-2.5 py-1 text-[11px] font-medium text-neutral-300 hover:text-white"
                >
                  <Pencil className="h-3 w-3" />
                  {editing ? "Close editor" : "Edit"}
                </button>
              )}
            </div>
            {avatarMsg && (
              <p className="mt-1 text-[11px] text-emerald-400">{avatarMsg}</p>
            )}
            {claimMsg && (
              <p
                className={`mt-1 text-[11px] ${
                  claimStatus === "error" ? "text-rose-300" : "text-emerald-300"
                }`}
              >
                {claimMsg}{" "}
                {claimStatus === "pending" && !demoMode && (
                  <Link href="/account" className="underline font-semibold">
                    My account
                  </Link>
                )}
              </p>
            )}
          </div>
        </div>
      </header>

      {/* Claim panel */}
      {claimPanelOpen && canClaim && !demoMode && claimStatus !== "pending" && (
        <div className={`${cardClass} p-4 space-y-3`}>
          <p className="text-sm font-medium text-white">
            Verify link to this sailor
          </p>
          <p className="text-[12px] text-neutral-500 leading-relaxed">
            Your signup email is shown to admins. Confirm sail number / club.
          </p>
          <select
            value={claimRelation}
            onChange={(e) =>
              setClaimRelation(e.target.value as "sailor" | "parent" | "other")
            }
            className="w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-xs text-white"
          >
            <option value="parent">Parent / guardian</option>
            <option value="sailor">The sailor</option>
            <option value="other">Coach / other</option>
          </select>
          <textarea
            value={claimNote}
            onChange={(e) => setClaimNote(e.target.value)}
            rows={3}
            placeholder={`e.g. Parent of ${displaySailor.name}. Sail ${displaySailor.sailNumber || "…"}`}
            className="w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-xs text-white"
          />
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
              } catch (e: unknown) {
                setClaimStatus("error");
                setClaimMsg(e instanceof Error ? e.message : "Error");
              } finally {
                setClaimBusy(false);
              }
            }}
            className="rounded-lg bg-orange-500 text-white px-4 py-2 text-[11px] font-semibold disabled:opacity-50"
          >
            {claimBusy ? "Submitting…" : "Submit claim"}
          </button>
        </div>
      )}

      {/* Owner editor */}
      {isOwner && editing && (
        <div className={`${cardClass} p-5 space-y-3`}>
          <h2 className="text-sm font-semibold text-white flex items-center gap-2">
            <Pencil className="h-3.5 w-3.5 text-neutral-400" />
            Edit profile
          </h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <label className="block sm:col-span-2">
              <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
                Bio
              </span>
              <textarea
                value={form.bio}
                onChange={(e) => setForm((f) => ({ ...f, bio: e.target.value }))}
                rows={3}
                className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
              />
            </label>
            <label className="block sm:col-span-2">
              <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
                Profile URL
              </span>
              <div className="mt-1 flex rounded-lg bg-black/40 border border-white/10 overflow-hidden">
                <span className="pl-3 self-center text-[11px] text-neutral-600 shrink-0">
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
                />
              </div>
            </label>
            <label className="block">
              <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
                School
              </span>
              <input
                value={form.school}
                onChange={(e) =>
                  setForm((f) => ({ ...f, school: e.target.value }))
                }
                className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
              />
            </label>
            <label className="block">
              <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
                Date of birth
              </span>
              <input
                type="date"
                value={form.dob}
                onChange={(e) =>
                  setForm((f) => ({ ...f, dob: e.target.value }))
                }
                className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
              />
            </label>
            <label className="block">
              <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
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
                className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
              />
            </label>
            <label className="block">
              <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
                Instagram
              </span>
              <input
                value={form.instagram || ""}
                onChange={(e) =>
                  setForm((f) => ({ ...f, instagram: e.target.value }))
                }
                className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
              />
            </label>
            {(
              [
                ["hullBrand", "Hull brand"],
                ["sailMake", "Sail make"],
                ["foilBrand", "Foil brand"],
                ["mast", "Mast / spar"],
              ] as const
            ).map(([key, label]) => (
              <label key={key} className="block">
                <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
                  {label}
                </span>
                <input
                  value={(form as Record<string, string>)[key] || ""}
                  onChange={(e) =>
                    setForm((f) => ({ ...f, [key]: e.target.value }))
                  }
                  className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                />
              </label>
            ))}
            <label className="block sm:col-span-2">
              <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
                Equipment notes
              </span>
              <input
                value={form.equipmentNotes}
                onChange={(e) =>
                  setForm((f) => ({ ...f, equipmentNotes: e.target.value }))
                }
                className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
              />
            </label>
          </div>
          <button
            type="button"
            disabled={saveBusy}
            onClick={() => void saveProfile()}
            className="rounded-lg bg-orange-500 text-white px-4 py-2 text-xs font-semibold disabled:opacity-50"
          >
            {saveBusy ? "Saving…" : "Save changes"}
          </button>
          {saveMsg && (
            <p className="text-[11px] text-emerald-400">{saveMsg}</p>
          )}
        </div>
      )}

      {/* ── Series standing ──────────────────────────────────── */}
      {initialSeriesStanding && (
        <section className={`${cardClass} p-4 sm:p-5`}>
          <div className="flex flex-wrap items-start justify-between gap-3">
            <div className="flex items-start gap-2.5 min-w-0">
              <div className="mt-0.5 flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-orange-500/15">
                <Trophy className="h-3.5 w-3.5 text-orange-400" />
              </div>
              <div>
                <p className="text-[13px] font-semibold text-white">
                  Series standing
                </p>
                <p className="text-[11px] text-neutral-500">
                  {initialSeriesStanding.periodLabel}
                  <span className="text-neutral-600"> · </span>
                  <span className="text-yellow-400/90 font-medium">
                    {initialSeriesStanding.fleet} fleet
                  </span>
                </p>
              </div>
            </div>
            <div className="text-right">
              <p className="text-[9px] font-semibold uppercase tracking-[0.12em] text-neutral-500">
                Best 3 of 5
              </p>
              <p className="text-2xl font-semibold text-white tabular-nums leading-none">
                {initialSeriesStanding.best3of5}
              </p>
              <p className="text-[12px] text-neutral-400 mt-0.5 tabular-nums">
                #{initialSeriesStanding.overallRank}
                <span className="text-neutral-600">
                  {" "}
                  of {initialSeriesStanding.fleetSize}
                </span>
              </p>
            </div>
          </div>
          <div className="mt-4 grid grid-cols-5 gap-1.5 sm:gap-2">
            {Array.from({ length: 5 }).map((_, i) => {
              const r = initialSeriesStanding.rScores[i];
              return (
                <div
                  key={i}
                  className="rounded-xl border border-white/[0.05] bg-black/25 px-1 py-2.5 text-center"
                  title={r?.regattaName}
                >
                  <p className="text-[9px] font-semibold text-orange-400/90">
                    R{i + 1}
                  </p>
                  <p className="text-[9px] text-neutral-600 line-clamp-1 mt-0.5 px-0.5">
                    {r?.regattaName
                      ? r.regattaName
                          .replace(/National Regatta/i, "NR")
                          .slice(0, 14)
                      : "—"}
                  </p>
                  <p className="text-base font-semibold text-white tabular-nums mt-1">
                    {r
                      ? `${r.score}${r.isOverseasCommitment ? "†" : r.isDNS ? "*" : ""}${r.isCarryForward ? " CF" : ""}`
                      : "—"}
                  </p>
                </div>
              );
            })}
          </div>
          {initialSeriesStanding.trendNote && (
            <p className="mt-3 text-[11px] text-emerald-400/90 font-medium">
              {initialSeriesStanding.trendNote}
            </p>
          )}
          <Link
            href={`/sg/optimist/${String(initialSeriesStanding.fleet).toLowerCase()}`}
            className="inline-block mt-2 text-[12px] font-medium text-orange-400 hover:text-orange-300"
          >
            View full {initialSeriesStanding.fleet} standings →
          </Link>
        </section>
      )}

      {/* ── Key stats ────────────────────────────────────────── */}
      <div className={`${cardClass} overflow-hidden`}>
        <div className="grid grid-cols-2 sm:grid-cols-4 divide-x divide-y sm:divide-y-0 divide-white/[0.06]">
          {statCells.map((s) => (
            <div key={s.label} className="px-3 py-5 text-center">
              <p
                className={`text-2xl sm:text-3xl font-semibold tabular-nums tracking-tight ${s.color}`}
              >
                {s.value}
              </p>
              <p className="mt-1 text-[10px] font-medium uppercase tracking-[0.12em] text-neutral-500">
                {s.label}
              </p>
            </div>
          ))}
        </div>
        {analytics.mode === "established_gold" && analytics.timeInGoldLabel && (
          <p className="border-t border-white/[0.06] px-4 py-2.5 text-center text-[11px] text-neutral-500">
            Best gold{" "}
            <span className="text-yellow-400 font-semibold">
              {analytics.bestGoldLabel}
            </span>
            <span className="text-neutral-600"> · </span>
            <span className="text-neutral-300 font-medium">
              {analytics.timeInGoldLabel}
            </span>{" "}
            in gold fleet
          </p>
        )}
      </div>

      {/* ── Medal tally ──────────────────────────────────────── */}
      {showMedals && (
        <section className={`${cardClass} p-4 sm:p-5`}>
          <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500 mb-3">
            Medal tally
          </h2>
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-2.5">
            {(
              [
                { label: "Gold", value: analytics.medals.gold, icon: "🥇" },
                { label: "Silver", value: analytics.medals.silver, icon: "🥈" },
                { label: "Bronze", value: analytics.medals.bronze, icon: "🥉" },
                { label: "Top 10", value: analytics.medals.top10, icon: "🏆" },
              ] as const
            ).map((m) => (
              <div
                key={m.label}
                className="rounded-xl border border-white/[0.05] bg-black/20 px-3 py-4 text-center"
              >
                <p className="text-lg" aria-hidden>
                  {m.icon}
                </p>
                <p className="mt-1 text-2xl font-semibold text-white tabular-nums">
                  {m.value}
                </p>
                <p className="mt-0.5 text-[11px] text-neutral-500">{m.label}</p>
              </div>
            ))}
          </div>
        </section>
      )}

      {/* ── Regatta results (last 8) ─────────────────────────── */}
      <section className={`${cardClass} overflow-hidden`}>
        <div className="px-4 sm:px-5 pt-4 sm:pt-5 pb-2 flex items-end justify-between gap-3">
          <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
            Regatta results
          </h2>
          <span className="text-[11px] text-neutral-600">
            {showAllResults
              ? `Showing all ${analytics.listResults.length}`
              : `Last ${Math.min(8, analytics.listResults.length)}`}
            {analytics.mode === "established_gold" ? " · gold fleet" : ""}
            {" · "}
            {analytics.regattaCount} total
          </span>
        </div>

        {isOwner && !demoMode && (
          <div className="mx-4 sm:mx-5 mb-3 rounded-xl border border-white/[0.06] bg-black/20 p-3 space-y-2">
            <p className="text-[10px] font-medium uppercase tracking-wide text-neutral-500">
              Add non-ranking result
            </p>
            <div className="grid grid-cols-2 sm:grid-cols-3 gap-2">
              <input
                value={personalForm.name}
                onChange={(e) =>
                  setPersonalForm((f) => ({ ...f, name: e.target.value }))
                }
                placeholder="Event name"
                className="col-span-2 sm:col-span-3 rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white"
              />
              <input
                type="date"
                value={personalForm.date}
                onChange={(e) =>
                  setPersonalForm((f) => ({ ...f, date: e.target.value }))
                }
                className="rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white"
              />
              <input
                type="number"
                min={1}
                value={personalForm.rank}
                onChange={(e) =>
                  setPersonalForm((f) => ({ ...f, rank: e.target.value }))
                }
                placeholder="Place"
                className="rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white"
              />
              <input
                type="number"
                min={1}
                value={personalForm.fleetSize}
                onChange={(e) =>
                  setPersonalForm((f) => ({ ...f, fleetSize: e.target.value }))
                }
                placeholder="Fleet size"
                className="rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white"
              />
            </div>
            <button
              type="button"
              disabled={personalBusy}
              onClick={() => void savePersonalResult()}
              className="rounded-lg bg-white/10 px-3 py-1.5 text-[11px] font-semibold text-white disabled:opacity-50"
            >
              {personalBusy ? "Saving…" : "Add to logbook"}
            </button>
            {personalMsg && (
              <p className="text-[11px] text-emerald-400">{personalMsg}</p>
            )}
          </div>
        )}

        {visibleResults.length === 0 ? (
          <p className="px-5 pb-5 text-sm text-neutral-600">
            No regatta results yet.
          </p>
        ) : (
          <>
            <div className="hidden sm:grid grid-cols-[2.75rem_1fr_3rem_4.25rem] gap-2 px-4 sm:px-5 py-2 border-t border-white/[0.05] text-[10px] font-medium uppercase tracking-wide text-neutral-600">
              <span>Pos</span>
              <span>Event</span>
              <span className="text-right">Pts</span>
              <span className="text-right">Fleet</span>
            </div>
            <div className="divide-y divide-white/[0.04]">
              {visibleResults.map((res, idx) => {
                const regattaId = String(res.regattaId || res.id || idx);
                const rank = res.rank != null ? Number(res.rank) : null;
                const dns = Boolean(res.isDns || res.isDNS);
                const fleet = fleetLabelForResult(res, analytics.goldEntryDate);
                const slug = res.regattaSlug || res.id;
                const expanded = expandedRegattaId === regattaId;
                const raceNotes = obsForRegatta(regattaId);
                const fleetSize = res.totalFleetSize ?? res.fleetSize;
                const nonRanking = res.countsForRanking === false;
                const canLink =
                  !nonRanking && slug && String(slug).length > 2;
                const pts =
                  res.nettScore != null &&
                  Number.isFinite(Number(res.nettScore))
                    ? Number(res.nettScore)
                    : null;
                const tags = buildResultTags(res, analytics.goldEntryDate);

                return (
                  <div key={regattaId + String(idx)}>
                    <div
                      role="button"
                      tabIndex={0}
                      onClick={() =>
                        setExpandedRegattaId(expanded ? null : regattaId)
                      }
                      onKeyDown={(e) => {
                        if (e.key === "Enter" || e.key === " ") {
                          e.preventDefault();
                          setExpandedRegattaId(expanded ? null : regattaId);
                        }
                      }}
                      className="grid grid-cols-[2.75rem_1fr_auto] sm:grid-cols-[2.75rem_1fr_3rem_4.25rem] gap-2 items-start px-4 sm:px-5 py-3.5 cursor-pointer hover:bg-white/[0.02]"
                    >
                      <span
                        className={`text-[15px] font-semibold tabular-nums pt-0.5 ${
                          dns ? "text-rose-400" : "text-neutral-200"
                        }`}
                      >
                        {dns ? "DNS" : rank != null ? rank : "—"}
                      </span>
                      <div className="min-w-0">
                        {canLink ? (
                          <Link
                            href={`/sg/optimist/regattas/${slug}`}
                            onClick={(e) => e.stopPropagation()}
                            className="text-[13px] font-medium text-white truncate block hover:text-neutral-300"
                          >
                            {res.regattaName}
                          </Link>
                        ) : (
                          <p className="text-[13px] font-medium text-white truncate">
                            {res.regattaName}
                          </p>
                        )}
                        <p className="text-[11px] text-neutral-500 truncate mt-0.5">
                          {[
                            res.geography,
                            formatEventWhen(res.regattaDate as string),
                            fleetSize ? `${fleetSize} boats` : null,
                          ]
                            .filter(Boolean)
                            .join(" · ")}
                        </p>
                        {tags.length > 0 && (
                          <div className="mt-1.5 flex flex-wrap gap-1">
                            {tags.map((t) => (
                              <span
                                key={t.label}
                                className={`rounded-md px-1.5 py-px text-[9px] font-semibold border ${t.className}`}
                              >
                                {t.label}
                              </span>
                            ))}
                          </div>
                        )}
                      </div>
                      <span className="hidden sm:block text-right text-[13px] tabular-nums text-neutral-400 pt-0.5">
                        {pts != null ? pts : "—"}
                      </span>
                      <span className="flex items-center justify-end pt-0.5">
                        <span
                          className={`rounded-full px-2 py-0.5 text-[10px] font-semibold ${fleetPillClass(fleet)}`}
                        >
                          {fleet === "—" ? "—" : fleet}
                        </span>
                      </span>
                    </div>

                    {isOwner && !demoMode && nonRanking && res.resultId && (
                        <button
                          type="button"
                          disabled={personalBusy}
                          onClick={() => void deletePersonalResult(res)}
                          className="ml-14 mb-2 text-[10px] font-medium text-rose-400/90"
                        >
                          Remove
                        </button>
                      )}

                    {expanded && (
                      <div className="px-4 sm:px-5 pb-4 space-y-3 border-t border-white/[0.04] bg-black/15">
                        <div className="flex items-center gap-2 pt-3 text-[11px] font-medium text-neutral-500 uppercase tracking-wide">
                          <BookOpen className="h-3.5 w-3.5 text-orange-400" />
                          Race observations
                        </div>
                        {raceNotes.length === 0 ? (
                          <p className="text-xs text-neutral-600">
                            {isOwner
                              ? "No notes yet — add wind, place, and takeaways below."
                              : "No public race notes for this event."}
                          </p>
                        ) : (
                          <ul className="space-y-2">
                            {raceNotes.map((o: Record<string, unknown>) => (
                              <li
                                key={String(
                                  o.id || `${o.regattaId}-${o.raceNumber}`
                                )}
                                className="rounded-lg border border-white/[0.06] bg-black/20 px-3 py-2"
                              >
                                <div className="flex items-center justify-between gap-2">
                                  <span className="text-xs font-semibold text-neutral-200">
                                    Race {String(o.raceNumber)}
                                  </span>
                                  <span className="text-[11px] font-mono text-neutral-500">
                                    {o.position != null
                                      ? `Score ${o.position}`
                                      : "—"}
                                    {o.wind ? ` · ${o.wind}` : ""}
                                    {o.isPrivate ? " · private" : ""}
                                  </span>
                                </div>
                                {o.note ? (
                                  <p className="text-xs text-neutral-400 mt-1">
                                    {String(o.note)}
                                  </p>
                                ) : null}
                                {isOwner && (
                                  <div className="mt-1.5 flex gap-2">
                                    <button
                                      type="button"
                                      onClick={() =>
                                        startEditObservation(o, regattaId)
                                      }
                                      className="text-[10px] font-medium text-neutral-400 hover:text-white"
                                    >
                                      Edit
                                    </button>
                                    {(o.id || demoMode) ? (
                                      <button
                                        type="button"
                                        disabled={obsBusy}
                                        onClick={() => {
                                          if (demoMode) {
                                            setObservations((prev) =>
                                              prev.filter(
                                                (x) =>
                                                  !(
                                                    x.regattaId === regattaId &&
                                                    Number(x.raceNumber) ===
                                                      Number(o.raceNumber)
                                                  )
                                              )
                                            );
                                            return;
                                          }
                                          void deleteObservation(o);
                                        }}
                                        className="text-[10px] font-medium text-rose-400/90"
                                      >
                                        Delete
                                      </button>
                                    ) : null}
                                  </div>
                                )}
                              </li>
                            ))}
                          </ul>
                        )}
                        {isOwner && (
                          <div className="rounded-lg border border-orange-500/20 bg-orange-500/[0.06] p-3 space-y-2">
                            <p className="text-[10px] font-medium uppercase text-orange-300/90">
                              {editingObsId
                                ? "Edit observation"
                                : "Add observation"}
                              {demoMode ? " (demo)" : ""}
                            </p>
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
                                className="rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white"
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
                                className="rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white"
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
                                className="rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white sm:col-span-2"
                              />
                              <input
                                value={obsForm.note}
                                onChange={(e) =>
                                  setObsForm((f) => ({
                                    ...f,
                                    note: e.target.value,
                                  }))
                                }
                                placeholder="Notes"
                                className="rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white col-span-2 sm:col-span-3"
                              />
                              <label className="flex items-center gap-1.5 text-[10px] text-neutral-500">
                                <input
                                  type="checkbox"
                                  checked={obsForm.isPrivate}
                                  onChange={(e) =>
                                    setObsForm((f) => ({
                                      ...f,
                                      isPrivate: e.target.checked,
                                    }))
                                  }
                                  className="rounded border-neutral-600"
                                />
                                Private
                              </label>
                            </div>
                            <div className="flex gap-2">
                              <button
                                type="button"
                                disabled={obsBusy}
                                onClick={() => void saveObservation(regattaId)}
                                className="rounded-lg bg-orange-500 text-white px-3 py-1.5 text-[11px] font-semibold disabled:opacity-50"
                              >
                                {obsBusy
                                  ? "Saving…"
                                  : editingObsId
                                    ? "Update"
                                    : "Save"}
                              </button>
                              <button
                                type="button"
                                onClick={resetObsForm}
                                className="text-[11px] text-neutral-500 hover:text-white"
                              >
                                Clear
                              </button>
                            </div>
                            {obsMsg && (
                              <p className="text-[11px] text-emerald-400">
                                {obsMsg}
                              </p>
                            )}
                          </div>
                        )}
                      </div>
                    )}
                  </div>
                );
              })}
            </div>
            {hasMoreResults && (
              <div className="border-t border-white/[0.05] px-4 sm:px-5 py-3 text-center">
                <button
                  type="button"
                  onClick={() => setShowAllResults((v) => !v)}
                  className="text-[12px] font-semibold text-orange-400 hover:text-orange-300"
                >
                  {showAllResults
                    ? "Show fewer"
                    : `View all ${analytics.listResults.length} results`}
                </button>
              </div>
            )}
          </>
        )}
      </section>

      {/* ── Position trend ───────────────────────────────────── */}
      <section className={`${cardClass} p-4 sm:p-5`}>
        <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
          Position trend
        </h2>
        <p className="text-[12px] text-neutral-400 mt-0.5 mb-4">
          Finishing position by regatta (lower is better)
          {analytics.mode === "established_gold"
            ? " · last 10 gold fleet"
            : " · last 10 regattas"}
        </p>
        {!trendSvg ? (
          <p className="text-sm text-neutral-600 py-8 text-center">
            Need at least two ranked finishes to chart progress.
          </p>
        ) : (
          <div className="relative w-full overflow-hidden">
            <svg
              viewBox={`0 0 ${trendSvg.w} ${trendSvg.h}`}
              className="w-full h-auto"
              role="img"
              aria-label="Position trend chart"
            >
              {trendSvg.gridRanks.map((r) => (
                <g key={r}>
                  <line
                    x1={trendSvg.padL}
                    x2={trendSvg.w - trendSvg.padR}
                    y1={trendSvg.yFor(r)}
                    y2={trendSvg.yFor(r)}
                    stroke="rgba(255,255,255,0.05)"
                    strokeDasharray="4 4"
                  />
                  <text
                    x={trendSvg.padL - 8}
                    y={trendSvg.yFor(r) + 3}
                    textAnchor="end"
                    fill="#6b7280"
                    fontSize="10"
                  >
                    {r}
                  </text>
                </g>
              ))}
              {trendSvg.showSegregation && trendSvg.promoX != null && (
                <>
                  <line
                    x1={trendSvg.promoX}
                    x2={trendSvg.promoX}
                    y1={trendSvg.padT - 4}
                    y2={trendSvg.h - trendSvg.padB}
                    stroke="rgba(255,255,255,0.22)"
                    strokeDasharray="3 4"
                  />
                  <text
                    x={trendSvg.promoX}
                    y={trendSvg.h - 10}
                    textAnchor="middle"
                    fill="#6b7280"
                    fontSize="9"
                  >
                    Promotion
                  </text>
                  <text
                    x={trendSvg.promoX - 12}
                    y={16}
                    textAnchor="end"
                    fill="#9ca3af"
                    fontSize="10"
                  >
                    Silver fleet
                  </text>
                  <text
                    x={trendSvg.promoX + 12}
                    y={16}
                    textAnchor="start"
                    fill="#fbbf24"
                    fontSize="10"
                  >
                    Gold fleet
                  </text>
                </>
              )}
              {!trendSvg.showSegregation && (
                <text
                  x={trendSvg.w / 2}
                  y={16}
                  textAnchor="middle"
                  fill="#fbbf24"
                  fontSize="10"
                >
                  Gold fleet
                </text>
              )}
              {trendSvg.silverPath && (
                <path
                  d={trendSvg.silverPath}
                  fill="none"
                  stroke="rgba(229,231,235,0.85)"
                  strokeWidth="2"
                  strokeLinejoin="round"
                  strokeLinecap="round"
                />
              )}
              {trendSvg.goldPath && (
                <path
                  d={trendSvg.goldPath}
                  fill="none"
                  stroke="#f59e0b"
                  strokeWidth="2"
                  strokeLinejoin="round"
                  strokeLinecap="round"
                />
              )}
              {trendSvg.pts.map((p, i) => {
                const cx = trendSvg.xFor(i);
                const cy = trendSvg.yFor(p.rank);
                // Place label above the point when space allows, else below
                const labelAbove = cy > trendSvg.padT + 18;
                const labelY = labelAbove ? cy - 12 : cy + 16;
                return (
                  <g key={i}>
                    <circle
                      cx={cx}
                      cy={cy}
                      r={5}
                      fill={p.fleet === "Gold" ? "#f59e0b" : "#e5e7eb"}
                      stroke="#151b2b"
                      strokeWidth="2"
                    >
                      <title>
                        {p.name}: {ordinal(p.rank)} ({p.date}) · {p.fleet}
                      </title>
                    </circle>
                    <text
                      x={cx}
                      y={labelY}
                      textAnchor="middle"
                      fill={p.fleet === "Gold" ? "#fbbf24" : "#e5e7eb"}
                      fontSize="11"
                      fontWeight="600"
                    >
                      {p.rank}
                    </text>
                  </g>
                );
              })}
            </svg>
          </div>
        )}
      </section>

      {/* ── Journey + Equipment ──────────────────────────────── */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
        <section className={`${cardClass} p-5`}>
          <div className="flex items-center gap-2 mb-1">
            <Anchor className="h-4 w-4 text-sky-400/90" />
            <h2 className="text-[14px] font-semibold text-white">
              Sailing Journey
            </h2>
          </div>
          <p className="text-[11px] text-neutral-500 mb-4">
            Key moments — campaigns, firsts, and milestones.
          </p>
          {journey.length === 0 ? (
            <p className="text-sm text-neutral-600">
              {isOwner
                ? "No highlights yet. Add one below."
                : "No journey highlights shared yet."}
            </p>
          ) : (
            <ol className="relative ml-0.5 space-y-0 border-l border-white/10">
              {journey.map((it) => (
                <li key={it.id} className="relative pl-4 pb-4 last:pb-0">
                  <span className="absolute -left-[3px] top-1.5 h-1.5 w-1.5 rounded-full bg-neutral-500" />
                  {it.when && (
                    <p className="text-[11px] font-semibold uppercase tracking-wide text-orange-400">
                      {it.when}
                    </p>
                  )}
                  <p className="text-sm font-semibold text-white mt-0.5">
                    {it.title}
                  </p>
                  {it.detail && (
                    <p className="text-xs text-neutral-500 mt-0.5 leading-relaxed">
                      {it.detail}
                    </p>
                  )}
                  {isOwner && (
                    <button
                      type="button"
                      disabled={journeyBusy}
                      onClick={() => void removeJourneyItem(it.id)}
                      className="mt-1 text-[10px] text-rose-400/90"
                    >
                      Remove
                    </button>
                  )}
                </li>
              ))}
            </ol>
          )}
          {isOwner && (
            <div className="mt-4 space-y-2 border-t border-white/[0.06] pt-3">
              <input
                value={journeyDraft.when}
                onChange={(e) =>
                  setJourneyDraft((d) => ({ ...d, when: e.target.value }))
                }
                placeholder="When"
                className="w-full rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white"
              />
              <input
                value={journeyDraft.title}
                onChange={(e) =>
                  setJourneyDraft((d) => ({ ...d, title: e.target.value }))
                }
                placeholder="Title"
                className="w-full rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white"
              />
              <textarea
                value={journeyDraft.detail}
                onChange={(e) =>
                  setJourneyDraft((d) => ({ ...d, detail: e.target.value }))
                }
                placeholder="Detail"
                rows={2}
                className="w-full rounded-lg bg-black/40 border border-white/10 px-2 py-1.5 text-xs text-white resize-none"
              />
              <button
                type="button"
                disabled={journeyBusy || !journeyDraft.title.trim()}
                onClick={() => void addJourneyItem()}
                className="rounded-lg bg-white/10 px-3 py-1.5 text-[11px] font-semibold text-white disabled:opacity-40"
              >
                {journeyBusy ? "Saving…" : "Add highlight"}
              </button>
              {journeyMsg && (
                <p className="text-[11px] text-emerald-400">{journeyMsg}</p>
              )}
            </div>
          )}
        </section>

        <section className={`${cardClass} p-5`}>
          <div className="flex items-center gap-2 mb-1">
            <Settings className="h-4 w-4 text-orange-400/90" />
            <h2 className="text-[14px] font-semibold text-white">Equipment</h2>
          </div>
          <p className="text-[11px] text-neutral-500 mb-4">
            Hull, sail, foils &amp; mast
          </p>
          {hasEquipment ? (
            <div className="space-y-0">
              {[
                ["Hull", displayEquipment.hullBrand],
                ["Sail", displayEquipment.sailMake],
                ["Foils", displayEquipment.foilBrand],
                ["Mast", displayEquipment.mast],
              ].map(([label, val]) => (
                <div
                  key={label as string}
                  className="flex justify-between py-2.5 border-b border-white/[0.05] last:border-0 text-sm"
                >
                  <span className="text-neutral-500">{label}</span>
                  <span className="text-white font-medium">
                    {(val as string) || "—"}
                  </span>
                </div>
              ))}
              {displayEquipment.notes && (
                <p className="mt-3 text-xs text-neutral-500">
                  {displayEquipment.notes}
                </p>
              )}
            </div>
          ) : (
            <div className="flex flex-col items-center py-6 text-center">
              <EyeOff className="h-6 w-6 text-neutral-700 mb-2" />
              <p className="text-xs text-neutral-500">
                {!showEquipment
                  ? "Equipment log is private."
                  : isOwner
                    ? "No equipment yet — use Edit to add gear."
                    : "No equipment logged yet."}
              </p>
            </div>
          )}
        </section>
      </div>

      {/* ── Privacy (owner) ──────────────────────────────────── */}
      {canSeePrivate && (
        <section className={`${cardClass} p-5`}>
          <div className="flex items-center gap-2 mb-4">
            <Settings className="h-3.5 w-3.5 text-neutral-500" />
            <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
              Privacy
            </h2>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-2">
            {(
              [
                ["Share weight", isPublicWeight, setIsPublicWeight],
                ["Share equipment", isPublicEquipment, setIsPublicEquipment],
                ["Share date of birth", isPublicDob, setIsPublicDob],
              ] as const
            ).map(([label, checked, setter]) => (
              <label
                key={label}
                className="flex items-center justify-between gap-3 rounded-xl border border-white/[0.06] bg-black/20 px-3 py-2.5"
              >
                <span className="text-xs text-neutral-300">{label}</span>
                <input
                  type="checkbox"
                  checked={checked}
                  disabled={!isOwner}
                  onChange={(e) => setter(e.target.checked)}
                  className="rounded border-neutral-600"
                />
              </label>
            ))}
          </div>
          {isOwner && (
            <button
              type="button"
              disabled={saveBusy}
              onClick={() => void saveProfile()}
              className="mt-3 rounded-lg border border-white/10 px-4 py-2 text-[11px] font-semibold text-neutral-300 disabled:opacity-50"
            >
              {saveBusy ? "Saving…" : "Save privacy"}
            </button>
          )}
        </section>
      )}
    </div>
  );
}
