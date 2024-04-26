# Write your MySQL query statement below
with base as 
    (
    select a.id aid, a.num anum, b.id bid, b.num bnum, c.id cid, c.num cnum 
    from Logs a
    inner join
    Logs b
    on a.num = b.num
    and
        a.id + 1 = b.id
    inner join
    Logs c
    on b.id + 1 = c.id
    and b.num = c.num
)
select distinct cnum as ConsecutiveNums from base