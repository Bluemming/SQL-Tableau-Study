--01 테이블 생성
use edu --[EDU] 데이터베이스를 사용합니다.

--[회원테이블] 생성
create table [회원테이블](
[회원번호] varchar(20) primary key, --데이터 제약 조건
[이름] varchar(20),
[성별] varchar(2),
[나이] int,
[가입금액] money,
[가입일자] date not null, --데이터 제약 조건
[수신동의] bit
)


--02 테이블 열 추가(Alter)
--[회원테이블]에 [몸무게] 컬럼 추가, 데이터 형식은 REAL
alter table [회원테이블] add [몸무게] real

--03 테이블 열 형식 변경(Alter)
alter table [회원테이블] alter column [몸무게] int

--04 테이블 열 이름 변경(Rename)
--[회원테이블]에 [몸무게] 컬럼 [몸무게(kg)]로 변경
sp_rename '[회원테이블].[몸무게]', '몸무게(kg)'

--05 테이블명 변경(Rename)
--[회원테이블] 테이블명 [member]로 변경
sp_rename '[회원테이블]', 'member'

--06 데이터 삭제(Truncate) 및 테이블 삭제(Drop)
--[member] 테이블 모든 행 데이터 삭제
truncate table [member]

--[member] 테이블 삭제
drop table [member]