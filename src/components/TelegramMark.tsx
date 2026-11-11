export function TelegramMark({ className }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" aria-hidden="true" className={className}>
      <circle cx="12" cy="12" r="12" fill="#229ED9" />
      <path
        fill="#fff"
        d="M5.4 11.8 17.9 7.1l-2 9.8c-.1.6-.5.7-1 .5l-2.8-2.1-1.3 1.3c-.2.1-.3.3-.6.3l.2-2.8 5.2-4.7c.2-.2 0-.3-.3-.1l-6.5 4.1-2.8-.9c-.6-.2-.6-.6.2-.9Z"
      />
    </svg>
  );
}
