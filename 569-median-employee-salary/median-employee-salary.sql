# Write your MySQL query statement below
select 
    id,
    company,
    salary
from (
    select 
        id,
        company,
        salary,
        dense_rank() over (partition by company order by salary,id) as rnums,
        count(id) over (partition by company) as cnts
    from 
        Employee
) a 
where 
    rnums between cnts/2 and cnts/2 + 1