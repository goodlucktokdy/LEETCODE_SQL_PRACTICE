# Write your MySQL query statement below
with base as (
    select 
        row_number() over () as rnums,
        count(distinct case when content like '% bull %' then file_name else null end) as bull,
        count(distinct case when content like '% bear %' then file_name else null end) as bear
    from 
        Files
)
select 
    'bull' as word,
    case when bull is not null then bull else null end as count
from 
    base 
union all
select 
    'bear' as word ,
    case when bear is not null then bear else null end as count
from 
    base 