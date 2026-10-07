import { redirect } from "next/navigation";

export default function RegattasPage() {
  redirect("/calendar?class=ilca4&view=past");
}
