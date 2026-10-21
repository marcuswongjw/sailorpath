# Approval welcome emails

New parent/sailor claim approvals and coach-role approvals send a personalised welcome automatically through the existing Resend integration, from SailorPath <notifications@sailorpath.com>. Accepted administrator invitations use the same welcome. Sending happens after the approval is saved.

## Parent example

Subject: Welcome to SailorPath — your Parent access is approved

Hi May,

Welcome aboard SailorPath!

Your Parent access is approved, and you’re ready to get started.
Your link to Ava Tan is approved as Parent / guardian.

Here’s where to begin:

- View your linked sailor’s race results and progress.
- Review their profile details and choose what is shared publicly.
- Use your account to manage your sailor links.

Get started: https://sailorpath.com/account

Sign in using the email address that received this message.
If something doesn’t look right, contact the SailorPath team through the Help & support page:
https://sailorpath.com/support

We’re glad to have you on board.
The SailorPath team

## Role-specific guidance

Sailors are guided to their results, profile/privacy settings and logbook, with the account link. Coaches are guided to Coach tools, squad organisation and requesting approved access to sailors. Existing coach/superadmin roles are preserved when claims are reviewed. Revoking coach access remains an access-change message, not a welcome.

Both HTML and plain text are sent. Names are escaped in HTML. Missing names use “Hi,”. The messages concern account access and do not subscribe recipients to marketing.

## Delivery and duplicate handling

- An unchanged repeated claim approval does not send another welcome.
- Each approval has a stable provider idempotency key, shared by its approval and invitation-acceptance paths. Resend retains these keys for 24 hours.
- Protected sends retry temporary network errors, HTTP 429 and server failures up to three attempts; permanent rejections are not retried.
- Requests have an eight-second timeout per attempt. An email problem does not roll back an approved account.
- The private admin audit log records role_email.sent (accepted by the provider), role_email.failed or role_email.skipped. “Sent” does not assert inbox delivery. Prolonged failures beyond the bounded attempts require delivery review; there is no persistent retry queue.
- Production RESEND_API_KEY configuration was confirmed without retrieving its secret value. No retrospective welcome blast or real-user test email was sent.

Validation includes the role copy, links, HTML escaping, request payload, stable retry keys, temporary/permanent failures, duplicate approvals and the approval/invitation routes, including rollback and rejection paths.
