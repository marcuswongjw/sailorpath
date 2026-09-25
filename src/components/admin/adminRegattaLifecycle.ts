import { parseApi, apiErr } from "@/components/admin/parseApi";
import type { RegattaLifecycleStatus } from "@/lib/regattaStatus";

export async function setAdminRegattaStatus(
  regattaId: string,
  targetStatus: RegattaLifecycleStatus
): Promise<{ status: RegattaLifecycleStatus; previousStatus?: string }> {
  const response = await fetch(
    `/api/admin/regattas/${encodeURIComponent(regattaId)}/publish`,
    {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ targetStatus }),
    }
  );
  const data = await parseApi(response);
  if (!response.ok) {
    throw new Error(apiErr(data, "Failed to update publication status"));
  }
  return {
    status: targetStatus,
    previousStatus:
      typeof data.previousStatus === "string" ? data.previousStatus : undefined,
  };
}
