"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import { normalizeNationality } from "@/lib/seriesMembership";
import { createBrowserSupabase } from "@/lib/supabase/browser";
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
  mergeStandingScoresIntoTrend,
  optimistLeftYear,
  prefersIlcaFirstProfile,
  profileBoatClassGroup,
  tenureFromFirstDate,
  type ProfileResult,
} from "@/lib/profileAnalytics";
import {
  boardDisciplineOf,
  disciplineLabel,
  isBoardDiscipline,
  pickInitialProfileClass,
  summarizeBoardClass,
  type BoardDiscipline,
  type ProfileDiscipline,
} from "@/lib/boardProfile";
import {
  PROFILE_CARD_CLASS as cardClass,
  resolveDisplayFleet,
  formatFullDob,
} from "./helpers";
import type {
  SailorRecordProps,
  RegattaResultItem,
  ObservationItem,
  SailorProfileViewProps,
} from "./types";
import type { ProfileSectionTab } from "./ProfileClassNavigation";
import { getSailorPrizes, getSailorMedalCounts } from "@/lib/sailorPrizes";
import type { ProfileOwnerForm } from "@/components/sailor-profile/ProfileOwnerEditor";
import { errorMessage } from "@/lib/errors";
import { useFeedback } from "@/components/ui/FeedbackProvider";

export function useSailorProfileState({
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
    boardNumber: String(initialSailor.boardNumber || ""),
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
  /** Class the profile is showing. Board classes stay out of the Optimist default. */
  const [resultsTab, setResultsTab] = useState<ProfileDiscipline | "journey">(
    () => {
      const fromResults = pickInitialProfileClass(
        initialResults as ProfileResult[]
      );
      if (fromResults) return fromResults;
      const prefer = prefersIlcaFirstProfile({
        dropDate: initialSailor.dropDate as string | null | undefined,
        dob: initialSailor.dob as string | null | undefined,
      }, initialResults as ProfileResult[]);
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
      } else if (hash === "#profile-awards" || hash === "#awards") {
        setSectionTab("awards");
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
          boardNumber: form.boardNumber || null,
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
        boardNumber: data.sailor.boardNumber ?? f.boardNumber,
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

  /** Split raw results by boat class (before gold filtering). ILCA 6 folds into ILCA 4. */
  const classBuckets = useMemo(() => {
    const all = results as ProfileResult[];
    const optimist: ProfileResult[] = [];
    const ilca4: ProfileResult[] = [];
    const boards: Record<BoardDiscipline, ProfileResult[]> = {
      techno293: [],
      wingfoil: [],
      iqfoil: [],
      windsurfing: [],
    };
    for (const r of all) {
      const board = boardDisciplineOf(r.boatClass);
      if (board) {
        boards[board].push(r);
        continue;
      }
      const g = profileBoatClassGroup(r.boatClass);
      if (g === "ilca4") ilca4.push(r);
      else if (g === "optimist") optimist.push(r);
    }
    const byDate = (a: ProfileResult, b: ProfileResult) =>
      String(b.regattaDate || "").localeCompare(String(a.regattaDate || ""));
    optimist.sort(byDate);
    ilca4.sort(byDate);
    for (const list of Object.values(boards)) list.sort(byDate);
    return { optimist, ilca4, boards };
  }, [results]);

  const leftOptimistYear = optimistLeftYear({
    dropDate: displaySailor.dropDate as string | null | undefined,
    dob: displaySailor.dob as string | null | undefined,
  });
  const preferIlcaFirst = prefersIlcaFirstProfile({
    dropDate: displaySailor.dropDate as string | null | undefined,
    dob: displaySailor.dob as string | null | undefined,
  }, results as ProfileResult[]);
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
  const onBoardClass = isBoardDiscipline(resultsTab);
  const activeBoardResults = useMemo(
    () => (onBoardClass ? classBuckets.boards[resultsTab] : []),
    [onBoardClass, classBuckets.boards, resultsTab]
  );
  const boardSummary = onBoardClass
    ? summarizeBoardClass(resultsTab, activeBoardResults)
    : null;
  const classChoices = useMemo(() => {
    const choices: { id: ProfileDiscipline; label: string; count: number }[] = [];
    for (const discipline of ["techno293", "wingfoil", "iqfoil", "windsurfing"] as const) {
      const list = classBuckets.boards[discipline];
      if (!list.length) continue;
      choices.push({
        id: discipline,
        label: summarizeBoardClass(discipline, list).label,
        count: list.length,
      });
    }
    if (optimistResultsAll.length > 0) {
      choices.push({
        id: "optimist",
        label: "Optimist",
        count: optimistResultsAll.length,
      });
    }
    if (ilca4Results.length > 0) {
      choices.push({
        id: "ilca4",
        label: "ILCA 4",
        count: ilca4Results.length,
      });
    }
    return choices;
  }, [classBuckets.boards, optimistResultsAll.length, ilca4Results]);
  const hasBoardResults = classChoices.some((choice) =>
    isBoardDiscipline(choice.id)
  );
  const dualClass = hasIlcaResults && optimistResultsAll.length > 0;
  const showOptimistScopeFilter =
    !onBoardClass &&
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

  /** Active class list for the results panel (tabs when more than one class) */
  const activeResultsList = onBoardClass
    ? activeBoardResults
    : dualClass && resultsTab === "ilca4"
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
    !onBoardClass &&
    ((dualClass && resultsTab === "ilca4") ||
      (!dualClass && hasIlcaResults && classBuckets.optimist.length === 0) ||
      (dualClass && preferIlcaFirst && resultsTab === "ilca4"));

  const sailDisplay = String(displaySailor.sailNumber || "—");
  const sailIlca4 = displaySailor.sailNumberIlca4
    ? String(displaySailor.sailNumberIlca4)
    : null;
  const boardNumber = displaySailor.boardNumber
    ? String(displaySailor.boardNumber)
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
    !onBoardClass &&
    ((hasIlcaResults && classBuckets.optimist.length === 0) ||
      (hasIlcaResults && dualClass && resultsTab === "ilca4") ||
      (preferIlcaFirst && hasIlcaResults && !hasOptimistResults));

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
   * The selected class owns the rank. An ILCA view with no ILCA standing
   * stays empty instead of borrowing the Optimist series place.
   */
  const standingLooksIlca = Boolean(
    initialIlcaStanding &&
      (String(initialIlcaStanding.boatClass || "")
        .toLowerCase()
        .includes("ilca") ||
        String(initialIlcaStanding.fleet || "")
          .toLowerCase()
          .includes("open"))
  );
  const standingIsIlca = Boolean(useIlcaStats && standingLooksIlca);
  const activeStanding = onBoardClass
    ? null
    : useIlcaStats
      ? standingIsIlca
        ? initialIlcaStanding ?? null
        : null
      : initialSeriesStanding ?? null;
  const activeBoatClass: "optimist" | "ilca4" = useIlcaStats
    ? "ilca4"
    : "optimist";
  const selectedClassLabel = onBoardClass
    ? boardSummary?.label || disciplineLabel(resultsTab)
    : activeBoatClass === "ilca4"
      ? "ILCA 4"
      : "Optimist";
  const visibleAwards = useMemo(() => {
    if (!onBoardClass) return awards;
    return awards.filter(
      (award) => boardDisciplineOf(award.boatClass) === resultsTab
    );
  }, [awards, onBoardClass, resultsTab]);
  const displayMedals = useMemo(() => {
    if (!onBoardClass) return heroMedals;
    const gold = visibleAwards.filter((award) => award.medal === "gold").length;
    const silver = visibleAwards.filter((award) => award.medal === "silver").length;
    const bronze = visibleAwards.filter((award) => award.medal === "bronze").length;
    return {
      gold,
      silver,
      bronze,
      show: gold + silver + bronze > 0,
    };
  }, [onBoardClass, heroMedals, visibleAwards]);

  /** Equipment stays family/owner-private (never on public / preview-public). */
  const showEquipmentSection = ownerView || hasPrivateAccess;

  // ILCA position trend (Open fleet) — shown for ILCA-only or dual-class ILCA tab
  const ilcaTrendPoints = useMemo(
    () => buildIlcaPositionTrend(ilca4Results as ProfileResult[]),
    [ilca4Results]
  );
  const showIlcaTrend =
    !onBoardClass && (primaryIsIlca || (dualClass && resultsTab === "ilca4"));
  const boardTrendPoints = useMemo(
    () => (onBoardClass ? buildIlcaPositionTrend(activeBoardResults) : []),
    [onBoardClass, activeBoardResults]
  );
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
  const trendPoints = onBoardClass
    ? boardTrendPoints
    : showIlcaTrend
      ? ilcaTrendPoints
      : optimistTrendPoints;
  const trendMode = onBoardClass || showIlcaTrend ? ("other" as const) : analytics.mode;
  const trendGoldEntry = onBoardClass || showIlcaTrend ? null : analytics.goldEntryDate;
  const trendCaption = onBoardClass
    ? ` · last 10 ${selectedClassLabel} events`
    : showIlcaTrend
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
    claimStatus !== "pending" &&
    (demoMode ? canClaim || demoRole === "public" : !isLoggedIn || canClaim);


  return {
    cardClass,
    router,
    toast,
    confirm,
    initialSailor,
    initialResults,
    initialSeriesStanding,
    initialIlcaStanding,
    canSeePrivate,
    canClaim,
    isOwner,
    isLoggedIn,
    profileClaimed,
    demoMode,
    demoRole,
    onDemoClaim,
    profileVerified,
    isPublicWeight,
    setIsPublicWeight,
    isPublicDob,
    setIsPublicDob,
    claimStatus,
    setClaimStatus,
    claimMsg,
    setClaimMsg,
    claimPanelOpen,
    setClaimPanelOpen,
    editing,
    setEditing,
    previewPublic,
    setPreviewPublic,
    saveBusy,
    saveMsg,
    expandedRegattaId,
    setExpandedRegattaId,
    observations,
    setObservations,
    obsForm,
    setObsForm,
    editingObsId,
    obsBusy,
    obsMsg,
    form,
    setForm,
    displaySailor,
    results,
    personalBusy,
    personalMsg,
    avatarBusy,
    avatarMsg,
    journey,
    journeyDraft,
    setJourneyDraft,
    journeyBusy,
    journeyMsg,
    showAllResults,
    setShowAllResults,
    optimistScope,
    setOptimistScope,
    resultsTab,
    setResultsTab,
    sectionTab,
    setSectionTab,
    dismissSailorTip,
    setDismissSailorTip,
    gearByRegatta,
    setGearByRegatta,
    ownerView,
    hasPrivateAccess,
    showWeight,
    showEquipment,
    saveProfile,
    uploadAvatar,
    resetObsForm,
    startEditObservation,
    saveObservation,
    persistJourney,
    addJourneyItem,
    removeJourneyItem,
    updateJourneyItem,
    deletePersonalResult,
    deleteObservation,
    classBuckets,
    leftOptimistYear,
    preferIlcaFirst,
    hasIlca4Data,
    fleetBadge,
    analytics,
    awards,
    awardCounts,
    heroMedals,
    dobYmd,
    bornYear,
    showFullDob,
    fullDobLabel,
    optimistResults,
    ilca4Results,
    hasIlcaResults,
    hasOptimistResults,
    dualClass,
    showOptimistScopeFilter,
    ilca4Tenure,
    ilcaKeyStats,
    optimistResultsWithSeriesDns,
    activeResultsList,
    visibleResults,
    hasMoreResults,
    seriesDnsCount,
    primaryIsIlca,
    sailDisplay,
    sailIlca4,
    boardNumber,
    noc,
    goldTenureLabel,
    goldTenureHint,
    useIlcaStats,
    ilcaStatCells,
    isSilverOnlyProfile,
    statCells,
    keyStatsTitle,
    medalTallyTitle,
    showMedals,
    activeStanding,
    standingIsIlca,
    activeBoatClass,
    onBoardClass,
    boardSummary,
    classChoices,
    hasBoardResults,
    selectedClassLabel,
    visibleAwards,
    displayMedals,
    showEquipmentSection,
    ilcaTrendPoints,
    showIlcaTrend,
    optimistTrendPoints,
    trendPoints,
    trendMode,
    trendGoldEntry,
    trendCaption,
    displayJourney,
    isUnclaimedProfile,
    showUnclaimedBanner,
  };
}
