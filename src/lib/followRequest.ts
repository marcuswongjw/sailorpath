import { safeAuthNext } from "@/lib/supabase/cookie-options";

export type FollowAction = {
  sailorId: string;
  nextPath: string;
  intent: "follow" | "unfollow";
  /** Browser form posts redirect. JSON calls from the button stay on the page. */
  redirect: boolean;
};

export async function readFollowAction(request: Request): Promise<FollowAction> {
  const type = request.headers.get("content-type") || "";
  if (type.includes("application/json") || !type.includes("form")) {
    const body = await request.json().catch(() => ({}));
    return {
      sailorId: String(body.sailorId || "").trim(),
      nextPath: safeAuthNext(typeof body.next === "string" ? body.next : "", "/following"),
      intent: body.intent === "unfollow" ? "unfollow" : "follow",
      redirect: false,
    };
  }

  const form = await request.formData();
  return {
    sailorId: String(form.get("sailorId") || "").trim(),
    nextPath: safeAuthNext(String(form.get("next") || ""), "/following"),
    intent: String(form.get("intent") || "") === "unfollow" ? "unfollow" : "follow",
    redirect: true,
  };
}
