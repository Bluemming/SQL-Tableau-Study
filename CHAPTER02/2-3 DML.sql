use edu

create table [회원테이블](
[회원번호] varchar(20) primary key,
[이름] varchar(20),
[성별] varchar(2),
[나이] int,
[가입금액] money,
[가입일자] date not null,
[수신동의] bit
)

--01 데이터 삽입(insert)
--[회원테이블]에 데이터 삽입
insert into [회원테이블] values ('A10001', '모원서', '남', 33, 100000, '2020-01-01', 1);
insert into [회원테이블] values ('A10002', '김영화', '여', 29, 200000, '2020-01-02', 0);
insert into [회원테이블] values ('A10003', '홍길동', '남', 29, 300000, '2020-01-03', NULL);

--primary key 제약 조건 위반
insert into [회원테이블] values ('A10001', '홍길동', '남', 29, 300000, '2020-01-03', NULL);

--not null 제약 조건 위반
insert into [회원테이블] values ('A10005', '홍길동', '남', 29, 300000, NULL, 1);

--02 데이터 조회(select)
--[회원테이블]의 모든 칼럼 조회
select * --모든 칼럼
from [회원테이블]

--[회원테이블]에 특정 칼럼명 조회 및 임시로 칼럼명 변경하기
select [회원번호]
		,[이름] as [성명]
		,[가입일자]
		,[나이]
from [회원테이블]

--03 데이터 수정(Update)
--모든 행을 조건 없이, [나이] 30으로 수정하기
update [회원테이블]
set [나이] = 30

--[회원테이블] 조회 및 수정 확인
select * --모든 칼럼
from [회원테이블]

--[회원번호]가 'A10001'인 [나이] 34로 변경하기
update [회원테이블]
set [나이]=34
where [회원번호] = 'A10001'

--[회원테이블] 조회 및 수정 확인
select * --모든 칼럼
from [회원테이블]

--04 데이터 삭제(Delete)
--[회원테이블] 모든 행 데이터 삭제
delete
from [회원테이블]

--[회원테이블] 특정 조건 데이터 삭제
delete
from [회원테이블]
where [회원번호] = 'A10001'

-- Delete : 데이터만 삭제
-- Truncate : 데이터 + 테이블 공간 삭제
-- Drop : 테이블 전체 삭제
