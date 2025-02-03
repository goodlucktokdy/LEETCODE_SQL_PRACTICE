with base as (
    select 
        a.item_category as Category,
        weekday(b.order_date) as days,
        sum(coalesce(b.quantity,0)) as quantity 
    from 
        Items a 
    left join 
        Orders b 
    on 
        a.item_id = b.item_id
    group by 
        Category, days
)
select 
    Category,
    max(case when days = 0 then quantity else 0 end) as Monday,
    max(case when days = 1 then quantity else 0 end) as Tuesday,
    max(case when days = 2 then quantity else 0 end) as Wednesday,
    max(case when days = 3 then quantity else 0 end) as Thursday,
    max(case when days = 4 then quantity else 0 end) as Friday,
    max(case when days = 5 then quantity else 0 end) as Saturday,
    max(case when days = 6 then quantity else 0 end) as Sunday
from 
    base 
group by 
    Category 
order by 
    Category