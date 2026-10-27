import { getAuthContext } from "@/lib/auth";
import { isEvidenceObjectPath } from "@/lib/evidenceDownload";
import { createServerSupabase } from "@/lib/supabase/server";

export const dynamic = "force-dynamic";
const PRIVATE_HEADERS = { "Cache-Control": "private, no-store", "X-Content-Type-Options": "nosniff" };

/** Storage RLS permits the uploader and superadmins; a URL alone grants nothing. */
export async function GET(request: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) return Response.json({ error: "Sign in required" }, { status: 401, headers: PRIVATE_HEADERS });
    const path = new URL(request.url).searchParams.get("path") || "";
    if (!isEvidenceObjectPath(path)) return Response.json({ error: "Invalid evidence path" }, { status: 400, headers: PRIVATE_HEADERS });
    if (path.split("/")[0].toLowerCase() !== auth.userId.toLowerCase() && auth.role !== "superadmin") {
      return Response.json({ error: "Evidence not found or access denied" }, { status: 404, headers: PRIVATE_HEADERS });
    }
    const supabase = await createServerSupabase();
    // Use this user's JWT, never a service-role key. RLS is a second access check.
    const { data, error } = await supabase.storage.from("regatta-evidence").download(path);
    if (error || !data) return Response.json({ error: "Evidence not found or access denied" }, { status: 404, headers: PRIVATE_HEADERS });
    return new Response(data, { headers: {
      ...PRIVATE_HEADERS, "Content-Type": data.type || "application/octet-stream",
      "Content-Disposition": `attachment; filename="${path.split("/").pop()}"`,
    } });
  } catch {
    return Response.json({ error: "Evidence is temporarily unavailable" }, { status: 503, headers: PRIVATE_HEADERS });
  }
}
