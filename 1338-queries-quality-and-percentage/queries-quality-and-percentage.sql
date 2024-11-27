
select 
    query_name,
    round(avg(rating/position),2) as quality,
    round(coalesce(100*count(case when rating < 3 then 1 else null end)/count(query_name),0),2) as poor_query_percentage
from 
    Queries
where 
    query_name is not null
group by 
    query_name