
create database Subqueries_CTEs_Assign


use Subqueries_CTEs_Assign


select *
from dbo.items

select *
from dbo.employees

select *
from dbo.departments

select *
from dbo.company


--Q1
go
select c.company_name , avg(i.price) as [average price of products]
from dbo.items i inner join dbo.company c
on i.company_id = c.company_id
group by c.company_name
go


--Q2
go
with avgOfProducts
as
(
	select  avg(i.price) [average price of products]
	from dbo.items i
)
select  c.company_name , avg(i.price) as [average price of products]
from dbo.items i inner join dbo.company c
on i.company_id = c.company_id
group by c.company_name
having  avg(i.price) > (select * from avgOfProducts )
go


--Q3
go
with avgOfProducts
as
(
	select  avg(i.price) [average price of products]
	from dbo.items i
)
select i.item_id, i.item_name,i.price,c.company_id
from dbo.items i inner join dbo.company c
on i.company_id = c.company_id
group by i.item_id, i.item_name,i.price,c.company_id
having  avg(i.price) > (select * from avgOfProducts )
go


--Q4
go
with avgOfbudget
as
(
	select  avg(d.dept_budget) [average department budget]
	from dbo.departments d
)
select e.emp_id,CONCAT_WS(' ',e.emp_fname,e.emp_lname) as [full name],e.emp_dept
from dbo.employees e inner join dbo.departments d
on e.emp_dept = d.dept_code
group by e.emp_id,CONCAT_WS(' ',e.emp_fname,e.emp_lname),e.emp_dept
having  avg(d.dept_budget) > (select * from avgOfbudget )
go


--Q5
with DeptCounts 
as 
(
    select d.dept_code,d.dept_name,count(e.emp_dept) as EmpCount,
        avg(cast(count(e.emp_dept) as float)) over()  as AvgEmpCount
    from dbo.departments d inner join dbo.employees e 
		on d.dept_code = e.emp_dept
    group by d.dept_code, d.dept_name
)
select dept_code,dept_name
from DeptCounts
where EmpCount > AvgEmpCount


--Q6
--Q7
--Q8
--Q9



