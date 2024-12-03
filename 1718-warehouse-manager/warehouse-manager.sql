with base as (
    select
        a.name as warehouse_name,
        a.units * b.Width * b.Length * b.Height as volume
    from 
        Warehouse a
    inner join 
        Products b
    on
        a.product_id = b.product_id
)
select
    warehouse_name,
    sum(volume) as volume
from 
    base
group by 
    1