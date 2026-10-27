const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
export const isPhotoSailorId = (id: string) => UUID.test(id);

/** Stable endpoint rechecks consent; never use Next image optimisation on it. */
export function profilePhotoUrl(id: string, value: string | null | undefined): string | null {
  if (!value) return null;
  if (["/demo-kimberly-tan.jpg", "/avatar-demo.png"].includes(value)) return value;
  if (!isPhotoSailorId(id)) return null;
  const endpoint = `/api/sailors/${id}/photo`;
  if (value === endpoint || value.startsWith(`${endpoint}?portrait=`)) return value;
  const portrait = portraitFile(value);
  return portrait ? `${endpoint}?portrait=${portrait}` : endpoint;
}

export function portraitFile(value: string): string | null {
  try {
    const url = new URL(value, "https://sailorpath.com");
    if (url.origin !== "https://sailorpath.com" || url.search || url.hash) return null;
    return url.pathname.match(/^\/athlete-portraits\/team-singapore\/([a-z0-9-]+\.(?:jpg|png|webp))$/)?.[1] || null;
  } catch { return null; }
}

export function avatarObjectPath(value: string, sailorId: string, storageUrl: string): string | null {
  try {
    const url = new URL(value);
    if (url.origin !== new URL(storageUrl).origin || url.search || url.hash) return null;
    const path = decodeURIComponent(url.pathname.replace(/^\/storage\/v1\/object\/(?:public|authenticated)\/avatars\//, ""));
    if (!isPhotoSailorId(sailorId) || !path.startsWith(`${sailorId}/`)) return null;
    return /^[0-9a-f-]+\/[A-Za-z0-9_-][A-Za-z0-9._-]{0,159}$/.test(path) && !path.includes("..") ? path : null;
  } catch { return null; }
}
