export type JsonValue =
  | string
  | number
  | boolean
  | null
  | JsonValue[]
  | { [key: string]: JsonValue };

const MAX_AUDIT_DETAILS_LENGTH = 8_000;

/** Accept both live JSONB values and legacy JSON-encoded text values. */
export function normalizeAdminAuditDetails(value: unknown): JsonValue | null {
  if (value === null || value === undefined) return null;

  if (typeof value === "string") {
    try {
      return JSON.parse(value) as JsonValue;
    } catch {
      return value;
    }
  }

  if (
    typeof value === "object" ||
    typeof value === "number" ||
    typeof value === "boolean"
  ) {
    return value as JsonValue;
  }

  return null;
}

export function formatAdminAuditDetails(value: unknown): string | null {
  const details = normalizeAdminAuditDetails(value);
  if (details === null) return null;

  try {
    return JSON.stringify(details, null, 2) ?? null;
  } catch {
    return null;
  }
}

export function adminAuditRegattaId(value: unknown): string | null {
  const details = normalizeAdminAuditDetails(value);
  if (
    details === null ||
    typeof details !== "object" ||
    Array.isArray(details)
  ) {
    return null;
  }

  const regattaId = (details as { regattaId?: JsonValue }).regattaId;
  return typeof regattaId === "string" && regattaId.trim()
    ? regattaId
    : null;
}

/**
 * Convert arbitrary audit input to a JSONB-safe value. Keep the stored payload
 * bounded without truncating JSON into invalid syntax.
 */
export function toAdminAuditJsonValue(
  value: unknown,
  maxSerializedLength = MAX_AUDIT_DETAILS_LENGTH
): JsonValue | null {
  if (value === undefined) return null;

  try {
    const serialized = JSON.stringify(value);
    if (serialized === undefined) return null;

    if (serialized.length <= maxSerializedLength) {
      return JSON.parse(serialized) as JsonValue;
    }

    return {
      truncated: true,
      preview: serialized.slice(0, Math.max(0, maxSerializedLength - 48)),
    };
  } catch {
    return null;
  }
}
