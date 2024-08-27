/*

-- 회원테이블
create table member
(
	mem_idx		int primary key auto_increment, -- 회원번호 
	mem_name 	varchar(100) not null, -- 회원명
	mem_id		varchar(100) not null, -- 회원 ID
	mem_pwd		varchar(100) not null, -- 회원 비번 
	mem_zipcode char(5) 	  not null, -- 우편번호 5글자 고정 
	mem_addr    varchar(1000) not null,-- 주소 
	mem_ip      varchar(100) not null, -- 아이피 
	mem_regdate datetime default now(),	-- 가입일자
	mem_grade   varchar(100) default '일반' -- 회원 등급   
)	 	

-- 회원등급(check)
alter table member
	add constraint ch_member_grade check(mem_grade in('일반','관리자'));  

-- sample data
insert into member values(null, '김관리', 'admin', 'admin', '00000', '서울시 관악구', '127.0.0.1', now(), '관리자');
insert into member values(null, '일길동', 'one','1234', '12345', '서울시 관악구', '127.0.0.1', default, default);


*/
