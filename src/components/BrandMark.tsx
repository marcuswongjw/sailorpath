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
  reversed = false,
}: {
  className?: string;
  reversed?: boolean;
}) {
  return (
    <Image
      src={reversed ? BRAND.logoReversed : BRAND.logo}
      width={1141}
      height={261}
      alt={BRAND.name}
      className={`h-5 w-auto shrink-0 ${className}`}
    />
  );
}

/** Header home link: mark + wordmark. Supports reversed for dark teal navbar. */
export function BrandLogoLink({
  href = "/",
  variant = "reversed",
}: {
  href?: string;
  variant?: "default" | "reversed";
}) {
  const isReversed = variant === "reversed";
  return (
    <Link
      href={href}
      prefetch
      className="flex shrink-0 items-center"
      aria-label="SailorPath home"
    >
      <Image
        src={isReversed ? BRAND.logoReversed : BRAND.logo}
        width={1141}
        height={261}
        priority
        alt="SailorPath"
        className="h-8 w-auto sm:h-9"
      />
    </Link>
  );
}
