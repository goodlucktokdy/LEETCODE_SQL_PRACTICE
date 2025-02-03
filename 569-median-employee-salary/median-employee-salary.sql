select 
    id,
    company,
    salary
from (
    select 
        id,
        company,
        salary,
        count(id) over (partition by company) as cnts,
        row_number() over (partition by company order by salary asc, id asc) as ranks
    from 
        Employee
) a 
where 
    ranks between cnts/2 and cnts/2 + 1
