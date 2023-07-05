-- 부모테이블은 다른 테이블에서 참조하기 때문에 삭제가 불가능 : cascade constraints
/*drop table Members cascade constraints;
drop table Addresses cascade constraints;
drop table Products cascade constraints;
drop table Orders cascade constraints;
*/

/*
int : 4byte -> number (4)
-number : oracle 정수,실수
number (4) : 정수 4자리만 입력
number 
*/
-- Members 테이블 회원정보
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    Email VARCHAR2(100),
    PhoneNumber VARCHAR2(20)
);

-- Addresses 테이블
CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY,
    MemberID INT,
    AddressLine1 VARCHAR2(100),
    AddressLine2 VARCHAR2(100),
    City VARCHAR2(50),
    State VARCHAR2(50),
    ZipCode VARCHAR2(20),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Products 테이블
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR2(100),
    Price NUMBER(10, 2),
    Description VARCHAR2(500)
);

-- Orders 테이블
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    MemberID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
-- Members 테이블에 레코드 5개 삽입
INSERT INTO Members (MemberID, FirstName, LastName, Email, PhoneNumber)
VALUES (1, 'John', 'Doe', 'john.doe@example.com', '1234567890');

INSERT INTO Members (MemberID, FirstName, LastName, Email, PhoneNumber)
VALUES (2, 'Jane', 'Smith', 'jane.smith@example.com', '9876543210');

INSERT INTO Members (MemberID, FirstName, LastName, Email, PhoneNumber)
VALUES (3, 'David', 'Johnson', 'david.johnson@example.com', '5555555555');

INSERT INTO Members (MemberID, FirstName, LastName, Email, PhoneNumber)
VALUES (4, 'Sarah', 'Williams', 'sarah.williams@example.com', '9999999999');

INSERT INTO Members (MemberID, FirstName, LastName, Email, PhoneNumber)
VALUES (5, 'Michael', 'Brown', 'michael.brown@example.com', '1111111111');

-- Addresses 테이블에 레코드 5개 삽입
INSERT INTO Addresses (AddressID, MemberID, AddressLine1, AddressLine2, City, State, ZipCode)
VALUES (1, 1, '123 Main St', 'Apt 4B', 'New York', 'NY', '10001');

INSERT INTO Addresses (AddressID, MemberID, AddressLine1, City, State, ZipCode)
VALUES (2, 2, '456 Elm St', 'Los Angeles', 'CA', '90001');

INSERT INTO Addresses (AddressID, MemberID, AddressLine1, City, State, ZipCode)
VALUES (3, 3, '789 Oak Ave',  'Chicago', 'IL', '60601');

INSERT INTO Addresses (AddressID, MemberID, AddressLine1, AddressLine2, City, State, ZipCode)
VALUES (4, 4, '321 Pine St', 'Suite 10', 'Seattle', 'WA', '98101');

INSERT INTO Addresses (AddressID, MemberID, AddressLine1, City, State, ZipCode)
VALUES (5, 5, '555 Maple Dr', 'Dallas', 'TX', '75201');

-- Products 테이블에 레코드 5개 삽입
INSERT INTO Products (ProductID, ProductName, Price, Description)
VALUES (1, 'iPhone 12', 999.99, 'Latest iPhone model');

INSERT INTO Products (ProductID, ProductName, Price, Description)
VALUES (2, 'Samsung Galaxy S21', 899.99, 'Flagship Android smartphone');

INSERT INTO Products (ProductID, ProductName, Price, Description)
VALUES (3, 'MacBook Pro', 1999.99, 'Powerful laptop for professionals');

INSERT INTO Products (ProductID, ProductName, Price, Description)
VALUES (4, 'Sony PlayStation 5', 499.99, 'Next-gen gaming console');

INSERT INTO Products (ProductID, ProductName, Price, Description)
VALUES (5, 'Amazon Echo Dot', 49.99, 'Smart speaker with voice assistant');

-- Orders 테이블에 레코드 5개 삽입
INSERT INTO Orders (OrderID, MemberID, ProductID, OrderDate, Quantity)
VALUES (1, 1, 1, '23/01/01', 3);

INSERT INTO Orders (OrderID, MemberID, ProductID, OrderDate, Quantity)
VALUES (2, 2, 4, '23/02/01', 5);

INSERT INTO Orders (OrderID, MemberID, ProductID, OrderDate, Quantity)
VALUES (3, 5, 5, '23/03/13', 2);

INSERT INTO Orders (OrderID, MemberID, ProductID, OrderDate, Quantity)
VALUES (4, 3, 4, '23/05/1', 7);

INSERT INTO Orders (OrderID, MemberID, ProductID, OrderDate, Quantity)

commit;
VALUES (5, 3, 5, '23/01/01', 2);

-- 각 테이블 select를 사용해서 저장된 레코드 확인
select * from members;
select * from addresses;
select * from products;
select * from orders;

-- 각 테이블에 조인 
-- 1.각 회원의 이름과 메일주소 , 주소정보를 출력 ( EQUI JOIN , ANSI JOIN)
select firstname , email , city
from members m ,addresses a
where m.memberid = a.memberid
and firstname like 'J%';

select firstname , email , city
from members m inner  join addresses a
on m.memberid = a.memberid;
where FirstName like 'J%';

-- 2개 테이블 조인
-- orders , members 테이블 정보를 join 구문으로 출력
-- 제품을 구매한 수량이 3개 이상 구매한 사용자가 누구인지 확인
select * from orders;

select firstname , phonenumber , quantity
from orders o , members m
where o.memberid = m.memberid
and quantity > = 3;

select firstname , phonenumber , quantity
from orders o join members m
on o.memberid = m.memberid
where quantity > = 3;

-- 두개테이블 join : orders ,  products
-- 구매한 제품의 제품명 , 가격 ,구매한 수량을 출력
select * from orders;
select * from products;

select  productname ,price , quantity , orderdate
from orders o , products p
where o.productid = p.productid;

select  productname ,price , quantity , orderdate
from orders o join products p
on o.productid = p.productid;

-- Outer join : 
    -- Left outer join : 왼쪽 테이블은 모두 출력
    -- Right outer join : 오른쪽 테이블은 모두 출력
    -- Full outer join : 왼쪽, 오른쪽 전체 출력
    
-- out join 을 사용해서 구매 (orders)되지 않는 제품이 무엇인지 확인
select * from orders;

select o.productid, productname , price , quantity 
from orders o , products p
where  o.productid (+) = p.productid 
and quantity is null;

select o.productid, productname , price , quantity 
from orders o Right outer join products p
on o.productid = p.productid 
where quantity is null;

/*
3개 이상 테이블 조인
--EQUI JOIN 
select 컬럼명
from 테이블1 , 테이블2 , 테이블 3, .....
where 공통 키컬럼1 = 공통키컬럼2
    and 공통 키컬럼 2 = 공통키컬럼3
    and 공통키컬럼3 = 공통키컬럼4
and 조건 처리
order by 정렬

--ANSI JOIN
select 컬러명
from 테이블1 a join 테이블2 b
on a.공통키컬럼 = b.공통키컬럼
join 테이블3 c 
on b.공통키컬럼 = c.공통키컬럼
join 테이블4 d 
on c.공통키컬럼 = d.공통키컬럼
...
where 조건처리
order by 정렬컬럼
*/

-- 주문한 사용자 이름 , 메일주소 ,집주소 , 구매한제품 ,가격, 구매갯수 , 날짜를 출력
select * from orders;
select * from products;
select * from members;
select * from addresses;

-- 카타르시안 곱
select m.memberid , o.memberid , firstname,email ,city,productname , price , quantity , orderdate 
from  orders o , products p , members m , addresses a
where o.productid = p.productid
    and o.memberid = m.memberid
    and m.memberid = a.memberid


select * from orders;

-- ANSI JOIN
select m.memberid , o.memberid , firstname,email ,city,productname , price , quantity , orderdate 
from  orders o join products p 
    on o.productid = p.productid
    join members m 
    on o.memberid = m.memberid
    join addresses a
    on m.memberid = a.memberid
    
    commit;
