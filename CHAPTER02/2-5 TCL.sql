--01 실행(Commit)
--begin tran -> delete -> commit
use edu /* [Edu] 데이터베이스를 사용 */
begin tran /* TCL 시작 */
delete from [회원테이블] /* [회원테이블] 모든 행 데이터 삭제 */
commit /* 모든 행 데이터 삭제 실행 */

--02 취소 (Rollback)
--번호 순서대로 드래그하여 실행해야 한다

use edu
begin tran
select * from [회원테이블]
delete * from [회원테이블]
select * from [회원테이블]
rollback
select * from [회원테이블]

--03 임시 저장(Savepoint)
--savepoint
use edu
begin tran

-- savepoint.1: [회원테이블]에 'A10001' 회원 데이터 삽입(insert)
save tran S1;
insert into [회원테이블] values ('A10001', '모원서', '남', 33, 100000, '2020-01-01', 1);
--savepoint.2: 'A10001'의 나이 34로 수정(update)
save tran S2;
update [회원테이블] set [나이] = 34 where [회원번호] = 'A10001'
--savepoint.3: [회원테이블]에 'A10003' 회원 데이터 삭제 (delete)
save tran S3;
delete from [회원테이블] where [회원번호] = 'A10003'

select * from [회원테이블] --3~5번 실행 확인

--S3 지정 취소
rollback tran S3;
select * from [회원테이블]
--S2 지정 취소
rollback tran S2;
select * from [회원테이블]
--S1 지정 취소
rollback tran S1;
select * from [회원테이블]