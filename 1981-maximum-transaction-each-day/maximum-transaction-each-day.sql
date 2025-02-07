# Write your MySQL query statement below
select 
    transaction_id
from (
    select 
        date(day) as dates,
        transaction_id,
        amount,
        dense_rank() over (partition by date(day) order by amount desc) as ranks
    from 
        Transactions
) a 
where 
    ranks = 1
order by 
    transaction_id