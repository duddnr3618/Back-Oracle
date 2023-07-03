/*
DDL - Alter Table 
- ������ ������ ���̺��� ����
- �������̺��� �÷��� �߰�/���� �� �̸� ����
- �÷��� �ο��� ���������� ���� , ���� , ����
*/

-- �÷��� �ڷ����� ���� 
alter table dept01
modify email varchar2(100);
desc dept01;

-- Ư�� �÷��� ����
alter table dept01
drop column addr;

desc dept01;
select * from dept01;

-- �÷��� ���� 
alter table dept01
rename column d_dno to dno;

desc dept01;
select * from dept01;

-- ���̺� �̸� ����
rename dept01 to dept001;
rename dept001 to dept01;

-- ���� �α׿��� ������� ��� ���̺� ���
select * from user_tables;

-- alter ���̺��� ����ؼ� �������� ����, ����, ����

-- ������ ������ ���ؼ� ���� ���̺��� ���������� �ѹ��� Ȯ��
select * from user_constraints
where table_name in ('DEPT01' , 'DEPARTMENT' , 'EMP01' , 'EMPLOYEE');

/*
���� ���̺��� primary key �Ҵ� : add 
- �÷��� �ߺ����� ����� �Ѵ�.
- �÷��� null�� �� ������ �ȵȴ�.
- ���̺� primary key �÷��� �����ϸ� �ȵȴ� -> ���̺� 1���� ������ �ִ�.
*/
select * from dept01;
-- dept01 ���̺� d_dno �÷��� Primary key �Ҵ�
alter table dept01
add constraints PK_DEPT01_D_DNO primary key (dno);
desc dept01;

/*
Foreign Key �Ҵ�
-�θ� ���̺��� primary key , unique �÷��� ������
-FK�� ����� �÷��� , �θ� ���̺��� ���� �÷��� �ڷ����� ����ϰų� ���ƾ��Ѵ�.
-FK�� ����� �÷��� ���� �θ����̺��� ���� ���� �� �־���Ѵ�.
*/
-- emp01 ���̺� dno �÷��� FK �Ҵ�
alter table emp01
add constraints FK_EMP01_DNO foreign key (dno) references DEPT01(dno);

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

Not null ��������
-�÷��� null ���� �������� �ʾƾ� �Ѵ�.
*/

-- job �÷��� not null �������� �߰�
desc emp01;

alter table emp01
modify job constraint NN_EMP01_JOB not null;