# Write your MySQL query statement below
with base as (
    select
        a.product_id,
        a.order_date,
        a.unit,
        b.product_name
    from 
        Orders a
    left join 
        Products b 
    on 
        a.product_id = b.product_id
    where
        date_format(a.order_date,'%Y-%m') = '2020-02'
)
select
    product_name,
    sum(unit) as unit
from 
    base
group by 
    product_name
having 
    unit >= 100