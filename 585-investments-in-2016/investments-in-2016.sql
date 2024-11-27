# Write your MySQL query statement below
with base as (
    select 
        pid,
        tiv_2015,
        count(tiv_2015) over (partition by tiv_2015) as cnt15,
        tiv_2016,
        concat(lat,',',lon) as latlon,
        count(concat(lat,',',lon)) over (partition by concat(lat,',',lon)) as latlon_cnt
    from 
        Insurance
)
select 
    round(sum(tiv_2016),2) as tiv_2016
from 
    base 
where 
    latlon_cnt = 1 and cnt15 != 1