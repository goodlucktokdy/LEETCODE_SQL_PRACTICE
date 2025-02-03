

select 
    max(case when continent = 'America' then name else null end) as America,
    max(case when continent = 'Asia' then name else null end) as Asia,
    max(case when continent = 'Europe' then name else null end) as Europe
from (
    select 
        name,
        continent,
        row_number() over (partition by continent order by name) as rnums
    from 
        Student
) a 
group by 
    rnums