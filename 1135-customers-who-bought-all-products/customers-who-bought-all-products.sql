# Write your MySQL query statement below
with base as (
    select
        distinct
        b.customer_id,
        sum(distinct a.product_key) as sums,
        count(distinct a.product_key) as cnts
    from 
        Product a 
    join 
        Customer b 
    on
        a.product_key = b.product_key
    group by 
        b.customer_id
)
select 
    customer_id
from 
    base
where 
    sums = (select sum(distinct product_key) from Product)
    and cnts = (select count(distinct product_key) from Product)