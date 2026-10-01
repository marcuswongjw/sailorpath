"use client";

import {
  Grid,
  Save,
  UserCheck,
  Trash2,
} from "lucide-react";
import {
  halfBoundaryOptions,
} from "@/lib/datesSg";
import { NationalitySelect } from "@/components/CountrySelect";

const HALF_BOUNDARY_OPTS = halfBoundaryOptions();

export type SailorBulkEditToolbarProps = {
  selectedCount: number;
  isSuperadmin: boolean;
  saving: boolean;
  bulkField: string;
  onBulkFieldChange: (v: string) => void;
  bulkValue: string;
  onBulkValueChange: (v: string) => void;
  onApplyBulk: () => void;
  onBulkDelete: () => void;
  onMergeSailors: () => void;
};

/**
 * Bulk edit toolbar for the sailor admin panel.
 * Appears when one or more sailors are selected in the data table.
 */
export function SailorBulkEditToolbar({
  selectedCount,
  isSuperadmin,
  saving,
  bulkField,
  onBulkFieldChange,
  bulkValue,
  onBulkValueChange,
  onApplyBulk,
  onBulkDelete,
  onMergeSailors,
}: SailorBulkEditToolbarProps) {
  return (
    <div className="rounded-2xl border border-orange-200 bg-orange-50/40 p-4 space-y-3">
      <div className="flex items-center gap-2">
        <Grid className="h-4 w-4 text-orange-600" />
        <h3 className="text-sm font-bold text-[var(--sp-charcoal)]">
          Bulk edit · {selectedCount} selected
        </h3>
      </div>
      <p className="text-[11px] text-[var(--sp-slate)]">
        Choose a property and value, then apply. Use Columns to show historical /
        overseas fields in the same overview.
      </p>
      <div className="flex flex-wrap items-end gap-4">
        <div className="flex flex-col gap-1 min-w-[180px]">
          <label className="text-[10px] font-bold text-[var(--sp-slate)] uppercase">Property</label>
          <select
            value={bulkField}
            onChange={(e) => {
              onBulkFieldChange(e.target.value);
              onBulkValueChange("");
            }}
            className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
          >
            <option value="">-- Select property --</option>
            <optgroup label="SG Series & Dates">
              <option value="currentFleet">SG Optimist (Guest / tagged)</option>
              <option value="goldEntryDate">Gold Fleet Entry Date</option>
              <option value="silverEntryDate">Silver Fleet Entry Date</option>
              <option value="dropDate">Optimist Drop Date</option>
            </optgroup>
            <optgroup label="Profile">
              <option value="club">Club</option>
              <option value="school">School</option>
              <option value="nationality">Nationality</option>
              <option value="sailNumber">Optimist sail #</option>
              <option value="gender">Gender (M/F)</option>
              <option value="dob">Date of Birth</option>
              <option value="weight">Weight (kg)</option>
            </optgroup>
            <optgroup label="ILCA 4">
              <option value="sailNumberIlca4">ILCA 4 sail #</option>
              <option value="ilca4NationalList">
                SG ILCA 4 (true/false)
              </option>
              <option value="ilca6NationalList">
                SG ILCA 6 (true/false)
              </option>
            </optgroup>
            <optgroup label="Squad history">
              <option value="natSquadStatusJan25">Squad Jan 25</option>
              <option value="natSquadStatusJul25">Squad Jul 25</option>
              <option value="natSquadStatusJan26">Squad Jan 26</option>
              <option value="natSquadStatusJul26">Squad Jul 26</option>
              <option value="natSquadStatusJan27">Squad Jan 27</option>
              <option value="natSquadStatusJul27">Squad Jul 27</option>
            </optgroup>
            <optgroup label="Historical rankings">
              <option value="histRankingJun24">Hist Jun 24</option>
              <option value="histRankingDec24">Hist Dec 24</option>
              <option value="histRankingJun25">Hist Jun 25</option>
              <option value="histRankingDec25">Hist Dec 25</option>
              <option value="histRankingJun26">Hist Jun 26</option>
            </optgroup>
            <optgroup label="Overseas Representation">
              <option value="worlds">Worlds years (e.g. 2023, 2025)</option>
              <option value="european">European years</option>
              <option value="asian">Asian years</option>
              <option value="seaGames">SEA Games years</option>
            </optgroup>
          </select>
        </div>
        <div className="flex flex-col gap-1 min-w-[140px]">
          <label className="text-[10px] font-bold text-[var(--sp-slate)] uppercase">Value</label>
          {bulkField === "goldEntryDate" || bulkField === "dropDate" ? (
            <select
              value={bulkValue}
              onChange={(e) => onBulkValueChange(e.target.value)}
              className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
            >
              <option value="">— clear / none —</option>
              {HALF_BOUNDARY_OPTS.map((o) => (
                <option key={o.value} value={o.value}>
                  {o.label}
                </option>
              ))}
            </select>
          ) : ["silverEntryDate", "dob"].includes(bulkField) ? (
            <input
              type="date"
              value={bulkValue}
              onChange={(e) => onBulkValueChange(e.target.value)}
              className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
            />
          ) : bulkField === "gender" ? (
            <select
              value={bulkValue}
              onChange={(e) => onBulkValueChange(e.target.value)}
              className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
            >
              <option value="">—</option>
              <option value="M">M</option>
              <option value="F">F</option>
            </select>
          ) : bulkField === "currentFleet" ? (
            <select
              value={bulkValue}
              onChange={(e) => onBulkValueChange(e.target.value)}
              className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
            >
              <option value="Guest">Guest</option>
              <option value="Series">SG Optimist</option>
            </select>
          ) : bulkField === "ilca4NationalList" ||
            bulkField === "ilca6NationalList" ? (
            <select
              value={bulkValue}
              onChange={(e) => onBulkValueChange(e.target.value)}
              className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
            >
              <option value="true">On list (true)</option>
              <option value="false">Off list (false)</option>
            </select>
          ) : [
              "natSquadStatusJan25",
              "natSquadStatusJul25",
              "natSquadStatusJan26",
              "natSquadStatusJul26",
              "natSquadStatusJan27",
              "natSquadStatusJul27",
            ].includes(bulkField) ? (
            <select
              value={bulkValue}
              onChange={(e) => onBulkValueChange(e.target.value)}
              className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
            >
              <option value="">—</option>
              <option value="Nat A">Nat A</option>
              <option value="Nat B">Nat B</option>
              <option value="DS">DS</option>
              <option value="CLEAR">Clear</option>
            </select>
          ) : [
              "histRankingJun24",
              "histRankingDec24",
              "histRankingJun25",
              "histRankingDec25",
              "histRankingJun26",
              "weight",
            ].includes(bulkField) ? (
            <input
              type="number"
              value={bulkValue}
              onChange={(e) => onBulkValueChange(e.target.value)}
              className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs font-mono"
              placeholder="Number"
            />
          ) : bulkField === "nationality" ? (
            <NationalitySelect
              value={bulkValue}
              onChange={onBulkValueChange}
              className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
              emptyLabel="— Clear / select —"
            />
          ) : (
            <input
              type="text"
              value={bulkValue}
              onChange={(e) => onBulkValueChange(e.target.value)}
              disabled={!bulkField}
              className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs disabled:opacity-40"
              placeholder={bulkField ? "Value" : "Select property first"}
            />
          )}
        </div>
        <button
          type="button"
          disabled={!isSuperadmin || saving || selectedCount === 0 || !bulkField}
          onClick={onApplyBulk}
          className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500 disabled:opacity-40 flex items-center gap-1.5 shadow-sm"
        >
          <Save className="h-4 w-4" />
          Apply to {selectedCount || 0}
        </button>
        <button
          type="button"
          disabled={!isSuperadmin || saving || selectedCount !== 2}
          onClick={onMergeSailors}
          title="Select exactly 2 sailors to merge duplicates"
          className="rounded-full bg-emerald-600 px-4 py-2 text-xs font-bold text-white hover:bg-emerald-500 disabled:opacity-40 flex items-center gap-1.5 shadow-sm"
        >
          <UserCheck className="h-4 w-4" />
          Merge 2 selected
          {selectedCount === 2 ? "" : ` (${selectedCount}/2)`}
        </button>
        <button
          type="button"
          disabled={!isSuperadmin || saving || selectedCount === 0}
          onClick={onBulkDelete}
          className="rounded-full bg-rose-600 px-4 py-2 text-xs font-bold text-white hover:bg-rose-500 disabled:opacity-40 flex items-center gap-1.5 shadow-sm"
        >
          <Trash2 className="h-4 w-4" />
          Delete selected
        </button>
      </div>
      <p className="text-[10px] text-[var(--sp-muted)]">
        <strong className="text-[var(--sp-slate)]">Merge:</strong> tick exactly two rows →{" "}
        <strong className="text-emerald-700">Merge 2 selected</strong>. The more
        complete profile is kept; results/aliases move over.
      </p>
    </div>
  );
}
