import { readFile } from "node:fs/promises";
import path from "node:path";
import { eq } from "drizzle-orm";
import { db } from "@/db";
import { sailors } from "@/db/schema";
import { getAuthContext } from "@/lib/auth";
import { canManageSailor } from "@/lib/claimAccess";
import { avatarObjectPath, isPhotoSailorId, portraitAsset } from "@/lib/profilePhoto";
import { createServerSupabase } from "@/lib/supabase/server";

export const dynamic = "force-dynamic";
const HEADERS = { "Cache-Control": "private, no-store, max-age=0", "X-Content-Type-Options": "nosniff", "Vary": "Cookie" };
const missing = () => Response.json({ error: "Photo not found" }, { status: 404, headers: HEADERS });

function detectImageType(type: string | null | undefined, objectPath: string, buffer?: Uint8Array): string | null {
  if (type === "image/jpeg" || type === "image/jpg") return "image/jpeg";
  if (type === "image/png") return "image/png";
  if (type === "image/webp") return "image/webp";
  if (buffer && buffer.length >= 4) {
    if (buffer[0] === 0xff && buffer[1] === 0xd8 && buffer[2] === 0xff) return "image/jpeg";
    if (buffer[0] === 0x89 && buffer[1] === 0x50 && buffer[2] === 0x4e && buffer[3] === 0x47) return "image/png";
    if (buffer[0] === 0x52 && buffer[1] === 0x49 && buffer[2] === 0x46 && buffer[3] === 0x46) return "image/webp";
  }
  const lower = objectPath.toLowerCase();
  if (lower.endsWith(".jpg") || lower.endsWith(".jpeg")) return "image/jpeg";
  if (lower.endsWith(".png")) return "image/png";
  if (lower.endsWith(".webp")) return "image/webp";
  return null;
}

/** Public photo endpoint: serves published athlete photos or authorized owner views. */
export async function GET(_request: Request, context: { params: Promise<{ id: string }> }) {
  try {
    const { id } = await context.params;
    if (!isPhotoSailorId(id)) return missing();
    const [sailor] = await db
      .select({
        avatarUrl: sailors.avatarUrl,
        parentId: sailors.parentId,
        isPublic: sailors.showProfilePhotoOnPublicProfile,
      })
      .from(sailors)
      .where(eq(sailors.id, id))
      .limit(1);
    if (!sailor?.avatarUrl) return missing();
    if (!sailor.isPublic) {
      const auth = await getAuthContext();
      if (!auth || !await canManageSailor(id, auth.userId, auth.role === "superadmin", sailor.parentId)) return missing();
    }
    const asset = portraitAsset(sailor.avatarUrl);
    if (asset) {
      const bytes = await readFile(path.join(process.cwd(), "private/athlete-portraits", asset.folder, asset.file));
      return new Response(new Uint8Array(bytes), { headers: { ...HEADERS, "Content-Type": asset.file.endsWith(".png") ? "image/png" : asset.file.endsWith(".webp") ? "image/webp" : "image/jpeg" } });
    }
    const storageUrl = (process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL || "").replace(/\/$/, "");
    const object = avatarObjectPath(sailor.avatarUrl, id, storageUrl);
    if (!object) return missing();
    const supabase = await createServerSupabase();

    let bodyBytes: Uint8Array | null = null;
    let contentType: string | null = null;

    // 1. Primary SDK download (covers standard setups and mocked test suites)
    try {
      const { data, error } = await supabase.storage.from("avatars").download(object);
      if (!error && data) {
        const detected = detectImageType(data.type, object);
        if (detected) {
          bodyBytes = new Uint8Array(await data.arrayBuffer());
          contentType = detected;
        }
      }
    } catch {
      // Fall through to authenticated endpoint
    }

    // 2. Fallback: Supabase Storage authenticated endpoint (/storage/v1/object/authenticated/).
    // RLS policy "Avatar consent read" explicitly requires storage.allow_any_operation(ARRAY['storage.object.get_authenticated', 'storage.render.image_authenticated']).
    if (!bodyBytes || !contentType) {
      try {
        const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY || "";
        const sessionRes = await supabase.auth?.getSession?.().catch(() => null);
        const token = sessionRes?.data?.session?.access_token || anonKey;
        const authUrl = `${storageUrl}/storage/v1/object/authenticated/avatars/${object}`;
        const res = await fetch(authUrl, {
          headers: {
            apikey: anonKey,
            Authorization: `Bearer ${token}`,
          },
          cache: "no-store",
        });
        if (res.ok) {
          const ab = await res.arrayBuffer();
          const bytes = new Uint8Array(ab);
          const detected = detectImageType(res.headers.get("content-type"), object, bytes);
          if (detected) {
            bodyBytes = bytes;
            contentType = detected;
          }
        }
      } catch (fetchErr) {
        console.warn("[profile-photo] authenticated fetch fallback failed:", fetchErr);
      }
    }

    if (!bodyBytes || !contentType) return missing();
    return new Response(Buffer.from(bodyBytes), { headers: { ...HEADERS, "Content-Type": contentType } });
  } catch (error) {
    console.error("[profile-photo]", error);
    return Response.json({ error: "Photo temporarily unavailable" }, { status: 503, headers: HEADERS });
  }
}
