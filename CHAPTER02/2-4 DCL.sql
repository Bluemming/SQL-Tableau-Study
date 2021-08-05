--01 권한 부여 (Grant)
--MMS라는 유저에게 [회원테이블] 권한 부여
grant select, insert, update, delete on [회원테이블] to MWS with grant option

--02 권한 제거(Revoke)
--MMS라는 유저에게 [회원테이블] 권한 제거
revoke select, insert, update, delete on [회원테이블] to MWS cascade
-- cascade : 특정 사용자가 다른 사용자에게 부여한 권한도 연쇄적으로 취소
