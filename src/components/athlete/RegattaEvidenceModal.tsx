"use client";

import { useState, useRef } from "react";
import {
  X,
  UploadCloud,
  FileText,
  ImageIcon,
  CheckCircle2,
  ExternalLink,
  Trash2,
  Loader2,
  Trophy,
  ShieldCheck,
} from "lucide-react";
import { GeographySelect } from "@/components/CountrySelect";
import { useFeedback } from "@/components/ui/FeedbackProvider";

export type RegattaResultItem = {
  id: string;
  rank: number;
  nettScore?: number | null;
  totalScore?: number | null;
  evidenceUrl?: string | null;
  evidenceName?: string | null;
  evidenceType?: "pdf" | "image" | "link" | null;
  officialUrl?: string | null;
  evidenceNotes?: string | null;
  verificationStatus?: "self_reported" | "pending_review" | "verified" | "rejected" | null;
  regattaId: string;
  regattaName: string;
  regattaSlug?: string | null;
  regattaDate: string | Date;
  regattaEndDate?: string | Date | null;
  venue?: string | null;
  boatClass?: string | null;
  division?: string | null;
  geography?: string | null;
  totalFleetSize?: number | null;
  countsForRanking?: boolean | null;
};

interface RegattaEvidenceModalProps {
  isOpen: boolean;
  onClose: () => void;
  sailorId: string;
  sailorName: string;
  initialResult?: RegattaResultItem | null;
  onSuccess: () => void;
}

interface RegattaEvidenceFormProps {
  onClose: () => void;
  sailorId: string;
  initialResult?: RegattaResultItem | null;
  onSuccess: () => void;
}

const DIVISION_OPTIONS = ["Open", "Gold", "Silver", "U12", "U15", "Other"];

function localTodayStr(): string {
  const now = new Date();
  const m = String(now.getMonth() + 1).padStart(2, "0");
  const d = String(now.getDate()).padStart(2, "0");
  return `${now.getFullYear()}-${m}-${d}`;
}

type FieldErrors = {
  name?: string;
  date?: string;
  endDate?: string;
  rank?: string;
  fleet?: string;
};

type UploadState = {
  isUploading: boolean;
  progress: number;
  fileName: string | null;
  fileSize: number | null;
  error: string | null;
};

function RegattaEvidenceForm({
  onClose,
  sailorId,
  initialResult,
  onSuccess,
}: RegattaEvidenceFormProps) {
  const { toast, confirm } = useFeedback();
  const fileInputRef = useRef<HTMLInputElement>(null);
  const uploadXhrRef = useRef<XMLHttpRequest | null>(null);

  // Check if editing a shared/official regatta managed centrally
  const isSharedRegatta = Boolean(
    initialResult?.regattaSlug && !initialResult.regattaSlug.startsWith("log-")
  );

  const [name, setName] = useState(initialResult?.regattaName || "");
  const [date, setDate] = useState(
    initialResult?.regattaDate
      ? String(initialResult.regattaDate).slice(0, 10)
      : ""
  );
  const [endDate, setEndDate] = useState(
    initialResult?.regattaEndDate
      ? String(initialResult.regattaEndDate).slice(0, 10)
      : ""
  );
  const [venue, setVenue] = useState(initialResult?.venue || "");
  const [geography, setGeography] = useState(initialResult?.geography || "SGP");
  const [boatClass, setBoatClass] = useState(initialResult?.boatClass || "Optimist");
  const [division, setDivision] = useState(initialResult?.division || "Open");
  const [rank, setRank] = useState(
    initialResult?.rank ? String(initialResult.rank) : ""
  );
  const [totalFleetSize, setTotalFleetSize] = useState(
    initialResult?.totalFleetSize ? String(initialResult.totalFleetSize) : ""
  );
  const [nettScore, setNettScore] = useState(
    initialResult?.nettScore != null ? String(initialResult.nettScore) : ""
  );
  const [totalScore, setTotalScore] = useState(
    initialResult?.totalScore != null ? String(initialResult.totalScore) : ""
  );
  const [officialUrl, setOfficialUrl] = useState(initialResult?.officialUrl || "");
  const [evidenceNotes, setEvidenceNotes] = useState(initialResult?.evidenceNotes || "");

  // Evidence state (pre-uploaded or existing)
  const [existingEvidenceUrl, setExistingEvidenceUrl] = useState<string | null>(
    initialResult?.evidenceUrl || null
  );
  const [existingEvidenceName, setExistingEvidenceName] = useState<string | null>(
    initialResult?.evidenceName || null
  );
  const [existingEvidenceType, setExistingEvidenceType] = useState<
    "pdf" | "image" | "link" | null
  >(initialResult?.evidenceType || null);

  // Decoupled asynchronous background upload state
  const [uploadState, setUploadState] = useState<UploadState>({
    isUploading: false,
    progress: 0,
    fileName: null,
    fileSize: null,
    error: null,
  });

  const [isSubmitting, setIsSubmitting] = useState(false);
  const [dragOver, setDragOver] = useState(false);
  const [fieldErrors, setFieldErrors] = useState<FieldErrors>({});

  const clearFieldError = (key: keyof FieldErrors) => {
    setFieldErrors((prev) => {
      if (!prev[key]) return prev;
      const next = { ...prev };
      delete next[key];
      return next;
    });
  };

  const inputCls = (hasError?: string, disabled?: boolean) =>
    `w-full rounded-xl border px-3.5 py-2 text-xs transition-colors focus:outline-none ${
      disabled
        ? "bg-slate-100/90 border-[var(--sp-cool-veil)] text-slate-500 cursor-not-allowed"
        : hasError
        ? "bg-white border-rose-500 focus:border-rose-600 focus:ring-1 focus:ring-rose-500 text-[var(--sp-charcoal)]"
        : "bg-white border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] placeholder:text-slate-400 focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)]"
    }`;

  const divisionOptions = DIVISION_OPTIONS.includes(division)
    ? DIVISION_OPTIONS
    : [...DIVISION_OPTIONS, division];

  // Background upload via XMLHttpRequest with real-time percentage progress
  const startUpload = (file: File) => {
    if (file.size > 10 * 1024 * 1024) {
      toast.error("File size cannot exceed 10MB");
      return;
    }
    const validTypes = ["application/pdf", "image/jpeg", "image/png", "image/webp"];
    if (!validTypes.includes(file.type)) {
      toast.error("Please upload a PDF document or JPG/PNG/WebP image");
      return;
    }

    if (uploadXhrRef.current) {
      uploadXhrRef.current.abort();
    }

    setUploadState({
      isUploading: true,
      progress: 0,
      fileName: file.name,
      fileSize: file.size,
      error: null,
    });

    const xhr = new XMLHttpRequest();
    uploadXhrRef.current = xhr;

    xhr.upload.onprogress = (e) => {
      if (e.lengthComputable) {
        const pct = Math.round((e.loaded / e.total) * 100);
        setUploadState((prev) => ({ ...prev, progress: pct }));
      }
    };

    xhr.onload = () => {
      uploadXhrRef.current = null;
      if (xhr.status >= 200 && xhr.status < 300) {
        try {
          const data = JSON.parse(xhr.responseText);
          setExistingEvidenceUrl(data.url);
          setExistingEvidenceName(data.name || file.name);
          setExistingEvidenceType(data.type as "pdf" | "image");
          setUploadState({
            isUploading: false,
            progress: 100,
            fileName: file.name,
            fileSize: file.size,
            error: null,
          });
          toast.success("Evidence document uploaded successfully!");
        } catch {
          setUploadState((prev) => ({
            ...prev,
            isUploading: false,
            error: "Failed to parse upload response",
          }));
          toast.error("Failed to parse server upload response");
        }
      } else {
        let msg = "Upload failed";
        try {
          const errData = JSON.parse(xhr.responseText);
          if (errData.error) msg = errData.error;
        } catch {}
        setUploadState((prev) => ({ ...prev, isUploading: false, error: msg }));
        toast.error(msg);
      }
    };

    xhr.onerror = () => {
      uploadXhrRef.current = null;
      setUploadState((prev) => ({
        ...prev,
        isUploading: false,
        error: "Network error during upload",
      }));
      toast.error("Network error while uploading evidence");
    };

    xhr.onabort = () => {
      uploadXhrRef.current = null;
      setUploadState({
        isUploading: false,
        progress: 0,
        fileName: null,
        fileSize: null,
        error: null,
      });
    };

    const formData = new FormData();
    formData.append("file", file);
    xhr.open("POST", "/api/account/evidence/upload");
    xhr.send(formData);
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setDragOver(false);
    if (e.dataTransfer.files?.[0]) {
      startUpload(e.dataTransfer.files[0]);
    }
  };

  const handleRemoveEvidence = async () => {
    // If removing evidence from a verified result, warn user
    if (initialResult?.verificationStatus === "verified") {
      const ok = await confirm({
        title: "Remove Verified Document?",
        message:
          "Removing this document will remove your Verified ✓ badge and revert this result to Self-Reported. Continue?",
        confirmLabel: "Remove Document",
        tone: "danger",
      });
      if (!ok) return;
    }

    if (uploadXhrRef.current) {
      uploadXhrRef.current.abort();
    }
    setExistingEvidenceUrl(null);
    setExistingEvidenceName(null);
    setExistingEvidenceType(null);
    setUploadState({
      isUploading: false,
      progress: 0,
      fileName: null,
      fileSize: null,
      error: null,
    });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (uploadState.isUploading) {
      toast.error("Please wait for the evidence file upload to complete.");
      return;
    }

    // Inline validation
    const errors: FieldErrors = {};
    if (!name.trim()) {
      errors.name = "Please enter the regatta name";
    }
    if (!date) {
      errors.date = "Please pick the regatta start date";
    } else if (date > localTodayStr()) {
      errors.date = "Start date can't be in the future";
    }
    if (date && endDate && endDate < date) {
      errors.endDate = "End date can't be before the start date";
    }
    const rankNum = parseInt(rank, 10);
    if (isNaN(rankNum) || rankNum < 1) {
      errors.rank = "Enter a valid finish rank (1 or higher)";
    }
    const fleetNum = totalFleetSize.trim() ? parseInt(totalFleetSize, 10) : null;
    if (fleetNum != null) {
      if (isNaN(fleetNum) || fleetNum < 1) {
        errors.fleet = "Enter a valid fleet size (1 or higher)";
      } else if (!isNaN(rankNum) && rankNum >= 1 && fleetNum < rankNum) {
        errors.fleet = "Fleet size can't be smaller than the finish rank";
      }
    }

    if (Object.keys(errors).length > 0) {
      setFieldErrors(errors);
      const firstField = ["name", "date", "endDate", "rank", "fleet"].find(
        (k) => errors[k as keyof FieldErrors]
      );
      if (firstField) {
        document
          .getElementById(`regatta-field-${firstField}`)
          ?.scrollIntoView({ behavior: "smooth", block: "center" });
      }
      return;
    }

    setIsSubmitting(true);
    try {
      let finalEvidenceType = existingEvidenceType;
      if (!existingEvidenceUrl && officialUrl.trim()) {
        finalEvidenceType = "link";
      }

      const payload = {
        sailorId,
        name: name.trim(),
        date,
        endDate: endDate || null,
        venue: venue.trim() || null,
        geography: geography.trim() || "SGP",
        boatClass,
        division: division.trim() || "Open",
        rank: rankNum,
        totalFleetSize: fleetNum,
        nettScore: nettScore.trim() ? parseFloat(nettScore) : null,
        totalScore: totalScore.trim() ? parseFloat(totalScore) : null,
        officialUrl: officialUrl.trim() || null,
        evidenceUrl: existingEvidenceUrl || null,
        evidenceName: existingEvidenceName || null,
        evidenceType: finalEvidenceType || null,
        evidenceNotes: evidenceNotes.trim() || null,
      };

      if (initialResult) {
        // PATCH existing result
        const res = await fetch("/api/account/results", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            resultId: initialResult.id,
            ...payload,
          }),
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Failed to update regatta result");

        toast.success(
          existingEvidenceUrl || officialUrl.trim()
            ? "Result updated! Attached evidence is now Under Review."
            : "Regatta result updated."
        );
      } else {
        // POST new result
        const res = await fetch("/api/account/results", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Failed to log regatta result");

        toast.success(
          existingEvidenceUrl || officialUrl.trim()
            ? "Result logged! Attached evidence is now Under Review."
            : "Regatta result saved to athlete logbook."
        );
      }

      onSuccess();
      onClose();
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Submission failed");
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="flex max-h-[85vh] flex-col bg-[var(--sp-warm-white)] text-[var(--sp-charcoal)]">
      <div className="flex-1 space-y-6 overflow-y-auto p-5 sm:p-7">
        {/* Shared / Official Regatta Notice */}
        {isSharedRegatta && (
          <div className="rounded-2xl border border-sky-200 bg-sky-50/80 p-3.5 text-xs text-sky-950 flex items-start gap-3">
            <ShieldCheck className="h-5 w-5 text-[var(--sp-harbour-teal)] shrink-0 mt-0.5" />
            <div>
              <p className="font-bold text-[var(--sp-harbour-shadow)]">Official SailorPath Event</p>
              <p className="text-[var(--sp-slate-soft)] text-xs leading-relaxed mt-0.5">
                Event details (name, dates, class, venue) are managed centrally by SailorPath. You can edit your personal finish rank, fleet size, division, scores, and official evidence.
              </p>
            </div>
          </div>
        )}

        {/* Section 1: Event Information */}
        <div className="space-y-4">
          <div className="flex items-center justify-between border-b border-[var(--sp-cool-veil)] pb-2">
            <h4 className="text-xs font-black uppercase tracking-wider text-[var(--sp-harbour-teal)]">
              Event Details
            </h4>
            {isSharedRegatta && (
              <span className="text-[11px] font-semibold text-slate-500">
                Managed by SailorPath
              </span>
            )}
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
            <div className="sm:col-span-2">
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Regatta Name <span className="text-rose-500">*</span>
              </label>
              <input
                id="regatta-field-name"
                type="text"
                disabled={isSharedRegatta}
                required
                placeholder="e.g. Pattaya International Regatta 2026"
                value={name}
                onChange={(e) => {
                  setName(e.target.value);
                  clearFieldError("name");
                }}
                className={inputCls(fieldErrors.name, isSharedRegatta)}
              />
              {fieldErrors.name && (
                <p className="mt-1 text-[13px] text-[var(--sp-color-error)] font-semibold">{fieldErrors.name}</p>
              )}
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Start Date <span className="text-rose-500">*</span>
              </label>
              <input
                id="regatta-field-date"
                type="date"
                disabled={isSharedRegatta}
                required
                max={localTodayStr()}
                value={date}
                onChange={(e) => {
                  setDate(e.target.value);
                  clearFieldError("date");
                }}
                className={inputCls(fieldErrors.date, isSharedRegatta)}
              />
              {fieldErrors.date && (
                <p className="mt-1 text-[13px] text-[var(--sp-color-error)] font-semibold">{fieldErrors.date}</p>
              )}
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                End Date <span className="text-slate-400 font-normal">(Optional)</span>
              </label>
              <input
                id="regatta-field-endDate"
                type="date"
                disabled={isSharedRegatta}
                min={date || undefined}
                value={endDate}
                onChange={(e) => {
                  setEndDate(e.target.value);
                  clearFieldError("endDate");
                }}
                className={inputCls(fieldErrors.endDate, isSharedRegatta)}
              />
              {fieldErrors.endDate && (
                <p className="mt-1 text-[13px] text-[var(--sp-color-error)] font-semibold">{fieldErrors.endDate}</p>
              )}
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Boat Class
              </label>
              <select
                disabled={isSharedRegatta}
                value={boatClass}
                onChange={(e) => setBoatClass(e.target.value)}
                className={inputCls(undefined, isSharedRegatta)}
              >
                <option value="Optimist">Optimist</option>
                <option value="ILCA 4">ILCA 4</option>
                <option value="ILCA 6">ILCA 6</option>
                <option value="ILCA 7">ILCA 7</option>
                <option value="WingFoil">WingFoil</option>
                <option value="Techno 293">Techno 293</option>
                <option value="iQFOiL">iQFOiL</option>
                <option value="29er">29er</option>
                <option value="420">420</option>
                <option value="Other">Other</option>
              </select>
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Country / Region
              </label>
              {isSharedRegatta ? (
                <input
                  type="text"
                  disabled
                  value={geography}
                  className={inputCls(undefined, true)}
                />
              ) : (
                <GeographySelect
                  value={geography}
                  onChange={(val) => setGeography(val || "SGP")}
                  className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
                />
              )}
            </div>

            <div className="sm:col-span-2">
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Venue / Host Club <span className="text-slate-400 font-normal">(Optional)</span>
              </label>
              <input
                type="text"
                disabled={isSharedRegatta}
                placeholder="e.g. Royal Varuna Yacht Club, Chonburi"
                value={venue}
                onChange={(e) => setVenue(e.target.value)}
                className={inputCls(undefined, isSharedRegatta)}
              />
            </div>
          </div>
        </div>

        {/* Section 2: Sailor Score & Finish Position */}
        <div className="space-y-4 pt-2 border-t border-[var(--sp-cool-veil)]">
          <h4 className="text-xs font-black uppercase tracking-wider text-[var(--sp-harbour-teal)]">
            Results &amp; Scoring
          </h4>
          {/* Responsive grid: single column on mobile, 3 cols on sm, 5 cols on lg */}
          <div className="grid grid-cols-1 sm:grid-cols-3 lg:grid-cols-5 gap-3">
            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Final Rank <span className="text-rose-500">*</span>
              </label>
              <input
                id="regatta-field-rank"
                type="number"
                min="1"
                required
                placeholder="e.g. 3"
                value={rank}
                onChange={(e) => {
                  setRank(e.target.value);
                  clearFieldError("rank");
                }}
                className={inputCls(fieldErrors.rank)}
              />
              {fieldErrors.rank && (
                <p className="mt-1 text-[13px] text-[var(--sp-color-error)] font-semibold">{fieldErrors.rank}</p>
              )}
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Fleet Size <span className="text-slate-400 font-normal">(Optional)</span>
              </label>
              <input
                id="regatta-field-fleet"
                type="number"
                min="1"
                placeholder="e.g. 65"
                value={totalFleetSize}
                onChange={(e) => {
                  setTotalFleetSize(e.target.value);
                  clearFieldError("fleet");
                }}
                className={inputCls(fieldErrors.fleet)}
              />
              {fieldErrors.fleet ? (
                <p className="mt-1 text-[13px] text-[var(--sp-color-error)] font-semibold">{fieldErrors.fleet}</p>
              ) : (
                <p className="mt-1 text-[13px] text-[var(--sp-slate-soft)]">
                  Total boats in fleet
                </p>
              )}
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Division / Fleet
              </label>
              <select
                value={division}
                onChange={(e) => setDivision(e.target.value)}
                className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
              >
                {divisionOptions.map((opt) => (
                  <option key={opt} value={opt}>
                    {opt}
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Nett Score <span className="text-slate-400 font-normal">(Pts)</span>
              </label>
              <input
                type="number"
                step="any"
                placeholder="e.g. 18.0"
                value={nettScore}
                onChange={(e) => setNettScore(e.target.value)}
                className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3 py-2 text-xs text-[var(--sp-charcoal)] font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Total Score <span className="text-slate-400 font-normal">(Pts)</span>
              </label>
              <input
                type="number"
                step="any"
                placeholder="e.g. 24.0"
                value={totalScore}
                onChange={(e) => setTotalScore(e.target.value)}
                className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3 py-2 text-xs text-[var(--sp-charcoal)] font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
              />
            </div>
          </div>
        </div>

        {/* Section 3: Official Verification Evidence */}
        <div className="space-y-4 pt-2 border-t border-[var(--sp-cool-veil)]">
          <div className="flex items-center justify-between">
            <h4 className="text-xs font-black uppercase tracking-wider text-[var(--sp-harbour-teal)]">
              Official Evidence for Verification
            </h4>
            <span className="text-[11px] text-[var(--sp-harbour-teal)] font-bold">
              Enables Verified ✓ badge
            </span>
          </div>
          <p className="text-xs text-[var(--sp-slate-soft)] leading-relaxed">
            Attach official race documentation (PDF results sheet, scorecard snapshot, or official regatta URL). Results with evidence are marked <strong>Under Review</strong> until stamped verified by SailorPath.
          </p>

          {/* Official Online Link */}
          <div>
            <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
              Official Results Link (Manage2Sail / HalSail / Host Club URL)
            </label>
            <div className="relative">
              <input
                type="url"
                placeholder="https://www.manage2sail.com/en-US/event/..."
                value={officialUrl}
                onChange={(e) => setOfficialUrl(e.target.value)}
                className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] pl-9 pr-3.5 py-2 text-xs text-[var(--sp-charcoal)] placeholder:text-slate-400 focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none"
              />
              <ExternalLink className="pointer-events-none absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-[var(--sp-slate-soft)]" />
            </div>
          </div>

          {/* File Upload Dropzone */}
          <div className="space-y-2">
            <label className="block text-xs font-semibold text-[var(--sp-slate-soft)]">
              Upload Official Document or Scorecard Photo (PDF, PNG, JPG, WebP)
            </label>

            {/* In-flight upload progress bar */}
            {uploadState.isUploading && (
              <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-4 space-y-2">
                <div className="flex items-center justify-between text-xs">
                  <div className="flex items-center gap-2 text-[var(--sp-charcoal)] font-semibold">
                    <Loader2 className="h-4 w-4 animate-spin text-[var(--sp-racing-orange)]" />
                    <span>Uploading {uploadState.fileName}...</span>
                  </div>
                  <span className="font-mono font-bold text-[var(--sp-racing-orange)]">
                    {uploadState.progress}%
                  </span>
                </div>
                <div className="w-full bg-slate-200 rounded-full h-2 overflow-hidden">
                  <div
                    className="bg-[var(--sp-racing-orange)] h-2 rounded-full transition-all duration-200"
                    style={{ width: `${uploadState.progress}%` }}
                  />
                </div>
              </div>
            )}

            {/* Attached file summary card */}
            {!uploadState.isUploading && (existingEvidenceUrl || existingEvidenceName) ? (
              <div className="flex items-center justify-between p-3.5 rounded-2xl border border-emerald-200 bg-emerald-50/70 text-xs text-emerald-950">
                <div className="flex items-center gap-3 min-w-0">
                  {existingEvidenceType === "pdf" ? (
                    <FileText className="h-5 w-5 text-emerald-700 shrink-0" />
                  ) : (
                    <ImageIcon className="h-5 w-5 text-emerald-700 shrink-0" />
                  )}
                  <div className="min-w-0">
                    <div className="flex items-center gap-2">
                      <p className="font-bold text-[var(--sp-charcoal)] truncate">
                        {existingEvidenceName || "Attached Evidence Document"}
                      </p>
                      <span className="rounded-md bg-emerald-100 px-1.5 py-0.5 text-[11px] font-bold text-emerald-800">
                        Uploaded ✓
                      </span>
                    </div>
                    <p className="text-[13px] text-[var(--sp-slate-soft)] mt-0.5">
                      Stored securely on SailorPath Cloud · Ready for verification
                    </p>
                  </div>
                </div>

                <div className="flex items-center gap-2 shrink-0 ml-3">
                  <button
                    type="button"
                    onClick={() => fileInputRef.current?.click()}
                    className="text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline"
                  >
                    Replace
                  </button>
                  <button
                    type="button"
                    onClick={() => void handleRemoveEvidence()}
                    className="p-1.5 rounded-lg text-slate-400 hover:text-rose-600 hover:bg-rose-50 transition-colors"
                    title="Remove evidence"
                  >
                    <Trash2 className="h-4 w-4" />
                  </button>
                </div>
              </div>
            ) : !uploadState.isUploading ? (
              <div
                onDragOver={(e) => {
                  e.preventDefault();
                  setDragOver(true);
                }}
                onDragLeave={() => setDragOver(false)}
                onDrop={handleDrop}
                onClick={() => fileInputRef.current?.click()}
                className={`border-2 border-dashed rounded-2xl p-6 text-center cursor-pointer transition-all ${
                  dragOver
                    ? "border-[var(--sp-racing-orange)] bg-[var(--sp-racing-mist)]/20"
                    : "border-[var(--sp-cool-veil)] hover:border-[var(--sp-harbour-teal)] bg-[var(--sp-sailcloth)]/70 hover:bg-[var(--sp-sailcloth)]"
                }`}
              >
                <UploadCloud className="mx-auto h-8 w-8 text-[var(--sp-harbour-teal)] mb-2" />
                <p className="text-xs font-bold text-[var(--sp-charcoal)]">
                  Click to select file or drag &amp; drop
                </p>
                <p className="text-[13px] text-[var(--sp-slate-soft)] mt-1">
                  Official PDF results document, race sheet photo, or noticeboard image (max 10MB)
                </p>
              </div>
            ) : null}

            <input
              ref={fileInputRef}
              type="file"
              accept=".pdf,image/png,image/jpeg,image/webp"
              className="hidden"
              onChange={(e) => {
                if (e.target.files?.[0]) {
                  startUpload(e.target.files[0]);
                }
              }}
            />
          </div>

          {/* Notes / Comments */}
          <div>
            <label className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
              Evidence Notes or Race Context <span className="text-slate-400 font-normal">(Optional)</span>
            </label>
            <textarea
              rows={2}
              placeholder="e.g. Competed in U15 division; tied on countback for 2nd girl; discard race 4."
              value={evidenceNotes}
              onChange={(e) => setEvidenceNotes(e.target.value)}
              className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2 text-xs text-[var(--sp-charcoal)] placeholder:text-slate-400 focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] focus:outline-none resize-none"
            />
          </div>
        </div>
      </div>

      {/* Footer Actions */}
      <div className="flex shrink-0 items-center justify-end gap-3 border-t border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-6 py-4">
        <button
          type="button"
          onClick={onClose}
          disabled={isSubmitting}
          className="rounded-xl border border-[var(--sp-cool-veil)] bg-white px-4 py-2 text-xs font-bold text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)] transition-colors shadow-2xs"
        >
          Cancel
        </button>
        <button
          type="submit"
          disabled={isSubmitting || uploadState.isUploading}
          className="inline-flex items-center gap-2 rounded-xl bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] active:scale-[0.98] px-5 py-2 text-[15px] font-semibold text-white transition-all disabled:opacity-50 shadow-xs"
        >
          {isSubmitting ? (
            <>
              <Loader2 className="h-4 w-4 animate-spin" />
              <span>Saving...</span>
            </>
          ) : uploadState.isUploading ? (
            <>
              <Loader2 className="h-4 w-4 animate-spin" />
              <span>Uploading ({uploadState.progress}%)...</span>
            </>
          ) : (
            <>
              <CheckCircle2 className="h-4 w-4" />
              <span>{initialResult ? "Save Changes" : "Log Result"}</span>
            </>
          )}
        </button>
      </div>
    </form>
  );
}

export function RegattaEvidenceModal({
  isOpen,
  onClose,
  sailorId,
  sailorName,
  initialResult,
  onSuccess,
}: RegattaEvidenceModalProps) {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 sm:p-6 overflow-y-auto bg-slate-900/60 backdrop-blur-xs animate-in fade-in duration-200">
      <div className="relative w-full max-w-2xl rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-2xl my-8 overflow-hidden">
        {/* Header */}
        <div className="flex items-center justify-between border-b border-[var(--sp-cool-veil)] px-6 py-4 sm:py-5 bg-[var(--sp-sailcloth)]">
          <div className="flex items-center gap-3">
            <div className="flex h-10 w-10 items-center justify-center rounded-2xl bg-[var(--sp-racing-mist)]/40 text-[var(--sp-racing-orange)] border border-[var(--sp-racing-orange)]/30 shadow-2xs">
              <Trophy className="h-5 w-5" />
            </div>
            <div>
              <h3 className="text-base font-bold text-[var(--sp-harbour-shadow)]">
                {initialResult ? "Edit Regatta Score & Evidence" : "Log Regatta Score & Evidence"}
              </h3>
              <p className="text-xs text-[var(--sp-slate-soft)]">
                Athlete: <span className="text-[var(--sp-charcoal)] font-bold">{sailorName}</span>
              </p>
            </div>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="rounded-full p-2 text-[var(--sp-slate-soft)] hover:bg-[var(--sp-warm-white)] hover:text-[var(--sp-charcoal)] transition-colors"
          >
            <X className="h-5 w-5" />
          </button>
        </div>

        <RegattaEvidenceForm
          key={initialResult?.id || "new"}
          onClose={onClose}
          sailorId={sailorId}
          initialResult={initialResult}
          onSuccess={onSuccess}
        />
      </div>
    </div>
  );
}
