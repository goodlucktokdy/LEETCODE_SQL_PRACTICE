with base as (
    select 
        distinct
        product_id,
        new_price as price
    from (
        select 
            product_id,
            new_price,
            change_date,
            max(change_date) over (partition by product_id) as max_date
        from 
            Products
        where 
            change_date <= '2019-08-16'
    ) a
    where 
        max_date = change_date
),
other_cte as (    
    select 
        product_id,
        10 as price
    from (
        select 
            product_id,
            new_price,
            change_date
        from 
            Products a 
        where not exists 
            (select 1 from Products b 
                where a.product_id = b.product_id and b.change_date <= '2019-08-16')
    ) c
)
select 
    product_id,
    price
from 
    base 
union 
select 
    product_id,
    price
from 
    other_cte