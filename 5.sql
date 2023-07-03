/*
DDL - Alter Table : 기존의 생성된 테이블을 수정
    - 기존테이블의 컬럼을 추가/삭제 및 이름 변경
    - 컬럼의 부여된 제약조건을 생성 , 수정 , 삭제
*/

-- 테이블 생성
create table dept01     -- department를 복사한 테이블 -> 원본테이블의 제약조건은 복사되어 오지않는다.
as select * from department;

create table emp01
as select * from employee;

select * from dept01;
desc dept01;
desc department;

-- 제약조건을 확인하는 데이터 사전
show user;
select * from user_constraints -- 현재 접속한 계정의 모든 테이블의 제약조건을 확인
--where table_name = 'DEPARTMENT';
where table_name = 'DEPT01';

-- FP가 참조하는 부모테이블은 drop이 되지 않는다.
-- 1. 자식테이블 삭제후 부모테이블 삭제
-- 2. 부모테이블을 삭제하면서 cascade 옵션을 사용시 강제로 삭제된다.

-- 부모테이블 삭제
drop table ParentTb1;
-- 1.자식테이블 먼저 삭제 후 부모테이블 삭제
drop table ChildTb1;
drop table ParentTb1;

-- 2.부모테이블 삭제하면서 cascde옵션을 사용
drop table ParentTb1 cascade constraints;

select * from dept01;

alter table dept01
add (birth date);

alter table dept01
add (email varchar2(100) , addr varchar2(200) , jumin char(14) );

-- 테이블에 컬럼을 추가하게 되면 기본값으로 null이 할당된다. -> update로 값 할당(추가)
update dept01
set birth = sysdate , email = 'aaa@aaa.com' , addr = '서울' , jumin = '123456-1234567'
where dno = 10;

-- 컬럼의 자료형을 수정 : char , varchar 글자수를 늘림
alter table dept01
modify email varchar2(200);
desc dept01;

-- 특정 컬럼 삭제
alter table dept01
drop column JUMIN;
select * from dept01;

-- 컬럼명 변경 : rename
alter table dept01
rename column dno to d_dno;

-- 테이블 이름 변경 
rename dept01 to dept001;
rename dept001 to dept01;

-- 테이터 사전에서 현재 로그온한 사용자의 모든 테이블 출력
select * from user_tables;

/*
alter table 을 사용 해서 제약조건 생성,수정,삭제
-Primary key
-Unique 
-Foreign key
-Check
-Not null

-default
*/

-- 데이터 사전을 통해서 여러 테이블의 제약조건을 한번에 확인
select * from user_constraints
where table_name in ('DEPT01' , 'DEPARTMENT' , 'EMP01' , 'EMPLOYEE');

-- 기존테이블에서 Primary key 제약조건 넣기
-- 컬럼의 중복된 값이 없어야 한다.
-- 컬럼의 null 이 들어가 있으면 안된다.
-- 테이블에 primary key컬럼이 존재하면 안된다.  테이블에 1번만 넣을수 있다
select * from dept01;
-- dept01 테이블에 d_dno 컬럼에 Primary key 할당
alter table dept01
add constraints PK_DEPT01_D_DNO primary key (d_dno);
desc dept01;

/*
Foreign Key 할당
-부모 테이블의 primary key , unique 컬럼을 참조함
-FK가 적용된 컬럼과 , 부모 테이블의 참조 컬럼의 자료형이 비슷하거나 같아야한다.
-FK가 적용된 컬럼의 값은 부모테이블의 참조 값이 들어가 있어야한다.
*/

--EMP01 테이블
select * from dept01;   -- 부모테이블(dept01) : d_dno
select * from emp01;    -- 자식테이블 : dno 

-- emp01 테이블에 dno 컬럼에 FK 할당
alter table emp01
add constraints FK_EMP01_DNO foreign key (dno) references DEPT01(d_dno);

/*
Unique 제약조건 
- 컬럼에 중복된 값이 없어야한다.
- null 은 1번만 들어가 있어야 한다.
- not null ,null 이 적용된 곳이 부여할수 있다
*/

-- emp01테이블에 ename 컬럼에 unique 제약 할당
select * from emp01;

alter table emp01
add constraint U_EMP01_ENAME unique(ename);

--emp01 테이블에 eno 컬럼에 primary key제약조건 추가
alter table emp01
add constraints FK_EMP01_ENO primary key (eno);

/*
Check 제약조건
- 특정컬럼에 조건에 맞는 값만 저장되도록 설정
- salary 컬럼에 조건 : salary > 0
*/

alter table emp01
add constraint CK_EMP01_SALARY check(salary> 0);

/*
Not null 제약조건
-컬럼에 null 값이 존재하지 않아야 한다.
*/

-- job 컬럼에 not null 제약조건 추가
desc emp01;

alter table emp01
modify job constraint NN_EMP01_JOB not null;