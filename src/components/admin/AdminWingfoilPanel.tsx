"use client";

import { useMemo, useState, useRef, useEffect } from "react";
import Link from "next/link";
import {
  Upload,
  Plus,
  Trash2,
  ExternalLink,
  Download,
  Calendar,
  MapPin,
  Flame,
  FileImage,
  X,
  Eye,
  RefreshCw,
  Trophy,
  Edit3,
  Images,
  FileSpreadsheet,
  Tag,
  GitMerge,
  AlertTriangle,
  Globe,
  CheckCircle2,
} from "lucide-react";
import {
  SINGAPORE_WINGFOIL_REGATTAS,
  recalculateScoreboard,
  loadWingfoilRegattas,
  saveWingfoilRegattas,
  findMatchingWingfoilRegatta,
  fetchServerWingfoilRegattas,
  syncWingfoilToServer,
  WINGFOIL_CATEGORIES,
  WINGFOIL_OFFICIAL_DIVISIONS,
  normalizeSailorName,
  areSailNumbersMatching,
  buildHistoricalSailNumberMap,
  applyHistoricalSailNumbers,
  mergeWingfoilRegattaLists,
  deleteWingfoilFromServer,
  type WingfoilRegatta,
  type WingfoilSailorResult,
  type WingfoilRaceScore,
} from "@/lib/wingfoil";
import { readWingfoilScreenshots } from "@/lib/wingfoilScreenshot";
import { readWingfoilExcel } from "@/lib/wingfoilExcel";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";

export function AdminWingfoilPanel({ isSuperadmin = true }: { isSuperadmin?: boolean }) {
  const { toast } = useFeedback();

  // Local state for regattas initialized with official Singapore data
  const [regattas, setRegattas] = useState<WingfoilRegatta[]>(
    SINGAPORE_WINGFOIL_REGATTAS
  );
  const [selectedRegattaId, setSelectedRegattaId] = useState<string>(
    SINGAPORE_WINGFOIL_REGATTAS[0]?.id || ""
  );

  // Merge/tag modal state
  const [showMergeModal, setShowMergeModal] = useState(false);
  const [mergeTargetId, setMergeTargetId] = useState<string>("");

  // Re-hydrate from persistent storage on mount, then sync with server database
  const [isSyncingServer, setIsSyncingServer] = useState(false);
  const [lastSyncedAt, setLastSyncedAt] = useState<Date | null>(null);

  useEffect(() => {
    const loaded = loadWingfoilRegattas();
    setRegattas(loaded);
    if (loaded.length > 0 && !loaded.some((r) => r.id === selectedRegattaId)) {
      setSelectedRegattaId(loaded[0].id);
    }

    // Sync all events (including drafts and staged) from server database
    fetchServerWingfoilRegattas({ includeAll: true }).then((serverData) => {
      if (serverData && serverData.length > 0) {
        // Merge without losing any local scores
        const merged = mergeWingfoilRegattaLists(serverData, loaded);
        setRegattas(merged);
        setLastSyncedAt(new Date());

        // If local had results that weren't on server yet, sync merged to server
        const localHadExtra = loaded.some(
          (l) =>
            l.results &&
            l.results.length > 0 &&
            !serverData.some(
              (s) => s.id === l.id && s.results && s.results.length > 0
            )
        );
        if (localHadExtra) {
          syncWingfoilToServer(merged).then((res) => {
            if (res.success) setLastSyncedAt(new Date());
          });
        }
      } else if (loaded.length > 0) {
        // Auto-persist local events to server if server was unpopulated
        syncWingfoilToServer(loaded).then((res) => {
          if (res.success) setLastSyncedAt(new Date());
        });
      }
    });
  }, []);

  // Helper to update regattas, persist to localStorage, and push to central server database
  const updateRegattas = (
    updater: WingfoilRegatta[] | ((prev: WingfoilRegatta[]) => WingfoilRegatta[])
  ) => {
    setRegattas((prev) => {
      const next = typeof updater === "function" ? updater(prev) : updater;
      saveWingfoilRegattas(next);
      syncWingfoilToServer(next).then((res) => {
        if (res.success) setLastSyncedAt(new Date());
      });
      return next;
    });
  };

  // Manual trigger to sync current regattas to server for sailorpath.com
  const handleSyncToLiveSite = async () => {
    if (!isSuperadmin) {
      toast.error("403 Forbidden. Only Superadmins can sync WingFoil data.");
      return;
    }
    setIsSyncingServer(true);
    try {
      const res = await syncWingfoilToServer(regattas);
      if (res.success) {
        setLastSyncedAt(new Date());
        toast.success("Successfully synchronized all WingFoil events & scores to sailorpath.com!");
      } else {
        toast.error(`Sync warning: ${res.error || "Unable to save to database"}`);
      }
    } catch {
      toast.error("Network error during sync to live site");
    } finally {
      setIsSyncingServer(false);
    }
  };

  // Multi-image upload state
  const [uploadedPreviews, setUploadedPreviews] = useState<string[]>([]);
  const [uploadedFilenames, setUploadedFilenames] = useState<string[]>([]);
  const [showScreenshotModal, setShowScreenshotModal] = useState<boolean>(false);
  const [modalPreviewIdx, setModalPreviewIdx] = useState<number>(0);
  const [isScanningScreenshot, setIsScanningScreenshot] = useState<boolean>(false);
  const [scanProgress, setScanProgress] = useState<number>(0);
  const [scanStatus, setScanStatus] = useState<string>("");
  const [lastScanSummary, setLastScanSummary] = useState<{
    competitorCount: number;
    heatCount: number;
    regattaName: string;
  } | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  // Excel upload state
  const [isProcessingExcel, setIsProcessingExcel] = useState(false);
  const excelInputRef = useRef<HTMLInputElement>(null);

  // New competitor form state
  const [showAddEntry, setShowAddEntry] = useState(false);
  const [newEntry, setNewEntry] = useState<Partial<WingfoilSailorResult>>({
    name: "",
    sailNumber: "",
    gender: "M",
    ageCategory: "16&U",
    schoolName: "",
    club: "",
  });

  const activeRegatta = useMemo(
    () => regattas.find((r) => r.id === selectedRegattaId) || regattas[0],
    [regattas, selectedRegattaId]
  );

  const [isEditingRegatta, setIsEditingRegatta] = useState(false);
  const [regattaEditForm, setRegattaEditForm] = useState({
    name: "",
    dates: "",
    venue: "",
    organizer: "",
    format: "Sprint Slalom" as WingfoilRegatta["format"],
    scoringSystem: "",
  });

  const startEditingRegatta = () => {
    if (activeRegatta) {
      setRegattaEditForm({
        name: activeRegatta.name,
        dates: activeRegatta.dates,
        venue: activeRegatta.venue,
        organizer: activeRegatta.organizer,
        format: activeRegatta.format,
        scoringSystem: activeRegatta.scoringSystem,
      });
    }
    setIsEditingRegatta(true);
  };

  const handleSaveRegattaDetails = (e: React.FormEvent) => {
    e.preventDefault();
    if (!isSuperadmin) {
      toast.error("403 Forbidden. Only Superadmins can update WingFoil data.");
      return;
    }
    if (!activeRegatta) return;
    updateRegattas((prev) =>
      prev.map((r) =>
        r.id === activeRegatta.id
          ? {
              ...r,
              name: regattaEditForm.name.trim() || r.name,
              dates: regattaEditForm.dates.trim() || r.dates,
              venue: regattaEditForm.venue.trim() || r.venue,
              organizer: regattaEditForm.organizer.trim() || r.organizer,
              format: regattaEditForm.format,
              scoringSystem:
                regattaEditForm.scoringSystem.trim() || r.scoringSystem,
            }
          : r
      )
    );
    setIsEditingRegatta(false);
    toast.success("Updated regatta details");
  };

  // Merge/Tag active regatta results into an existing official regatta
  const handleMergeIntoEvent = (targetEventId: string) => {
    if (!isSuperadmin) {
      toast.error("403 Forbidden. Only Superadmins can update WingFoil data.");
      return;
    }
    if (!activeRegatta || !targetEventId || targetEventId === activeRegatta.id) return;

    const targetEvent = regattas.find((r) => r.id === targetEventId);
    if (!targetEvent) {
      toast.error("Target regatta not found");
      return;
    }

    // Results to attach: if activeRegatta has results, transfer/replace into target
    const resultsToApply = activeRegatta.results && activeRegatta.results.length > 0
      ? activeRegatta.results
      : targetEvent.results || [];

    updateRegattas((prev) => {
      // 1. Update target regatta with results, mark as Completed, and set lifecycleStatus to published
      const updated = prev.map((r) => {
        if (r.id === targetEventId) {
          return {
            ...r,
            status: "Completed" as const,
            lifecycleStatus: "published" as const,
            results: resultsToApply,
            scoringSystem: activeRegatta.scoringSystem || r.scoringSystem,
          };
        }
        return r;
      });

      // 2. Remove the temporary uploaded regatta if it was a dynamically uploaded one
      const cleaned = activeRegatta.id.startsWith("wingfoil-upload-")
        ? updated.filter((r) => r.id !== activeRegatta.id)
        : updated;

      return cleaned;
    });

    if (activeRegatta.id.startsWith("wingfoil-upload-")) {
      deleteWingfoilFromServer(activeRegatta.id).catch(() => {});
    }

    setSelectedRegattaId(targetEventId);
    setShowMergeModal(false);
    toast.success(
      `Successfully tagged results to "${targetEvent.name}" (${resultsToApply.length} competitor scores saved)!`
    );
  };

  const results = useMemo(
    () => activeRegatta?.results || [],
    [activeRegatta]
  );

  // Map of sailor name to historical sail numbers across other regattas
  const priorSailNumbersMap = useMemo(() => {
    return buildHistoricalSailNumberMap(regattas, activeRegatta?.id);
  }, [regattas, activeRegatta?.id]);

  // Detected sail number discrepancies for active regatta
  const discrepancies = useMemo(() => {
    if (!activeRegatta?.results) return [];
    return activeRegatta.results
      .map((sailor, idx) => {
        const norm = normalizeSailorName(sailor.name);
        const prior = priorSailNumbersMap.get(norm);
        const currentSn = sailor.sailNumber?.trim();
        const isMismatch = Boolean(
          prior &&
          currentSn &&
          currentSn !== "-" &&
          currentSn !== "—" &&
          !areSailNumbersMatching(currentSn, prior.sailNumber)
        );
        return { sailorIdx: idx, sailor, prior, isMismatch };
      })
      .filter((d) => d.isMismatch);
  }, [activeRegatta?.results, priorSailNumbersMap]);

  // Handle Category / Division change
  const handleCategoryChange = (sailorIdx: number, newCategory: string) => {
    if (!isSuperadmin) {
      toast.error("403 Forbidden. Only Superadmins can update WingFoil data.");
      return;
    }
    if (!activeRegatta) return;
    const updated = [...results];
    updated[sailorIdx] = {
      ...updated[sailorIdx],
      ageCategory: newCategory,
    };
    updateRegattas((prev) =>
      prev.map((r) =>
        r.id === activeRegatta.id ? { ...r, results: updated } : r
      )
    );
    toast.success(`Updated division for ${updated[sailorIdx].name} to "${newCategory}"`);
  };

  // Handle Sail Number change
  const handleSailNumberChange = (sailorIdx: number, newSailNumber: string) => {
    if (!isSuperadmin) {
      toast.error("403 Forbidden. Only Superadmins can update WingFoil data.");
      return;
    }
    if (!activeRegatta) return;
    const updated = [...results];
    updated[sailorIdx] = {
      ...updated[sailorIdx],
      sailNumber: newSailNumber.trim(),
    };
    updateRegattas((prev) =>
      prev.map((r) =>
        r.id === activeRegatta.id ? { ...r, results: updated } : r
      )
    );
  };

  // Bulk resolve all discrepancies by adopting prior sail numbers
  const handleResolveAllDiscrepancies = () => {
    if (!isSuperadmin) {
      toast.error("403 Forbidden. Only Superadmins can update WingFoil data.");
      return;
    }
    if (!activeRegatta || discrepancies.length === 0) return;
    const updated = [...results];
    for (const d of discrepancies) {
      if (d.prior) {
        updated[d.sailorIdx] = {
          ...updated[d.sailorIdx],
          sailNumber: d.prior.sailNumber,
        };
      }
    }
    updateRegattas((prev) =>
      prev.map((r) =>
        r.id === activeRegatta.id ? { ...r, results: updated } : r
      )
    );
    toast.success(`Resolved ${discrepancies.length} sail number discrepancies using prior regatta numbers.`);
  };

  const [isPublishing, setIsPublishing] = useState(false);

  // Toggle regatta between In-Review and Published on live site
  const handleTogglePublish = async (
    regattaId: string,
    targetStatus: "draft" | "in_review" | "published" | "archived"
  ) => {
    if (!isSuperadmin) {
      toast.error("403 Forbidden. Only Superadmins can change publication status.");
      return;
    }
    setIsPublishing(true);
    try {
      const res = await fetch(`/api/admin/regattas/${regattaId}/publish`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ targetStatus }),
      });

      const data = await res.json();
      if (!res.ok) {
        toast.error(data?.error || "Failed to update regatta lifecycle state.");
        return;
      }

      updateRegattas((prev) =>
        prev.map((r) =>
          r.id === regattaId
            ? {
                ...r,
                lifecycleStatus: targetStatus,
                status: targetStatus === "published" ? "Completed" : "Upcoming",
              }
            : r
        )
      );

      if (targetStatus === "published") {
        toast.success(`Published "${data.name || "Event"}" to live site (sailorpath.com)!`);
      } else {
        toast.info(`Moved "${data.name || "Event"}" to ${targetStatus}. Hidden from live public site.`);
      }
    } catch {
      toast.error("Network error while updating lifecycle state.");
    } finally {
      setIsPublishing(false);
    }
  };

  // Handle Screenshot Upload & Metadata Extraction (supports multiple files)
  const handleScreenshotUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!isSuperadmin) {
      toast.error("403 Forbidden. Only Superadmins can update WingFoil data.");
      return;
    }
    const fileList = e.target.files;
    if (!fileList || fileList.length === 0) return;

    const files = Array.from(fileList);

    // 1. Generate Data URL previews for all files (for thumbnail strip)
    const previewPromises = files.map(
      (f) =>
        new Promise<string>((resolve) => {
          const reader = new FileReader();
          reader.onload = (ev) => resolve(ev.target?.result as string);
          reader.readAsDataURL(f);
        })
    );
    const previews = await Promise.all(previewPromises);
    setUploadedPreviews(previews);
    setUploadedFilenames(files.map((f) => f.name));
    setModalPreviewIdx(0);

    // 2. Run OCR & Parser on all files (stitched if >1)
    setIsScanningScreenshot(true);
    setScanProgress(5);
    setScanStatus(
      files.length > 1
        ? `Preparing ${files.length} screenshots for OCR…`
        : "Analyzing scorecard with OCR…"
    );

    try {
      const parsed = await readWingfoilScreenshots(files, (p) => {
        setScanStatus(p.status);
        setScanProgress(Math.round(p.progress * 100));
      });

      let extractedResults = parsed.results;
      const { results: populatedResults, autoAssignedCount } = applyHistoricalSailNumbers(
        extractedResults,
        buildHistoricalSailNumberMap(regattas)
      );
      extractedResults = populatedResults;
      const heatCount = extractedResults[0]?.races.length || parsed.sailedCount || 9;

      setLastScanSummary({
        competitorCount: extractedResults.length,
        heatCount,
        regattaName: parsed.regattaName,
      });

      if (extractedResults.length > 0) {
        // Check if there is an existing matching official regatta (e.g. "NE Monsoon Series GP2" -> GP2)
        const matched = findMatchingWingfoilRegatta(parsed.regattaName, regattas);

        if (matched) {
          updateRegattas((prev) =>
            prev.map((r) =>
              r.id === matched.id
                ? {
                    ...r,
                    status: "Completed" as const,
                    results: extractedResults,
                    scoringSystem: `${heatCount} races, ${parsed.discardsCount ?? 1} discard`,
                  }
                : r
            )
          );
          setSelectedRegattaId(matched.id);
          toast.success(
            `OCR Results tagged & saved to official event: "${matched.name}" (${extractedResults.length} competitors, ${heatCount} heats)!`
          );
        } else {
          const newRegatta: WingfoilRegatta = {
            id: `wingfoil-upload-${Date.now()}`,
            name: parsed.regattaName || `WingFoil Regatta ${new Date().toLocaleDateString("en-SG", { day: "numeric", month: "short", year: "numeric" })}`,
            shortName: (parsed.regattaName || "WingFoil").slice(0, 20),
            dates: parsed.startDate || new Date().toLocaleDateString("en-SG", { day: "numeric", month: "long", year: "numeric" }),
            venue: "National Sailing Centre (NSC), Singapore",
            organizer: "Singapore Sailing Federation",
            format: "Sprint Slalom",
            status: "Completed",
            scoringSystem: `${heatCount} races, ${parsed.discardsCount ?? 1} discard`,
            rulesNotes:
              "Delta Buoy Slalom course, 4–5 min heat target time, 1 discard after 4+ races.",
            results: extractedResults,
          };
          updateRegattas((prev) => [newRegatta, ...prev]);
          setSelectedRegattaId(newRegatta.id);
          toast.success(
            `OCR Extracted: "${parsed.regattaName}" — ${extractedResults.length} competitors, ${heatCount} heats${files.length > 1 ? ` (from ${files.length} stitched screenshots)` : ""}!`
          );
        }
      } else {
        toast.info(
          "OCR completed, but could not detect competitor score rows. You can enter competitors manually below."
        );
      }
    } catch (err) {
      console.error("Failed to read WingFoil screenshot OCR:", err);
      toast.error(
        err instanceof Error
          ? err.message
          : "Failed to parse scorecard image. Please ensure the screenshots are clear."
      );
    } finally {
      setIsScanningScreenshot(false);
      setScanProgress(0);
      setScanStatus("");
      if (fileInputRef.current) {
        fileInputRef.current.value = "";
      }
    }
  };

  // Handle Excel / CSV upload
  const handleExcelUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!isSuperadmin) {
      toast.error("403 Forbidden. Only Superadmins can update WingFoil data.");
      return;
    }
    const file = e.target.files?.[0];
    if (!file) return;

    setIsProcessingExcel(true);
    setScanProgress(5);
    setScanStatus(`Reading ${file.name}…`);

    try {
      const parsed = await readWingfoilExcel(file, (p) => {
        setScanStatus(p.status);
        setScanProgress(Math.round(p.progress * 100));
      });

      let extractedResults = parsed.results;
      const { results: populatedResults, autoAssignedCount } = applyHistoricalSailNumbers(
        extractedResults,
        buildHistoricalSailNumberMap(regattas)
      );
      extractedResults = populatedResults;
      const heatCount = extractedResults[0]?.races.length || parsed.sailedCount || 9;

      setLastScanSummary({
        competitorCount: extractedResults.length,
        heatCount,
        regattaName: parsed.regattaName,
      });

      if (extractedResults.length > 0) {
        // Check if there is an existing matching official regatta (e.g. "NE Monsoon Series GP2" matches "2026 Northeast Monsoon Grand Prix 2")
        const matched = findMatchingWingfoilRegatta(parsed.regattaName, regattas);

        if (matched) {
          updateRegattas((prev) =>
            prev.map((r) =>
              r.id === matched.id
                ? {
                    ...r,
                    status: "Completed" as const,
                    lifecycleStatus: "published" as const,
                    results: extractedResults,
                    scoringSystem: `${heatCount} races, ${parsed.discardsCount ?? 1} discard`,
                  }
                : r
            )
          );
          setSelectedRegattaId(matched.id);
          toast.success(
            `Excel Results tagged & saved to official event: "${matched.name}" (${extractedResults.length} competitors, ${heatCount} races)!`
          );
        } else {
          const newRegatta: WingfoilRegatta = {
            id: `wingfoil-upload-${Date.now()}`,
            name: parsed.regattaName || `WingFoil Regatta ${new Date().toLocaleDateString("en-SG", { day: "numeric", month: "short", year: "numeric" })}`,
            shortName: (parsed.regattaName || "WingFoil").slice(0, 20),
            dates: parsed.startDate || new Date().toLocaleDateString("en-SG", { day: "numeric", month: "long", year: "numeric" }),
            venue: "National Sailing Centre (NSC), Singapore",
            organizer: "Singapore Sailing Federation",
            format: "Sprint Slalom",
            status: "Completed",
            lifecycleStatus: "published",
            scoringSystem: `${heatCount} races, ${parsed.discardsCount ?? 1} discard`,
            rulesNotes:
              "Delta Buoy Slalom course, 4–5 min heat target time, 1 discard after 4+ races.",
            results: extractedResults,
          };
          updateRegattas((prev) => [newRegatta, ...prev]);
          setSelectedRegattaId(newRegatta.id);
          toast.success(
            `Excel Imported & Saved: "${parsed.regattaName}" — ${extractedResults.length} competitors, ${heatCount} races!`
          );
        }
      } else {
        toast.info(
          "Excel parsed, but no competitor rows found. Check that the file uses standard Sailwave export format."
        );
      }
    } catch (err) {
      console.error("Failed to parse WingFoil Excel:", err);
      toast.error(
        err instanceof Error
          ? err.message
          : "Failed to parse the spreadsheet. Ensure it is a standard Sailwave .xlsx or .csv export."
      );
    } finally {
      setIsProcessingExcel(false);
      setScanProgress(0);
      setScanStatus("");
      if (excelInputRef.current) {
        excelInputRef.current.value = "";
      }
    }
  };

  // Helper to get active discards count
  const activeDiscardsCount = useMemo(() => {
    if (!activeRegatta?.scoringSystem) return undefined;
    const match = activeRegatta.scoringSystem.match(/(\d+)\s*discard/i);
    return match ? parseInt(match[1], 10) : undefined;
  }, [activeRegatta]);

  // Update a single heat score for a competitor
  const handleScoreChange = (
    sailorIndex: number,
    raceIndex: number,
    valStr: string,
    codeStr?: string
  ) => {
    if (!activeRegatta) return;
    const currentResults = [...(activeRegatta.results || [])];
    const sailor = { ...currentResults[sailorIndex] };
    const races: WingfoilRaceScore[] = [...sailor.races];

    const numScore = valStr === "" ? 8 : Number(valStr);
    const code = (codeStr as WingfoilRaceScore["code"]) || undefined;

    races[raceIndex] = {
      score: isNaN(numScore) ? 8 : numScore,
      code: code || undefined,
    };

    sailor.races = races;
    currentResults[sailorIndex] = sailor;

    // Recalculate scoreboard discards and rankings
    const updatedScoreboard = recalculateScoreboard(currentResults, activeDiscardsCount);

    updateRegattas((prev) =>
      prev.map((r) =>
        r.id === activeRegatta.id ? { ...r, results: updatedScoreboard } : r
      )
    );
  };

  // Add a new competitor
  const handleAddCompetitor = (e: React.FormEvent) => {
    e.preventDefault();
    if (!newEntry.name || !newEntry.sailNumber) {
      toast.error("Name and Sail Number are required");
      return;
    }

    const defaultRaces: WingfoilRaceScore[] = Array.from({ length: 9 }, () => ({
      score: 8,
      code: "DNF",
    }));

    const competitor: WingfoilSailorResult = {
      rank: results.length + 1,
      name: newEntry.name.trim(),
      sailNumber: newEntry.sailNumber.trim(),
      gender: newEntry.gender || "M",
      ageCategory: newEntry.ageCategory || "16&U",
      schoolName: newEntry.schoolName?.trim() || "—",
      club: newEntry.club?.trim() || "—",
      races: defaultRaces,
      grossScore: 72,
      nettScore: 64,
    };

    const updatedScoreboard = recalculateScoreboard([...results, competitor]);

    updateRegattas((prev) =>
      prev.map((r) =>
        r.id === activeRegatta.id ? { ...r, results: updatedScoreboard } : r
      )
    );

    setNewEntry({
      name: "",
      sailNumber: "",
      gender: "M",
      ageCategory: "16&U",
      schoolName: "",
      club: "",
    });
    setShowAddEntry(false);
    toast.success(`Added entry for ${competitor.name}`);
  };

  // Delete competitor
  const handleDeleteCompetitor = (name: string) => {
    if (!confirm(`Delete competitor ${name} from this regatta?`)) return;
    const filtered = results.filter((s) => s.name !== name);
    const updated = recalculateScoreboard(filtered);

    updateRegattas((prev) =>
      prev.map((r) =>
        r.id === activeRegatta.id ? { ...r, results: updated } : r
      )
    );
    toast.success(`Removed competitor ${name}`);
  };

  // Export results as CSV
  const handleExportCsv = () => {
    if (!results.length) {
      toast.error("No results to export");
      return;
    }

    const maxRaces = Math.max(
      results.reduce((max, s) => Math.max(max, s.races?.length || 0), 0),
      9
    );

    const raceHeaders = Array.from({ length: maxRaces }, (_, i) => `R${i + 1}`);

    const headers = [
      "Rank",
      "Sail Number",
      "Name",
      "Gender",
      "Category",
      "School",
      "Club",
      ...raceHeaders,
      "Gross",
      "Nett",
    ];

    const rows = results.map((s) => [
      s.rank,
      `"${s.sailNumber}"`,
      `"${s.name}"`,
      s.gender,
      `"${s.ageCategory}"`,
      `"${s.schoolName}"`,
      `"${s.club}"`,
      ...Array.from({ length: maxRaces }, (_, i) => {
        const r = s.races[i];
        if (!r) return "";
        return r.code ? `"${r.score} (${r.code})"` : r.score;
      }),
      s.grossScore,
      s.nettScore,
    ]);

    const csvContent =
      "data:text/csv;charset=utf-8," +
      [headers.join(","), ...rows.map((e) => e.join(","))].join("\n");

    const encodedUri = encodeURI(csvContent);
    const link = document.createElement("a");
    link.setAttribute("href", encodedUri);
    link.setAttribute(
      "download",
      `${activeRegatta?.shortName || "WingFoil"}_Results.csv`
    );
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    toast.success("Downloaded results CSV");
  };

  return (
    <div className="w-full min-w-0 space-y-6">
      {/* Top Header & Fast Actions */}
      <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-4 glass-panel rounded-3xl p-6 border border-white/5 bg-[#131520]">
        <div>
          <div className="flex items-center gap-2">
            <span className="flex h-6 w-6 items-center justify-center rounded-lg bg-orange-500/20 text-orange-400">
              <Flame className="h-4 w-4" />
            </span>
            <h2 className="text-lg font-black text-white tracking-tight">
              WingFoil Results & Regatta Manager
            </h2>
            <span className="rounded-full bg-emerald-500/10 border border-emerald-500/20 px-2.5 py-0.5 text-[10px] font-bold text-emerald-400">
              Sprint Slalom
            </span>
            {lastSyncedAt && (
              <span className="hidden sm:inline-flex items-center gap-1 text-[10px] text-sky-400 bg-sky-500/10 border border-sky-500/20 px-2.5 py-0.5 rounded-full font-semibold">
                <CheckCircle2 className="w-3 h-3 text-sky-400" />
                Live Sync Active
              </span>
            )}
          </div>
        </div>

        <div className="flex flex-wrap items-center gap-2">
          {/* Screenshot Upload Button */}
          <input
            ref={fileInputRef}
            type="file"
            accept="image/*"
            multiple
            onChange={handleScreenshotUpload}
            className="hidden"
          />
          <button
            type="button"
            disabled={isScanningScreenshot}
            onClick={() => fileInputRef.current?.click()}
            className="inline-flex items-center gap-1.5 rounded-full border border-orange-500/30 bg-orange-500/10 hover:bg-orange-500/20 disabled:opacity-50 px-4 py-2 text-xs font-bold text-orange-300 transition-all shadow-sm cursor-pointer"
          >
            {isScanningScreenshot ? (
              <>
                <RefreshCw className="h-3.5 w-3.5 animate-spin text-orange-400" />
                Scanning Scorecard…
              </>
            ) : (
              <>
                <Images className="h-3.5 w-3.5 text-orange-400" />
                Upload Screenshots
              </>
            )}
          </button>

          {/* Excel / CSV Upload */}
          <input
            ref={excelInputRef}
            type="file"
            accept=".xlsx,.xls,.csv"
            onChange={handleExcelUpload}
            className="hidden"
          />
          <button
            type="button"
            disabled={isProcessingExcel || isScanningScreenshot}
            onClick={() => excelInputRef.current?.click()}
            className="inline-flex items-center gap-1.5 rounded-full border border-emerald-500/30 bg-emerald-500/10 hover:bg-emerald-500/20 disabled:opacity-50 px-4 py-2 text-xs font-bold text-emerald-300 transition-all shadow-sm cursor-pointer"
          >
            {isProcessingExcel ? (
              <>
                <RefreshCw className="h-3.5 w-3.5 animate-spin text-emerald-400" />
                Importing Excel…
              </>
            ) : (
              <>
                <FileSpreadsheet className="h-3.5 w-3.5 text-emerald-400" />
                Import Excel / CSV
              </>
            )}
          </button>

          {/* Export CSV */}
          <button
            type="button"
            onClick={handleExportCsv}
            className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 hover:bg-white/10 px-4 py-2 text-xs font-bold text-slate-300 transition-all"
          >
            <Download className="h-3.5 w-3.5 text-slate-400" />
            Export CSV
          </button>

          {/* Sync to Live Site (sailorpath.com) */}
          <button
            type="button"
            disabled={isSyncingServer}
            onClick={handleSyncToLiveSite}
            className="inline-flex items-center gap-1.5 rounded-full border border-sky-500/30 bg-sky-500/10 hover:bg-sky-500/20 disabled:opacity-50 px-4 py-2 text-xs font-bold text-sky-300 transition-all cursor-pointer"
            title="Persist all WingFoil regattas and scores to server database so they immediately appear on sailorpath.com"
          >
            {isSyncingServer ? (
              <>
                <RefreshCw className="h-3.5 w-3.5 animate-spin text-sky-400" />
                Syncing…
              </>
            ) : (
              <>
                <Globe className="h-3.5 w-3.5 text-sky-400" />
                Sync to Live Site
              </>
            )}
          </button>

          {/* View Live Public Page */}
          <Link
            href="/sg/wingfoil"
            target="_blank"
            className="inline-flex items-center gap-1.5 rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white transition-all shadow-lg shadow-orange-950/40"
          >
            <ExternalLink className="h-3.5 w-3.5" />
            View Public Hub
          </Link>
        </div>
      </div>

      {/* Progress Card — shown for both screenshot OCR and Excel import */}
      {(isScanningScreenshot || isProcessingExcel) && (
        <div className={`glass-panel rounded-2xl p-5 border space-y-2.5 ${
          isProcessingExcel
            ? "border-emerald-500/30 bg-emerald-500/[0.08]"
            : "border-orange-500/30 bg-orange-500/[0.08]"
        }`}>
          <div className={`flex items-center justify-between text-xs font-bold ${
            isProcessingExcel ? "text-emerald-200" : "text-orange-200"
          }`}>
            <div className="flex items-center gap-2">
              <RefreshCw className={`h-4 w-4 animate-spin shrink-0 ${
                isProcessingExcel ? "text-emerald-400" : "text-orange-400"
              }`} />
              <span>{scanStatus || (isProcessingExcel ? "Parsing spreadsheet…" : "Analyzing screenshot with OCR…")}</span>
            </div>
            <span className={`tabular-nums font-mono ${isProcessingExcel ? "text-emerald-300" : "text-orange-300"}`}>
              {scanProgress}%
            </span>
          </div>
          <div className="h-2 w-full rounded-full bg-black/40 overflow-hidden">
            <div
              className={`h-full transition-all duration-300 rounded-full bg-gradient-to-r ${
                isProcessingExcel
                  ? "from-emerald-500 to-teal-400"
                  : "from-orange-500 to-amber-400"
              }`}
              style={{ width: `${scanProgress}%` }}
            />
          </div>
          <p className={`text-[11px] ${isProcessingExcel ? "text-emerald-300/70" : "text-orange-300/70"}`}>
            {isProcessingExcel
              ? "Reading Excel columns — Pos, HelmName, SailNo, R1…Rn, Total, Nett…"
              : uploadedPreviews.length > 1
                ? `Upscaling & stitching ${uploadedPreviews.length} screenshots, then running a single OCR pass…`
                : "Upscaling image, isolating podium heat score boxes, and parsing Sailwave table columns…"}
          </p>
        </div>
      )}

      {/* Multi-image thumbnail strip (after upload, not scanning) */}
      {uploadedPreviews.length > 0 && !isScanningScreenshot && (
        <div className="glass-panel rounded-2xl p-4 border border-orange-500/20 bg-orange-500/[0.04] space-y-3">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <FileImage className="h-4 w-4 text-orange-400 shrink-0" />
              <span className="text-xs font-bold text-white">
                {uploadedPreviews.length === 1
                  ? uploadedFilenames[0] || "Uploaded Screenshot"
                  : `${uploadedPreviews.length} screenshots uploaded`}
              </span>
              {lastScanSummary ? (
                <span className="rounded bg-emerald-500/20 text-emerald-300 text-[9px] font-bold px-1.5 py-0.5">
                  OCR: {lastScanSummary.competitorCount} competitors · {lastScanSummary.heatCount} heats
                  {uploadedPreviews.length > 1 ? ` · ${uploadedPreviews.length} images stitched` : ""}
                </span>
              ) : (
                <span className="rounded bg-emerald-500/20 text-emerald-300 text-[9px] font-bold px-1.5 py-0.5">
                  Scorecard Loaded
                </span>
              )}
            </div>
            <div className="flex items-center gap-2 shrink-0">
              <button
                type="button"
                onClick={() => fileInputRef.current?.click()}
                className="px-3 py-1.5 rounded-full border border-orange-500/30 bg-orange-500/10 text-xs font-semibold text-orange-300 hover:bg-orange-500/20 flex items-center gap-1.5"
              >
                <RefreshCw className="h-3 w-3" />
                Re-upload
              </button>
              <button
                type="button"
                onClick={() => {
                  setUploadedPreviews([]);
                  setUploadedFilenames([]);
                  setLastScanSummary(null);
                }}
                className="p-1.5 rounded-full text-slate-500 hover:text-rose-400 hover:bg-rose-500/10"
                title="Dismiss previews"
              >
                <X className="h-4 w-4" />
              </button>
            </div>
          </div>

          {/* Thumbnail strip */}
          <div className="flex gap-2 overflow-x-auto pb-1">
            {uploadedPreviews.map((src, idx) => (
              <div
                key={idx}
                onClick={() => { setModalPreviewIdx(idx); setShowScreenshotModal(true); }}
                className="relative shrink-0 h-20 w-32 rounded-lg overflow-hidden border border-white/10 bg-black/40 cursor-pointer group"
              >
                {/* eslint-disable-next-line @next/next/no-img-element */}
                <img
                  src={src}
                  alt={`Screenshot ${idx + 1}`}
                  className="h-full w-full object-cover group-hover:scale-105 transition-transform"
                />
                <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 flex items-center justify-center transition-opacity">
                  <Eye className="h-4 w-4 text-white" />
                </div>
                <span className="absolute bottom-1 right-1 rounded bg-black/70 px-1 py-0.5 text-[9px] font-bold text-white">
                  {idx + 1}/{uploadedPreviews.length}
                </span>
              </div>
            ))}
          </div>
          <p className="text-[11px] text-slate-400">
            {uploadedPreviews.length > 1
              ? "All screenshots were stitched vertically before OCR — no rows are cut off. Review or edit any score directly below."
              : "Competitors, sail numbers, and race heats populated into the heat scoreboard below. Review or edit any score directly."}
          </p>
        </div>
      )}

      {/* Fullscreen screenshot modal with prev/next navigation */}
      {showScreenshotModal && uploadedPreviews.length > 0 && (
        <div
          className="fixed inset-0 z-50 bg-black/80 flex items-center justify-center p-4"
          onClick={() => setShowScreenshotModal(false)}
        >
          <div
            className="relative max-w-4xl w-full max-h-[90vh] flex flex-col items-center gap-3"
            onClick={(e) => e.stopPropagation()}
          >
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img
              src={uploadedPreviews[modalPreviewIdx]}
              alt={`Screenshot ${modalPreviewIdx + 1}`}
              className="max-h-[80vh] w-auto rounded-xl border border-white/10 object-contain"
            />
            <div className="flex items-center gap-3">
              {uploadedPreviews.length > 1 && (
                <button
                  type="button"
                  onClick={() => setModalPreviewIdx((i) => Math.max(0, i - 1))}
                  disabled={modalPreviewIdx === 0}
                  className="px-3 py-1.5 rounded-full bg-white/10 hover:bg-white/20 text-xs font-bold text-white disabled:opacity-30"
                >
                  ← Prev
                </button>
              )}
              <span className="text-xs text-slate-400 font-semibold">
                {uploadedFilenames[modalPreviewIdx] || `Image ${modalPreviewIdx + 1}`}
                {uploadedPreviews.length > 1 && ` (${modalPreviewIdx + 1} of ${uploadedPreviews.length})`}
              </span>
              {uploadedPreviews.length > 1 && (
                <button
                  type="button"
                  onClick={() => setModalPreviewIdx((i) => Math.min(uploadedPreviews.length - 1, i + 1))}
                  disabled={modalPreviewIdx === uploadedPreviews.length - 1}
                  className="px-3 py-1.5 rounded-full bg-white/10 hover:bg-white/20 text-xs font-bold text-white disabled:opacity-30"
                >
                  Next →
                </button>
              )}
              <button
                type="button"
                onClick={() => setShowScreenshotModal(false)}
                className="px-3 py-1.5 rounded-full bg-rose-500/20 border border-rose-500/30 text-xs font-bold text-rose-300 hover:bg-rose-500/30"
              >
                Close
              </button>
            </div>
          </div>
        </div>
      )}


      {/* Sticky Lifecycle Action Bar for Active Regatta */}
      {activeRegatta && (
        <div className="sticky top-4 z-20 flex flex-wrap items-center justify-between gap-3 px-5 py-3.5 rounded-2xl border border-white/10 bg-[#141624]/95 backdrop-blur-md shadow-2xl">
          <div className="flex flex-wrap items-center gap-3">
            <span className="text-xs text-slate-400 font-semibold">Lifecycle Status:</span>
            {(() => {
              const status = (activeRegatta as any).lifecycleStatus || (activeRegatta.status === "Completed" ? "published" : "in_review");
              const isPublished = status === "published";
              const isInReview = status === "in_review";

              return (
                <div className="flex flex-wrap items-center gap-2">
                  <span
                    className={`inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-black uppercase tracking-wider ${
                      isPublished
                        ? "bg-emerald-500/20 text-emerald-300 border border-emerald-500/30"
                        : isInReview
                        ? "bg-amber-500/20 text-amber-300 border border-amber-500/30"
                        : "bg-slate-500/20 text-slate-300 border border-slate-500/30"
                    }`}
                  >
                    <span
                      className={`h-2 w-2 rounded-full ${
                        isPublished
                          ? "bg-emerald-400 animate-pulse"
                          : isInReview
                          ? "bg-amber-400"
                          : "bg-slate-400"
                      }`}
                    />
                    {isPublished ? "Published" : isInReview ? "In Review" : "Draft"}
                  </span>
                  <span className="text-xs text-slate-400 font-medium">
                    {isPublished
                      ? "• Live on sailorpath.com for all public visitors"
                      : "• Staged in Admin Cockpit only (hidden from public site)"}
                  </span>
                </div>
              );
            })()}
          </div>

          <div className="flex items-center gap-2.5">
            {(() => {
              const isPublished = (activeRegatta as any).lifecycleStatus === "published" || activeRegatta.status === "Completed";
              return (
                <>
                  <button
                    type="button"
                    disabled={isPublishing}
                    onClick={() =>
                      handleTogglePublish(
                        activeRegatta.id,
                        isPublished ? "in_review" : "published"
                      )
                    }
                    className={`inline-flex items-center gap-1.5 px-4 py-2 rounded-full text-xs font-black tracking-wide transition-all cursor-pointer ${
                      isPublished
                        ? "bg-amber-500/10 hover:bg-amber-500/20 text-amber-300 border border-amber-500/30"
                        : "bg-emerald-600 hover:bg-emerald-500 text-white shadow-lg shadow-emerald-950/50"
                    }`}
                  >
                    {isPublishing ? (
                      <>
                        <RefreshCw className="h-3.5 w-3.5 animate-spin" />
                        Updating Status…
                      </>
                    ) : isPublished ? (
                      <>Unpublish to In-Review</>
                    ) : (
                      <>
                        <CheckCircle2 className="h-3.5 w-3.5" />
                        Publish to Live Site
                      </>
                    )}
                  </button>

                  <Link
                    href="/sg/wingfoil"
                    target="_blank"
                    className="inline-flex items-center gap-1.5 text-xs font-bold text-slate-300 hover:text-white px-3.5 py-2 rounded-full border border-white/10 hover:border-white/20 bg-white/5 transition-all cursor-pointer"
                  >
                    <Eye className="h-3.5 w-3.5 text-slate-400" />
                    Preview Live Hub
                  </Link>
                </>
              );
            })()}
          </div>
        </div>
      )}

      {/* Regatta Selector & Event Metadata */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
        {/* Event Details Card */}
        <div className="lg:col-span-4 glass-panel rounded-3xl p-6 border border-white/5 space-y-4">
          <div className="flex items-center justify-between">
            <label className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">
              Selected WingFoil Regatta
            </label>
            <button
              type="button"
              onClick={() =>
                isEditingRegatta
                  ? setIsEditingRegatta(false)
                  : startEditingRegatta()
              }
              className="inline-flex items-center gap-1 text-[10px] font-bold text-orange-400 hover:text-orange-300 bg-orange-500/10 hover:bg-orange-500/20 px-2.5 py-1 rounded-full border border-orange-500/20 transition-all"
            >
              <Edit3 className="h-3 w-3" />
              {isEditingRegatta ? "Cancel" : "Edit Details"}
            </button>
          </div>

          <select
            value={selectedRegattaId}
            onChange={(e) => {
              setSelectedRegattaId(e.target.value);
              setIsEditingRegatta(false);
            }}
            className="w-full rounded-xl border border-white/10 bg-slate-950 px-3.5 py-2.5 text-xs font-bold text-white focus:border-orange-500/40"
          >
            {regattas.map((r) => (
              <option key={r.id} value={r.id}>
                {r.name} ({r.dates})
              </option>
            ))}
          </select>

          {isEditingRegatta ? (
            <form onSubmit={handleSaveRegattaDetails} className="space-y-3 pt-3 border-t border-white/5 text-xs">
              <div>
                <label className="text-[10px] font-bold text-slate-500 uppercase">
                  Regatta Name
                </label>
                <input
                  type="text"
                  required
                  value={regattaEditForm.name}
                  onChange={(e) =>
                    setRegattaEditForm({ ...regattaEditForm, name: e.target.value })
                  }
                  className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                />
              </div>

              <div>
                <label className="text-[10px] font-bold text-slate-500 uppercase">
                  Date
                </label>
                <input
                  type="text"
                  required
                  value={regattaEditForm.dates}
                  onChange={(e) =>
                    setRegattaEditForm({ ...regattaEditForm, dates: e.target.value })
                  }
                  placeholder="e.g. 5–7 September 2026"
                  className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                />
              </div>

              <div>
                <label className="text-[10px] font-bold text-slate-500 uppercase">
                  Venue
                </label>
                <input
                  type="text"
                  required
                  value={regattaEditForm.venue}
                  onChange={(e) =>
                    setRegattaEditForm({ ...regattaEditForm, venue: e.target.value })
                  }
                  placeholder="e.g. National Sailing Centre (NSC), Singapore"
                  className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                />
              </div>

              <div>
                <label className="text-[10px] font-bold text-slate-500 uppercase">
                  Organiser
                </label>
                <input
                  type="text"
                  required
                  value={regattaEditForm.organizer}
                  onChange={(e) =>
                    setRegattaEditForm({ ...regattaEditForm, organizer: e.target.value })
                  }
                  placeholder="e.g. Singapore Sailing Federation (SSF)"
                  className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                />
              </div>

              <div className="grid grid-cols-2 gap-2">
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase">
                    Format
                  </label>
                  <select
                    value={regattaEditForm.format}
                    onChange={(e) =>
                      setRegattaEditForm({
                        ...regattaEditForm,
                        format: e.target.value as WingfoilRegatta["format"],
                      })
                    }
                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-2.5 py-2 text-white text-xs"
                  >
                    <option value="Sprint Slalom">Sprint Slalom</option>
                    <option value="Course Race">Course Race</option>
                    <option value="Marathon">Marathon</option>
                    <option value="Slalom / Course / Marathon">Slalom / Course / Marathon</option>
                  </select>
                </div>
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase">
                    Scoring
                  </label>
                  <input
                    type="text"
                    required
                    value={regattaEditForm.scoringSystem}
                    onChange={(e) =>
                      setRegattaEditForm({
                        ...regattaEditForm,
                        scoringSystem: e.target.value,
                      })
                    }
                    placeholder="e.g. 9 races, 1 discard"
                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-2.5 py-2 text-white text-xs"
                  />
                </div>
              </div>

              <div className="flex justify-end gap-2 pt-2">
                <button
                  type="button"
                  onClick={() => setIsEditingRegatta(false)}
                  className="rounded-full px-3 py-1.5 text-xs font-bold text-slate-400 hover:text-white"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-1.5 text-xs font-bold text-white shadow-md shadow-orange-950/40"
                >
                  Save Details
                </button>
              </div>
            </form>
          ) : (
            activeRegatta && (
              <div className="space-y-3 pt-3 border-t border-white/5 text-xs">
                <div className="flex items-start gap-2">
                  <Calendar className="h-4 w-4 text-slate-400 mt-0.5 shrink-0" />
                  <div>
                    <span className="text-[10px] font-bold text-slate-500 uppercase block">
                      Dates
                    </span>
                    <span className="font-semibold text-slate-200">
                      {activeRegatta.dates}
                    </span>
                  </div>
                </div>

                <div className="flex items-start gap-2">
                  <MapPin className="h-4 w-4 text-slate-400 mt-0.5 shrink-0" />
                  <div>
                    <span className="text-[10px] font-bold text-slate-500 uppercase block">
                      Venue &amp; Organiser
                    </span>
                    <span className="font-semibold text-slate-200">
                      {activeRegatta.venue}
                    </span>
                    <span className="text-[10px] text-slate-400 block mt-0.5">
                      {activeRegatta.organizer}
                    </span>
                  </div>
                </div>

                <div className="flex items-start gap-2">
                  <Trophy className="h-4 w-4 text-orange-400 mt-0.5 shrink-0" />
                  <div>
                    <span className="text-[10px] font-bold text-slate-500 uppercase block">
                      Format &amp; Scoring
                    </span>
                    <span className="font-semibold text-orange-300">
                      {activeRegatta.format} · {activeRegatta.scoringSystem}
                    </span>
                    {activeRegatta.rulesNotes && (
                      <p className="text-[10px] text-slate-400 mt-0.5 leading-snug">
                        {activeRegatta.rulesNotes}
                      </p>
                    )}
                  </div>
                </div>
              </div>
            )
          )}

          <button
            type="button"
            onClick={() => setShowAddEntry(true)}
            className="w-full flex items-center justify-center gap-2 rounded-xl bg-orange-600/90 hover:bg-orange-500 px-4 py-2.5 text-xs font-bold text-white transition-all shadow-md shadow-orange-950/40"
          >
            <Plus className="h-4 w-4" />
            Add Competitor Entry
          </button>

          {/* Merge or Tag into Official Event */}
          <button
            type="button"
            onClick={() => {
              // Pre-select closest matching regatta or first other regatta
              const match = findMatchingWingfoilRegatta(
                activeRegatta?.name || "",
                regattas.filter((r) => r.id !== activeRegatta?.id)
              );
              setMergeTargetId(match?.id || regattas.find((r) => r.id !== activeRegatta?.id)?.id || "");
              setShowMergeModal(true);
            }}
            className="w-full flex items-center justify-center gap-2 rounded-xl border border-sky-500/30 bg-sky-500/10 hover:bg-sky-500/20 px-4 py-2 text-xs font-bold text-sky-300 transition-all shadow-sm"
          >
            <GitMerge className="h-3.5 w-3.5" />
            Tag / Merge to Another Event
          </button>

          {/* If custom or uploaded event, allow deleting */}
          {activeRegatta && activeRegatta.id.startsWith("wingfoil-upload-") && (
            <button
              type="button"
              onClick={() => {
                if (!confirm(`Delete uploaded event "${activeRegatta.name}"?`)) return;
                updateRegattas((prev) => prev.filter((r) => r.id !== activeRegatta.id));
                setSelectedRegattaId(regattas.find((r) => r.id !== activeRegatta.id)?.id || "");
                toast.success("Event removed");
              }}
              className="w-full flex items-center justify-center gap-1.5 rounded-xl border border-rose-500/20 bg-rose-500/5 hover:bg-rose-500/15 px-3 py-1.5 text-[11px] font-semibold text-rose-400 transition-colors"
            >
              <Trash2 className="h-3 w-3" />
              Delete Uploaded Event
            </button>
          )}
        </div>

        {/* Scoreboard Table */}
        {(() => {
          const totalRacesCount = Math.max(
            results.reduce((max, s) => Math.max(max, s.races?.length || 0), 0),
            9
          );

          return (
            <div className="lg:col-span-8 glass-panel rounded-3xl border border-white/5 overflow-hidden flex flex-col">
              <div className="p-4 sm:p-5 border-b border-white/5 flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-slate-900/30">
                <div>
                  <h3 className="text-sm font-bold text-white flex items-center gap-2">
                    Heat Scoreboard (R1 – R{totalRacesCount})
                    <span className="rounded-full bg-white/10 px-2 py-0.5 text-[10px] font-bold text-slate-300">
                      {results.length} Competitors
                    </span>
                  </h3>
                  <p className="text-[11px] text-slate-400 mt-0.5">
                    Strikethrough values indicate discarded worst races (Appendix A). Click any cell to adjust position or scoring code.
                  </p>
                </div>
                <button
                  type="button"
                  onClick={() => {
                    const updated = recalculateScoreboard(results, activeDiscardsCount);
                    updateRegattas((prev) =>
                      prev.map((r) =>
                        r.id === activeRegatta.id ? { ...r, results: updated } : r
                      )
                    );
                    toast.success("Recalculated Appendix A discards & ranks!");
                  }}
                  className="inline-flex items-center gap-1 text-[11px] font-bold text-orange-400 hover:text-orange-300 bg-orange-500/10 px-3 py-1.5 rounded-full border border-orange-500/20 shrink-0 cursor-pointer"
                >
                  <RefreshCw className="h-3 w-3" />
                  Recalculate Discards
                </button>
              </div>

              {/* Sail Number Discrepancy Banner */}
              {discrepancies.length > 0 && (
                <div className="flex flex-wrap items-center justify-between gap-3 p-3 rounded-xl bg-amber-500/10 border border-amber-500/30 text-amber-300 text-xs">
                  <div className="flex items-center gap-2 font-medium">
                    <AlertTriangle className="w-4 h-4 text-amber-400 shrink-0" />
                    <span>
                      <strong>{discrepancies.length} Sail Number {discrepancies.length === 1 ? "Discrepancy" : "Discrepancies"} Flagged:</strong>{" "}
                      {discrepancies.length === 1
                        ? "1 competitor has a different sail number than in prior regattas. Review highlighted row below."
                        : `${discrepancies.length} competitors have different sail numbers than in prior regattas. Review highlighted rows below.`}
                    </span>
                  </div>
                  <button
                    type="button"
                    onClick={handleResolveAllDiscrepancies}
                    className="px-3 py-1.5 rounded-lg bg-amber-500 hover:bg-amber-400 text-slate-950 font-bold text-xs transition-colors shadow-sm cursor-pointer"
                  >
                    Resolve All with Prior Sail #s ({discrepancies.length})
                  </button>
                </div>
              )}

              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs text-slate-300">
                  <thead className="bg-[#11131c] text-[10px] font-black uppercase text-slate-400 border-b border-white/5">
                    <tr>
                      <th className="px-3 py-3 w-10 text-center">Rank</th>
                      <th className="px-3 py-3 min-w-[110px]">Sail #</th>
                      <th className="px-3 py-3">Competitor</th>
                      <th className="px-2 py-3 min-w-[110px]">Cat</th>
                      {Array.from({ length: totalRacesCount }).map((_, i) => (
                        <th key={i} className="px-1.5 py-3 w-12 text-center">
                          R{i + 1}
                        </th>
                      ))}
                      <th className="px-2.5 py-3 w-12 text-center font-bold">Gross</th>
                      <th className="px-2.5 py-3 w-12 text-center font-black text-orange-400">Nett</th>
                      <th className="px-2 py-3 w-10 text-center">Action</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-white/5 font-medium text-xs">
                    {results.length === 0 ? (
                      <tr>
                        <td colSpan={totalRacesCount + 7} className="px-6 py-12 text-center text-slate-500">
                          No competitors entered yet. Click &ldquo;Add Competitor Entry&rdquo; or upload a results screenshot.
                        </td>
                      </tr>
                    ) : (
                      results.map((sailor, sailorIdx) => (
                        <tr
                          key={`${sailor.name}-${sailor.sailNumber}`}
                          className="hover:bg-white/[0.02] transition-colors"
                        >
                          <td className="px-3 py-3 text-center">
                            <RankMedalBadge rank={sailor.rank} />
                          </td>
                          <td className="px-3 py-2.5">
                            {(() => {
                              const normName = normalizeSailorName(sailor.name);
                              const prior = priorSailNumbersMap.get(normName);
                              const currentSn = sailor.sailNumber?.trim();
                              const isMismatch = Boolean(
                                prior &&
                                currentSn &&
                                currentSn !== "-" &&
                                currentSn !== "—" &&
                                !areSailNumbersMatching(currentSn, prior.sailNumber)
                              );

                              return (
                                <div className="flex flex-col gap-1">
                                  <input
                                    type="text"
                                    value={sailor.sailNumber}
                                    onChange={(e) =>
                                      handleSailNumberChange(sailorIdx, e.target.value)
                                    }
                                    className={`w-20 bg-slate-950 border px-2 py-1 rounded font-mono text-xs font-bold text-white transition-colors ${
                                      isMismatch
                                        ? "border-amber-500 bg-amber-500/10 text-amber-200 focus:border-amber-400"
                                        : "border-white/10 hover:border-white/25 focus:border-cyan-400"
                                    }`}
                                    placeholder="Sail #"
                                  />
                                  {isMismatch && prior && (
                                    <div className="flex items-center gap-1">
                                      <span
                                        className="text-[10px] text-amber-400 font-semibold truncate max-w-[110px]"
                                        title={`Prior regatta (${prior.regattaName}): ${prior.sailNumber}`}
                                      >
                                        Prior: #{prior.sailNumber}
                                      </span>
                                      <button
                                        type="button"
                                        onClick={() =>
                                          handleSailNumberChange(sailorIdx, prior.sailNumber)
                                        }
                                        className="text-[9px] font-bold px-1.5 py-0.5 rounded bg-amber-500/20 hover:bg-amber-500/40 text-amber-300 border border-amber-500/40 transition-colors cursor-pointer"
                                        title={`Update to prior sail number ${prior.sailNumber}`}
                                      >
                                        Use
                                      </button>
                                    </div>
                                  )}
                                  {(!currentSn || currentSn === "-" || currentSn === "—") && prior && (
                                    <button
                                      type="button"
                                      onClick={() =>
                                        handleSailNumberChange(sailorIdx, prior.sailNumber)
                                      }
                                      className="text-[10px] text-sky-400 hover:text-sky-300 text-left underline cursor-pointer"
                                    >
                                      Auto: #{prior.sailNumber}
                                    </button>
                                  )}
                                </div>
                              );
                            })()}
                          </td>
                          <td className="px-3 py-3 min-w-[140px]">
                            <div className="font-bold text-white leading-tight">
                              {sailor.name}
                            </div>
                            <div className="text-[10px] text-slate-400 truncate max-w-[180px]">
                              {sailor.schoolName !== "—" ? sailor.schoolName : sailor.club}
                            </div>
                          </td>
                          <td className="px-2 py-2.5">
                            <select
                              value={sailor.ageCategory || "Open"}
                              onChange={(e) => handleCategoryChange(sailorIdx, e.target.value)}
                              className="bg-slate-900 border border-white/15 text-slate-200 rounded px-2 py-1 text-xs font-medium focus:border-amber-400 focus:outline-none cursor-pointer hover:border-white/30 transition-colors"
                            >
                              <optgroup label="Official NoR Divisions">
                                {WINGFOIL_OFFICIAL_DIVISIONS.map((cat) => (
                                  <option key={cat} value={cat} className="bg-slate-900 text-white">
                                    {cat}
                                  </option>
                                ))}
                              </optgroup>
                              <optgroup label="Shorthand / Standard">
                                {["Open", "Women", "16&U", "U19", "Masters", "Grand Masters", "Fun Open"].map((cat) => (
                                  <option key={cat} value={cat} className="bg-slate-900 text-white">
                                    {cat}
                                  </option>
                                ))}
                              </optgroup>
                              {sailor.ageCategory &&
                                !WINGFOIL_CATEGORIES.includes(sailor.ageCategory as any) && (
                                  <option value={sailor.ageCategory} className="bg-slate-900 text-white">
                                    {sailor.ageCategory}
                                  </option>
                                )}
                            </select>
                          </td>

                          {/* R1 through RN Heat Score Inputs */}
                          {Array.from({ length: totalRacesCount }).map((_, raceIdx) => {
                            const race = sailor.races[raceIdx] || { score: results.length + 1, code: "DNC", isDiscarded: false };
                            const isDiscarded = race.isDiscarded;
                            const code = race.code;
                            return (
                              <td
                                key={raceIdx}
                                className={`px-1 py-2 text-center ${
                                  isDiscarded ? "opacity-50" : ""
                                }`}
                              >
                                <div className="flex flex-col items-center">
                                  <input
                                    type="number"
                                    min={1}
                                    max={100}
                                    value={race.score ?? ""}
                                    onChange={(e) =>
                                      handleScoreChange(
                                        sailorIdx,
                                        raceIdx,
                                        e.target.value,
                                        race.code
                                      )
                                    }
                                    className={`w-9 text-center font-mono font-bold rounded p-0.5 text-xs border ${
                                      isDiscarded
                                        ? "line-through bg-slate-900 border-white/5 text-slate-500"
                                        : race.score === 1
                                        ? "bg-amber-400/20 border-amber-400/40 text-amber-300"
                                        : race.score === 2
                                        ? "bg-sky-400/20 border-sky-400/40 text-sky-200"
                                        : race.score === 3
                                        ? "bg-orange-500/20 border-orange-500/40 text-orange-200"
                                        : "bg-slate-950 border-white/10 text-white"
                                    }`}
                                  />
                                  <select
                                    value={code || ""}
                                    onChange={(e) =>
                                      handleScoreChange(
                                        sailorIdx,
                                        raceIdx,
                                        String(race.score),
                                        e.target.value
                                      )
                                    }
                                    className="w-11 text-[9px] font-bold mt-0.5 bg-transparent border-0 text-slate-500 hover:text-slate-300 text-center"
                                  >
                                    <option value="" className="bg-slate-900 text-slate-300">
                                      FIN
                                    </option>
                                    <option value="DNF" className="bg-slate-900 text-slate-300">
                                      DNF
                                    </option>
                                    <option value="DNS" className="bg-slate-900 text-slate-300">
                                      DNS
                                    </option>
                                    <option value="DSQ" className="bg-slate-900 text-slate-300">
                                      DSQ
                                    </option>
                                    <option value="DNC" className="bg-slate-900 text-slate-300">
                                      DNC
                                    </option>
                                    <option value="RDG" className="bg-slate-900 text-slate-300">
                                      RDG
                                    </option>
                                  </select>
                                </div>
                              </td>
                            );
                          })}

                          <td className="px-2.5 py-3 text-center font-mono font-bold text-slate-400">
                            {sailor.grossScore}
                          </td>
                          <td className="px-2.5 py-3 text-center font-mono font-black text-orange-400 text-sm">
                            {sailor.nettScore}
                          </td>
                          <td className="px-2 py-3 text-center">
                            <button
                              type="button"
                              onClick={() => handleDeleteCompetitor(sailor.name)}
                              className="p-1 rounded text-slate-500 hover:text-rose-400 hover:bg-rose-500/10 transition-colors"
                              title="Delete entry"
                            >
                              <Trash2 className="h-3.5 w-3.5" />
                            </button>
                          </td>
                        </tr>
                      ))
                    )}
                  </tbody>
                </table>
              </div>
            </div>
          );
        })()}
      </div>

      {/* Add Competitor Modal */}
      {showAddEntry && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/70 backdrop-blur-sm">
          <div className="glass-panel w-full max-w-md rounded-3xl p-6 border border-white/10 bg-[#131520] shadow-2xl space-y-4">
            <div className="flex items-center justify-between border-b border-white/5 pb-3">
              <h3 className="text-base font-bold text-white flex items-center gap-2">
                <Plus className="h-4 w-4 text-orange-500" />
                Add Competitor Entry
              </h3>
              <button
                type="button"
                onClick={() => setShowAddEntry(false)}
                className="rounded-full p-1 text-slate-400 hover:text-white"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            <form onSubmit={handleAddCompetitor} className="space-y-3 text-xs">
              <div>
                <label className="text-[10px] font-bold text-slate-500 uppercase">
                  Competitor Name *
                </label>
                <input
                  type="text"
                  required
                  placeholder="e.g. Mason Qifeng Lau"
                  value={newEntry.name || ""}
                  onChange={(e) =>
                    setNewEntry({ ...newEntry, name: e.target.value })
                  }
                  className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase">
                    Sail Number *
                  </label>
                  <input
                    type="text"
                    required
                    placeholder="e.g. 27"
                    value={newEntry.sailNumber || ""}
                    onChange={(e) =>
                      setNewEntry({ ...newEntry, sailNumber: e.target.value })
                    }
                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white font-mono"
                  />
                </div>
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase">
                    Gender
                  </label>
                  <select
                    value={newEntry.gender || "M"}
                    onChange={(e) =>
                      setNewEntry({
                        ...newEntry,
                        gender: e.target.value as "M" | "F",
                      })
                    }
                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                  >
                    <option value="M">Male (M)</option>
                    <option value="F">Female (F)</option>
                  </select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase">
                    Age Category
                  </label>
                  <select
                    value={newEntry.ageCategory || "Open"}
                    onChange={(e) =>
                      setNewEntry({ ...newEntry, ageCategory: e.target.value })
                    }
                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs"
                  >
                    <optgroup label="Official NoR Divisions">
                      {WINGFOIL_OFFICIAL_DIVISIONS.map((cat) => (
                        <option key={cat} value={cat}>
                          {cat}
                        </option>
                      ))}
                    </optgroup>
                    <optgroup label="Shorthand / Standard">
                      {["Open", "Women", "16&U", "U19", "Masters", "Grand Masters", "Fun Open"].map((cat) => (
                        <option key={cat} value={cat}>
                          {cat}
                        </option>
                      ))}
                    </optgroup>
                  </select>
                </div>
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase">
                    School Name
                  </label>
                  <input
                    type="text"
                    placeholder="e.g. Tao Nan School"
                    value={newEntry.schoolName || ""}
                    onChange={(e) =>
                      setNewEntry({ ...newEntry, schoolName: e.target.value })
                    }
                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                  />
                </div>
              </div>

              <div>
                <label className="text-[10px] font-bold text-slate-500 uppercase">
                  Club / Organization
                </label>
                <input
                  type="text"
                  placeholder="e.g. Constant Wind SeaSports"
                  value={newEntry.club || ""}
                  onChange={(e) =>
                    setNewEntry({ ...newEntry, club: e.target.value })
                  }
                  className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white"
                />
              </div>

              <div className="flex justify-end gap-2 pt-3 border-t border-white/5">
                <button
                  type="button"
                  onClick={() => setShowAddEntry(false)}
                  className="rounded-full px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="rounded-full bg-orange-600 hover:bg-orange-500 px-5 py-2 text-xs font-bold text-white shadow-lg shadow-orange-950/40"
                >
                  Save Entry
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Tag / Merge Event Modal */}
      {showMergeModal && (
        <div
          className="fixed inset-0 z-50 bg-black/80 flex items-center justify-center p-4 backdrop-blur-sm"
          onClick={() => setShowMergeModal(false)}
        >
          <div
            className="relative max-w-lg w-full rounded-3xl border border-sky-500/30 bg-[#0f111c] p-6 shadow-2xl space-y-4"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between pb-3 border-b border-white/10">
              <div className="flex items-center gap-2">
                <div className="h-8 w-8 rounded-xl bg-sky-500/15 border border-sky-500/30 flex items-center justify-center text-sky-400">
                  <GitMerge className="h-4 w-4" />
                </div>
                <div>
                  <h3 className="text-sm font-bold text-white">
                    Tag / Merge Results to Event
                  </h3>
                  <p className="text-[11px] text-slate-400">
                    Attach results from this regatta to another existing official event.
                  </p>
                </div>
              </div>
              <button
                type="button"
                onClick={() => setShowMergeModal(false)}
                className="rounded-full p-1.5 text-slate-400 hover:text-white hover:bg-white/10"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            <div className="space-y-3 text-xs">
              <div className="rounded-xl border border-white/5 bg-white/[0.02] p-3 space-y-1">
                <span className="text-[10px] uppercase font-bold text-slate-500">
                  Source Regatta (Current View):
                </span>
                <p className="font-bold text-white">{activeRegatta?.name}</p>
                <p className="text-[11px] text-orange-400">
                  {results.length} competitor scores · {activeRegatta?.dates}
                </p>
              </div>

              <div>
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block mb-1.5">
                  Select Target Event to Merge / Tag Into:
                </label>
                <select
                  value={mergeTargetId}
                  onChange={(e) => setMergeTargetId(e.target.value)}
                  className="w-full rounded-xl border border-white/10 bg-slate-950 px-3.5 py-2.5 text-xs font-bold text-white focus:border-sky-500/50"
                >
                  {regattas
                    .filter((r) => r.id !== activeRegatta?.id)
                    .map((r) => (
                      <option key={r.id} value={r.id}>
                        {r.name} ({r.dates})
                      </option>
                    ))}
                </select>
                <p className="text-[10px] text-slate-400 mt-1.5">
                  💡 Tip: If you uploaded a spreadsheet with a variation like{" "}
                  <code className="text-sky-300 font-mono">NE Monsoon Series GP2</code>,
                  select <strong className="text-white">2026 Northeast Monsoon Grand Prix 2</strong> to merge its scores into that official event and remove the duplicate entry.
                </p>
              </div>
            </div>

            <div className="flex items-center justify-end gap-2 pt-3 border-t border-white/10">
              <button
                type="button"
                onClick={() => setShowMergeModal(false)}
                className="rounded-full px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
              >
                Cancel
              </button>
              <button
                type="button"
                disabled={!mergeTargetId}
                onClick={() => handleMergeIntoEvent(mergeTargetId)}
                className="rounded-full bg-sky-600 hover:bg-sky-500 disabled:opacity-50 px-5 py-2 text-xs font-bold text-white shadow-lg shadow-sky-950/40 inline-flex items-center gap-1.5 cursor-pointer"
              >
                <GitMerge className="h-3.5 w-3.5" />
                Confirm Merge &amp; Save
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
