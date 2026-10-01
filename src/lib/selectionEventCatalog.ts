export type SelectionEventOption = {
  id: string;
  label: string;
  campaign: string;
  dates: string;
  classFamily: "optimist" | "ilca4";
};

/** Selection events an admin can attach to one class sheet. */
export const SELECTION_EVENT_OPTIONS: SelectionEventOption[] = [
  {
    id: "ssf-trials-2026",
    label: "SSF Selection Trials",
    campaign: "Optimist Asian & Oceania and Perth Camp",
    dates: "22–30 Aug 2026",
    classFamily: "optimist",
  },
  {
    id: "snsc-2026",
    label: "Singapore National Sailing Championships",
    campaign: "Optimist Asian & Oceania and Perth Camp",
    dates: "11–13 Sep 2026",
    classFamily: "optimist",
  },
  {
    id: "ilca4-pesta-2026",
    label: "Pesta Sukan Regatta",
    campaign: "ILCA 4 Eastern Seaboard",
    dates: "1–2 Aug 2026",
    classFamily: "ilca4",
  },
  {
    id: "ilca4-snsc-2026",
    label: "Singapore National Sailing Championships",
    campaign: "ILCA 4 Eastern Seaboard and Asian Open",
    dates: "11–13 Sep 2026",
    classFamily: "ilca4",
  },
  {
    id: "ilca4-selection-trials-2026",
    label: "ILCA 4 Selection Trials",
    campaign: "ILCA Asian Open",
    dates: "10, 11, 17 and 18 Oct 2026",
    classFamily: "ilca4",
  },
];

export function isKnownSelectionEventId(id: string): boolean {
  return SELECTION_EVENT_OPTIONS.some((item) => item.id === id);
}

export function selectionEventsForBoatClass(
  boatClass: string | null | undefined
): SelectionEventOption[] {
  const raw = String(boatClass || "").trim().toLowerCase();
  if (raw.includes("optimist")) {
    return SELECTION_EVENT_OPTIONS.filter((item) => item.classFamily === "optimist");
  }
  if (raw === "ilca 4" || raw === "ilca" || raw.includes("laser")) {
    return SELECTION_EVENT_OPTIONS.filter((item) => item.classFamily === "ilca4");
  }
  if (raw.includes("ilca")) return [];
  return SELECTION_EVENT_OPTIONS;
}
