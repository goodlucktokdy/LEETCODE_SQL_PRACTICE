# Write your MySQL query statement below
with base as (
    select 
        book_id,
        name,
        available_from
    from 
        Books 
    where 
        available_from <= date_sub('2019-06-23',interval 1 month)
)
select 
    book_id,
    name
from (
    select 
        a.book_id,
        a.name,
        coalesce(b.quantity,0) as quantity
    from 
        base a 
    left join 
        Orders b 
    on 
        a.book_id = b.book_id 
    and
        date_sub('2019-06-23',interval 1 year) <= b.dispatch_date
) a 
group by 
    book_id, name
having 
    sum(quantity) < 10