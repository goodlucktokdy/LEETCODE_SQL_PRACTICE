# Write your MySQL query statement below
with t1 as
    (
        select
            d.name Department, e.name Employee, e.salary Salary,
            dense_rank() over (partition by e.departmentId order by e.salary desc) sal_rank
        from
                Employee e
            inner join
                Department d
                on e.departmentId = d.id
    )
select
    Department, Employee, Salary
    from
        t1
    where
        sal_rank <= 3
