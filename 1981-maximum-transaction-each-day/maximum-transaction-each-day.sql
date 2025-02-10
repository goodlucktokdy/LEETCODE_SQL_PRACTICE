# Write your MySQL query statement below
select 
    distinct
    transaction_id
from (
    select 
        transaction_id,
        day,
        dense_rank() over (partition by day order by amount desc) as ranks
    from 
        Transactions
) a
where 
    ranks = 1
order by 
    transaction_id