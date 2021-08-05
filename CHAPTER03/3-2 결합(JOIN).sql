--01 Inner Join
use edu
--inner join : ����� ��ҵ��� ���� �����ϴ� ���� ���
--[Member] �� [Order] ���̺� ���� ��(mem_no) ����
select *
from [Member] as A
inner
join [Order] as B
On A.mem_no = B.mem_no --���� ��(mem_no) ����

--02 Outer Join
--Left join: ���� ���̺� ���� ������ ��ȸ
--[Member] �� [Order] ���̺� ���� ��(mem_no) ���� + ��Ī �ȵǴ� [Member] ������ ��ȸ
select *
from [Member] A --���� ���̺�
left
join [Order] B --������ ���̺�
on A.mem_no = B.mem_no

--Right join: ������ ���̺� ���� ������ ��ȸ
--[Member] �� [Order] ���̺� ���� ��(mem_no) ���� + ��Ī �ȵǴ� [Member] ������ ��ȸ
select *
from [Member] A --���� ���̺�
right
join [Order] B --������ ���̺�
on A.mem_no = B.mem_no

--Full join: ���� ���̺� ���� ������ ��ȸ
select *
from [Member] A --���� ���̺�
full
join [Order] B --������ ���̺�
on A.mem_no = B.mem_no

--03 Other(Cross, Self) JOIN
--Cross Join : �� ���̺��� ���� ������ ������ ��ȸ
-- [Member]�� X [Order]��
select *
from [Member] A
cross
join [Order] B
where A.mem_no = '1000001'
--mem_no�� [Member] [Order]�� ��� �����Ƿ�, A.mem_no �Ǵ� B.mem_no�� ����ؾ���

--Self Join : �� ���̺��� ���� ������ ������ ��ȸ
-- [Member]�� X [Member]��
select *
from [Member] A, [Member] B
where A.mem_no = '1000001'
--mem_no�� [Member]�� ��� �����Ƿ�, A.mem_no �Ǵ� B.mem_no�� ����ؾ���
