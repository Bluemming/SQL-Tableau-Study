--01
use edu
--ERD를 활용한 데이터 마트 구성
select A.*
	, B.prod_cd
	, B.quantity
	, D.price
	, B.quantity * D.price as sales_amt
	, C.store_addr
	, D.brand
	, D.model
	, E.gender
	, E.age
	, E.addr
	, E.join_date
into [Car_Mart]
from [Car_order] A
left join [Car_orderdetail] B on A.order_no = B.order_no
left join [Car_store] C on A.store_cd = C.store_cd
left join [Car_product] D on B.prod_cd = D.prod_cd
left join [Car_member] E on A.mem_no = E.mem_no

--[Car_Mart] 테이블의 모든 컬럼 조회
select *
from [Car_Mart]

--02 구매 고객 프로파일 분석
use edu
select *
		,case when age < 20 then '20대 미만'
			  when age between 20 and 29 then '20대'
			  when age between 30 and 39 then '30대'
			  when age between 40 and 49 then '40대'
			  when age between 50 and 59 then '50대'
			  else '60대 이상' end as ageband
	into #profile_base --임시 테이블명
	from [Car_Mart]

--임시 테이블 조회
select *
from #profile_base

--성별 구매자 분포
select gender
	,count(distinct mem_no) as tot_mem
	from #profile_base
	group by gender

--연령대별 구매자 분포
select ageband
	,count(distinct mem_no) as tot_mem
	from #profile_base
	group by ageband

--성별 및 연령대별 구매자 분포
select gender, ageband
	,count(distinct mem_no) as tot_mem
	from #profile_base
	group by gender, ageband
	order by 1

--성별 및 연령대별 구매자 분포(+연도별)
select gender, ageband
		,count(distinct case when year(order_date) = 2020 then mem_no end) as tot_mem_2020
		,count(distinct case when year(order_date) = 2021 then mem_no end) as tot_mem_2021
	from #profile_base
	group by gender, ageband
	order by 1

--03 고객 세분화 분석 RFM
use edu
select mem_no
	,sum(sales_amt) as tot_amt -- M :구매금액
	, count(order_no) as tot_tr -- F : 구매빈도
	into #RFM_BASE
	from [Car_Mart]
	where year(order_date) between 2020 and 2021 -- R:최근성
	group by mem_no
select *
from #RFM_BASE

select A.*
	, B.tot_amt
	, B.tot_tr
	, case when B.tot_amt >= 1000000000 and B.tot_tr >=3 then '1_VVIP'
		   when B.tot_amt >=  500000000 and B.tot_tr >=2 then '2_VIP'
		   when B.tot_amt >=  300000000 then '3_GOLD'
		   when B.tot_amt >=  100000000 then '4_SILVER'
		   when B.tot_amt >= 1 then '5_BRONZE'
		   else '6_POTENTIAL' end as segmentation
		into #RFM_BASE_SEG
		from [Car_Mart] A
		left join #RFM_BASE B
		on A.mem_no = B.mem_no
select *
from #RFM_BASE_SEG

--3 고객 수 및 매출 비중 파악
select segmentation
	, count(mem_no) as tot_mem
	, sum(tot_amt) as tot_amt
	from #RFM_BASE_SEG
	group by segmentation
	order by 1


--04 구매전환율 및 구매주기 분석
use edu
select A.mem_no as pur_mem_2020
	, B.mem_no as pur_mem_2021
	, case when B.mem_no is not null then 'Y' else 'N' end as retention_yn
into #retention_base
from (select distinct mem_no from [Car_Mart] where year(order_date) = 2020) A
left join (select distinct mem_no from [Car_Mart] where year(order_date) = 2021) B
on A.mem_no = B.mem_no

select *
from #retention_base

select count(pur_mem_2020) as tot_mem
	, count(case when retention_yn = 'Y' then pur_mem_2020 end) as retention_mem
	from #retention_base

select store_cd
	, min(order_date) as min_order_date
	, max(order_date) as max_order_date
	, count(distinct order_no) -1 as tot_tr_1
into #cycle_base
from [Car_Mart]
group by store_cd
having count(distinct order_no) >=2

select *
from #cycle_base

select *
	,datediff(day, min_order_date, max_order_date) as diff_day
	,DATEDIFF(day, min_order_date, max_order_date)*1.00/tot_tr_1 as cycle
	from #cycle_base
	order by 6 desc

--05 제품 및 성장률 분석
use edu
select brand, model
	, sum(case when year(order_date) = 2020 then sales_amt end) as tot_amt_2020
	, sum(case when year(order_date) = 2021 then sales_amt end) as tot_amt_2021
	into #product_growth_base
	from [Car_Mart]
	group by brand, model
select *
from #product_growth_base

select brand
		, sum(tot_amt_2021)/sum(tot_amt_2020) -1 as growth
		from #product_growth_base
		group by brand
		order by 2 desc

select *
	,ROW_NUMBER() over(partition by brand order by growth desc) as rnk
from (
	select brand, model
		, sum(tot_amt_2021) / sum(tot_amt_2020) -1 as growth
		from #product_growth_base
		group by brand, model
		) A

select *
from (
	select *
		, ROW_NUMBER() over(partition by brand order by growth desc) as rnk
	from (
		select brand, model
			,sum(tot_amt_2021)/sum(tot_amt_2020) -1 as growth
		from #product_growth_base
	group by brand, model
	) A
	) B
where rnk <=2