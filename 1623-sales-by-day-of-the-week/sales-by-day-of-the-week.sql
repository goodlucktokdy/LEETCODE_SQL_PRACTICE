# Write your MySQL query statement below
select 
    item_category as Category,
    max(case when days = 0 then quantity else 0 end) as Monday,
    max(case when days = 1 then quantity else 0 end) as Tuesday,
    max(case when days = 2 then quantity else 0 end) as Wednesday,
    max(case when days = 3 then quantity else 0 end) as Thursday,
    max(case when days = 4 then quantity else 0 end) as Friday,
    max(case when days = 5 then quantity else 0 end) as Saturday,
    max(case when days = 6 then quantity else 0 end) as Sunday
from (
    select 
        a.item_category,
        weekday(b.order_date) as days,
        sum(coalesce(b.quantity,0)) as quantity
    from 
        Items a
    left join 
        Orders b 
    on 
        a.item_id = b.item_id
    group by 
        a.item_category, weekday(b.order_date)
) c
group by 
    item_category
order by 
    Category