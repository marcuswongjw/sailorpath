import { getAuthContext } from "@/lib/auth";
import { ILCA4_SELECTION_SAILORS } from "@/lib/ilcaSelectionData";
import { NextResponse } from "next/server";

export async function GET() {
  const auth = await getAuthContext();
  if (!auth) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  return NextResponse.json({ sailors: ILCA4_SELECTION_SAILORS });
}
