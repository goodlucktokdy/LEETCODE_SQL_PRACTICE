# Write your MySQL query statement below
with base as (
    select 
        viewer_id,
        view_date,
        count(distinct article_id) as cnts
    from 
        Views 
    group by 
        1,2
)
select 
    distinct 
    viewer_id as id
from 
    base 
where 
    cnts > 1 
order by 
    id