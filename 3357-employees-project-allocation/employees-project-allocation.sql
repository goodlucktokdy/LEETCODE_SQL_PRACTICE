select 
    employee_id,
    project_id,
    employee_name,
    project_workload
from (
    select 
        a.employee_id,
        a.project_id,
        b.name as employee_name,
        a.workload as project_workload,
        avg(a.workload) over (partition by b.team) as team_avg
    from 
        Project a 
    inner join 
        Employees b 
    on 
        a.employee_id = b.employee_id
) a 
where 
    project_workload > team_avg 
order by 
    employee_id, project_id