import { readFile } from "node:fs/promises";
import path from "node:path";
import { eq } from "drizzle-orm";
import { db } from "@/db";
import { sailors } from "@/db/schema";
import { getAuthContext } from "@/lib/auth";
import { canManageSailor } from "@/lib/claimAccess";
import { avatarObjectPath, isPhotoSailorId, portraitFile } from "@/lib/profilePhoto";
import { createServerSupabase } from "@/lib/supabase/server";

export const dynamic = "force-dynamic";
const HEADERS = { "Cache-Control": "private, no-store, max-age=0", "X-Content-Type-Options": "nosniff", "Vary": "Cookie" };
const missing = () => Response.json({ error: "Photo not found" }, { status: 404, headers: HEADERS });

/** No redirects or signed URLs: visibility is checked for every byte response. */
export async function GET(_request: Request, context: { params: Promise<{ id: string }> }) {
  try {
    const { id } = await context.params;
    if (!isPhotoSailorId(id)) return missing();
    // Deliberately uncached: a stale public profile must not keep a hidden photo readable.
    const [sailor] = await db.select({ avatarUrl: sailors.avatarUrl, parentId: sailors.parentId,
      isPublic: sailors.showProfilePhotoOnPublicProfile }).from(sailors).where(eq(sailors.id, id)).limit(1);
    if (!sailor?.avatarUrl) return missing();
    if (!sailor.isPublic) {
      const auth = await getAuthContext();
      if (!auth || !await canManageSailor(id, auth.userId, auth.role === "superadmin", sailor.parentId)) return missing();
    }
    const file = portraitFile(sailor.avatarUrl);
    if (file) {
      const bytes = await readFile(path.join(process.cwd(), "private/athlete-portraits/team-singapore", file));
      return new Response(new Uint8Array(bytes), { headers: { ...HEADERS, "Content-Type": file.endsWith(".png") ? "image/png" : file.endsWith(".webp") ? "image/webp" : "image/jpeg" } });
    }
    const storageUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL || "";
    const object = avatarObjectPath(sailor.avatarUrl, id, storageUrl);
    if (!object) return missing();
    const supabase = await createServerSupabase();
    // RLS independently checks current consent or this user's approved claim.
    const { data, error } = await supabase.storage.from("avatars").download(object);
    if (error || !data || !["image/jpeg", "image/png", "image/webp"].includes(data.type)) return missing();
    return new Response(data, { headers: { ...HEADERS, "Content-Type": data.type } });
  } catch (error) {
    console.error("[profile-photo]", error);
    return Response.json({ error: "Photo temporarily unavailable" }, { status: 503, headers: HEADERS });
  }
}
