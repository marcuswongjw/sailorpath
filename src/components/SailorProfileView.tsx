"use client";

import {
  useEffect,
  useMemo,
  useState,
} from "react";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { normalizeNationality } from "@/lib/seriesMembership";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import {
  UserPlus,
  BookOpen,
  Anchor,
  Trophy,
  ChevronDown,
  ChevronRight,
  StickyNote,
  X,
  FileText,
  ImageIcon,
  CheckCircle2,
  ExternalLink,
  Plus,
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
import { regattaCountsForRanking } from "@/lib/ranking";
import dynamic from "next/dynamic";
import {
  PROFILE_CARD_CLASS as cardClass,
  resolveDisplayFleet,
  fleetPillClass,
  formatFullDob,
  type SailorRecordProps,
  type RegattaResultItem,
  type ObservationItem,
  type SailorProfileViewProps,
  HeroAthleteCard,
  ProfileClassNavigation,
  ProfileAwardsCabinet,
  type ProfileSectionTab,
} from "@/components/sailor-profile";
import { getSailorPrizes, getSailorMedalCounts } from "@/lib/sailorPrizes";
import type { ProfileOwnerForm } from "@/components/sailor-profile/ProfileOwnerEditor";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { errorMessage } from "@/lib/errors";
import { ProfilePerformanceSummary } from "@/components/sailor-profile/ProfilePerformanceSummary";

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
  canSeePrivate = false,
  canClaim = false,
  isOwner = false,
  isLoggedIn = false,
  profileClaimed = false,
  demoMode = false,
  demoRole,
  onDemoClaim,
  profileVerified = false,
}: SailorProfileViewProps) {
  const router = useRouter();
  const { toast, confirm } = useFeedback();
  const [isPublicWeight, setIsPublicWeight] = useState<boolean>(
    Boolean(initialSailor.isPublicWeight)
  );
  const [isPublicDob, setIsPublicDob] = useState<boolean>(
    Boolean(initialSailor.isPublicDob)
  );
  const [claimStatus, setClaimStatus] = useState<string | null>(null);
  const [claimMsg, setClaimMsg] = useState<string | null>(null);
  const [claimPanelOpen, setClaimPanelOpen] = useState(false);
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
  const [personalBusy, setPersonalBusy] = useState(false);
  const [personalMsg, setPersonalMsg] = useState<string | null>(null);
  const [avatarBusy, setAvatarBusy] = useState(false);
  const [avatarMsg, setAvatarMsg] = useState<string | null>(null);
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
  /** Segmented profile view: Overview | Regattas | Milestones | Equipment */
  const [sectionTab, setSectionTab] = useState<ProfileSectionTab>("overview");

  useEffect(() => {
    const handleHash = () => {
      if (typeof window === "undefined") return;
      const hash = window.location.hash.toLowerCase();
      if (
        hash === "#profile-results" ||
        hash === "#results" ||
        hash === "#regattas"
      ) {
        setSectionTab("results");
      } else if (
        hash === "#profile-journey" ||
        hash === "#journey" ||
        hash === "#milestones"
      ) {
        setSectionTab("journey");
      } else if (hash === "#profile-equipment" || hash === "#equipment") {
        setSectionTab("equipment");
      } else if (
        hash === "#profile-standing" ||
        hash === "#profile-hero" ||
        hash === "#overview"
      ) {
        setSectionTab("overview");
      }
    };
    handleHash();
    window.addEventListener("hashchange", handleHash);
    return () => window.removeEventListener("hashchange", handleHash);
  }, []);

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
      setIsPublicWeight(Boolean(data.sailor.isPublicWeight));
      setIsPublicDob(Boolean(data.sailor.isPublicDob));
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
        router.replace(`/${encodeURIComponent(data.sailor.handle)}`);
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
          "We couldn’t upload the photo. Try again or contact support if the problem continues."
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

  const updateJourneyItem = async (
    id: string,
    updated: { when: string; title: string; detail: string },
    isSystem?: boolean
  ) => {
    let next: JourneyHighlight[];
    if (isSystem) {
      const dismissed = dismissSystemMilestone(journey, id);
      const customItem: JourneyHighlight = {
        id: newJourneyId(),
        when: updated.when.trim(),
        title: updated.title.trim(),
        detail: updated.detail.trim(),
      };
      next = [customItem, ...dismissed];
    } else {
      next = journey.map((j) =>
        j.id === id
          ? {
              ...j,
              when: updated.when.trim(),
              title: updated.title.trim(),
              detail: updated.detail.trim(),
            }
          : j
      );
    }
    await persistJourney(next);
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

  // Cross-class official Notice of Race (NoR) prizes and verified awards
  const awards = useMemo(
    () => getSailorPrizes(displaySailor, results),
    [displaySailor, results]
  );
  const awardCounts = useMemo(() => getSailorMedalCounts(awards), [awards]);

  const heroMedals = useMemo(() => {
    if (awards.length > 0) {
      return {
        gold: awardCounts.gold,
        silver: awardCounts.silver,
        bronze: awardCounts.bronze,
        show: true,
      };
    }
    return analytics.medals;
  }, [awards, awardCounts, analytics.medals]);

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

  const isUnclaimedProfile =
    !profileClaimed && !profileVerified && !isOwner;
  const showUnclaimedBanner =
    isUnclaimedProfile &&
    (demoMode ? canClaim || demoRole === "public" : true);

  return (
    <div
      id="profile-hero"
      className="mx-auto max-w-3xl px-3 sm:px-6 py-6 sm:py-10 flex-1 w-full min-w-0 space-y-4 sm:space-y-5 bg-sailcloth text-charcoal overflow-x-clip"
    >
      {/* Claim banner — single primary CTA for unclaimed profiles (header repeats suppressed) */}
      {showUnclaimedBanner && (
        <div className="rounded-2xl border border-racing-orange/30 bg-warm-white p-4 sm:p-5 shadow-sm flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div className="min-w-0">
            <p className="text-sm font-bold text-harbour-shadow flex items-center gap-1.5">
              <span className="h-2 w-2 rounded-full bg-racing-orange" />
              Is this you? Claim your profile
            </p>
            <p className="text-[13px] text-slate-soft mt-1 leading-snug">
              Link as sailor or parent to unlock logbook, privacy controls, race notes, and equipment tracking.
            </p>
          </div>
          <button
            type="button"
            onClick={() => {
              if (demoMode) {
                onDemoClaim?.();
                return;
              }
              if (!isLoggedIn) {
                router.push(
                  `/login?next=${encodeURIComponent(
                    `/${displaySailor.handle || ""}`
                  )}`
                );
                return;
              }
              setClaimPanelOpen(true);
            }}
            className="shrink-0 sp-primary inline-flex items-center gap-1.5 px-4 py-2.5 text-xs font-bold text-white shadow-sm"
          >
            <UserPlus className="h-3.5 w-3.5" />
            Claim this profile
          </button>
        </div>
      )}

      {/* Coach squad context strip (demo) */}
      {demoMode && demoRole === "coach" && (
        <div className="rounded-2xl border border-harbour/25 bg-aqua-mist/50 px-4 py-3 flex flex-wrap items-center gap-x-4 gap-y-1.5 text-xs text-charcoal shadow-xs">
          <span className="font-bold text-harbour">Squad context</span>
          <span className="text-slate-soft">
            Avg. finish:{" "}
            <span className="font-semibold text-charcoal">3.6</span>
            <span className="text-slate-soft"> · Squad avg: 5.2</span>
          </span>
          <span className="text-slate-soft">
            <span className="font-semibold text-charcoal">#3</span> of 100 nationally
            <span className="text-slate-soft"> · </span>
            <span className="font-semibold text-harbour">#1 of 12</span> in squad
          </span>
        </div>
      )}

      {/* ── Hero Athlete Card ─────────────────────────────────── */}
      <HeroAthleteCard
        displaySailor={displaySailor}
        fleetBadge={fleetBadge}
        activeStanding={activeStanding}
        standingIsIlca={standingIsIlca}
        dualClass={dualClass}
        selectedBoatClass={resultsTab === "ilca4" ? "ilca4" : "optimist"}
        onSelectBoatClass={(cls) => {
          setResultsTab(cls);
          setShowAllResults(false);
        }}
        medals={heroMedals}
        profileClaimed={profileClaimed}
        profileVerified={profileVerified}
        showUnclaimedBanner={showUnclaimedBanner}
        canClaim={canClaim}
        claimStatus={claimStatus}
        claimMsg={claimMsg}
        claimPanelOpen={claimPanelOpen}
        onToggleClaimPanel={() => setClaimPanelOpen((o) => !o)}
        onDemoClaim={onDemoClaim}
        demoMode={demoMode}
        isLoggedIn={isLoggedIn}
        isOwner={isOwner}
        ownerView={ownerView}
        previewPublic={previewPublic}
        onTogglePreviewPublic={() => {
          setPreviewPublic((p) => {
            const next = !p;
            if (next) {
              setEditing(false);
              setExpandedRegattaId(null);
            }
            return next;
          });
        }}
        editing={editing}
        onToggleEditing={() => setEditing((e) => !e)}
        avatarBusy={avatarBusy}
        avatarMsg={avatarMsg}
        onUploadAvatar={(f) => void uploadAvatar(f)}
        showWeight={showWeight}
        bornYear={bornYear}
        fullDobLabel={fullDobLabel}
        showFullDob={showFullDob}
        leftOptimistYear={leftOptimistYear}
        sailDisplay={sailDisplay}
        sailIlca4={sailIlca4}
        noc={noc}
        totalRegattasCount={results.length}
      />

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

      <ProfileClassNavigation
        dualClass={dualClass}
        preferIlcaFirst={preferIlcaFirst}
        activeTab={resultsTab}
        sectionTab={sectionTab}
        optimistCount={optimistResults.length}
        ilcaCount={ilca4Results.length}
        journeyCount={displayJourney.length}
        awardsCount={awards.length}
        showStanding={Boolean(activeStanding)}
        showEquipment={showEquipmentSection || !isOwner}
        onTabChange={(tab) => {
          setResultsTab(tab);
          if (tab === "journey") {
            setSectionTab("journey");
          }
          setShowAllResults(false);
        }}
        onSectionTabChange={(tab) => {
          setSectionTab(tab);
        }}
      />

      {/* ── OVERVIEW TAB ────────────────────────────────────────── */}
      {sectionTab === "overview" && (
        <div className="space-y-4">
          {/* ── Awards & Honours Cabinet ─────────────────────────── */}
          {awards.length > 0 && (
            <ProfileAwardsCabinet
              awards={awards}
              sailorName={displaySailor.name}
              isOwner={ownerView}
            />
          )}

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
                  standingIsIlca ? "bg-aqua-mist text-harbour" : "bg-racing-mist/30 text-racing-orange"
                }`}
              >
                <Trophy className="h-3.5 w-3.5" />
              </div>
              <div>
                <p className="text-[13px] font-bold text-harbour-shadow">
                  {standingIsIlca
                    ? "ILCA 4 national ranking"
                    : "Series standing"}
                </p>
                <p className="text-[13px] text-slate-soft">
                  {activeStanding.periodLabel}
                  <span className="text-cool-veil"> · </span>
                  <span
                    className={`font-semibold ${
                      standingIsIlca
                        ? "text-harbour"
                        : "text-racing-orange"
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
              <p className="text-[12px] font-bold uppercase tracking-[0.12em] text-slate-soft">
                National rank
              </p>
              <p
                className={`text-3xl sm:text-4xl font-black tabular-nums leading-none ${
                  standingIsIlca ? "text-harbour" : "text-racing-orange"
                }`}
              >
                #{activeStanding.overallRank}
              </p>
              <p className="text-[12px] text-slate-soft mt-1 tabular-nums font-medium">
                of {activeStanding.fleetSize}
                {standingIsIlca ? "" : ` · ${activeStanding.fleet}`}
              </p>
              <p className="text-[13px] text-slate-soft mt-1.5 tabular-nums">
                Best 3 of 5{" "}
                <span className="font-bold text-charcoal">
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
                  className="rounded-xl border border-cool-veil bg-sailcloth/60 px-2 py-3 text-center min-h-[5.5rem] flex flex-col"
                  title={r?.regattaName}
                >
                  <p
                    className={`text-[13px] font-bold tracking-wide ${
                      standingIsIlca ? "text-harbour" : "text-racing-orange"
                    }`}
                  >
                    R{i + 1}
                  </p>
                  <p className="text-[12px] sm:text-[13px] font-medium text-charcoal leading-snug mt-1.5 line-clamp-2 flex-1 px-0.5">
                    {empty && !showIlcaScore ? "—" : shortName || "—"}
                  </p>
                  {showIlcaScore ? (
                    <div className="mt-2 space-y-0.5">
                      <p className="text-lg font-black text-harbour-shadow tabular-nums leading-none">
                        {r!.finishPlace != null && r!.finishPlace > 0
                          ? `#${r!.finishPlace}`
                          : "DNC"}
                      </p>
                      <p className="text-[13px] font-bold text-harbour tabular-nums">
                        {r!.score} pts
                      </p>
                    </div>
                  ) : (
                    <p className="text-xl font-black text-charcoal tabular-nums mt-2">
                      {empty
                        ? "—"
                        : `${r!.score}${r!.isOverseasCommitment ? "†" : r!.isDNS ? "*" : ""}${r!.isCarryForward ? " CF" : ""}`}
                    </p>
                  )}
                </div>
              );
            })}
          </div>
          <ul className="mt-4 sm:hidden divide-y divide-cool-veil rounded-xl border border-cool-veil bg-sailcloth/40 overflow-hidden">
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
                      className={`shrink-0 text-[13px] font-bold w-6 ${
                        standingIsIlca ? "text-harbour" : "text-racing-orange"
                      }`}
                    >
                      R{i + 1}
                    </span>
                    <span className="text-[13px] font-medium text-charcoal truncate">
                      {empty && !standingIsIlca
                        ? "—"
                        : r?.regattaName && r.regattaName !== "—"
                          ? r.regattaName
                          : "—"}
                    </span>
                  </div>
                  {standingIsIlca && r && r.regattaName !== "—" ? (
                    <span className="shrink-0 text-right">
                      <span className="block text-base font-black text-harbour-shadow tabular-nums leading-none">
                        {r.finishPlace != null && r.finishPlace > 0
                          ? `#${r.finishPlace}`
                          : ilcaMiss || r.isDNS
                            ? "DNC"
                            : "—"}
                      </span>
                      <span className="block text-[13px] font-bold text-harbour tabular-nums mt-0.5">
                        {r.score} pts
                      </span>
                    </span>
                  ) : (
                    <span className="shrink-0 text-lg font-black text-charcoal tabular-nums">
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
            <p className="mt-3 text-[13px] text-slate-soft leading-relaxed">
              <span className="font-bold text-charcoal">Key: </span>
              <span className="tabular-nums font-medium">CF</span> = carry-forward ·{" "}
              <span className="tabular-nums font-medium">*</span> = DNS (did not start;
              series score = fleet size + 1) ·{" "}
              <span className="tabular-nums font-medium">†</span> = overseas commitment
            </p>
          )}
          {!standingIsIlca && seriesDnsCount > 0 && (
            <p className="mt-1.5 text-[13px] text-slate-soft leading-relaxed">
              {seriesDnsCount} missed ranking{" "}
              {seriesDnsCount === 1 ? "event" : "events"} in this window
              (DNS) — listed under Results below and on the position trend.
            </p>
          )}
          {activeStanding.trendNote && (
            <p className="mt-2 text-[13px] font-bold text-harbour">
              {activeStanding.trendNote}
            </p>
          )}
          <Link
            href={
              standingIsIlca
                ? "/sg/ilca4"
                : `/sg/optimist/${String(activeStanding.fleet).toLowerCase()}`
            }
            className="inline-flex items-center gap-1 mt-2 text-[12px] font-bold text-harbour hover:text-harbour-shadow"
          >
            {standingIsIlca
              ? "View full ILCA 4 standings →"
              : `View full ${activeStanding.fleet} standings →`}
          </Link>
        </section>
      )}

      <ProfilePerformanceSummary
        showSummary={resultsTab !== "journey"}
        keyStatsTitle={keyStatsTitle}
        statCells={statCells}
        showMedals={showMedals}
        medalTallyTitle={medalTallyTitle}
        medals={analytics.medals}
        trendPoints={trendPoints}
        trendMode={trendMode}
        trendGoldEntry={trendGoldEntry}
        trendCaption={trendCaption}
      />

          {/* ── Recent Regattas Snapshot (Overview) ────────────────── */}
          {activeResultsList.length > 0 && (
            <section className={`${cardClass} p-4 sm:p-5 space-y-3`}>
              <div className="flex items-center justify-between gap-2">
                <div>
                  <h2 className="text-[12px] font-bold uppercase tracking-[0.14em] text-slate-soft">
                    Recent Regattas
                  </h2>
                  <p className="text-xs text-slate-soft mt-0.5 font-medium">
                    Latest competition finishes
                  </p>
                </div>
                <button
                  type="button"
                  onClick={() => setSectionTab("results")}
                  className="text-[11px] font-bold text-harbour hover:text-harbour-shadow transition cursor-pointer"
                >
                  View all {activeResultsList.length} results →
                </button>
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-3 gap-2.5">
                {activeResultsList.slice(0, 3).map((res, idx) => {
                  const rank = res.rank != null ? Number(res.rank) : null;
                  const dns = Boolean(res.isDns || res.isDNS);
                  const isIlcaRow =
                    primaryIsIlca ||
                    profileBoatClassGroup((res as ProfileResult).boatClass) ===
                      "ilca4";
                  const fleetSize = res.totalFleetSize ?? res.fleetSize;
                  const dateStr = formatEventWhen(res.regattaDate as string);
                  return (
                    <div
                      key={String(res.id || idx)}
                      className="rounded-xl border border-cool-veil bg-sailcloth/60 p-3.5 flex flex-col justify-between"
                    >
                      <div>
                        <p className="text-[13px] text-slate-soft truncate font-medium">
                          {dateStr}
                        </p>
                        <p
                          className="text-[13px] font-bold text-harbour-shadow line-clamp-1 mt-0.5"
                          title={res.regattaName}
                        >
                          {res.regattaName}
                        </p>
                      </div>
                      <div className="mt-3 flex items-baseline justify-between">
                        <span
                          className={`text-xl font-black tabular-nums ${
                            dns
                              ? "text-racing-orange"
                              : isIlcaRow
                                ? "text-harbour"
                                : "text-charcoal"
                          }`}
                        >
                          {dns ? "DNS" : rank != null ? `#${rank}` : "—"}
                        </span>
                        {fleetSize ? (
                          <span className="text-[13px] text-slate-soft tabular-nums font-medium">
                            of {fleetSize} boats
                          </span>
                        ) : null}
                      </div>
                    </div>
                  );
                })}
              </div>
            </section>
          )}

          {/* ── Career Milestones Snapshot (Overview) ──────────────── */}
          {displayJourney.length > 0 && (
            <section className={`${cardClass} p-4 sm:p-5 space-y-3`}>
              <div className="flex items-center justify-between gap-2">
                <div>
                  <h2 className="text-[12px] font-bold uppercase tracking-[0.14em] text-slate-soft">
                    Career Milestones
                  </h2>
                  <p className="text-xs text-slate-soft mt-0.5 font-medium">
                    Key pathway achievements
                  </p>
                </div>
                <button
                  type="button"
                  onClick={() => setSectionTab("journey")}
                  className="text-[11px] font-bold text-harbour hover:text-harbour-shadow transition cursor-pointer"
                >
                  View all {displayJourney.length} milestones →
                </button>
              </div>
              <div className="space-y-2">
                {displayJourney.slice(0, 2).map((m) => (
                  <div
                    key={m.id}
                    className="flex items-start gap-3 rounded-xl border border-cool-veil bg-sailcloth/50 px-3.5 py-2.5"
                  >
                    <span className="mt-0.5 flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-aqua-mist text-harbour font-bold text-xs">
                      ★
                    </span>
                    <div className="min-w-0 flex-1">
                      <div className="flex items-center justify-between gap-2">
                        <p className="text-[13px] font-bold text-harbour-shadow truncate">
                          {m.title}
                        </p>
                        {m.when && (
                          <span className="text-[13px] text-slate-soft font-medium shrink-0">
                            {m.when}
                          </span>
                        )}
                      </div>
                      {m.detail && (
                        <p className="text-[12px] text-slate-soft mt-0.5 line-clamp-2 leading-relaxed">
                          {m.detail}
                        </p>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* ── Equipment Locker Snapshot (Overview) ──────────────── */}
          {showEquipmentSection && (
            <section
              className={`${cardClass} p-4 sm:p-5 flex items-center justify-between gap-3`}
            >
              <div className="flex items-center gap-3 min-w-0">
                <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-aqua-mist border border-harbour/20 text-harbour">
                  <Anchor className="h-5 w-5" />
                </div>
                <div>
                  <h2 className="text-[13px] font-bold text-harbour-shadow">
                    Boat Locker & Equipment
                  </h2>
                  <p className="text-[13px] text-slate-soft mt-0.5 font-medium">
                    Private gear inventory, condition statuses & use logs
                  </p>
                </div>
              </div>
              <button
                type="button"
                onClick={() => setSectionTab("equipment")}
                className="shrink-0 sp-secondary inline-flex items-center px-3.5 py-2 text-xs font-bold transition touch-manipulation cursor-pointer"
              >
                Open Locker →
              </button>
            </section>
          )}
        </div>
      )}

      {/* ── REGATTAS TAB ────────────────────────────────────────── */}
      {sectionTab === "results" && (
        <div id="profile-results" className="scroll-mt-28 space-y-4">
      <section className={`${cardClass} overflow-hidden`}>
        <div className="px-4 sm:px-5 pt-4 sm:pt-5 pb-2 flex flex-wrap items-end justify-between gap-2">
          <div className="min-w-0 flex-1">
            <h2 className="text-[12px] font-bold uppercase tracking-[0.14em] text-slate-soft">
              {resultsTab === "journey"
                ? "Sailing journey"
                : dualClass && resultsTab === "ilca4"
                  ? "Regatta results · ILCA 4"
                  : dualClass && resultsTab === "optimist"
                    ? "Regatta results · Optimist"
                    : "Regatta results"}
            </h2>
            {resultsTab !== "journey" && (
            <p className="text-[13px] text-slate-soft mt-1 font-medium">
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
                className="mt-2 inline-flex rounded-full border border-cool-veil bg-sailcloth p-0.5 gap-0.5"
                role="group"
                aria-label="Optimist results filter"
              >
                <button
                  type="button"
                  onClick={() => {
                    setOptimistScope("gold");
                    setShowAllResults(false);
                  }}
                  className={`rounded-full px-3 py-1 text-[13px] font-bold touch-manipulation min-h-[1.75rem] cursor-pointer ${
                    optimistScope === "gold"
                      ? "bg-harbour text-sailcloth shadow-2xs"
                      : "text-slate-soft hover:text-charcoal"
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
                  className={`rounded-full px-3 py-1 text-[13px] font-bold touch-manipulation min-h-[1.75rem] cursor-pointer ${
                    optimistScope === "all"
                      ? "bg-harbour text-sailcloth shadow-2xs"
                      : "text-slate-soft hover:text-charcoal"
                  }`}
                >
                  All Optimist
                </button>
              </div>
            )}
          </div>
          {ownerView && resultsTab !== "journey" && (
            <p className="text-[13px] text-slate-soft inline-flex items-center gap-1 font-medium">
              <StickyNote className="h-3 w-3 text-harbour" />
              Expand a row for race notes
            </p>
          )}
        </div>

        {ownerView &&
          !dismissSailorTip &&
          resultsTab !== "journey" &&
          (demoMode ? demoRole === "sailor" : true) && (
            <div className="mx-4 sm:mx-5 mb-3 flex items-start gap-2 rounded-xl border border-harbour/20 bg-aqua-mist/50 px-3.5 py-2.5 shadow-2xs">
              <p className="flex-1 text-[12px] text-charcoal leading-relaxed">
                <span className="font-bold text-harbour">Tip: </span>
                Expand any regatta to add race observations (place, wind, notes).
                Use the{" "}
                <span className="font-bold text-harbour-shadow">📝 Add note</span>{" "}
                control on each row.
              </p>
              <button
                type="button"
                onClick={() => setDismissSailorTip(true)}
                className="shrink-0 rounded-md p-1 text-slate-soft hover:text-charcoal cursor-pointer"
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
            onUpdate={(id, updated, isSystem) =>
              void updateJourneyItem(id, updated, isSystem)
            }
            onRemove={(id, isSystem) => void removeJourneyItem(id, isSystem)}
          />
        ) : null}

        {resultsTab !== "journey" && ownerView && !demoMode && (
          <div className="mx-4 sm:mx-5 mb-3 rounded-xl border border-cool-veil bg-sailcloth/50 p-3 flex flex-col sm:flex-row sm:items-center justify-between gap-2">
            <p className="text-[13px] text-slate-soft">
              Log an overseas, club, or training regatta — attach evidence for
              a Verified ✓ badge.
            </p>
            <div className="flex items-center gap-3 shrink-0">
              {personalMsg && (
                <p className="text-[13px] font-bold text-harbour">{personalMsg}</p>
              )}
              <Link
                href={`/athlete?id=${initialSailor.id}&tab=results&action=new`}
                className="sp-secondary inline-flex items-center gap-1.5 rounded-lg px-3 py-1.5 text-[13px] font-bold cursor-pointer"
              >
                <Plus className="h-3.5 w-3.5" />
                Log a regatta result
              </Link>
            </div>
          </div>
        )}

        {resultsTab !== "journey" && visibleResults.length === 0 ? (
          <p className="px-5 pb-5 text-sm text-slate-soft font-medium">
            No regatta results yet.
          </p>
        ) : resultsTab !== "journey" ? (
          <>
            <div
              className={`hidden sm:grid gap-2 px-4 sm:px-5 py-2.5 border-t border-cool-veil text-[12px] font-bold uppercase tracking-wider text-slate-soft ${
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
            <div className="divide-y divide-cool-veil">
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
                const officialRaces = (res.raceResults || []).slice().sort(
                  (a, b) => a.raceNumber - b.raceNumber
                );
                const fleetSize = res.totalFleetSize ?? res.fleetSize;
                const nonRanking = !regattaCountsForRanking(res);
                /** Public: expand when there are visible notes, official races, or evidence; owners always can. */
                const canExpand =
                  officialRaces.length > 0 ||
                  raceNotes.length > 0 ||
                  Boolean(res.evidenceUrl || res.officialUrl || res.evidenceNotes) ||
                  ownerView;
                const canLink =
                  slug &&
                  String(slug).length > 2 &&
                  !String(slug).startsWith("log-");
                const regattaHref = isIlcaRow
                  ? `/sg/ilca/regattas/${slug}`
                  : `/sg/optimist/regattas/${slug}`;
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
                          ? "cursor-pointer hover:bg-sailcloth/60 transition-colors"
                          : "cursor-default"
                      } ${
                        isIlcaRow
                          ? "sm:grid-cols-[1.25rem_2.75rem_1fr_2.5rem_4.25rem]"
                          : "sm:grid-cols-[1.25rem_2.75rem_1fr_4.5rem_4.25rem]"
                      }`}
                    >
                      <span
                        className={`pt-1 ${
                          canExpand ? "text-slate-soft" : "text-transparent"
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
                            ? "text-racing-orange font-black"
                            : isIlcaRow
                              ? "text-harbour font-black"
                              : "text-harbour-shadow font-black"
                        }`}
                        title={
                          isIlcaRow
                            ? "High Ranking Points (1st = fleet size)"
                            : fleetSize
                              ? `Place ${leftValue} of ${fleetSize} sailors`
                              : "Finishing place"
                        }
                      >
                        <span className="text-[15px] font-black">
                          {isIlcaRow ? leftValue : leftValue === "DNS" ? "DNS" : leftValue === "—" ? "—" : `#${leftValue}`}
                        </span>
                        {showFleetSizeUnderPlace && (
                            <span className="text-[13px] font-medium text-slate-soft mt-0.5">
                              /{fleetSize}
                            </span>
                          )}
                      </span>
                      <div className="min-w-0">
                        {canLink ? (
                          <Link
                            href={regattaHref}
                            onClick={(e) => e.stopPropagation()}
                            className="text-[13px] font-bold text-harbour-shadow truncate block hover:text-harbour"
                          >
                            {res.regattaName}
                          </Link>
                        ) : (
                          <p className="text-[13px] font-bold text-harbour-shadow truncate">
                            {res.regattaName}
                          </p>
                        )}
                        <p className="text-[13px] text-slate-soft truncate mt-0.5 font-medium">
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
                            <p className="sm:hidden text-[13px] text-slate-soft mt-1 tabular-nums font-semibold">
                              {mobileSecondary}
                            </p>
                          ) : null;
                        })()}
                        {tags.length > 0 && (
                          <div className="mt-1.5 flex flex-wrap gap-1">
                            {tags.map((t) => (
                              <span
                                key={t.label}
                                className={`rounded-md px-1.5 py-px text-[11px] font-bold border ${t.className}`}
                              >
                                {t.label}
                              </span>
                            ))}
                          </div>
                        )}
                        {(() => {
                          const regAwards = awards.filter(
                            (a) =>
                              a.regattaSlug === res.regattaSlug ||
                              (res.regattaName &&
                                a.regattaName.toLowerCase().trim() ===
                                  res.regattaName.toLowerCase().trim())
                          );
                          if (!regAwards.length) return null;
                          return (
                            <div className="mt-1.5 flex flex-wrap gap-1.5">
                              {regAwards.map((a) => (
                                <span
                                  key={a.id}
                                  className="inline-flex items-center gap-1 rounded-md border border-amber-300 bg-amber-50 px-2 py-0.5 text-[11px] font-bold text-amber-900 shadow-2xs"
                                  title={`Official Prize: ${a.prizeTitle} (${a.categoryName})`}
                                >
                                  <Trophy className="h-3 w-3 text-amber-600" />
                                  <span>{a.prizeTitle}</span>
                                  <span className="text-amber-700">· {a.categoryName}</span>
                                </span>
                              ))}
                            </div>
                          );
                        })()}
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
                              className="mt-1.5 text-[13px] text-slate-soft flex flex-wrap items-center gap-x-2 gap-y-0.5 font-medium"
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
                          <span className="mt-1.5 inline-flex items-center gap-1 rounded-md border border-harbour/30 bg-aqua-mist px-2 py-0.5 text-[11px] font-bold text-harbour">
                            <StickyNote className="h-3 w-3" />
                            {raceNotes.length} note
                            {raceNotes.length === 1 ? "" : "s"}
                          </span>
                        )}
                        {officialRaces.length > 0 && (
                          <span className="mt-1.5 inline-flex items-center gap-1 rounded-md border border-emerald-300 bg-emerald-50 px-2 py-0.5 text-[11px] font-bold text-emerald-800">
                            <Trophy className="h-3 w-3 text-emerald-600" />
                            {officialRaces.length} race score
                            {officialRaces.length === 1 ? "" : "s"}
                          </span>
                        )}
                        {ownerView && (
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation();
                              setExpandedRegattaId(regattaId);
                            }}
                            className={`mt-1.5 inline-flex items-center gap-1 rounded-md border px-2 py-0.5 text-[13px] font-bold cursor-pointer ${
                              raceNotes.length > 0
                                ? "border-cool-veil bg-warm-white text-charcoal hover:bg-sailcloth"
                                : "border-racing-orange/30 bg-racing-mist/30 text-racing-orange hover:bg-racing-mist/50"
                            }`}
                          >
                            <StickyNote className="h-3 w-3" />
                            {raceNotes.length > 0 ? "View notes" : "Add note"}
                          </button>
                        )}
                      </div>
                      <span
                        className={`hidden sm:flex flex-col items-end text-right tabular-nums pt-0.5 leading-tight ${
                          isIlcaRow ? "text-charcoal font-bold" : "text-slate-soft font-semibold"
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
                            <span className="text-[13px] font-medium text-slate-soft mt-0.5">
                              /{fleetSize}
                            </span>
                          )}
                      </span>
                      <span className="flex items-center justify-end pt-0.5">
                        <span
                          className={`rounded-full px-2 py-0.5 text-[13px] font-bold ${fleetPillClass(fleet)}`}
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
                          className="ml-14 mb-2 text-[10px] font-medium text-rose-600"
                        >
                          Remove
                        </button>
                      )}

                    {expanded && canExpand && (
                      <div className="px-4 sm:px-5 pb-4 space-y-3 border-t border-cool-veil bg-sailcloth/50">
                        {/* Official Evidence & Results Document Block */}
                        {(res.evidenceUrl || res.officialUrl || res.evidenceNotes) && (
                          <div className="mt-3 rounded-xl border border-cool-veil bg-warm-white p-3.5 space-y-2 shadow-2xs">
                            <div className="flex flex-wrap items-center justify-between gap-2">
                              <span className="text-[12px] font-bold text-slate-soft uppercase tracking-wider flex items-center gap-1.5">
                                <FileText className="h-3.5 w-3.5 text-harbour" />
                                Official Evidence & Score Verification
                              </span>
                              {res.verificationStatus === "verified" ? (
                                <span className="inline-flex items-center gap-1 text-[11px] font-bold text-emerald-700 bg-emerald-50 border border-emerald-200 rounded-full px-2 py-0.5">
                                  <CheckCircle2 className="h-3 w-3" />
                                  Verified Score
                                </span>
                              ) : res.verificationStatus === "pending_review" ? (
                                <span className="inline-flex items-center gap-1 text-[11px] font-bold text-sky-700 bg-sky-50 border border-sky-200 rounded-full px-2 py-0.5">
                                  <FileText className="h-3 w-3" />
                                  Evidence Attached · Awaiting Review
                                </span>
                              ) : (
                                <span className="text-[11px] font-bold text-amber-700 bg-amber-50 border border-amber-200 rounded-full px-2 py-0.5">
                                  Self-Reported Score
                                </span>
                              )}
                            </div>

                            <div className="flex flex-wrap items-center gap-3 text-xs pt-1">
                              {res.evidenceUrl && (
                                <a
                                  href={res.evidenceUrl}
                                  target="_blank"
                                  rel="noreferrer"
                                  className="inline-flex items-center gap-1.5 text-harbour hover:underline font-bold text-[11px]"
                                >
                                  {res.evidenceType === "image" ? (
                                    <ImageIcon className="h-3.5 w-3.5" />
                                  ) : (
                                    <FileText className="h-3.5 w-3.5" />
                                  )}
                                  <span>{res.evidenceName || "View Uploaded Evidence"}</span>
                                </a>
                              )}
                              {res.officialUrl && (
                                <a
                                  href={res.officialUrl}
                                  target="_blank"
                                  rel="noreferrer"
                                  className="inline-flex items-center gap-1.5 text-indigo-600 hover:underline font-bold text-[11px]"
                                >
                                  <ExternalLink className="h-3.5 w-3.5" />
                                  <span>Official Results Webpage</span>
                                </a>
                              )}
                            </div>

                            {res.evidenceNotes && (
                              <p className="text-xs text-charcoal italic border-t border-cool-veil pt-1.5 mt-1">
                                “{res.evidenceNotes}”
                              </p>
                            )}
                          </div>
                        )}

                        {officialRaces.length > 0 && (
                          <div className="pt-3 space-y-2">
                            <div className="flex items-center gap-2 text-[12px] font-bold text-slate-soft uppercase tracking-wider">
                              <Trophy className="h-3.5 w-3.5 text-harbour" />
                              Published race scores
                            </div>
                            <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
                              {officialRaces.map((race) => (
                                <div
                                  key={race.raceNumber}
                                  className="rounded-lg border border-cool-veil bg-warm-white px-3 py-2 shadow-2xs"
                                >
                                  <p className="text-[13px] text-slate-soft font-medium">Race {race.raceNumber}</p>
                                  <p className="text-sm font-black text-harbour-shadow tabular-nums">
                                    {race.rawValue || race.score}
                                  </p>
                                  {race.scoringCode && (
                                    <p className="text-[13px] font-bold text-racing-orange">
                                      {race.scoringCode}
                                    </p>
                                  )}
                                </div>
                              ))}
                            </div>
                          </div>
                        )}
                        <div className="flex items-center gap-2 pt-3 text-[12px] font-bold text-slate-soft uppercase tracking-wider">
                          <BookOpen className="h-3.5 w-3.5 text-racing-orange" />
                          Race observations
                        </div>
                        {raceNotes.length === 0 ? (
                          <p className="text-xs text-slate-soft font-medium">
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
                                className="rounded-lg border border-cool-veil bg-warm-white px-3 py-2 shadow-2xs"
                              >
                                <div className="flex items-center justify-between gap-2">
                                  <span className="text-xs font-bold text-harbour-shadow">
                                    Race {String(o.raceNumber)}
                                  </span>
                                  <span className="text-[13px] font-mono text-slate-soft">
                                    {o.position != null
                                      ? `Score ${o.position}`
                                      : "—"}
                                    {o.wind ? ` · ${o.wind}` : ""}
                                    {o.isPrivate ? " · private" : ""}
                                  </span>
                                </div>
                                {o.note ? (
                                  <p className="text-xs text-charcoal mt-1 leading-relaxed">
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
                                      className="text-[10px] font-bold text-harbour hover:underline"
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
                                        className="text-[10px] font-bold text-rose-600 hover:underline"
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
                          <div className="rounded-lg border border-cool-veil bg-warm-white p-3 space-y-2">
                            <p className="text-[12px] font-bold uppercase tracking-wider text-harbour">
                              {editingObsId
                                ? "Edit observation"
                                : "Add observation"}
                              {demoMode ? " (demo)" : ""}
                            </p>
                            <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
                              <input
                                value={obsForm.raceNumber}
                                onChange={(e) =>
                                  setObsForm((f) => ({
                                    ...f,
                                    raceNumber: e.target.value,
                                  }))
                                }
                                placeholder="Race #"
                                type="number"
                                min={1}
                                className="rounded-lg bg-sailcloth border border-cool-veil px-2.5 py-1.5 text-xs text-charcoal"
                              />
                              <input
                                value={obsForm.position}
                                onChange={(e) =>
                                  setObsForm((f) => ({
                                    ...f,
                                    position: e.target.value,
                                  }))
                                }
                                placeholder="Score / Place"
                                type="number"
                                min={1}
                                className="rounded-lg bg-sailcloth border border-cool-veil px-2.5 py-1.5 text-xs text-charcoal"
                              />
                              <input
                                value={obsForm.wind}
                                onChange={(e) =>
                                  setObsForm((f) => ({
                                    ...f,
                                    wind: e.target.value,
                                  }))
                                }
                                placeholder="Wind (e.g. 12kt E)"
                                className="col-span-2 rounded-lg bg-sailcloth border border-cool-veil px-2.5 py-1.5 text-xs text-charcoal"
                              />
                              <textarea
                                value={obsForm.note}
                                onChange={(e) =>
                                  setObsForm((f) => ({
                                    ...f,
                                    note: e.target.value,
                                  }))
                                }
                                placeholder="Notes, starts, tactics, gear observations..."
                                rows={2}
                                className="col-span-2 sm:col-span-4 rounded-lg bg-sailcloth border border-cool-veil px-2.5 py-1.5 text-xs text-charcoal"
                              />
                            </div>
                            <div className="flex flex-wrap items-center justify-between gap-2 pt-1">
                              <label className="flex items-center gap-1.5 text-xs text-slate-soft font-medium cursor-pointer">
                                <input
                                  type="checkbox"
                                  checked={obsForm.isPrivate}
                                  onChange={(e) =>
                                    setObsForm((f) => ({
                                      ...f,
                                      isPrivate: e.target.checked,
                                    }))
                                  }
                                  className="rounded border-cool-veil text-harbour focus:ring-harbour"
                                />
                                Private (only you & coach can see)
                              </label>
                              <div className="flex items-center gap-2">
                                {editingObsId && (
                                  <button
                                    type="button"
                                    onClick={resetObsForm}
                                    className="text-xs text-slate-soft hover:text-charcoal font-medium"
                                  >
                                    Cancel
                                  </button>
                                )}
                                <button
                                  type="button"
                                  disabled={obsBusy}
                                  onClick={() => void saveObservation(regattaId)}
                                  className="sp-primary rounded-lg px-3 py-1.5 text-xs font-bold text-white shadow-xs disabled:opacity-50"
                                >
                                  {obsBusy
                                    ? "Saving…"
                                    : editingObsId
                                      ? "Update observation"
                                      : "Save note"}
                                </button>
                              </div>
                            </div>
                            {obsMsg && (
                              <p className="text-[13px] font-bold text-harbour">{obsMsg}</p>
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
              <div className="border-t border-cool-veil px-4 sm:px-5 py-3 text-center bg-sailcloth/30">
                <button
                  type="button"
                  onClick={() => setShowAllResults((v) => !v)}
                  className="text-[12px] font-bold text-harbour hover:text-harbour-shadow transition cursor-pointer"
                >
                  {showAllResults
                    ? "Show fewer results"
                    : `View all ${activeResultsList.length} results →`}
                </button>
              </div>
            )}
          </>
        ) : null}
      </section>
      </div>
      )}

      {/* ── AWARDS TAB ─────────────────────────────────────────── */}
      {sectionTab === "awards" && (
        <div id="profile-awards-tab" className="scroll-mt-28">
          <ProfileAwardsCabinet
            awards={awards}
            sailorName={displaySailor.name}
            isOwner={ownerView}
          />
        </div>
      )}

      {/* ── MILESTONES TAB ──────────────────────────────────────── */}
      {sectionTab === "journey" && (
        <div id="profile-journey" className="scroll-mt-28">
          <ProfileJourneyPanel
            variant="tab"
            items={displayJourney}
            isOwner={ownerView}
            draft={journeyDraft}
            setDraft={setJourneyDraft}
            busy={journeyBusy}
            message={journeyMsg}
            onAdd={() => void addJourneyItem()}
            onUpdate={(id, updated, isSystem) =>
              void updateJourneyItem(id, updated, isSystem)
            }
            onRemove={(id, isSystem) => void removeJourneyItem(id, isSystem)}
          />
        </div>
      )}

      {/* ── EQUIPMENT TAB ───────────────────────────────────────── */}
      {sectionTab === "equipment" && (
        <div id="profile-equipment" className="scroll-mt-28">
          {showEquipmentSection ? (
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
          ) : (
            <section
              id="profile-equipment-private"
              className={`${cardClass} p-4 sm:p-5`}
            >
              <h2 className="text-[12px] font-medium uppercase tracking-[0.14em] text-neutral-500">
                Equipment
              </h2>
              <p className="mt-2 text-[13px] text-neutral-400 leading-relaxed">
                Gear is private to the sailor and their linked family — not shown
                on public profiles.
                {showUnclaimedBanner
                  ? " Claim this profile to add hull, sail, and foils."
                  : ""}
              </p>
            </section>
          )}
        </div>
      )}

      {/* Privacy controls live under Edit profile only (not on Optimist/ILCA/Journey tabs). */}
    </div>
  );
}
