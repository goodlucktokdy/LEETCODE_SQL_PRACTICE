# Write your MySQL query statement below
with base as (
    select 
        distinct
        a.pid,
        a.tiv_2016,
        a.lat,
        a.lon
    from 
        Insurance a 
    inner join 
        Insurance b 
    on 
        a.pid != b.pid and a.tiv_2015 = b.tiv_2015
)
select 
    round(sum(tiv_2016),2) as tiv_2016
from (
    select 
        pid,
        tiv_2016
    from
        base a 
    where not exists 
        (select 1 from Insurance b 
            where a.pid != b.pid and (a.lat,a.lon) = (b.lat,b.lon))
) a