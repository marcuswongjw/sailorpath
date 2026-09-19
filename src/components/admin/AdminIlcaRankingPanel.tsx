"use client";

import { useMemo, useState, useCallback } from "react";
import Link from "next/link";
import {
  computeIlcaRankings,
  defaultIlcaIntake,
  ilcaSquadCutoff,
  selectIlca4NationalSquad,
  ILCA_POLICY_NOTES,
  isIlcaSeriesClass,
  type IlcaBoatClass,
  type IlcaIntakeKind,
} from "@/lib/ilcaRanking";
import {
  isSailorOnIlca4NationalList,
  ILCA4_NATIONAL_RANKING_NAMES,
  isSingaporeNationality,
} from "@/lib/ilca4NationalList";
import { birthYear } from "@/lib/age";
import {
  findDuplicateSailorPairs,
  type DuplicatePair,
} from "@/lib/nameMatch";
import type { SailorAdmin } from "@/types/sailor";
import { NationalitySelect } from "@/components/CountrySelect";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import {
  Trophy,
  Users,
  UserPlus,
  Copy,
  Loader2,
  ListChecks,
} from "lucide-react";
import { useFeedback } from "@/components/ui/FeedbackProvider";

type Props = {
  sailors: SailorAdmin[];
  regattas: RegattaAdmin[];
  results: ResultAdmin[];
  /** Refresh sailor list after national-list toggle / seed */
  onSailorsChange?: (next: SailorAdmin[]) => void;
  /** Merge two sailors (same as Database tab) */
  onMergePair?: (keepId: string, mergeId: string) => void | Promise<void>;
};

const REASON_LABEL: Record<string, string> = {
  top2_overall: "Top 2 overall",
  age16: "Intake bucket 16",
  age15_or_under: "Intake bucket ≤15",
  fill_same_gender: "Fill (same gender)",
};

function isIlca4Regatta(r: RegattaAdmin): boolean {
  return isIlcaSeriesClass(r.boatClass, "ILCA 4");
}

export function AdminIlcaRankingPanel({
  sailors,
  regattas,
  results,
  onSailorsChange,
  onMergePair,
}: Props) {
  const { confirm } = useFeedback();
  const now = new Date();
  const y = now.getFullYear();
  /** ILCA 6 not active — rankings are ILCA 4 only for now */
  const boatClass: IlcaBoatClass = "ILCA 4";
  const defaultIntake = defaultIlcaIntake(now);
  const [intakeKind, setIntakeKind] = useState<IlcaIntakeKind>(defaultIntake.kind);
  const [intakeYear, setIntakeYear] = useState(defaultIntake.year);
  const [rosterFilter, setRosterFilter] = useState<
    "all" | "on_list" | "off_list" | "with_results" | "no_results"
  >("all");
  const [rosterSearch, setRosterSearch] = useState("");
  const [busyId, setBusyId] = useState<string | null>(null);
  const [seedBusy, setSeedBusy] = useState(false);
  const [msg, setMsg] = useState<string | null>(null);
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [bulkField, setBulkField] = useState("sailNumberIlca4");
  const [bulkValue, setBulkValue] = useState("");
  const [bulkBusy, setBulkBusy] = useState(false);
  const [editId, setEditId] = useState<string | null>(null);
  const [editForm, setEditForm] = useState({
    name: "",
    sailNumberIlca4: "",
    sailNumber: "",
    nationality: "",
    gender: "",
    club: "",
    dob: "",
  });
  const [editBusy, setEditBusy] = useState(false);
  const [showDupes, setShowDupes] = useState(true);
  const [ignoredDupes, setIgnoredDupes] = useState<Set<string>>(() => {
    try {
      const raw = localStorage.getItem("sailorpath_ignored_ilca4_duplicates");
      if (raw) return new Set(JSON.parse(raw) as string[]);
    } catch {
      /* ignore */
    }
    return new Set();
  });

  const cutoff = useMemo(
    () => ilcaSquadCutoff(intakeKind, intakeYear),
    [intakeKind, intakeYear]
  );

  const ilca4RegattaIds = useMemo(() => {
    const ids = new Set<string>();
    for (const r of regattas) {
      if (isIlca4Regatta(r)) ids.add(r.id);
    }
    return ids;
  }, [regattas]);

  /** Sailors who raced ILCA 4 or have an ILCA 4 sail number */
  const ilca4Sailors = useMemo(() => {
    const withResults = new Set<string>();
    const resultCount = new Map<string, number>();
    for (const res of results) {
      if (!ilca4RegattaIds.has(res.regattaId)) continue;
      withResults.add(res.sailorId);
      resultCount.set(
        res.sailorId,
        (resultCount.get(res.sailorId) || 0) + 1
      );
    }
    return sailors
      .filter(
        (s) =>
          withResults.has(s.id) ||
          Boolean(String(s.sailNumberIlca4 || "").trim())
      )
      .map((s) => ({
        sailor: s,
        resultCount: resultCount.get(s.id) || 0,
        onList: isSailorOnIlca4NationalList(s),
      }))
      .sort((a, b) => a.sailor.name.localeCompare(b.sailor.name));
  }, [sailors, results, ilca4RegattaIds]);

  const ranked = useMemo(
    () =>
      computeIlcaRankings(
        boatClass,
        cutoff.asOf,
        sailors.map((s) => ({
          id: s.id,
          name: s.name,
          gender: s.gender,
          dob: s.dob,
          nationality: s.nationality,
          sailNumber: s.sailNumber,
          sailNumberIlca4: s.sailNumberIlca4,
          ilca4NationalList: s.ilca4NationalList,
          club: s.club,
          handle: s.handle,
        })),
        regattas,
        results,
        {
          intakeYear: cutoff.intakeYear,
          restrictToNationalList: boatClass === "ILCA 4",
        }
      ),
    [boatClass, cutoff, sailors, regattas, results]
  );

  const rankedById = useMemo(() => {
    const m = new Map(ranked.map((r) => [r.sailorId, r]));
    return m;
  }, [ranked]);

  const squad = useMemo(
    () =>
      boatClass === "ILCA 4" ? selectIlca4NationalSquad(ranked) : [],
    [boatClass, ranked]
  );
  const missingEligibilityBirthYears = useMemo(
    () =>
      boatClass === "ILCA 4"
        ? ranked.filter(
            (sailor) =>
              sailor.rank <= 25 &&
              isSingaporeNationality(sailor.nationality) &&
              (sailor.gender === "M" || sailor.gender === "F") &&
              sailor.ageInIntakeYear == null
          )
        : [],
    [boatClass, ranked]
  );

  const filteredRoster = useMemo(() => {
    const q = rosterSearch.trim().toLowerCase();
    return ilca4Sailors.filter(({ sailor, resultCount, onList }) => {
      if (rosterFilter === "on_list" && !onList) return false;
      if (rosterFilter === "off_list" && onList) return false;
      if (rosterFilter === "with_results" && resultCount < 1) return false;
      if (rosterFilter === "no_results" && resultCount > 0) return false;
      if (!q) return true;
      const hay = [
        sailor.name,
        sailor.sailNumber,
        sailor.sailNumberIlca4,
        sailor.club,
        sailor.nationality,
        sailor.handle,
      ]
        .filter(Boolean)
        .join(" ")
        .toLowerCase();
      return hay.includes(q);
    });
  }, [ilca4Sailors, rosterFilter, rosterSearch]);

  const onListCount = ilca4Sailors.filter((x) => x.onList).length;
  const seedMatchedUnset = useMemo(
    () =>
      sailors.filter(
        (s) =>
          !s.ilca4NationalList &&
          isSailorOnIlca4NationalList({
            name: s.name,
            ilca4NationalList: null,
          })
      ).length,
    [sailors]
  );

  const ilcaDupes: DuplicatePair[] = useMemo(() => {
    const pairs = findDuplicateSailorPairs(
      ilca4Sailors.map(({ sailor }) => ({
        id: sailor.id,
        name: sailor.name,
        sailNumber: sailor.sailNumber,
        sailNumberIlca4: sailor.sailNumberIlca4,
      })),
      0.6
    );
    return pairs.filter((p) => {
      const key = [p.a.id, p.b.id].sort().join("|");
      return !ignoredDupes.has(key);
    });
  }, [ilca4Sailors, ignoredDupes]);

  const ignoreDupe = (aId: string, bId: string) => {
    const key = [aId, bId].sort().join("|");
    setIgnoredDupes((prev) => {
      const next = new Set(prev);
      next.add(key);
      try {
        localStorage.setItem(
          "sailorpath_ignored_ilca4_duplicates",
          JSON.stringify([...next])
        );
      } catch {
        /* ignore */
      }
      return next;
    });
  };

  const refreshSailors = useCallback(async () => {
    const list = await fetch("/api/admin/sailors?all=1", {
      credentials: "include",
    }).then((r) => r.json());
    if (list.sailors && onSailorsChange) {
      onSailorsChange(list.sailors);
    }
  }, [onSailorsChange]);

  const toggleSelect = (id: string) => {
    setSelectedIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  };

  const clearSelection = () => setSelectedIds(new Set());

  const applyBulk = async () => {
    if (selectedIds.size === 0) {
      setMsg("Select sailors for bulk edit");
      return;
    }
    if (!bulkField) {
      setMsg("Choose a field to bulk-edit");
      return;
    }
    setBulkBusy(true);
    setMsg(null);
    try {
      const res = await fetch("/api/admin/bulk", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          sailorIds: [...selectedIds],
          field: bulkField,
          value: bulkValue,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Bulk edit failed");
      await refreshSailors();
      setMsg(data.message || `Updated ${selectedIds.size} sailor(s)`);
      setBulkValue("");
    } catch (e) {
      setMsg(e instanceof Error ? e.message : "Bulk edit failed");
    } finally {
      setBulkBusy(false);
    }
  };

  const openEdit = (s: SailorAdmin) => {
    setEditId(s.id);
    setEditForm({
      name: s.name || "",
      sailNumberIlca4: String(s.sailNumberIlca4 || ""),
      sailNumber: String(s.sailNumber || ""),
      nationality: String(s.nationality || ""),
      gender: String(s.gender || ""),
      club: String(s.club || ""),
      dob: s.dob ? String(s.dob).slice(0, 10) : "",
    });
  };

  const saveEdit = async () => {
    if (!editId) return;
    setEditBusy(true);
    setMsg(null);
    try {
      const res = await fetch("/api/admin/sailors", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          id: editId,
          name: editForm.name.trim(),
          sailNumberIlca4: editForm.sailNumberIlca4.trim() || null,
          sailNumber: editForm.sailNumber.trim() || null,
          nationality: editForm.nationality.trim() || null,
          gender: editForm.gender.trim() || null,
          club: editForm.club.trim() || null,
          dob: editForm.dob.trim() || null,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Save failed");
      await refreshSailors();
      setMsg(`Saved ${editForm.name}`);
      setEditId(null);
    } catch (e) {
      setMsg(e instanceof Error ? e.message : "Save failed");
    } finally {
      setEditBusy(false);
    }
  };

    const setOnList = async (sailorId: string, value: boolean) => {
    setBusyId(sailorId);
    setMsg(null);
    try {
      const res = await fetch("/api/admin/sailors", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "setIlca4NationalList",
          sailorIds: [sailorId],
          value,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Update failed");
      // Optimistic local update
      if (onSailorsChange) {
        onSailorsChange(
          sailors.map((s) =>
            s.id === sailorId ? { ...s, ilca4NationalList: value } : s
          )
        );
      } else {
        await refreshSailors();
      }
      setMsg(data.message || (value ? "Added to list" : "Removed from list"));
    } catch (e) {
      setMsg(e instanceof Error ? e.message : "Failed");
    } finally {
      setBusyId(null);
    }
  };

  const seedFromNames = async () => {
    const ok = await confirm({
      title: `Match DB sailors to the ${ILCA4_NATIONAL_RANKING_NAMES.length}-name official list?`,
      message:
        "Turn ON their national-list flag.\n\nExisting ON flags are kept. Only missing matches are set.",
      confirmLabel: "Seed list",
    });
    if (!ok) return;
    setSeedBusy(true);
    setMsg(null);
    try {
      const res = await fetch("/api/admin/sailors", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "seedIlca4NationalList" }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Seed failed");
      await refreshSailors();
      setMsg(data.message || `Seeded ${data.updated}`);
    } catch (e) {
      setMsg(
        e instanceof Error
          ? e.message
          : "The national-list update failed. Contact platform support if it continues."
      );
    } finally {
      setSeedBusy(false);
    }
  };


  return (
    <div className="w-full min-w-0 space-y-4 sm:space-y-6 overflow-x-clip">
      <div className="rounded-2xl sm:rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-sm p-4 sm:p-5 lg:p-6 space-y-3">
        <div className="flex items-start gap-3">
          <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-sky-500/10">
            <Trophy className="h-5 w-5 text-sky-600" />
          </div>
          <div className="min-w-0 flex-1">
            <h2 className="text-base font-bold text-[var(--sp-charcoal)]">
              ILCA 4 roster & national ranking
            </h2>
            <p className="text-[12px] text-[var(--sp-slate)] mt-1 max-w-3xl leading-relaxed">
              {ILCA_POLICY_NOTES.highPoints}
            </p>
            <p className="text-[11px] text-[var(--sp-muted)] mt-1 max-w-3xl">
              {ILCA_POLICY_NOTES.nationalList} {ILCA_POLICY_NOTES.dualSail}
            </p>
          </div>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
          <label className="text-xs text-[var(--sp-slate)] font-medium">
            Class
            <div className="mt-1 w-full rounded-lg bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs">
              ILCA 4
              <span className="ml-2 text-[10px] text-[var(--sp-muted)]">
                (ILCA 6 not active)
              </span>
            </div>
          </label>
          <label className="text-xs text-[var(--sp-slate)] font-medium">
            Intake
            <select
              className="mt-1 w-full rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
              value={intakeKind}
              onChange={(e) =>
                setIntakeKind(e.target.value as IlcaIntakeKind)
              }
            >
              <option value="january">January intake (Jul – Dec results · cutoff 31 Dec)</option>
              <option value="july">July intake (Jan – Jun results · cutoff 30 Jun)</option>
            </select>
          </label>
          <label className="text-xs text-[var(--sp-slate)] font-medium">
            Intake year
            <input
              type="number"
              min={2022}
              max={2040}
              className="mt-1 w-full rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
              value={intakeYear}
              onChange={(e) =>
                setIntakeYear(Number(e.target.value) || y)
              }
            />
          </label>
        </div>
        <p className="text-[11px] text-sky-800 font-medium">
          {cutoff.label} · {ranked.length} on scored national board · Best 3 of
          last 5 ≤ {cutoff.asOf}
        </p>
        {msg && (
          <p className="text-[11px] text-emerald-700 font-medium">{msg}</p>
        )}
      </div>

      {/* ── All ILCA 4 sailors + national list toggles ─────────── */}
      {boatClass === "ILCA 4" && (
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-sm overflow-hidden">
          <div className="px-4 py-3 border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50 flex flex-wrap items-center justify-between gap-3">
            <div>
              <h3 className="text-xs font-bold text-[var(--sp-charcoal)] uppercase tracking-wider flex items-center gap-2">
                <ListChecks className="h-4 w-4 text-sky-600" />
                All ILCA 4 sailors
              </h3>
              <p className="text-[11px] text-[var(--sp-slate)] mt-0.5">
                {ilca4Sailors.length} with ILCA 4 results or sail # ·{" "}
                <span className="text-sky-800 font-semibold">{onListCount} on national list</span>
                {seedMatchedUnset > 0 && (
                  <span className="text-amber-800 font-semibold">
                    {" "}
                    · {seedMatchedUnset} seed-name match not yet flagged
                  </span>
                )}
              </p>
            </div>
            <div className="flex flex-wrap gap-2">
              <button
                type="button"
                disabled={seedBusy}
                onClick={() => void seedFromNames()}
                className="inline-flex items-center gap-1.5 rounded-full border border-sky-300 bg-sky-50 px-3 py-1.5 text-[10px] font-bold text-sky-800 hover:bg-sky-100 disabled:opacity-50"
              >
                {seedBusy ? (
                  <Loader2 className="h-3 w-3 animate-spin" />
                ) : (
                  <UserPlus className="h-3 w-3" />
                )}
                Seed from official {ILCA4_NATIONAL_RANKING_NAMES.length} names
              </button>
            </div>
          </div>

          <div className="px-4 py-2 border-b border-[var(--sp-cool-veil)] bg-white flex flex-wrap gap-2 items-center">
            <input
              value={rosterSearch}
              onChange={(e) => setRosterSearch(e.target.value)}
              placeholder="Search name / sail / club…"
              className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] placeholder:text-[var(--sp-muted)] px-3 py-1.5 text-xs min-w-[12rem] flex-1 max-w-sm"
            />
            <select
              className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-2 py-1.5 text-xs"
              value={rosterFilter}
              onChange={(e) =>
                setRosterFilter(
                  e.target.value as typeof rosterFilter
                )
              }
            >
              <option value="all">All ILCA 4</option>
              <option value="on_list">On national list</option>
              <option value="off_list">Not on list</option>
              <option value="with_results">Has ILCA 4 results</option>
              <option value="no_results">No results yet</option>
            </select>
            <span className="text-[10px] text-[var(--sp-slate)]">
              Showing {filteredRoster.length}
            </span>
          </div>

          <div className="px-4 py-2 border-b border-[var(--sp-cool-veil)] flex flex-wrap gap-2 items-center bg-[var(--sp-sailcloth)]/30">
            <button
              type="button"
              onClick={() =>
                setSelectedIds(new Set(filteredRoster.map((r) => r.sailor.id)))
              }
              className="text-[10px] font-bold text-sky-800 hover:text-sky-950"
            >
              Select shown
            </button>
            <button
              type="button"
              onClick={() => clearSelection()}
              className="text-[10px] font-bold text-[var(--sp-slate)] hover:text-[var(--sp-charcoal)]"
            >
              Clear
            </button>
            <span className="text-[10px] text-[var(--sp-slate)]">
              {selectedIds.size} selected
            </span>
            <select
              className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-2 py-1.5 text-xs"
              value={bulkField}
              onChange={(e) => setBulkField(e.target.value)}
            >
              <option value="sailNumberIlca4">ILCA 4 sail #</option>
              <option value="sailNumber">Optimist sail #</option>
              <option value="nationality">Nationality</option>
              <option value="gender">Gender</option>
              <option value="club">Club</option>
              <option value="dob">DOB</option>
              <option value="ilca4NationalList">National list (true/false)</option>
            </select>
            {bulkField === "nationality" ? (
              <NationalitySelect
                value={bulkValue}
                onChange={setBulkValue}
                className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-2 py-1.5 text-xs min-w-[10rem]"
                emptyLabel="— Clear / select —"
              />
            ) : (
              <input
                value={bulkValue}
                onChange={(e) => setBulkValue(e.target.value)}
                placeholder="Value (empty = clear)"
                className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-2 py-1.5 text-xs min-w-[8rem]"
              />
            )}
            <button
              type="button"
              disabled={bulkBusy || selectedIds.size === 0}
              onClick={() => void applyBulk()}
              className="rounded-full bg-sky-600 px-3 py-1.5 text-[10px] font-bold text-white hover:bg-sky-700 disabled:opacity-50"
            >
              {bulkBusy ? "…" : "Bulk apply"}
            </button>
          </div>

          {editId && (
            <div className="px-4 py-3 border-b border-sky-200 bg-sky-50/70 space-y-2">
              <p className="text-[11px] font-bold text-sky-900 uppercase tracking-wide">
                Edit sailor
              </p>
              <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
                {(
                  [
                    ["name", "Name"],
                    ["sailNumberIlca4", "ILCA 4 #"],
                    ["sailNumber", "Opti #"],
                    ["nationality", "Nationality"],
                    ["gender", "Gender"],
                    ["club", "Club"],
                    ["dob", "DOB"],
                  ] as const
                ).map(([key, label]) => (
                  <label key={key} className="text-[10px] text-[var(--sp-slate)] font-medium">
                    {label}
                    {key === "nationality" ? (
                      <NationalitySelect
                        value={editForm.nationality}
                        onChange={(v) =>
                          setEditForm((f) => ({ ...f, nationality: v }))
                        }
                        className="mt-0.5 w-full rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-2 py-1.5 text-xs"
                      />
                    ) : (
                      <input
                        value={editForm[key]}
                        onChange={(e) =>
                          setEditForm((f) => ({ ...f, [key]: e.target.value }))
                        }
                        type={key === "dob" ? "date" : "text"}
                        className="mt-0.5 w-full rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-2 py-1.5 text-xs"
                      />
                    )}
                  </label>
                ))}
              </div>
              <div className="flex gap-2">
                <button
                  type="button"
                  disabled={editBusy}
                  onClick={() => void saveEdit()}
                  className="rounded-full bg-sky-600 px-3 py-1.5 text-[10px] font-bold text-white hover:bg-sky-700 disabled:opacity-50"
                >
                  {editBusy ? "Saving…" : "Save"}
                </button>
                <button
                  type="button"
                  onClick={() => setEditId(null)}
                  className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-3 py-1.5 text-[10px] font-bold text-[var(--sp-slate)] hover:text-[var(--sp-charcoal)]"
                >
                  Cancel
                </button>
              </div>
            </div>
          )}

          {filteredRoster.length === 0 ? (
            <p className="p-6 text-sm text-[var(--sp-muted)] text-center">
              No ILCA 4 sailors match. Import ILCA 4 regattas or set sail numbers.
            </p>
          ) : (
            <div className="overflow-x-auto max-h-[28rem] overflow-y-auto">
              <table className="w-full text-left text-xs">
                <thead className="sticky top-0 bg-[var(--sp-sailcloth)] text-[var(--sp-slate)] border-b border-[var(--sp-cool-veil)] z-10">
                  <tr className="text-[10px] uppercase tracking-wide">
                    <th className="px-2 py-2 font-bold w-8" />
                    <th className="px-3 py-2 font-bold">Sailor</th>
                    <th className="px-3 py-2 font-bold">ILCA #</th>
                    <th className="px-3 py-2 font-bold">Opti #</th>
                    <th className="px-3 py-2 font-bold">Nat</th>
                    <th className="px-3 py-2 font-bold">BY</th>
                    <th className="px-3 py-2 font-bold">Events</th>
                    <th className="px-3 py-2 font-bold">Score</th>
                    <th className="px-3 py-2 font-bold">National list</th>
                    <th className="px-3 py-2 font-bold">Edit</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-[var(--sp-cool-veil)]">
                  {filteredRoster.map(({ sailor, resultCount, onList }) => {
                    const rank = rankedById.get(sailor.id);
                    const by = birthYear(sailor.dob as string | null);
                    return (
                      <tr
                        key={sailor.id}
                        className="text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)]/30"
                      >
                        <td className="px-2 py-2">
                          <input
                            type="checkbox"
                            checked={selectedIds.has(sailor.id)}
                            onChange={() => toggleSelect(sailor.id)}
                          />
                        </td>
                        <td className="px-3 py-2">
                          {sailor.handle ? (
                            <Link
                              href={`/${sailor.handle}`}
                              className="font-semibold text-[var(--sp-charcoal)] hover:text-sky-700"
                              target="_blank"
                            >
                              {sailor.name}
                            </Link>
                          ) : (
                            <span className="font-semibold text-[var(--sp-charcoal)]">
                              {sailor.name}
                            </span>
                          )}
                          {sailor.club && (
                            <span className="block text-[10px] text-[var(--sp-muted)]">
                              {sailor.club}
                            </span>
                          )}
                        </td>
                        <td className="px-3 py-2 font-mono text-[11px] text-[var(--sp-charcoal)]">
                          {sailor.sailNumberIlca4 || "—"}
                        </td>
                        <td className="px-3 py-2 font-mono text-[11px] text-[var(--sp-slate)]">
                          {sailor.sailNumber || "—"}
                        </td>
                        <td className="px-3 py-2 text-[var(--sp-charcoal)]">
                          {sailor.nationality || "—"}
                        </td>
                        <td className="px-3 py-2 tabular-nums text-[var(--sp-slate)]">
                          {by ?? "—"}
                        </td>
                        <td className="px-3 py-2 tabular-nums text-[var(--sp-slate)]">
                          {resultCount}
                        </td>
                        <td className="px-3 py-2 tabular-nums">
                          {rank ? (
                            <span className="text-sky-700 font-bold">
                              #{rank.rank} · {rank.totalPoints}pts
                            </span>
                          ) : onList ? (
                            <span className="text-[var(--sp-muted)]">no score</span>
                          ) : (
                            "—"
                          )}
                        </td>
                        <td className="px-3 py-2">
                          <button
                            type="button"
                            disabled={busyId === sailor.id}
                            onClick={() =>
                              void setOnList(sailor.id, !onList)
                            }
                            className={`rounded-full px-2.5 py-1 text-[10px] font-bold border disabled:opacity-50 ${
                              onList
                                ? "bg-sky-50 border-sky-300 text-sky-800 hover:bg-rose-50 hover:border-rose-300 hover:text-rose-800"
                                : "bg-white border-[var(--sp-cool-veil)] text-[var(--sp-slate)] hover:bg-sky-50 hover:border-sky-300 hover:text-sky-800"
                            }`}
                          >
                            {busyId === sailor.id
                              ? "…"
                              : onList
                                ? "On list · remove"
                                : "Add to list"}
                          </button>
                        </td>
                        <td className="px-3 py-2">
                          <button
                            type="button"
                            onClick={() => openEdit(sailor)}
                            className="text-[10px] font-bold text-sky-700 hover:text-sky-800"
                          >
                            Edit
                          </button>
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          )}
          <p className="px-4 py-2 text-[9px] text-[var(--sp-muted)] border-t border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/30">
            Seed matching compares names regardless of token order (for example,
            &quot;Goh, Ian&quot; and &quot;Ian Goh&quot;).
          </p>
        </div>
      )}

      {/* ── ILCA 4 duplicate finder ───────────────────────────── */}
      {boatClass === "ILCA 4" && (
        <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-sm overflow-hidden">
          <div className="px-4 py-3 border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50 flex flex-wrap items-center justify-between gap-2">
            <div className="flex items-center gap-2">
              <Copy className="h-4 w-4 text-orange-600" />
              <h3 className="text-xs font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                ILCA 4 possible duplicates
              </h3>
              {ilcaDupes.length > 0 && (
                <span className="rounded-full bg-orange-100 border border-orange-200 text-orange-800 px-2 py-0.5 text-[10px] font-bold">
                  {ilcaDupes.length}
                </span>
              )}
            </div>
            <button
              type="button"
              onClick={() => setShowDupes((v) => !v)}
              className="text-[11px] font-bold text-[var(--sp-slate)] hover:text-[var(--sp-charcoal)]"
            >
              {showDupes ? "Hide" : "Show"}
            </button>
          </div>
          {showDupes && (
            <div className="p-4 space-y-2">
              <p className="text-[11px] text-[var(--sp-slate)]">
                Among ILCA 4 sailors only: name ≥60% similar, same Optimist
                sail #, or same ILCA 4 sail #. Merge opens the same keep/delete
                flow as Database → Sailors.
              </p>
              {ilcaDupes.length === 0 ? (
                <p className="text-xs text-[var(--sp-muted)] py-3 text-center">
                  No pairs at 60%+ among ILCA 4 sailors.
                </p>
              ) : (
                <ul className="space-y-2 max-h-72 overflow-y-auto">
                  {ilcaDupes.slice(0, 80).map((p) => {
                    const pct = Math.round(p.similarity * 100);
                    const high = p.band === "high" || pct >= 80;
                    return (
                      <li
                        key={`${p.a.id}-${p.b.id}`}
                        className={`flex flex-col sm:flex-row sm:items-center justify-between gap-2 rounded-lg border px-3 py-2 text-xs ${
                          high
                            ? "border-rose-200 bg-rose-50/60"
                            : "border-amber-200 bg-amber-50/60"
                        }`}
                      >
                        <div className="min-w-0">
                          <div className="flex flex-wrap items-center gap-2 mb-1">
                            <span
                              className={`rounded-full px-2 py-0.5 text-[10px] font-bold border ${
                                high
                                  ? "bg-rose-100 text-rose-800 border-rose-300"
                                  : "bg-amber-100 text-amber-800 border-amber-300"
                              }`}
                            >
                              {pct}% · {high ? "High" : "Medium"}
                            </span>
                            <span className="text-[10px] text-[var(--sp-muted)]">
                              {p.how}
                            </span>
                          </div>
                          <p className="text-[var(--sp-charcoal)] font-semibold truncate">
                            {p.a.name}
                            <span className="text-[var(--sp-slate)] font-mono text-[10px] ml-2">
                              Opti {p.a.sailNumber || "—"} · ILCA{" "}
                              {p.a.sailNumberIlca4 || "—"}
                            </span>
                          </p>
                          <p className="text-[var(--sp-charcoal)] font-semibold truncate">
                            {p.b.name}
                            <span className="text-[var(--sp-slate)] font-mono text-[10px] ml-2">
                              Opti {p.b.sailNumber || "—"} · ILCA{" "}
                              {p.b.sailNumberIlca4 || "—"}
                            </span>
                          </p>
                        </div>
                        <div className="flex flex-wrap gap-2 shrink-0">
                          {onMergePair && (
                            <>
                              <button
                                type="button"
                                onClick={() =>
                                  void onMergePair(p.a.id, p.b.id)
                                }
                                className="rounded-full bg-emerald-600 hover:bg-emerald-700 px-3 py-1.5 text-[10px] font-bold text-white shadow-sm"
                              >
                                Keep A · merge B
                              </button>
                              <button
                                type="button"
                                onClick={() =>
                                  void onMergePair(p.b.id, p.a.id)
                                }
                                className="rounded-full bg-emerald-700 hover:bg-emerald-800 px-3 py-1.5 text-[10px] font-bold text-white shadow-sm"
                              >
                                Keep B · merge A
                              </button>
                            </>
                          )}
                          <button
                            type="button"
                            onClick={() => ignoreDupe(p.a.id, p.b.id)}
                            className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-3 py-1.5 text-[10px] font-bold text-[var(--sp-slate)] hover:text-[var(--sp-charcoal)]"
                          >
                            Ignore
                          </button>
                        </div>
                      </li>
                    );
                  })}
                </ul>
              )}
            </div>
          )}
        </div>
      )}

      <div className="grid grid-cols-1 xl:grid-cols-5 gap-4">
        <div className="xl:col-span-3 rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-sm overflow-hidden">
          <div className="px-4 py-3 border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50">
            <h3 className="text-xs font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
              {boatClass} series ranking (national list + results)
            </h3>
          </div>
          {ranked.length === 0 ? (
            <p className="p-6 text-sm text-[var(--sp-muted)] text-center">
              No scored sailors. For ILCA 4: add sailors to the national list
              above and ensure they have ranking results ≤ {cutoff.asOf}.
            </p>
          ) : (
            <div className="overflow-x-auto max-h-[32rem] overflow-y-auto">
              <table className="w-full text-left text-xs">
                <thead className="sticky top-0 bg-[var(--sp-sailcloth)] text-[var(--sp-slate)] border-b border-[var(--sp-cool-veil)]">
                  <tr className="text-[10px] uppercase tracking-wide">
                    <th className="px-3 py-2 font-bold">#</th>
                    <th className="px-3 py-2 font-bold">Sailor</th>
                    <th className="px-3 py-2 font-bold">Gender</th>
                    <th className="px-3 py-2 font-bold">Birth year</th>
                    <th className="px-3 py-2 font-bold">Best 3 pts</th>
                    <th className="px-3 py-2 font-bold">Total</th>
                    <th className="px-3 py-2 font-bold">Events</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-[var(--sp-cool-veil)]">
                  {ranked.map((r) => (
                    <tr
                      key={r.sailorId}
                      className="text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)]/30"
                    >
                      <td className="px-3 py-2 tabular-nums font-bold text-[var(--sp-charcoal)]">
                        {r.rank}
                      </td>
                      <td className="px-3 py-2 font-semibold text-[var(--sp-charcoal)]">
                        {r.name}
                      </td>
                      <td className="px-3 py-2 text-[var(--sp-slate)]">{r.gender || "—"}</td>
                      <td className="px-3 py-2 tabular-nums text-[var(--sp-slate)]">
                        {r.birthYear ?? "—"}
                      </td>
                      <td className="px-3 py-2 tabular-nums text-[var(--sp-slate)]">
                        {r.bestThreePoints.join(" + ")}
                      </td>
                      <td className="px-3 py-2 tabular-nums font-bold text-sky-700">
                        {r.totalPoints}
                      </td>
                      <td className="px-3 py-2 text-[10px] text-[var(--sp-slate)] max-w-[14rem]">
                        {r.eventScores
                          .filter((e) => !e.isDns)
                          .map(
                            (e) => `${e.regattaName.slice(0, 12)}:${e.points}`
                          )
                          .join(" · ") || "—"}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
          <p className="px-4 py-2 text-[9px] text-[var(--sp-muted)] border-t border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/30">
            Birth year from DOB. Squad eligibility requires a verified birth year, SGP nationality, top-25 ranking, and age ≤17 in intake year {cutoff.intakeYear}.
          </p>
        </div>

        <div className="xl:col-span-2 rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-sm overflow-hidden">
          <div className="px-4 py-3 border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50 flex items-center gap-2">
            <Users className="h-4 w-4 text-orange-600" />
            <h3 className="text-xs font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
              {boatClass === "ILCA 4"
                ? "ILCA 4 squad shortlist (preview)"
                : "Squad selection (ILCA 4 only)"}
            </h3>
          </div>
          {boatClass !== "ILCA 4" ? (
            <p className="p-4 text-xs text-[var(--sp-muted)]">
              National squad rules in this tool are configured for ILCA 4.
              Switch class to ILCA 4 to preview selection.
            </p>
          ) : squad.length === 0 ? (
            <p className="p-4 text-xs text-[var(--sp-muted)]">
              No eligible sailors (need top-25 ranking + SGP nationality +
              gender + intake-year ≤ 17).
            </p>
          ) : (
            <ol className="divide-y divide-[var(--sp-cool-veil)] max-h-[32rem] overflow-y-auto">
              {squad.map((s, i) => (
                <li
                  key={s.sailorId}
                  className="px-4 py-2.5 flex items-start justify-between gap-2 text-xs hover:bg-[var(--sp-sailcloth)]/30"
                >
                  <span>
                    <span className="text-[var(--sp-muted)] tabular-nums mr-2">
                      {i + 1}.
                    </span>
                    <span className="font-semibold text-[var(--sp-charcoal)]">{s.name}</span>
                    <span className="block text-[10px] text-[var(--sp-slate)] mt-0.5">
                      Series #{s.rankingPosition} · {s.gender} ·{" "}
                      {s.totalPoints} pts
                    </span>
                  </span>
                  <span className="shrink-0 rounded-full bg-white border border-[var(--sp-cool-veil)] px-2 py-0.5 text-[9px] font-bold text-[var(--sp-slate)]">
                    {REASON_LABEL[s.reason] || s.reason}
                  </span>
                </li>
              ))}
            </ol>
          )}
          {missingEligibilityBirthYears.length > 0 && (
            <p className="border-t border-amber-200 bg-amber-50 px-4 py-3 text-[11px] leading-relaxed text-amber-900">
              {missingEligibilityBirthYears.length} top-25 SGP sailor
              {missingEligibilityBirthYears.length === 1 ? "" : "s"} {" "}
              {missingEligibilityBirthYears.length === 1 ? "is" : "are"} excluded
              from the squad preview until a birth year is recorded: {" "}
              {missingEligibilityBirthYears.map((sailor) => sailor.name).join(", ")}.
            </p>
          )}
          <p className="px-4 py-2 text-[9px] text-[var(--sp-muted)] border-t border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/30">
            {ILCA_POLICY_NOTES.squad}
          </p>
        </div>
      </div>
    </div>
  );
}
