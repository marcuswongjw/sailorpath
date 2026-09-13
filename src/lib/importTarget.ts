export type ImportTarget = {
  id: string;
  slug: string;
};

export const NEW_IMPORT_TARGET = "new-regatta";

export type ImportTargetResolution<T extends ImportTarget> =
  | { kind: "target"; target: T }
  | { kind: "selection-required" }
  | { kind: "selected-target-not-found" }
  | { kind: "new-regatta" };

/**
 * Resolves an event for an import without relying on database row order.
 * A different title always requires an explicit choice, even with one candidate.
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

  if (args.selectedId === NEW_IMPORT_TARGET && !args.slugMatch) return { kind: "new-regatta" };

  if (args.selectedId) {
    const selected = args.sameDay.find(
      (candidate) => candidate.id === args.selectedId
    );
    return selected
      ? { kind: "target", target: selected }
      : { kind: "selected-target-not-found" };
  }

  if (args.sameDay.length > 0) return { kind: "selection-required" };
  if (args.slugMatch) return { kind: "target", target: args.slugMatch };
  return { kind: "new-regatta" };
}
