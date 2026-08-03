/**
 * One-time / idempotent ILCA display-name corrections.
 * Old names are stored as aliases so Excel import still matches.
 */

export const ILCA_NAME_CORRECTIONS: readonly {
  from: string;
  to: string;
}[] = [
  { from: "Travis Yeo", to: "Travis Jia Le Yeo" },
  { from: "Tan Reyes Jit Eng", to: "Reyes Jit Eng Tan" },
  { from: "Regis Wong Xuan Kai", to: "Wong Kai Lun" },
] as const;
