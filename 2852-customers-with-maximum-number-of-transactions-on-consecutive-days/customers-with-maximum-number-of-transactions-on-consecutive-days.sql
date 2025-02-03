with sess_info as (
    select 
        customer_id,
        count(distinct transaction_date) as cnts
    from (
        select 
            customer_id,
            transaction_date,
            date_sub(transaction_date,interval row_number() over (partition by customer_id order by transaction_date) day) as sess
        from 
            Transactions
    ) a 
    group by 
        customer_id,sess
)
select 
    customer_id
from (
    select 
        customer_id,
        dense_rank() over (order by cnts desc) as ranks
    from 
        sess_info
) a 
where 
    ranks = 1 
order by 
    customer_id