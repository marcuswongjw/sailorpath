const UPLOADER_ID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/**
 * Evidence objects live under the signed-in user's id. The storage policy
 * allows writes only in that folder, so the path cannot be chosen by the client.
 */
export function evidenceStoragePath(
  userId: string,
  originalName: string,
  now: number
): string {
  const owner = userId.trim().toLowerCase();
  if (!UPLOADER_ID.test(owner)) {
    throw new Error("Invalid uploader");
  }
  const base = (originalName || "evidence").split(/[/\\]/).pop() || "evidence";
  const safeName =
    base
      .replace(/[^a-zA-Z0-9._-]/g, "_")
      .replace(/\.\.+/g, ".")
      .replace(/^\.+/, "")
      .slice(0, 80) || "evidence";
  return `${owner}/${now}_${safeName}`;
}
