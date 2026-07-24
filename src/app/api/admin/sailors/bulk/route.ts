import { NextResponse } from "next/server";
import { requireSuperadmin } from "@/lib/auth";

/**
 * One-time roster bulk import has been removed.
 * Use Database → Sailors (create/edit) or regatta Excel import for new guests.
 */
export async function POST() {
  await requireSuperadmin();
  return NextResponse.json(
    {
      error:
        "Sailor roster bulk import has been removed. Use Database → Sailors or Regatta Excel import.",
    },
    { status: 410 }
  );
}
