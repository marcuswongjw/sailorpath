import { permanentRedirect } from "next/navigation";
import { PRIVATE_WORKSPACE_REDIRECTS } from "@/lib/publicRouteRedirects";
export default function LegacyCoachPage() { permanentRedirect(PRIVATE_WORKSPACE_REDIRECTS["/coach-tools"]); }
