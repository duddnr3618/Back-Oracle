/*
DDL , DMT , 제약조건

SQL 구문의 종류 분류
DDL (Data Definition Language) 
: 객체(테이블,함수,뷰,저장프로세서,인덱스) 를 생성하는 언어(구문)
: 스키마(틀,객체)를 생성하는 언어    
- create(생성),alter(수정),drop(삭제)
    
DML (Data Manipulation Language) 
:테이블의 레코드(값)를 조작언어 -> 트랜잭션을 발생시킴 (반드시 커밋(commit)이나 롤벡(rollback을 해야한다)
- insert (입력), update(수정) , delete(삭제)
-오라클에서는 트랜잭션 시작은 자동으로 작동됨
- 트랜잭션을 완료해야한다 (commit , rollback) -> 트랜잭션을 완료하지 않으면 다른 사용자가 접근이 않된다.

DCL(Data Controller Language) 
: 데이터 제어 언어 , 계정에 권한을 부여,수정,제거
- grant (권한을 부여 ) revoke(권한을 취소)

=================================================================

DQL (Data Query Language) 
: 데이터 질의 언어(출력)

TCL (Transaction Control Language)
:트랜젝션 제어 언어 -> DML문에서만 트랜잭션 발생
-begin transaction : 트랜잭션을 자동으로 시작 (insert , update , delete)
-commit transcation : 트랜잭션을 완료 , 커밋 전까지는 메모리에만 수정되어 있고 커밋 후 실제 db에 저장
- rollback transaction : 트랜잭션을 시작시점으로 되돌림
-savepoint : 트랜잭션의 임시 저장 시점 설정
*/

drop table dept
-- 테이블 생성 : create table
create table dept (
    dno number(2) not null , 
    dname varchar2(50) not null ,
    loc varchar2(13) null
);

--테이블 구조 확인
desc dept;

-- 테이블에 값 넣기
insert into dept (dno , dname , loc)
values (10 , '인사부' , '서울');

rollback;
commit ;

select * from dept;

/*트랜잭션 : 작업(일) 을 처리하는 최소 단위 -> DNL문에서 작동 / 트랜잭션을 종료하기 전까지는 LOCK이 걸려서 다른사용자의 접근을 차단
    -- DBMS : 네트워크를 통해서 여러명의 사용자가 동시에 작업
    -- commit : RAM의 수정된 내용을 DB에 영구적으로 저장
    -- rollback : 트랜잰션 시작 시점으로 되돌림
    -- 작업이 할때 LOCK을 걸고 완료되면 LOCK을 풀어준다
    
    -- 트랜잭션의 4가지 특징 
    1.ALL or NOTHING : 되면 전부 되게 하거나 아니면 원래로 되돌리거나
    2.원자성 (Atomicity) : 일을 처리하는 최소단위
    3.일관성 (consistency) : 트랜잭션에서 처리한 결과는 일관성을 가진다.
    4.독립성 (isolation) : 하나의 트랜잭션은 다른 트랜잭션과 격리된다(lock)
*/  
/*
A가 B에게 100억 입금 예시 : 두 update 구문이 하나의 트랜잭션 구문으로 작동되어야 한다.
1.update문을 사용해서 A통장 100억 출금
2.update문을 사용해서 B통장 100억 입금
*/

-- insert 문
desc dept;

insert into dept (loc , dname , dno)
values ('부산' , '관리부' ,20);

select * from dept;

insert into dept
values(30, '영업부' ,null)

insert into dept (dno , dname)
values (40 , '광주')

commit;

-- Update : 수정 -> 반드시 where 조건을 사용해야한다.(Primary key , Unique 컬럼)을 사용해야 한다.
select * from dept;

update dept 
set dname = '제조부'   --> 다바뀐다.

rollback;

update dept 
set dname = '제조부'
where dno = 40;

insert into dept (dno , dname )
values (40 , '판매부')
commit;

update dept
set dname = 'HR' , loc = '대전'
where dno  = 40;
commit;

-- 테이블에는 Primary Key 컬럼이 반드시 존재하야한다. -> 중복된 값을 넣을수 없도록 제약을 설정

-- delete : 테이블의 특정 레코드(값)을 제거 -> 반드시 where조건을 (Primary key , Unique 컬럼)을 사용해야 한다.
select * from dept;

delete dept -- where조건을 사용하지 않으면 모든 레코드값이 다 날라간다.
rollback;

delete dept
where dno = 40;

commit;

/*
제약조건 : 컬럼에 부여되는 제약 ,Primary Key , Unique , Default , Not null , Cheek ,Foreign Key
    특정 컬럼에 무결성을 확보하기 위해서 부여
    - 중복된 값을 넣지 못하도록 설정
    -NOT NULL
    -테이블에 한번만 넣을수 있다. 여러 컬럼에 하나의 Primary key를 넣을수 있다.
    -INDEX가 자동으로 생성된다 -> 검색을 빠르게 함.
    -update , delete 시 where절에서 사용되는 컬럼
*/

create table member1 (
    id varchar2(50) not null Primary Key ,-- primary key에는 반드시 not null이 들어간다. / 중복된 값을 넣을수가 없다.
    pass varchar2 (50) not null ,
    addr varchar2 (100) null ,
    phone varchar2 (30) null,
    age number (3) , 
    weight number (5,2) 
);

select * from member1;

insert into member1 
values ('ddd','aaa' , '1234' , '서울' , '010-1111-1111' , 30 , 70.55)

commit;

update member1 
set addt = '부산' , phone = '010-2222-2222' , age = 30 , weight = 99.12
where id = 'bbb'

-- Unique : 중복된 값을 넣을수 없다 / null 값을 1번만 넣을수 있다. / 하나의 테이블에 여러번 넣을수 있다.  
    -- index가 자동으로 생성됨 -> 검색을 빠르게함.
    -- update , delete 시 where절에서 사용되는 컬럼
    -- join 시 on 절에서 사용되는 컬럼

--Not null 
    -- 반드시 값이 입려되어야 한다. null 을 넣을수 없도록
    
--Check
    --컬럼에 들어오는 값을 체크해서 저장 , 조건에 만족하는 값만 넣도록 

--Foreign Key 
    -- 부모테이블의 특정 컬럼을 참조해서 값을 넣을수 있도록 설정
    -- 부모 테이블의 참조하는 컬럼은 Primary key , unique 키 컬럼을 참조
  
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
values ('aaa' , 'bbb' , '서울' , '010-0000-0000' , 10,70.55)

select * from member2;
commit;

/* 
데이터 사전 : 오라클에서 테이블에 대한 각종 정보를 저장한 테이블
-user_constraints : 제약 조건을 확인하는 데이터 사전
select * from user_constraints
*/



where table_name = 'member2';


-- 테이블 생성시 제약 조건 이름을 부여하면서 제약조건 할당
-- 제약조건 이름은 : PK_테이블이름_컬럼명
 create table member3 (
    id varchar2(50) not null constraint PK_MEMBER3_ID Primary Key ,
    pass varchar2 (50) not null constraint U_MEMBER3_PASS  Unique,
    addr varchar2 (100) null ,
    phone varchar2 (30) null constraint U_MEMBER3_PHONE Unique,
    age number (3) , 
    weight number (5,2) 
);

insert into member3
values ('bb' , 'bb' , '서울' , '010-3333-4444' , 10,70.55)

select * from member3

-- Check : 컬럼의 값을 체크
 create table member4 (
    id varchar2(50) not null constraint PK_MEMBER4_ID Primary Key ,
    pass varchar2 (50) not null constraint U_MEMBER4_PASS  Unique,
    addr varchar2 (100) null ,
    phone varchar2 (30) null constraint U_MEMBER4_PHONE Unique,
    age number (3) constraint CK_MEMBER4_PHONE check (age > 0 and age <150 ) , 
    gender char(1) constraint CK_MEMBER4_GENDER check (gender in ('W' , 'M') ),
    weight number (5,2) 
);

-- 제약조건 출력
select * from user_constraints
where table_name = 'MEMBER4';

insert into member4
values ('a' , 'a' , '서울' , '010-3333-4444' , 10 , 'W' , 70.55)

select * from member4;
commit;

-- Default : 값을 넣지 않으면 default로 설정된 값이 들어간다.
-- 제약조건이 아니여서 제약조건 이름을 부여할수 없다
-- default의 위치는 null 앞쪽에 위치해야한다.
 create table member5 (
    id varchar2(50) not null constraint PK_MEMBER5_ID Primary Key ,
    pass varchar2 (50) not null constraint U_MEMBER5_PASS  Unique,
    addr varchar2 (100) default '서울' null ,
    phone varchar2 (30) null constraint U_MEMBER5_PHONE Unique,
    age number (3) constraint CK_MEMBER5_PHONE check (age > 0 and age <150 ) , 
    gender char(1) constraint CK_MEMBER5_GENDER check (gender in ('W' , 'M') ),
    weight number (5,2) default 0.0 null ,
    hiredate date default sysdate
);

-- insert : default 에 값이 할당 -> default 키를 사용 하는 경우
insert into member5 
values ('b' , 'b', '서울', '010-1111-2222' , 70 , 'M' , 70.55, default) 
select * from member5;
commit;

-- insert : default 에 값이 할당 -> 컬럼에 명시되지 않는경우
insert into member5 
values ('c' ,'c', '010-2222-3333' , 70 , 'M');

select * from member5;

drop table member5

--Foreign Key : 부모 테이블의 특정 컬럼을 참조해서 값을 넣도록 설정
    -- 부모 테이블의 Primary Key , Unique 키 컬럼을 참조
    -- Foreign key는 자식 테이블의 특정 컬럼에 넣는다.
    
--employee 테이블의 dno컬럼은 foreign key 가 설정되어있어 Department의 dno 컬럼을 참조
    --> emlpoyee테이블의 dno 값은 department dno컬럼의 존재하는 값만 참조가능하다.
    
select * from department; -- 부서 정보를 저정하는 테이블(부모테이블)dno
select * from employee;     -- 사원 정보를 저장하는 테이블 (자식 테이블 -> foreign key 가 들어간 테이블 (dno) )

desc employee ;
insert into employee (eno ,ename , job , manager ,hiredate , salary , commission , dno)
values (8000, 'CYW' , 'CTO' , 7369 , sysdate , 1000 , 100 , 40);

select * from employee;

rollback;

/*
foreign key 실습 테이블 생성
*/
-- 1.부모테이블 생성 (PK,UK)
create table ParentTb1 (
    info number constraints PK_ParentTb1_info Primary key,
    name varchar2 (20),
    age number(3) check (age > 0 and age < 200 ),
    gender char(1) check (gender in ('W','M'))
);

-- 2. 자식테이블 생성 (FK)
create table ChildTb1 (
    id varchar2(40) constraints PK_ChildTb1 Primary key ,
    pw varchar2(40) , 
    info number , 
        constraints FK_ChildTb1_info Foreign key (info) references ParentTb1 (info)
);

--부모테이블의 더미(dumy) 데이터 넣기
insert into ParentTb1 (info , name , age , gender )
values ( 10 , '홍길동' , 22 , 'M');

insert into ParentTb1 (info , name , age , gender )
values ( 20 , '이길동' , 32 , 'M');

insert into ParentTb1 (info , name , age , gender )
values ( 30 , '김길동' , 42 , 'M');

insert into ParentTb1 (info , name , age , gender )
values ( 40 , '박길동' , 52 , 'M');
select * from ParentTb1;
commit;

-- 자식테이블의 더미 데이터 넣기
insert into ChildTb1 (id , pw , info)
values ('aaa' , 'aaa' , 10);

insert into ChildTb1 (id , pw , info)
values ('bbb' , 'aaa' , 10);

insert into ChildTb1 (id , pw , info)
values ('ccc' , 'aaa' , 10);

insert into ChildTb1 (id , pw , info)
values ('ddd' , 'aaa' , 10);

select * from ChildTb1;