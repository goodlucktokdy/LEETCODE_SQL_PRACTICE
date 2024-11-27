# Write your MySQL query statement below
select 
    distinct
    a.author_id as id
from (
    select 
        distinct
        author_id,
        viewer_id
    from 
        Views
    where 
        author_id = viewer_id
) a
order by 
    id 