# Write your MySQL query statement below
with base as (
    select 
        user_id,
        transaction_date,
        row_number() over (partition by user_id order by transaction_date) as rnums,
        spend
    from 
        Transactions 
)
select 
    user_id,
    third_transaction_spend,
    third_transaction_date
from (
    select 
        a.user_id,
        a.transaction_date,
        a.spend,
        a.rnums,
        b.transaction_date as third_transaction_date,
        b.spend as third_transaction_spend
    from 
        base a 
    left join 
        base b 
    on 
        a.user_id = b.user_id and a.rnums < 3 and b.rnums = 3
        and a.spend < b.spend
    where 
        b.user_id is not null
) a
group by 
    1,2,3
having 
    sum(distinct rnums) = 3 
order by 
    user_id