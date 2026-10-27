import { NextResponse } from "next/server";
import { createServerSupabase } from "@/lib/supabase/server";
import { ensureProfileForUser } from "@/lib/queries";
import { jsonError } from "@/lib/auth";

export async function POST() {
  try {
    const supabase = await createServerSupabase();
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: "Not signed in" }, { status: 401 });
    }
    const result = await ensureProfileForUser(user);
    return NextResponse.json(result);
  } catch (e) {
    return jsonError(e);
  }
}
