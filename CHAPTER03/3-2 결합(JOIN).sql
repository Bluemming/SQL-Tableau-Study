--01 Inner Join
use edu
--inner join : 공통된 요소들을 통해 결합하는 조인 방식
--[Member] 및 [Order] 테이블 공통 값(mem_no) 결합
select *
from [Member] as A
inner
join [Order] as B
On A.mem_no = B.mem_no --공통 값(mem_no) 결합

--02 Outer Join
--Left join: 왼쪽 테이블 기준 데이터 조회
--[Member] 및 [Order] 테이블 공통 값(mem_no) 결합 + 매칭 안되는 [Member] 데이터 조회
select *
from [Member] A --왼쪽 테이블
left
join [Order] B --오른쪽 테이블
on A.mem_no = B.mem_no

--Right join: 오른쪽 테이블 기준 데이터 조회
--[Member] 및 [Order] 테이블 공통 값(mem_no) 결합 + 매칭 안되는 [Member] 데이터 조회
select *
from [Member] A --왼쪽 테이블
right
join [Order] B --오른쪽 테이블
on A.mem_no = B.mem_no

--Full join: 양쪽 테이블 기준 데이터 조회
select *
from [Member] A --왼쪽 테이블
full
join [Order] B --오른쪽 테이블
on A.mem_no = B.mem_no

--03 Other(Cross, Self) JOIN
--Cross Join : 두 테이블의 행을 결합한 데이터 조회
-- [Member]행 X [Order]행
select *
from [Member] A
cross
join [Order] B
where A.mem_no = '1000001'
--mem_no가 [Member] [Order]에 모두 있으므로, A.mem_no 또는 B.mem_no로 명시해야함

--Self Join : 두 테이블의 행을 결합한 데이터 조회
-- [Member]행 X [Member]행
select *
from [Member] A, [Member] B
where A.mem_no = '1000001'
--mem_no가 [Member]에 모두 있으므로, A.mem_no 또는 B.mem_no로 명시해야함
