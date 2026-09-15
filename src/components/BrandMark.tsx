import Link from "next/link";
import Image from "next/image";
import { BRAND } from "@/lib/brand";

const SIZE = {
  sm: 28,
  md: 32,
  lg: 40,
} as const;

type MarkSize = keyof typeof SIZE;

export function BrandMark({
  size = "md",
  className = "",
}: {
  size?: MarkSize;
  className?: string;
}) {
  const pixels = SIZE[size];
  return <Image src={BRAND.icon} width={pixels} height={pixels} alt="" className={`shrink-0 ${className}`} aria-hidden />;
}

export function BrandWordmark({
  className = "",
}: {
  className?: string;
}) {
  return <span className={`font-display font-bold tracking-[-0.02em] text-harbour ${className}`}>{BRAND.name}</span>;
}

/** Header home link: mark + wordmark. */
export function BrandLogoLink({
  href = "/",
}: {
  href?: string;
}) {
  return (
    <Link
      href={href}
      prefetch
      className="flex shrink-0 items-center"
      aria-label="SailorPath home"
    >
      <Image
        src={BRAND.logo}
        width={800}
        height={265}
        priority
        alt="SailorPath"
        className="h-8 w-auto sm:h-9"
      />
    </Link>
  );
}
