# Write your MySQL query statement below
with base as (
    select 
        a.id,
        a.name,
        b.id as report_from,
        b.managerId
    from 
        Employee a
    left join
        Employee b 
    on 
        a.id = b.managerId
)
select 
    a.name
from (
    select
        distinct
        id,
        name,
        count(distinct report_from) as num_of_reports
    from 
        base
    group by 
        id,name
    having 
        num_of_reports >= 5
) a
