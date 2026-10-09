/**
 * Canonical sailing-class registry.
 *
 * This is the single vocabulary used by public discovery, admin filtering,
 * imports, event hubs, and profile classification. Aliases are intentionally
 * class-scoped: similar board disciplines must never be merged by a loose
 * substring match.
 */

export type SailingClassKey =
  | "optimist"
  | "ilca4"
  | "ilca6"
  | "ilca7"
  | "wingfoil"
  | "techno293"
  | "iqfoil"
  | "windsurfing"
  | "29er";

export type SailingClassDefinition = {
  key: SailingClassKey;
  label: string;
  /** Compact accepted input tokens. See normalizeSailingClassToken. */
  aliases: readonly string[];
  /** Only classes with an implemented federation policy may be ranking-eligible. */
  supportsNationalRanking: boolean;
  /** A known single open fleet. Board disciplines keep an editable official division. */
  fixedOpenDivision?: boolean;
};

export const SAILING_CLASS_REGISTRY: readonly SailingClassDefinition[] = [
  {
    key: "optimist",
    label: "Optimist",
    aliases: ["optimist", "opti"],
    supportsNationalRanking: true,
  },
  {
    key: "ilca4",
    label: "ILCA 4",
    aliases: ["ilca4", "ilca", "laser47", "laser4p7"],
    supportsNationalRanking: true,
    fixedOpenDivision: true,
  },
  {
    key: "ilca6",
    label: "ILCA 6",
    aliases: ["ilca6", "laserradial", "radial"],
    supportsNationalRanking: true,
    fixedOpenDivision: true,
  },
  {
    key: "ilca7",
    label: "ILCA 7",
    aliases: ["ilca7", "laserstandard", "standard"],
    supportsNationalRanking: false,
    fixedOpenDivision: true,
  },
  {
    key: "wingfoil",
    label: "WingFoil",
    aliases: ["wingfoil", "wing"],
    supportsNationalRanking: false,
  },
  {
    key: "techno293",
    label: "Techno 293",
    aliases: ["techno293", "t293", "techno"],
    supportsNationalRanking: false,
  },
  {
    key: "iqfoil",
    label: "iQFOiL",
    aliases: ["iqfoil"],
    supportsNationalRanking: false,
  },
  {
    key: "windsurfing",
    label: "Windsurfing",
    aliases: ["windsurfing", "windfoil"],
    supportsNationalRanking: false,
  },
  {
    key: "29er",
    label: "29er",
    aliases: ["29er"],
    supportsNationalRanking: false,
    fixedOpenDivision: true,
  },
] as const;

export function normalizeSailingClassToken(value: string | null | undefined): string {
  return String(value || "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "");
}

function tokenMatchesDefinition(token: string, definition: SailingClassDefinition): boolean {
  if (!token) return false;

  // The broad Optimist label legitimately appears with Gold/Silver suffixes.
  if (definition.key === "optimist") {
    return token === "opti" || token.startsWith("optimist");
  }

  // Preserve explicit ILCA aliases without allowing a generic ILCA label to
  // accidentally become ILCA 6 or 7.
  if (definition.key === "ilca4") {
    return token === "ilca" || definition.aliases.some((alias) => token === alias);
  }

  // Board class labels can include a published fleet/category suffix. Keep
  // iQFOiL, WingFoil, Windfoil, and Windsurfing as independent identities.
  if (definition.key === "wingfoil") {
    return token === "wing" || token.startsWith("wingfoil");
  }
  if (definition.key === "techno293") {
    return token === "t293" || token.startsWith("techno293") || token === "techno";
  }
  if (definition.key === "iqfoil") return token.startsWith("iqfoil");
  if (definition.key === "windsurfing") {
    return token.startsWith("windsurfing") || token.startsWith("windfoil");
  }
  if (definition.key === "29er") return token.startsWith("29er");

  return definition.aliases.some((alias) => token === alias);
}

/** Resolve one value to its canonical class. Returns null for unknown classes. */
export function resolveSailingClass(
  value: string | null | undefined
): SailingClassDefinition | null {
  const token = normalizeSailingClassToken(value);
  if (!token) return null;

  // Priority prevents the untagged ILCA fallback from consuming a specific one.
  const priority: SailingClassKey[] = [
    "ilca7",
    "ilca6",
    "ilca4",
    "iqfoil",
    "wingfoil",
    "windsurfing",
    "techno293",
    "29er",
    "optimist",
  ];
  for (const key of priority) {
    const definition = SAILING_CLASS_REGISTRY.find((item) => item.key === key)!;
    if (tokenMatchesDefinition(token, definition)) return definition;
  }
  return null;
}

export function sailingClassKeyOf(value: string | null | undefined): SailingClassKey | null {
  return resolveSailingClass(value)?.key ?? null;
}

export function canonicalBoatClass(value: string | null | undefined): string {
  const raw = String(value || "").trim();
  return resolveSailingClass(raw)?.label || raw;
}

export function sailingClassLabel(value: string | null | undefined): string {
  return resolveSailingClass(value)?.label || String(value || "").trim() || "Other";
}

export function matchesSailingClass(
  value: string | null | undefined,
  requested: SailingClassKey | "all" | "ilca"
): boolean {
  if (requested === "all") return true;
  const key = sailingClassKeyOf(value);
  if (requested === "ilca") {
    return key === "ilca4" || key === "ilca6" || key === "ilca7";
  }
  return key === requested;
}

export function supportsNationalRanking(value: string | null | undefined): boolean {
  return resolveSailingClass(value)?.supportsNationalRanking === true;
}

/**
 * Classes without an approved ranking policy must carry source-confirmed
 * class/fleet, race-count, and non-ranking metadata before an import is saved.
 */
export function requiresExplicitImportMetadata(
  value: string | null | undefined
): boolean {
  const resolved = resolveSailingClass(value);
  return !resolved || !resolved.supportsNationalRanking;
}

export function hasFixedOpenDivision(value: string | null | undefined): boolean {
  return resolveSailingClass(value)?.fixedOpenDivision === true;
}
