# Write your MySQL query statement below
with base as (
    select 
        id,
        salary,
        dense_rank() over (order by salary desc) as ranks
    from 
        Employee
)
select 
    max(case when b.id is null then null else b.salary end) as SecondHighestSalary
from 
    base a 
left join 
    base b 
on 
    a.id = b.id and a.ranks = b.ranks and b.ranks = 2