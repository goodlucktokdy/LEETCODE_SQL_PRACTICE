# Write your MySQL query statement below
select 
    distinct 
    viewer_id as id
from (
    select 
        viewer_id,
        view_date,
        count(distinct article_id) as cnts
    from 
        Views 
    group by 
        viewer_id, view_date
    having 
        cnts > 1
) a
order by 
    id 