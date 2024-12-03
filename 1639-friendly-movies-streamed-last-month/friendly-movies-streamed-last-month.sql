select
    distinct
    b.title
from 
    TVProgram a
inner join 
    Content b 
on
    a.content_id = b.content_id
where 
    b.Kids_content = 'Y' and date_format(a.program_date,'%Y-%m') = '2020-06'
    and b.content_type = 'Movies'
