/*
DAY : 요일(월요일,화요일...)
DY : 요일 (월,화 ...)
HH : 시간
MI : 분  
SS : 초
*/

select TO_CHAR(sysdate , 'YYYYMMDD'), TO_CHAR(sysdate , 'YYYY-MM-DD DY HH:MI;SS'),
TO_CHAR(sysdate , 'YYYY/MM/DD DY HH:MI;SS')
from dual;

select sysdate , TO_CHAR (sysdate , 'YY/MM/DD_HH:MI:SS_DY')
from dual;

select *
from employee ;


select hiredate , TO_CHAR (hiredate , 'YYYY-MM-DD DAY HH:MM:SS')
from employee;

/*TO_CHAR : 날짜 , 숫자 -> 문자형으로 변환
    0 : 자릿수를 처리함 , 자릿수가 맞지 않으면 0으로 처리됨
    9 : 자릿수를 처리함 , 자릿수가 맞지 않으면 공백으로 처리됨
    L : 각 지역에 통화를 기호로 표시
    . : 소숫점 처리
    , : 천단위 구분자
*/

desc employee;

select ename, salary , to_char(salary , 'L999,999') , to_char (salary ,'L000,000')
from employee;

--TO_CHAR (변환할문자[숫자] ,YYYYMMDD)

select TO_DATE(20230628,'YYYYMMDD'),TO_DATE ('06282023' , 'MMDDYYYY')
from dual;

select to_date ('2001-10-30' , 'yyyy-mm-dd')
from dual;

-- 태어난 날에서 오늘까지 몇일 지났는지
select TRUNC (sysdate - to_date ('1981-04-15' , 'yyyy-mm-dd') ) -- 해당 날짜에서 현재까지 일수
from dual;

select to_date ('12/06/22' , 'MM/DD/YY') - to_date ('1900-10-17' , 'yyyy/mm/dd')
from dual;

select trunc( sysdate - to_date ('1981/01/01' , 'yyyy/mm/dd') ) as "살아온 일수",
    trunc (months_between (sysdate , to_date ('1981/01/01', 'yyyy/mm/dd')) ) as "살아온 개월수"
    from dual;
    
-- employee 테이블에섯 각 사원의 입사일에서 2030/01/01 까지 근무 개월수 
select * from employee;

select ename ,hiredate , 
trunc ( months_between( to_Date ('2030/01/01' , 'yyyy/mm/dd') , hiredate) ) as "특정날짜까지 개월수"
from employee;

/*
null 처리 함수
 NVL (컬럼 ,값 ) : 컬럼에 null이 존재하는경우 값으로 대체
 NVL2 (컬럼명 ,null이 아닐경우 처리 , null일 경우 처리)
*/

select *
from employee;

--NVL 함수를 사용해서 처리 -> 연봉을 구함
select ename 사원이름, salary 월급,commission 보너스,salary*12+NVL(commission,0) 연봉
from employee;

--NVL2 함수를 사용해서 처리
select ename , salary , commission,
    salary*12+NVL2(commission,commission,0) 총연봉
from employee;

/*
그룹함수 : group by , 특정컬럼을 그룹핑해서 처리
*/

select 컬럼명
from 테이블이름[뷰]
where 조건
group by 컬럼명[그룹핑할컬럼명]
having 조건 {그룹핑한 결과의 조건}
order by 정렬할컬럼명

/*
집계함수 : SUM , AVG , MAX , MIN m COUNT -> null을 자동으로 처리해서 작동됨
    -sum : 컬럼의 모듬 값을 더하는 함수
    -avg : 컬럼의 모든 값의 평균을 구하는 함수
    -max : 컬럼의 모든값의 최대값을 가져오는 함수
    -min : 컬럼의 모든값의 최소값을 가져오는 함수
    -count : 레코드 수 ,그룹핑된 갯수
*/

select commission from employee;

select sum(commission) as 합계 , avg (commission)as 평균 , max(commission) 최대값 , min(commission) 최솟값
from employee;


-- 부서별 월급의 합계,평균,최대,최소,그룹핑된 갯수
select *
from employee;

select sum (salary) as 부서별합계 , dno  부서,  -- 부서별로 묶어서 그 부스별로 총합 
count (dno) 그룹핑된갯수
from employee                                -- dno : 부서번호가 동일한 값을 그룹해서 처리함
group by dno;

select avg (salary) as 부서별평균 , dno 부서
from employee
group by dno;

select ename , salary dno
from employee
order by dno asc;

-- 부서별로 월급의 합계 평균 최대월급 그룹핑된수를 출력
select dno 부서번호, sum(salary) 월급의합 ,trunc(avg(salary)) 월급의평균 , max(salary) 최대월급 , count(salary) 그룹핑된수
from employee
group by dno
order by dno asc;

select ename , job , salary
from employee;

-- 직급별로 월급의 합계 평균 최대값 최소값 그룹핑된수
select sum(salary) , round(avg(salary)), max(salary) , min(salary) ,job,count(job)
from employee
group by job;

/*
group by에서 
where 절 : <조건> : group by 전에 조건을 처리해서 나온 결과만 group by
having 절 : <조건> : group by 한 결과에 대한 조건 처리 ,별칭이름을 사용하면 안된다.
*/

-- 직급별로 월급의 평균, 합계 , 최대값 , 최소값을 출력하되 20부서 제외 , 평균이 2000이상인 것만 출력
select sum(salary), round (avg(salary)) 평균 , max(salary) ,min(salary) ,count(*) ,job 부서
from employee
where dno not in(20)
group by job
having round (avg(salary)) >= 2000
order by 평균 desc;

-- 두 컬럼이상을 그룹핑 가능하다 -> 두 컬럼 모두가 동일 할떄 그룹핑 가능
select dno , job 
from employee
order by dno , job;

-- 부서번호와 직책컬럼 모두를 그룹핑해서 월급의 합계 , 평균 , 최대값 ,최소값 , 그룹핑된수
select sum(salary), round(avg(salary)) , max (salary) , min(salary) , count(*) 그룹핑된수
from employee
group by dno ,job
order by 그룹핑된수 desc;

--각 직책에 대해서 월급의 합계,평균 최대값 최소값 출력하되 81년도 입사,월급의 평균이 1500만원 이상인것만 출력하고 월급으 내림차순
select sum(salary) ,round( avg(salary)) 평균 , max(salary) , min(salary) ,job ,count(*)
from employee
where hiredate like '81%'
group by job
having round( avg(salary)) > 1500
order by 평균 desc;


-- rollup : 그룹핑 한 결과 마지막 라인에 전체 결과를 출력 
-- cube : 각 그룹핑의 마지막 라인에 결과를 출력 , 제일 마지막 라인에 전체 결과도 함께 출력

-- rollup , cube 를 사용하지 않는 그룹핑 쿼리
select sum(salary) ,round( avg(salary)) , max(salary) , min(salary) , dno , count(*)
from employee
group by dno
order by dno asc;

--rollup 사용 : rollup() -> 전체 결과값을 출력해줌
select sum(salary) ,round( avg(salary)) , max(salary) , min(salary) , dno , count(*)
from employee
group by rollup (dno)
order by dno asc;

-- cube 사용 : 
select sum(salary) ,round( avg(salary)) , max(salary) , min(salary) , dno , count(*)
from employee
group by cube (dno)
order by dno asc;

/*
SubQuery (서브쿼리) : select 내부의 select구문 -> 여러번 작업을 하나의 쿼리에서 실행
 where 절에서 많이 사용
*/

-- ename : SCOTT 인 사원과 동일한 직책의 사원들을 출력
    -- 1.ename 이 SCOTT인 사원의 직책을 가져오는 쿼리
    -- 2.직책을 조건으로 해서 사원을 알아와야하는 쿼리
select * from employee ;

select job
from employee
where ename = 'SCOTT';

select ename 
from employee 
where job = 'ANALYST';

-- SubQuery를 사용해서 출력
select ename , salary , job
from employee
where job = (select job from employee where ename = 'SCOTT');

-- SMITH와 동일한 부서를 가진 사원들을 출력
select ename
from employee
where dno =(select dno from employee where ename = 'SMITH');

-- "SCOTT'의 월급보다 많은 사원 정보 출력하기
select ename
from employee
where salary > (select salary from employee where ename = 'SCOTT');

-- 최소급여를 받는 사원의 이름과 담당업무 급여 출력
select ename 이름 , job 직무 , salary 급여
from employee
where salary = (select min(salary) from employee );

-- 단일값이 아니라 여러개의 값을 처리할때 in 키워드 사용

-- 부서별로 최소 급여를 받는 사람 , 직책 , 급여를 출력
select ename 사원이름 , job 직책 , salary 급여 , dno 부서
from employee
where salary in (select min(salary) from employee group by dno)

-- 각 부서의 최소급여가 30번 부서의 최소 급여보다 큰 부서를 출력
select min(salary) 최소급여 , dno 부서번호 , count(*)
from employee
group by dno -- 각 부서의 최소 급여 = a
having min(salary) > ( select min(salary) from employee where dno = 30 );   -- 30번부서의 최소급여보다 급여가 큰 부서 출력 


/*
ANY 연산자 : 서브쿼리가 반환하는 각각의 값과 비교함
 -- >any : 최대값보다 작음을 나타냄
 -- <any : 최소값보다 큰것을 나타냄
 -- =any : in 과 동일한 키워드
 
ALL 연산자 : 서브쿼리에서 반환되는 모든 값을 비교함
    -- <all : 최소값보다 작음을 나타냄
    -- >all : 최대값보다 큼을 나타냄    
*/

-- 직급이 salesman이 아니면서 직급이 salesman보다 급여가 적은 사원들을 모두 출력
-- != , <> 같은 연산자
select * from employee order by job asc;

select ename , job , salary
from employee
where salary < all (select salary from employee where job = 'SALESMAN' )
    and job != 'SALESMAN';

select ename , job , salary
from employee
where salary <  (select min(salary) from employee where job = 'SALESMAN' )
    and job != 'SALESMAN';    
    
-- 담당업무 분석가인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 출력
select ename , job , salary
from employee
where salary < all ( select salary from employee where job = 'ANALYST')
    and job !=  'ANALYST'
    
    =====================================================================  
-- 1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 
select *
from employee;

select ename , substr (hiredate,1,5)
from employee

-- 2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오.
select ename , substr (hiredate ,1,5)=
from employee

-- 3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
select ename 
from employee
where MOD (MANAGER ,2) = 1; 

-- 4. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.
select ename , salary
from employee
where mod(salary , 3) = 0;

-- 5. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오. 
select to_char(hiredate,'yy/mm/dd-dy')
from employee;

-- 6. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여 데이터 형식을 일치 시키시오.
select trunc (sysdate - 1 - to_date('23/01/01' , 'yy/mm/dd')) 
from dual;

-- 7. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
select trunc (sysdate - to_date ('1995/11/22','yyyy/mm/dd') )
from dual;

-- 8. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요.
select trunc( sysdate - to_date ('1995/11/22' , 'yyyy/mm/dd') ) as "살아온 일수",
    trunc (months_between (sysdate , to_date ('1995/11/21', 'yyyy/mm/dd')) ) as "살아온 개월수"
    from dual;

-- 9. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오.
select ename , eno ,NVL (MANAGER,0)
from employee;

/* 10.   사원번호,
      [사원번호 2자리만출력 나머지는 *가림 ] as "가린번호", 
      이름, 
       [이름의 첫자만 출력 총 네자리, 세자리는 * 가림] as "가린이름"    */

select RPAD ( substr(ENO ,1,2) , length(eno) ,'*' ) as 가린번호 , RPAD ( substr(ENAME ,1,1) , 4 ,'*' ) as 가린이름      
from employee;
       
-- 11.  주민번호:   를 출력하되 801210-1*******   출력 하도록 , 전화 번호 : 010-12*******
	-- dual 테이블 사용
 select RPAD( substr ('801210-1234567',1,8) , length('801210-1234567'),'*') 주민번호,
        RPAD( substr ('010-1234-5678',1,6) , length('010-1234-5678'),'*') 전화번호
from dual;
    
=============================================================================
--모든 평균은 소숫점 2자리까지 출력하되 반올림 해서 출력 하시오.  
-- 1.  10 번 부서를 제외하고 각 부서별 월급의 합계와 평균과 최대값, 최소값을 구하시오. 
select *
from employee;

select sum(salary), round( avg(salary),2) , min(salary) , max(salary) , dno
from employee
where dno !=30
group by dno;

*-- 2.  직책의 SALSMAN, PRESIDENT, CLERK 을 제외한 각 부서별 월급의 합계와 평균과 최대값, 최소값을 구하시오.  
select sum(salary), round( avg(salary),2) , min(salary) , max(salary) , job 직책 , dno 부서번호
from employee
where job != 'SALESMAN' , 'PRESIDENT', 'CLERK' 
group by dno;

-- 3. SMITH 과 동일한 부서에 근무하는 사원들 의 월급의 합계와 평균과 최대값, 최소값을 구하시오. 
select sum(salary) , round (avg (salary),2) , min(salary) , max(salary) ,dno
from employee
where dno = 20
group by dno;

-- 4. 부서별 최소월급을 가져오되 최소월급이 1000 이상인 것만 출력하세요. 
select min(salary) 최소월급 , dno
from employee
group by dno 
having  min(salary)>=1000;
-- 5.  부서별 월급의 합계가 9000 이상것만 출력
select sum(salary)부서월급총합 ,dno
from employee
group by dno
having sum(salary)>=9000;

-- 6.  부서별 월급의 평균이 2000 이상만 출력
select round (avg (salary) , 2) 부서평균월급 , dno
from employee
group by dno
having  round (avg (salary) , 2) >=2000;
-- 7. 월급이 1500 이하는 제외하고 각 부서별로 월급의 평균을 구하되 월급의 평균이 2500이상인 것만 출력 하라. 
select  round (avg (salary) , 2) , dno
from employee
where salary >1500
group by dno
having  round (avg (salary) , 2) >=2500
-- 8. sub query - 부서별로 최소 급여를 받는 사용자의 이름과 급여와 직책과 부서번호를 출력하세요. 
select ename , salary , job , dno
from employee
where salary in (select min(salary) from employee group by dno )

-- 9. sub query - 전체 평균 급여보다 많이 받는 사용자의  이름과 급여와 직책과 부서번호를 출력하세요. 
select ename , salary , job , dno 
from employee
where salary >= (select round (avg (salary),2) from employee)

-- 10. sub query - 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해 오름차순 정렬하시오. 
select ename , eno , salary
from employee
where salary >= (select round (avg (salary),2) from employee )
order by salary asc;

