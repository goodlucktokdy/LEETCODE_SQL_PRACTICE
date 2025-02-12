# Write your MySQL query statement below
with base as (
    select 
        user_id,
        spend,
        transaction_date,
        lag(spend) over (partition by user_id order by transaction_date) as prev_spend,
        lag(spend,2) over (partition by user_id order by transaction_date) as 2prev_spend,
        row_number() over (partition by user_id order by transaction_date) as rnums
    from 
        Transactions 
)
select 
    user_id,
    spend as third_transaction_spend,
    transaction_date as third_transaction_date
from 
    base
where 
    rnums = 3 and prev_spend < spend and 2prev_spend < spend 
order by 
    user_id