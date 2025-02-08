# Write your MySQL query statement below
with base as (
    select 
        dep_id,
        dense_rank() over (order by emp_num desc) as ranks
    from (
        select 
            dep_id,
            count(distinct emp_id) as emp_num
        from 
            Employees 
        group by 
            dep_id
    ) a
)
select 
    a.emp_name as manager_name,
    b.dep_id
from 
    Employees a 
inner join 
    base b 
on 
    a.dep_id = b.dep_id and b.ranks = 1
where 
    a.position = 'manager'
order by 
    b.dep_id