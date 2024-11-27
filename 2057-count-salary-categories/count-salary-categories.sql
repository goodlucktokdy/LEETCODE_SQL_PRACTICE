# Write your MySQL query statement below
with cat_cte as (
    select 
        'Low Salary' as category
    union all
    select 
        'Average Salary' as category
    union all
    select 
        'High Salary' as category
)
, income_cnt as (
    select 
        case when income > 50000 then 'High Salary' 
            when income between 20000 and 50000 then 'Average Salary'
            when income < 20000 then 'Low Salary' else null end as category,
        income,
        account_id
    from 
        Accounts
)
select 
    a.category,
    count(distinct b.account_id) as accounts_count
from 
    cat_cte a
left join
    income_cnt b
on 
    a.category = b.category
group by 
    category