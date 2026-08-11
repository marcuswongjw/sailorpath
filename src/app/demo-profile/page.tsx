import { redirect } from "next/navigation";

/** Alias for marketing CTAs — demo profile lives at /sample */
export default function DemoProfilePage() {
  redirect("/sample");
}
