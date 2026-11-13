-- App-owner setup: run once in the shared Supabase project used by SCHOLIVORA.
-- End users only need a SCHOLIVORA login; they do not need Supabase dashboard access.
create table if not exists public.bursarpro_data (
    user_id uuid primary key references auth.users (id) on delete cascade,
    data jsonb not null,
    updated_at timestamptz not null default now()
);

alter table public.bursarpro_data enable row level security;

revoke all on public.bursarpro_data from anon;
grant select, insert, update on public.bursarpro_data to authenticated;

drop policy if exists "Admins can read their own BURSARPRO data" on public.bursarpro_data;
create policy "Admins can read their own BURSARPRO data"
    on public.bursarpro_data for select to authenticated
    using ((select auth.uid()) = user_id);

drop policy if exists "Admins can create their own BURSARPRO data" on public.bursarpro_data;
create policy "Admins can create their own BURSARPRO data"
    on public.bursarpro_data for insert to authenticated
    with check ((select auth.uid()) = user_id);

drop policy if exists "Admins can update their own BURSARPRO data" on public.bursarpro_data;
create policy "Admins can update their own BURSARPRO data"
    on public.bursarpro_data for update to authenticated
    using ((select auth.uid()) = user_id)
    with check ((select auth.uid()) = user_id);

do $$
begin
    if to_regclass('public.bursarpro_payment_requests') is not null then
        execute 'drop policy if exists "Admins can read their own BURSARPRO payment requests" on public.bursarpro_payment_requests';
        execute 'drop policy if exists "Admins can submit their own BURSARPRO payment requests" on public.bursarpro_payment_requests';
        execute 'revoke all on public.bursarpro_payment_requests from anon, authenticated';
    end if;
end;
$$;
