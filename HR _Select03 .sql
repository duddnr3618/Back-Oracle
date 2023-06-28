/*
DAY : ����(������,ȭ����...)
DY : ���� (��,ȭ ...)
HH : �ð�
MI : ��  
SS : ��
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

/*TO_CHAR : ��¥ , ���� -> ���������� ��ȯ
    0 : �ڸ����� ó���� , �ڸ����� ���� ������ 0���� ó����
    9 : �ڸ����� ó���� , �ڸ����� ���� ������ �������� ó����
    L : �� ������ ��ȭ�� ��ȣ�� ǥ��
    . : �Ҽ��� ó��
    , : õ���� ������
*/

desc employee;

select ename, salary , to_char(salary , 'L999,999') , to_char (salary ,'L000,000')
from employee;

--TO_CHAR (��ȯ�ҹ���[����] ,YYYYMMDD)

select TO_DATE(20230628,'YYYYMMDD'),TO_DATE ('06282023' , 'MMDDYYYY')
from dual;

select to_date ('2001-10-30' , 'yyyy-mm-dd')
from dual;

-- �¾ ������ ���ñ��� ���� ��������
select TRUNC (sysdate - to_date ('1981-04-15' , 'yyyy-mm-dd') ) -- �ش� ��¥���� ������� �ϼ�
from dual;

select to_date ('12/06/22' , 'MM/DD/YY') - to_date ('1900-10-17' , 'yyyy/mm/dd')
from dual;

select trunc( sysdate - to_date ('1981/01/01' , 'yyyy/mm/dd') ) as "��ƿ� �ϼ�",
    trunc (months_between (sysdate , to_date ('1981/01/01', 'yyyy/mm/dd')) ) as "��ƿ� ������"
    from dual;
    
-- employee ���̺��� �� ����� �Ի��Ͽ��� 2030/01/01 ���� �ٹ� ������ 
select * from employee;

select ename ,hiredate , 
trunc ( months_between( to_Date ('2030/01/01' , 'yyyy/mm/dd') , hiredate) ) as "Ư����¥���� ������"
from employee;

/*
null ó�� �Լ�
 NVL (�÷� ,�� ) : �÷��� null�� �����ϴ°�� ������ ��ü
 NVL2 (�÷��� ,null�� �ƴҰ�� ó�� , null�� ��� ó��)
*/

select *
from employee;

--NVL �Լ��� ����ؼ� ó�� -> ������ ����
select ename ����̸�, salary ����,commission ���ʽ�,salary*12+NVL(commission,0) ����
from employee;

--NVL2 �Լ��� ����ؼ� ó��
select ename , salary , commission,
    salary*12+NVL2(commission,commission,0) �ѿ���
from employee;

/*
�׷��Լ� : group by , Ư���÷��� �׷����ؼ� ó��
*/

select �÷���
from ���̺��̸�[��]
where ����
group by �÷���[�׷������÷���]
having ���� {�׷����� ����� ����}
order by �������÷���

/*
�����Լ� : SUM , AVG , MAX , MIN m COUNT -> null�� �ڵ����� ó���ؼ� �۵���
    -sum : �÷��� ��� ���� ���ϴ� �Լ�
    -avg : �÷��� ��� ���� ����� ���ϴ� �Լ�
    -max : �÷��� ��簪�� �ִ밪�� �������� �Լ�
    -min : �÷��� ��簪�� �ּҰ��� �������� �Լ�
    -count : ���ڵ� �� ,�׷��ε� ����
*/

select commission from employee;

select sum(commission) as �հ� , avg (commission)as ��� , max(commission) �ִ밪 , min(commission) �ּڰ�
from employee;


-- �μ��� ������ �հ�,���,�ִ�,�ּ�,�׷��ε� ����
select *
from employee;

select sum (salary) as �μ����հ� , dno  �μ�,  -- �μ����� ��� �� �ν����� ���� 
count (dno) �׷��εȰ���
from employee                                -- dno : �μ���ȣ�� ������ ���� �׷��ؼ� ó����
group by dno;

select avg (salary) as �μ������ , dno �μ�
from employee
group by dno;

select ename , salary dno
from employee
order by dno asc;

-- �μ����� ������ �հ� ��� �ִ���� �׷��εȼ��� ���
select dno �μ���ȣ, sum(salary) �������� ,trunc(avg(salary)) ��������� , max(salary) �ִ���� , count(salary) �׷��εȼ�
from employee
group by dno
order by dno asc;

select ename , job , salary
from employee;

-- ���޺��� ������ �հ� ��� �ִ밪 �ּҰ� �׷��εȼ�
select sum(salary) , round(avg(salary)), max(salary) , min(salary) ,job,count(job)
from employee
group by job;

/*
group by���� 
where �� : <����> : group by ���� ������ ó���ؼ� ���� ����� group by
having �� : <����> : group by �� ����� ���� ���� ó�� ,��Ī�̸��� ����ϸ� �ȵȴ�.
*/

-- ���޺��� ������ ���, �հ� , �ִ밪 , �ּҰ��� ����ϵ� 20�μ� ���� , ����� 2000�̻��� �͸� ���
select sum(salary), round (avg(salary)) ��� , max(salary) ,min(salary) ,count(*) ,job �μ�
from employee
where dno not in(20)
group by job
having round (avg(salary)) >= 2000
order by ��� desc;

-- �� �÷��̻��� �׷��� �����ϴ� -> �� �÷� ��ΰ� ���� �ҋ� �׷��� ����
select dno , job 
from employee
order by dno , job;

-- �μ���ȣ�� ��å�÷� ��θ� �׷����ؼ� ������ �հ� , ��� , �ִ밪 ,�ּҰ� , �׷��εȼ�
select sum(salary), round(avg(salary)) , max (salary) , min(salary) , count(*) �׷��εȼ�
from employee
group by dno ,job
order by �׷��εȼ� desc;

--�� ��å�� ���ؼ� ������ �հ�,��� �ִ밪 �ּҰ� ����ϵ� 81�⵵ �Ի�,������ ����� 1500���� �̻��ΰ͸� ����ϰ� ������ ��������
select sum(salary) ,round( avg(salary)) ��� , max(salary) , min(salary) ,job ,count(*)
from employee
where hiredate like '81%'
group by job
having round( avg(salary)) > 1500
order by ��� desc;


-- rollup : �׷��� �� ��� ������ ���ο� ��ü ����� ��� 
-- cube : �� �׷����� ������ ���ο� ����� ��� , ���� ������ ���ο� ��ü ����� �Բ� ���

-- rollup , cube �� ������� �ʴ� �׷��� ����
select sum(salary) ,round( avg(salary)) , max(salary) , min(salary) , dno , count(*)
from employee
group by dno
order by dno asc;

--rollup ��� : rollup() -> ��ü ������� �������
select sum(salary) ,round( avg(salary)) , max(salary) , min(salary) , dno , count(*)
from employee
group by rollup (dno)
order by dno asc;

-- cube ��� : 
select sum(salary) ,round( avg(salary)) , max(salary) , min(salary) , dno , count(*)
from employee
group by cube (dno)
order by dno asc;

/*
SubQuery (��������) : select ������ select���� -> ������ �۾��� �ϳ��� �������� ����
 where ������ ���� ���
*/

-- ename : SCOTT �� ����� ������ ��å�� ������� ���
    -- 1.ename �� SCOTT�� ����� ��å�� �������� ����
    -- 2.��å�� �������� �ؼ� ����� �˾ƿ;��ϴ� ����
select * from employee ;

select job
from employee
where ename = 'SCOTT';

select ename 
from employee 
where job = 'ANALYST';

-- SubQuery�� ����ؼ� ���
select ename , salary , job
from employee
where job = (select job from employee where ename = 'SCOTT');

-- SMITH�� ������ �μ��� ���� ������� ���
select ename
from employee
where dno =(select dno from employee where ename = 'SMITH');

-- "SCOTT'�� ���޺��� ���� ��� ���� ����ϱ�
select ename
from employee
where salary > (select salary from employee where ename = 'SCOTT');

-- �ּұ޿��� �޴� ����� �̸��� ������ �޿� ���
select ename �̸� , job ���� , salary �޿�
from employee
where salary = (select min(salary) from employee );

-- ���ϰ��� �ƴ϶� �������� ���� ó���Ҷ� in Ű���� ���

-- �μ����� �ּ� �޿��� �޴� ��� , ��å , �޿��� ���
select ename ����̸� , job ��å , salary �޿� , dno �μ�
from employee
where salary in (select min(salary) from employee group by dno)

-- �� �μ��� �ּұ޿��� 30�� �μ��� �ּ� �޿����� ū �μ��� ���
select min(salary) �ּұ޿� , dno �μ���ȣ , count(*)
from employee
group by dno -- �� �μ��� �ּ� �޿� = a
having min(salary) > ( select min(salary) from employee where dno = 30 );   -- 30���μ��� �ּұ޿����� �޿��� ū �μ� ��� 


/*
ANY ������ : ���������� ��ȯ�ϴ� ������ ���� ����
 -- >any : �ִ밪���� ������ ��Ÿ��
 -- <any : �ּҰ����� ū���� ��Ÿ��
 -- =any : in �� ������ Ű����
 
ALL ������ : ������������ ��ȯ�Ǵ� ��� ���� ����
    -- <all : �ּҰ����� ������ ��Ÿ��
    -- >all : �ִ밪���� ŭ�� ��Ÿ��    
*/

-- ������ salesman�� �ƴϸ鼭 ������ salesman���� �޿��� ���� ������� ��� ���
-- != , <> ���� ������
select * from employee order by job asc;

select ename , job , salary
from employee
where salary < all (select salary from employee where job = 'SALESMAN' )
    and job != 'SALESMAN';

select ename , job , salary
from employee
where salary <  (select min(salary) from employee where job = 'SALESMAN' )
    and job != 'SALESMAN';    
    
-- ������ �м����� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ���
select ename , job , salary
from employee
where salary < all ( select salary from employee where job = 'ANALYST')
    and job !=  'ANALYST'
    
    =====================================================================  
-- 1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�. 
select *
from employee;

select ename , substr (hiredate,1,5)
from employee

-- 2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�.
select ename , substr (hiredate ,1,5)=
from employee

-- 3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�. 
select ename 
from employee
where MOD (MANAGER ,2) = 1; 

-- 4. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
select ename , salary
from employee
where mod(salary , 3) = 0;

-- 5. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�. 
select to_char(hiredate,'yy/mm/dd-dy')
from employee;

-- 6. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ� ������ ������ ��ġ ��Ű�ÿ�.
select trunc (sysdate - 1 - to_date('23/01/01' , 'yy/mm/dd')) 
from dual;

-- 7. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 
select trunc (sysdate - to_date ('1995/11/22','yyyy/mm/dd') )
from dual;

-- 8. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���.
select trunc( sysdate - to_date ('1995/11/22' , 'yyyy/mm/dd') ) as "��ƿ� �ϼ�",
    trunc (months_between (sysdate , to_date ('1995/11/21', 'yyyy/mm/dd')) ) as "��ƿ� ������"
    from dual;

-- 9. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�.
select ename , eno ,NVL (MANAGER,0)
from employee;

/* 10.   �����ȣ,
      [�����ȣ 2�ڸ������ �������� *���� ] as "������ȣ", 
      �̸�, 
       [�̸��� ù�ڸ� ��� �� ���ڸ�, ���ڸ��� * ����] as "�����̸�"    */

select RPAD ( substr(ENO ,1,2) , length(eno) ,'*' ) as ������ȣ , RPAD ( substr(ENAME ,1,1) , 4 ,'*' ) as �����̸�      
from employee;
       
-- 11.  �ֹι�ȣ:   �� ����ϵ� 801210-1*******   ��� �ϵ��� , ��ȭ ��ȣ : 010-12*******
	-- dual ���̺� ���
 select RPAD( substr ('801210-1234567',1,8) , length('801210-1234567'),'*') �ֹι�ȣ,
        RPAD( substr ('010-1234-5678',1,6) , length('010-1234-5678'),'*') ��ȭ��ȣ
from dual;
    
=============================================================================
--��� ����� �Ҽ��� 2�ڸ����� ����ϵ� �ݿø� �ؼ� ��� �Ͻÿ�.  
-- 1.  10 �� �μ��� �����ϰ� �� �μ��� ������ �հ�� ��հ� �ִ밪, �ּҰ��� ���Ͻÿ�. 
select *
from employee;

select sum(salary), round( avg(salary),2) , min(salary) , max(salary) , dno
from employee
where dno !=30
group by dno;

*-- 2.  ��å�� SALSMAN, PRESIDENT, CLERK �� ������ �� �μ��� ������ �հ�� ��հ� �ִ밪, �ּҰ��� ���Ͻÿ�.  
select sum(salary), round( avg(salary),2) , min(salary) , max(salary) , job ��å , dno �μ���ȣ
from employee
where job != 'SALESMAN' , 'PRESIDENT', 'CLERK' 
group by dno;

-- 3. SMITH �� ������ �μ��� �ٹ��ϴ� ����� �� ������ �հ�� ��հ� �ִ밪, �ּҰ��� ���Ͻÿ�. 
select sum(salary) , round (avg (salary),2) , min(salary) , max(salary) ,dno
from employee
where dno = 20
group by dno;

-- 4. �μ��� �ּҿ����� �������� �ּҿ����� 1000 �̻��� �͸� ����ϼ���. 
select min(salary) �ּҿ��� , dno
from employee
group by dno 
having  min(salary)>=1000;
-- 5.  �μ��� ������ �հ谡 9000 �̻�͸� ���
select sum(salary)�μ��������� ,dno
from employee
group by dno
having sum(salary)>=9000;

-- 6.  �μ��� ������ ����� 2000 �̻� ���
select round (avg (salary) , 2) �μ���տ��� , dno
from employee
group by dno
having  round (avg (salary) , 2) >=2000;
-- 7. ������ 1500 ���ϴ� �����ϰ� �� �μ����� ������ ����� ���ϵ� ������ ����� 2500�̻��� �͸� ��� �϶�. 
select  round (avg (salary) , 2) , dno
from employee
where salary >1500
group by dno
having  round (avg (salary) , 2) >=2500
-- 8. sub query - �μ����� �ּ� �޿��� �޴� ������� �̸��� �޿��� ��å�� �μ���ȣ�� ����ϼ���. 
select ename , salary , job , dno
from employee
where salary in (select min(salary) from employee group by dno )

-- 9. sub query - ��ü ��� �޿����� ���� �޴� �������  �̸��� �޿��� ��å�� �μ���ȣ�� ����ϼ���. 
select ename , salary , job , dno 
from employee
where salary >= (select round (avg (salary),2) from employee)

-- 10. sub query - �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���� �������� �����Ͻÿ�. 
select ename , eno , salary
from employee
where salary >= (select round (avg (salary),2) from employee )
order by salary asc;

