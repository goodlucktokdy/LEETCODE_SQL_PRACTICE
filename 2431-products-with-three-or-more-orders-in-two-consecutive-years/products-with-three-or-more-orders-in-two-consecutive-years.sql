# Write your MySQL query statement below
with base as (
    select 
        product_id,
        lag(years,1,years - 1) over (partition by product_id order by years) as prev_year,
        years,
        years - row_number() over (partition by product_id order by years) as sess,
        cnts
    from (
        select
            distinct
            product_id,
            year(purchase_date) as years,
            count(order_id) as cnts
        from 
            Orders
        group by 
            product_id, years
    ) a
    where 
        cnts >= 3
)
select 
    distinct 
    product_id
from 
    base
group by 
    product_id, sess
having 
    count(distinct years) >= 2
