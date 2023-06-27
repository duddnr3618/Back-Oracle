/*
select 2 
함수 사용 하기
오라클에서 제공해 주는 다양한 기본 제공된 함수
1.문자 처리 함수
2.숫자 처리 함수
3.날짜 처리 함수
4.변환 함수
5.일반 함수
*/

/*
1.문자 함수 
UPPER : 대문자로 변환해주는 함수
LOWER : 소문자로 변환해주는 함수
INITCAP : 첫 글자만 대문자로 변환해주는 함수
*/
--dual : 가상의 테이블 ->  단일 함수를 처리하기 위해서 만든 테이블
select UPPER ('Oracle mania') as 대문자
from dual;

select LOWER ('Oracle mania') as 소문자
from dual;

select INITCAP ('oracle mania') as 첫글자만대문자
from dual;

select ename as "이름(원본)",LOWER (ename) as 소문자 , INITCAP(ename) as 첫글자만대문자 
--가로(특수문자)는 "" 으로 묶어줘야한다. 
from employee;

select * 
from employee
where ename = UPPER('ward');

/*
문자의 길이 처리하는 함수
LENGTH : 글자 수를 반환 (한글 -> 1byte)
LENGTHB : 글자 수를 반환 (한글 -> 3byte)
*/

--글자수를 리턴
-- LENGTH
select LENGTH ('Oracle maina')as 글자수
from dual;
select LENGTH ('오라클 매니아') as 글자수
from dual;

--LENGTHB
select LENGTHB ('Oracle maina')as 글자수
from dual;
select LENGTHB ('오라클 매니아') as 글자수
from dual;


/*
char (6) : 영문6자 , 한글 2자 -> 1자당 3byte로 처리 / 글자의 자릿수가 지정된 경우(주민번호 , 전화번호)
varchar2(6) : 영문6자 , 한글 2자 -> 1자당 3byte로 처리 / 글자의 자릿수를 알수 없는경우
nchar (6) : 유니코드(3byte) : 한글,일본어,중국어 -> 6자 입력가능 / 영문 18자(아스키코드)
nvarchar2 (6) : 유니코드(3byte) : 한글,일본어,중국어 -> 6자 입력가능 / 영문 18자(아스키코드)
*/
--Test01 테이블 생성
create table test01 (
    name1 char(6) not null ,
    name2 varchar2(6) null,
    name3 nchar(6) null,
    name4 nvarchar2(6) null
);

desc test01;

--test01 : 테이블에 값 넣기
--name1 ,name2 : 영문6자 한글 2자
--name3 , name4 : 영문6자 , 한글6자
select LENGTH ('qwertyusdfghjk')as 글자수
from dual;
insert into test01 (name1,name2,name3,name4)
values ('abcdef','qwerty','qweajk','가나다라마바');

select * from test01;

--실제 테이블의 글자수 불러오기
select * from employee ;
select ename , length(ename) as  이름의글자수
from employee;

/*
CONCAT : 문자열을 연결 시켜주는 함수
SUBSTR : 문자를 잘라내는 함수 , 한글 1자를 1byte로 처리
SUBSTRB : 문자를 잘라내는 함수 , 한글 1자를 3byte로 처리
INSTR : 특정 문자의 위치값을 반환 , 한글 1자를 1byte로 처리
INSTRB : 특정 문자의 위치값을 반환 , 한글(유니코드) 1자를 3byte로 처리
LPAD : 글자수를 입력받고 나머지는 특정기호로 채움(왼쪽)
RPAD : 글자수를 입력받고 나머지는 특정기호로 채움(오른쪽)
TRIM : 공백을 제거하는 함수( 앞뒤 공백 제거)
RTRIM (오른쪽 공백 제거) / LTRIM(왼쪽 공백제거)
*/

select 'Oracle', 'maina',
    concat ('Oracle',+'maina')
from dual;

select * 
from employee 

select ename 이름 , job 직책 , concat(ename,job) 컬럼연결
from employee ;

--substr : 문자열을 잘라오는 함수 : substr (컬럼, 4,3) -> 컬럼의 4번째 자리에서 3자를 잘라와서 출력
select substr('Oracle maina',4,3) 
from dual;

select substr('오라클 매니아',4,3) 
from dual;

--실제 테이블에서 사용
select hiredate , substr(hiredate, 1 , 2) 연도출력 , substr(hiredate,4,2) 월출력
, substr (hiredate, 7,2 ) 일출력
from employee;

--INSTR : 특정 문자의 위치를 출력
select instr ('Oracle maina','a')
from dual;

--4번째 자리 이후부터 검색 
select instr ('Oracle maina','a',4)
from dual;

--사원 이름 컬럼에 'K' 글자가 들어간 자릴수를 검색 : 검색이 되지 않는경우 : 0
select ename , instr(ename , 'K')
from employee;

--LPAD : LPAD(컬럼,자릴수늘림,'*') - > 특수문자를 왼쪽에 출력
select salary , LPAD(salary,10,'*')
from employee;

--RPAD : RPAD(컬럼,자릴수늘림,'*') - > 특수문자를 오른쪽에 출력
select salary , RPAD(salary,10,'*')
from employee;

--주민번호 : 230627-1234567 : 전체 14자리(-포함)
--substr을 사용해서 잘라내고 RPAD를 사용해서 *로 처리
select '230627-1234567' 주민번호 , RPAD( substr('230627-1234567',1,8),
length('230627-1234567'),'*') 주민번호2
from dual;

-- 이름 ,입사일을 출력시 일은 *로 출력
select * 
from employee;
select ename 이름 , RPAD(substr(hiredate,1,6),length(hiredate),'*') 입사일자
from employee;

select '     Oracle maina      'as 원본,
RTRIM ('     Oracle maina      ') as 오른쪽공백제거,
LTRIM ('     Oracle maina      ') as 왼쪽공백제거,
TRIM('     Oracle maina      ')as 앞뒤공백제거
from dual;

--ROUND (대상,소숫점자리수)
-- 양수일떄 : 소숫점 기준으로 오른쪽으로 이동해서 반올림 , 그 자릿수 뒤에서 반올림
-- 음수일떄 : 소숫점 기준으로 왼쪽으로 이동해서 반올림 , 그자리에서 반올림됨
-- TRUNC : 특정 자릿수에서 잘라서 버림
-- MOD : 나머지 값만 반환
select 98.7654 as 원본,   --99
round (98.7654,2),       --98.77 소숫점 오른쪽으로 2자리 이동후 그뒤에서 반올림
round (98.7654,-1),     -- 100 소숫점 왼쪽으로 1자리 이동후 그 자리에서 반올림
round (98.7654 ,-2),       -- 100
round (98.7654,-3)         --0
from dual;

select ROUND(1234/34,2)
from dual;

--월 근로소득세를 출력 : 월급 * 0.033
select salary , salary*0.033 as 근로소득세
from employee;

--TRUNC : 특정 자리에서 버림
select trunc(12.3456),       --소수점 뒤는 모두 버림
    trunc(12.3456 , 2),      --소수점 2자리까지만 출력
    trunc(12.3456 , -1)     --소수점 왼쪽으로 1자리 이동후 버림
from dual;

--MOD (대상 , 나누는 수) : 대상을 나누는 수로 나누어서 나머지만 출력
select MOD (31,2)
from dual;

select round (31/2,3) as 몫만출력 , MOD (31,2) as 나머지만출력
from dual;

-- 1. 덧셈 연산자를 사용하여 모든 사원에 대해서 $300의 급여 인상을 계산한후 사원이름, 급여, 인상된 급여를 출력하세요. 
select *
from employee;

select ename 사원이름, salary 월급 , salary+300 인상된급여
from employee;

-- 2. 사원의 이름, 급여, 연간 총 수입이 많은것 부터 작은순으로 출력 하시오.  
-- 연간 총 수입은 월급에 12를 곱한후 $100의 상여금을 더해서 계산 하시오. 
select *
from employee;

select ename 사원이름 , salary 급여 , salary*12+100 연간수입
from employee
order by 연간수입 asc;

-- 3. 급여가 2000을 넘는 사원의 이름과 급여를 급여가 많은것 부터 작은순으로 출력하세요. 
select *
from employee;

select ename 사원이름 , salary 급여
from employee
where salary > 2000
order by 급여 desc;

-- 4. 사원번호가 7788인 사원의 이름과 부서번호를 출력하세요. 
select *
from employee;

select ename 사원이름 , dno 부서번호
from employee
where eno = 7788;

-- 5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력 하세요. 
select *
from employee;

select ename 사원 , salary 급여
from employee
where salary <2000 or salary > 3000

-- 6. 1981년 2월 20일부터 81년 5월 1일 사이의 입사한 사원의 이름 담당업무, 입사일을 출력하시오
select *
from employee;

select ename 사원이름 , job 직책 , hiredate 입사일
from employee
where hiredate >'81/02/20' and hiredate <'81/05/01'

-- 7. 부서번호가 20및 30에 속한 사원의 이름과 부서번호를 출력하되 이름을 기준(내림차순)으로 출력하시오. 
select *
from employee;

select ename 사원이름 , dno 부서번호 
from employee
where dno >= 20 and dno <=30 
order by 사원이름 desc;

-- 8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 사원의 이름, 급여와 부서번호를 출력하되 이름을 오름차순으로 출력하세요. 
select *
from employee;

select ename 사원이름 , salary 급여 ,dno 부서번호
from employee
where salary >= 2000 and salary <=3000 and dno = 20 or dno =30
order by 사원이름 asc;

-- 9. 1981년도 입사한 사원의 이름과 입사일을 출력 하시오 ( like 연산자와 와일드 카드 사용 : _ , % )
select *
from employee;

select ename 사원이름 , hiredate 입사일 
from employee
where HIREDATE like '81%';

-- 10. 관리자가 없는 사원의 이름과 담당업무를 출력하세요.
select *
from employee;

select ename 사원이름 , job 직책
from employee
where MANAGER is null ;

-- 11. 커밋션을 받을 수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되 급여및 커밋션을 기준으로 내림차순 정렬하여 표시하시오.
select *
from employee;

select ename 사원이름 , salary 급여 , commission 보너스
from employee
where COMMISSION is not null
order by job , commission asc;  -- 두개 이상의 컬럼이 정렬될때 job컬럼을 정렬후 중복된 값에 대해서 commission 이 정렬됨

-- 12. 이름이 세번째 문자인 R인 사원의 이름을 표시하시오.
select *
from employee;

select ename 사원이름
from employee

13. 이름에 A 와 E 를 모두 포함하고 있는 사원의 이름을 표시하시오.
--14. 담당 업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이며서 
   -- 급여가 $1600, $950, 또는 $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오.
select *
from employee;

select ename 사원이름 , job 담당업무 , salary 급여
from employee
where salary != 950 or salary != 1600 or salary !=1300 and job = 'CLEAK' or job = 'SALESMAN'
    
-- 15. 커미션이 $500이상인 사원의 이름과 급여 및 커미션을 출력하시오.  
select *
from employee;

select ename 사원이름 , salary 급여 , commission 보너스
from employee
where commission >=500 

/*
SYSDATE : 현재 시스템의 날짜를 출력하는 함수
MONTHS_BETWEEN : 두 날짜 사이의 개월 수를 출력
ADD_MONTHS : 특정 날짜에 개월수를 더할떄 사용
NEXT_DAYS : 특정 날짜에서 초래하는 요일을 인자로 받아서 요일이 도래하는 날짜를 출력
LAST_DAY : 달의 마지막 날짜를 반환
ROUND : 날짜를 반올림 하는 함수 , 15일 이상 : 반올림 , 15미만 : 삭제
TRUNC : 날짜를 잘라내는 함수
*/

select sysdate
from dual;

select sysdate-1
from dual;