# Write your MySQL query statement below
with base as (
    select 
        a.product_id,
        a.sale_date,
        b.product_name
    from 
        Sales a 
    left join 
        Product b 
    on 
        a.product_id = b.product_id
    where 
        a.sale_date between '2019-01-01' and '2019-03-31'
)
select 
    distinct
    product_id,
    product_name
from 
    base 
where 
    product_id not in (select product_id from Sales where sale_date 
                            not between '2019-01-01' and '2019-03-31')
    