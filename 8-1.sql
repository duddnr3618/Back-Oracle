/*
index (�ε���) : ���̺��� Ư�� �÷��� �˻��� ������ �ϱ� ���ؼ� �ο��Ǵ� ��ü
    - index�� �ο��Ǿ� ���� �ʴ� �÷��� �˻��� ���̺� ��ĵ�� �Ѵ�.
    - �÷��� index�� �����ϸ� index[����] �������� �����Ѵ� - DB�� 10% ������ ����Ѵ�.
    
    - Ŭ������ index    : ����ó�� A~Z���� ���������� ������ index������
    - non Ŭ������ index : å�� ù ������ , ���뺰�� ��ġ ������ ������ index ������
    - where , join on ������ ���� �˻��ϴ� �÷��� index�� �ο��Ѵ�.
    - index�� �˻��� ������ �ϱ� ���ؼ� ���Ǵµ� �߸� �ο��ϰų� �ֱ����� ���� ���� ������ 
        ������ �˻��� ���������� �ִ�.
    - insert , update , delete �� ����ϰ� �Ͼ�� �÷����� index�� �ֱ����� ������ �ʿ��ϴ�.
    - index �������� ��������
    - �ֱ������� index ��������rebuild �ؾ��Ѵ�.
    - index�� �߸��ϸ� ��������.
    - PK , Unique �÷��� �ڵ����� index�� �����ȴ�.
    - index ������ ����� ������ ���� : ueser_indexes
*/

select * from employee;

-- ������ ������ ���ؼ� index������ Ȯ��
select * from user_indexes
where table_name in ('DEPARTMENT' , 'EMPLOYEE');

-- ���̺� ������ PK,Unique �÷��� �ڵ����� index ������
create table emp07
as 
select eno , ename , job , salary from employee;

select * from emp07;

-- ������ ������ ���ؼ� �������� Ȯ��
select * from user_constraints
where table_name in ('EMP07');

select * from user_indexes
where table_name in ('EMP07');

select * from user_ind_columns
where table_name in ('EMP07');

--EMP07���̺� PK �ο�
alter table EMP07
add constraint PK_EMP07_ENO primary key (eno);

-- Ư�� �÷��� index�� ������  -> where, join on, ���ְ˻��ϴ� �÷�
create index idx_EMP07_ENAME  
on EMP07(ENAME);

---------------------------------
create table emp08
as 
select * from employee ;

select * from emp08;

create index idx_EMP08_JOB
on EMP08 (JOB);

-- ������ index�� ���Ӱ� rebuild �� -> index�� ������ �÷��� ���� update�� �Ǵ� ��� index�� ���Ӱ� ����
-- index������ �� ���� (������ ���ϰ� �� ���)
drop index idx_EMP08_JOB
create index idx_EMP08_JOB
on EMP08(Job) ; 

-- index rebuild : ������ ���ϰ� ���� �ʴ� ���
alter index EMP08 idx_EMP08_JOB rebuild;


--------------------------

/*
������ (SEQUENCE) : �ڵ� ��ȣ �߻��� 
-Ư�� �÷��� ��ȣ�� �ڵ����� �ѹ�����
-MS-SQL : Identifty (1,1) 
-MY-SQL : Auto-increment(1,1) : ���̺� ������ Ư�� �÷��� indentity , auto_increment�� ������ �ȴ�.
-����Ÿ������ �����Ǿ�� �Ѵ�.
-�������� ������ ���� ���� 
*/

-- ������ ���� -> ó���� 10 , ������ 10
create sequence seq1
start with 10
increment by 10;

select * from user_sequences;

-- ��� ���̺��� ����ؼ� sequence ���� ��� : seq1:nextval (�������� ���)/ seq1.currval (���� ���� Ȯ��)
select seq1.nextval from dual;
select seq1.currval from dual;

-- ���̺� Ư�� �÷��� ���� ������ , ���������� �߻��� ���� ����
-- ���̺��� ���� �ҋ� where�� false�� ó���ϸ鼭 ���̺� ���� , ���ڵ� ���� �������� ����
create table dept08
as 
select * from department
where 0 = 1;

-- dept08 ���̺��� dno �÷��� sequence�Ҵ� : seq1.nextval
select seq1.currval from dual;

insert into dept08 (dno , dname , loc)
values (seq1.nextval, 'HR' , 'Seoul');

select * from dept08;

-- ������ ����
create sequence seq2 
start with 1
increment by 1
nocache;

select * from user_sequences;

-- insert �� ���̺��� �÷��� ����
create table dept09
as
select * from department
where 0 = 1;

select * from dept09;

insert into dept09 (dno , dname , loc)
values (seq2.nextval , 'HR' , '����' );

-- ������ ���� Ȯ��
select seq2.currval from dual;

commit;

-- view ���� ���̺� : select ������ �� �ִ� 
-- 1. ���� ���̺�
-- 2. ������ ������ ������ ��� , join����
-- �並 ����� insert , update , delete �� �Ҽ��� �ְ� �׷��� ������ �ִ�. -> ���� ���̺� �����
        -- ���� ���̺��� ���� ���ǿ� ���� �޶�����.
        
create table dept10
as
select * from department;

select * from dept10;

--view ����
create view v_dept10
as
select dno ,dname from dept10;

-- view�� ���
select * from v_dept10;

-- view�� ���ڵ� �Ҵ� : insert -> ���� ���̺��� �������ǿ� ���� ���� ���̺� ���� �Ҵ� �ɼ����ְ� �ȵɼ��� �ִ�.
insert into v_dept10 (dno , dname)
values (50 , 'HR');
commit;

-- view�� ����ؼ� update / delete 
update v_dept10
set dname = '������'
where dno = 50;

delete v_dept10
where dno = 50;

-- view�� insert / update / delete �� ���� ���̺��� �������ǿ� ���� �޶���
select * from dept10;

alter table dept10
modify loc constraint NN_DEPT10_LOC not null ;

-- view�� ���� insert�� �����߻� -> ���� ���̺��� �������� ���� : not null
select * from v_dept10

insert into v_dept10
values (60,'HR');

/* view ���ο� distinct , �����Լ� (sum,min,max,avg)�� �ݵ�� ����ҽ� ��Ī�̸��� ����ؾ��Ѵ�. */
create view v_emp10
as
select min(salary) , max(salary) , round(avg(salary)) , sum(salary) ,count(*)
from employee 
group by dno

create view v_emp10
as
select min(salary) �ּҿ��� , max(salary) �ִ���� , round(avg(salary)) ��տ��� , sum(salary) �����հ� ,
count(*) �μ��հ� ,dno
from employee 
group by dno


----------------------------------------------------------------

/*
ERD (Entity Relationship Diagram) : �����ͺ��̽� �𵨸� ���赵
- ER-Win : ���� , ��� , Oracle , MS-SQL , My-SQL .....
https://www.erdcloud.com/ -> ���� , ������ ���� , 

�𵨸�
1.�䱸���� �м� ->2. ���� �𵨸� ->3. ������ �𵨸� -> 4.����

1.�䱸���� �м� 
- �����ľ� 
- �� ����(������Ʈ�� ���� ����)->���,�Ⱓ , ��������

2.���� �𵨸�
    - ��ƼƼ(���� �𵨸�)�� : ���̺�� (������ �𵨸�)
    - �Ӽ��� (���� �𵨸�)�� : �÷��m (������ �𵨸�)
    - ���� 1:1 , 1:�� , ��:��
    
3. ������ �𵨸�(���̺� �̸� , �÷��� , �ڷ��� -> ��������)

4.���� : Oracle , my-sql ,ms-sql...



*/