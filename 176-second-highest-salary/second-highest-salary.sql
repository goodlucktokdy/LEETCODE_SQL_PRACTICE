-- # Write your MySQL query statement below
-- with base as (
--     select 
--         id,
--         case when a.ranks = 2 and count(a.ranks) = 1 then a.salary
--         else null end as SecondHighestSalary
--     from (
--         select 
--             id,
--             salary,
--             rank() over (order by salary desc) as ranks
--         from 
--             Employee
--     ) a
--     group by 
--         1
-- )
-- select 
--     SecondHighestSalary
-- from 
--     base
-- order by 
--     SecondHighestSalary desc 
-- limit 1
select
(select distinct Salary 
from Employee order by salary desc 
limit 1 offset 1) 
as SecondHighestSalary;