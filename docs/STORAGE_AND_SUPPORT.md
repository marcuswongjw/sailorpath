# Storage (avatars) & support messages

## 1. Support messages table

In Supabase **SQL Editor**, run:

`src/db/migrations/013_support_messages.sql`

## 2. Avatar storage bucket

Run, in order:

`src/db/migrations/014_avatars_storage.sql`

`src/db/migrations/102_storage_object_owner_policies.sql`

014 creates the public avatars bucket. 102 replaces its bucket-wide write policies. Do not add a policy that allows every authenticated user to insert, update, or delete objects in `avatars` or `regatta-evidence`.

Profile photos stay readable by URL. A write is allowed only for a superadmin, the sailor's parent, or an approved claim, and only under that sailor's folder. Evidence writes are allowed only under the uploader's own folder.

## 3. Where it appears

- Photo: claim owner taps profile circle → upload
- Support: `/support`, footer **Help / Support**, account page, admin **Support** tab
