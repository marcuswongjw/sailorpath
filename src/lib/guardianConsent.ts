/** Unknown or invalid ages require guardian consent too. Uses Singapore's date. */
export function requiresGuardianConsent(dob: string | null | undefined, asOf = new Date()): boolean {
  const date = String(dob || "").slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(date)) return true;
  const parsed = new Date(`${date}T00:00:00Z`);
  if (!Number.isFinite(parsed.getTime()) || parsed.toISOString().slice(0, 10) !== date) return true;
  const today = new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Singapore", year: "numeric", month: "2-digit", day: "2-digit",
  }).format(asOf);
  const eighteenthBirthday = `${Number(date.slice(0, 4)) + 18}${date.slice(4)}`;
  return today < eighteenthBirthday;
}
