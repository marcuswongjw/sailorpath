export type ImportTarget = {
  id: string;
  slug: string;
};

export type ImportTargetResolution<T extends ImportTarget> =
  | { kind: "target"; target: T }
  | { kind: "selection-required" }
  | { kind: "selected-target-not-found" }
  | { kind: "new-regatta" };

/**
 * Resolves an event for an import without relying on database row order.
 * A renamed upload may reuse the sole same-day event, but multiple same-day
 * candidates require an explicit administrator selection.
 */
export function resolveImportTarget<T extends ImportTarget>(args: {
  sameDay: T[];
  incomingSlug: string;
  slugMatch: T | null;
  selectedId: string | null | undefined;
}): ImportTargetResolution<T> {
  const exactSameDay = args.sameDay.find(
    (candidate) => candidate.slug === args.incomingSlug
  );
  if (exactSameDay) return { kind: "target", target: exactSameDay };

  if (args.selectedId) {
    const selected = args.sameDay.find(
      (candidate) => candidate.id === args.selectedId
    );
    return selected
      ? { kind: "target", target: selected }
      : { kind: "selected-target-not-found" };
  }

  if (args.sameDay.length === 1) {
    return { kind: "target", target: args.sameDay[0] };
  }
  if (args.sameDay.length > 1) return { kind: "selection-required" };
  if (args.slugMatch) return { kind: "target", target: args.slugMatch };
  return { kind: "new-regatta" };
}
