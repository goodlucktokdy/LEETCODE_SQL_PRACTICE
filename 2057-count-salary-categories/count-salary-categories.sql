# Write your MySQL query statement below
with categories as (
    select 
        'Low Salary' as category 
    union 
    select 
        'Average Salary' as category
    union 
    select 
        'High Salary' as category
)
select 
    a.category,
    count(distinct b.account_id) as accounts_count
from 
    categories a 
left join (
   select 
        case when income < 20000 then 'Low Salary'
            when income between 20000 and 50000 then 'Average Salary'
            else 'High Salary' end as category,
        account_id
    from 
        Accounts
) b
on 
    a.category = b.category
group by 
    a.category 