# Write your MySQL query statement below
with base as (
    select 
        year,
        product_id,
        orders,
        year - cast(row_number() over (partition by product_id order by year) as real) as sess
    from (
        select 
            year(purchase_date) as year,
            product_id,
            count(distinct order_id) as orders
        from 
            Orders 
        group by 
            year(purchase_date), product_id
    ) a
    where 
        orders >= 3
)
select 
    distinct 
    product_id
from 
    base 
group by 
    product_id, sess
having 
    count(distinct year) >= 2