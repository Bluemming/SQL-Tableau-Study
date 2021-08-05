use edu

--01
select *
from [Order]

select *
from [Order]
where shop_code >= 30

select mem_no
	,sum(sales_amt) as tot_amt
	from [Order]
	where shop_code >=30
	group
	by mem_no

select mem_no
	,sum(sales_amt) as tot_amt
	from [Order]
	where shop_code >=30
	group
	by mem_no
	having sum(sales_amt) >= 100000

select mem_no
	,sum(sales_amt) as tot_amt
	from [Order]
	where shop_code >=30
	group
	by mem_no
	having sum(sales_amt) >= 100000
	order
	by sum(sales_amt) desc

--02
select *
from [Order] A
left join [Member] B
on A.mem_no = B.mem_no

select B.gender,
	sum(sales_amt) as tot_amt
	from [Order] A
	left join [Member] B
	on A.mem_no = B.mem_no
	group
	by B.gender

select B.gender,
	B.addr,
	sum(sales_amt) as tot_amt
	from [Order] A
	left join [Member] B
	on A.mem_no = B.mem_no
	group
	by B.gender, B.addr

--03
select mem_no, sum(sales_amt) as tot_amt
from [Order]
group by mem_no

select *
from (
	select mem_no,sum(sales_amt) as tot_amt
	from [Order]
	group by mem_no
	) A
left join [Member] B
on A.mem_no = B.mem_no

select B.gender, B.addr, sum(tot_amt) as гу╟Х
from (
	select mem_no,sum(sales_amt) as tot_amt
	from [Order]
	group by mem_no
	) A
left join [Member] B
on A.mem_no = B.mem_no
group by B.gender, B.addr
