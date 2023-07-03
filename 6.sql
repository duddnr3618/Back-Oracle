/*
Join View Index 시퀀스

*/
create table dept03
as select * from department;

select * from department;
select * from dept03;
create table emp03 as select * from employee;

select * from emp03;

-- 테이블 복사  : 특정 컬럼과 조건을 주어서 복사
create table salesman01
as select eno , ename , job, salary
from employee
where job = 'SALESMAN';

select * from salesman01;

-- 우리회사의 직책만 담은 테이블 생성(job01)
select * from employee;

create table job01
as 
select distinct job
from employee;

-- 테이블 복사시 제약조건은 복사되지 않는다 - 컬럼명 , 자료형 , 레코드(데이터) 복사됨
 --제약조건은 복사되지 않는다
select * from user_constraints 
where table_name in ('DEPARTMENT' , 'EMPLOYEE' , 'EMP');

--Alter 테이블 을 사용해서 재약조건 추가
select * from emp03;
select * from dept03;

alter table emp03
add constraint PK_EMP03_ENO primary key (eno);

--EMO03 테이블의 DNO 컬럼에 foreign key : 부모테이블 : dept03 dno컬럼
    -- foreign key 가 참조하는 컬럼은 primary key , unique 컬럼을 참조
    -- 참조 컬럼의 자료형이 같거나 비슷해야함
    -- dno 컬럼의 값이 부모 테이블의 컬럼의 값이 참조된 값이 들어가야 한다.
    
desc emp03 
desc dept03;

-- 부모 테이블의 참조 컬럼은 : primary key , unique이 와야한다.
alter table dept03
add constraint PK_DEPT03_DNO primary key (dno) ;

alter table emp03
add constraint FK_EMP03_DNO foreign key (dno) references dept03 (dno);

select * from emp03;
select distinct job from emp03;

alter table emp03 
add constraint CK_EMP03_SALARY check (salary > 0); 

-- emp03 의 job컬럼은 : check salesman manager , analyst , president 만 넣도록 제약조건 할당
alter table emp03
add constraint CK_emp03_job check ( job in ('CLERK' , 'SALESMAN' , 'MANAGER' , 'ANALYST' , 'PRESIDENT') );


/*
join : database에는 많은 데이터 테이블이 존재한다 . 각 테이블은 다른 테이블과 관계(FK)를 가지고 있다.
    -RDEMS : 관계형 DBMS
    -DB내의 각각의 테이블은 모델링 되어있다 -> 중복된 데이터 제거 , 성능 향상
    - 모델링 되지 않는 테이블은 중복된 데이터가 계속 입력됨 -> 하드 공간을 낭비 , 성능이 느려진다.
    -employee 테이블의 dno 컬럼은 부서번호 
    -department의 테이블으느 부서번호 부서명 부서위치
    - employee 테이블과 department테이블을 하나으 테이블로 디자인 되었을 경우 부서 정보가 계속 중복되어서 들어간다.
    - 다른 테이블의 컬럼을 출력하기 위해서는 join을 통해서 다른 테이블의 컬럼을 출력
    - 두 테이블을 join 하기 위해서는 두 테이블의 공통 키 컬럼을 찾아야 한다. ( FK->PK , UK) -> and절에서 할당
    - join anst 호환 join : 모든 DBMS 에서 공통으로 사용하는 join 구문
*/

select * from employee;
select * from department;

-- EQUI JOIN : 오라클에서만 작동하는 join // 주의) 공통 키 컬럼은 테이블이름을 명시 해야한다.
-- select - join 할 테이블의 컬럼을 명시 
-- 테이블 별칭 (alias)을 사용해서 조인
select ENO , ENAME , JOB , d.DNO , DNAME , LOC        -- 두 테이블의 공통의 키 컬럼을 출력시 해당 테이블을 명시해야한다.
from employee e , department d  -- employee = e 테이블과 department = d 테이블을 조인 -> 조인할 테이블을 ,로 명시
where e.dno = d.dno     -- 두 테이블의 공통 키 컬럼을 찾아서 '=' 로 처리 / and 조건을 처리
and d.dno ='20';

-- 테이블 별칭을 사용하지 않는경우 [전체구문]
select employee.eno , employee.ename , employee.job , employee.dno , department.dname , department.loc
from employee , department 
where employee.dno = department.dno
and employeee.dno= '20';

select eno , ename , job , e.dno , dname , loc
from employee e, department d 
where e.dno = d.dno
and e.dno= '20';

-- employee , department 테이블의 전체 컬럼 출력
desc employee;
desc department;

select eno , job , manager , hiredate , salary, commission , e.dno
from employee e , department d 
where e.dno = d.dno;

select * from emp_dept;
select * from department;

/*
ANSI JOIN : 모든 DBMS에서 공통으로 사용

-inner join : 두 테이블 모두 공통 키 컬럼의 값이 일치 하는 것만 출력
select : 두 테이블의 컬럼을 명시, 두 테이블의 공통 키 컬럼을 출력시 테이블 이름을 명시
from : 테이블 1 join 테이블2
on : 두 테이블의 공통 키 컬럼을 명시 
where : 조건
*/

select eno , ename , job , salary , e.dno , dname , loc
from employee e join department d
on e.dno = d.dno
where e.dno = '20';


/*
Outer join : 한쪽 테이블의 내용을 모두 출력

Left outer join : 왼쪽 테이블으느 무조건 모두 출력
Right outer join : 오른쪽 테이블은 무조건 모두 출력
Full outer join : 두 테이블의 모두 전체 내용을 출력
*/

--ANSI 호환의 Outer join 
create table emp05 
as 
select * from employee ;

create table dept05
as
select * from department;

select * from dept05;
insert into dept05 
values (50,'HR' , '서울');
commit;

-- ANSI 호환의 INNER JOIN : 두 테이블의 공통 키 컬럼이 일치하는 데이터만 출력(교집합)
select eno , ename , job , e.dno , dname , loc
from dept05 d Inner join emp05 e
on d.dno = e.dno;


-- ANSI 호환의 Left out JOIN : 두 테이블의 공통 키 컬럼이 일치하는 왼쪽 테이블의 값은 모두 출력
select eno , ename , job , e.dno , dname , loc
from dept05 d left outer join emp05 e
on d.dno = e.dno;

--Oracle Equie JOIN
--카타르시안 곱 : 앞 테이블의 모든 레코드가 뒷 테이블의 레코드에 각각 매칭
--where 조건에서 두 공통 키 컬럼이 같은 항목만 출력
select *  
from employee e ,department d
where e.dno = d.dno
and salary >2000;

/*
Natural join : 오라클에서만 사용되는 join 
-두 테이블의 공통 키 컬럼을 오라클에서 자동으로 찾아서 join
-select 구문에 공통 키 컬럼을 테이블을 명시하면 오류가 발생
-from 절에 natural join키워드를 사용함
- where 절에 공통 키 컬럼을 명시하지 않음 (오라클에서 두 테이블의 공통 키컬럼을 자동으로 찾아서 처리)
- where절에 조건을 처리함
*/
--natural join으로 join
-- 두테이블의 공통 키 컬럼을 자동으로 찾아서 조인 -> select절에 공통 키 컬럼을 출력시 테이블이름을 명시시 오류발생
select eno , ename , salary ,dno , dname , loc
from emp05 e natural join dept05 d

--EQUI JOIN
select eno , ename, salary , e.dno , dname , loc
from emp05 e , dept05 d
where e.dno = d.dno 
and salary >2000;

-- ANSI SQL JOIN : 모든DBMS에서 사용되는 구문
select eno , ename , salary , e.dno , dname , loc 
from emp05 e join dept05 d
on e.dno = d.dno
where salary >2000;

-- SELF JOIN 을 사용해서 사원의 직속 상관정보 (이름) 을 출력
select eno 사원번호 , ename 사원명 , manager 직속상관
from employee 
where manager = 7788
order by ename asc;

-- self join을 사용해서 직속상관 정보를 한번에 출력(EQUI JOIN)
select e.ename 사원번호 , e.manager 직속상관번호 , m.eno 직속상관사원번호, m.ename 직속상관이름
from emp05 e , emp05 m
where e.manager = m.eno
order by e.ename asc;

select eno , ename , manager , eno , ename
from emp05 

-- self join을 사용해서 직속상관 정보를 한번에 출력(ANSI JOIN)
select e.ename 사원번호 , e.manager 직속상관번호 , m.eno 직속상관사원번호, m.ename 직속상관이름
from emp05 e join emp05 m
on e.manager = m.eno
order by e.ename asc;

select * from emp05;

-- select문에서 ㅣㅣ를 사용하면서 문자열과 연결
select '사원명 : '||ename ||' 은 월급이 ' || salary '입니다.'
as 사원급여정보
from emp05 ;

-- 