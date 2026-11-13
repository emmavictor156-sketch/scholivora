# SCHOLIVORA Supabase setup

The app owner sets up one shared Supabase project. New users do not need their own Supabase project, Supabase dashboard access, or Supabase details; they only use a SCHOLIVORA login.

1. Create a Supabase project.
2. In the Supabase SQL Editor, run [`supabase.sql`](./supabase.sql) once in that shared project.
3. In **Authentication → URL Configuration**, set the Site URL to the address where SCHOLIVORA is hosted. Add that same address to the allowed redirect URLs. Use localhost for development or HTTPS for a deployed app; opening the HTML directly as a `file://` URL is not suitable for email-confirmation redirects.
4. The shared project's URL and public anon/publishable key are configured in `index.html`, so users go directly to the SCHOLIVORA sign-in screen. Never put a service-role key in the browser.
5. To add a user, have them select **Create admin account** and register with their email and password. They do not need to create or configure a Supabase account.

Each signed-in admin can read and change only their own `bursarpro_data` row. New accounts start with empty school records. On the first account only, any existing browser-saved SCHOLIVORA records are moved to that account's cloud row. Subsequent accounts do not import those records.

If you previously enabled payment approval, rerun the updated `supabase.sql` to restore access to school records. It disables client access to the old payment-request table but retains its existing rows.
