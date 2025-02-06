# Write your MySQL query statement below
select 
    distinct 
    viewer_id as id
from (
    select 
        view_date,
        viewer_id,
        count(distinct article_id) as cnts
    from 
        Views
    group by 
        view_date, viewer_id 
    having 
        cnts > 1
) a 
order by 
    id