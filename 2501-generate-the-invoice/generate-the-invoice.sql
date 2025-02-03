with base as (
    select 
        invoice_id,
        dense_rank() over (order by total_price desc,invoice_id asc) as ranks
    from (
        select 
            a.invoice_id,
            sum(a.quantity * b.price) as total_price
        from 
            Purchases a 
        inner join 
            Products b 
        on 
            a.product_id = b.product_id
        group by 
            a.invoice_id
    ) a 
)
select 
    a.product_id,
    a.quantity,
    a.quantity * b.price as price
from 
    Purchases a 
inner join 
    Products b 
on 
    a.product_id = b.product_id 
where 
    a.invoice_id in (select invoice_id from base where ranks = 1)