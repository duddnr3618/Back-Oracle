/*
select 2 
�Լ� ��� �ϱ�
����Ŭ���� ������ �ִ� �پ��� �⺻ ������ �Լ�
1.���� ó�� �Լ�
2.���� ó�� �Լ�
3.��¥ ó�� �Լ�
4.��ȯ �Լ�
5.�Ϲ� �Լ�
*/

/*
1.���� �Լ� 
UPPER : �빮�ڷ� ��ȯ���ִ� �Լ�
LOWER : �ҹ��ڷ� ��ȯ���ִ� �Լ�
INITCAP : ù ���ڸ� �빮�ڷ� ��ȯ���ִ� �Լ�
*/
--dual : ������ ���̺� ->  ���� �Լ��� ó���ϱ� ���ؼ� ���� ���̺�
select UPPER ('Oracle mania') as �빮��
from dual;

select LOWER ('Oracle mania') as �ҹ���
from dual;

select INITCAP ('oracle mania') as ù���ڸ��빮��
from dual;

select ename as "�̸�(����)",LOWER (ename) as �ҹ��� , INITCAP(ename) as ù���ڸ��빮�� 
--����(Ư������)�� "" ���� ��������Ѵ�. 
from employee;

select * 
from employee
where ename = UPPER('ward');

/*
������ ���� ó���ϴ� �Լ�
LENGTH : ���� ���� ��ȯ (�ѱ� -> 1byte)
LENGTHB : ���� ���� ��ȯ (�ѱ� -> 3byte)
*/

--���ڼ��� ����
-- LENGTH
select LENGTH ('Oracle maina')as ���ڼ�
from dual;
select LENGTH ('����Ŭ �ŴϾ�') as ���ڼ�
from dual;

--LENGTHB
select LENGTHB ('Oracle maina')as ���ڼ�
from dual;
select LENGTHB ('����Ŭ �ŴϾ�') as ���ڼ�
from dual;


/*
char (6) : ����6�� , �ѱ� 2�� -> 1�ڴ� 3byte�� ó�� / ������ �ڸ����� ������ ���(�ֹι�ȣ , ��ȭ��ȣ)
varchar2(6) : ����6�� , �ѱ� 2�� -> 1�ڴ� 3byte�� ó�� / ������ �ڸ����� �˼� ���°��
nchar (6) : �����ڵ�(3byte) : �ѱ�,�Ϻ���,�߱��� -> 6�� �Է°��� / ���� 18��(�ƽ�Ű�ڵ�)
nvarchar2 (6) : �����ڵ�(3byte) : �ѱ�,�Ϻ���,�߱��� -> 6�� �Է°��� / ���� 18��(�ƽ�Ű�ڵ�)
*/
--Test01 ���̺� ����
create table test01 (
    name1 char(6) not null ,
    name2 varchar2(6) null,
    name3 nchar(6) null,
    name4 nvarchar2(6) null
);

desc test01;

--test01 : ���̺��� �� �ֱ�
--name1 ,name2 : ����6�� �ѱ� 2��
--name3 , name4 : ����6�� , �ѱ�6��
select LENGTH ('qwertyusdfghjk')as ���ڼ�
from dual;
insert into test01 (name1,name2,name3,name4)
values ('abcdef','qwerty','qweajk','�����ٶ󸶹�');

select * from test01;

--���� ���̺��� ���ڼ� �ҷ�����
select * from employee ;
select ename , length(ename) as  �̸��Ǳ��ڼ�
from employee;

/*
CONCAT : ���ڿ��� ���� �����ִ� �Լ�
SUBSTR : ���ڸ� �߶󳻴� �Լ� , �ѱ� 1�ڸ� 1byte�� ó��
SUBSTRB : ���ڸ� �߶󳻴� �Լ� , �ѱ� 1�ڸ� 3byte�� ó��
INSTR : Ư�� ������ ��ġ���� ��ȯ , �ѱ� 1�ڸ� 1byte�� ó��
INSTRB : Ư�� ������ ��ġ���� ��ȯ , �ѱ�(�����ڵ�) 1�ڸ� 3byte�� ó��
LPAD : ���ڼ��� �Է¹ް� �������� Ư����ȣ�� ä��(����)
RPAD : ���ڼ��� �Է¹ް� �������� Ư����ȣ�� ä��(������)
TRIM : ������ �����ϴ� �Լ�( �յ� ���� ����)
RTRIM (������ ���� ����) / LTRIM(���� ��������)
*/

select 'Oracle', 'maina',
    concat ('Oracle',+'maina')
from dual;

select * 
from employee 

select ename �̸� , job ��å , concat(ename,job) �÷�����
from employee ;

--substr : ���ڿ��� �߶���� �Լ� : substr (�÷�, 4,3) -> �÷��� 4��° �ڸ����� 3�ڸ� �߶�ͼ� ���
select substr('Oracle maina',4,3) 
from dual;

select substr('����Ŭ �ŴϾ�',4,3) 
from dual;

--���� ���̺����� ���
select hiredate , substr(hiredate, 1 , 2) ������� , substr(hiredate,4,2) �����
, substr (hiredate, 7,2 ) �����
from employee;

--INSTR : Ư�� ������ ��ġ�� ���
select instr ('Oracle maina','a')
from dual;

--4��° �ڸ� ���ĺ��� �˻� 
select instr ('Oracle maina','a',4)
from dual;

--��� �̸� �÷��� 'K' ���ڰ� �� �ڸ����� �˻� : �˻��� ���� �ʴ°�� : 0
select ename , instr(ename , 'K')
from employee;

--LPAD : LPAD(�÷�,�ڸ����ø�,'*') - > Ư�����ڸ� ���ʿ� ���
select salary , LPAD(salary,10,'*')
from employee;

--RPAD : RPAD(�÷�,�ڸ����ø�,'*') - > Ư�����ڸ� �����ʿ� ���
select salary , RPAD(salary,10,'*')
from employee;

--�ֹι�ȣ : 230627-1234567 : ��ü 14�ڸ�(-����)
--substr�� ����ؼ� �߶󳻰� RPAD�� ����ؼ� *�� ó��
select '230627-1234567' �ֹι�ȣ , RPAD( substr('230627-1234567',1,8),
length('230627-1234567'),'*') �ֹι�ȣ2
from dual;

-- �̸� ,�Ի����� ��½� ���� *�� ���
select * 
from employee;
select ename �̸� , RPAD(substr(hiredate,1,6),length(hiredate),'*') �Ի�����
from employee;

select '     Oracle maina      'as ����,
RTRIM ('     Oracle maina      ') as �����ʰ�������,
LTRIM ('     Oracle maina      ') as ���ʰ�������,
TRIM('     Oracle maina      ')as �յڰ�������
from dual;

--ROUND (���,�Ҽ����ڸ���)
-- ����ϋ� : �Ҽ��� �������� ���������� �̵��ؼ� �ݿø� , �� �ڸ��� �ڿ��� �ݿø�
-- �����ϋ� : �Ҽ��� �������� �������� �̵��ؼ� �ݿø� , ���ڸ����� �ݿø���
-- TRUNC : Ư�� �ڸ������� �߶� ����
-- MOD : ������ ���� ��ȯ
select 98.7654 as ����,   --99
round (98.7654,2),       --98.77 �Ҽ��� ���������� 2�ڸ� �̵��� �׵ڿ��� �ݿø�
round (98.7654,-1),     -- 100 �Ҽ��� �������� 1�ڸ� �̵��� �� �ڸ����� �ݿø�
round (98.7654 ,-2),       -- 100
round (98.7654,-3)         --0
from dual;

select ROUND(1234/34,2)
from dual;

--�� �ٷμҵ漼�� ��� : ���� * 0.033
select salary , salary*0.033 as �ٷμҵ漼
from employee;

--TRUNC : Ư�� �ڸ����� ����
select trunc(12.3456),       --�Ҽ��� �ڴ� ��� ����
    trunc(12.3456 , 2),      --�Ҽ��� 2�ڸ������� ���
    trunc(12.3456 , -1)     --�Ҽ��� �������� 1�ڸ� �̵��� ����
from dual;

--MOD (��� , ������ ��) : ����� ������ ���� ����� �������� ���
select MOD (31,2)
from dual;

select round (31/2,3) as ����� , MOD (31,2) as �����������
from dual;

-- 1. ���� �����ڸ� ����Ͽ� ��� ����� ���ؼ� $300�� �޿� �λ��� ������� ����̸�, �޿�, �λ�� �޿��� ����ϼ���. 
select *
from employee;

select ename ����̸�, salary ���� , salary+300 �λ�ȱ޿�
from employee;

-- 2. ����� �̸�, �޿�, ���� �� ������ ������ ���� ���������� ��� �Ͻÿ�.  
-- ���� �� ������ ���޿� 12�� ������ $100�� �󿩱��� ���ؼ� ��� �Ͻÿ�. 
select *
from employee;

select ename ����̸� , salary �޿� , salary*12+100 ��������
from employee
order by �������� asc;

-- 3. �޿��� 2000�� �Ѵ� ����� �̸��� �޿��� �޿��� ������ ���� ���������� ����ϼ���. 
select *
from employee;

select ename ����̸� , salary �޿�
from employee
where salary > 2000
order by �޿� desc;

-- 4. �����ȣ�� 7788�� ����� �̸��� �μ���ȣ�� ����ϼ���. 
select *
from employee;

select ename ����̸� , dno �μ���ȣ
from employee
where eno = 7788;

-- 5. �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ��� �ϼ���. 
select *
from employee;

select ename ��� , salary �޿�
from employee
where salary not between 2000 and 3000;

-- 6. 1981�� 2�� 20�Ϻ��� 81�� 5�� 1�� ������ �Ի��� ����� �̸� ������, �Ի����� ����Ͻÿ�
select *
from employee;

select ename ����̸� , job ��å , hiredate �Ի���
from employee
where hiredate >'81/02/20' and hiredate <'81/05/01'

-- 7. �μ���ȣ�� 20�� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ� �̸��� ����(��������)���� ����Ͻÿ�. 
select *
from employee;

select ename ����̸� , dno �μ���ȣ 
from employee
where dno >= 20 and dno <=30 
order by ����̸� desc;

select ename , dno
from employee 
where dno in (20,30)
order by ename asc;

-- 8. ����� �޿��� 2000���� 3000���̿� ���Եǰ� �μ���ȣ�� 20 �Ǵ� 30�� ����� �̸�, �޿��� �μ���ȣ�� ����ϵ� �̸��� ������������ ����ϼ���. 
select *
from employee;

select ename ����̸� , salary �޿� ,dno �μ���ȣ
from employee
where( salary between 2000 and 3000) and (dno in(20,30) )
order by ����̸� asc;

-- 9. 1981�⵵ �Ի��� ����� �̸��� �Ի����� ��� �Ͻÿ� ( like �����ڿ� ���ϵ� ī�� ��� : _ , % )
select *
from employee;

select ename ����̸� , hiredate �Ի��� 
from employee
where HIREDATE like '81%';

-- 10. �����ڰ� ���� ����� �̸��� �������� ����ϼ���.
select *
from employee;

select ename ����̸� , job ��å
from employee , manager
where MANAGER is null ;

-- 11. Ŀ�Լ��� ���� �� �ִ� �ڰ��� �Ǵ� ����� �̸�, �޿�, Ŀ�̼��� ����ϵ� �޿��� Ŀ�Լ��� �������� �������� �����Ͽ� ǥ���Ͻÿ�.
select *
from employee;

select ename ����̸� , salary �޿� , commission ���ʽ�
from employee
where COMMISSION is not null
order by salary desc , commission desc;  -- �ΰ� �̻��� �÷��� ���ĵɶ� job�÷��� ������ �ߺ��� ���� ���ؼ� commission �� ���ĵ�

-- 12. �̸��� ����° ������ R�� ����� �̸��� ǥ���Ͻÿ�.
select *
from employee;

select ename ����̸�
from employee
where ename like '__R%';            -- _ _ �� �����

select ename
from employee
where instr (ename , 'R' ,3) = 3;
select ename ,instr (ename , 'R' ,3)
from employee;

-- 13. �̸��� A �� E �� ��� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�.
select *
from employee;

select ename 
from employee
where ename like '%A%' and ename like '%E%';

select ename 
from employee
where instr(ename ,'A') !=0 and instr(ename ,'E')!=0;

select 
from employee
--14. ��� ������ �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸缭 
   -- �޿��� $1600, $950, �Ǵ� $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�.
select *
from employee;

select ename ����̸� , job ������ , salary �޿�
from employee
where salary != 950 or salary != 1600 or salary !=1300 and job = 'CLEAK' or job = 'SALESMAN'

select ename , job , salary
from employee
where job in('CLEAK','SALESMAN') and salary not in (1600,950,1300);
-- 15. Ŀ�̼��� $500�̻��� ����� �̸��� �޿� �� Ŀ�̼��� ����Ͻÿ�.  
select *
from employee;

select ename ����̸� , salary �޿� , commission ���ʽ�
from employee
where commission >=500 

/*
SYSDATE : ���� �ý����� ��¥�� ����ϴ� �Լ�
MONTHS_BETWEEN : �� ��¥ ������ ���� ���� ���
ADD_MONTHS : Ư�� ��¥�� �������� ���ҋ� ���
NEXT_DAYS : Ư�� ��¥���� �ʷ��ϴ� ������ ���ڷ� �޾Ƽ� ������ �����ϴ� ��¥�� ���
LAST_DAY : ���� ������ ��¥�� ��ȯ
ROUND : ��¥�� �ݿø� �ϴ� �Լ� , 15�� �̻� : �ݿø� , 15�̸� : ����
TRUNC : ��¥�� �߶󳻴� �Լ�
*/

select sysdate
from dual;

select sysdate-1
from dual;

select sysdate -1 as ���� , sysdate ���� , sysdate+1 as ����
from dual;

-- �Ի��� ���� ���ó�¥���� ���� �ٹ� �ߴ��� ���
select ename �̸� , hiredate �Ի��� ,ROUND(sysdate - hiredate) �ٹ���
from employee;

-- �Ի��� ���� 1000�� ���� ������ ��¥�� ���
select ename �̸� , hiredate �Ի��� , hiredate + 1000 �Ի�1000�ϳ�¥
from employee;

-- Ư�� ��¥���� ���� �������� ���
select hiredate ���� , trunc(hiredate, 'MONTH') ,
ROUND (hiredate , 'MONTH')      --  15���̻���ʹ� �ݿø��Ǿ� ���
from employee;

-- �� ��¥������ �������� ��� : months_between
select ename ����̸� , hiredate �Ի��� , round(months_between (sysdate,hiredate))�Ѱ�����
from employee;

-- add_months (��¥,������) : ��¥�� �������� ���ϴ� �Լ�
select add_months (sysdate , 100) as "100������", sysdate + 100 as "100����"
from dual;

-- �Ի��� 6������ ���� ������ ���
select ename , hiredate , add_months(hiredate ,6) "�Ի���6��������"
from employee;

-- next_day : Ư����¥���� ������ ��ǲ���� �־ �� ��¥�� �����ϸ� ���
select next_day (sysdate , '�����')
from dual;

-- last_day(date) : �� ���� ������ ��¥�� ���
select sysdate as ���ó�¥ , last_day(sysdate)
from dual;

/*
���� ��ȯ �Լ�
TO_CHAR : ��¥ , �������� ���������� ��ȯ
TO_DATE : �������� ��¥������ ��ȯ
TO_NUMBER : �������� ���ڷ� ��ȯ
*/

--TO_CHAR(date,'YYYYMMDD') : ��¥������ 'YYYYMMDD'�������� �̾Ƽ� CHARŸ������ ��ȯ
select TO_CHAR (sysdate , 'YYYYMMDD')
from dual;