select
    a.sale_date,
    sum(a.apples) - sum(a.oranges) as diff
from (
        select
            sale_date,
            case when fruit = 'apples' then sold_num else 0 end as apples,
            case when fruit = 'oranges' then sold_num else 0 end as oranges
        from 
            Sales
) a
group by 
    a.sale_date
order by 
    a.sale_date
