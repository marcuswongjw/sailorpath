import { eq } from "drizzle-orm";
import { regattas } from "@/db/schema";

/** Draft logbook entries and staged imports are never public profile data. */
export function publicProfileRegattaCondition() {
  return eq(regattas.status, "published");
}
