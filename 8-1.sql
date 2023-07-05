/*
index (인덱스) : 테이블의 특정 컬럼에 검색을 빠르게 하기 위해서 부여되는 객체
    - index가 부여되었 있지 않는 컬럼은 검색시 테이블 스캔을 한다.
    - 컬럼에 index를 생성하면 index[색인] 페이지를 생성한다 - DB의 10% 공간을 사용한다.
    
    - 클러스터 index    : 사전처럼 A~Z까지 순차적으로 생성된 index페이지
    - non 클러스터 index : 책의 첫 페이지 , 내용별로 위치 정보가 생성된 index 페이지
    - where , join on 절에서 자주 검색하는 컬럼에 index를 부여한다.
    - index는 검색을 빠르게 하기 위해서 사용되는데 잘못 부여하거나 주기적인 관리 하지 않으면 
        오히려 검색이 느려질수도 있다.
    - insert , update , delete 가 빈번하게 일어나는 컬럼에는 index의 주기적인 관리가 필요하다.
    - index 페이지가 조각난다
    - 주기적으로 index 페이지를rebuild 해야한다.
    - index를 잘못하면 느려진다.
    - PK , Unique 컬럼은 자동으로 index가 생성된다.
    - index 정보가 저장된 데이터 사전 : ueser_indexes
*/

select * from employee;

-- 데이터 사전을 통해서 index정보를 확인
select * from user_indexes
where table_name in ('DEPARTMENT' , 'EMPLOYEE');

-- 테이블 생성시 PK,Unique 컬럼은 자동으로 index 생성됨
create table emp07
as 
select eno , ename , job , salary from employee;

select * from emp07;

-- 데이터 사전을 통해서 제약조건 확인
select * from user_constraints
where table_name in ('EMP07');

select * from user_indexes
where table_name in ('EMP07');

select * from user_ind_columns
where table_name in ('EMP07');

--EMP07테이블에 PK 부여
alter table EMP07
add constraint PK_EMP07_ENO primary key (eno);

-- 특정 컬럼에 index를 생성함  -> where, join on, 자주검색하는 컬럼
create index idx_EMP07_ENAME  
on EMP07(ENAME);

---------------------------------
create table emp08
as 
select * from employee ;

select * from emp08;

create index idx_EMP08_JOB
on EMP08 (JOB);

-- 조각난 index를 새롭게 rebuild 함 -> index가 생성된 컬럼에 자주 update가 되는 경우 index를 새롭게 생성
-- index삭제후 재 생성 (조각이 심하게 난 경우)
drop index idx_EMP08_JOB
create index idx_EMP08_JOB
on EMP08(Job) ; 

-- index rebuild : 조각이 심하게 나지 않는 경우
alter index EMP08 idx_EMP08_JOB rebuild;


--------------------------

/*
시퀀스 (SEQUENCE) : 자동 번호 발생기 
-특정 컬럼에 번호를 자동으로 넘버링함
-MS-SQL : Identifty (1,1) 
-MY-SQL : Auto-increment(1,1) : 테이블 생성시 특정 컬럼에 indentity , auto_increment를 넣으면 된다.
-정수타입으로 지정되어야 한다.
-시퀀스는 고유한 값을 생성 
*/

-- 시퀀스 생성 -> 처음값 10 , 증가값 10
create sequence seq1
start with 10
increment by 10;

select * from user_sequences;

-- 듀얼 테이블을 사용해서 sequence 정보 출력 : seq1:nextval (다음값을 출력)/ seq1.currval (현재 값을 확인)
select seq1.nextval from dual;
select seq1.currval from dual;

-- 테이블 특정 컬럼에 값을 넣을때 , 시퀀스에서 발생된 값을 넣음
-- 테이블을 복사 할떄 where을 false로 처리하면서 테이블만 복사 , 레코드 값은 가져오지 않음
create table dept08
as 
select * from department
where 0 = 1;

-- dept08 테이블의 dno 컬럼에 sequence할당 : seq1.nextval
select seq1.currval from dual;

insert into dept08 (dno , dname , loc)
values (seq1.nextval, 'HR' , 'Seoul');

select * from dept08;

-- 시퀀스 생성
create sequence seq2 
start with 1
increment by 1
nocache;

select * from user_sequences;

-- insert 시 테이블의 컬럼에 부착
create table dept09
as
select * from department
where 0 = 1;

select * from dept09;

insert into dept09 (dno , dname , loc)
values (seq2.nextval , 'HR' , '서울' );

-- 시퀀스 부착 확인
select seq2.currval from dual;

commit;

-- view 가상 테이블 : select 쿼리가 들어가 있다 
-- 1. 실제 테이블
-- 2. 복잡한 쿼리를 저장후 사용 , join쿼리
-- 뷰를 사용해 insert , update , delete 를 할수도 있고 그렇지 않을수 있다. -> 실제 테이블에 저장됨
        -- 실제 테이블의 제약 조건에 따라 달라진다.
        
create table dept10
as
select * from department;

select * from dept10;

--view 생성
create view v_dept10
as
select dno ,dname from dept10;

-- view를 사용
select * from v_dept10;

-- view에 레코드 할당 : insert -> 실제 테이블의 제약조건에 따라서 실제 테이블에 값이 할당 될수도있고 안될수도 있다.
insert into v_dept10 (dno , dname)
values (50 , 'HR');
commit;

-- view를 사용해서 update / delete 
update v_dept10
set dname = '관리부'
where dno = 50;

delete v_dept10
where dno = 50;

-- view에 insert / update / delete 시 실제 테이블의 제약조건에 따라서 달라짐
select * from dept10;

alter table dept10
modify loc constraint NN_DEPT10_LOC not null ;

-- view에 값을 insert시 오류발생 -> 실제 테이블의 제약조건 위배 : not null
select * from v_dept10

insert into v_dept10
values (60,'HR');

/* view 내부에 distinct , 집계함수 (sum,min,max,avg)를 반드시 사용할시 별칭이름을 사용해야한다. */
create view v_emp10
as
select min(salary) , max(salary) , round(avg(salary)) , sum(salary) ,count(*)
from employee 
group by dno

create view v_emp10
as
select min(salary) 최소월급 , max(salary) 최대월급 , round(avg(salary)) 평균월급 , sum(salary) 월급합계 ,
count(*) 부서합계 ,dno
from employee 
group by dno


----------------------------------------------------------------

/*
ERD (Entity Relationship Diagram) : 데이터베이스 모델링 설계도
- ER-Win : 유료 , 기업 , Oracle , MS-SQL , My-SQL .....
https://www.erdcloud.com/ -> 무료 , 팀별로 공유 , 

모델링
1.요구사항 분석 ->2. 논리적 모델링 ->3. 물리적 모델링 -> 4.구현

1.요구사항 분석 
- 업무파악 
- 고객 협의(프토젝트의 범위 설정)->비용,기간 , 구현범위

2.논리적 모델링
    - 엔티티(논리적 모델링)명 : 테이블명 (물리적 모델링)
    - 속서성 (논리적 모델링)명 : 컬러몀 (물리적 모델링)
    - 관계 1:1 , 1:다 , 다:다
    
3. 물리적 모델링(테이블 이름 , 컬러명 , 자료형 -> 영문으로)

4.구현 : Oracle , my-sql ,ms-sql...



*/