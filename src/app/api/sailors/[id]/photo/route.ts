import { readFile } from "node:fs/promises";
import path from "node:path";
import { eq, sql } from "drizzle-orm";
import { db } from "@/db";
import { sailors } from "@/db/schema";
import { getAuthContext } from "@/lib/auth";
import { canManageSailor } from "@/lib/claimAccess";
import { avatarObjectPath, isPhotoSailorId, portraitAsset } from "@/lib/profilePhoto";
import { createServerSupabase } from "@/lib/supabase/server";

export const dynamic = "force-dynamic";
const HEADERS = { "Cache-Control": "private, no-store, max-age=0", "X-Content-Type-Options": "nosniff", "Vary": "Cookie" };
const missing = (reason?: string, details?: Record<string, string>) =>
  Response.json(
    { error: "Photo not found" },
    {
      status: 404,
      headers: {
        ...HEADERS,
        ...(reason ? { "X-Photo-Missing-Reason": reason } : {}),
        ...details,
      },
    }
  );

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
    if (!isPhotoSailorId(id)) return missing("invalid-sailor-id");
    const [sailor] = await db
      .select({
        avatarUrl: sailors.avatarUrl,
        parentId: sailors.parentId,
        isPublic: sailors.showProfilePhotoOnPublicProfile,
      })
      .from(sailors)
      .where(eq(sailors.id, id))
      .limit(1);
    if (!sailor?.avatarUrl) return missing("no-avatar-url");
    if (!sailor.isPublic) {
      const auth = await getAuthContext();
      if (!auth || !await canManageSailor(id, auth.userId, auth.role === "superadmin", sailor.parentId)) return missing("not-public");
    }
    const asset = portraitAsset(sailor.avatarUrl);
    if (asset) {
      const bytes = await readFile(path.join(process.cwd(), "private/athlete-portraits", asset.folder, asset.file));
      return new Response(new Uint8Array(bytes), { headers: { ...HEADERS, "Content-Type": asset.file.endsWith(".png") ? "image/png" : asset.file.endsWith(".webp") ? "image/webp" : "image/jpeg" } });
    }
    const storageUrl = (process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL || "").replace(/\/$/, "");
    let object = avatarObjectPath(sailor.avatarUrl, id, storageUrl);

    // If initial avatarObjectPath returned null (e.g. from query params or relative path), retry with clean URL
    if (!object) {
      try {
        const u = new URL(sailor.avatarUrl, storageUrl || "https://sailorpath.com");
        const cleanValue = `${u.origin}${u.pathname}`;
        object = avatarObjectPath(cleanValue, id, storageUrl) ||
                 avatarObjectPath(cleanValue, id, u.origin);
      } catch {
        // ignore
      }
    }

    if (!object) {
      return missing("invalid-object-path", {
        "X-Photo-Avatar-Url": String(sailor.avatarUrl).slice(0, 100),
        "X-Photo-Storage-Url": storageUrl,
      });
    }

    let dbObjExists = false;
    let dbPubCheck: boolean | null = null;
    let existingNames: string[] = [];
    try {
      const rows = await db.execute<{ name: string }>(
        sql`SELECT name FROM storage.objects WHERE bucket_id = 'avatars' AND name = ${object} LIMIT 1`
      );
      dbObjExists = (rows.rows?.length ?? 0) > 0;
      const pubRows = await db.execute<{ is_pub: boolean }>(
        sql`SELECT private.is_published_avatar(${object}) as is_pub`
      );
      dbPubCheck = pubRows.rows?.[0]?.is_pub ?? null;
      if (!dbObjExists) {
        const altRows = await db.execute<{ name: string }>(
          sql`SELECT name FROM storage.objects WHERE bucket_id = 'avatars' AND name LIKE ${id + "/%"} LIMIT 5`
        );
        existingNames = (altRows.rows || []).map((r) => String(r.name));
      }
    } catch {
      // Storage schema not queried or not present in local test DB
    }

    const supabase = await createServerSupabase();

    let bodyBytes: Uint8Array | null = null;
    let contentType: string | null = null;

    // 1. Primary SDK download (used in tests and standard storage configurations)
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
      // Fall through to candidate endpoints
    }

    // 2. Multi-endpoint fallbacks for Supabase Storage (authenticated, public, render, direct)
    if (!bodyBytes || !contentType) {
      const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY || "";
      const sessionRes = await supabase.auth?.getSession?.().catch(() => null);
      const token = sessionRes?.data?.session?.access_token || anonKey;
      const candidateHeaders = {
        apikey: anonKey,
        Authorization: `Bearer ${token}`,
      };

      const candidateUrls = [
        `${storageUrl}/storage/v1/object/authenticated/avatars/${object}`,
        `${storageUrl}/storage/v1/object/public/avatars/${object}`,
        `${storageUrl}/storage/v1/render/image/authenticated/avatars/${object}`,
        sailor.avatarUrl,
        ...existingNames.map((n) => `${storageUrl}/storage/v1/object/authenticated/avatars/${n}`),
        ...existingNames.map((n) => `${storageUrl}/storage/v1/object/public/avatars/${n}`),
      ];

      const attempts: string[] = [];

      for (const targetUrl of candidateUrls) {
        if (!targetUrl || !targetUrl.startsWith("http")) continue;
        try {
          const res = await fetch(targetUrl, { headers: candidateHeaders, cache: "no-store" });
          const shortUrl = targetUrl.replace(storageUrl, "");
          attempts.push(`${shortUrl}:${res.status}`);
          if (res.ok) {
            const ab = await res.arrayBuffer();
            const bytes = new Uint8Array(ab);
            const detected = detectImageType(res.headers.get("content-type"), object, bytes);
            if (detected) {
              bodyBytes = bytes;
              contentType = detected;
              break;
            }
          }
        } catch (fetchErr) {
          attempts.push(`${targetUrl.replace(storageUrl, "")}:err`);
          console.warn("[profile-photo] candidate fetch error:", targetUrl, fetchErr);
        }
      }

      if (!bodyBytes || !contentType) {
        return missing("storage-fetch-failed", {
          "X-Photo-Object": object,
          "X-Photo-Storage-Url": storageUrl,
          "X-Photo-Attempts": attempts.join(", "),
          "X-Photo-DB-Obj": dbObjExists ? "true" : "false",
          "X-Photo-DB-Pub": String(dbPubCheck),
          "X-Photo-Existing": existingNames.join(", "),
        });
      }
    }

    if (!bodyBytes || !contentType) return missing("no-body-bytes");
    return new Response(Buffer.from(bodyBytes), { headers: { ...HEADERS, "Content-Type": contentType } });
  } catch (error) {
    console.error("[profile-photo]", error);
    return Response.json({ error: "Photo temporarily unavailable" }, { status: 503, headers: HEADERS });
  }
}
