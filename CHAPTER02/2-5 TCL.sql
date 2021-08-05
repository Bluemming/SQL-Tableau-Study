--01 ����(Commit)
--begin tran -> delete -> commit
use edu /* [Edu] �����ͺ��̽��� ��� */
begin tran /* TCL ���� */
delete from [ȸ�����̺�] /* [ȸ�����̺�] ��� �� ������ ���� */
commit /* ��� �� ������ ���� ���� */

--02 ��� (Rollback)
--��ȣ ������� �巡���Ͽ� �����ؾ� �Ѵ�

use edu
begin tran
select * from [ȸ�����̺�]
delete * from [ȸ�����̺�]
select * from [ȸ�����̺�]
rollback
select * from [ȸ�����̺�]

--03 �ӽ� ����(Savepoint)
--savepoint
use edu
begin tran

-- savepoint.1: [ȸ�����̺�]�� 'A10001' ȸ�� ������ ����(insert)
save tran S1;
insert into [ȸ�����̺�] values ('A10001', '�����', '��', 33, 100000, '2020-01-01', 1);
--savepoint.2: 'A10001'�� ���� 34�� ����(update)
save tran S2;
update [ȸ�����̺�] set [����] = 34 where [ȸ����ȣ] = 'A10001'
--savepoint.3: [ȸ�����̺�]�� 'A10003' ȸ�� ������ ���� (delete)
save tran S3;
delete from [ȸ�����̺�] where [ȸ����ȣ] = 'A10003'

select * from [ȸ�����̺�] --3~5�� ���� Ȯ��

--S3 ���� ���
rollback tran S3;
select * from [ȸ�����̺�]
--S2 ���� ���
rollback tran S2;
select * from [ȸ�����̺�]
--S1 ���� ���
rollback tran S1;
select * from [ȸ�����̺�]