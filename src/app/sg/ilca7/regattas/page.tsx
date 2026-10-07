import { redirect } from "next/navigation";

export default function RegattasPage() {
  redirect("/calendar?class=ilca7&view=past");
}
