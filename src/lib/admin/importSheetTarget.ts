/** Server-side import target. Never guesses another class. */
export function assertImportSheetTarget(args: {
  sheet: { id: string; eventSlug: string | null } | null;
  eventSlug?: string | null;
}):
  | { ok: true; sheetId: string }
  | { ok: false; status: number; error: string } {
  if (!args.sheet) {
    return { ok: false, status: 404, error: "That class sheet was not found." };
  }
  if (args.eventSlug && args.sheet.eventSlug && args.sheet.eventSlug !== args.eventSlug) {
    return {
      ok: false,
      status: 409,
      error: "That class does not belong to this weekend.",
    };
  }
  if (args.eventSlug && !args.sheet.eventSlug) {
    return {
      ok: false,
      status: 409,
      error: "That class is not linked to this weekend.",
    };
  }
  return { ok: true, sheetId: args.sheet.id };
}
