const OBJECT_PATH = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\/[A-Za-z0-9_-][A-Za-z0-9._-]{0,159}$/i;

export function isEvidenceObjectPath(path: string): boolean {
  return OBJECT_PATH.test(path) && !path.includes("..");
}

export function evidenceDownloadUrlForPath(path: string): string {
  if (!isEvidenceObjectPath(path)) throw new Error("Invalid evidence object path");
  return `/api/account/evidence?path=${encodeURIComponent(path)}`;
}

/** Existing stored public URLs resolve through the same authenticated reader. */
export function evidenceDownloadUrl(value: string | null | undefined): string | null {
  if (!value) return null;
  const storageUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL;
  if (!storageUrl) return value;
  try {
    const url = new URL(value);
    if (url.origin !== new URL(storageUrl).origin) return value;
    const match = url.pathname.match(/^\/storage\/v1\/object\/(?:public|authenticated|sign)\/regatta-evidence\/(.+)$/);
    if (!match) return value;
    return evidenceDownloadUrlForPath(decodeURIComponent(match[1]));
  } catch { return value; }
}
