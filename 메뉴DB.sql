create database finalproject;

use finalproject;

drop table carts;

-- 테이블 생성
CREATE TABLE `Menu` (
    `menu_id` INT NOT NULL AUTO_INCREMENT,
    `menu_category` VARCHAR(30) NOT NULL,
    `menu_name` VARCHAR(50) NOT NULL,
    `menu_content` VARCHAR(255),
    `menu_price` INT NOT NULL,
    `menu_img` VARCHAR(255),
    `menu_popularity` INT NOT NULL DEFAULT 0 COMMENT '일반, 인기',
    `menu_cdate` DATE NOT NULL DEFAULT (CURRENT_DATE),
    `menu_status` INT NOT NULL DEFAULT 1 COMMENT '활성화, 비활성화',
    `menu_hidden` INT NOT NULL DEFAULT 0 COMMENT '숨김, 표시',
    `menu_soldout` INT NOT NULL DEFAULT 0 COMMENT '품절, 판매중',
    `shop_id` INT NOT NULL,
    PRIMARY KEY (`menu_id`)
);

CREATE TABLE `Orders` (
    `orders_id` INT NOT NULL AUTO_INCREMENT,
    `orders_payment` VARCHAR(30) NOT NULL DEFAULT 'Easy Payment' COMMENT '간편결제(카카오페이, 토스페이)',
    `orders_price` INT NOT NULL,
    `orders_srequest` VARCHAR(255) NULL,
    `orders_drequest` VARCHAR(255) NULL,
    `orders_cdate` DATE NOT NULL DEFAULT (CURRENT_DATE),
    `orders_status` VARCHAR(20) NOT NULL DEFAULT 'Processing Order' COMMENT '주문확인중, 주문접수, 조리시작, 조리완료, 배송픽업, 배송완료',
    `shop_id` INT NOT NULL,
    `addr_id` INT NOT NULL,
    PRIMARY KEY (`orders_id`)
);

CREATE TABLE `Carts` (
    `carts_menu_id` INT NOT NULL AUTO_INCREMENT,
    `carts_menu_quantity` INT NOT NULL DEFAULT 1,
    `member_id` INT NOT NULL,
    `shop_id` INT NOT NULL,
    `orders_id` INT NOT NULL,
    `menu_id` INT NOT NULL,
    `carts_cdate` DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (`carts_menu_id`)
);

-- 더미데이터
INSERT INTO `Menu` (
    `menu_category`, `menu_name`, `menu_content`, `menu_price`, `menu_img`, `menu_popularity`, `menu_cdate`, `menu_status`, `menu_hidden`, `menu_soldout`, `shop_id`
) VALUES 
(
    '음료', 
    '아메리카노', 
    '진한 커피 맛의 기본 아메리카노', 
    4000, 
    'americano.jpg', 
    5, 
    CURRENT_DATE, 
    1, 
    0,  -- 표시 상태 (0: 표시)
    0,  -- 품절 상태 (0: 판매중)
    1
);

INSERT INTO `Menu` (
    `menu_category`, `menu_name`, `menu_content`, `menu_price`, `menu_img`, `menu_popularity`, `menu_cdate`, `menu_status`, `menu_hidden`, `menu_soldout`, `shop_id`
) VALUES 
(
    '디저트', 
    '치즈케이크', 
    '부드럽고 고소한 치즈케이크', 
    6000, 
    'cheesecake.jpg', 
    3, 
    CURRENT_DATE, 
    1, 
    1,  -- 숨김 상태 (1: 숨김)
    1,  -- 품절 상태 (1: 품절)
    1
);

-- 장바구니 더미데이터 
INSERT INTO `Carts` (carts_menu_quantity, member_id, shop_id, orders_id, menu_id, carts_cdate)
VALUES (2, 101, 202, 303, 404, '2024-08-30');

-- 더미 데이터 2
INSERT INTO `Carts` ( carts_menu_quantity, member_id, shop_id, orders_id, menu_id, carts_cdate)
VALUES ( 3, 102, 203, 304, 405, '2024-08-30');

-- 조회
SELECT * FROM MENU;




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
)	 ;	

-- 회원등급(check)
alter table member
	add constraint ch_member_grade check(mem_grade in('일반','관리자'));  
    
    insert into member values(null, '김관리', 'admin', 'admin', '00000', '서울시 관악구', '127.0.0.1', now(), '관리자');
insert into member values(null, '일길동', 'one','1234', '12345', '서울시 관악구', '127.0.0.1', default, default);

