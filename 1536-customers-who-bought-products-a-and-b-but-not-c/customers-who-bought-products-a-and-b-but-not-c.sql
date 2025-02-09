# Write your MySQL query statement below
with base as (
    select 
        customer_id,
        product_name
    from 
        Orders a 
    where not exists 
        (select 1 from Orders b 
            where a.customer_id = b.customer_id and b.product_name = 'C')
)
select 
    a.customer_id,
    b.customer_name
from 
    base a
inner join 
    Customers b 
on 
    a.customer_id = b.customer_id
group by 
    a.customer_id
having 
    count(distinct case when product_name in ('A','B') then product_name else null end) = 2
order by 
    a.customer_id