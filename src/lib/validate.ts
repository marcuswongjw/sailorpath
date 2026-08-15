/**
 * Shared runtime payload guards for API routes.
 * Prefer these over ad-hoc Number()/String() across admin + public writes.
 */

export function asString(
  v: unknown,
  max: number
): string | null {
  if (v === null || v === undefined) return null;
  const s = String(v).trim();
  if (!s) return null;
  return s.length > max ? s.slice(0, max) : s;
}

export function asRequiredString(
  v: unknown,
  max: number,
  field = "value"
): { ok: true; value: string } | { ok: false; error: string } {
  const s = asString(v, max);
  if (!s) return { ok: false, error: `${field} is required` };
  return { ok: true, value: s };
}

const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

export function asUuid(
  v: unknown,
  field = "id"
): { ok: true; value: string } | { ok: false; error: string } {
  const s = asString(v, 36);
  if (!s || !UUID_RE.test(s)) {
    return { ok: false, error: `${field} must be a valid UUID` };
  }
  return { ok: true, value: s };
}

export function asOptionalUuid(
  v: unknown,
  field = "id"
): { ok: true; value: string | null } | { ok: false; error: string } {
  if (v === null || v === undefined || v === "") {
    return { ok: true, value: null };
  }
  return asUuid(v, field);
}

/** YYYY-MM-DD */
export function asYmd(
  v: unknown,
  field = "date"
): { ok: true; value: string } | { ok: false; error: string } {
  const s = asString(v, 10);
  if (!s || !/^\d{4}-\d{2}-\d{2}$/.test(s)) {
    return { ok: false, error: `${field} must be YYYY-MM-DD` };
  }
  const t = Date.parse(`${s}T12:00:00Z`);
  if (Number.isNaN(t)) {
    return { ok: false, error: `${field} is not a valid calendar date` };
  }
  return { ok: true, value: s };
}

export function asOptionalYmd(
  v: unknown,
  field = "date"
): { ok: true; value: string | null } | { ok: false; error: string } {
  if (v === null || v === undefined || v === "") {
    return { ok: true, value: null };
  }
  return asYmd(v, field);
}

/** Integer rank ≥ 1 (finishing place / DNS points). */
export function asRank(
  v: unknown,
  field = "rank"
): { ok: true; value: number } | { ok: false; error: string } {
  if (v === null || v === undefined || v === "") {
    return { ok: false, error: `${field} is required` };
  }
  const n = Math.round(Number(v));
  if (!Number.isFinite(n) || n < 1 || n > 10_000) {
    return { ok: false, error: `${field} must be an integer from 1 to 10000` };
  }
  return { ok: true, value: n };
}

export function asOptionalNumber(
  v: unknown,
  opts?: { min?: number; max?: number; field?: string }
): { ok: true; value: number | null } | { ok: false; error: string } {
  const field = opts?.field || "value";
  if (v === null || v === undefined || v === "") {
    return { ok: true, value: null };
  }
  const n = Number(v);
  if (!Number.isFinite(n)) {
    return { ok: false, error: `${field} must be a number` };
  }
  if (opts?.min != null && n < opts.min) {
    return { ok: false, error: `${field} must be ≥ ${opts.min}` };
  }
  if (opts?.max != null && n > opts.max) {
    return { ok: false, error: `${field} must be ≤ ${opts.max}` };
  }
  return { ok: true, value: n };
}

export function asEmail(
  v: unknown
): { ok: true; value: string } | { ok: false; error: string } {
  const s = asString(v, 254)?.toLowerCase() ?? null;
  if (!s || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(s)) {
    return { ok: false, error: "Valid email required" };
  }
  return { ok: true, value: s };
}

export function asHttpUrl(
  v: unknown,
  field = "url",
  max = 500
): { ok: true; value: string | null } | { ok: false; error: string } {
  if (v === null || v === undefined || v === "") {
    return { ok: true, value: null };
  }
  const s = asString(v, max);
  if (!s || !/^https?:\/\//i.test(s)) {
    return { ok: false, error: `${field} must start with http:// or https://` };
  }
  try {
    // eslint-disable-next-line no-new
    new URL(s);
  } catch {
    return { ok: false, error: `${field} is not a valid URL` };
  }
  return { ok: true, value: s };
}

export function asBoundedText(
  v: unknown,
  opts: { min?: number; max: number; field?: string; required?: boolean }
): { ok: true; value: string | null } | { ok: false; error: string } {
  const field = opts.field || "text";
  if (v === null || v === undefined || v === "") {
    if (opts.required) return { ok: false, error: `${field} is required` };
    return { ok: true, value: null };
  }
  const s = String(v).trim();
  if (opts.min != null && s.length < opts.min) {
    return {
      ok: false,
      error: `${field} must be at least ${opts.min} characters`,
    };
  }
  if (s.length > opts.max) {
    return {
      ok: false,
      error: `${field} must be at most ${opts.max} characters`,
    };
  }
  return { ok: true, value: s };
}
