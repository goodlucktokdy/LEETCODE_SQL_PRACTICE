# Write your MySQL query statement below
with base as (
    select 
        a.project_id,
        dense_rank() over (order by a.employee_cnts desc) as ranking
    from (
        SELECT 
            a.project_id,
            count(distinct b.employee_id) as employee_cnts
        from 
            Project a 
        left join 
            Employee b 
        on 
            a.employee_id = b.employee_id
        group by 
            1
    ) a
)
select 
    project_id
from 
    base 
where 
    ranking = 1       