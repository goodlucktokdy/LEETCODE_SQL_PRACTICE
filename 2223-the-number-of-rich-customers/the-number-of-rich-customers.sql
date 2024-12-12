# Write your MySQL query statement below
select  
    count(distinct a.customer_id) as rich_count
from (
    select 
        customer_id,
        max(amount) as max_amount
    from 
        Store
    group by 
        customer_id
    having 
        max(amount) > 500
) a