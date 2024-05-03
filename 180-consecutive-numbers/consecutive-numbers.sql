# Write your MySQL query statement below
-- with base as 
--     (
--     select a.id aid, a.num anum, b.id bid, b.num bnum, c.id cid, c.num cnum 
--     from Logs a
--     inner join
--     Logs b
--     on a.num = b.num
--     and
--         a.id + 1 = b.id
--     inner join
--     Logs c
--     on b.id + 1 = c.id
--     and b.num = c.num
-- )
-- select distinct cnum as ConsecutiveNums from base
-- with t1 as (select id, num, lead(id,1) over () id2, 
-- lead(id,2) over () id3, lead(num,1) over () num2,
-- lead(num,2) over () num3
-- from Logs
-- order by id
-- )
-- select distinct num as ConsecutiveNums
-- from t1
-- where (id3 - id = 2) and ((num = num2) and (num2 = num3) and (num =num3)) 
with t1 as (select id, num, lead(num,1) over (order by id) n2,
lead(num,2) over (order by id) n3,
lead(id,2) over () i3
from
Logs
)
select distinct num ConsecutiveNums
from t1
where i3 - id = 2 and (num = n2 and n2 = n3)