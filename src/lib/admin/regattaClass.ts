/** Admin-only class families. Public sailorpath.com is unchanged. */

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

function compact(value: string): string {
  return value.toLowerCase().replace(/[\s._-]+/g, "");
}

export function regattaClassFamily(
  boatClass: string | null | undefined
): Exclude<RegattaClassFamily, "all"> | "other" {
  const bc = String(boatClass || "").toLowerCase();
  const a = compact(bc);
  if (!bc || bc.includes("optimist") || a === "opti") return "optimist";
  if (a.includes("29er")) return "29er";
  if (a.includes("wingfoil")) return "wingfoil";
  if (a.includes("iqfoil")) return "iqfoil";
  if (a.includes("techno")) return "techno";
  if (/ilca|laser|radial/.test(bc)) return "ilca";
  return "other";
}

/** ILCA 4, 6, or 7. Untagged "ILCA" / "Laser" stays with ILCA 4. */
export function ilcaFleetOf(boatClass: string | null | undefined): (typeof ILCA_FLEETS)[number] | null {
  const raw = String(boatClass || "");
  const a = compact(raw);
  if (!a) return null;
  if (a.includes("ilca7") || a.includes("laserstandard")) return "ILCA 7";
  if (a.includes("ilca6") || a.includes("laserradial") || a === "radial") return "ILCA 6";
  if (/ilca|laser/.test(raw.toLowerCase())) return "ILCA 4";
  return null;
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

  return String(input.division || "Gold") === input.fleet;
}
