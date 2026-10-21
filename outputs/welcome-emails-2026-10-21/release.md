# Automatic approval welcome emails

Production release 622ebd834dac1a8b8ffa309a512c646294a54405.
Deployment dpl_BJGEzHrZeKtnY963erkudC8DqLTi reached READY, with sailorpath.com and admin.sailorpath.com assigned.

Parent/sailor claim approvals and coach approvals/invitation acceptances use personalised welcome copy, with HTML and plain text, role-specific steps and links. Delivery runs after approval persistence. Repeat unchanged claim approvals are suppressed; bounded transient retries use stable Resend idempotency keys. Delivery outcomes are recorded in the private administration audit log. Coach access revocations retain an access-change notice.

60 relevant tests passed, including mail payload/escaping/retries, duplicate approvals, post-commit effects, rollback/rejection and invitation paths. Changed files passed lint and production build. Existing production email configuration was confirmed through environment metadata only. No real-user test, retrospective message or bulk welcome was sent. The first actual welcome delivery will occur on the next eligible approval.

parent-welcome.txt and parent-welcome.html are generated previews using fictional example names, without sending mail.
