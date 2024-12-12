# Write your MySQL query statement below
with base as (
    select 
        product_id,
        'store1' as store,
        store1 as price
    from 
        Products
    union all
    select 
        product_id,
        'store2' as store,
        store2 as price
    from 
        Products
    union all
        select
        product_id,
        'store3' as store,
        store3 as price
    from 
        Products
)
select 
    product_id,
    store,
    price
from 
    base 
where 
    price is not null