# Write your MySQL query statement below
with base as (
    select 
        product_id,
        lag(years,1,years-1) over (partition by product_id order by years) as prev_years,
        years,
        lag(orders,1,0) over (partition by product_id order by years) as prev_orders,
        orders
    from (
        select 
            product_id,
            year(purchase_date) as years,
            count(distinct order_id) as orders
        from 
            Orders 
        group by 
            product_id, years
    ) a
)
select 
    distinct 
    a.product_id
from 
    base a 
where exists 
    (select 1 from base b 
        where a.product_id = b.product_id and (b.years - b.prev_years = 1 and b.prev_orders >= 3 and b.orders >= 3))
