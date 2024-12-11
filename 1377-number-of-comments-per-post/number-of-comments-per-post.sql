with base as (
    select 
        a.sub_id,
        b.sub_id as bsi
    from 
        Submissions a 
    left join 
        Submissions b 
    on 
        a.sub_id = b.parent_id
    where 
        a.parent_id is null
)
select 
    sub_id as post_id,
    count(distinct bsi) as number_of_comments
from 
    base 
group by 
    post_id
order by 
    post_id