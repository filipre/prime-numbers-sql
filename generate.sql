with recursive numbers(n) as (
  select n
  from generate_series(1,5000) s(n)
),
prim(n, step) as (
  select numbers.n, 2
  from numbers
  union
  select prim.n, prim.step + 1
  from prim
  where prim.step <= (select max(n) from numbers) and (prim.n = prim.step or mod(prim.n, prim.step) != 0)
)
select prim.n
from prim
where prim.step = (select max(n) from numbers) and prim.n >= 2
order by prim.n ASC
