"use client";

export type RaceObservationForm = {
  raceNumber: string;
  position: string;
  wind: string;
  note: string;
  isPrivate: boolean;
};

export type RaceObservationFormProps = {
  form: RaceObservationForm;
  editingObsId: string | null;
  obsBusy: boolean;
  obsMsg: string | null;
  ownerView: boolean;
  demoMode: boolean;
  regattaId: string;
  onFormChange: (form: RaceObservationForm) => void;
  onSave: (regattaId: string) => void;
  onCancel: () => void;
};

/**
 * Form for adding or editing a race observation inside an expanded regatta row.
 * Only shown when the viewer is the profile owner.
 */
export function RaceObservationForm({
  form,
  editingObsId,
  obsBusy,
  obsMsg,
  ownerView,
  demoMode,
  regattaId,
  onFormChange,
  onSave,
  onCancel,
}: RaceObservationFormProps) {
  if (!ownerView) return null;

  const set = (patch: Partial<RaceObservationForm>) =>
    onFormChange({ ...form, ...patch });

  return (
    <div className="rounded-lg border border-cool-veil bg-warm-white p-3 space-y-2">
      <p className="text-[12px] font-bold uppercase tracking-wider text-harbour">
        {editingObsId ? "Edit observation" : "Add observation"}
        {demoMode ? " (demo)" : ""}
      </p>
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
        <input
          value={form.raceNumber}
          onChange={(e) => set({ raceNumber: e.target.value })}
          placeholder="Race #"
          type="number"
          min={1}
          className="rounded-lg bg-sailcloth border border-cool-veil px-2.5 py-1.5 text-xs text-charcoal"
        />
        <input
          value={form.position}
          onChange={(e) => set({ position: e.target.value })}
          placeholder="Score / Place"
          type="number"
          min={1}
          className="rounded-lg bg-sailcloth border border-cool-veil px-2.5 py-1.5 text-xs text-charcoal"
        />
        <input
          value={form.wind}
          onChange={(e) => set({ wind: e.target.value })}
          placeholder="Wind (e.g. 12kt E)"
          className="col-span-2 rounded-lg bg-sailcloth border border-cool-veil px-2.5 py-1.5 text-xs text-charcoal"
        />
        <textarea
          value={form.note}
          onChange={(e) => set({ note: e.target.value })}
          placeholder="Notes, starts, tactics, gear observations..."
          rows={2}
          className="col-span-2 sm:col-span-4 rounded-lg bg-sailcloth border border-cool-veil px-2.5 py-1.5 text-xs text-charcoal"
        />
      </div>
      <div className="flex flex-wrap items-center justify-between gap-2 pt-1">
        <label className="flex items-center gap-1.5 text-xs text-slate-soft font-medium cursor-pointer">
          <input
            type="checkbox"
            checked={form.isPrivate}
            onChange={(e) => set({ isPrivate: e.target.checked })}
            className="rounded border-cool-veil text-harbour focus:ring-harbour"
          />
          Private (only you & coach can see)
        </label>
        <div className="flex items-center gap-2">
          {editingObsId && (
            <button
              type="button"
              onClick={onCancel}
              className="text-xs text-slate-soft hover:text-charcoal font-medium"
            >
              Cancel
            </button>
          )}
          <button
            type="button"
            disabled={obsBusy}
            onClick={() => onSave(regattaId)}
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
  );
}
