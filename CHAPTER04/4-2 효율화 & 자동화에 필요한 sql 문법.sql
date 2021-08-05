--2 ȿ��ȭ & �ڵ�ȭ�� �ʿ��� sql ����

--01 view
use edu
--view ����
create view [Order_Member]
as
select A.*
	, B.gender
	, B.ageband
	, B.join_date
from [Order] A
left join [Member] B
on A.mem_no = B.mem_no

--view ��ȸ
use edu
select *
from [Order_Member]

--view ����
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

--view ����
drop view [Order_Member]

--02 procedure ����
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

--procedure ����
use edu
exec [Order_Member] 3 --���� 3���� �Է�, channel_code =3���� ���͵Ǿ� ��ȸ

--procedure ����
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

-- procedure ����
use edu
drop procedure [Order_Member]
