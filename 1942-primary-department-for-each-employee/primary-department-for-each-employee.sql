# Write your MySQL query statement below
with base as (
    select 
        employee_id,
        department_id,
        count(department_id) over (partition by employee_id) as dept_per_employee,
        primary_flag
    from 
        Employee
)
select 
    distinct
    employee_id,
    department_id
from 
    base 
where 
    (dept_per_employee = 1 and primary_flag = 'N') or primary_flag = 'Y'