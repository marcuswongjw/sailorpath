export const RESULT_ENTRY_TYPES = ["individual", "crew"] as const;
export type ResultEntryType = (typeof RESULT_ENTRY_TYPES)[number];

export const RESULT_PARTICIPANT_ROLES = [
  "solo",
  "helm",
  "crew",
  "member",
  "unknown",
] as const;
export type ResultParticipantRole = (typeof RESULT_PARTICIPANT_ROLES)[number];

export type ResultParticipantInput = {
  sailorId: string;
  sourceName?: string | null;
  role?: ResultParticipantRole | null;
  displayOrder?: number | null;
  rankingCredit?: boolean | null;
};

export type NormalizedResultParticipant = {
  sailorId: string;
  sourceName: string | null;
  role: ResultParticipantRole;
  displayOrder: number;
  rankingCredit: boolean;
};

export type ParticipantRule = {
  entryType: ResultEntryType;
  minParticipants: number;
  maxParticipants: number;
};

/** Classes whose result rows are boats with more than one sailor. */
export function isKnownCrewBoatClass(boatClass: unknown): boolean {
  const normalized = String(boatClass || "")
    .toLowerCase()
    .replace(/\s+/g, " ")
    .trim();
  return /\b(29er|420|470|49er|49erfx|nacra|hobie)\b/.test(normalized);
}

export type ParticipantValidation =
  | { ok: true; participants: NormalizedResultParticipant[] }
  | { ok: false; error: string };

export function isResultEntryType(value: unknown): value is ResultEntryType {
  return RESULT_ENTRY_TYPES.includes(value as ResultEntryType);
}

export function isResultParticipantRole(
  value: unknown
): value is ResultParticipantRole {
  return RESULT_PARTICIPANT_ROLES.includes(value as ResultParticipantRole);
}

/**
 * Accept the new participants[] shape, or make a legacy one-sailor payload a
 * valid individual entry. UUID and existence checks intentionally stay in the
 * route, where the database is available.
 */
export function normalizeResultParticipants(
  raw: unknown,
  legacySailorId?: unknown
): ParticipantValidation {
  const rawItems = Array.isArray(raw)
    ? raw
    : legacySailorId != null && String(legacySailorId).trim()
      ? [{ sailorId: legacySailorId, role: "solo", displayOrder: 1 }]
      : [];

  if (!rawItems.length) {
    return { ok: false, error: "At least one participant is required" };
  }

  const seen = new Set<string>();
  const participants: NormalizedResultParticipant[] = [];
  for (let index = 0; index < rawItems.length; index++) {
    const item = rawItems[index];
    if (!item || typeof item !== "object") {
      return { ok: false, error: `Participant ${index + 1} is invalid` };
    }
    const value = item as Record<string, unknown>;
    const sailorId = String(value.sailorId || "").trim();
    if (!sailorId) {
      return { ok: false, error: `Participant ${index + 1} needs a sailor profile` };
    }
    if (seen.has(sailorId)) {
      return { ok: false, error: "A sailor can only appear once in a result entry" };
    }
    seen.add(sailorId);

    const role = value.role == null || value.role === ""
      ? "unknown"
      : value.role;
    if (!isResultParticipantRole(role)) {
      return { ok: false, error: `Participant ${index + 1} has an invalid role` };
    }

    const orderRaw = value.displayOrder;
    const displayOrder =
      orderRaw == null || orderRaw === "" ? index + 1 : Number(orderRaw);
    if (!Number.isInteger(displayOrder) || displayOrder < 1) {
      return { ok: false, error: `Participant ${index + 1} has an invalid display order` };
    }

    const sourceName = String(value.sourceName || "").trim().slice(0, 240);
    participants.push({
      sailorId,
      sourceName: sourceName || null,
      role,
      displayOrder,
      rankingCredit: value.rankingCredit === true,
    });
  }

  const orders = new Set(participants.map((item) => item.displayOrder));
  if (orders.size !== participants.length) {
    return { ok: false, error: "Each participant needs a different display order" };
  }

  participants.sort((a, b) => a.displayOrder - b.displayOrder);
  return { ok: true, participants };
}

export function validateParticipantCount(
  rule: ParticipantRule,
  participants: readonly NormalizedResultParticipant[]
): string | null {
  const count = participants.length;
  if (count < rule.minParticipants || count > rule.maxParticipants) {
    const expected =
      rule.minParticipants === rule.maxParticipants
        ? `${rule.minParticipants}`
        : `${rule.minParticipants}–${rule.maxParticipants}`;
    return `${rule.entryType === "crew" ? "Crew" : "Individual"} entries need ${expected} participant${rule.maxParticipants === 1 ? "" : "s"}`;
  }
  if (rule.entryType === "individual" && count !== 1) {
    return "Individual entries need exactly one participant";
  }
  return null;
}

export function crewRuleFromRegatta(regatta: {
  entryType?: string | null;
  minParticipants?: number | null;
  maxParticipants?: number | null;
}): ParticipantRule {
  const entryType: ResultEntryType = regatta.entryType === "crew" ? "crew" : "individual";
  const defaultCount = entryType === "crew" ? 2 : 1;
  const minParticipants = Math.max(1, Number(regatta.minParticipants) || defaultCount);
  const maxParticipants = Math.max(minParticipants, Number(regatta.maxParticipants) || defaultCount);
  return { entryType, minParticipants, maxParticipants };
}
