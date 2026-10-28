import { NextResponse } from "next/server";
import { getAuthContext, jsonError } from "@/lib/auth";
import { canManageSailor, hasAnyManagedSailor } from "@/lib/claimAccess";
import { evidenceDownloadUrlForPath } from "@/lib/evidenceDownload";
import { evidenceStoragePath } from "@/lib/evidenceStoragePath";
import { createServerSupabase } from "@/lib/supabase/server";

export const dynamic = "force-dynamic";

const ALLOWED_MIME_TYPES = new Set([
  "application/pdf",
  "image/jpeg",
  "image/png",
  "image/webp",
]);

const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
const MAX_EVIDENCE_FILES_PER_USER = 50;
const MAX_EVIDENCE_TOTAL_BYTES_PER_USER = 100 * 1024 * 1024; // 100MB

export async function POST(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }

    const isAdmin = auth.role === "superadmin";
    // Reject unapproved accounts before parsing or buffering multipart uploads.
    if (!isAdmin && !(await hasAnyManagedSailor(auth.userId))) {
      return NextResponse.json(
        { error: "An approved sailor profile claim is required to upload evidence." },
        { status: 403 }
      );
    }

    const formData = await req.formData();
    const file = formData.get("file");
    const rawSailorId = formData.get("sailorId");
    const sailorId = typeof rawSailorId === "string" ? rawSailorId.trim() : "";

    const canUpload = sailorId
      ? await canManageSailor(sailorId, auth.userId, isAdmin)
      : true;
    if (!canUpload) {
      return NextResponse.json(
        { error: "An approved sailor profile claim is required to upload evidence." },
        { status: 403 }
      );
    }

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
    const evidenceType = mimeType === "application/pdf" ? "pdf" : "image";
    let path: string;
    try {
      path = evidenceStoragePath(auth.userId, originalName, Date.now());
    } catch {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }

    const supabase = await createServerSupabase();
    const bucket = supabase.storage.from("regatta-evidence") as {
      list: (
        folder?: string,
        options?: { limit?: number }
      ) => Promise<{
        data: Array<{ name: string; metadata?: { size?: number } | null }> | null;
        error: { message: string } | null;
      }>;
      upload: (
        path: string,
        body: Buffer,
        options: { contentType: string; upsert: boolean }
      ) => Promise<{ error: { message: string } | null }>;
    };

    if (!isAdmin) {
      const { data: existingFiles, error: listError } = await bucket.list(
        auth.userId,
        { limit: MAX_EVIDENCE_FILES_PER_USER + 1 }
      );
      if (listError) {
        console.error("regatta-evidence quota list failed", listError.message);
        return NextResponse.json(
          { error: "Could not verify evidence storage quota. Try again." },
          { status: 502 }
        );
      }
      const items = (existingFiles || []).filter(
        (item) => item.name && item.name !== ".emptyFolderPlaceholder"
      );
      const totalBytes = items.reduce(
        (sum, item) => sum + (Number(item.metadata?.size) || 0),
        0
      );
      if (
        items.length >= MAX_EVIDENCE_FILES_PER_USER ||
        totalBytes + file.size > MAX_EVIDENCE_TOTAL_BYTES_PER_USER
      ) {
        return NextResponse.json(
          {
            error:
              "Evidence storage quota exceeded (maximum 50 files or 100MB per account).",
          },
          { status: 413 }
        );
      }
    }

    const arrayBuffer = await file.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);

    const { error: uploadError } = await bucket.upload(path, buffer, {
      contentType: mimeType,
      upsert: false,
    });

    if (uploadError) {
      console.error("regatta-evidence upload failed", uploadError.message);
      return NextResponse.json(
        { error: "Could not upload evidence. Try again." },
        { status: 502 }
      );
    }

    return NextResponse.json({
      ok: true,
      url: evidenceDownloadUrlForPath(path),
      name: originalName,
      type: evidenceType,
      size: file.size,
    });
  } catch (err) {
    console.error("evidence upload error", err);
    return jsonError(err);
  }
}
