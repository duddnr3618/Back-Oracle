/*
DDL - Alter Table : ������ ������ ���̺��� ����
    - �������̺��� �÷��� �߰�/���� �� �̸� ����
    - �÷��� �ο��� ���������� ���� , ���� , ����
*/

-- ���̺� ����
create table dept01     -- department�� ������ ���̺� -> �������̺��� ���������� ����Ǿ� �����ʴ´�.
as select * from department;

create table emp01
as select * from employee;

select * from dept01;
desc dept01;
desc department;

-- ���������� Ȯ���ϴ� ������ ����
show user;
select * from user_constraints -- ���� ������ ������ ��� ���̺��� ���������� Ȯ��
--where table_name = 'DEPARTMENT';
where table_name = 'DEPT01';

-- FP�� �����ϴ� �θ����̺��� drop�� ���� �ʴ´�.
-- 1. �ڽ����̺� ������ �θ����̺� ����
-- 2. �θ����̺��� �����ϸ鼭 cascade �ɼ��� ���� ������ �����ȴ�.

-- �θ����̺� ����
drop table ParentTb1;
-- 1.�ڽ����̺� ���� ���� �� �θ����̺� ����
drop table ChildTb1;
drop table ParentTb1;

-- 2.�θ����̺� �����ϸ鼭 cascde�ɼ��� ���
drop table ParentTb1 cascade constraints;

select * from dept01;

alter table dept01
add (birth date);

alter table dept01
add (email varchar2(100) , addr varchar2(200) , jumin char(14) );

-- ���̺� �÷��� �߰��ϰ� �Ǹ� �⺻������ null�� �Ҵ�ȴ�. -> update�� �� �Ҵ�(�߰�)
update dept01
set birth = sysdate , email = 'aaa@aaa.com' , addr = '����' , jumin = '123456-1234567'
where dno = 10;

-- �÷��� �ڷ����� ���� : char , varchar ���ڼ��� �ø�
alter table dept01
modify email varchar2(200);
desc dept01;

-- Ư�� �÷� ����
alter table dept01
drop column JUMIN;
select * from dept01;

-- �÷��� ���� : rename
alter table dept01
rename column dno to d_dno;

-- ���̺� �̸� ���� 
rename dept01 to dept001;
rename dept001 to dept01;

-- ������ �������� ���� �α׿��� ������� ��� ���̺� ���
select * from user_tables;

/*
alter table �� ��� �ؼ� �������� ����,����,����
-Primary key
-Unique 
-Foreign key
-Check
-Not null

-default
*/

-- ������ ������ ���ؼ� ���� ���̺��� ���������� �ѹ��� Ȯ��
select * from user_constraints
where table_name in ('DEPT01' , 'DEPARTMENT' , 'EMP01' , 'EMPLOYEE');

-- �������̺��� Primary key �������� �ֱ�
-- �÷��� �ߺ��� ���� ����� �Ѵ�.
-- �÷��� null �� �� ������ �ȵȴ�.
-- ���̺� primary key�÷��� �����ϸ� �ȵȴ�.  ���̺� 1���� ������ �ִ�
select * from dept01;
-- dept01 ���̺� d_dno �÷��� Primary key �Ҵ�
alter table dept01
add constraints PK_DEPT01_D_DNO primary key (d_dno);
desc dept01;

/*
Foreign Key �Ҵ�
-�θ� ���̺��� primary key , unique �÷��� ������
-FK�� ����� �÷��� , �θ� ���̺��� ���� �÷��� �ڷ����� ����ϰų� ���ƾ��Ѵ�.
-FK�� ����� �÷��� ���� �θ����̺��� ���� ���� �� �־���Ѵ�.
*/

--EMP01 ���̺�
select * from dept01;   -- �θ����̺�(dept01) : d_dno
select * from emp01;    -- �ڽ����̺� : dno 

-- emp01 ���̺� dno �÷��� FK �Ҵ�
alter table emp01
add constraints FK_EMP01_DNO foreign key (dno) references DEPT01(d_dno);

/*
Unique �������� 
- �÷��� �ߺ��� ���� ������Ѵ�.
- null �� 1���� �� �־�� �Ѵ�.
- not null ,null �� ����� ���� �ο��Ҽ� �ִ�
*/

-- emp01���̺� ename �÷��� unique ���� �Ҵ�
select * from emp01;

alter table emp01
add constraint U_EMP01_ENAME unique(ename);

--emp01 ���̺� eno �÷��� primary key�������� �߰�
alter table emp01
add constraints FK_EMP01_ENO primary key (eno);

/*
Check ��������
- Ư���÷��� ���ǿ� �´� ���� ����ǵ��� ����
- salary �÷��� ���� : salary > 0
*/

alter table emp01
add constraint CK_EMP01_SALARY check(salary> 0);

/*
Not null ��������
-�÷��� null ���� �������� �ʾƾ� �Ѵ�.
*/

-- job �÷��� not null �������� �߰�
desc emp01;

alter table emp01
modify job constraint NN_EMP01_JOB not null;