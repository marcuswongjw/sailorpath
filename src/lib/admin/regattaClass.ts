/** Admin-only class families. Public sailorpath.com is unchanged. */

import {
  matchesSailingClass,
  resolveSailingClass,
  sailingClassKeyOf,
} from "@/lib/classRegistry";

export type RegattaClassFamily =
  | "all"
  | "optimist"
  | "ilca"
  | "wingfoil"
  | "iqfoil"
  | "29er"
  | "techno";

export const REGATTA_CLASS_FAMILIES: { id: RegattaClassFamily; label: string }[] = [
  { id: "all", label: "All classes" },
  { id: "optimist", label: "Optimist" },
  { id: "ilca", label: "ILCA" },
  { id: "wingfoil", label: "WingFoil" },
  { id: "iqfoil", label: "iQFOiL" },
  { id: "29er", label: "29er" },
  { id: "techno", label: "Techno 293" },
];

/** Fleets inside a class, the way Gold and Silver sit inside Optimist. */
export const OPTIMIST_FLEETS = ["Gold", "Silver", "Both", "NonRanking"] as const;
export const ILCA_FLEETS = ["ILCA 4", "ILCA 6", "ILCA 7"] as const;

export type ClassBoatButton = { family: string; boatClass: string };

export const ADMIN_BOAT_CLASS_GROUPS: { family: string; classes: string[] }[] = [
  { family: "Optimist", classes: ["Optimist"] },
  { family: "ILCA", classes: ["ILCA 4", "ILCA 6", "ILCA 7"] },
  { family: "29er", classes: ["29er"] },
  { family: "WingFoil", classes: ["WingFoil"] },
  { family: "iQFOiL", classes: ["iQFOiL"] },
  { family: "Techno 293", classes: ["Techno 293"] },
];

export function regattaClassFamily(
  boatClass: string | null | undefined
): Exclude<RegattaClassFamily, "all"> | "other" {
  if (!String(boatClass || "").trim()) return "optimist";
  const key = sailingClassKeyOf(boatClass);
  if (key === "optimist") return "optimist";
  if (key === "ilca4" || key === "ilca6" || key === "ilca7") return "ilca";
  if (key === "29er") return "29er";
  if (key === "wingfoil") return "wingfoil";
  if (key === "iqfoil") return "iqfoil";
  if (key === "techno293") return "techno";
  return "other";
}

/** ILCA 4, 6, or 7. Untagged "ILCA" / "Laser" stays with ILCA 4. */
export function ilcaFleetOf(boatClass: string | null | undefined): (typeof ILCA_FLEETS)[number] | null {
  const key = sailingClassKeyOf(boatClass);
  if (key === "ilca7") return "ILCA 7";
  if (key === "ilca6") return "ILCA 6";
  if (key === "ilca4") return "ILCA 4";
  return null;
}

/** Classes shown on a sailor's results list. ILCA 4, 6, and 7 are separate. */
export const SAILOR_RESULT_CLASSES = [
  { id: "optimist", label: "Optimist" },
  { id: "ilca4", label: "ILCA 4" },
  { id: "ilca6", label: "ILCA 6" },
  { id: "ilca7", label: "ILCA 7" },
  { id: "29er", label: "29er" },
  { id: "wingfoil", label: "WingFoil" },
  { id: "iqfoil", label: "iQFOiL" },
  { id: "techno", label: "Techno 293" },
] as const;

export type SailorResultClassId =
  | (typeof SAILOR_RESULT_CLASSES)[number]["id"]
  | "other";

/** One result's class. A blank boat class stays Optimist. Untagged ILCA stays ILCA 4. */
export function sailorResultClassOf(boatClass: string | null | undefined): {
  id: SailorResultClassId;
  label: string;
} {
  const fleet = ilcaFleetOf(boatClass);
  if (fleet === "ILCA 7") return { id: "ilca7", label: "ILCA 7" };
  if (fleet === "ILCA 6") return { id: "ilca6", label: "ILCA 6" };
  if (fleet === "ILCA 4") return { id: "ilca4", label: "ILCA 4" };
  const classKey = resolveSailingClass(boatClass)?.key;
  const family =
    classKey === "techno293" ? "techno" : regattaClassFamily(boatClass);
  const known = SAILOR_RESULT_CLASSES.find((item) => item.id === family);
  if (known) return { id: known.id, label: known.label };
  const label = String(boatClass || "").trim();
  return { id: "other", label: label || "Other" };
}

export function regattaMatchesAdminClass(input: {
  boatClass?: string | null;
  division?: string | null;
  family: string;
  fleet: string;
}): boolean {
  const family = regattaClassFamily(input.boatClass);
  if (input.family !== "all" && family !== input.family) return false;

  if (input.fleet === "all") return true;

  if ((ILCA_FLEETS as readonly string[]).includes(input.fleet)) {
    return ilcaFleetOf(input.boatClass) === input.fleet;
  }

  if (input.family === "iqfoil") {
    return matchesSailingClass(input.boatClass, "iqfoil");
  }

  return String(input.division || "Gold") === input.fleet;
}
