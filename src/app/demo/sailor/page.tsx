import { permanentRedirect } from "next/navigation";

export default function DemoSailorPage() {
  permanentRedirect("/sample?view=sailor");
}
