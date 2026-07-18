# Storage (avatars) & support messages

## 1. Support messages table

In Supabase **SQL Editor**, run:

`src/db/migrations/013_support_messages.sql`

## 2. Avatar storage bucket

Run:

`src/db/migrations/014_avatars_storage.sql`

Or create bucket **avatars** in Dashboard → Storage:

- Public: **Yes**
- File size limit: 5 MB
- MIME: image/jpeg, image/png, image/webp, image/gif

Then add policies so authenticated users can INSERT/UPDATE/DELETE on `avatars` and anyone can SELECT.

## 3. Where it appears

- Photo: claim owner taps profile circle → upload
- Support: `/support`, footer **Help / Support**, account page, admin **Support** tab
