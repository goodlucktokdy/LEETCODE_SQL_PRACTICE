# Write your MySQL query statement below
select 
    customer_name,
    customer_id,
    order_id,
    order_date
from (
    select 
        a.name as customer_name,
        a.customer_id,
        b.order_id,
        b.order_date,
        row_number() over (partition by a.customer_id order by b.order_date desc) as ranks
    from 
        Customers a
    inner join 
        Orders b 
    on 
        a.customer_id = b.customer_id
) a
where 
    ranks <= 3
order by 
    customer_name, customer_id, order_date desc