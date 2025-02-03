# Write your MySQL query statement below
with recursive cte as (
    select 
        task_id,
        1 as subtask_id
    from 
        Tasks
    union all
    select 
        a.task_id,
        cte.subtask_id + 1 
    from 
        Tasks a 
    inner join 
        cte 
    on 
        a.task_id = cte.task_id
    where 
        cte.subtask_id < a.subtasks_count
)
select 
    a.task_id,
    a.subtask_id
from 
    cte a 
left join 
    Executed b 
on 
    a.task_id = b.task_id and a.subtask_id = b.subtask_id
where 
    b.subtask_id is null 