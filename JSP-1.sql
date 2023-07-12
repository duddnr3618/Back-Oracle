create table board (
seq number(5) not null primary key,
title varchar2 (200) not null,
write varchar2(200) null,
content varchar2(2000) null,
regdate date default sysdate null,
cnt number(5) default 0 null
);

drop table board;

insert into board 
values (1 , 'MVC M2 게시판 제목' , 'admin' , 'MVC M2 게시판 내용' , default , 0 );

insert into board 
values (2 , 'MVC M2 게시판 제목2' , 'admin' , 'MVC M2 게시판 내용2' , default , 0 );

select * from board;

select nvl(max(seq),0)+1 from board


create table users (
id varchar2(8) not null primary key,
password varchar2(8) null,
name varchar2 (20) null,
role varchar2 (5)
);

-- 더미 데이터 입력
insert into users
values ('admin' , '1234' , '관리자' , 'Admin' );

insert into users 
values ('user' ,'1234' , '일반사용자' , 'Users');

select * from users

commit;

select * from board order by seq desc

select * from board;
select * from users;

select * from board
where seq = 4;

update board
set cnt = (select cnt+1 from board where seq = 4)
where seq = 4;

select * from board;

update board set title = '제목변경' , content = '내용변경' where seq = 3;
commit;