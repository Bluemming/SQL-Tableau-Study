--01 ���̺� ����
use edu --[EDU] �����ͺ��̽��� ����մϴ�.

--[ȸ�����̺�] ����
create table [ȸ�����̺�](
[ȸ����ȣ] varchar(20) primary key, --������ ���� ����
[�̸�] varchar(20),
[����] varchar(2),
[����] int,
[���Աݾ�] money,
[��������] date not null, --������ ���� ����
[���ŵ���] bit
)


--02 ���̺� �� �߰�(Alter)
--[ȸ�����̺�]�� [������] �÷� �߰�, ������ ������ REAL
alter table [ȸ�����̺�] add [������] real

--03 ���̺� �� ���� ����(Alter)
alter table [ȸ�����̺�] alter column [������] int

--04 ���̺� �� �̸� ����(Rename)
--[ȸ�����̺�]�� [������] �÷� [������(kg)]�� ����
sp_rename '[ȸ�����̺�].[������]', '������(kg)'

--05 ���̺�� ����(Rename)
--[ȸ�����̺�] ���̺�� [member]�� ����
sp_rename '[ȸ�����̺�]', 'member'

--06 ������ ����(Truncate) �� ���̺� ����(Drop)
--[member] ���̺� ��� �� ������ ����
truncate table [member]

--[member] ���̺� ����
drop table [member]