--01

use edu

--1. 비교 연산자
--(1-1) [addr]이 'seoul'이 아닌 값만 조회
select *
from [Member]
where addr <> 'seoul'

--2. 논리 연산자
--(2-1) [gender]가 'man' 및 [ageband]가 20인 값만 조회
select *
from [Member]
where gender='man' and ageband = 20

--(2-2) [gender]가 'man' 및 [ageband]가 20인 값과 또는 [addr]이 'seoul'인 값 조회
select *
from [Member]
where (gender='man' and ageband = 20) or addr='seoul'

--3. 특수 연산자
--(3-1)[ageband]가 20~40 사이인 값 조회
select *
from [Member]
where ageband between 20 and 40

--(3-2) [addr]이 ae를 포함하는 값 조회
select *
from [Member]
where addr like '%ae%'

--4. 산술 연산자
--[Order] 테이블 사용
--(4-1) [sales_amt]을 0.1을 곱하여라. (컬럼명 fees)
select *
	, sales_amt * 0.1 as fees
from [Order]

--(4-2) [sales_amt]에 [sales_amt]을 0.1 곱한 값을 뺄셈하여라. (컬럼명 excluding_fees)
select *
	, sales_amt * 0.1 as fees
	, sales_amt - (sales_amt*0.1) as excluding_fees
from [Order]

--02
use edu
--case when : 여러 조건별로 지정 값 변환
--조건 외 값은 NULL 반환
select *
	,case when ageband between 20 and 30 then '2030세대'
		  when ageband between 40 and 50 then '4050세대'
		  end  as ageband_seg
	from [Member]

--case when(+else): 여러 조건별로 지정 값 변환(+else)
select *
	,case when ageband between 20 and 30 then '2030세대'
		  when ageband between 40 and 50 then '4050세대'
		  else 'OTHER세대'
		  end  as ageband_seg
	from [Member]

--03
use edu
--1. 집계 함수
select count(order_no) as 주문수
		,sum(sales_amt) as 주문금액
		, avg(sales_amt) as 평균주문금액
		, max(order_date) as 최근구매일자
		, min(order_date) as 최초구매일자
		,stdev(sales_amt) as 주문금액_표준편차
		, var(sales_amt) as 주문금액_분산
	from [Order]

--2. 그룹 함수
use edu
--with rollup
--group by 항목들을 오른쪽에서 왼쪽 순으로 그룹으로 묶음
select year(order_date) as 연도
	, channel_code as 채널코드
	, sum(sales_amt) as 주문금액
	from [Order]
	group by year(order_date)
			, channel_code
	with rollup --groupby 항목들의 오른쪽에서 왼쪽 순으로 그룹으로 묶는다. groupby 다음에 작성해야 함
	order by 1 desc, 2 asc

use edu
--with rollup 비교 / 사용 안할 경우
select year(order_date) as 연도
		, channel_code as 채널코드
	, sum(sales_amt) as 주문금액
	from [Order]
	group by year(order_date)
			, channel_code
	order by 1 desc, 2 asc

-- with cube
--groupby 항목들의 모든 경우의 수를 그룹으로 묶음
select year(order_date) as 연도
	, channel_code as 채널코드
	, sum(sales_amt) as 주문금액
	from [Order]
	group by year(order_date)
			, channel_code
	with cube
	order by 1 desc, 2 asc

--grouping sets
--groupby 항목들을 개별 그룹으로 묶음
select year(order_date) as 연도
	, channel_code as 채널코드
	, sum(sales_amt) as 주문금액
	from [Order]
	group by grouping sets(year(order_date), channel_code)

--grouping
--with rollup 및 cube에 의해 그룹화 되었다면0, 그렇지 않으면 1 반환
--with rollup 함수에 주로 사용
select year(order_date) as 연도
	, grouping(year(order_date)) as 연도_grouping

	,channel_code as 채널코드
	, grouping(channel_code) as 채널코드_grouping

	, sum(sales_amt) as 주문금액
from [Order]
group by year(order_date)
	, channel_code
with rollup
order by 1 desc, 2 asc

--grouping 및 case when을 활용한 총계 및 소계 변환
--(1) year(order_date) 및 channel_code 숫자 -> 문자형 변환
select cast(year(order_date) as varchar) as 연도
		, cast(channel_code as varchar) as 채널코드
		, sales_amt
	from [Order]
--(2) (1)을 서브 쿼리로 하여, case when으로 총계 및 소계 변환
select case when grouping(연도)=1 then '총계'
		else 연도 end as 연도_총계
	, case when grouping(연도)=1 then '총계'
			when grouping(채널코드)=1 then '소계'
			else 채널코드 end as 채널코드_총소계
	, sum(sales_amt) as 주문금액
	from (
			select cast(year(order_date) as varchar) as 연도
					, cast(channel_code as varchar) as 채널코드
					, sales_amt
				from [Order]
			) A
	group by 연도, 채널코드
	with rollup
	order by 1 desc, 2 asc

--4. 윈도우 함수
use edu
--순위 함수
--order by
select order_date
	, row_number() over (order by order_date asc) as row_number --고유 순위 반환
	, rank()	   over (order by order_date asc) as rank -- 동일 순위 반환
	, dense_rank() over (order by order_date asc) as dense_rank --동일 순위 반환 (하나의 등수로 간주)
from [Order]

--order by+patition by
select mem_no
	,order_date
	, row_number() over (partition by mem_no order by order_date asc) as row_number
	, rank()	   over (partition by mem_no order by order_date asc) as rank
	, dense_rank() over (partition by mem_no order by order_date asc) as dense_rank
from [Order]

--집계 함수
use edu
select order_date
	,sales_amt
	,count(sales_amt) over (order by order_date asc) as 구매횟수
	, sum(sales_amt) over (order by order_date asc) as 구매금액
	, avg(sales_amt) over (order by order_date asc) as 평균구매금액
	, max(sales_amt) over (order by order_date asc) as 가장높은구매금액
	, min(sales_amt) over (order by order_date asc) as 가장낮은구매금액
from [Order]

select mem_no
	, order_date
	, sales_amt
	, count(sales_amt) over (partition by mem_no order by order_date asc) as 누적_구매횟수
	, sum(sales_amt) over (partition by mem_no order by order_date asc) as 누적_구매금액
	, avg(sales_amt) over (partition by mem_no order by order_date asc) as 누적_평균구매금액
	, max(sales_amt) over (partition by mem_no order by order_date asc) as 누적_가장높은구매금액
	, min(sales_amt) over (partition by mem_no order by order_date asc) as 누적_가장낮은구매금액
from [Order]

--05 집합 연산자
use edu
--union : 두 테이블을 합집합 형태로 결과 반환
select *
from [Member_1]
union
select *
from [Member_2]

use edu
-- union all : 두 테이블을 합집합 형태로 결과 반환
select *
from [Member_1]
union all
select *
from [Member_2]

use edu
--intersect : 두 테이블을 교집합 형태로 결과 반환
select *
from [Member_1]
intersect
select *
from [Member_2]

use edu
--except : 두 테이블을 차집합 형태로 겨로가 반환
select *
from [Member_1]
except
select *
from [Member_2]