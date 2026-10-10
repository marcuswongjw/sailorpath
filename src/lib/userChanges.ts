import { getAuthContext, type AuthContext } from "@/lib/auth";
import { logAdminChange } from "@/lib/adminChangeLog";

const PRIVATE_FIELDS = /password|token|secret|body|text|notes|detail|content/i;
const ID_FIELDS = ["id", "sailorId", "resultId", "regattaId", "equipmentId", "squadId"];
const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
type Identifiers = Record<string, string | string[]>;

/** Keep an activity record, without copying private content or credentials. */
export async function recordUserChange(
  auth: AuthContext,
  input: { area: string; operation: string; source: string; fields?: string[]; identifiers?: Identifiers }
) {
  if (auth.role === "superadmin") return;
  const targetId = input.identifiers?.id || input.identifiers?.resultId || input.identifiers?.sailorId;
  await logAdminChange({
    actorUserId: auth.userId,
    actorEmail: auth.email,
    action: `user.${input.area}.${input.operation}`,
    entityType: input.area,
    entityId: typeof targetId === "string" && UUID.test(targetId) ? targetId : null,
    summary: `${input.area.replaceAll("_", " ")}: ${input.operation}`,
    source: input.source,
    details: {
      actorRole: auth.role,
      submittedFields: input.fields,
      identifiers: input.identifiers,
      // Values deliberately omitted: this is activity history, not a private-data export.
    },
  });
}

/** Audit successful user write endpoints; failed writes and reads are excluded. */
export function withUserChangeTracking(
  area: string,
  handler: (request: Request) => Promise<Response>
) {
  return async (request: Request): Promise<Response> => {
    const bodyPromise = request.clone().json().catch(() => ({}));
    const response = await handler(request);
    if (!response.ok) return response;
    try {
      const auth = await getAuthContext();
      if (!auth || auth.role === "superadmin") return response;
      const body = await bodyPromise;
      const output = await response.clone().json().catch(() => ({}));
      if (output.alreadyFollowing === true) return response;
      const url = new URL(request.url);
      const identifiers: Identifiers = {};
      const objects = [output, output.result, output.regatta, output.note, output.equipment, output.observation, body];
      for (const key of ID_FIELDS) {
        const value = objects.find((object) => object && typeof object[key] === "string")?.[key] || url.searchParams.get(key);
        if (typeof value === "string" && value.length <= 120) identifiers[key] = value;
      }
      for (const key of ["ids", "sailorIds"]) {
        const values = Array.isArray(body?.[key]) ? body[key] : url.searchParams.get(key)?.split(",");
        if (Array.isArray(values)) identifiers[key] = values.filter((value): value is string => typeof value === "string" && UUID.test(value)).slice(0, 100);
      }
      await recordUserChange(auth, {
        area,
        operation: request.method === "DELETE" ? "deleted" : request.method === "PATCH" ? "updated" : "saved",
        source: url.pathname,
        fields: Object.keys(body || {}).filter((key) => /^[a-zA-Z][a-zA-Z0-9_]{0,79}$/.test(key) && !PRIVATE_FIELDS.test(key)).slice(0, 50),
        identifiers,
      });
    } catch (error) {
      // Audit failures must not turn a successful write into an apparent failure.
      console.warn("[userChanges] Unable to record user change", error);
    }
    return response;
  };
}
