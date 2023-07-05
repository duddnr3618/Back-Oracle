CREATE TABLE "Members" (
	"MemberID"	int		NOT NULL,
	"FirstName"	varchar2(50)		NULL,
	"LastName"	varchar2(50)		NULL,
	"Email"	varchar2(100)		NULL,
	"PhoneNumber"	varchar2(20)		NULL
);

CREATE TABLE "Addresses" (
	"AddressID"	int		NOT NULL,
	"MemberID"	int		NOT NULL,
	"AddressLine1"	varchar2(100)		NULL,
	"AddressLine2"	varchar2(100)		NULL,
	"City"	varchar2(50)		NULL,
	"Zipcode"	varchar2(20)		NULL
);

CREATE TABLE "Products" (
	"ProductID"	int		NOT NULL,
	"ProductName"	varchar2(100)		NULL,
	"Price"	Number(10,2)		NULL,
	"Description"	varchar2(500)		NULL
);

CREATE TABLE "Orders" (
	"OrderID"	int		NOT NULL,
	"MemberID"	int		NOT NULL,
	"ProductID"	int		NOT NULL,
	"OrderDate"	Date		NULL,
	"Quantity"	int		NULL
);

ALTER TABLE "Members" ADD CONSTRAINT "PK_MEMBERS" PRIMARY KEY (
	"MemberID"
);

ALTER TABLE "Addresses" ADD CONSTRAINT "PK_ADDRESSES" PRIMARY KEY (
	"AddressID",
	"MemberID"
);

ALTER TABLE "Products" ADD CONSTRAINT "PK_PRODUCTS" PRIMARY KEY (
	"ProductID"
);

ALTER TABLE "Orders" ADD CONSTRAINT "PK_ORDERS" PRIMARY KEY (
	"OrderID",
	"MemberID",
	"ProductID"
);

ALTER TABLE "Addresses" ADD CONSTRAINT "FK_Members_TO_Addresses_1" FOREIGN KEY (
	"MemberID"
)
REFERENCES "Members" (
	"MemberID"
);

ALTER TABLE "Orders" ADD CONSTRAINT "FK_Members_TO_Orders_1" FOREIGN KEY (
	"MemberID"
)
REFERENCES "Members" (
	"MemberID"
);

ALTER TABLE "Orders" ADD CONSTRAINT "FK_Products_TO_Orders_1" FOREIGN KEY (
	"ProductID"
)
REFERENCES "Products" (
	"ProductID"
);

