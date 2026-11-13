# SCHOLIVORA Supabase setup

SCHOLIVORA uses one shared Supabase project for admin sign-in and cloud records. Users sign in through SCHOLIVORA; they do not need Supabase dashboard access or project details.

1. In the Supabase SQL Editor for the project configured in `index.html`, run [`supabase.sql`](./supabase.sql). If the old data table was deleted, this recreates it.
2. In **Authentication → URL Configuration**, set the Site URL to the address where SCHOLIVORA is hosted. Add that same address to the allowed redirect URLs. Use localhost for development or HTTPS for a deployed app; opening the HTML directly as a `file://` URL is not suitable for email-confirmation redirects.
3. Users can select **Create admin account**, register with their email and password, confirm the email if prompted, then sign in.

Each signed-in admin can read and change only their own `bursarpro_data` row. When a user has no cloud row, the first account on a browser can migrate its saved SCHOLIVORA data. Existing cloud rows take precedence.

The public anon/publishable key in `index.html` is intended for browser use. Never put a service-role key in the app.
