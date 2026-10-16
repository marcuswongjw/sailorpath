export type MergeIdentityProfile = {
  id: string;
  name: string;
  parentId?: string | null;
  dob?: string | null;
  gender?: string | null;
  nationality?: string | null;
};

function gender(value: string | null | undefined) {
  const normalized = value?.trim().toUpperCase();
  return normalized === "MALE" ? "M" : normalized === "FEMALE" ? "F" : normalized;
}

/** Identity disagreements require source correction before a merge, never an override. */
export function sailorIdentityConflicts(a: MergeIdentityProfile, b: MergeIdentityProfile): string[] {
  const conflicts: string[] = [];
  if (a.parentId && b.parentId && a.parentId !== b.parentId) conflicts.push("Profiles belong to different accounts.");
  if (a.dob && b.dob && a.dob !== b.dob) conflicts.push("Dates of birth differ.");
  if (gender(a.gender) && gender(b.gender) && gender(a.gender) !== gender(b.gender)) conflicts.push("Recorded genders differ.");
  if (a.nationality && b.nationality && a.nationality.trim().toUpperCase() !== b.nationality.trim().toUpperCase()) conflicts.push("Recorded nationalities differ.");
  return conflicts;
}
