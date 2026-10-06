export type ImportTarget = {
  id: string;
  slug: string;
  eventId?: string | null;
};

export const NEW_IMPORT_TARGET = "new-regatta";

export type ImportTargetResolution<T extends ImportTarget> =
  | { kind: "target"; target: T }
  | { kind: "selection-required" }
  | { kind: "selected-target-not-found" }
  | { kind: "new-regatta" };

function belongsToAnotherEvent<T extends ImportTarget>(
  candidate: T | null | undefined,
  requestedEventId: string | null | undefined
): boolean {
  if (!candidate || !requestedEventId) return false;
  return candidate.eventId != null && candidate.eventId !== requestedEventId;
}

/**
 * Sailors an authoritative class replace must keep. The chosen profile
 * receives the uploaded finish. Exact-name siblings and close name
 * suggestions stay too, so one chosen profile cannot delete their finish.
 */
export function sailorsKeptOnAuthoritativeReplace(
  chosenSailorIds: readonly string[],
  exactNameProfileIds: readonly string[]
): string[] {
  return [...new Set([...chosenSailorIds, ...exactNameProfileIds])];
}

/**
 * Resolves an event for an import without relying on database row order.
 * A different title always requires an explicit choice, even with one candidate.
 * A sheet that already belongs to another weekend is not a candidate.
 */
export function resolveImportTarget<T extends ImportTarget>(args: {
  sameDay: T[];
  incomingSlug: string;
  slugMatch: T | null;
  selectedId: string | null | undefined;
  requestedEventId?: string | null;
}): ImportTargetResolution<T> {
  const eligibleSameDay = args.requestedEventId
    ? args.sameDay.filter(
        (candidate) =>
          candidate.eventId == null ||
          candidate.eventId === args.requestedEventId
      )
    : args.sameDay;
  const exactSameDay = eligibleSameDay.find(
    (candidate) => candidate.slug === args.incomingSlug
  );

  // A slug-only match that is not among the same-day (same class/division)
  // candidates is a *different* event that happens to share name + date.
  // It must not silently absorb this import, and it must not block an
  // explicit "create separate event" choice. An exact slug on another
  // weekend is the same kind of miss: create the class on the requested weekend.
  const slugMatchId = args.slugMatch?.id;
  const slugMatchIsSameEvent =
    slugMatchId != null &&
    eligibleSameDay.some((candidate) => candidate.id === slugMatchId);

  if (args.selectedId === NEW_IMPORT_TARGET && !exactSameDay) {
    return { kind: "new-regatta" };
  }

  if (exactSameDay) return { kind: "target", target: exactSameDay };

  if (args.selectedId) {
    const selected = eligibleSameDay.find(
      (candidate) => candidate.id === args.selectedId
    );
    return selected
      ? { kind: "target", target: selected }
      : { kind: "selected-target-not-found" };
  }

  if (eligibleSameDay.length > 0) return { kind: "selection-required" };
  if (slugMatchIsSameEvent && args.slugMatch) {
    return { kind: "target", target: args.slugMatch };
  }
  // Same name + date under a different class/division on this weekend:
  // require an explicit choice instead of silently updating that sheet.
  // A slug owned by another weekend does not block a new class here.
  if (args.slugMatch && !belongsToAnotherEvent(args.slugMatch, args.requestedEventId)) {
    return { kind: "selection-required" };
  }
  return { kind: "new-regatta" };
}
