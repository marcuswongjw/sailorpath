export type SelectionEventOption = {
  id: string;
  label: string;
  campaign: string;
  dates: string;
  classFamily: "optimist" | "ilca4" | "ilca6";
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
  // 2027 Optimist Gold Fleet selection events
  {
    id: "opti-csc-2027",
    label: "CSC Optimist Championships 2027",
    campaign: "Bodrum Europe Camp, IODA Worlds Part A, IODA Europeans & ROC Kosmos 2027",
    dates: "23–24 Jan 2027",
    classFamily: "optimist",
  },
  {
    id: "opti-safyc-2027",
    label: "23rd SAFYC Regatta 2027",
    campaign: "15th Bodrum International Optimist Regatta (Europe Training Camp)",
    dates: "13–14 Feb 2027",
    classFamily: "optimist",
  },
  {
    id: "opti-pulau-ujong-2027",
    label: "Pulau Ujong Regatta 2027",
    campaign: "IODA Worlds Part A, IODA Europeans & ROC Kosmos 2027",
    dates: "20–21 Feb 2027",
    classFamily: "optimist",
  },
  {
    id: "opti-sysc-2027",
    label: "Singapore Youth Sailing Championships 2027",
    campaign: "IODA Worlds Part A, IODA Europeans & ROC Kosmos 2027",
    dates: "13–15 Mar 2027",
    classFamily: "optimist",
  },
  {
    id: "opti-bodrum-2027",
    label: "15th Bodrum International Optimist Regatta 2027",
    campaign: "IODA Optimist World Championship 2027 (Part B)",
    dates: "Apr/May 2027 (TBC)",
    classFamily: "optimist",
  },
  // 2027 ILCA 4 selection events
  {
    id: "ilca4-safyc-2027",
    label: "23rd SAFYC Regatta 2027",
    campaign: "23rd Langkawi International Regatta 2027",
    dates: "30–31 Jan 2027",
    classFamily: "ilca4",
  },
  {
    id: "ilca4-csc-2027",
    label: "7th CSC ILCA Open 2027",
    campaign: "Langkawi, China Training Camp & ILCA 4 Youth Worlds Part A",
    dates: "13–14 Feb 2027",
    classFamily: "ilca4",
  },
  {
    id: "ilca4-pulau-ujong-2027",
    label: "Pulau Ujong Regatta 2027",
    campaign: "China Training Camp & ILCA 4 Youth Worlds Part A",
    dates: "20–21 Feb 2027",
    classFamily: "ilca4",
  },
  {
    id: "ilca4-sysc-2027",
    label: "Singapore Youth Sailing Championships 2027",
    campaign: "China Training Camp & ILCA 4 Youth Worlds Part A",
    dates: "13–15 Mar 2027",
    classFamily: "ilca4",
  },
  {
    id: "ilca4-langkawi-2027",
    label: "23rd Langkawi International Regatta 2027",
    campaign: "ILCA 4 Youth World Championships 2027 (Part B)",
    dates: "18–21 Mar 2027",
    classFamily: "ilca4",
  },
  {
    id: "ilca4-pesta-2027",
    label: "Pesta Sukan Regatta 2027",
    campaign: "Eastern Seaboard Regatta 2027",
    dates: "Aug 2027 (TBC)",
    classFamily: "ilca4",
  },
  {
    id: "ilca4-snsc-2027",
    label: "Singapore National Sailing Championships 2027",
    campaign: "Eastern Seaboard Regatta 2027",
    dates: "Sep 2027 (TBC)",
    classFamily: "ilca4",
  },
  // 2027 ILCA 6 selection events
  {
    id: "ilca6-safyc-2027",
    label: "23rd SAFYC Regatta 2027",
    campaign: "23rd Langkawi International Regatta 2027",
    dates: "30–31 Jan 2027",
    classFamily: "ilca6",
  },
  {
    id: "ilca6-csc-2027",
    label: "7th CSC ILCA Open 2027",
    campaign: "Langkawi & Kieler Woche 2027",
    dates: "13–14 Feb 2027",
    classFamily: "ilca6",
  },
  {
    id: "ilca6-pulau-ujong-2027",
    label: "Pulau Ujong Regatta 2027",
    campaign: "Kieler Woche 2027",
    dates: "20–21 Feb 2027",
    classFamily: "ilca6",
  },
  {
    id: "ilca6-sysc-2027",
    label: "Singapore Youth Sailing Championships 2027",
    campaign: "Kieler Woche 2027",
    dates: "13–15 Mar 2027",
    classFamily: "ilca6",
  },
  {
    id: "ilca6-kieler-woche-2027",
    label: "Kieler Woche 2027",
    campaign: "ILCA 6 Youth World Championships 2027",
    dates: "19–23 Jun 2027",
    classFamily: "ilca6",
  },
  {
    id: "ilca6-pesta-2027",
    label: "Pesta Sukan Regatta 2027",
    campaign: "Eastern Seaboard Regatta 2027",
    dates: "Aug 2027 (TBC)",
    classFamily: "ilca6",
  },
  {
    id: "ilca6-snsc-2027",
    label: "Singapore National Sailing Championships 2027",
    campaign: "Eastern Seaboard Regatta 2027",
    dates: "Sep 2027 (TBC)",
    classFamily: "ilca6",
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
  if (raw === "ilca 6" || raw === "ilca6" || raw.includes("radial")) {
    return SELECTION_EVENT_OPTIONS.filter((item) => item.classFamily === "ilca6");
  }
  if (raw === "ilca 4" || raw === "ilca4" || raw === "ilca" || raw.includes("laser")) {
    return SELECTION_EVENT_OPTIONS.filter((item) => item.classFamily === "ilca4");
  }
  if (raw.includes("ilca")) return [];
  return SELECTION_EVENT_OPTIONS;
}
