import { permanentRedirect } from "next/navigation";
import { PRIVATE_WORKSPACE_REDIRECTS } from "@/lib/publicRouteRedirects";
export default function LegacyParentPage() { permanentRedirect(PRIVATE_WORKSPACE_REDIRECTS["/parent"]); }
