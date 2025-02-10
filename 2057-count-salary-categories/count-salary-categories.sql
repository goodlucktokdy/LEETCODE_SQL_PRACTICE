# Write your MySQL query statement below
with base as (
    select 
        'High Salary' as category
    union all
    select 
        'Average Salary' as category
    union all
    select 
        'Low Salary' as category
)
select 
    a.category,
    count(distinct account_id) as accounts_count
from 
    base a 
left join 
    Accounts b 
on 
    a.category = case when b.income > 50000 then 'High Salary'
        when b.income between 20000 and 50000 then 'Average Salary'
        else 'Low Salary' end
group by 
    a.category