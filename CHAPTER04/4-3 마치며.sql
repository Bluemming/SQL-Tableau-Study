--01
--1
use edu
select mem_no
		,sum(sales_amt) as tot_amt
		,count(order_no) as tot_tr
from [Order]
where year(order_date) = 2020
group by mem_no

--2
select A.*
	, B.tot_amt
	, B.tot_tr
	from [Member] A
left join (
	select mem_no
		, sum(sales_amt) as tot_amt
		, count(order_no) as tot_tr
	from [Order]
	where year(order_date) = 2020
	group by mem_no
	) B
on A.mem_no = B.mem_no

--3
select A.*
	, B.tot_amt
	, B.tot_tr
	, case when B.mem_no is not null then '구매자'
			else '미구매자' end as pur_vn
	from [Member] A
left join (
	select mem_no
		, sum(sales_amt) as tot_amt
		, count(order_no) as tot_tr
	from [Order]
	where year(order_date) = 2020
	group by mem_no
	) B
on A.mem_no = B.mem_no

--4
select A.*
	, B.tot_amt
	, B.tot_tr
	, case when B.mem_no is not null then '구매자'
			else '미구매자' end as pur_vn
	into [Mart_2020]
	from [Member] A
left join (
	select mem_no
		, sum(sales_amt) as tot_amt
		, count(order_no) as tot_tr
	from [Order]
	where year(order_date) = 2020
	group by mem_no
	) B
on A.mem_no = B.mem_no

--02
use edu
--데이터 마트 정합성 체크
--1 회원수 중복 유무
select count(mem_no) as 회원수
		, count(distinct mem_no) as 회원수_중복제거
from [Mart_2020]

--2
select count(mem_no) as 회원수
		, count(distinct mem_no) as 회원수_중복제거
from [Member]

--3
select sum(tot_tr) as 주문수
	from [Mart_2020]
select count(order_no) as 주문수
		,count(distinct order_no) as 주문수_중복제거
	from [Order]
where year(order_date) = 2020

--4
select *
from [Order]
where mem_no in (select mem_no from [Mart_2020] where pur_vn = '미구매자')
and year(order_date) = 2020
