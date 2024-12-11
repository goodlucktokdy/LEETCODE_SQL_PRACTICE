# Write your MySQL query statement below
with base as (
    select 
        distinct
        user_id,
        min(transaction_date) over (partition by user_id) as first_transaction,
        lead(spend,2) over (partition by user_id order by transaction_date) as third_spend,
        lead(spend,1) over (partition by user_id order by transaction_date) as second_spend,
        spend,
        lead(transaction_date,2) over (partition by user_id order by transaction_date) as third_transaction,
        transaction_date
    from 
        Transactions
)
select 
    a.user_id,
    a.third_spend as third_transaction_spend,
    a.third_transaction as third_transaction_date
from (
    select 
        user_id,
        third_transaction,
        first_transaction,
        third_spend,
        second_spend,
        spend as first_spend
    from 
        base
    where 
        first_transaction = transaction_date
        and
        third_spend > second_spend and third_spend > spend
) a 
order by 
    user_id asc 
