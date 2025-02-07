# Write your MySQL query statement below
select 
    user_id,
    gender
from (
    select 
        user_id,
        gender,
        case when gender = 'female' then 1 
            when gender = 'other' then 2
            else 3 end as gender_rn,
        row_number() over (partition by gender order by user_id) as rnums
    from 
        Genders
) a
order by 
    rnums, gender_rn