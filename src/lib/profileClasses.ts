import { sailingClassKeyOf } from "@/lib/classRegistry";

export const PROFILE_ILCA_CLASSES = ["ilca4", "ilca6", "ilca7"] as const;
export type ProfileIlcaClass = typeof PROFILE_ILCA_CLASSES[number];
export function isProfileIlcaClass(value: string): value is ProfileIlcaClass {
  return (PROFILE_ILCA_CLASSES as readonly string[]).includes(value);
}
export function profileIlcaClassOf(value: string | null | undefined): ProfileIlcaClass | null {
  const key = sailingClassKeyOf(value);
  return key && isProfileIlcaClass(key) ? key : null;
}
export function profileIlcaLabel(key: ProfileIlcaClass): "ILCA 4" | "ILCA 6" | "ILCA 7" {
  return key === "ilca6" ? "ILCA 6" : key === "ilca7" ? "ILCA 7" : "ILCA 4";
}
