import Link from "next/link";
import { BRAND } from "@/lib/brand";

const SIZE = {
  sm: "h-7 w-7 text-sm rounded-md",
  md: "h-8 w-8 text-lg rounded-lg",
  lg: "h-10 w-10 text-xl rounded-xl",
} as const;

type MarkSize = keyof typeof SIZE;

/** Orange rounded square with SP — matches favicon / apple-icon. */
export function BrandMark({
  size = "md",
  className = "",
}: {
  size?: MarkSize;
  className?: string;
}) {
  return (
    <span
      className={`flex shrink-0 items-center justify-center bg-orange-600 font-black text-white group-hover:bg-orange-500 ${SIZE[size]} ${className}`}
      aria-hidden
    >
      {BRAND.markLetters}
    </span>
  );
}

/** Sailor + orange Path wordmark. */
export function BrandWordmark({
  className = "",
}: {
  className?: string;
}) {
  return (
    <span
      className={`font-extrabold text-white tracking-tight ${className}`}
    >
      Sailor<span className="text-orange-500">Path</span>
    </span>
  );
}

/** Header home link: mark + wordmark. */
export function BrandLogoLink({
  href = "/",
  markSize = "md",
  wordmarkClassName = "text-base sm:text-xl truncate",
}: {
  href?: string;
  markSize?: MarkSize;
  wordmarkClassName?: string;
}) {
  return (
    <Link
      href={href}
      prefetch
      className="flex items-center gap-2 group shrink-0 min-w-0"
    >
      <BrandMark size={markSize} />
      <BrandWordmark className={wordmarkClassName} />
    </Link>
  );
}
