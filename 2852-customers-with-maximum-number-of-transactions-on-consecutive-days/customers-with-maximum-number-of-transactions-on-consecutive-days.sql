# Write your MySQL query statement below
with base as (
    select 
        customer_id,
        transaction_date,
        date_sub(transaction_date,interval row_number() over (partition by customer_id order by transaction_date) day) as sess
    from 
        Transactions
),
sess_info as (
    select 
        customer_id,
        dense_rank() over (order by streaks desc) as ranks
    from (
        select 
            customer_id,
            count(distinct transaction_date) as streaks
        from 
            base 
        group by 
            customer_id, sess
    ) a 
)
select 
    customer_id
from 
    sess_info 
where 
    ranks = 1
order by 
    customer_id 