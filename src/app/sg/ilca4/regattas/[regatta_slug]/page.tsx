import { permanentRedirect } from "next/navigation";

export default async function Ilca4RegattaDetailRedirect({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}) {
  const { regatta_slug } = await params;
  permanentRedirect(`/sg/ilca/regattas/${regatta_slug}`);
}
