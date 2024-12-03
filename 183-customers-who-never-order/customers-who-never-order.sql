select
    a.name as Customers
from 
    Customers a
left join
    Orders b
on
    a.id = b.customerId
where
        b.customerId is null