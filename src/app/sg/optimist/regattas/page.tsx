import { redirect } from "next/navigation";

export default function RegattasPage() {
  redirect("/calendar?class=optimist&view=past");
}
