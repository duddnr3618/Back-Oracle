/*
DDL , DMT , ��������

SQL ������ ���� �з�
DDL (Data Definition Language) 
: ��ü(���̺�,�Լ�,��,�������μ���,�ε���) �� �����ϴ� ���(����)
: ��Ű��(Ʋ,��ü)�� �����ϴ� ���    
- create(����),alter(����),drop(����)
    
DML (Data Manipulation Language) 
:���̺��� ���ڵ�(��)�� ���۾�� -> Ʈ������� �߻���Ŵ (�ݵ�� Ŀ��(commit)�̳� �Ѻ�(rollback�� �ؾ��Ѵ�)
- insert (�Է�), update(����) , delete(����)
-����Ŭ������ Ʈ����� ������ �ڵ����� �۵���
- Ʈ������� �Ϸ��ؾ��Ѵ� (commit , rollback) -> Ʈ������� �Ϸ����� ������ �ٸ� ����ڰ� ������ �ʵȴ�.

DCL(Data Controller Language) 
: ������ ���� ��� , ������ ������ �ο�,����,����
- grant (������ �ο� ) revoke(������ ���)

=================================================================

DQL (Data Query Language) 
: ������ ���� ���(���)

TCL (Transaction Control Language)
:Ʈ������ ���� ��� -> DML�������� Ʈ����� �߻�
-begin transaction : Ʈ������� �ڵ����� ���� (insert , update , delete)
-commit transcation : Ʈ������� �Ϸ� , Ŀ�� �������� �޸𸮿��� �����Ǿ� �ְ� Ŀ�� �� ���� db�� ����
- rollback transaction : Ʈ������� ���۽������� �ǵ���
-savepoint : Ʈ������� �ӽ� ���� ���� ����
*/

drop table dept
-- ���̺� ���� : create table
create table dept (
    dno number(2) not null , 
    dname varchar2(50) not null ,
    loc varchar2(13) null
);

--���̺� ���� Ȯ��
desc dept;

-- ���̺� �� �ֱ�
insert into dept (dno , dname , loc)
values (10 , '�λ��' , '����');

rollback;
commit ;

select * from dept;

/*Ʈ����� : �۾�(��) �� ó���ϴ� �ּ� ���� -> DNL������ �۵� / Ʈ������� �����ϱ� �������� LOCK�� �ɷ��� �ٸ�������� ������ ����
    -- DBMS : ��Ʈ��ũ�� ���ؼ� �������� ����ڰ� ���ÿ� �۾�
    -- commit : RAM�� ������ ������ DB�� ���������� ����
    -- rollback : Ʈ����� ���� �������� �ǵ���
    -- �۾��� �Ҷ� LOCK�� �ɰ� �Ϸ�Ǹ� LOCK�� Ǯ���ش�
    
    -- Ʈ������� 4���� Ư¡ 
    1.ALL or NOTHING : �Ǹ� ���� �ǰ� �ϰų� �ƴϸ� ������ �ǵ����ų�
    2.���ڼ� (Atomicity) : ���� ó���ϴ� �ּҴ���
    3.�ϰ��� (consistency) : Ʈ����ǿ��� ó���� ����� �ϰ����� ������.
    4.������ (isolation) : �ϳ��� Ʈ������� �ٸ� Ʈ����ǰ� �ݸ��ȴ�(lock)
*/  
/*
A�� B���� 100�� �Ա� ���� : �� update ������ �ϳ��� Ʈ����� �������� �۵��Ǿ�� �Ѵ�.
1.update���� ����ؼ� A���� 100�� ���
2.update���� ����ؼ� B���� 100�� �Ա�
*/

-- insert ��
desc dept;

insert into dept (loc , dname , dno)
values ('�λ�' , '������' ,20);

select * from dept;

insert into dept
values(30, '������' ,null)

insert into dept (dno , dname)
values (40 , '����')

commit;

-- Update : ���� -> �ݵ�� where ������ ����ؾ��Ѵ�.(Primary key , Unique �÷�)�� ����ؾ� �Ѵ�.
select * from dept;

update dept 
set dname = '������'   --> �ٹٲ��.

rollback;

update dept 
set dname = '������'
where dno = 40;

insert into dept (dno , dname )
values (40 , '�Ǹź�')
commit;

update dept
set dname = 'HR' , loc = '����'
where dno  = 40;
commit;

-- ���̺��� Primary Key �÷��� �ݵ�� �����Ͼ��Ѵ�. -> �ߺ��� ���� ������ ������ ������ ����

-- delete : ���̺��� Ư�� ���ڵ�(��)�� ���� -> �ݵ�� where������ (Primary key , Unique �÷�)�� ����ؾ� �Ѵ�.
select * from dept;

delete dept -- where������ ������� ������ ��� ���ڵ尪�� �� ���󰣴�.
rollback;

delete dept
where dno = 40;

commit;

/*
�������� : �÷��� �ο��Ǵ� ���� ,Primary Key , Unique , Default , Not null , Cheek ,Foreign Key
    Ư�� �÷��� ���Ἲ�� Ȯ���ϱ� ���ؼ� �ο�
    - �ߺ��� ���� ���� ���ϵ��� ����
    -NOT NULL
    -���̺� �ѹ��� ������ �ִ�. ���� �÷��� �ϳ��� Primary key�� ������ �ִ�.
    -INDEX�� �ڵ����� �����ȴ� -> �˻��� ������ ��.
    -update , delete �� where������ ���Ǵ� �÷�
*/

create table member1 (
    id varchar2(50) not null Primary Key ,-- primary key���� �ݵ�� not null�� ����. / �ߺ��� ���� �������� ����.
    pass varchar2 (50) not null ,
    addr varchar2 (100) null ,
    phone varchar2 (30) null,
    age number (3) , 
    weight number (5,2) 
);

select * from member1;

insert into member1 
values ('ddd','aaa' , '1234' , '����' , '010-1111-1111' , 30 , 70.55)

commit;

update member1 
set addt = '�λ�' , phone = '010-2222-2222' , age = 30 , weight = 99.12
where id = 'bbb'

-- Unique : �ߺ��� ���� ������ ���� / null ���� 1���� ������ �ִ�. / �ϳ��� ���̺� ������ ������ �ִ�.  
    -- index�� �ڵ����� ������ -> �˻��� ��������.
    -- update , delete �� where������ ���Ǵ� �÷�
    -- join �� on ������ ���Ǵ� �÷�

--Not null 
    -- �ݵ�� ���� �Է��Ǿ�� �Ѵ�. null �� ������ ������
    
--Check
    --�÷��� ������ ���� üũ�ؼ� ���� , ���ǿ� �����ϴ� ���� �ֵ��� 

--Foreign Key 
    -- �θ����̺��� Ư�� �÷��� �����ؼ� ���� ������ �ֵ��� ����
    -- �θ� ���̺��� �����ϴ� �÷��� Primary key , unique Ű �÷��� ����
  
/* Unique*/
create table member2 (
    id varchar2(50) not null Primary Key ,
    pass varchar2 (50) not null  Unique,
    addr varchar2 (100) null ,
    phone varchar2 (30) null Unique,
    age number (3) , 
    weight number (5,2) 
);

insert into member2 
values ('aaa' , 'bbb' , '����' , '010-0000-0000' , 10,70.55)

select * from member2;
commit;

/* 
������ ���� : ����Ŭ���� ���̺� ���� ���� ������ ������ ���̺�
-user_constraints : ���� ������ Ȯ���ϴ� ������ ����
select * from user_constraints
*/



where table_name = 'member2';


-- ���̺� ������ ���� ���� �̸��� �ο��ϸ鼭 �������� �Ҵ�
-- �������� �̸��� : PK_���̺��̸�_�÷���
 create table member3 (
    id varchar2(50) not null constraint PK_MEMBER3_ID Primary Key ,
    pass varchar2 (50) not null constraint U_MEMBER3_PASS  Unique,
    addr varchar2 (100) null ,
    phone varchar2 (30) null constraint U_MEMBER3_PHONE Unique,
    age number (3) , 
    weight number (5,2) 
);

insert into member3
values ('bb' , 'bb' , '����' , '010-3333-4444' , 10,70.55)

select * from member3

-- Check : �÷��� ���� üũ
 create table member4 (
    id varchar2(50) not null constraint PK_MEMBER4_ID Primary Key ,
    pass varchar2 (50) not null constraint U_MEMBER4_PASS  Unique,
    addr varchar2 (100) null ,
    phone varchar2 (30) null constraint U_MEMBER4_PHONE Unique,
    age number (3) constraint CK_MEMBER4_PHONE check (age > 0 and age <150 ) , 
    gender char(1) constraint CK_MEMBER4_GENDER check (gender in ('W' , 'M') ),
    weight number (5,2) 
);

-- �������� ���
select * from user_constraints
where table_name = 'MEMBER4';

insert into member4
values ('a' , 'a' , '����' , '010-3333-4444' , 10 , 'W' , 70.55)

select * from member4;
commit;

-- Default : ���� ���� ������ default�� ������ ���� ����.
-- ���������� �ƴϿ��� �������� �̸��� �ο��Ҽ� ����
-- default�� ��ġ�� null ���ʿ� ��ġ�ؾ��Ѵ�.
 create table member5 (
    id varchar2(50) not null constraint PK_MEMBER5_ID Primary Key ,
    pass varchar2 (50) not null constraint U_MEMBER5_PASS  Unique,
    addr varchar2 (100) default '����' null ,
    phone varchar2 (30) null constraint U_MEMBER5_PHONE Unique,
    age number (3) constraint CK_MEMBER5_PHONE check (age > 0 and age <150 ) , 
    gender char(1) constraint CK_MEMBER5_GENDER check (gender in ('W' , 'M') ),
    weight number (5,2) default 0.0 null ,
    hiredate date default sysdate
);

-- insert : default �� ���� �Ҵ� -> default Ű�� ��� �ϴ� ���
insert into member5 
values ('b' , 'b', '����', '010-1111-2222' , 70 , 'M' , 70.55, default) 
select * from member5;
commit;

-- insert : default �� ���� �Ҵ� -> �÷��� ��õ��� �ʴ°��
insert into member5 
values ('c' ,'c', '010-2222-3333' , 70 , 'M');

select * from member5;

drop table member5

--Foreign Key : �θ� ���̺��� Ư�� �÷��� �����ؼ� ���� �ֵ��� ����
    -- �θ� ���̺��� Primary Key , Unique Ű �÷��� ����
    -- Foreign key�� �ڽ� ���̺��� Ư�� �÷��� �ִ´�.
    
--employee ���̺��� dno�÷��� foreign key �� �����Ǿ��־� Department�� dno �÷��� ����
    --> emlpoyee���̺��� dno ���� department dno�÷��� �����ϴ� ���� ���������ϴ�.
    
select * from department; -- �μ� ������ �����ϴ� ���̺�(�θ����̺�)dno
select * from employee;     -- ��� ������ �����ϴ� ���̺� (�ڽ� ���̺� -> foreign key �� �� ���̺� (dno) )

desc employee ;
insert into employee (eno ,ename , job , manager ,hiredate , salary , commission , dno)
values (8000, 'CYW' , 'CTO' , 7369 , sysdate , 1000 , 100 , 40);

select * from employee;

rollback;

/*
foreign key �ǽ� ���̺� ����
*/
-- 1.�θ����̺� ���� (PK,UK)
create table ParentTb1 (
    info number constraints PK_ParentTb1_info Primary key,
    name varchar2 (20),
    age number(3) check (age > 0 and age < 200 ),
    gender char(1) check (gender in ('W','M'))
);

-- 2. �ڽ����̺� ���� (FK)
create table ChildTb1 (
    id varchar2(40) constraints PK_ChildTb1 Primary key ,
    pw varchar2(40) , 
    info number , 
        constraints FK_ChildTb1_info Foreign key (info) references ParentTb1 (info)
);

--�θ����̺��� ����(dumy) ������ �ֱ�
insert into ParentTb1 (info , name , age , gender )
values ( 10 , 'ȫ�浿' , 22 , 'M');

insert into ParentTb1 (info , name , age , gender )
values ( 20 , '�̱浿' , 32 , 'M');

insert into ParentTb1 (info , name , age , gender )
values ( 30 , '��浿' , 42 , 'M');

insert into ParentTb1 (info , name , age , gender )
values ( 40 , '�ڱ浿' , 52 , 'M');
select * from ParentTb1;
commit;

-- �ڽ����̺��� ���� ������ �ֱ�
insert into ChildTb1 (id , pw , info)
values ('aaa' , 'aaa' , 10);

insert into ChildTb1 (id , pw , info)
values ('bbb' , 'aaa' , 10);

insert into ChildTb1 (id , pw , info)
values ('ccc' , 'aaa' , 10);

insert into ChildTb1 (id , pw , info)
values ('ddd' , 'aaa' , 10);

select * from ChildTb1;