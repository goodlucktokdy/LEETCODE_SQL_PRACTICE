# Write your MySQL query statement below
with base as (
    select 
        a.product_id,
        a.start_date,
        a.end_date,
        b.purchase_date,
        a.price,
        b.units,
        a.price * b.units as sales
    from 
        Prices a 
    left join 
        UnitsSold b 
    on 
        a.product_id = b.product_id 
    and 
        b.purchase_date between a.start_date and a.end_date
)
select 
    product_id,
    round(coalesce(sum(sales)/sum(units),0),2) as average_price
from 
    base 
group by 
    product_id 
