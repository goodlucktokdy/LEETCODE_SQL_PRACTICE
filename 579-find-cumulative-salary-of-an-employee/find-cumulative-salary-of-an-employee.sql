-- -- -- -- -- -- -- -- -- -- -- -- -- # Write your MySQL query statement below
select 
    id,
    month,
    sum(salary) over (partition by id order by month range between 2 preceding and 0 following) as Salary
from (
    select 
        id,
        month,
        salary,
        row_number() over (partition by id order by month desc) as month_sequence
    from 
        Employee
) a 
where 
    month_sequence > 1
order by 
    id asc, month desc 