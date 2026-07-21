/**
 * Whole-year age from DOB (YYYY-MM-DD or Date), or null if unknown.
 */
export function ageYears(
  dob: string | Date | null | undefined,
  asOf: Date = new Date()
): number | null {
  if (dob == null || dob === "") return null;
  const s = typeof dob === "string" ? dob.slice(0, 10) : dob.toISOString().slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(s)) return null;
  const birth = new Date(`${s}T12:00:00`);
  if (Number.isNaN(birth.getTime())) return null;
  let age = asOf.getFullYear() - birth.getFullYear();
  const m = asOf.getMonth() - birth.getMonth();
  if (m < 0 || (m === 0 && asOf.getDate() < birth.getDate())) age--;
  if (age < 0 || age > 120) return null;
  return age;
}
