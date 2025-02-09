# Write your MySQL query statement below
select 
    a.book_id as book_id,
    a.name as name
from 
    Books a 
left join 
    Orders b 
on 
    a.book_id = b.book_id
    and date_sub('2019-06-23',interval 1 year) <= b.dispatch_date
where 
    date_sub('2019-06-23',interval 1 month) >= a.available_from
group by 
    book_id,name
having 
    sum(coalesce(b.quantity,0)) < 10
