# Write your MySQL query statement below
with base as (
    select 
        customer_id,
        sum(distinct product_key) as sums,
        count(distinct product_key) as cnts
    from 
        Customer
    group by 
        customer_id
)
select 
    distinct 
    customer_id
from 
    base 
where 
    sums = (select sum(distinct product_key) from Product) and 
    cnts = (select count(distinct product_key) from Product)