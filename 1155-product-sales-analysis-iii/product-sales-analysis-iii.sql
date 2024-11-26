with base as (
    select 
        a.sale_id,
        a.product_id,
        b.product_name,
        a.year,
        a.quantity,
        a.price
    from 
        Sales a
    left join 
        Product b 
    on 
        a.product_id = b.product_id
)
select 
    distinct
    a.product_id,
    a.first_year,
    a.quantity,
    a.price
from (
    select 
        product_id,
        year,
        min(year) over (partition by product_id) as first_year,
        quantity,
        price
    from
        base
    group by 
        product_id, quantity, price
) a
where 
    a.year = a.first_year