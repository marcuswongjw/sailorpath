import { redirect } from "next/navigation";

export default function RegattasPage() {
  redirect("/calendar?class=ilca6&view=past");
}
