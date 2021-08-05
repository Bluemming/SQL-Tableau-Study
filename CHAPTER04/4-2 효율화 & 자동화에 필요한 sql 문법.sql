--2 효율화 & 자동화에 필요한 sql 문법

--01 view
use edu
--view 생성
create view [Order_Member]
as
select A.*
	, B.gender
	, B.ageband
	, B.join_date
from [Order] A
left join [Member] B
on A.mem_no = B.mem_no

--view 조회
use edu
select *
from [Order_Member]

--view 수정
alter view [Order_Member]
as
select A.*
	,B.gender
	,B.ageband
	,B.join_date
from [Order] A
left join [Member] B
on A.mem_no = B.mem_no
where A.channel_code = 1

--view 삭제
drop view [Order_Member]

--02 procedure 생성
create procedure [Order_Member]
(
@channel_code as int
)
as
select *
from [Order] A
left join [Member] B
on A.mem_no = B.mem_no
where A.channel_code = @channel_code

--procedure 실행
use edu
exec [Order_Member] 3 --변수 3으로 입력, channel_code =3으로 필터되어 조회

--procedure 수정
alter procedure [Order_Member]
(
@channel_code as int
,@year_order_date as int
)
as
select *
from [Order] A
left join [Member] B
on A.mem_no = B.mem_no
where A.channel_code = @channel_code
and year(order_date) = @year_order_date

-- procedure 삭제
use edu
drop procedure [Order_Member]
