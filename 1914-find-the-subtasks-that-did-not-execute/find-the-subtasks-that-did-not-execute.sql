-- -- -- -- -- -- -- -- -- -- with recursive cte as(
-- -- -- -- -- -- -- -- -- --     select *
-- -- -- -- -- -- -- -- -- --         from Tasks
-- -- -- -- -- -- -- -- -- --     union
-- -- -- -- -- -- -- -- -- --     select task_id, subtasks_count  - 1
-- -- -- -- -- -- -- -- -- --         from cte where subtasks_count  > 1
-- -- -- -- -- -- -- -- -- -- ),
-- -- -- -- -- -- -- -- -- -- joins as (
-- -- -- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- -- -- --         distinct
-- -- -- -- -- -- -- -- -- --         a.task_id,
-- -- -- -- -- -- -- -- -- --         a.subtasks_count,
-- -- -- -- -- -- -- -- -- --         ifnull(b.subtask_id,0) as subtasks_executed
-- -- -- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- -- -- --         cte a 
-- -- -- -- -- -- -- -- -- --     left join 
-- -- -- -- -- -- -- -- -- --         Executed b 
-- -- -- -- -- -- -- -- -- --     on 
-- -- -- -- -- -- -- -- -- --         a.task_id = b.task_id 
-- -- -- -- -- -- -- -- -- -- )
-- -- -- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- -- -- --     distinct
-- -- -- -- -- -- -- -- -- --     task_id,
-- -- -- -- -- -- -- -- -- --     subtasks_count as subtask_id
-- -- -- -- -- -- -- -- -- -- from 
-- -- -- -- -- -- -- -- -- --     joins a
-- -- -- -- -- -- -- -- -- -- where 
-- -- -- -- -- -- -- -- -- --     not exists
-- -- -- -- -- -- -- -- -- --     (select 1 from Executed b 
-- -- -- -- -- -- -- -- -- --      where b.task_id = a.task_id and a.subtasks_count = b.subtask_id)

-- -- -- -- -- -- -- -- -- with recursive cte as (
-- -- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- -- --         task_id,
-- -- -- -- -- -- -- -- --         1 as subtasks
-- -- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- -- --         Tasks
-- -- -- -- -- -- -- -- --     union all
-- -- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- -- --         a.task_id,
-- -- -- -- -- -- -- -- --         cte.subtasks + 1
-- -- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- -- --         Tasks a
-- -- -- -- -- -- -- -- --     inner join 
-- -- -- -- -- -- -- -- --         cte
-- -- -- -- -- -- -- -- --     on 
-- -- -- -- -- -- -- -- --         a.task_id = cte.task_id
-- -- -- -- -- -- -- -- --     where 
-- -- -- -- -- -- -- -- --         cte.subtasks < a.subtasks_count
-- -- -- -- -- -- -- -- -- )
-- -- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- -- --     task_id,
-- -- -- -- -- -- -- -- --     subtasks as subtask_id
-- -- -- -- -- -- -- -- -- from (
-- -- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- -- --         a.task_id,
-- -- -- -- -- -- -- -- --         a.subtasks,
-- -- -- -- -- -- -- -- --         ifnull(b.subtask_id,0) as subtask_id
-- -- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- -- --         cte a
-- -- -- -- -- -- -- -- --     left join 
-- -- -- -- -- -- -- -- --         Executed b 
-- -- -- -- -- -- -- -- --     on 
-- -- -- -- -- -- -- -- --         a.task_id = b.task_id and a.subtasks = b.subtask_id
-- -- -- -- -- -- -- -- -- ) a
-- -- -- -- -- -- -- -- -- where 
-- -- -- -- -- -- -- -- --     subtask_id = 0    


-- -- -- -- -- -- -- -- with recursive cte as (
-- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- --         1 as subtasks,
-- -- -- -- -- -- -- --         task_id
-- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- --         Tasks
-- -- -- -- -- -- -- --     union all
-- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- --         cte.subtasks + 1,
-- -- -- -- -- -- -- --         a.task_id
-- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- --         Tasks a
-- -- -- -- -- -- -- --     inner join 
-- -- -- -- -- -- -- --         cte
-- -- -- -- -- -- -- --     on 
-- -- -- -- -- -- -- --         a.task_id = cte.task_id
-- -- -- -- -- -- -- --     where 
-- -- -- -- -- -- -- --         cte.subtasks < a.subtasks_count
-- -- -- -- -- -- -- -- )
-- -- -- -- -- -- -- -- select
-- -- -- -- -- -- -- --     distinct
-- -- -- -- -- -- -- --     a.task_id,
-- -- -- -- -- -- -- --     a.subtasks as subtask_id
-- -- -- -- -- -- -- -- from 
-- -- -- -- -- -- -- --     cte a
-- -- -- -- -- -- -- -- left join 
-- -- -- -- -- -- -- --     Executed b
-- -- -- -- -- -- -- -- on 
-- -- -- -- -- -- -- --     a.task_id = b.task_id and a.subtasks = b.subtask_id
-- -- -- -- -- -- -- -- where
-- -- -- -- -- -- -- --     b.subtask_id is null
-- -- -- -- -- -- -- with recursive cte as (
-- -- -- -- -- -- --     select 
-- -- -- -- -- -- --         task_id,
-- -- -- -- -- -- --         1 as subtask
-- -- -- -- -- -- --     from 
-- -- -- -- -- -- --         Tasks
-- -- -- -- -- -- --     union all
-- -- -- -- -- -- --     select 
-- -- -- -- -- -- --         a.task_id,
-- -- -- -- -- -- --         cte.subtask + 1 
-- -- -- -- -- -- --     from 
-- -- -- -- -- -- --         Tasks a 
-- -- -- -- -- -- --     inner join 
-- -- -- -- -- -- --         cte 
-- -- -- -- -- -- --     on 
-- -- -- -- -- -- --         a.task_id = cte.task_id
-- -- -- -- -- -- --     where 
-- -- -- -- -- -- --         cte.subtask < a.subtasks_count
-- -- -- -- -- -- -- )
-- -- -- -- -- -- -- select 
-- -- -- -- -- -- --     distinct
-- -- -- -- -- -- --     a.task_id,
-- -- -- -- -- -- --     a.subtask as subtask_id
-- -- -- -- -- -- -- from 
-- -- -- -- -- -- --     cte a
-- -- -- -- -- -- -- where 
-- -- -- -- -- -- --     not exists (select 1 from Executed b 
-- -- -- -- -- -- --                 where a.task_id = b.task_id and a.subtask = b.subtask_id)

-- -- -- -- -- -- with recursive cte as (
-- -- -- -- -- --     select 
-- -- -- -- -- --         task_id,
-- -- -- -- -- --          1 as subtask_id
-- -- -- -- -- --     from 
-- -- -- -- -- --         Tasks
-- -- -- -- -- --     union all
-- -- -- -- -- --     select 
-- -- -- -- -- --         a.task_id,
-- -- -- -- -- --         cte.subtask_id + 1 
-- -- -- -- -- --     from 
-- -- -- -- -- --         Tasks a 
-- -- -- -- -- --     inner join 
-- -- -- -- -- --         cte 
-- -- -- -- -- --     on 
-- -- -- -- -- --         a.task_id = cte.task_id 
-- -- -- -- -- --     where 
-- -- -- -- -- --         cte.subtask_id < a.subtasks_count
-- -- -- -- -- -- )
-- -- -- -- -- -- select 
-- -- -- -- -- --     task_id,
-- -- -- -- -- --     subtask_id
-- -- -- -- -- -- from 
-- -- -- -- -- --     cte a 
-- -- -- -- -- -- where 
-- -- -- -- -- --     not exists (select 1 from Executed b 
-- -- -- -- -- --                 where a.task_id = b.task_id and a.subtask_id = b.subtask_id)

-- -- -- -- -- with recursive tasks_cte as (
-- -- -- -- --     select 
-- -- -- -- --         task_id,
-- -- -- -- --         1 as subtasks_id
-- -- -- -- --     from 
-- -- -- -- --         Tasks
-- -- -- -- --     union all 
-- -- -- -- --     select 
-- -- -- -- --         a.task_id,
-- -- -- -- --         b.subtasks_id + 1
-- -- -- -- --     from 
-- -- -- -- --         tasks_cte b 
-- -- -- -- --     inner join 
-- -- -- -- --         Tasks a 
-- -- -- -- --     on 
-- -- -- -- --         a.task_id = b.task_id
-- -- -- -- --     where 
-- -- -- -- --         b.subtasks_id < a.subtasks_count
-- -- -- -- -- )
-- -- -- -- -- select 
-- -- -- -- --     distinct 
-- -- -- -- --     task_id,
-- -- -- -- --     subtasks_id as subtask_id 
-- -- -- -- -- from 
-- -- -- -- --     tasks_cte a
-- -- -- -- -- where not exists
-- -- -- -- --     (select 1 from Executed b 
-- -- -- -- --     where a.task_id = b.task_id and a.subtasks_id = b.subtask_id)
-- -- -- -- with recursive cte as (
-- -- -- --     select 
-- -- -- --         task_id,
-- -- -- --         1 as subtask_id
-- -- -- --     from 
-- -- -- --         Tasks
-- -- -- --     union all
-- -- -- --     select 
-- -- -- --         a.task_id,
-- -- -- --         cte.subtask_id + 1 
-- -- -- --     from 
-- -- -- --         cte 
-- -- -- --     inner join 
-- -- -- --         Tasks a 
-- -- -- --     on 
-- -- -- --         a.task_id = cte.task_id 
-- -- -- --     where 
-- -- -- --         cte.subtask_id < a.subtasks_count
-- -- -- -- )
-- -- -- -- select 
-- -- -- --     distinct 
-- -- -- --     task_id,
-- -- -- --     subtask_id
-- -- -- -- from 
-- -- -- --     cte a 
-- -- -- -- where 
-- -- -- --     not exists 
-- -- -- --         (select 1 from Executed b 
-- -- -- --             where a.task_id = b.task_id
-- -- -- --             and a.subtask_id = b.subtask_id)

-- -- -- with recursive cte as (
-- -- --     select 
-- -- --         task_id,
-- -- --         1 as subtask_id
-- -- --     from 
-- -- --         Tasks
-- -- --     union all
-- -- --     select 
-- -- --         a.task_id,
-- -- --         cte.subtask_id + 1 
-- -- --     from 
-- -- --         Tasks a 
-- -- --     inner join 
-- -- --         cte 
-- -- --     on
-- -- --         a.task_id = cte.task_id 
-- -- --     where 
-- -- --         cte.subtask_id < a.subtasks_count
-- -- -- )
-- -- -- select 
-- -- --     task_id,
-- -- --     subtask_id
-- -- -- from 
-- -- --     cte a 
-- -- -- where not exists
-- -- --     (select 1 from Executed b 
-- -- --         where a.task_id = b.task_id and a.subtask_id = b.subtask_id)

-- -- with recursive cte as (
-- --     select 
-- --         task_id,
-- --         1 as subtask_id
-- --     from 
-- --         Tasks
-- --     union all
-- --     select 
-- --         a.task_id,
-- --         cte.subtask_id + 1 
-- --     from 
-- --         Tasks a 
-- --     inner join 
-- --         cte 
-- --     on 
-- --         a.task_id = cte.task_id 
-- --     where 
-- --         cte.subtask_id < a.subtasks_count
-- -- )
-- -- select 
-- --     task_id,
-- --     subtask_id
-- -- from 
-- --     cte a 
-- -- where not exists 
-- --     (select 1 from Executed b 
-- --         where a.task_id = b.task_id and a.subtask_id = b.subtask_id)

-- with recursive cte as (
--     select 
--         task_id,
--         1 as subtask_id
--     from 
--         Tasks 
--     union all
--     select 
--         a.task_id,
--         cte.subtask_id + 1 
--     from 
--         Tasks a 
--     inner join 
--         cte 
--     on 
--         a.task_id = cte.task_id 
--     where 
--         cte.subtask_id < a.subtasks_count
-- )
-- select 
--     task_id,
--     subtask_id
-- from 
--     cte a 
-- where not exists 
--     (select 1 from Executed b 
--         where a.task_id = b.task_id and a.subtask_id = b.subtask_id)

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
    task_id,
    subtask_id 
from 
    cte a
where not exists 
    (select 1 from Executed b 
        where a.task_id = b.task_id and a.subtask_id = b.subtask_id)