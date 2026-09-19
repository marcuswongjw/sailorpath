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

function RegattaEvidenceForm({
  onClose,
  sailorId,
  initialResult,
  onSuccess,
}: RegattaEvidenceFormProps) {
  const { toast } = useFeedback();
  const fileInputRef = useRef<HTMLInputElement>(null);

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

  // Evidence file upload state
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [existingEvidenceUrl, setExistingEvidenceUrl] = useState<string | null>(
    initialResult?.evidenceUrl || null
  );
  const [existingEvidenceName, setExistingEvidenceName] = useState<string | null>(
    initialResult?.evidenceName || null
  );
  const [existingEvidenceType, setExistingEvidenceType] = useState<
    "pdf" | "image" | "link" | null
  >(initialResult?.evidenceType || null);

  const [isSubmitting, setIsSubmitting] = useState(false);
  const [uploadProgress, setUploadProgress] = useState(false);
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

  const inputCls = (hasError?: string) =>
    `w-full rounded-xl bg-slate-900/80 border px-3.5 py-2.5 text-xs text-white placeholder:text-slate-600 focus:outline-none ${
      hasError
        ? "border-rose-500/60 focus:border-rose-500"
        : "border-white/10 focus:border-orange-500"
    }`;

  // Preserve a pre-existing division that isn't one of the standard options
  const divisionOptions = DIVISION_OPTIONS.includes(division)
    ? DIVISION_OPTIONS
    : [...DIVISION_OPTIONS, division];

  const handleFileSelect = (file: File) => {
    if (file.size > 10 * 1024 * 1024) {
      toast.error("File size cannot exceed 10MB");
      return;
    }
    const validTypes = ["application/pdf", "image/jpeg", "image/png", "image/webp"];
    if (!validTypes.includes(file.type)) {
      toast.error("Please upload a PDF document or JPG/PNG/WebP image");
      return;
    }
    setSelectedFile(file);
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setDragOver(false);
    if (e.dataTransfer.files?.[0]) {
      handleFileSelect(e.dataTransfer.files[0]);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    // Inline validation — collect all errors, then scroll to the first one
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
    // Fleet size is optional — but when given it must cover the rank
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
      let finalEvidenceUrl = existingEvidenceUrl;
      let finalEvidenceName = existingEvidenceName;
      let finalEvidenceType = existingEvidenceType;

      // 1. If user selected a new file, upload it to storage
      if (selectedFile) {
        setUploadProgress(true);
        const uploadForm = new FormData();
        uploadForm.append("file", selectedFile);

        const upRes = await fetch("/api/account/evidence/upload", {
          method: "POST",
          body: uploadForm,
        });
        const upData = await upRes.json();
        if (!upRes.ok) {
          throw new Error(upData.error || "Failed to upload evidence document");
        }
        finalEvidenceUrl = upData.url;
        finalEvidenceName = upData.name;
        finalEvidenceType = upData.type as "pdf" | "image";
        setUploadProgress(false);
      }

      // If user supplied official URL without a file, evidenceType is link
      if (!finalEvidenceUrl && officialUrl.trim()) {
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
        totalFleetSize: fleetNum, // null when left blank — server defaults to rank
        nettScore: nettScore.trim() ? parseFloat(nettScore) : null,
        totalScore: totalScore.trim() ? parseFloat(totalScore) : null,
        officialUrl: officialUrl.trim() || null,
        evidenceUrl: finalEvidenceUrl || null,
        evidenceName: finalEvidenceName || null,
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
          finalEvidenceUrl || officialUrl.trim()
            ? "Result updated! Attached evidence is now queued for verification."
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
          finalEvidenceUrl || officialUrl.trim()
            ? "Result logged! It appears on your profile and has been sent for verification."
            : "Regatta result saved to athlete logbook."
        );
      }

      onSuccess();
      onClose();
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Submission failed");
    } finally {
      setIsSubmitting(false);
      setUploadProgress(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="flex max-h-[80vh] flex-col">
      <div className="flex-1 space-y-6 overflow-y-auto p-6">
      {/* Section 1: Event Information */}
      <div className="space-y-4">
        <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400">
          Event Details
        </h4>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div className="sm:col-span-2">
            <label className="block text-xs font-medium text-slate-300 mb-1">
              Regatta Name <span className="text-rose-400">*</span>
            </label>
            <input
              id="regatta-field-name"
              type="text"
              required
              placeholder="e.g. Pattaya International Regatta 2026"
              value={name}
              onChange={(e) => {
                setName(e.target.value);
                clearFieldError("name");
              }}
              className={inputCls(fieldErrors.name)}
            />
            {fieldErrors.name && (
              <p className="mt-1 text-[11px] text-rose-400">{fieldErrors.name}</p>
            )}
          </div>

          <div>
            <label className="block text-xs font-medium text-slate-300 mb-1">
              Start Date <span className="text-rose-400">*</span>
            </label>
            <input
              id="regatta-field-date"
              type="date"
              required
              max={localTodayStr()}
              value={date}
              onChange={(e) => {
                setDate(e.target.value);
                clearFieldError("date");
              }}
              className={inputCls(fieldErrors.date)}
            />
            {fieldErrors.date && (
              <p className="mt-1 text-[11px] text-rose-400">{fieldErrors.date}</p>
            )}
          </div>

          <div>
            <label className="block text-xs font-medium text-slate-300 mb-1">
              End Date (Optional)
            </label>
            <input
              id="regatta-field-endDate"
              type="date"
              min={date || undefined}
              max={localTodayStr()}
              value={endDate}
              onChange={(e) => {
                setEndDate(e.target.value);
                clearFieldError("endDate");
              }}
              className={inputCls(fieldErrors.endDate)}
            />
            {fieldErrors.endDate && (
              <p className="mt-1 text-[11px] text-rose-400">{fieldErrors.endDate}</p>
            )}
          </div>

          <div>
            <label className="block text-xs font-medium text-slate-300 mb-1">
              Boat Class
            </label>
            <select
              value={boatClass}
              onChange={(e) => setBoatClass(e.target.value)}
              className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
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
            <label className="block text-xs font-medium text-slate-300 mb-1">
              Country / Region
            </label>
            <GeographySelect
              value={geography}
              onChange={(val) => setGeography(val || "SGP")}
              className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
            />
          </div>

          <div className="sm:col-span-2">
            <label className="block text-xs font-medium text-slate-300 mb-1">
              Venue / Host Club (Optional)
            </label>
            <input
              type="text"
              placeholder="e.g. Royal Varuna Yacht Club, Chonburi"
              value={venue}
              onChange={(e) => setVenue(e.target.value)}
              className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3.5 py-2.5 text-xs text-white placeholder:text-slate-600 focus:border-orange-500 focus:outline-none"
            />
          </div>
        </div>
      </div>

      {/* Section 2: Sailor Score & Finish Position */}
      <div className="space-y-4 pt-2 border-t border-white/10">
        <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400">
          Results & Scoring
        </h4>
        <div className="grid grid-cols-2 sm:grid-cols-5 gap-3">
          <div>
            <label className="block text-xs font-medium text-slate-300 mb-1">
              Final Rank <span className="text-rose-400">*</span>
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
              <p className="mt-1 text-[11px] text-rose-400">{fieldErrors.rank}</p>
            )}
          </div>

          <div>
            <label className="block text-xs font-medium text-slate-300 mb-1">
              Fleet Size <span className="text-slate-500 font-normal">(Optional)</span>
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
              <p className="mt-1 text-[11px] text-rose-400">{fieldErrors.fleet}</p>
            ) : (
              <p className="mt-1 text-[10px] text-slate-500">
                Total boats — leave blank if unsure
              </p>
            )}
          </div>

          <div>
            <label className="block text-xs font-medium text-slate-300 mb-1">
              Nett Score
            </label>
            <input
              type="number"
              step="any"
              placeholder="e.g. 18.0"
              value={nettScore}
              onChange={(e) => setNettScore(e.target.value)}
              className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3 py-2.5 text-xs text-white font-mono focus:border-orange-500 focus:outline-none"
            />
          </div>

          <div>
            <label className="block text-xs font-medium text-slate-300 mb-1">
              Total Score
            </label>
            <input
              type="number"
              step="any"
              placeholder="e.g. 24.0"
              value={totalScore}
              onChange={(e) => setTotalScore(e.target.value)}
              className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3 py-2.5 text-xs text-white font-mono focus:border-orange-500 focus:outline-none"
            />
          </div>

          <div>
            <label className="block text-xs font-medium text-slate-300 mb-1">
              Division / Fleet
            </label>
            <select
              value={division}
              onChange={(e) => setDivision(e.target.value)}
              className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3 py-2.5 text-xs text-white focus:border-orange-500 focus:outline-none"
            >
              {divisionOptions.map((opt) => (
                <option key={opt} value={opt}>
                  {opt}
                </option>
              ))}
            </select>
          </div>
        </div>
      </div>

      {/* Section 3: Official Verification Evidence */}
      <div className="space-y-4 pt-2 border-t border-white/10">
        <div className="flex items-center justify-between">
          <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400">
            Official Evidence for Verification
          </h4>
          <span className="text-[11px] text-sky-400 font-medium">
            Enables Verified ✓ badge
          </span>
        </div>
        <p className="text-xs text-slate-400">
          Attach official race documentation (PDF results sheet, scorecard photo, or official results link). You can provide any or all of these.
        </p>

        {/* Official Online Link */}
        <div>
          <label className="block text-xs font-medium text-slate-300 mb-1">
            Official Results Link (Manage2Sail / HalSail / Club URL)
          </label>
          <div className="relative">
            <input
              type="url"
              placeholder="https://www.manage2sail.com/en-US/event/..."
              value={officialUrl}
              onChange={(e) => setOfficialUrl(e.target.value)}
              className="w-full rounded-xl bg-slate-900/80 border border-white/10 pl-9 pr-3.5 py-2.5 text-xs text-white placeholder:text-slate-600 focus:border-orange-500 focus:outline-none"
            />
            <ExternalLink className="absolute left-3 top-3 h-4 w-4 text-slate-500" />
          </div>
        </div>

        {/* File Upload Dropzone */}
        <div>
          <label className="block text-xs font-medium text-slate-300 mb-1">
            Upload Official Document or Scorecard Photo (PDF, PNG, JPG)
          </label>

          {/* Already uploaded / selected file */}
          {selectedFile || existingEvidenceUrl ? (
            <div className="flex items-center justify-between p-3 rounded-2xl border border-sky-500/30 bg-sky-500/10 text-xs text-slate-200">
              <div className="flex items-center gap-2.5 min-w-0">
                {selectedFile?.type === "application/pdf" || existingEvidenceType === "pdf" ? (
                  <FileText className="h-5 w-5 text-sky-400 shrink-0" />
                ) : (
                  <ImageIcon className="h-5 w-5 text-sky-400 shrink-0" />
                )}
                <div className="min-w-0">
                  <p className="font-semibold text-white truncate">
                    {selectedFile?.name || existingEvidenceName || "Attached Evidence"}
                  </p>
                  <p className="text-[10px] text-slate-400">
                    {selectedFile
                      ? `${(selectedFile.size / 1024).toFixed(0)} KB · Ready to upload`
                      : "Stored on SailorPath Cloud · Click replace to change"}
                  </p>
                </div>
              </div>

              <div className="flex items-center gap-2 shrink-0">
                <button
                  type="button"
                  onClick={() => fileInputRef.current?.click()}
                  className="text-[11px] font-bold text-sky-400 hover:text-sky-300 hover:underline"
                >
                  Replace
                </button>
                <button
                  type="button"
                  onClick={() => {
                    setSelectedFile(null);
                    setExistingEvidenceUrl(null);
                    setExistingEvidenceName(null);
                    setExistingEvidenceType(null);
                  }}
                  className="p-1 text-slate-400 hover:text-rose-400"
                >
                  <Trash2 className="h-4 w-4" />
                </button>
              </div>
            </div>
          ) : (
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
                  ? "border-orange-500 bg-orange-500/5"
                  : "border-white/10 hover:border-white/20 bg-slate-900/40"
              }`}
            >
              <UploadCloud className="mx-auto h-8 w-8 text-slate-400 mb-2" />
              <p className="text-xs font-semibold text-slate-200">
                Click to choose file or drag and drop
              </p>
              <p className="text-[11px] text-slate-500 mt-1">
                Official results PDF, scorecard snapshot, or noticeboard photo (max 10MB)
              </p>
            </div>
          )}

          <input
            ref={fileInputRef}
            type="file"
            accept=".pdf,image/png,image/jpeg,image/webp"
            className="hidden"
            onChange={(e) => {
              if (e.target.files?.[0]) {
                handleFileSelect(e.target.files[0]);
              }
            }}
          />
        </div>

        {/* Notes / Comments */}
        <div>
          <label className="block text-xs font-medium text-slate-300 mb-1">
            Evidence Notes or Division Context (Optional)
          </label>
          <textarea
            rows={2}
            placeholder="e.g. Competed in U15 category; finished 2nd overall girl; tied on discard."
            value={evidenceNotes}
            onChange={(e) => setEvidenceNotes(e.target.value)}
            className="w-full rounded-xl bg-slate-900/80 border border-white/10 px-3.5 py-2 text-xs text-white placeholder:text-slate-600 focus:border-orange-500 focus:outline-none resize-none"
          />
        </div>
      </div>
      </div>

      {/* Footer Actions — pinned below the scroll area so Save is always reachable */}
      <div className="flex shrink-0 items-center justify-end gap-3 border-t border-white/10 bg-[#0e111a] px-6 py-4">
        <button
          type="button"
          onClick={onClose}
          disabled={isSubmitting}
          className="rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:text-white transition-colors"
        >
          Cancel
        </button>
        <button
          type="submit"
          disabled={isSubmitting}
          className="inline-flex items-center gap-2 rounded-xl bg-orange-600 hover:bg-orange-500 px-5 py-2.5 text-xs font-bold text-white transition-colors disabled:opacity-50 shadow-lg shadow-orange-600/20"
        >
          {isSubmitting ? (
            <>
              <Loader2 className="h-4 w-4 animate-spin" />
              <span>{uploadProgress ? "Uploading Evidence..." : "Saving..."}</span>
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
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 sm:p-6 overflow-y-auto bg-slate-950/80 backdrop-blur-sm animate-in fade-in duration-200">
      <div className="relative w-full max-w-2xl rounded-3xl border border-white/10 bg-[#0e111a] shadow-2xl my-8 overflow-hidden">
        {/* Header */}
        <div className="flex items-center justify-between border-b border-white/10 px-6 py-5 bg-[#131722]">
          <div className="flex items-center gap-3">
            <div className="flex h-10 w-10 items-center justify-center rounded-2xl bg-orange-500/15 text-orange-400 border border-orange-500/30">
              <Trophy className="h-5 w-5" />
            </div>
            <div>
              <h3 className="text-base font-bold text-white">
                {initialResult ? "Edit Regatta Score & Evidence" : "Log Regatta Score & Evidence"}
              </h3>
              <p className="text-xs text-slate-400">
                Athlete: <span className="text-slate-200 font-semibold">{sailorName}</span>
              </p>
            </div>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="rounded-full p-2 text-slate-400 hover:bg-white/10 hover:text-white transition-colors"
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
