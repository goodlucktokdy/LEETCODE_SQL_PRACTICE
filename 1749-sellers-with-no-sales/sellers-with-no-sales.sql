select
    distinct
    a.seller_name
from 
    Seller a 
left join
    Orders b
on
    a.seller_id = b.seller_id
where
    a.seller_id not in (select seller_id from Orders where year(sale_date) = 2020) 
order by 
    seller_name asc