--02 위치에 따른 서브 쿼리

--01 select절
select *
	, (select gender
	from [Member] B
	where A.mem_no = B.mem_no) as gender
	from [Order] A
--02 from절
select *
from(
	select mem_no
	,SUM(sales_amt) as tot_amt --집계함수에 대한 열 이름
	from [Order]
	group
	by mem_no
	)A --서브 쿼리에 대한 테이블명
--from 절에 사용되는 서브 쿼리
--[Member] 및 [Order] 테이블 공통 값(mem_no) 결합
--1:1 관계
select *
from(
	select mem_no
	, sum(sales_amt) as tot_amt
	from [Order]
	group
	by mem_no
	)A
left
join [Member] B
on A.mem_no = B.mem_no
--03 where절
--where절에 사용되는 서브 쿼리 (단일 행 서브 쿼리)
--단일 행 : 서브 쿼리 결과가 단일 행
select *
from [Order]
where mem_no = (select mem_no from [Member] where mem_no = '1000005')

--단일 행 확인
select mem_no from [Member] where mem_no = '1000005'
--다중 행:서브 쿼리 결과가 여러 행
select *
from [Order]
where mem_no in (select mem_no from [Member] where gender = 'man')

--단일 행 확인
select mem_no from [Member] where gender = 'man'
