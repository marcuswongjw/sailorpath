import { NextResponse } from "next/server";
import { getAuthContext, jsonError } from "@/lib/auth";
import { createServerSupabase } from "@/lib/supabase/server";

export const dynamic = "force-dynamic";

const ALLOWED_MIME_TYPES = new Set([
  "application/pdf",
  "image/jpeg",
  "image/png",
  "image/webp",
]);

const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB

export async function POST(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }

    const formData = await req.formData();
    const file = formData.get("file");

    if (!file || !(file instanceof Blob)) {
      return NextResponse.json(
        { error: "No file provided" },
        { status: 400 }
      );
    }

    if (file.size > MAX_FILE_SIZE) {
      return NextResponse.json(
        { error: "File size exceeds 10MB limit" },
        { status: 400 }
      );
    }

    const mimeType = file.type || "application/octet-stream";
    if (!ALLOWED_MIME_TYPES.has(mimeType)) {
      return NextResponse.json(
        { error: "Invalid file format. Please upload a PDF, PNG, JPG, or WebP." },
        { status: 400 }
      );
    }

    const originalName = file instanceof File ? file.name : "evidence_document";
    const safeName = originalName.replace(/[^a-zA-Z0-9._-]/g, "_");
    const evidenceType = mimeType === "application/pdf" ? "pdf" : "image";

    const supabase = await createServerSupabase();
    const path = `${auth.userId}/${Date.now()}_${safeName}`;

    const arrayBuffer = await file.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);

    const { error: uploadError } = await supabase.storage
      .from("regatta-evidence")
      .upload(path, buffer, {
        contentType: mimeType,
        upsert: true,
      });

    if (uploadError) {
      // Fall back to avatars bucket or return error
      console.warn("regatta-evidence bucket upload error:", uploadError.message);
      const { data: fallbackData, error: fallbackError } = await supabase.storage
        .from("avatars")
        .upload(`evidence/${path}`, buffer, {
          contentType: mimeType,
          upsert: true,
        });

      if (fallbackError) {
        throw new Error(uploadError.message || "Failed to upload evidence file");
      }

      const { data: pubUrl } = supabase.storage
        .from("avatars")
        .getPublicUrl(fallbackData.path);

      return NextResponse.json({
        ok: true,
        url: pubUrl.publicUrl,
        name: originalName,
        type: evidenceType,
        size: file.size,
      });
    }

    const { data: pubUrl } = supabase.storage
      .from("regatta-evidence")
      .getPublicUrl(path);

    return NextResponse.json({
      ok: true,
      url: pubUrl.publicUrl,
      name: originalName,
      type: evidenceType,
      size: file.size,
    });
  } catch (err) {
    console.error("evidence upload error", err);
    return jsonError(err);
  }
}
