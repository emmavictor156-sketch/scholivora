# BURSARPRO Supabase setup

BURSARPRO uses Supabase Authentication for admin sign-in and stores each admin's school records in a row protected by row-level security.

1. Create a Supabase project.
2. In the Supabase SQL Editor, run [`supabase.sql`](./supabase.sql).
3. In **Authentication → URL Configuration**, set the Site URL to the address where BURSARPRO is hosted. Add that same address to the allowed redirect URLs. Use localhost for development or HTTPS for a deployed app; opening the HTML directly as a `file://` URL is not suitable for email-confirmation redirects.
4. Open BURSARPRO and enter the project's URL and public anon/publishable key. Never use a service-role key in the browser.
5. Select **Create admin account**, register the administrator's email and password, confirm the email if prompted, then sign in.

Each signed-in admin can read and change only their own `bursarpro_data` row. New accounts start with empty school records. On the first account only, any existing browser-saved BURSARPRO records are moved to that account's cloud row. Subsequent accounts do not import those records.

If you previously enabled payment approval, rerun the updated `supabase.sql` to restore access to school records. It disables client access to the old payment-request table but retains its existing rows.
