-- ΥΔΕ Studio G — Διόρθωση τύπου αναγνωριστικού έργου
-- Εκτέλεση στο project promitheies-dimou-rodou.
-- Δεν διαγράφει έργα. Μετατρέπει UUID IDs σε ισοδύναμα text IDs.

begin;

do $$
begin
  if to_regclass('public.yde_project_members') is not null then
    execute 'alter table public.yde_project_members drop constraint if exists yde_project_members_project_id_fkey';
  end if;
  if to_regclass('public.yde_project_versions') is not null then
    execute 'alter table public.yde_project_versions drop constraint if exists yde_project_versions_project_id_fkey';
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_schema='public' and table_name='yde_projects'
      and column_name='id' and data_type='uuid'
  ) then
    execute 'alter table public.yde_projects alter column id drop default';
    execute 'alter table public.yde_projects alter column id type text using id::text';
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_schema='public' and table_name='yde_project_members'
      and column_name='project_id' and data_type='uuid'
  ) then
    execute 'alter table public.yde_project_members alter column project_id type text using project_id::text';
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_schema='public' and table_name='yde_project_versions'
      and column_name='project_id' and data_type='uuid'
  ) then
    execute 'alter table public.yde_project_versions alter column project_id type text using project_id::text';
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_schema='public' and table_name='yde_audit_log'
      and column_name='project_id' and data_type='uuid'
  ) then
    execute 'alter table public.yde_audit_log alter column project_id type text using project_id::text';
  end if;
end
$$;

commit;

select table_name, column_name, data_type
from information_schema.columns
where table_schema='public'
  and (
    (table_name='yde_projects' and column_name='id')
    or (table_name in ('yde_project_members','yde_project_versions','yde_audit_log') and column_name='project_id')
  )
order by table_name, column_name;
