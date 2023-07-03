/*
Join View Index ������

*/
create table dept03
as select * from department;

select * from department;
select * from dept03;
create table emp03 as select * from employee;

select * from emp03;

-- ���̺� ����  : Ư�� �÷��� ������ �־ ����
create table salesman01
as select eno , ename , job, salary
from employee
where job = 'SALESMAN';

select * from salesman01;

-- �츮ȸ���� ��å�� ���� ���̺� ����(job01)
select * from employee;

create table job01
as 
select distinct job
from employee;

-- ���̺� ����� ���������� ������� �ʴ´� - �÷��� , �ڷ��� , ���ڵ�(������) �����
 --���������� ������� �ʴ´�
select * from user_constraints 
where table_name in ('DEPARTMENT' , 'EMPLOYEE' , 'EMP');

--Alter ���̺� �� ����ؼ� ������� �߰�
select * from emp03;
select * from dept03;

alter table emp03
add constraint PK_EMP03_ENO primary key (eno);

--EMO03 ���̺��� DNO �÷��� foreign key : �θ����̺� : dept03 dno�÷�
    -- foreign key �� �����ϴ� �÷��� primary key , unique �÷��� ����
    -- ���� �÷��� �ڷ����� ���ų� ����ؾ���
    -- dno �÷��� ���� �θ� ���̺��� �÷��� ���� ������ ���� ���� �Ѵ�.
    
desc emp03 
desc dept03;

-- �θ� ���̺��� ���� �÷��� : primary key , unique�� �;��Ѵ�.
alter table dept03
add constraint PK_DEPT03_DNO primary key (dno) ;

alter table emp03
add constraint FK_EMP03_DNO foreign key (dno) references dept03 (dno);

select * from emp03;
select distinct job from emp03;

alter table emp03 
add constraint CK_EMP03_SALARY check (salary > 0); 

-- emp03 �� job�÷��� : check salesman manager , analyst , president �� �ֵ��� �������� �Ҵ�
alter table emp03
add constraint CK_emp03_job check ( job in ('CLERK' , 'SALESMAN' , 'MANAGER' , 'ANALYST' , 'PRESIDENT') );


/*
join : database���� ���� ������ ���̺��� �����Ѵ� . �� ���̺��� �ٸ� ���̺�� ����(FK)�� ������ �ִ�.
    -RDEMS : ������ DBMS
    -DB���� ������ ���̺��� �𵨸� �Ǿ��ִ� -> �ߺ��� ������ ���� , ���� ���
    - �𵨸� ���� �ʴ� ���̺��� �ߺ��� �����Ͱ� ��� �Էµ� -> �ϵ� ������ ���� , ������ ��������.
    -employee ���̺��� dno �÷��� �μ���ȣ 
    -department�� ���̺����� �μ���ȣ �μ��� �μ���ġ
    - employee ���̺�� department���̺��� �ϳ��� ���̺�� ������ �Ǿ��� ��� �μ� ������ ��� �ߺ��Ǿ ����.
    - �ٸ� ���̺��� �÷��� ����ϱ� ���ؼ��� join�� ���ؼ� �ٸ� ���̺��� �÷��� ���
    - �� ���̺��� join �ϱ� ���ؼ��� �� ���̺��� ���� Ű �÷��� ã�ƾ� �Ѵ�. ( FK->PK , UK) -> and������ �Ҵ�
    - join anst ȣȯ join : ��� DBMS ���� �������� ����ϴ� join ����
*/

select * from employee;
select * from department;

-- EQUI JOIN : ����Ŭ������ �۵��ϴ� join // ����) ���� Ű �÷��� ���̺��̸��� ��� �ؾ��Ѵ�.
-- select - join �� ���̺��� �÷��� ��� 
-- ���̺� ��Ī (alias)�� ����ؼ� ����
select ENO , ENAME , JOB , d.DNO , DNAME , LOC        -- �� ���̺��� ������ Ű �÷��� ��½� �ش� ���̺��� ����ؾ��Ѵ�.
from employee e , department d  -- employee = e ���̺�� department = d ���̺��� ���� -> ������ ���̺��� ,�� ���
where e.dno = d.dno     -- �� ���̺��� ���� Ű �÷��� ã�Ƽ� '=' �� ó�� / and ������ ó��
and d.dno ='20';

-- ���̺� ��Ī�� ������� �ʴ°�� [��ü����]
select employee.eno , employee.ename , employee.job , employee.dno , department.dname , department.loc
from employee , department 
where employee.dno = department.dno
and employeee.dno= '20';

select eno , ename , job , e.dno , dname , loc
from employee e, department d 
where e.dno = d.dno
and e.dno= '20';

-- employee , department ���̺��� ��ü �÷� ���
desc employee;
desc department;

select eno , job , manager , hiredate , salary, commission , e.dno
from employee e , department d 
where e.dno = d.dno;

select * from emp_dept;
select * from department;

/*
ANSI JOIN : ��� DBMS���� �������� ���

-inner join : �� ���̺� ��� ���� Ű �÷��� ���� ��ġ �ϴ� �͸� ���
select : �� ���̺��� �÷��� ���, �� ���̺��� ���� Ű �÷��� ��½� ���̺� �̸��� ���
from : ���̺� 1 join ���̺�2
on : �� ���̺��� ���� Ű �÷��� ��� 
where : ����
*/

select eno , ename , job , salary , e.dno , dname , loc
from employee e join department d
on e.dno = d.dno
where e.dno = '20';


/*
Outer join : ���� ���̺��� ������ ��� ���

Left outer join : ���� ���̺����� ������ ��� ���
Right outer join : ������ ���̺��� ������ ��� ���
Full outer join : �� ���̺��� ��� ��ü ������ ���
*/

--ANSI ȣȯ�� Outer join 
create table emp05 
as 
select * from employee ;

create table dept05
as
select * from department;

select * from dept05;
insert into dept05 
values (50,'HR' , '����');
commit;

-- ANSI ȣȯ�� INNER JOIN : �� ���̺��� ���� Ű �÷��� ��ġ�ϴ� �����͸� ���(������)
select eno , ename , job , e.dno , dname , loc
from dept05 d Inner join emp05 e
on d.dno = e.dno;


-- ANSI ȣȯ�� Left out JOIN : �� ���̺��� ���� Ű �÷��� ��ġ�ϴ� ���� ���̺��� ���� ��� ���
select eno , ename , job , e.dno , dname , loc
from dept05 d left outer join emp05 e
on d.dno = e.dno;

--Oracle Equie JOIN
--īŸ���þ� �� : �� ���̺��� ��� ���ڵ尡 �� ���̺��� ���ڵ忡 ���� ��Ī
--where ���ǿ��� �� ���� Ű �÷��� ���� �׸� ���
select *  
from employee e ,department d
where e.dno = d.dno
and salary >2000;

/*
Natural join : ����Ŭ������ ���Ǵ� join 
-�� ���̺��� ���� Ű �÷��� ����Ŭ���� �ڵ����� ã�Ƽ� join
-select ������ ���� Ű �÷��� ���̺��� ����ϸ� ������ �߻�
-from ���� natural joinŰ���带 �����
- where ���� ���� Ű �÷��� ������� ���� (����Ŭ���� �� ���̺��� ���� Ű�÷��� �ڵ����� ã�Ƽ� ó��)
- where���� ������ ó����
*/
--natural join���� join
-- �����̺��� ���� Ű �÷��� �ڵ����� ã�Ƽ� ���� -> select���� ���� Ű �÷��� ��½� ���̺��̸��� ��ý� �����߻�
select eno , ename , salary ,dno , dname , loc
from emp05 e natural join dept05 d

--EQUI JOIN
select eno , ename, salary , e.dno , dname , loc
from emp05 e , dept05 d
where e.dno = d.dno 
and salary >2000;

-- ANSI SQL JOIN : ���DBMS���� ���Ǵ� ����
select eno , ename , salary , e.dno , dname , loc 
from emp05 e join dept05 d
on e.dno = d.dno
where salary >2000;

-- SELF JOIN �� ����ؼ� ����� ���� ������� (�̸�) �� ���
select eno �����ȣ , ename ����� , manager ���ӻ��
from employee 
where manager = 7788
order by ename asc;

-- self join�� ����ؼ� ���ӻ�� ������ �ѹ��� ���(EQUI JOIN)
select e.ename �����ȣ , e.manager ���ӻ����ȣ , m.eno ���ӻ�������ȣ, m.ename ���ӻ���̸�
from emp05 e , emp05 m
where e.manager = m.eno
order by e.ename asc;

select eno , ename , manager , eno , ename
from emp05 

-- self join�� ����ؼ� ���ӻ�� ������ �ѹ��� ���(ANSI JOIN)
select e.ename �����ȣ , e.manager ���ӻ����ȣ , m.eno ���ӻ�������ȣ, m.ename ���ӻ���̸�
from emp05 e join emp05 m
on e.manager = m.eno
order by e.ename asc;

select * from emp05;

-- select������ �ӤӸ� ����ϸ鼭 ���ڿ��� ����
select '����� : '||ename ||' �� ������ ' || salary '�Դϴ�.'
as ����޿�����
from emp05 ;

-- 