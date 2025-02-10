# Write your MySQL query statement below
with base as (
    select 
        paid_by as state,
        -1 * amount as amount
    from 
        Transactions
    union all
    select 
        paid_to,
        amount
    from 
        Transactions
)
select 
    user_id,
    user_name,
    credit + diff as credit,
    case when credit + diff >= 0 then 'No' else 'Yes' end as credit_limit_breached
from (
    select 
        a.user_id,
        a.user_name,
        a.credit,
        sum(coalesce(b.amount,0)) as diff
    from 
        Users a 
    left join 
        base b 
    on 
        a.user_id = b.state
    group by 
        a.user_id, a.user_name, a.credit
) a