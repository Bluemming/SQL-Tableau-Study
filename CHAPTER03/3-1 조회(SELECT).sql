use edu --[edu] �����ͺ��̽� ���

--01 select + from
select * --��� Į��
from [Member]

--02 select+from+where
--where : gender �÷����� 'man'���θ� ���͸�
select *
from [Member]
where gender = 'man'

--03 select+from+where+group by
--group by : addr �÷����� ȸ��(mem_no) ����
select addr,
		count(mem_no) as [ȸ��������]
from [Member]
where gender = 'man'
group
by addr

--group by : addr, gender �÷����� ȸ��(mem_no) ����
select addr,
		gender,
		count(mem_no) as [ȸ��������]
from [Member]
where gender = 'man'
group
by addr,
	gender


--04 select+from+where+group by+having
--having: addr �÷����� (mem_no) ���� 50 �̻� ���͸�
select addr,
		count(mem_no) as [ȸ��������]
from [Member]
where gender = 'man'
group
by addr
having count(mem_no) >=50

--05 select+from+where+group by+having+order by
--order by : addr �÷����� ȸ��(mem_no) ���� ���� ������ ����
select addr,
		count(mem_no) as [ȸ��������]
from [Member]
where gender = 'man'
group
by addr
having count(mem_no) >=50
order
by count(mem_no) desc