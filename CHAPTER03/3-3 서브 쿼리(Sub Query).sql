--02 ��ġ�� ���� ���� ����

--01 select��
select *
	, (select gender
	from [Member] B
	where A.mem_no = B.mem_no) as gender
	from [Order] A
--02 from��
select *
from(
	select mem_no
	,SUM(sales_amt) as tot_amt --�����Լ��� ���� �� �̸�
	from [Order]
	group
	by mem_no
	)A --���� ������ ���� ���̺��
--from ���� ���Ǵ� ���� ����
--[Member] �� [Order] ���̺� ���� ��(mem_no) ����
--1:1 ����
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
--03 where��
--where���� ���Ǵ� ���� ���� (���� �� ���� ����)
--���� �� : ���� ���� ����� ���� ��
select *
from [Order]
where mem_no = (select mem_no from [Member] where mem_no = '1000005')

--���� �� Ȯ��
select mem_no from [Member] where mem_no = '1000005'
--���� ��:���� ���� ����� ���� ��
select *
from [Order]
where mem_no in (select mem_no from [Member] where gender = 'man')

--���� �� Ȯ��
select mem_no from [Member] where gender = 'man'
