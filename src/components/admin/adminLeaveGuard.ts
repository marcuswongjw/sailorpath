let leaveGuard: (() => boolean) | null = null;

/** The open Events forms register this. Primary navigation asks before leaving. */
export function setAdminLeaveGuard(guard: (() => boolean) | null) {
  leaveGuard = guard;
}

export function confirmAdminLeave(): boolean {
  return leaveGuard ? leaveGuard() : true;
}
