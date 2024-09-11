create database finalproject;

use finalproject;

-- -------------------------------- 테이블 생성
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
	`orders_id`	INT	NOT NULL primary key auto_increment,
	`orders_payment`	VARCHAR(30)	NOT NULL	COMMENT '간편결제(카카오페이,토스페이)',
	`orders_method`	VARCHAR(30)	NOT NULL	DEFAULT "card",
	`orders_imp_uid`	VARCHAR(30)	NOT NULL,
	`orders_merchant_uid`	VARCHAR(20)	NOT NULL,
	`orders_name`	VARCHAR(50)	NOT NULL,
	`orders_price`	INT	NOT NULL,
	`orders_srequest`	VARCHAR(255)	NULL,
	`orders_drequest`	VARCHAR(255)	NULL,
	`orders_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`orders_status` VARCHAR(20) NOT NULL DEFAULT 'Order Confirmed' COMMENT 'Order Confirmed, 
		Order Received, 
		Cooking Started, 
		Cooking Finished, 
		Delivery Picked Up, 
		Delivery Delivered',
	`shop_id`	INT	NOT NULL,
	`addr_id`	INT	NOT NULL,
	`member_id`	INT	NOT NULL
);

CREATE TABLE `Carts` (
    `carts_id` INT NOT NULL AUTO_INCREMENT,
    `carts_quantity` INT NOT NULL DEFAULT 1,
    `member_id` INT NOT NULL,
    `shop_id` INT NOT NULL,
    `orders_id` INT NULL,
    `menu_id` INT NOT NULL,
    `carts_cdate` DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (`carts_id`)
);

CREATE TABLE `shop` (
    `shop_id` int not null primary key auto_increment,
    `shop_name` varchar(90) NOT NULL,
    `shop_img` varchar(255) NULL,
    `shop_addr` varchar(255) NOT NULL,
    `food_category` varchar(30) NOT NULL,
    `shop_call` varchar(20) NOT NULL,
    `shop_content` varchar(255) NULL,
    `shop_min_price` int NULL DEFAULT 0,
    `shop_rate` decimal(2, 1) NOT NULL DEFAULT 0,
    `shop_stemp_count` int NOT NULL DEFAULT 0,
    `shop_review_count` int NOT NULL DEFAULT 0,
    `shop_open_time` varchar(30) NOT NULL,
    `shop_close_time` varchar(30) NOT NULL,
    `shop_close_day` varchar(30) NOT NULL,
    `shop_area` varchar(255) NOT NULL,
    `shop_cdate` date NOT NULL default(current_date),
    `shop_mdate` date NULL default(current_date),
    `shop_status` varchar(30) NOT NULL default '오픈전'
);

-- -------------------------------- 조회
SELECT * FROM MENU;
SELECT * FROM Carts;
SELECT * FROM shop;
-- -------------------------------- 
Drop table MENU;
Drop table Carts;
Drop table shop;


delete from menu;
delete from carts;
delete from shop;


-- 외래키 설정

-- Menu 테이블에 외래 키 추가
ALTER TABLE `Menu`
ADD CONSTRAINT `fk_menu_shop`
    FOREIGN KEY (`shop_id`) REFERENCES `shop`(`shop_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- Carts 테이블에 외래 키 추가
ALTER TABLE `Carts`
ADD CONSTRAINT `fk_carts_shop`
    FOREIGN KEY (`shop_id`) REFERENCES `shop`(`shop_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Carts`
ADD CONSTRAINT `fk_carts_menu`
    FOREIGN KEY (`menu_id`) REFERENCES `Menu`(`menu_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Carts`
ADD CONSTRAINT `fk_carts_orders`
    FOREIGN KEY (`orders_id`) REFERENCES `Orders`(`orders_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- Carts에는 회원 id도 외래키 추가하기 
ALTER TABLE `Carts`
ADD CONSTRAINT `fk_carts_member`
    FOREIGN KEY (`member_id`) REFERENCES `Member`(`member_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- Orders 테이블에 외래 키 추가 ( 추가로 더 있을 듯 )
ALTER TABLE `Orders`
ADD CONSTRAINT `fk_orders_shop`
    FOREIGN KEY (`shop_id`) REFERENCES `shop`(`shop_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- -------------------------------- 더미데이터 --------------------------

INSERT INTO `shop` (
    `shop_name`, 
    `shop_img`, 
    `shop_addr`, 
    `food_category`, 
    `shop_call`, 
    `shop_content`, 
    `shop_min_price`, 
    `shop_rate`, 
    `shop_stemp_count`, 
    `shop_review_count`, 
    `shop_open_time`, 
    `shop_close_time`, 
    `shop_close_day`, 
    `shop_area`, 
    `shop_cdate`, 
    `shop_mdate`, 
    `shop_status`
) VALUES
(
    '맛집1', 
    'image1.jpg', 
    '서울시 강남구 역삼동', 
    '한식', 
    '010-1234-5678', 
    '정통 한식 맛집', 
    5000, 
    4.5, 
    10, 
    25, 
    '10:00', 
    '22:00', 
    '월요일', 
    '강남', 
    CURRENT_DATE, 
    CURRENT_DATE, 
    '오픈전'
),
(
    '푸드코트2', 
    'image2.jpg', 
    '서울시 마포구 합정동', 
    '양식', 
    '010-9876-5432', 
    '다양한 양식 메뉴를 제공합니다', 
    7000, 
    4.2, 
    15, 
    30, 
    '11:00', 
    '23:00', 
    '화요일', 
    '마포', 
    CURRENT_DATE, 
    CURRENT_DATE, 
    '오픈전'
);



INSERT INTO `Menu` (
    `menu_name`, 
    `menu_category`, 
    `menu_content`, 
    `menu_price`, 
    `menu_img`, 
    `menu_popularity`, 
    `menu_cdate`, 
    `menu_status`, 
    `menu_hidden`, 
    `menu_soldout`, 
    `shop_id`
) VALUES
(
    '김치찌개', 
    '메인', 
    '매운 김치찌개', 
    8000, 
    'kimchi_jjigae.jpg', 
    5, 
    CURRENT_DATE, 
    1, 
    0, 
    0, 
    1
),
(
    '스파게티', 
    '메인', 
    '크림 소스 스파게티', 
    12000, 
    'spaghetti.jpg', 
    4, 
    CURRENT_DATE, 
    1, 
    0, 
    0, 
    2
);

INSERT INTO `Carts` (
    `carts_quantity`, 
    `member_id`, 
    `shop_id`, 
    `orders_id`, 
    `menu_id`, 
    `carts_cdate`
) VALUES
(
    2, 
    1, 
    1, 
    1001, 
    1, 
    CURRENT_DATE
),
(
    1, 
    2, 
    2, 
    1002, 
    2, 
    CURRENT_DATE
);


-- --------------------------------------------------------


SELECT 
	 c.*,                  -- Carts 테이블의 모든 컬럼을 선택
	 s.shop_name AS shop_name, -- shop 테이블에서 가게명
	 m.menu_name AS menu_name  -- Menu 테이블에서 메뉴명
  FROM 
	 Carts c
  JOIN 
	 Menu m ON c.menu_id = m.menu_id
  JOIN 
	 shop s ON m.shop_id = s.shop_id;

SELECT * FROM Carts WHERE shop_id = 1 OR shop_id = 2;
SELECT * FROM Menu WHERE shop_id = 1 OR shop_id = 2;
SELECT * FROM shop WHERE shop_id = 1 OR shop_id = 2;