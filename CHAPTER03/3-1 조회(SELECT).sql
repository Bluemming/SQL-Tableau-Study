use edu --[edu] 데이터베이스 사용

--01 select + from
select * --모든 칼럼
from [Member]

--02 select+from+where
--where : gender 컬럼값이 'man'으로만 필터링
select *
from [Member]
where gender = 'man'

--03 select+from+where+group by
--group by : addr 컬럼별로 회원(mem_no) 집계
select addr,
		count(mem_no) as [회원수집계]
from [Member]
where gender = 'man'
group
by addr

--group by : addr, gender 컬럼별로 회원(mem_no) 집계
select addr,
		gender,
		count(mem_no) as [회원수집계]
from [Member]
where gender = 'man'
group
by addr,
	gender


--04 select+from+where+group by+having
--having: addr 컬럼별로 (mem_no) 수가 50 이상만 필터링
select addr,
		count(mem_no) as [회원수집계]
from [Member]
where gender = 'man'
group
by addr
having count(mem_no) >=50

--05 select+from+where+group by+having+order by
--order by : addr 컬럼별로 회원(mem_no) 수가 높은 순으로 정렬
select addr,
		count(mem_no) as [회원수집계]
from [Member]
where gender = 'man'
group
by addr
having count(mem_no) >=50
order
by count(mem_no) desc