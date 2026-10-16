import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";

export async function POST() {
  try {
    await requireSuperadmin();
    return NextResponse.json({
      code: "PAIR_REVIEW_REQUIRED",
      error: "Automatic name-based merging has been retired. Review each explicit survivor/source pair and its official identity evidence.",
    }, { status: 409 });
  } catch (error) { return jsonError(error); }
}
