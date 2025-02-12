# Write your MySQL query statement below
select 
    round(sum(tiv_2016),2) as tiv_2016
from (
    select 
        distinct
        pid,
        tiv_2016
    from 
        Insurance a 
    where exists
        (select 1 from Insurance b 
            where a.pid != b.pid and a.tiv_2015 = b.tiv_2015)
    and 
        not exists
        (select 1 from Insurance b 
            where a.pid != b.pid and (a.lat,a.lon) = (b.lat,b.lon))
) c
