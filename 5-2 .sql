CREATE TABLE member (
    id VARCHAR2(20) NOT NULL CONSTRAINT PK_MEMBER_ID PRIMARY KEY,
    pwd VARCHAR2(20),
    name VARCHAR2(50),
    zipcode VARCHAR2(7),
    address VARCHAR2(20),
    tel VARCHAR2(13),
    indate DATE DEFAULT SYSDATE,
    CONSTRAINT FK_member_id_tb_zipcode FOREIGN KEY (zipcode) REFERENCES tb_zipcode(zipcode)
);


CREATE TABLE tb_zipcode (
    zipcode VARCHAR2(7) NOT NULL,
    sido VARCHAR2(30),
    gugum VARCHAR2(30),
    dong VARCHAR2(30),
    bungi VARCHAR2(30),
    CONSTRAINT PK_tb_zipcode PRIMARY KEY (zipcode)
);

create table products (
    product_code varchar2(20) not null constraint PK_products_product_code primary key,
    product_name varchar2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1),
    indate date 
    );

create table orders (
    o_seq number(10)not null constraint PK_orders_o_seq primary key,
    product_code varchar2(20) constraint FK_orders_produc_code_products references products(product_code),
    id varchar2(16) constraint FK_order_id_member references member (id),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date 
);

create table sale (
    sale_date date default sysdate not null primary key ,
    wine_code varchar2(6) not null,
    mem_id varchar(30) not null,
    sale_amount varchar(5) default 0 not null ,
    sale_price varchar(6) default 0 not null,
    sale_tot_price varchar(15) default 0 not null 
);
alter table sale
add foreign key (wine_code) references member01(mem_id)
alter table sale
add foreign key (mem_id) references wine(wine_code);

create table member01 (
    mem_id varchar2(6) not null primary key ,
    mem_grade varchar2(20) ,
    mem_pw varchar2(20) not null,
    mem_birth date default sysdate not null,
    mem_tel varchar2(20) ,
    mem_pt varchar2(10) default 0 not null
);

alter table member01 
add foreign key (mem_grade) references grade_pt_rade(mem_grade);

create table grade_pt_rade (
    mem_grade varchar2(20) not null primary key,
    grade_pt_rate number(3,2)
);

create table today (
    today_code varchar2(6) not null primary key,
    today_sens_value number(3),
    today_intell_value number(3),
    today_phy_value number(3)
);

create table nation (
    nation_code varchar2(26) not null primary key,
    notion_name varchar2(50) not null
);

create table wine (
    wine_code varchar2(26) not null primary key ,
    wine_name varchar2(100) not null,
    wine_url blob ,
    nation_code varchar2(6) references nation(nation_code) ,
    wine_type_code varchar2(6),
    wine_sugar_code number(2),
    wine_price number(15) default 0 not null ,
    wine_vintage date,
    theme_code varchar2(6),
    today_code varchar2(6) references today(today_code)
);
alter table wine
add foreign key (wine_type_code) references wine_type(wine_type_code);

alter table wine
add foreign key (theme_code) references theme(theme_code)

create table theme (
    theme_code varchar2(5) not null primary key,
    theme_name varchar2(50) not null
);

create table stock_mamagement (
    stock_code varchar2(6) primary key,
    wine_code varchar2(6) references wine(wine_code),
    manager_id varchar2(30) ,
    ware_date date default sysdate not null,
    stock_amount number(5) default 0 not null 
);
alter table stock_mamagement 
add foreign key (manager_id) references manager(manager_id);

create table manager (
    manager_id varchar2(30) not null primary key,
    manager_pwd varchar2(20) not null,
    manager_tel varchar2(20)
);

create table wine_type (
    wine_type_code varchar2(6) not null primary key,
    wine_type_name varchar2(50)
);