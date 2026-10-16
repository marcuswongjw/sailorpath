export const EDITORIAL_KINDS = [
  "result_report",
  "correction",
  "class_announcement",
  "product_update",
  "partner_update",
] as const;

export const EDITORIAL_STATUSES = [
  "draft",
  "in_review",
  "published",
  "archived",
] as const;

export const EDITORIAL_ACTIONS = [
  "save_draft",
  "submit_review",
  "publish",
  "archive",
] as const;

export type EditorialKind = (typeof EDITORIAL_KINDS)[number];
export type EditorialStatus = (typeof EDITORIAL_STATUSES)[number];
export type EditorialAction = (typeof EDITORIAL_ACTIONS)[number];

export type EditorialFields = {
  slug: string;
  kind: EditorialKind;
  title: string;
  summary: string;
  body: string;
  authorDisplayName: string;
  relatedClass: string | null;
  relatedRegion: string | null;
  sourceUrl: string | null;
  sourceLabel: string | null;
  tags: string[];
};

const SLUG_PATTERN = /^[a-z0-9]+(?:-[a-z0-9]+)*$/;

function requiredText(value: unknown, field: string, maxLength: number): string {
  const text = String(value ?? "").trim();
  if (!text) throw new Error(`${field} is required`);
  return text.slice(0, maxLength);
}

function optionalText(value: unknown, maxLength: number): string | null {
  const text = String(value ?? "").trim();
  return text ? text.slice(0, maxLength) : null;
}

function parseKind(value: unknown): EditorialKind {
  if (typeof value === "string" && EDITORIAL_KINDS.includes(value as EditorialKind)) {
    return value as EditorialKind;
  }
  return "product_update";
}

function parseTags(value: unknown): string[] {
  const raw = Array.isArray(value)
    ? value
    : typeof value === "string"
      ? value.split(",")
      : [];

  return [
    ...new Set(
      raw
        .map((tag) => String(tag).trim().toLowerCase())
        .filter(Boolean)
        .map((tag) => tag.slice(0, 48))
    ),
  ].slice(0, 12);
}

function parseSourceUrl(value: unknown): string | null {
  const sourceUrl = optionalText(value, 500);
  if (!sourceUrl) return null;

  try {
    const parsed = new URL(sourceUrl);
    if (parsed.protocol !== "https:" && parsed.protocol !== "http:") {
      throw new Error("unsupported protocol");
    }
  } catch {
    throw new Error("source URL must be a valid http(s) URL");
  }

  return sourceUrl;
}

/** Validates the editable fields shared by create and workflow-transition requests. */
export function parseEditorialFields(value: unknown): EditorialFields {
  const input = value && typeof value === "object" ? value as Record<string, unknown> : {};
  const slug = requiredText(input.slug, "slug", 160).toLowerCase();
  if (!SLUG_PATTERN.test(slug)) {
    throw new Error("slug must use lowercase letters, numbers and single hyphens");
  }

  const sourceUrl = parseSourceUrl(input.sourceUrl);
  const sourceLabel = optionalText(input.sourceLabel, 180);
  if (sourceLabel && !sourceUrl) {
    throw new Error("a source label requires a source URL");
  }

  return {
    slug,
    kind: parseKind(input.kind),
    title: requiredText(input.title, "title", 180),
    summary: requiredText(input.summary, "summary", 600),
    body: requiredText(input.body, "body", 20_000),
    authorDisplayName: optionalText(input.authorDisplayName, 120) ?? "SailorPath",
    relatedClass: optionalText(input.relatedClass, 120),
    relatedRegion: optionalText(input.relatedRegion, 120),
    sourceUrl,
    sourceLabel,
    tags: parseTags(input.tags),
  };
}

export function parseEditorialAction(value: unknown): EditorialAction {
  if (typeof value === "string" && EDITORIAL_ACTIONS.includes(value as EditorialAction)) {
    return value as EditorialAction;
  }
  throw new Error("unsupported editorial action");
}

/** Keeps the author/reviewer flow explicit and prevents direct draft-to-public writes. */
export function transitionEditorialStatus(
  current: EditorialStatus,
  action: EditorialAction
): EditorialStatus {
  if (action === "save_draft" && (current === "draft" || current === "in_review")) {
    return "draft";
  }
  if (action === "submit_review" && current === "draft") return "in_review";
  if (action === "publish" && current === "in_review") return "published";
  if (action === "archive" && current !== "archived") return "archived";

  throw new Error(`cannot ${action.replace(/_/g, " ")} an article in ${current} state`);
}
