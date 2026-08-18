"use client";

import { useEffect, useMemo, useRef, useState } from "react";

import Link from "next/link";
import { normalizeNationality } from "@/lib/seriesMembership";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import {
  Link2,
  UserPlus,
  Pencil,
  BookOpen,
  Camera,
  Settings,
  EyeOff,
  Anchor,
  Clock,
  Trophy,
  ChevronDown,
  ChevronRight,
  StickyNote,
  BadgeCheck,
  ShieldAlert,
  X,
} from "lucide-react";
import { formatEventWhen } from "@/lib/profileUi";
import {
  buildSystemJourneyMilestones,
  dismissSystemMilestone,
  mergeJourneyDisplay,
  newJourneyId,
  parseSailingJourney,
  type JourneyHighlight,
} from "@/lib/sailingJourney";
import {
  buildIlcaKeyStats,
  buildIlcaPositionTrend,
  buildProfileAnalytics,
  buildResultTags,
  fleetLabelForResult,
  optimistLeftYear,
  prefersIlcaFirstProfile,
  profileBoatClassGroup,
  tenureFromFirstDate,
  ilcaHighPointsForResult,
  type ProfileResult,
} from "@/lib/profileAnalytics";
import dynamic from "next/dynamic";
import { EquipmentInventory } from "@/components/EquipmentInventory";
import { ClaimPanel } from "@/components/sailor-profile/ClaimPanel";
import {
  PROFILE_CARD_CLASS as cardClass,
  resolveDisplayFleet,
  fleetPillClass,
  nationalityFlag,
  nationalityLabel,
  initials,
  formatFullDob,
  type SailorRecordProps,
  type RegattaResultItem,
  type ObservationItem,
  type SailorProfileViewProps,
} from "@/components/sailor-profile";
import { useFeedback } from "@/components/ui/FeedbackProvider";

const PositionTrendChart = dynamic(
  () =>
    import("@/components/sailor-profile/PositionTrendChart").then(
      (m) => m.PositionTrendChart
    ),
  {
    ssr: false,
    loading: () => (
      <div className="h-48 w-full animate-pulse rounded-2xl bg-white/5 border border-white/5" />
    ),
  }
);

export type {
  SailorRecordProps,
  RegattaResultItem,
  ObservationItem,
  SailorProfileViewProps,
};

export function SailorProfileView({
  initialSailor,
  initialResults,
  initialEquipment,
  initialSeriesStanding = null,
  initialIlcaStanding = null,
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
  hidePrivacySection = false,
  profileVerified = false,
}: SailorProfileViewProps) {
  const { toast, confirm } = useFeedback();
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
  const [claimPanelOpen, setClaimPanelOpen] = useState(false);
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
    club: String(initialSailor.club || ""),
    sailNumber: String(initialSailor.sailNumber || ""),
    sailNumberIlca4: String(initialSailor.sailNumberIlca4 || ""),
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
    hullBrandIlca4: String(
      initialSailor.hullBrandIlca4 || initialEquipment?.hullBrandIlca4 || ""
    ),
    sailMakeIlca4: String(
      initialSailor.sailMakeIlca4 || initialEquipment?.sailMakeIlca4 || ""
    ),
    foilBrandIlca4: String(
      initialSailor.foilBrandIlca4 || initialEquipment?.foilBrandIlca4 || ""
    ),
    mastIlca4: String(
      initialSailor.mastIlca4 || initialEquipment?.mastIlca4 || ""
    ),
    equipmentNotesIlca4: String(
      initialSailor.equipmentNotesIlca4 ||
        initialEquipment?.notesIlca4 ||
        ""
    ),
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
  /** Dual-class profiles: Optimist · ILCA 4 · Journey */
  const [resultsTab, setResultsTab] = useState<"optimist" | "ilca4" | "journey">(
    () => {
      const prefer = prefersIlcaFirstProfile({
        dropDate: initialSailor.dropDate as string | null | undefined,
        dob: initialSailor.dob as string | null | undefined,
      });
      return prefer ? "ilca4" : "optimist";
    }
  );
  /** One-time dismissible tip near regatta table (owner / sailor demo) */
  const [dismissSailorTip, setDismissSailorTip] = useState(false);
  /** Equipment logged per regatta (owner-only linkage from EquipmentInventory) */
  const [gearByRegatta, setGearByRegatta] = useState<
    Record<
      string,
      { category: string; brand: string | null; label: string | null }[]
    >
  >({});

  // Do not auto-open the profile editor on visit (owners open Edit explicitly).

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
  // Equipment is always private — owner / private access only (never public)
  const showEquipment = hasPrivateAccess || isOwner;

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
          club: form.club,
          sailNumber: form.sailNumber,
          sailNumberIlca4: form.sailNumberIlca4 || null,
          dob: form.dob === "" ? null : form.dob,
          weight: form.weight === "" ? null : Number(form.weight),
          isPublicWeight,
          isPublicDob,
          isPublicEquipment: false,
          hullBrand: form.hullBrand,
          sailMake: form.sailMake,
          foilBrand: form.foilBrand,
          mast: form.mast,
          equipmentNotes: form.equipmentNotes,
          hullBrandIlca4: form.hullBrandIlca4,
          sailMakeIlca4: form.sailMakeIlca4,
          foilBrandIlca4: form.foilBrandIlca4,
          mastIlca4: form.mastIlca4,
          equipmentNotesIlca4: form.equipmentNotesIlca4,
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
      setForm((f) => ({
        ...f,
        handle: data.sailor.handle || f.handle,
        club: data.sailor.club ?? f.club,
        sailNumber: data.sailor.sailNumber ?? f.sailNumber,
        sailNumberIlca4: data.sailor.sailNumberIlca4 ?? f.sailNumberIlca4,
        hullBrandIlca4: data.sailor.hullBrandIlca4 ?? f.hullBrandIlca4,
        sailMakeIlca4: data.sailor.sailMakeIlca4 ?? f.sailMakeIlca4,
        foilBrandIlca4: data.sailor.foilBrandIlca4 ?? f.foilBrandIlca4,
        mastIlca4: data.sailor.mastIlca4 ?? f.mastIlca4,
        equipmentNotesIlca4:
          data.sailor.equipmentNotesIlca4 ?? f.equipmentNotesIlca4,
      }));
      setSaveMsg("Saved");
      setEditing(false);
      if (data.handleChanged && data.sailor?.handle) {
        window.location.assign(`/${data.sailor.handle}`);
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

  const removeJourneyItem = async (id: string, isSystem?: boolean) => {
    const ok = await confirm({
      title: "Remove this highlight from your journey?",
      tone: "danger",
      confirmLabel: "Remove",
    });
    if (!ok) return;
    if (isSystem) {
      await persistJourney(dismissSystemMilestone(journey, id));
      return;
    }
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
    const ok = await confirm({
      title: `Remove “${res.regattaName}” from your logbook?`,
      tone: "danger",
      confirmLabel: "Remove",
    });
    if (!ok) return;
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
      toast.error(e.message || "Delete failed");
      setPersonalMsg(e.message || "Delete failed");
    } finally {
      setPersonalBusy(false);
    }
  };

  const deleteObservation = async (o: any) => {
    if (demoMode || !o?.id) return;
    const ok = await confirm({
      title: `Delete observation for race ${o.raceNumber}?`,
      tone: "danger",
      confirmLabel: "Delete",
    });
    if (!ok) return;
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
      toast.error(e.message || "Delete failed");
      setObsMsg(e.message || "Delete failed");
    } finally {
      setObsBusy(false);
    }
  };

  const obsForRegatta = (regattaId: string) =>
    observations
      .filter((o: any) => o.regattaId === regattaId)
      .sort((a: any, b: any) => a.raceNumber - b.raceNumber);


  /** Split raw results by boat class (before gold filtering). ILCA 6 folds into ILCA 4. */
  const classBuckets = useMemo(() => {
    const all = results as ProfileResult[];
    const optimist: ProfileResult[] = [];
    const ilca4: ProfileResult[] = [];
    for (const r of all) {
      const g = profileBoatClassGroup(r.boatClass);
      if (g === "ilca4") ilca4.push(r);
      else if (g === "optimist") optimist.push(r);
      // "other" ignored for class tabs
    }
    const byDate = (a: ProfileResult, b: ProfileResult) =>
      String(b.regattaDate || "").localeCompare(String(a.regattaDate || ""));
    optimist.sort(byDate);
    ilca4.sort(byDate);
    return { optimist, ilca4 };
  }, [results]);

  const leftOptimistYear = optimistLeftYear({
    dropDate: displaySailor.dropDate as string | null | undefined,
    dob: displaySailor.dob as string | null | undefined,
  });
  const preferIlcaFirst = prefersIlcaFirstProfile({
    dropDate: displaySailor.dropDate as string | null | undefined,
    dob: displaySailor.dob as string | null | undefined,
  });
  const hasIlca4Data =
    classBuckets.ilca4.length > 0 ||
    Boolean(String(displaySailor.sailNumberIlca4 || "").trim());
  const optimistOnlyAbsent = classBuckets.optimist.length === 0;

  const fleetBadge = resolveDisplayFleet(
    displaySailor as Record<string, unknown>,
    {
      hasIlca4: hasIlca4Data,
      preferIlca: preferIlcaFirst && hasIlca4Data,
      optimistOnlyAbsent: optimistOnlyAbsent && hasIlca4Data,
    }
  );

  // Optimist-only analytics (gold tenure, medals, trend) — ILCA never mixes in
  const analytics = useMemo(
    () =>
      buildProfileAnalytics(
        displaySailor as never,
        classBuckets.optimist as never,
        observations as never,
        initialSeriesStanding
          ? {
              overallRank: initialSeriesStanding.overallRank,
              fleetSize: initialSeriesStanding.fleetSize,
              fleet: initialSeriesStanding.fleet,
            }
          : null
      ),
    [displaySailor, classBuckets.optimist, observations, initialSeriesStanding]
  );

  /**
   * DOB privacy:
   * - Birth year is always public when DOB is set
   * - Full date only when owner shared it or viewer has private access
   * - Age is never shown on public profiles (birth year only)
   */
  const dobYmd = displaySailor.dob
    ? String(displaySailor.dob).slice(0, 10)
    : "";
  const bornYear =
    /^\d{4}-\d{2}-\d{2}$/.test(dobYmd) ? dobYmd.slice(0, 4) : null;
  const showFullDob =
    Boolean(bornYear) && (isPublicDob || hasPrivateAccess);
  const fullDobLabel =
    showFullDob && dobYmd ? formatFullDob(dobYmd) : null;

  const hasEquipment =
    showEquipment &&
    displayEquipment &&
    (displayEquipment.hullBrand ||
      displayEquipment.sailMake ||
      displayEquipment.foilBrand ||
      displayEquipment.mast ||
      displayEquipment.notes ||
      displaySailor.hullBrandIlca4 ||
      displaySailor.sailMakeIlca4 ||
      displaySailor.foilBrandIlca4 ||
      displaySailor.mastIlca4 ||
      displaySailor.equipmentNotesIlca4);

  const optimistResults = analytics.listResults;
  const ilca4Results = classBuckets.ilca4;
  const hasIlcaResults = ilca4Results.length > 0;
  const hasOptimistResults =
    optimistResults.length > 0 || classBuckets.optimist.length > 0;
  const dualClass = hasIlcaResults && classBuckets.optimist.length > 0;
  const ilca4Tenure = useMemo(() => {
    if (!ilca4Results.length) return null;
    const first = [...ilca4Results]
      .map((r) => String(r.regattaDate || "").slice(0, 10))
      .filter((d) => /^\d{4}-\d{2}-\d{2}$/.test(d))
      .sort()[0];
    return tenureFromFirstDate(first);
  }, [ilca4Results]);

  const ilcaKeyStats = useMemo(
    () => buildIlcaKeyStats(ilca4Results as ProfileResult[]),
    [ilca4Results]
  );

  // Dual class: default to Optimist unless left Optimist → ILCA first.
  const resultsForPrimarySection = dualClass
    ? preferIlcaFirst
      ? ilca4Results
      : optimistResults
    : hasIlcaResults && classBuckets.optimist.length === 0
      ? ilca4Results
      : optimistResults;

  /** Active class list for the results panel (tabs when dual-class) */
  const activeResultsList =
    dualClass && resultsTab === "ilca4"
      ? ilca4Results
      : dualClass && resultsTab === "journey"
        ? []
        : dualClass
          ? optimistResults
          : resultsForPrimarySection;
  const visibleResults = showAllResults
    ? activeResultsList
    : activeResultsList.slice(0, 8);
  const hasMoreResults = activeResultsList.length > 8;
  /** Showing ILCA columns (points + rank) vs Optimist (place + nett) */
  const primaryIsIlca =
    (dualClass && resultsTab === "ilca4") ||
    (!dualClass && hasIlcaResults && classBuckets.optimist.length === 0) ||
    (dualClass && preferIlcaFirst && resultsTab === "ilca4");

  const sailDisplay = String(displaySailor.sailNumber || "—");
  const sailIlca4 = displaySailor.sailNumberIlca4
    ? String(displaySailor.sailNumberIlca4)
    : null;
  const noc =
    normalizeNationality(displaySailor.nationality) ||
    (String(displaySailor.nationality || "").trim() ? "SGP" : "SGP");

  // Stats cells by mode — include gold entry year when known
  const goldTenureLabel = analytics.timeInGoldLabel
    ? analytics.goldEntryYear
      ? `${analytics.timeInGoldLabel}${
          analytics.isDroppedFromGold ? " (ended)" : ""
        }`
      : analytics.timeInGoldLabel
    : "—";
  const goldTenureSub =
    analytics.goldEntryYear != null
      ? analytics.isDroppedFromGold
        ? `Gold since ${analytics.goldEntryYear} · dropped`
        : `Gold since ${analytics.goldEntryYear}`
      : analytics.isDroppedFromGold
        ? "Dropped from gold"
        : "In gold fleet";

  /**
   * ILCA-focused stats whenever:
   * - ILCA-only profile, or
   * - dual-class user is on the ILCA 4 tab, or
   * - ILCA-first after leaving Optimist
   */
  const useIlcaStats =
    (hasIlcaResults && classBuckets.optimist.length === 0) ||
    (hasIlcaResults && dualClass && resultsTab === "ilca4") ||
    (preferIlcaFirst && hasIlcaResults && !hasOptimistResults);

  const ilcaStatCells =
    leftOptimistYear != null
      ? [
          {
            value: String(ilcaKeyStats.regattaCount),
            label: "Regattas",
            color: "text-white",
          },
          {
            value: ilcaKeyStats.bestFinishLabel,
            label: "Best finish",
            color: "text-emerald-400",
          },
          {
            value: ilcaKeyStats.avgFinishLabel,
            label: "Avg. finish",
            color: "text-sky-400",
          },
          {
            value: String(leftOptimistYear),
            label: "Left Optimist",
            color: "text-white",
          },
        ]
      : [
          {
            value: String(ilcaKeyStats.regattaCount),
            label: "Regattas",
            color: "text-white",
          },
          {
            value: String(ilcaKeyStats.top10Count),
            label: "Top 10",
            color: "text-emerald-400",
          },
          {
            value: ilcaKeyStats.avgFinishLabel,
            label: "Avg. finish",
            color: "text-sky-400",
          },
          {
            value: ilcaKeyStats.bestFinishLabel,
            label: "Best finish",
            color: "text-white",
          },
        ];

  const statCells = useIlcaStats
    ? ilcaStatCells
    : analytics.mode === "established_gold"
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
            value: goldTenureLabel,
            label: goldTenureSub,
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
            label: "Best silver rank",
            color: "text-emerald-400",
          },
          {
            value: analytics.bestGoldLabel,
            label: "Best gold rank",
            color: "text-amber-400",
          },
          {
            value: goldTenureLabel,
            label: goldTenureSub,
            color: "text-white",
          },
        ];

  const keyStatsTitle = useIlcaStats
    ? "Key stats (ILCA 4)"
    : "Key stats (Optimist)";
  const medalTallyTitle = "Medal tally (Optimist)";

  // Medal tally only for established Optimist gold (never on ILCA tab)
  const showMedals =
    !useIlcaStats &&
    analytics.mode === "established_gold" &&
    analytics.medals.show;

  /**
   * Ranking strip: on ILCA context prefer ILCA national standing;
   * fall back to Optimist series if ILCA standing is missing (live safety net).
   */
  const activeStanding = useIlcaStats
    ? initialIlcaStanding ?? initialSeriesStanding ?? null
    : initialSeriesStanding ?? null;
  const standingIsIlca = Boolean(
    useIlcaStats &&
      initialIlcaStanding &&
      (String(initialIlcaStanding.boatClass || "")
        .toLowerCase()
        .includes("ilca") ||
        String(initialIlcaStanding.fleet || "")
          .toLowerCase()
          .includes("open"))
  );

  /** Public viewers only see equipment when the sailor made it public */
  const showEquipmentSection = isOwner || hasPrivateAccess;

  // ILCA position trend (Open fleet) — shown for ILCA-only or dual-class ILCA tab
  const ilcaTrendPoints = useMemo(
    () => buildIlcaPositionTrend(ilca4Results as ProfileResult[]),
    [ilca4Results]
  );
  const showIlcaTrend =
    primaryIsIlca || (dualClass && resultsTab === "ilca4");
  const trendPoints = showIlcaTrend ? ilcaTrendPoints : analytics.trend;
  const trendMode = showIlcaTrend ? ("other" as const) : analytics.mode;
  const trendGoldEntry = showIlcaTrend ? null : analytics.goldEntryDate;
  const trendCaption = showIlcaTrend
    ? " · last 10 ILCA 4 regattas"
    : analytics.mode === "established_gold"
      ? " · last 10 gold events"
      : " · last 10 regattas";

  // System + owner journey milestones (Optimist + ILCA results for first ILCA 4)
  const displayJourney = useMemo(() => {
    const allResults = [
      ...(classBuckets.optimist as ProfileResult[]),
      ...(classBuckets.ilca4 as ProfileResult[]),
    ];
    const system = buildSystemJourneyMilestones(
      {
        goldEntryDate: displaySailor.goldEntryDate as string | null | undefined,
        silverEntryDate: displaySailor.silverEntryDate as
          | string
          | null
          | undefined,
        dropDate: displaySailor.dropDate as string | null | undefined,
        dob: displaySailor.dob as string | null | undefined,
      },
      allResults,
      { optimistLeftYear: leftOptimistYear }
    );
    return mergeJourneyDisplay(journey, system);
  }, [
    displaySailor,
    classBuckets.optimist,
    classBuckets.ilca4,
    journey,
    leftOptimistYear,
  ]);

  return (
    <div className="mx-auto max-w-3xl px-3 sm:px-6 py-5 sm:py-10 flex-1 w-full min-w-0 space-y-4 sm:space-y-5 bg-[#090a0f] overflow-x-clip">
      {/* Claim banner — unclaimed public profiles (logged-in claim or log-in CTA) */}
      {(() => {
        const isUnclaimed =
          !profileClaimed && !profileVerified && !isOwner;
        const showBanner =
          isUnclaimed &&
          (demoMode
            ? canClaim || demoRole === "public"
            : true);
        if (!showBanner) return null;
        const handleClaim = () => {
          if (demoMode) {
            onDemoClaim?.();
            return;
          }
          if (!isLoggedIn) {
            if (typeof window !== "undefined") {
              window.location.href = `/login?next=${encodeURIComponent(
                `/${displaySailor.handle || ""}`
              )}`;
            }
            return;
          }
          setClaimPanelOpen(true);
        };
        return (
          <div className="rounded-2xl border border-orange-500/30 bg-gradient-to-r from-orange-500/15 to-amber-500/5 px-4 py-3.5 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
            <div className="min-w-0">
              <p className="text-sm font-semibold text-white">
                Is this you? Claim your profile →
              </p>
              <p className="text-[12px] text-neutral-400 mt-0.5">
                Link as sailor or parent to unlock logbook, privacy, and notes.
              </p>
            </div>
            <button
              type="button"
              onClick={handleClaim}
              className="shrink-0 inline-flex items-center gap-1.5 rounded-full bg-orange-500 px-4 py-2 text-[12px] font-bold text-white hover:bg-orange-400"
            >
              <UserPlus className="h-3.5 w-3.5" />
              {!demoMode && !isLoggedIn
                ? "Log in to claim"
                : "Claim this profile"}
            </button>
          </div>
        );
      })()}

      {/* Coach squad context strip (demo) */}
      {demoMode && demoRole === "coach" && (
        <div className="rounded-2xl border border-blue-500/25 bg-blue-500/[0.07] px-4 py-3 flex flex-wrap items-center gap-x-4 gap-y-1.5 text-[12px]">
          <span className="font-semibold text-blue-200">Squad context</span>
          <span className="text-neutral-300">
            Avg. finish:{" "}
            <span className="font-semibold text-white">3.6</span>
            <span className="text-neutral-500"> · Squad avg: 5.2</span>
          </span>
          <span className="text-neutral-300">
            <span className="font-semibold text-white">#3</span> of 100 nationally
            <span className="text-neutral-500"> · </span>
            <span className="font-semibold text-sky-300">#1 of 12</span> in squad
          </span>
        </div>
      )}

      {/* ── Header card ──────────────────────────────────────── */}
      <header className={`${cardClass} p-5 sm:p-6`}>
        <div className="flex items-start gap-3 sm:gap-4">
          <div className="relative shrink-0">
            <div className="h-14 w-14 sm:h-16 sm:w-16 rounded-full bg-gradient-to-br from-orange-500/90 via-amber-600/80 to-sky-700/70 border-2 border-white/15 text-white flex items-center justify-center overflow-hidden shadow-lg shadow-orange-950/40">
              {displaySailor.avatarUrl ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img
                  src={displaySailor.avatarUrl}
                  alt={displaySailor.name}
                  className="h-full w-full object-cover"
                />
              ) : (
                <span className="flex flex-col items-center justify-center leading-none">
                  <Anchor className="h-4 w-4 sm:h-5 sm:w-5 opacity-90 mb-0.5" aria-hidden />
                  <span className="text-[11px] sm:text-xs font-bold tracking-wide">
                    {initials(displaySailor.name)}
                  </span>
                </span>
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
                  {profileClaimed || profileVerified ? (
                    <span className="inline-flex items-center gap-1 rounded-full bg-emerald-500/15 border border-emerald-500/30 px-2 py-0.5 text-[10px] font-semibold text-emerald-300">
                      <BadgeCheck className="h-3 w-3" />
                      Verified
                    </span>
                  ) : (
                    <span className="inline-flex items-center gap-1 rounded-full bg-amber-500/10 border border-amber-500/25 px-2 py-0.5 text-[10px] font-semibold text-amber-200/90">
                      <ShieldAlert className="h-3 w-3" />
                      Unclaimed
                    </span>
                  )}
                </div>
                <p className="mt-0.5 text-[13px] text-neutral-400">
                  {[
                    hasOptimistResults || !hasIlcaResults ? "Optimist" : null,
                    hasIlcaResults ? "ILCA 4" : null,
                    displaySailor.club ? String(displaySailor.club) : null,
                  ]
                    .filter(Boolean)
                    .join(" · ")}
                </p>
              </div>
              <div className="shrink-0 text-right space-y-1.5">
                {/* Hide Optimist sail once aged out / left Optimist (ILCA-first) */}
                {!leftOptimistYear &&
                  sailDisplay &&
                  sailDisplay !== "—" &&
                  !/^SGP\s*0+$/i.test(sailDisplay) && (
                <div>
                  <p className="text-[8px] font-semibold uppercase tracking-[0.14em] text-neutral-500 mb-1">
                    Optimist sail
                  </p>
                  <div className="inline-flex items-center rounded-lg bg-orange-500 px-2.5 py-1.5 shadow-md shadow-orange-950/40">
                    <span className="text-sm sm:text-[15px] font-bold tabular-nums text-white tracking-tight">
                      {sailDisplay.includes(" ") ? sailDisplay : `${noc} ${sailDisplay}`}
                    </span>
                  </div>
                </div>
                )}
                {sailIlca4 && (
                  <div>
                    <p className="text-[8px] font-semibold uppercase tracking-[0.14em] text-neutral-500 mb-1">
                      ILCA 4 sail
                    </p>
                    <div className="inline-flex items-center rounded-lg bg-sky-600 px-2.5 py-1.5 shadow-md shadow-sky-950/40">
                      <span className="text-sm sm:text-[15px] font-bold tabular-nums text-white tracking-tight">
                        {sailIlca4.includes(" ")
                          ? sailIlca4
                          : `${noc} ${sailIlca4}`}
                      </span>
                    </div>
                  </div>
                )}
              </div>
            </div>

            {displaySailor.bio && (
              <p className="mt-2.5 text-[13px] sm:text-sm leading-relaxed text-neutral-300 max-w-xl">
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
                  {showFullDob && fullDobLabel ? (
                    <>
                      Born{" "}
                      <span className="text-neutral-300 font-medium">
                        {fullDobLabel}
                      </span>
                    </>
                  ) : (
                    <>
                      Birth year{" "}
                      <span className="text-neutral-300 font-medium">
                        {bornYear}
                      </span>
                    </>
                  )}
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
        <ClaimPanel
          sailorId={initialSailor.id}
          sailorName={displaySailor.name}
          sailNumber={displaySailor.sailNumber}
          onClose={() => setClaimPanelOpen(false)}
          onResult={(status, msg) => {
            setClaimStatus(status);
            setClaimMsg(msg);
          }}
        />
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
              <p className="mt-1 text-[10px] text-neutral-600 leading-snug">
                Birth year is always public. Full date shows only if you enable
                “Share full date of birth” under Privacy.
              </p>
            </label>
            <label className="block">
              <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
                Sailing club
              </span>
              <input
                value={form.club}
                onChange={(e) =>
                  setForm((f) => ({ ...f, club: e.target.value }))
                }
                className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
              />
            </label>
            <label className="block">
              <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
                Optimist sail #
              </span>
              <input
                value={form.sailNumber}
                onChange={(e) =>
                  setForm((f) => ({ ...f, sailNumber: e.target.value }))
                }
                className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white font-mono"
              />
            </label>
            <label className="block">
              <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
                ILCA 4 sail #
              </span>
              <input
                value={form.sailNumberIlca4}
                onChange={(e) =>
                  setForm((f) => ({ ...f, sailNumberIlca4: e.target.value }))
                }
                placeholder="Optional"
                className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white font-mono"
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
            <div className="sm:col-span-2 rounded-xl border border-white/[0.07] p-3 space-y-2">
              <p className="text-[10px] font-bold uppercase tracking-wide text-neutral-500">
                Privacy
              </p>
              <p className="text-[10px] text-neutral-600 leading-snug">
                Birth year is public when set. Full DOB and weight stay private
                unless shared. Equipment is always private (owner only).
              </p>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                {(
                  [
                    {
                      label: "Share weight",
                      checked: isPublicWeight,
                      set: setIsPublicWeight,
                    },
                    {
                      label: "Share full DOB",
                      checked: isPublicDob,
                      set: setIsPublicDob,
                    },
                  ] as const
                ).map((row) => (
                  <label
                    key={row.label}
                    className="flex items-center justify-between gap-2 rounded-lg border border-white/[0.06] px-2.5 py-2 cursor-pointer"
                  >
                    <span className="text-[11px] font-medium text-neutral-200">
                      {row.label}
                    </span>
                    <input
                      type="checkbox"
                      checked={row.checked}
                      onChange={(e) => row.set(e.target.checked)}
                      className="rounded border-neutral-600"
                    />
                  </label>
                ))}
              </div>
            </div>
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

      {/* ── Class tabs (dual-class) — above ranking so they control the whole profile ── */}
      {dualClass && (
        <div
          className={`${cardClass} p-2 sm:p-2.5`}
          role="tablist"
          aria-label="Boat class"
        >
          <div className="flex gap-1 rounded-xl bg-black/30 border border-white/[0.06] p-1">
            {(
              preferIlcaFirst
                ? (["ilca4", "optimist", "journey"] as const)
                : (["optimist", "ilca4", "journey"] as const)
            ).map((tab) => {
              const isIlca = tab === "ilca4";
              const isJourney = tab === "journey";
              const count = isJourney
                ? displayJourney.length
                : isIlca
                  ? ilca4Results.length
                  : optimistResults.length;
              const selected = resultsTab === tab;
              return (
                <button
                  key={tab}
                  type="button"
                  role="tab"
                  aria-selected={selected}
                  onClick={() => {
                    setResultsTab(tab);
                    setShowAllResults(false);
                  }}
                  className={`flex-1 rounded-lg px-2.5 sm:px-3 py-2.5 text-[12px] sm:text-[13px] font-semibold transition-colors min-h-[44px] ${
                    selected
                      ? isIlca
                        ? "bg-sky-600 text-white shadow-sm"
                        : isJourney
                          ? "bg-violet-600 text-white shadow-sm"
                          : "bg-orange-500 text-white shadow-sm"
                      : "text-neutral-400 hover:text-white"
                  }`}
                >
                  {isIlca ? "ILCA 4" : isJourney ? "Journey" : "Optimist"}
                  <span
                    className={`ml-1.5 tabular-nums text-[10px] sm:text-[11px] ${
                      selected ? "text-white/80" : "text-neutral-600"
                    }`}
                  >
                    ({count})
                  </span>
                </button>
              );
            })}
          </div>
          <p className="text-[11px] text-neutral-500 mt-2 px-1">
            {resultsTab === "ilca4"
              ? "ILCA 4 ranking, stats, and results"
              : resultsTab === "journey"
                ? "Career milestones and highlights"
                : "Optimist series ranking, stats, and results"}
          </p>
        </div>
      )}

      {/* ── Series / ILCA national standing ─────────────────── */}
      {activeStanding && resultsTab !== "journey" && (
        <section className={`${cardClass} p-4 sm:p-5`}>
          <div className="flex flex-wrap items-start justify-between gap-3">
            <div className="flex items-start gap-2.5 min-w-0">
              <div
                className={`mt-0.5 flex h-7 w-7 shrink-0 items-center justify-center rounded-full ${
                  standingIsIlca ? "bg-sky-500/15" : "bg-orange-500/15"
                }`}
              >
                <Trophy
                  className={`h-3.5 w-3.5 ${
                    standingIsIlca ? "text-sky-400" : "text-orange-400"
                  }`}
                />
              </div>
              <div>
                <p className="text-[13px] font-semibold text-white">
                  {standingIsIlca
                    ? "ILCA 4 national ranking"
                    : "Series standing"}
                </p>
                <p className="text-[11px] text-neutral-500">
                  {activeStanding.periodLabel}
                  <span className="text-neutral-600"> · </span>
                  <span
                    className={`font-medium ${
                      standingIsIlca
                        ? "text-sky-300/90"
                        : "text-yellow-400/90"
                    }`}
                  >
                    {standingIsIlca
                      ? activeStanding.fleet || "Open fleet"
                      : `${activeStanding.fleet} fleet`}
                  </span>
                </p>
              </div>
            </div>
            <div className="text-right">
              <p className="text-[9px] font-semibold uppercase tracking-[0.12em] text-neutral-500">
                {standingIsIlca ? "National rank" : "National rank"}
              </p>
              <p
                className={`text-3xl sm:text-4xl font-black tabular-nums leading-none ${
                  standingIsIlca ? "text-sky-300" : "text-orange-400"
                }`}
              >
                #{activeStanding.overallRank}
              </p>
              <p className="text-[12px] text-neutral-400 mt-1 tabular-nums">
                of {activeStanding.fleetSize}
                {standingIsIlca ? "" : ` · ${activeStanding.fleet}`}
              </p>
              <p className="text-[11px] text-neutral-500 mt-1.5 tabular-nums">
                {standingIsIlca ? "Best 3 of 5" : "Best 3 of 5"}{" "}
                <span className="font-semibold text-neutral-300">
                  {activeStanding.best3of5}
                  {standingIsIlca ? " pts" : ""}
                </span>
              </p>
            </div>
          </div>
          <div className="mt-4 hidden sm:grid grid-cols-5 gap-2">
            {Array.from({ length: 5 }).map((_, i) => {
              const r = activeStanding.rScores[i];
              const shortName = r?.regattaName
                ? r.regattaName
                    .replace(/National Ranking Series/i, "NRS")
                    .replace(/National Regatta/i, "NR")
                    .replace(/Championships?/i, "Champs")
                : null;
              const slotEmpty =
                !r || r.regattaName === "—" || r.regattaName === "";
              // Optimist: treat DNS-zero pad as empty; ILCA: show DNC + 0 pts
              const optimistEmpty =
                !standingIsIlca &&
                Boolean(
                  r &&
                    r.isDNS &&
                    r.score === 0 &&
                    !r.isOverseasCommitment
                );
              const empty = slotEmpty || optimistEmpty;
              const showIlcaScore = standingIsIlca && r && !slotEmpty;
              return (
                <div
                  key={i}
                  className="rounded-xl border border-white/[0.07] bg-black/30 px-2 py-3 text-center min-h-[5.5rem] flex flex-col"
                  title={r?.regattaName}
                >
                  <p
                    className={`text-[11px] font-bold tracking-wide ${
                      standingIsIlca ? "text-sky-400" : "text-orange-400"
                    }`}
                  >
                    R{i + 1}
                  </p>
                  <p className="text-[12px] sm:text-[13px] font-medium text-neutral-300 leading-snug mt-1.5 line-clamp-2 flex-1 px-0.5">
                    {empty && !showIlcaScore ? "—" : shortName || "—"}
                  </p>
                  {showIlcaScore ? (
                    <div className="mt-2 space-y-0.5">
                      <p className="text-lg font-bold text-white tabular-nums leading-none">
                        {r!.finishPlace != null && r!.finishPlace > 0
                          ? `#${r!.finishPlace}`
                          : "DNC"}
                      </p>
                      <p className="text-[11px] font-semibold text-sky-300/90 tabular-nums">
                        {r!.score} pts
                      </p>
                    </div>
                  ) : (
                    <p className="text-xl font-bold text-white tabular-nums mt-2">
                      {empty
                        ? "—"
                        : `${r!.score}${r!.isOverseasCommitment ? "†" : r!.isDNS ? "*" : ""}${r!.isCarryForward ? " CF" : ""}`}
                    </p>
                  )}
                </div>
              );
            })}
          </div>
          <ul className="mt-4 sm:hidden divide-y divide-white/[0.06] rounded-xl border border-white/[0.07] bg-black/25 overflow-hidden">
            {Array.from({ length: 5 }).map((_, i) => {
              const r = activeStanding.rScores[i];
              const empty =
                !r ||
                r.regattaName === "—" ||
                (r.isDNS && r.score === 0 && !r.isOverseasCommitment && r.finishPlace == null && !standingIsIlca);
              const ilcaMiss =
                standingIsIlca &&
                r &&
                (r.finishPlace == null || r.finishPlace <= 0) &&
                (r.isDNS || r.score === 0);
              return (
                <li
                  key={i}
                  className="flex items-center justify-between gap-3 px-3.5 py-3"
                >
                  <div className="min-w-0 flex items-center gap-2.5">
                    <span
                      className={`shrink-0 text-[11px] font-bold w-6 ${
                        standingIsIlca ? "text-sky-400" : "text-orange-400"
                      }`}
                    >
                      R{i + 1}
                    </span>
                    <span className="text-[13px] font-medium text-neutral-200 truncate">
                      {empty && !standingIsIlca
                        ? "—"
                        : r?.regattaName && r.regattaName !== "—"
                          ? r.regattaName
                          : "—"}
                    </span>
                  </div>
                  {standingIsIlca && r && r.regattaName !== "—" ? (
                    <span className="shrink-0 text-right">
                      <span className="block text-base font-bold text-white tabular-nums leading-none">
                        {r.finishPlace != null && r.finishPlace > 0
                          ? `#${r.finishPlace}`
                          : ilcaMiss || r.isDNS
                            ? "DNC"
                            : "—"}
                      </span>
                      <span className="block text-[11px] font-semibold text-sky-300/90 tabular-nums mt-0.5">
                        {r.score} pts
                      </span>
                    </span>
                  ) : (
                    <span className="shrink-0 text-lg font-bold text-white tabular-nums">
                      {empty
                        ? "—"
                        : `${r!.score}${r!.isOverseasCommitment ? "†" : r!.isDNS ? "*" : ""}${r!.isCarryForward ? " CF" : ""}`}
                    </span>
                  )}
                </li>
              );
            })}
          </ul>
          {activeStanding.trendNote && (
            <p
              className={`mt-3 text-[11px] font-medium ${
                standingIsIlca ? "text-sky-300/90" : "text-emerald-400/90"
              }`}
            >
              {activeStanding.trendNote}
            </p>
          )}
          <Link
            href={
              standingIsIlca
                ? "/sg/ilca4"
                : `/sg/optimist/${String(activeStanding.fleet).toLowerCase()}`
            }
            className={`inline-block mt-2 text-[12px] font-medium ${
              standingIsIlca
                ? "text-sky-400 hover:text-sky-300"
                : "text-orange-400 hover:text-orange-300"
            }`}
          >
            {standingIsIlca
              ? "View full ILCA 4 standings →"
              : `View full ${activeStanding.fleet} standings →`}
          </Link>
        </section>
      )}

      {/* ── Key stats ────────────────────────────────────────── */}
      {resultsTab !== "journey" && (
      <section className={`${cardClass} overflow-hidden`}>
        <div className="px-4 sm:px-5 pt-4 sm:pt-5 pb-1">
          <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
            {keyStatsTitle}
          </h2>
        </div>
        <div className="grid grid-cols-2 sm:grid-cols-4 divide-x divide-y sm:divide-y-0 divide-white/[0.06]">
          {statCells.map((s) => (
            <div
              key={s.label}
              className="px-2.5 sm:px-3 py-4 sm:py-5 text-center"
            >
              <p
                className={`text-[1.65rem] sm:text-3xl font-semibold tabular-nums tracking-tight leading-none ${s.color}`}
              >
                {s.value}
              </p>
              <p className="mt-1.5 text-[9px] sm:text-[10px] font-medium uppercase tracking-[0.1em] text-neutral-500 leading-tight">
                {s.label}
              </p>
            </div>
          ))}
        </div>
      </section>
      )}

      {/* ── Medal tally ──────────────────────────────────────── */}
      {showMedals && (
        <section className={`${cardClass} p-4 sm:p-5`}>
          <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500 mb-3">
            {medalTallyTitle}
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

      {/* ── Position trend ───────────────────────────────────── */}
      {resultsTab !== "journey" && (
      <section className={`${cardClass} p-4 sm:p-5`}>
        <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
          Position trend
        </h2>
        <p className="text-[12px] text-neutral-400 mt-0.5 mb-4">
          Finishing position by regatta (lower is better)
          {trendCaption}
        </p>
        <PositionTrendChart
          points={trendPoints}
          mode={trendMode}
          goldEntryDate={trendGoldEntry}
        />
      </section>
      )}

      {/* ── Regatta results ────────────────────────────────── */}
      <section className={`${cardClass} overflow-hidden`}>
        <div className="px-4 sm:px-5 pt-4 sm:pt-5 pb-2 flex flex-wrap items-end justify-between gap-2">
          <div className="min-w-0 flex-1">
            <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
              {resultsTab === "journey"
                ? "Sailing journey"
                : dualClass && resultsTab === "ilca4"
                  ? "Regatta results · ILCA 4"
                  : dualClass && resultsTab === "optimist"
                    ? "Regatta results · Optimist"
                    : "Regatta results"}
            </h2>
            {resultsTab !== "journey" && (
            <p className="text-[11px] text-neutral-600 mt-1.5">
              {(() => {
                const list =
                  dualClass && resultsTab === "ilca4"
                    ? ilca4Results
                    : dualClass
                      ? optimistResults
                      : resultsForPrimarySection;
                const n = list.length;
                return showAllResults
                  ? `All ${n} listed`
                  : `Showing ${Math.min(8, n)} of ${n}`;
              })()}
              {dualClass && resultsTab === "optimist" && analytics.mode === "established_gold"
                ? " · gold fleet"
                : ""}
              {dualClass && resultsTab === "ilca4" && ilca4Tenure
                ? ` · in ILCA 4 ${ilca4Tenure.label} (from first race)`
                : ""}
              {!dualClass &&
              analytics.mode === "established_gold" &&
              !primaryIsIlca
                ? " · gold fleet"
                : ""}
              {!dualClass && primaryIsIlca && ilca4Tenure
                ? ` · in ILCA 4 ${ilca4Tenure.label} (from first race)`
                : ""}
            </p>
            )}
          </div>
          {isOwner && resultsTab !== "journey" && (
            <p className="text-[11px] text-neutral-500 inline-flex items-center gap-1">
              <StickyNote className="h-3 w-3 text-orange-400" />
              Expand a row for race notes
            </p>
          )}
        </div>

        {isOwner &&
          !dismissSailorTip &&
          resultsTab !== "journey" &&
          (demoMode ? demoRole === "sailor" : true) && (
            <div className="mx-4 sm:mx-5 mb-3 flex items-start gap-2 rounded-xl border border-orange-500/25 bg-orange-500/[0.08] px-3 py-2.5">
              <p className="flex-1 text-[12px] text-neutral-300 leading-relaxed">
                <span className="font-semibold text-orange-300">Tip: </span>
                Expand any regatta to add race observations (place, wind, notes).
                Use the{" "}
                <span className="font-medium text-white">📝 Add note</span>{" "}
                control on each row.
              </p>
              <button
                type="button"
                onClick={() => setDismissSailorTip(true)}
                className="shrink-0 rounded-md p-1 text-neutral-500 hover:text-white"
                aria-label="Dismiss tip"
              >
                <X className="h-3.5 w-3.5" />
              </button>
            </div>
          )}

        {resultsTab === "journey" && dualClass ? (
          <div className="px-4 sm:px-5 pb-5 pt-1 space-y-3">
            <p className="text-[11px] text-neutral-500">
              Key moments — campaigns, firsts, and milestones.
              {displayJourney.some((j) => j.system)
                ? " Fleet milestones are filled in automatically."
                : ""}
            </p>
            {displayJourney.length === 0 ? (
              <p className="text-sm text-neutral-600">
                {isOwner
                  ? "No highlights yet. Add one below."
                  : "No journey highlights shared yet."}
              </p>
            ) : (
              <ol className="relative space-y-0 border-l border-white/10">
                {displayJourney.map((it) => (
                  <li key={it.id} className="relative pl-4 pb-4 last:pb-0">
                    <span
                      className={`absolute -left-[3px] top-1.5 h-1.5 w-1.5 rounded-full ${
                        it.system ? "bg-amber-400" : "bg-violet-400"
                      }`}
                    />
                    {it.when && (
                      <p className="text-[11px] font-semibold uppercase tracking-wide text-violet-300">
                        {it.when}
                      </p>
                    )}
                    <p className="text-sm font-semibold text-white mt-0.5">
                      {it.title}
                      {it.system ? (
                        <span className="ml-1.5 text-[9px] font-medium uppercase tracking-wide text-amber-500/80">
                          milestone
                        </span>
                      ) : null}
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
                        onClick={() => void removeJourneyItem(it.id, it.system)}
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
          </div>
        ) : null}

        {resultsTab !== "journey" && isOwner && !demoMode && (
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

        {resultsTab !== "journey" && visibleResults.length === 0 ? (
          <p className="px-5 pb-5 text-sm text-neutral-600">
            No regatta results yet.
          </p>
        ) : resultsTab !== "journey" ? (
          <>
            <div
              className={`hidden sm:grid gap-2 px-4 sm:px-5 py-2 border-t border-white/[0.05] text-[10px] font-medium uppercase tracking-wide text-neutral-600 ${
                primaryIsIlca
                  ? "grid-cols-[1.25rem_2.75rem_1fr_2.5rem_4.25rem]"
                  : "grid-cols-[1.25rem_2.75rem_1fr_4.5rem_4.25rem]"
              }`}
            >
              <span />
              <span>{primaryIsIlca ? "Points" : "Rank"}</span>
              <span>Event</span>
              <span className="text-right">
                {primaryIsIlca ? "Rank" : "Nett Score"}
              </span>
              <span className="text-right">
                {primaryIsIlca ? "Class" : "Fleet"}
              </span>
            </div>
            <div className="divide-y divide-white/[0.04]">
              {visibleResults.map((res, idx) => {
                const regattaId = String(res.regattaId || res.id || idx);
                const rank = res.rank != null ? Number(res.rank) : null;
                const dns = Boolean(res.isDns || res.isDNS);
                const boatGroup = profileBoatClassGroup(
                  (res as ProfileResult).boatClass
                );
                const isIlcaRow =
                  primaryIsIlca || boatGroup === "ilca4";
                const fleet = isIlcaRow
                  ? "ILCA 4"
                  : fleetLabelForResult(res, analytics.goldEntryDate);
                const slug = res.regattaSlug || res.id;
                const expanded = expandedRegattaId === regattaId;
                const raceNotes = obsForRegatta(regattaId);
                const fleetSize = res.totalFleetSize ?? res.fleetSize;
                const nonRanking = res.countsForRanking === false;
                const canLink =
                  !nonRanking &&
                  !isIlcaRow &&
                  slug &&
                  String(slug).length > 2;
                const nett =
                  res.nettScore != null &&
                  Number.isFinite(Number(res.nettScore))
                    ? Number(res.nettScore)
                    : null;
                const ilcaPts = isIlcaRow
                  ? ilcaHighPointsForResult(res as ProfileResult)
                  : null;
                const leftValue = isIlcaRow
                  ? dns
                    ? "0"
                    : ilcaPts != null
                      ? String(ilcaPts)
                      : "—"
                  : dns
                    ? "DNS"
                    : rank != null
                      ? String(rank)
                      : "—";
                const midValue = isIlcaRow
                  ? dns
                    ? "DNS"
                    : rank != null
                      ? String(rank)
                      : "—"
                  : nett != null
                    ? String(nett)
                    : "—";
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
                      className={`grid gap-2 items-start px-4 sm:px-5 py-3.5 cursor-pointer hover:bg-white/[0.02] grid-cols-[1.25rem_2.75rem_1fr_auto] ${
                        isIlcaRow
                          ? "sm:grid-cols-[1.25rem_2.75rem_1fr_2.5rem_4.25rem]"
                          : "sm:grid-cols-[1.25rem_2.75rem_1fr_4.5rem_4.25rem]"
                      }`}
                    >
                      <span className="pt-1 text-neutral-500" aria-hidden>
                        {expanded ? (
                          <ChevronDown className="h-3.5 w-3.5" />
                        ) : (
                          <ChevronRight className="h-3.5 w-3.5" />
                        )}
                      </span>
                      <span
                        className={`tabular-nums pt-0.5 flex flex-col items-start leading-tight ${
                          dns && !isIlcaRow
                            ? "text-rose-400"
                            : isIlcaRow
                              ? "text-sky-300"
                              : "text-neutral-200"
                        }`}
                        title={
                          isIlcaRow
                            ? "High Ranking Points (1st = fleet size)"
                            : fleetSize
                              ? `Place ${leftValue} of ${fleetSize} sailors`
                              : "Finishing place"
                        }
                      >
                        <span className="text-[15px] font-semibold">
                          {isIlcaRow ? leftValue : leftValue === "DNS" ? "DNS" : leftValue === "—" ? "—" : `#${leftValue}`}
                        </span>
                        {fleetSize != null &&
                          Number(fleetSize) > 0 &&
                          leftValue !== "—" && (
                            <span className="text-[10px] font-medium text-neutral-500 mt-0.5">
                              /{fleetSize}
                            </span>
                          )}
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
                        {/* Mobile: show rank / nett under event */}
                        <p className="sm:hidden text-[11px] text-neutral-400 mt-1 tabular-nums">
                          {isIlcaRow
                            ? `Rank #${midValue}${
                                fleetSize ? ` / ${fleetSize}` : ""
                              }`
                            : `Nett ${midValue}`}
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
                        {(() => {
                          const gear = gearByRegatta[regattaId] || [];
                          const compact = gear
                            .filter(
                              (g) =>
                                g.category === "hull" || g.category === "sail"
                            )
                            .slice(0, 3);
                          if (!compact.length) return null;
                          return (
                            <p
                              className="mt-1.5 text-[10px] text-slate-400 flex flex-wrap items-center gap-x-2 gap-y-0.5"
                              title="Equipment used at this regatta"
                            >
                              {compact.map((g, i) => {
                                const icon =
                                  g.category === "hull" ? "🛶" : "⛵";
                                const name =
                                  g.category === "sail"
                                    ? [
                                        g.brand || "Sail",
                                        g.label ? `#${g.label}` : null,
                                      ]
                                        .filter(Boolean)
                                        .join(" ")
                                    : [g.brand, g.label]
                                        .filter(Boolean)
                                        .join(" · ") || "Hull";
                                return (
                                  <span key={`${g.category}-${i}`}>
                                    {icon} {name}
                                  </span>
                                );
                              })}
                            </p>
                          );
                        })()}
                        {raceNotes.length > 0 && (
                          <span className="mt-1.5 inline-flex items-center gap-1 rounded-md border border-sky-500/30 bg-sky-500/10 px-2 py-0.5 text-[10px] font-semibold text-sky-200">
                            <StickyNote className="h-3 w-3" />
                            {raceNotes.length} note
                            {raceNotes.length === 1 ? "" : "s"}
                          </span>
                        )}
                        {isOwner && (
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation();
                              setExpandedRegattaId(regattaId);
                            }}
                            className={`mt-1.5 inline-flex items-center gap-1 rounded-md border px-2 py-0.5 text-[10px] font-semibold ${
                              raceNotes.length > 0
                                ? "border-white/10 bg-white/5 text-slate-300 hover:bg-white/10"
                                : "border-orange-500/25 bg-orange-500/10 text-orange-200 hover:bg-orange-500/20"
                            }`}
                          >
                            <StickyNote className="h-3 w-3" />
                            {raceNotes.length > 0 ? "View notes" : "Add note"}
                          </button>
                        )}
                      </div>
                      <span
                        className={`hidden sm:flex flex-col items-end text-right tabular-nums pt-0.5 leading-tight ${
                          isIlcaRow ? "text-neutral-200" : "text-neutral-400"
                        }`}
                      >
                        <span className="text-[13px]">
                          {isIlcaRow && midValue !== "—" && midValue !== "DNS"
                            ? `#${midValue}`
                            : midValue}
                        </span>
                        {isIlcaRow &&
                          fleetSize != null &&
                          Number(fleetSize) > 0 &&
                          midValue !== "—" && (
                            <span className="text-[10px] font-medium text-neutral-500 mt-0.5">
                              /{fleetSize}
                            </span>
                          )}
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
                  className={`text-[12px] font-semibold ${
                    primaryIsIlca
                      ? "text-sky-400 hover:text-sky-300"
                      : "text-orange-400 hover:text-orange-300"
                  }`}
                >
                  {showAllResults
                    ? "Show fewer"
                    : `View all ${activeResultsList.length} results`}
                </button>
              </div>
            )}
          </>
        ) : null}
      </section>

      {/* ── Journey + Equipment (journey lives in class tabs when dual-class) ── */}
      <div
        className={`grid grid-cols-1 gap-4 ${
          showEquipmentSection && !dualClass ? "lg:grid-cols-2" : ""
        }`}
      >
        {!dualClass && (
        <section className={`${cardClass} p-5`}>
          <div className="flex items-center gap-2 mb-1">
            <Anchor className="h-3.5 w-3.5 text-sky-400/90" />
            <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
              Sailing journey
            </h2>
          </div>
          <p className="text-[11px] text-neutral-500 mb-4">
            Key moments — campaigns, firsts, and milestones.
            {displayJourney.some((j) => j.system)
              ? " Fleet milestones are filled in automatically."
              : ""}
          </p>
          {displayJourney.length === 0 ? (
            <p className="text-sm text-neutral-600">
              {isOwner
                ? "No highlights yet. Add one below."
                : "No journey highlights shared yet."}
            </p>
          ) : (
            <ol className="relative ml-0.5 space-y-0 border-l border-white/10">
              {displayJourney.map((it) => (
                <li key={it.id} className="relative pl-4 pb-4 last:pb-0">
                  <span
                    className={`absolute -left-[3px] top-1.5 h-1.5 w-1.5 rounded-full ${
                      it.system ? "bg-amber-400" : "bg-neutral-500"
                    }`}
                  />
                  {it.when && (
                    <p className="text-[11px] font-semibold uppercase tracking-wide text-orange-400">
                      {it.when}
                    </p>
                  )}
                  <p className="text-sm font-semibold text-white mt-0.5">
                    {it.title}
                    {it.system ? (
                      <span className="ml-1.5 text-[9px] font-medium uppercase tracking-wide text-amber-500/80">
                        milestone
                      </span>
                    ) : null}
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
                      onClick={() => void removeJourneyItem(it.id, it.system)}
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
        )}

        {showEquipmentSection && resultsTab !== "journey" && (
        <EquipmentInventory
          sailorId={initialSailor.id}
          isOwner={isOwner}
          canSeeEquipment={showEquipment || isOwner}
          mayHaveIlca={Boolean(
            hasIlcaResults ||
              displaySailor.sailNumberIlca4 ||
              displaySailor.ilca4NationalList
          )}
          regattaOptions={(results || [])
            .filter((r) => r.regattaId)
            .map((r) => ({
              id: String(r.regattaId),
              name: String(r.regattaName || "Regatta"),
              date: String(r.regattaDate || "").slice(0, 10),
            }))
            .filter(
              (r, i, arr) => arr.findIndex((x) => x.id === r.id) === i
            )
            .slice(0, 40)}
          cardClass={cardClass}
          onGearByRegatta={setGearByRegatta}
        />
        )}
      </div>

      {/* Privacy controls live under Edit profile only (not on Optimist/ILCA/Journey tabs). */}
    </div>
  );
}
