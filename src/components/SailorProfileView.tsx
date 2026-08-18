"use client";

import {
  useEffect,
  useMemo,
  useRef,
  useState,
  type ReactNode,
} from "react";

import Link from "next/link";
import { normalizeNationality } from "@/lib/seriesMembership";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import {
  Link2,
  UserPlus,
  Pencil,
  BookOpen,
  Camera,
  Eye,
  EyeOff,
  Anchor,
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
  mergeStandingScoresIntoTrend,
  optimistLeftYear,
  prefersIlcaFirstProfile,
  profileBoatClassGroup,
  tenureFromFirstDate,
  ilcaHighPointsForResult,
  type ProfileResult,
} from "@/lib/profileAnalytics";
import dynamic from "next/dynamic";
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
import type { ProfileOwnerForm } from "@/components/sailor-profile/ProfileOwnerEditor";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { errorMessage } from "@/lib/errors";

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

const EquipmentInventory = dynamic(
  () =>
    import("@/components/EquipmentInventory").then((m) => m.EquipmentInventory),
  {
    ssr: false,
    loading: () => (
      <div className="h-40 w-full animate-pulse rounded-2xl bg-white/5 border border-white/5" />
    ),
  }
);

const ClaimPanel = dynamic(
  () =>
    import("@/components/sailor-profile/ClaimPanel").then((m) => m.ClaimPanel),
  { ssr: false }
);

const ProfileOwnerEditor = dynamic(
  () =>
    import("@/components/sailor-profile/ProfileOwnerEditor").then(
      (m) => m.ProfileOwnerEditor
    ),
  { ssr: false }
);

const ProfileJourneyPanel = dynamic(
  () =>
    import("@/components/sailor-profile/ProfileJourneyPanel").then(
      (m) => m.ProfileJourneyPanel
    )
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
  /** Owner-only: preview the profile as the public sees it (masks private surfaces). */
  const [previewPublic, setPreviewPublic] = useState(false);
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
  const [form, setForm] = useState<ProfileOwnerForm>({
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
  /** Established Gold: default Gold-only results; allow All Optimist */
  const [optimistScope, setOptimistScope] = useState<"gold" | "all">("gold");
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
          (c: { sailorId?: string; status?: string }) =>
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

  /** When owner enables Preview public, hide private/owner-only surfaces. */
  const ownerView = isOwner && !previewPublic;
  const hasPrivateAccess = canSeePrivate && !previewPublic;
  const showWeight =
    isPublicWeight || hasPrivateAccess || (isOwner && !previewPublic);
  // Equipment is always private — owner / private access only (never public)
  const showEquipment = hasPrivateAccess || ownerView;

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
      setDisplaySailor((s: SailorRecordProps) => ({
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
    } catch (e: unknown) {
      setSaveMsg(errorMessage(e, "Save failed"));
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
      setDisplaySailor((s: SailorRecordProps) => ({
        ...s,
        avatarUrl: data.sailor.avatarUrl || publicUrl,
      }));
      setAvatarMsg("Photo updated");
      setTimeout(() => setAvatarMsg(null), 2500);
    } catch (e: unknown) {
      setAvatarMsg(
        errorMessage(
          e,
          "Upload failed — ensure avatars bucket exists (see docs)"
        )
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

  const startEditObservation = (o: ObservationItem, regattaId: string) => {
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
      const row = data.observation as ObservationItem;
      setObservations((prev: ObservationItem[]) => {
        const rest = prev.filter(
          (o) =>
            !(
              o.regattaId === row.regattaId &&
              o.raceNumber === row.raceNumber
            )
        );
        const existingName = prev.find((p) => p.regattaId === row.regattaId)
          ?.regattaName;
        const resultName = initialResults.find(
          (r: RegattaResultItem) => r.regattaId === regattaId
        )?.regattaName;
        return [
          ...rest,
          {
            ...row,
            regattaName:
              (typeof existingName === "string" ? existingName : undefined) ||
              resultName,
          },
        ].sort((a, b) => {
          const bd = String(b.regattaDate == null ? "" : b.regattaDate);
          const ad = String(a.regattaDate == null ? "" : a.regattaDate);
          return (
            bd.localeCompare(ad) ||
            Number(a.raceNumber ?? 0) - Number(b.raceNumber ?? 0)
          );
        });
      });
      setObsMsg(editingObsId ? "Observation updated" : "Observation saved");
      resetObsForm();
    } catch (e: unknown) {
      setObsMsg(errorMessage(e, "Failed"));
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
        setResults((prev: RegattaResultItem[]) =>
          [data.entry as RegattaResultItem, ...prev].sort((a, b) => {
            const bd = String(b.regattaDate == null ? "" : b.regattaDate);
            const ad = String(a.regattaDate == null ? "" : a.regattaDate);
            return bd.localeCompare(ad);
          })
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
    } catch (e: unknown) {
      setPersonalMsg(errorMessage(e, "Failed"));
    } finally {
      setPersonalBusy(false);
    }
  };

  const deletePersonalResult = async (res: {
    resultId?: string | null;
    id?: string;
    regattaName?: string | null;
  }) => {
    const resultId = res.resultId ?? res.id;
    if (demoMode || resultId == null || resultId === "") return;
    const ok = await confirm({
      title: `Remove “${res.regattaName ?? "event"}” from your logbook?`,
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
        body: JSON.stringify({ resultId }),
      });
      const data = await r.json();
      if (!r.ok) throw new Error(data.error || "Delete failed");
      setResults((prev: RegattaResultItem[]) =>
        prev.filter((x) => x.resultId !== resultId && x.id !== resultId)
      );
      setPersonalMsg("Removed");
    } catch (e: unknown) {
      const msg = errorMessage(e, "Delete failed");
      toast.error(msg);
      setPersonalMsg(msg);
    } finally {
      setPersonalBusy(false);
    }
  };

  const deleteObservation = async (o: ObservationItem) => {
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
      setObservations((prev: ObservationItem[]) =>
        prev.filter((x) => x.id !== o.id)
      );
      if (editingObsId === o.id) resetObsForm();
      setObsMsg("Observation deleted");
    } catch (e: unknown) {
      const msg = errorMessage(e, "Delete failed");
      toast.error(msg);
      setObsMsg(msg);
    } finally {
      setObsBusy(false);
    }
  };

  const obsForRegatta = (regattaId: string) =>
    observations
      .filter((o: ObservationItem) => {
        if (o.regattaId !== regattaId) return false;
        // Public / preview-public: only non-private notes
        if (!ownerView && !hasPrivateAccess && o.isPrivate !== false) {
          return false;
        }
        return true;
      })
      .sort(
        (a: ObservationItem, b: ObservationItem) =>
          Number(a.raceNumber ?? 0) - Number(b.raceNumber ?? 0)
      );


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
    Boolean(bornYear) && (isPublicDob || hasPrivateAccess || ownerView);
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

  /** Gold-filtered when established_gold; otherwise all Optimist results */
  const optimistResultsGold = analytics.listResults;
  const optimistResultsAll = classBuckets.optimist;
  const optimistResults =
    analytics.mode === "established_gold" && optimistScope === "all"
      ? optimistResultsAll
      : optimistResultsGold;
  const ilca4Results = classBuckets.ilca4;
  const hasIlcaResults = ilca4Results.length > 0;
  const hasOptimistResults =
    optimistResultsAll.length > 0 || optimistResultsGold.length > 0;
  const dualClass = hasIlcaResults && optimistResultsAll.length > 0;
  const showOptimistScopeFilter =
    analytics.mode === "established_gold" &&
    resultsTab !== "ilca4" &&
    resultsTab !== "journey" &&
    !(hasIlcaResults && optimistResultsAll.length === 0);
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

  /**
   * Optimist results plus series-window DNS (missed ranking events).
   * Keeps the Results list aligned with the Best 3/5 strip / trend.
   */
  const optimistResultsWithSeriesDns = useMemo(() => {
    const standing = initialSeriesStanding;
    if (!standing?.rScores?.length) return optimistResults as ProfileResult[];
    const existingIds = new Set(
      (optimistResults as ProfileResult[]).map((r) => String(r.regattaId || ""))
    );
    const existingNames = new Set(
      (optimistResults as ProfileResult[]).map((r) =>
        String(r.regattaName || "")
          .trim()
          .toLowerCase()
      )
    );
    const fleetDiv = String(standing.fleet || "Silver");
    const extras: ProfileResult[] = [];
    for (const rs of standing.rScores) {
      if (!rs.isDNS || !(rs.score > 0)) continue;
      const name = String(rs.regattaName || "").trim();
      if (!name || name === "—") continue;
      if (existingIds.has(String(rs.regattaId || ""))) continue;
      if (existingNames.has(name.toLowerCase())) continue;
      extras.push({
        id: `series-dns-${rs.regattaId}`,
        regattaId: rs.regattaId,
        regattaName: name,
        regattaDate: rs.regattaDate || null,
        rank: rs.score,
        isDns: true,
        isDNS: true,
        division: fleetDiv,
        countsForRanking: true,
        totalFleetSize: rs.score > 1 ? rs.score - 1 : null,
        fleetSize: rs.score > 1 ? rs.score - 1 : null,
      });
    }
    if (!extras.length) return optimistResults as ProfileResult[];
    return [...(optimistResults as ProfileResult[]), ...extras].sort((a, b) =>
      String(b.regattaDate || "").localeCompare(String(a.regattaDate || ""))
    );
  }, [optimistResults, initialSeriesStanding]);

  /** Active class list for the results panel (tabs when dual-class) */
  const activeResultsList =
    dualClass && resultsTab === "ilca4"
      ? ilca4Results
      : dualClass && resultsTab === "journey"
        ? []
        : dualClass
          ? optimistResultsWithSeriesDns
          : hasIlcaResults && classBuckets.optimist.length === 0
            ? ilca4Results
            : optimistResultsWithSeriesDns;
  const visibleResults = showAllResults
    ? activeResultsList
    : activeResultsList.slice(0, 8);
  const hasMoreResults = activeResultsList.length > 8;
  const seriesDnsCount =
    initialSeriesStanding?.rScores?.filter(
      (rs) => rs.isDNS && rs.score > 0 && rs.regattaName && rs.regattaName !== "—"
    ).length ?? 0;
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

  // Tenure cell: short duration value + compact “since” hint (avoids wrapping soup)
  const goldTenureLabel = analytics.timeInGoldLabel || "—";
  const goldTenureHint =
    analytics.goldEntryYear != null
      ? analytics.isDroppedFromGold
        ? `Since ${analytics.goldEntryYear} · ended`
        : `Since ${analytics.goldEntryYear}`
      : analytics.isDroppedFromGold
        ? "Ended"
        : null;

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

  /** Pure silver (no gold entry): never show Best gold / Gold tenure. */
  const isSilverOnlyProfile =
    !useIlcaStats && !analytics.goldEntryDate && !analytics.isGoldFleet;

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
            label: "Gold tenure",
            hint: goldTenureHint,
            color: "text-white",
          },
        ]
      : isSilverOnlyProfile
        ? [
            {
              value: String(analytics.regattaCount),
              label: "Regattas",
              color: "text-white",
            },
            {
              value: analytics.bestSilverLabel,
              label: "Best finish",
              color: "text-emerald-400",
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
              label: "Gold tenure",
              hint: goldTenureHint,
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

  /** Equipment stays family/owner-private (never on public / preview-public). */
  const showEquipmentSection = ownerView || hasPrivateAccess;

  // ILCA position trend (Open fleet) — shown for ILCA-only or dual-class ILCA tab
  const ilcaTrendPoints = useMemo(
    () => buildIlcaPositionTrend(ilca4Results as ProfileResult[]),
    [ilca4Results]
  );
  const showIlcaTrend =
    primaryIsIlca || (dualClass && resultsTab === "ilca4");
  /** Merge series-standing DNS (missed ranking events) into Optimist trend. */
  const optimistTrendPoints = useMemo(() => {
    const standing = initialSeriesStanding;
    if (!standing?.rScores?.length) return analytics.trend;
    const fleet =
      String(standing.fleet || "").toLowerCase() === "gold"
        ? ("Gold" as const)
        : ("Silver" as const);
    return mergeStandingScoresIntoTrend(
      analytics.trend,
      standing.rScores,
      fleet
    );
  }, [analytics.trend, initialSeriesStanding]);
  const trendPoints = showIlcaTrend ? ilcaTrendPoints : optimistTrendPoints;
  const trendMode = showIlcaTrend ? ("other" as const) : analytics.mode;
  const trendGoldEntry = showIlcaTrend ? null : analytics.goldEntryDate;
  const trendCaption = showIlcaTrend
    ? " · last 10 ILCA 4 regattas"
    : analytics.mode === "established_gold"
      ? " · last 10 gold events"
      : " · last 10 regattas (incl. DNS)";

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
              Claim this profile
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
            {ownerView && !demoMode && (
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
              {activeStanding &&
                resultsTab !== "journey" &&
                activeStanding.overallRank != null && (
                  <p
                    className={`mt-1.5 text-[12px] sm:text-[13px] font-semibold tabular-nums leading-snug ${
                      standingIsIlca ? "text-sky-300/95" : "text-orange-300/95"
                    }`}
                  >
                    #{activeStanding.overallRank}
                    {activeStanding.fleet
                      ? ` ${activeStanding.fleet}`
                      : standingIsIlca
                        ? " ILCA"
                        : ""}
                    {" · "}
                    Best 3/5: {activeStanding.best3of5}
                    {standingIsIlca ? " pts" : ""}
                    {activeStanding.periodLabel
                      ? ` · ${activeStanding.periodLabel}`
                      : ""}
                  </p>
                )}
              {/* Compact identity passport: sail · club · nationality · born */}
              <p className="mt-1.5 flex flex-wrap items-center gap-x-1.5 gap-y-0.5 text-[12px] sm:text-[13px] text-neutral-400">
                {(() => {
                  const parts: ReactNode[] = [];
                  const push = (node: ReactNode, key: string) => {
                    if (parts.length > 0) {
                      parts.push(
                        <span
                          key={`sep-${key}`}
                          className="text-neutral-600"
                          aria-hidden
                        >
                          ·
                        </span>
                      );
                    }
                    parts.push(<span key={key}>{node}</span>);
                  };
                  if (
                    !leftOptimistYear &&
                    sailDisplay &&
                    sailDisplay !== "—" &&
                    !/^SGP\s*0+$/i.test(sailDisplay)
                  ) {
                    push(
                      <span className="tabular-nums font-medium text-neutral-300">
                        {sailDisplay.includes(" ")
                          ? sailDisplay
                          : `${noc} ${sailDisplay}`}
                      </span>,
                      "opt-sail"
                    );
                  }
                  if (sailIlca4) {
                    push(
                      <span className="tabular-nums font-medium text-sky-300/90">
                        ILCA{" "}
                        {sailIlca4.includes(" ")
                          ? sailIlca4
                          : `${noc} ${sailIlca4}`}
                      </span>,
                      "ilca-sail"
                    );
                  }
                  if (displaySailor.club) {
                    push(String(displaySailor.club), "club");
                  }
                  push(
                    <span className="inline-flex items-center gap-1">
                      <span aria-hidden>
                        {nationalityFlag(displaySailor.nationality)}
                      </span>
                      {nationalityLabel(displaySailor.nationality)}
                    </span>,
                    "nat"
                  );
                  if (bornYear) {
                    push(
                      showFullDob && fullDobLabel ? (
                        <>
                          Born{" "}
                          <span className="text-neutral-300 font-medium">
                            {fullDobLabel}
                          </span>
                        </>
                      ) : (
                        <>
                          Born{" "}
                          <span className="text-neutral-300 font-medium">
                            {bornYear}
                          </span>
                        </>
                      ),
                      "born"
                    );
                  }
                  if (showWeight && displaySailor.weight != null) {
                    push(
                      <>
                        <span className="text-neutral-300 font-medium">
                          {displaySailor.weight} kg
                        </span>
                      </>,
                      "weight"
                    );
                  }
                  const dropYmd = displaySailor.dropDate
                    ? String(displaySailor.dropDate).slice(0, 10)
                    : "";
                  if (/^\d{4}-\d{2}-\d{2}$/.test(dropYmd)) {
                    const dropLabel = (() => {
                      try {
                        return new Date(`${dropYmd}T12:00:00+08:00`).toLocaleDateString(
                          "en-SG",
                          {
                            month: "short",
                            year: "numeric",
                            timeZone: "Asia/Singapore",
                          }
                        );
                      } catch {
                        return dropYmd.slice(0, 7);
                      }
                    })();
                    push(
                      <span className="text-amber-200/90 font-medium">
                        Left series {dropLabel}
                      </span>,
                      "drop"
                    );
                  }
                  return parts;
                })()}
              </p>
            </div>

            {displaySailor.bio && (
              <p className="mt-2.5 text-[13px] sm:text-sm leading-relaxed text-neutral-300 max-w-xl">
                {displaySailor.bio}
              </p>
            )}

            {isOwner && previewPublic && (
              <div className="mt-2.5 inline-flex items-center gap-1.5 rounded-lg border border-sky-500/30 bg-sky-500/10 px-2.5 py-1 text-[11px] font-medium text-sky-200">
                <Eye className="h-3 w-3" />
                Previewing public profile
              </div>
            )}

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
                  Claim this profile
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
                    ? "Claim this profile (demo)"
                    : claimPanelOpen
                      ? "Cancel"
                      : "Claim this profile"}
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
                  onClick={() => {
                    setPreviewPublic((p) => {
                      const next = !p;
                      if (next) {
                        setEditing(false);
                        setExpandedRegattaId(null);
                      }
                      return next;
                    });
                  }}
                  className={`inline-flex items-center gap-1.5 rounded-lg border px-2.5 py-1 text-[11px] font-medium ${
                    previewPublic
                      ? "border-sky-500/40 bg-sky-500/15 text-sky-200"
                      : "border-white/10 bg-white/[0.03] text-neutral-300 hover:text-white"
                  }`}
                >
                  {previewPublic ? (
                    <EyeOff className="h-3 w-3" />
                  ) : (
                    <Eye className="h-3 w-3" />
                  )}
                  {previewPublic ? "Exit preview" : "Preview public"}
                </button>
              )}
              {isOwner && !previewPublic && (
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
      {ownerView && editing && (
        <ProfileOwnerEditor
          form={form}
          setForm={setForm}
          isPublicWeight={isPublicWeight}
          setIsPublicWeight={setIsPublicWeight}
          isPublicDob={isPublicDob}
          setIsPublicDob={setIsPublicDob}
          saveBusy={saveBusy}
          saveMsg={saveMsg}
          onSave={() => void saveProfile()}
        />
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
                      selected ? "text-white/80" : "text-neutral-400"
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

      {/* Sticky jump links — long dual-class profiles */}
      <nav
        aria-label="Profile sections"
        className="sticky top-14 sm:top-16 z-20 -mx-1 px-1 py-1.5 flex gap-1.5 overflow-x-auto scrollbar-thin bg-[#090a0f]/95 backdrop-blur-md border-b border-white/5"
      >
        {resultsTab !== "journey" && activeStanding && (
          <a
            href="#profile-standing"
            className="shrink-0 rounded-full border border-white/10 bg-white/[0.03] px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white hover:border-orange-500/40 touch-manipulation"
          >
            Standing
          </a>
        )}
        <a
          href="#profile-results"
          className="shrink-0 rounded-full border border-white/10 bg-white/[0.03] px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white hover:border-orange-500/40 touch-manipulation"
        >
          {resultsTab === "journey" ? "Journey" : "Results"}
        </a>
        {showEquipmentSection && (
          <a
            href="#profile-equipment"
            className="shrink-0 rounded-full border border-white/10 bg-white/[0.03] px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white hover:border-orange-500/40 touch-manipulation"
          >
            Equipment
          </a>
        )}
      </nav>

      {/* ── Series / ILCA national standing ─────────────────── */}
      {activeStanding && resultsTab !== "journey" && (
        <section
          id="profile-standing"
          className={`${cardClass} p-4 sm:p-5 scroll-mt-28`}
        >
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
              <p className="text-[11px] text-neutral-400 mt-1.5 tabular-nums">
                Best 3 of 5{" "}
                <span className="font-semibold text-neutral-200">
                  {activeStanding.best3of5}
                  {standingIsIlca ? " pts" : ""}
                </span>
              </p>
              {!standingIsIlca && (
                <p className="text-[10px] text-neutral-500 mt-0.5">
                  Sum of best three places (lower is better)
                </p>
              )}
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
          {!standingIsIlca && (
            <p className="mt-3 text-[10px] sm:text-[11px] text-slate-400 leading-relaxed">
              <span className="font-semibold text-slate-300">Key: </span>
              <span className="tabular-nums">CF</span> = carry-forward ·{" "}
              <span className="tabular-nums">*</span> = DNS (did not start;
              series score = fleet size + 1) ·{" "}
              <span className="tabular-nums">†</span> = overseas commitment
            </p>
          )}
          {!standingIsIlca && seriesDnsCount > 0 && (
            <p className="mt-1.5 text-[11px] text-neutral-500 leading-relaxed">
              {seriesDnsCount} missed ranking{" "}
              {seriesDnsCount === 1 ? "event" : "events"} in this window
              (DNS) — listed under Results below and on the position trend.
            </p>
          )}
          {activeStanding.trendNote && (
            <p
              className={`mt-2 text-[11px] font-medium ${
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
              {"hint" in s && s.hint ? (
                <p className="mt-0.5 text-[9px] sm:text-[10px] font-medium text-neutral-600 leading-tight normal-case tracking-normal">
                  {s.hint}
                </p>
              ) : null}
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

      {/* ── Position trend (hide until ≥2 ranked finishes) ─── */}
      {resultsTab !== "journey" && trendPoints.length >= 2 && (
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
      <div id="profile-results" className="scroll-mt-28 space-y-4">
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
            <p className="text-[11px] text-neutral-400 mt-1.5">
              {(() => {
                const list = activeResultsList;
                const n = list.length;
                return showAllResults
                  ? `All ${n} listed`
                  : `Showing ${Math.min(8, n)} of ${n}`;
              })()}
              {showOptimistScopeFilter && optimistScope === "gold"
                ? " · gold fleet"
                : ""}
              {dualClass && resultsTab === "ilca4" && ilca4Tenure
                ? ` · in ILCA 4 ${ilca4Tenure.label} (from first race)`
                : ""}
              {!dualClass && primaryIsIlca && ilca4Tenure
                ? ` · in ILCA 4 ${ilca4Tenure.label} (from first race)`
                : ""}
            </p>
            )}
            {showOptimistScopeFilter && (
              <div
                className="mt-2 inline-flex rounded-full border border-white/10 bg-black/30 p-0.5 gap-0.5"
                role="group"
                aria-label="Optimist results filter"
              >
                <button
                  type="button"
                  onClick={() => {
                    setOptimistScope("gold");
                    setShowAllResults(false);
                  }}
                  className={`rounded-full px-3 py-1.5 text-[10px] font-bold touch-manipulation min-h-[2rem] ${
                    optimistScope === "gold"
                      ? "bg-orange-600 text-white"
                      : "text-slate-400 hover:text-white"
                  }`}
                >
                  Gold only
                </button>
                <button
                  type="button"
                  onClick={() => {
                    setOptimistScope("all");
                    setShowAllResults(false);
                  }}
                  className={`rounded-full px-3 py-1.5 text-[10px] font-bold touch-manipulation min-h-[2rem] ${
                    optimistScope === "all"
                      ? "bg-orange-600 text-white"
                      : "text-slate-400 hover:text-white"
                  }`}
                >
                  All Optimist
                </button>
              </div>
            )}
          </div>
          {ownerView && resultsTab !== "journey" && (
            <p className="text-[11px] text-neutral-500 inline-flex items-center gap-1">
              <StickyNote className="h-3 w-3 text-orange-400" />
              Expand a row for race notes
            </p>
          )}
        </div>

        {ownerView &&
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
          <ProfileJourneyPanel
            variant="tab"
            items={displayJourney}
            isOwner={ownerView}
            draft={journeyDraft}
            setDraft={setJourneyDraft}
            busy={journeyBusy}
            message={journeyMsg}
            onAdd={() => void addJourneyItem()}
            onRemove={(id, isSystem) => void removeJourneyItem(id, isSystem)}
          />
        ) : null}

        {resultsTab !== "journey" && ownerView && !demoMode && (
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
                /** Public: expand only when there are visible notes; owners always can. */
                const canExpand = raceNotes.length > 0 || ownerView;
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
                const showFleetSizeUnderPlace =
                  fleetSize != null &&
                  Number(fleetSize) > 0 &&
                  leftValue !== "—";

                return (
                  <div key={regattaId + String(idx)}>
                    <div
                      role={canExpand ? "button" : undefined}
                      tabIndex={canExpand ? 0 : undefined}
                      onClick={
                        canExpand
                          ? () =>
                              setExpandedRegattaId(
                                expanded ? null : regattaId
                              )
                          : undefined
                      }
                      onKeyDown={
                        canExpand
                          ? (e) => {
                              if (e.key === "Enter" || e.key === " ") {
                                e.preventDefault();
                                setExpandedRegattaId(
                                  expanded ? null : regattaId
                                );
                              }
                            }
                          : undefined
                      }
                      className={`grid gap-2 items-start px-4 sm:px-5 py-3.5 grid-cols-[1.25rem_2.75rem_1fr_auto] ${
                        canExpand
                          ? "cursor-pointer hover:bg-white/[0.02]"
                          : "cursor-default"
                      } ${
                        isIlcaRow
                          ? "sm:grid-cols-[1.25rem_2.75rem_1fr_2.5rem_4.25rem]"
                          : "sm:grid-cols-[1.25rem_2.75rem_1fr_4.5rem_4.25rem]"
                      }`}
                    >
                      <span
                        className={`pt-1 ${
                          canExpand ? "text-neutral-500" : "text-transparent"
                        }`}
                        aria-hidden
                      >
                        {canExpand ? (
                          expanded ? (
                            <ChevronDown className="h-3.5 w-3.5" />
                          ) : (
                            <ChevronRight className="h-3.5 w-3.5" />
                          )
                        ) : (
                          <span className="inline-block h-3.5 w-3.5" />
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
                        {showFleetSizeUnderPlace && (
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
                            // Avoid repeating fleet size already under place (#n / N)
                            !showFleetSizeUnderPlace && fleetSize
                              ? `${fleetSize} boats`
                              : null,
                          ]
                            .filter(Boolean)
                            .join(" · ")}
                        </p>
                        {/* Mobile: complementary score only (Optimist rank is already left col) */}
                        {(() => {
                          const mobileSecondary = isIlcaRow
                            ? midValue !== "—" && midValue !== "DNS"
                              ? `Rank #${midValue}`
                              : midValue === "DNS"
                                ? "DNS"
                                : null
                            : `Nett ${midValue}`;
                          return mobileSecondary ? (
                            <p className="sm:hidden text-[11px] text-neutral-400 mt-1 tabular-nums">
                              {mobileSecondary}
                            </p>
                          ) : null;
                        })()}
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
                          if (!showEquipment) return null;
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
                        {ownerView && (
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

                    {ownerView && !demoMode && nonRanking && res.resultId && (
                        <button
                          type="button"
                          disabled={personalBusy}
                          onClick={() => void deletePersonalResult(res)}
                          className="ml-14 mb-2 text-[10px] font-medium text-rose-400/90"
                        >
                          Remove
                        </button>
                      )}

                    {expanded && canExpand && (
                      <div className="px-4 sm:px-5 pb-4 space-y-3 border-t border-white/[0.04] bg-black/15">
                        <div className="flex items-center gap-2 pt-3 text-[11px] font-medium text-neutral-500 uppercase tracking-wide">
                          <BookOpen className="h-3.5 w-3.5 text-orange-400" />
                          Race observations
                        </div>
                        {raceNotes.length === 0 ? (
                          <p className="text-xs text-neutral-600">
                            {ownerView
                              ? "No notes yet — add wind, place, and takeaways below."
                              : "No public race notes for this event."}
                          </p>
                        ) : (
                          <ul className="space-y-2">
                            {raceNotes.map((o) => (
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
                                {ownerView && (
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
                        {ownerView && (
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
      </div>

      {/* ── Journey + Equipment (equipment stays visible on Journey tab) ── */}
      <div
        className={`grid grid-cols-1 gap-4 ${
          showEquipmentSection && !dualClass ? "lg:grid-cols-2" : ""
        }`}
      >
        {!dualClass && (
          <ProfileJourneyPanel
            variant="card"
            items={displayJourney}
            isOwner={ownerView}
            draft={journeyDraft}
            setDraft={setJourneyDraft}
            busy={journeyBusy}
            message={journeyMsg}
            onAdd={() => void addJourneyItem()}
            onRemove={(id, isSystem) => void removeJourneyItem(id, isSystem)}
          />
        )}

        {showEquipmentSection && (
        <EquipmentInventory
          sailorId={initialSailor.id}
          isOwner={ownerView}
          canSeeEquipment={showEquipment}
          mayHaveIlca={Boolean(
            hasIlcaResults ||
              displaySailor.sailNumberIlca4 ||
              displaySailor.ilca4NationalList
          )}
          preferredBoatClass={
            resultsTab === "ilca4"
              ? "ilca4"
              : resultsTab === "optimist"
                ? "optimist"
                : null
          }
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
