-- �θ����̺��� �ٸ� ���̺��� �����ϱ� ������ ������ �Ұ��� : cascade constraints
/*drop table Members cascade constraints;
drop table Addresses cascade constraints;
drop table Products cascade constraints;
drop table Orders cascade constraints;
*/

/*
int : 4byte -> number (4)
-number : oracle ����,�Ǽ�
number (4) : ���� 4�ڸ��� �Է�
number 
*/
-- Members ���̺� ȸ������
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    Email VARCHAR2(100),
    PhoneNumber VARCHAR2(20)
);

-- Addresses ���̺�
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

-- Products ���̺�
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR2(100),
    Price NUMBER(10, 2),
    Description VARCHAR2(500)
);

-- Orders ���̺�
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    MemberID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
-- Members ���̺� ���ڵ� 5�� ����
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

-- Addresses ���̺� ���ڵ� 5�� ����
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

-- Products ���̺� ���ڵ� 5�� ����
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

-- Orders ���̺� ���ڵ� 5�� ����
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

-- �� ���̺� select�� ����ؼ� ����� ���ڵ� Ȯ��
select * from members;
select * from addresses;
select * from products;
select * from orders;

-- �� ���̺� ���� 
-- 1.�� ȸ���� �̸��� �����ּ� , �ּ������� ��� ( EQUI JOIN , ANSI JOIN)
select firstname , email , city
from members m ,addresses a
where m.memberid = a.memberid
and firstname like 'J%';

select firstname , email , city
from members m inner  join addresses a
on m.memberid = a.memberid;
where FirstName like 'J%';

-- 2�� ���̺� ����
-- orders , members ���̺� ������ join �������� ���
-- ��ǰ�� ������ ������ 3�� �̻� ������ ����ڰ� �������� Ȯ��
select * from orders;

select firstname , phonenumber , quantity
from orders o , members m
where o.memberid = m.memberid
and quantity > = 3;

select firstname , phonenumber , quantity
from orders o join members m
on o.memberid = m.memberid
where quantity > = 3;

-- �ΰ����̺� join : orders ,  products
-- ������ ��ǰ�� ��ǰ�� , ���� ,������ ������ ���
select * from orders;
select * from products;

select  productname ,price , quantity , orderdate
from orders o , products p
where o.productid = p.productid;

select  productname ,price , quantity , orderdate
from orders o join products p
on o.productid = p.productid;

-- Outer join : 
    -- Left outer join : ���� ���̺��� ��� ���
    -- Right outer join : ������ ���̺��� ��� ���
    -- Full outer join : ����, ������ ��ü ���
    
-- out join �� ����ؼ� ���� (orders)���� �ʴ� ��ǰ�� �������� Ȯ��
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
3�� �̻� ���̺� ����
--EQUI JOIN 
select �÷���
from ���̺�1 , ���̺�2 , ���̺� 3, .....
where ���� Ű�÷�1 = ����Ű�÷�2
    and ���� Ű�÷� 2 = ����Ű�÷�3
    and ����Ű�÷�3 = ����Ű�÷�4
and ���� ó��
order by ����

--ANSI JOIN
select �÷���
from ���̺�1 a join ���̺�2 b
on a.����Ű�÷� = b.����Ű�÷�
join ���̺�3 c 
on b.����Ű�÷� = c.����Ű�÷�
join ���̺�4 d 
on c.����Ű�÷� = d.����Ű�÷�
...
where ����ó��
order by �����÷�
*/

-- �ֹ��� ����� �̸� , �����ּ� ,���ּ� , ��������ǰ ,����, ���Ű��� , ��¥�� ���
select * from orders;
select * from products;
select * from members;
select * from addresses;

-- īŸ���þ� ��
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
