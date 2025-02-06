# Write your MySQL query statement below
with base as (
    select 
        a.customer_id,
        b.product_key
    from 
        Customer a 
    cross join 
        Product b 
),
no_filter as (
    select 
        a.customer_id
    from 
        base a 
    left join 
        Customer b 
    on 
        a.customer_id = b.customer_id and a.product_key = b.product_key
    where 
        b.product_key is null 
)
select 
    distinct 
    a.customer_id
from 
    Customer a 
left join 
    no_filter b 
on 
    a.customer_id = b.customer_id 
where 
    b.customer_id is null