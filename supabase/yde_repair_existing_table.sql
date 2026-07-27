-- ΥΔΕ Studio G — Διόρθωση παλιού yde_projects
-- Τρέξε αυτό ΠΡΩΤΑ και μετά ξανατρέξε ολόκληρο το yde_schema.sql.
-- Δεν διαγράφει έργα.

begin;

alter table public.yde_projects add column if not exists owner_id uuid;
alter table public.yde_projects add column if not exists supply_number text;
alter table public.yde_projects add column if not exists installation_type text;
alter table public.yde_projects add column if not exists project_status text;
alter table public.yde_projects add column if not exists revision integer;
alter table public.yde_projects add column if not exists created_at timestamptz;

do $$
declare
  v_admin_id uuid;
begin
  select id into v_admin_id
  from auth.users
  where lower(email) = lower('vasilis1730@gmail.com')
  order by created_at
  limit 1;

  if v_admin_id is null then
    raise exception 'Δεν βρέθηκε ο Auth user vasilis1730@gmail.com. Δημιούργησέ τον πρώτα από Authentication > Users.';
  end if;

  update public.yde_projects
  set owner_id = v_admin_id
  where owner_id is null;
end
$$;

update public.yde_projects
set title = coalesce(nullif(title, ''), 'Νέο έργο ΥΔΕ'),
    supply_number = coalesce(supply_number, ''),
    installation_type = coalesce(installation_type, ''),
    project_status = case
      when project_status in ('draft','finalized','archived') then project_status
      else 'draft'
    end,
    data = coalesce(data, '{}'::jsonb),
    revision = greatest(coalesce(revision, 1), 1),
    created_at = coalesce(created_at, updated_at, now()),
    updated_at = coalesce(updated_at, now());

alter table public.yde_projects alter column owner_id set default auth.uid();
alter table public.yde_projects alter column owner_id set not null;
alter table public.yde_projects alter column title set default 'Νέο έργο ΥΔΕ';
alter table public.yde_projects alter column title set not null;
alter table public.yde_projects alter column supply_number set default '';
alter table public.yde_projects alter column supply_number set not null;
alter table public.yde_projects alter column installation_type set default '';
alter table public.yde_projects alter column installation_type set not null;
alter table public.yde_projects alter column project_status set default 'draft';
alter table public.yde_projects alter column project_status set not null;
alter table public.yde_projects alter column data set default '{}'::jsonb;
alter table public.yde_projects alter column data set not null;
alter table public.yde_projects alter column revision set default 1;
alter table public.yde_projects alter column revision set not null;
alter table public.yde_projects alter column created_at set default now();
alter table public.yde_projects alter column created_at set not null;
alter table public.yde_projects alter column updated_at set default now();
alter table public.yde_projects alter column updated_at set not null;

do $$
begin
  if not exists (
    select 1 from pg_constraint
    where conrelid = 'public.yde_projects'::regclass
      and conname = 'yde_projects_owner_id_fkey'
  ) then
    alter table public.yde_projects
      add constraint yde_projects_owner_id_fkey
      foreign key (owner_id) references auth.users(id) on delete cascade;
  end if;

  if not exists (
    select 1 from pg_constraint
    where conrelid = 'public.yde_projects'::regclass
      and conname = 'yde_projects_project_status_check'
  ) then
    alter table public.yde_projects
      add constraint yde_projects_project_status_check
      check (project_status in ('draft','finalized','archived'));
  end if;
end
$$;

create index if not exists yde_projects_owner_idx
  on public.yde_projects(owner_id);
create index if not exists yde_projects_updated_idx
  on public.yde_projects(updated_at desc);

commit;

select id, title, owner_id, project_status, revision, updated_at
from public.yde_projects
order by updated_at desc
limit 20;
