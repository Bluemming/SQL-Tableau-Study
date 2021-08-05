--01

use edu

--1. �� ������
--(1-1) [addr]�� 'seoul'�� �ƴ� ���� ��ȸ
select *
from [Member]
where addr <> 'seoul'

--2. �� ������
--(2-1) [gender]�� 'man' �� [ageband]�� 20�� ���� ��ȸ
select *
from [Member]
where gender='man' and ageband = 20

--(2-2) [gender]�� 'man' �� [ageband]�� 20�� ���� �Ǵ� [addr]�� 'seoul'�� �� ��ȸ
select *
from [Member]
where (gender='man' and ageband = 20) or addr='seoul'

--3. Ư�� ������
--(3-1)[ageband]�� 20~40 ������ �� ��ȸ
select *
from [Member]
where ageband between 20 and 40

--(3-2) [addr]�� ae�� �����ϴ� �� ��ȸ
select *
from [Member]
where addr like '%ae%'

--4. ��� ������
--[Order] ���̺� ���
--(4-1) [sales_amt]�� 0.1�� ���Ͽ���. (�÷��� fees)
select *
	, sales_amt * 0.1 as fees
from [Order]

--(4-2) [sales_amt]�� [sales_amt]�� 0.1 ���� ���� �����Ͽ���. (�÷��� excluding_fees)
select *
	, sales_amt * 0.1 as fees
	, sales_amt - (sales_amt*0.1) as excluding_fees
from [Order]

--02
use edu
--case when : ���� ���Ǻ��� ���� �� ��ȯ
--���� �� ���� NULL ��ȯ
select *
	,case when ageband between 20 and 30 then '2030����'
		  when ageband between 40 and 50 then '4050����'
		  end  as ageband_seg
	from [Member]

--case when(+else): ���� ���Ǻ��� ���� �� ��ȯ(+else)
select *
	,case when ageband between 20 and 30 then '2030����'
		  when ageband between 40 and 50 then '4050����'
		  else 'OTHER����'
		  end  as ageband_seg
	from [Member]

--03
use edu
--1. ���� �Լ�
select count(order_no) as �ֹ���
		,sum(sales_amt) as �ֹ��ݾ�
		, avg(sales_amt) as ����ֹ��ݾ�
		, max(order_date) as �ֱٱ�������
		, min(order_date) as ���ʱ�������
		,stdev(sales_amt) as �ֹ��ݾ�_ǥ������
		, var(sales_amt) as �ֹ��ݾ�_�л�
	from [Order]

--2. �׷� �Լ�
use edu
--with rollup
--group by �׸���� �����ʿ��� ���� ������ �׷����� ����
select year(order_date) as ����
	, channel_code as ä���ڵ�
	, sum(sales_amt) as �ֹ��ݾ�
	from [Order]
	group by year(order_date)
			, channel_code
	with rollup --groupby �׸���� �����ʿ��� ���� ������ �׷����� ���´�. groupby ������ �ۼ��ؾ� ��
	order by 1 desc, 2 asc

use edu
--with rollup �� / ��� ���� ���
select year(order_date) as ����
		, channel_code as ä���ڵ�
	, sum(sales_amt) as �ֹ��ݾ�
	from [Order]
	group by year(order_date)
			, channel_code
	order by 1 desc, 2 asc

-- with cube
--groupby �׸���� ��� ����� ���� �׷����� ����
select year(order_date) as ����
	, channel_code as ä���ڵ�
	, sum(sales_amt) as �ֹ��ݾ�
	from [Order]
	group by year(order_date)
			, channel_code
	with cube
	order by 1 desc, 2 asc

--grouping sets
--groupby �׸���� ���� �׷����� ����
select year(order_date) as ����
	, channel_code as ä���ڵ�
	, sum(sales_amt) as �ֹ��ݾ�
	from [Order]
	group by grouping sets(year(order_date), channel_code)

--grouping
--with rollup �� cube�� ���� �׷�ȭ �Ǿ��ٸ�0, �׷��� ������ 1 ��ȯ
--with rollup �Լ��� �ַ� ���
select year(order_date) as ����
	, grouping(year(order_date)) as ����_grouping

	,channel_code as ä���ڵ�
	, grouping(channel_code) as ä���ڵ�_grouping

	, sum(sales_amt) as �ֹ��ݾ�
from [Order]
group by year(order_date)
	, channel_code
with rollup
order by 1 desc, 2 asc

--grouping �� case when�� Ȱ���� �Ѱ� �� �Ұ� ��ȯ
--(1) year(order_date) �� channel_code ���� -> ������ ��ȯ
select cast(year(order_date) as varchar) as ����
		, cast(channel_code as varchar) as ä���ڵ�
		, sales_amt
	from [Order]
--(2) (1)�� ���� ������ �Ͽ�, case when���� �Ѱ� �� �Ұ� ��ȯ
select case when grouping(����)=1 then '�Ѱ�'
		else ���� end as ����_�Ѱ�
	, case when grouping(����)=1 then '�Ѱ�'
			when grouping(ä���ڵ�)=1 then '�Ұ�'
			else ä���ڵ� end as ä���ڵ�_�ѼҰ�
	, sum(sales_amt) as �ֹ��ݾ�
	from (
			select cast(year(order_date) as varchar) as ����
					, cast(channel_code as varchar) as ä���ڵ�
					, sales_amt
				from [Order]
			) A
	group by ����, ä���ڵ�
	with rollup
	order by 1 desc, 2 asc

--4. ������ �Լ�
use edu
--���� �Լ�
--order by
select order_date
	, row_number() over (order by order_date asc) as row_number --���� ���� ��ȯ
	, rank()	   over (order by order_date asc) as rank -- ���� ���� ��ȯ
	, dense_rank() over (order by order_date asc) as dense_rank --���� ���� ��ȯ (�ϳ��� ����� ����)
from [Order]

--order by+patition by
select mem_no
	,order_date
	, row_number() over (partition by mem_no order by order_date asc) as row_number
	, rank()	   over (partition by mem_no order by order_date asc) as rank
	, dense_rank() over (partition by mem_no order by order_date asc) as dense_rank
from [Order]

--���� �Լ�
use edu
select order_date
	,sales_amt
	,count(sales_amt) over (order by order_date asc) as ����Ƚ��
	, sum(sales_amt) over (order by order_date asc) as ���űݾ�
	, avg(sales_amt) over (order by order_date asc) as ��ձ��űݾ�
	, max(sales_amt) over (order by order_date asc) as ����������űݾ�
	, min(sales_amt) over (order by order_date asc) as ���峷�����űݾ�
from [Order]

select mem_no
	, order_date
	, sales_amt
	, count(sales_amt) over (partition by mem_no order by order_date asc) as ����_����Ƚ��
	, sum(sales_amt) over (partition by mem_no order by order_date asc) as ����_���űݾ�
	, avg(sales_amt) over (partition by mem_no order by order_date asc) as ����_��ձ��űݾ�
	, max(sales_amt) over (partition by mem_no order by order_date asc) as ����_����������űݾ�
	, min(sales_amt) over (partition by mem_no order by order_date asc) as ����_���峷�����űݾ�
from [Order]

--05 ���� ������
use edu
--union : �� ���̺��� ������ ���·� ��� ��ȯ
select *
from [Member_1]
union
select *
from [Member_2]

use edu
-- union all : �� ���̺��� ������ ���·� ��� ��ȯ
select *
from [Member_1]
union all
select *
from [Member_2]

use edu
--intersect : �� ���̺��� ������ ���·� ��� ��ȯ
select *
from [Member_1]
intersect
select *
from [Member_2]

use edu
--except : �� ���̺��� ������ ���·� �ܷΰ� ��ȯ
select *
from [Member_1]
except
select *
from [Member_2]