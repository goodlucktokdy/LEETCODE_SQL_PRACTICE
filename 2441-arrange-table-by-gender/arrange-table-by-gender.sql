# Write your MySQL query statement below
with base as (
    select 
        user_id,
        gender,
        gen_ranks,
        row_number() over (partition by gen_ranks order by user_id) as rnums
    from (
        select 
            user_id,
            gender,
            case when gender = 'female' then 1 
                when gender = 'other' then 2
                else 3 end as gen_ranks
        from 
            Genders
    ) a
)
select 
    user_id,
    gender
from 
    base 
order by 
    rnums asc, gen_ranks asc